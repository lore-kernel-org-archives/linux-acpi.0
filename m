From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 05 Oct 2009 04:18:13 +0400
Message-ID: <4AC93B45.8090707@suse.de>
References: <1254669853.26496.0.camel@carter>	 <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>	 <4AC8F02B.6080209@suse.de> <200910042246.23712.rjw@sisk.pl>	 <4AC91578.2020807@suse.de>	 <ca2dc2820910041455h18ece909rc2280a40f1899c0a@mail.gmail.com>	 <4AC923F4.9050100@suse.de> <ca2dc2820910041653o29d4b253n69270d231e56e447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52842 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752340AbZJEASx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 20:18:53 -0400
In-Reply-To: <ca2dc2820910041653o29d4b253n69270d231e56e447@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Miguel Ojeda =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, Oct 5, 2009 at 12:38 AM, Alexey Starikovskiy
> <astarikovskiy@suse.de> wrote:
>> Miguel Ojeda =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Sun, Oct 4, 2009 at 11:36 PM, Alexey Starikovskiy
>>> <astarikovskiy@suse.de> wrote:
>>>> Hi Rafael,
>>>>
>>>> This is not my rule, it was/is the rule of power device class. If =
you do
>>>> not
>>>> agree to it, please change
>>>> appropriate documentation.
>>> Oh, I did not know that. Thank you for pointing it out. I think you
>>> are refering to:
>>>
>>>  158Q: Suppose, my battery monitoring chip/firmware does not provid=
es
>>> capacity
>>>  159   in percents, but provides charge_{now,full,empty}. Should I
>>> calculate
>>>  160   percentage capacity manually, inside the driver, and registe=
r
>>> CAPACITY
>>>  161   attribute? The same question about time_to_empty/time_to_ful=
l.
>>>  162A: Most likely, no. This class is designed to export properties=
 which
>>> are
>>>  163   directly measurable by the specific hardware available.
>>>  164
>>>  165   Inferring not available properties using some heuristics or
>>> mathematical
>>>  166   model is not subject of work for a battery driver. Such
>>> functionality
>>>  167   should be factored out, and in fact, apm_power, the driver t=
o serve
>>>  168   legacy APM API on top of power supply class, uses a simple
>>> heuristic of
>>>  169   approximating remaining battery capacity based on its charge=
,
>>> current,
>>>  170   voltage and so on. But full-fledged battery model is likely =
not
>>> subject
>>>  171   for kernel at all, as it would require floating point calcul=
ation
>>> to deal
>>>  172   with things like differential equations and Kalman filters. =
This is
>>>  173   better be handled by batteryd/libbattery, yet to be written.
>>>
>>> We are not calculating anything new just by the pleasure of doing i=
t,
>>> we are correcting a wrong value provided by the hardware.
>> You are guessing that normal battery can not jump charge value, and =
on this
>> assumption you
>> cap charge_now with last full_charge. Immediate problem is that full=
_charge
>> is not fixed value,
>> this is why it is separated from design_full_charge.
>> During battery life full_charge may go down and up, depending on out=
side
>> temperature, battery discharge (full or partial).
>> I've seen batteries on some new machines reporting full charge of mo=
re than
>> design charge.
>> Obviously, your patch will fail in some of the above situations.
>=20
> I don't see why. The patch compares against full_charge every time
> (which is updated as you say), not against design_full_charge.
>=20
> 1. full_charge > design_full_charge =3D> OK, design_full_charge is no=
t
> involved in the min() operation.
> 2. full_charge goes down =3D> If charge_now > full_charge then hardwa=
re
> is wrong and we should read full_charge. OK.
> 3. full_charge goes up =3D> Same.
full_charge_capacity is the value of last full charge. It will be updat=
ed to
current full charge, when the charging is complete. It may end up lower=
 or greater than
previous value.
Comparing current charge with the last full charge may correctly give y=
ou >100%.
Now we have a decision to make -- do we update full charge to be greate=
r than charge now,
or do we update charge now to be lower than full charge.=20
> So, maybe the battery works as you suggested; still, the kernel shoul=
d
> provide a common meaning to its interfaces. If some batteries report
> full_charge when in "charged" state and others report
> design_full_charge, then the kernel should convert all of them into
> one unique convention, or there is no sane way to write userspace
> applications.

I still want to receive raw data from driver, and have 1 level of inter=
preters.
As I understand, there is HAL, which may do interpretations for you and=
 keep it in single location.
>> Regards,
>> Alex.
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
