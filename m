From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: battery: current a factor of 10 off?
Date: Fri, 21 Nov 2008 07:09:46 +0300
Message-ID: <8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_92743_20705533.1227240586298"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:41560 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYKUEJs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2008 23:09:48 -0500
Received: by fk-out-0910.google.com with SMTP id 18so815432fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2008 20:09:46 -0800 (PST)
In-Reply-To: <87skplx6ho.fsf@szonett.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

------=_Part_92743_20705533.1227240586298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ferenc,

Good catch.
ACPI battery interface report its state either in mW or in mA, and
discharge rate
in your case is reported in mW. power_supply interface does not have
such a parameter,
so current_now parameter is used for all cases. But in case of mW,
reported discharge should
be converted into mA.

Please test the attached patch.

Thanks,
Alex.

On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
> Hi,
>
> on my ThinkPad R50e the current_now reading seems something like 10
> times the actual value.  Documentation/power/power_supply_class.txt
> says it's in uA, and a tipical discharge value is around 15259000,
> that is, 15 A on my system.  At the same time voltage is 11756000,
> that is, 12 V, which sounds reasonable, but then the power is 15*12 VA,
> ie 180 W, which is insane.  However, the numerical derivative of
> energy_now gives 18 W, which is both reasonable and consistent with
> the assumed factor of 10 error in current_now.  Is this possibly a bug
> in 2.6.26.6?  During a quick glance over battery.c nothing obvious
> jumped at me, but I'm no expert on this.
> --
> Thanks,
> Feri.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_Part_92743_20705533.1227240586298
Content-Type: text/x-patch; name=convert_discharge_energy_to_current.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnsbcc5s0
Content-Disposition: attachment;
 filename=convert_discharge_energy_to_current.patch

QUNQSTpiYXR0ZXJ5OiBDb252ZXJ0IGRpc2NoYXJnZSBlbmVyZ3kgcmF0ZSB0byBjdXJyZW50IHBy
b3Blcmx5CgpGcm9tOiBBbGV4ZXkgU3Rhcmlrb3Zza2l5IDxhc3Rhcmlrb3Zza2l5QHN1c2UuZGU+
CgpBQ1BJIGJhdHRlcnkgaW50ZXJmYWNlIHJlcG9ydHMgaXRzIHN0YXRlIGVpdGhlciBpbiBtVyBv
ciBpbiBtQSwgYW5kIApkaXNjaGFyZ2UgcmF0ZSBpbiB5b3VyIGNhc2UgaXMgcmVwb3J0ZWQgaW4g
bVcuIHBvd2VyX3N1cHBseSBpbnRlcmZhY2UgCmRvZXMgbm90IGhhdmUgc3VjaCBhIHBhcmFtZXRl
ciwgc28gY3VycmVudF9ub3cgcGFyYW1ldGVyIGlzIHVzZWQgCmZvciBhbGwgY2FzZXMuIEJ1dCBp
biBjYXNlIG9mIG1XLCByZXBvcnRlZCBkaXNjaGFyZ2Ugc2hvdWxkCmJlIGNvbnZlcnRlZCBpbnRv
IG1BLgoKU2lnbmVkLW9mZi1ieTogQWxleGV5IFN0YXJpa292c2tpeSA8YXN0YXJpa292c2tpeUBz
dXNlLmRlPgotLS0KCiBkcml2ZXJzL2FjcGkvYmF0dGVyeS5jIHwgICAgOSArKysrKysrKysKIDEg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jIGIvZHJpdmVycy9hY3BpL2JhdHRlcnkuYwppbmRl
eCAxNDIzYjBjLi40NGY5NTg2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jCisr
KyBiL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMKQEAgLTE3NCw2ICsxNzQsMTUgQEAgc3RhdGljIGlu
dCBhY3BpX2JhdHRlcnlfZ2V0X3Byb3BlcnR5KHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwKIAkJ
YnJlYWs7CiAJY2FzZSBQT1dFUl9TVVBQTFlfUFJPUF9DVVJSRU5UX05PVzoKIAkJdmFsLT5pbnR2
YWwgPSBiYXR0ZXJ5LT5jdXJyZW50X25vdyAqIDEwMDA7CisJCS8qIGlmIHBvd2VyIHVuaXRzIGFy
ZSBtVywgY29udmVydCB0byBtQSBieSAKKwkJICAgZGl2aWRpbmcgYnkgY3VycmVudCB2b2x0YWdl
IChtVi8xMDAwKSAqLworCQlpZiAoIWJhdHRlcnktPnBvd2VyX3VuaXQpIHsgCisJCQlpZiAoYmF0
dGVyeS0+dm9sdGFnZV9ub3cpIHsKKwkJCQl2YWwtPmludHZhbCAqPSAxMDAwOworCQkJCXZhbC0+
aW50dmFsIC89IGJhdHRlcnktPnZvbHRhZ2Vfbm93OworCQkJfSBlbHNlIAorCQkJCXZhbC0+aW50
dmFsID0gLTE7CisJCX0KIAkJYnJlYWs7CiAJY2FzZSBQT1dFUl9TVVBQTFlfUFJPUF9DSEFSR0Vf
RlVMTF9ERVNJR046CiAJY2FzZSBQT1dFUl9TVVBQTFlfUFJPUF9FTkVSR1lfRlVMTF9ERVNJR046
Cg==
------=_Part_92743_20705533.1227240586298--
