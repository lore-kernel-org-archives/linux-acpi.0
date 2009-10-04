From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 5 Oct 2009 01:53:16 +0200
Message-ID: <ca2dc2820910041653o29d4b253n69270d231e56e447@mail.gmail.com>
References: <1254669853.26496.0.camel@carter>
	 <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
	 <4AC8F02B.6080209@suse.de> <200910042246.23712.rjw@sisk.pl>
	 <4AC91578.2020807@suse.de>
	 <ca2dc2820910041455h18ece909rc2280a40f1899c0a@mail.gmail.com>
	 <4AC923F4.9050100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:58017 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZJDXxy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 19:53:54 -0400
In-Reply-To: <4AC923F4.9050100@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 5, 2009 at 12:38 AM, Alexey Starikovskiy
<astarikovskiy@suse.de> wrote:
> Miguel Ojeda =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On Sun, Oct 4, 2009 at 11:36 PM, Alexey Starikovskiy
>> <astarikovskiy@suse.de> wrote:
>>>
>>> Hi Rafael,
>>>
>>> This is not my rule, it was/is the rule of power device class. If y=
ou do
>>> not
>>> agree to it, please change
>>> appropriate documentation.
>>
>> Oh, I did not know that. Thank you for pointing it out. I think you
>> are refering to:
>>
>> =C2=A0158Q: Suppose, my battery monitoring chip/firmware does not pr=
ovides
>> capacity
>> =C2=A0159 =C2=A0 in percents, but provides charge_{now,full,empty}. =
Should I
>> calculate
>> =C2=A0160 =C2=A0 percentage capacity manually, inside the driver, an=
d register
>> CAPACITY
>> =C2=A0161 =C2=A0 attribute? The same question about time_to_empty/ti=
me_to_full.
>> =C2=A0162A: Most likely, no. This class is designed to export proper=
ties which
>> are
>> =C2=A0163 =C2=A0 directly measurable by the specific hardware availa=
ble.
>> =C2=A0164
>> =C2=A0165 =C2=A0 Inferring not available properties using some heuri=
stics or
>> mathematical
>> =C2=A0166 =C2=A0 model is not subject of work for a battery driver. =
Such
>> functionality
>> =C2=A0167 =C2=A0 should be factored out, and in fact, apm_power, the=
 driver to serve
>> =C2=A0168 =C2=A0 legacy APM API on top of power supply class, uses a=
 simple
>> heuristic of
>> =C2=A0169 =C2=A0 approximating remaining battery capacity based on i=
ts charge,
>> current,
>> =C2=A0170 =C2=A0 voltage and so on. But full-fledged battery model i=
s likely not
>> subject
>> =C2=A0171 =C2=A0 for kernel at all, as it would require floating poi=
nt calculation
>> to deal
>> =C2=A0172 =C2=A0 with things like differential equations and Kalman =
filters. This is
>> =C2=A0173 =C2=A0 better be handled by batteryd/libbattery, yet to be=
 written.
>>
>> We are not calculating anything new just by the pleasure of doing it=
,
>> we are correcting a wrong value provided by the hardware.
>
> You are guessing that normal battery can not jump charge value, and o=
n this
> assumption you
> cap charge_now with last full_charge. Immediate problem is that full_=
charge
> is not fixed value,
> this is why it is separated from design_full_charge.
> During battery life full_charge may go down and up, depending on outs=
ide
> temperature, battery discharge (full or partial).
> I've seen batteries on some new machines reporting full charge of mor=
e than
> design charge.
> Obviously, your patch will fail in some of the above situations.

I don't see why. The patch compares against full_charge every time
(which is updated as you say), not against design_full_charge.

1. full_charge > design_full_charge =3D> OK, design_full_charge is not
involved in the min() operation.
2. full_charge goes down =3D> If charge_now > full_charge then hardware
is wrong and we should read full_charge. OK.
3. full_charge goes up =3D> Same.

 What do you mean by failing in such situations? My point is that,
AFAIK charge_now shouldn't be higher than full_charge *. The patch
does not care about design_full_charge, neither the original code.

* I do not know about some overcharging issues that Henrique mentioned.

> Currently, reading from the driver is "last resort" to get un-interpr=
eted
> value, if you have any doubts on it. With
> your patch, this is gone, and user space will have to interpret resul=
ts of
> kernel interpreter.
>
> Return to the "bug still exists". We are referring to the value, whic=
h can
> not be measured directly with any known device.
> Thus, it may be completely sane that battery manufacturer provides yo=
u with
> some charge curve, but knows only two values on it
> which he may trust -- point where he can not get any power out of it
> (complete discharge) and point where he can not put any additional ch=
arge
> into the battery (due to various stop conditions (battery temperature=
 being
> one)). In such a case manufacturer may choose to adjust charge curve =
to end
> up always at design_full_charge point, no matter how much of adjustme=
nt this
> requires.

I understand that and you may be right; however, AFAIK, a userspace
application has no way to know that it should compare against
full_charge every time _except_ when in "charged" state, has it? Is
there any kind of protocol/documentation that establish what an
userspace application should do?

The battery reports correctly full_charge in order to compare with
charge_now (and as I checked, some userspace plugins always check
against that full_charge, not design_full_charge, which seems to be
the logical thing to do, who cares what the design full charge level
was when reporting the actual charge level?).

>
> Do you have the same jump from >100% to 99% on discharge?

Yes: When in "charged" state, the battery reports a fixed value
(desing_full_charge, it is always the same). In "charging" or
"discharging" it correctly reports the current charge. It also
correctly reports full_charge, not matter what state.

So, maybe the battery works as you suggested; still, the kernel should
provide a common meaning to its interfaces. If some batteries report
full_charge when in "charged" state and others report
design_full_charge, then the kernel should convert all of them into
one unique convention, or there is no sane way to write userspace
applications.

>
> Regards,
> Alex.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
