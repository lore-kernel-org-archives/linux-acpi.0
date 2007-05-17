From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] Workaround for a PCI restoring bug
Date: Thu, 17 May 2007 02:14:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6031BCDF6@hdsmsx411.amr.corp.intel.com>
References: <200705161925.53410.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7984A.9048783D"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939AbXEQGOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 02:14:09 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <200705161925.53410.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org

------_=_NextPart_001_01C7984A.9048783D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>> the problem is that saving device state didn't=20
>> work, because the device was somehow turned off at suspend=20
>> time before we even saved it, so we saved crap.
>> Or more specifically, we saved=20
>> all-0xffffffff values from the config space, because the=20
>> devices were effectively not there any more! ]
>>=20
>> On Wed, 16 May 2007, Lukas Hejtmanek wrote:
>> >=20
>> > ...
>> > The problematic code is in drivers/acpi/hardware/hwsleep.c method
>> > acpi_enter_sleep_state_prep.
>> >=20
>> > In particular code:
>> > /* Run the _PTS and _GTS methods */
>> >=20

>>=20
>> Ok, so to fix this bug, we really should do=20
>> acpi_enter_sleep_state_prep()=20
>> _after_ we have done our own suspend/save of the device information,=20
>> rather than before. Because clearly acpi_enter_sleep_state_prep() can

>> corrupt the state wee *want* to save!

Right.

>> Of course, it has to be between the "suspend()" and the=20
>> "suspend_late()"=20
>> calls, since it wants to run with interrupts enabled and the=20
>> system in a=20
>> working state, and the final suspend_late() really does end=20
>> up shutting=20
>> things down and does *not* want to have things in a "working" state.
>>=20
>> But that's fine. It is, after all, how suspend/suspend_late=20
>> was designed=20
>> to work: the "suspend()" part should allocate memory and=20
>> save state, the=20
>> "suspend_late()" part should actually suspend the device. So=20
>> this does fit in the model.

>> - call "device_suspend()" before the "pm_ops->prepare()" function,
and=20
>>    then call the "suspend_late()" thing just before the actual
suspend.=20
>>=20
>>    This *should* work, and I think it's the right thing to do, but
the=20
>>    "change order of ACPI calls" is dangerous. Much more dangerous
than I'd=20
>>    like. There's no way I can do it before 2.6.22 - it would have to
go=20
>>    into 2.6.23-rc1 (and the ugly patch might be a candidate for
2.6.22,=20
>>    however much I hate it)

While I know it breaks your own rule for taking risks after rc1,
I don't see a huge down-side to pushing this patch now.
Suspend on Linux has numerous problems on numerous boxes, and this fix
appears to be obvious and important -- so the reward is potentially
large.
It is a small text change to code that is not otherwise changing --
so if it causes a regression before 2.6.22, simply revert it.
Consider that if Rafael had found this test-case box, I'm sure he would
have
shipped you this patch before the rc1 cutoff.

Acked-by: Len Brown <len.brown@intel.com>
If you want somebody to blame:-)

>>    However, the reason I think that's the correct thing to=20
>>    do is that on *resume*, we actually already call "pm_finish()"
>>    before we call  "device_resume()", so _logically_ we should do
>>    the suspend in the reverse order too!

Agreed.

>> Len? What do you think? Does the ACPI spec say anything? Do=20
>> you know what the other system (the one that BIOS vendors actually
test with) does?

>Well, I've raised exactly the same issue on linux-pm and=20
>linux-acpi recently,
>but I haven't had a test case to support my observations.
>
>In fact, we're violating the spec by executing the _PTS and=20
>_GTS control methods before suspending devices.

Agreed.  suspend_prepare() has this order wrong.
Linus' patch (attached) looks like it fixes it.

>The spec is clear in these points:
>_PTS should be executed *after* devices are placed in=20
>low-power states and
>_GTS should be executed immediately before the sleep state is=20
>*entered*.

Yep -- here's the quote from ACPI 3.0b:

OSPM will invoke _GTS, _PTS, _TTS, _WAK, and _BFS in the following
order:
1.OSPM decides (through a policy scheme) to place the system into a
sleeping state.
2._TTS(Sx) is run, where Sx is the desired sleep state to enter.
3. OSPM notifies all native device drivers of the sleep state transition
4._PTS is run
5.OSPM readies system for the sleep state transition
6._GTS is run
7.OSPM writes the sleep vector and the system enters the specified Sx
sleep state.
8.System Wakes up
9._BFS is run
10.OSPM readies system for the return from the sleep state transition
11._WAK is run
12. OSPM notifies all native device drivers of the return from the sleep
state transition
13._TTS(0) is run to indicate the return to the S0 state.

Technically we write the sleep vector too early as well.
And we don't evaluate _TTS at all -- though _TTS was
added only as of ACPI 3.0 and I've not seen it implemented on
any of the systems I've got.

>Thus I think the second patch is a better thing to do long=20
>term.  Moreover, I'd
>also move the execution of _GTS to after disable_nonboot_cpus()

I'd agree to that on the grounds of symmetry.
However, I expect it will be a NOP -- since the BIOS
can't tell the difference between an enabled and a non-enabled CPU.
(The possible exception is if any BIOS hooks -- such as magic traps
 into SMM -- assume that they're run in cpu0).

In the resume case, the order is important.  Per our discussion
on this last November, _WAK must follow _INIT of the non boot cpus
so that it can patch up stuff in firmware that got cleared on reset.
This continues to be true in Linux.

>(and, symmetrically, the execution of _BFS to before=20
>enable_nonboot_cpus(), which
>also would be more in line with the spec, but that's a separate issue).

True, _BFS is probably later than the spec wants.
But like _GTS, it was added with ACPI 2.0 and it is optional
for a BIOS to implement it.  Poking around, I don't see any systems
that actually implement _BFS or _GTS.  So that tweak probably isn't
a big deal like the problem at hand.

thanks,
-Len

------_=_NextPart_001_01C7984A.9048783D
Content-Type: application/octet-stream; name="diff-better"
Content-Transfer-Encoding: base64
Content-Description: diff-better
Content-Disposition: attachment; filename="diff-better"

IGtlcm5lbC9wb3dlci9tYWluLmMgfCAgIDE1ICsrKysrKysrLS0tLS0tLQ0KIDEgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEva2Vy
bmVsL3Bvd2VyL21haW4uYyBiL2tlcm5lbC9wb3dlci9tYWluLmMNCmluZGV4IDQwZDU2YTMuLmI5
OGI4MGMgMTAwNjQ0DQotLS0gYS9rZXJuZWwvcG93ZXIvbWFpbi5jDQorKysgYi9rZXJuZWwvcG93
ZXIvbWFpbi5jDQpAQCAtOTcsMjUgKzk3LDI2IEBAIHN0YXRpYyBpbnQgc3VzcGVuZF9wcmVwYXJl
KHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSkNCiAJCX0NCiAJfQ0KIA0KLQlpZiAocG1fb3BzLT5wcmVw
YXJlKSB7DQotCQlpZiAoKGVycm9yID0gcG1fb3BzLT5wcmVwYXJlKHN0YXRlKSkpDQotCQkJZ290
byBUaGF3Ow0KLQl9DQotDQogCXN1c3BlbmRfY29uc29sZSgpOw0KIAllcnJvciA9IGRldmljZV9z
dXNwZW5kKFBNU0dfU1VTUEVORCk7DQogCWlmIChlcnJvcikgew0KIAkJcHJpbnRrKEtFUk5fRVJS
ICJTb21lIGRldmljZXMgZmFpbGVkIHRvIHN1c3BlbmRcbiIpOw0KLQkJZ290byBSZXN1bWVfZGV2
aWNlczsNCisJCWdvdG8gUmVzdW1lX2NvbnNvbGU7DQogCX0NCisJaWYgKHBtX29wcy0+cHJlcGFy
ZSkgew0KKwkJaWYgKChlcnJvciA9IHBtX29wcy0+cHJlcGFyZShzdGF0ZSkpKQ0KKwkJCWdvdG8g
UmVzdW1lX2RldmljZXM7DQorCX0NCisNCiAJZXJyb3IgPSBkaXNhYmxlX25vbmJvb3RfY3B1cygp
Ow0KIAlpZiAoIWVycm9yKQ0KIAkJcmV0dXJuIDA7DQogDQogCWVuYWJsZV9ub25ib290X2NwdXMo
KTsNCi0gUmVzdW1lX2RldmljZXM6DQogCXBtX2ZpbmlzaChzdGF0ZSk7DQorIFJlc3VtZV9kZXZp
Y2VzOg0KIAlkZXZpY2VfcmVzdW1lKCk7DQorIFJlc3VtZV9jb25zb2xlOg0KIAlyZXN1bWVfY29u
c29sZSgpOw0KICBUaGF3Og0KIAl0aGF3X3Byb2Nlc3NlcygpOw0K

------_=_NextPart_001_01C7984A.9048783D--
