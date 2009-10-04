From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sun, 4 Oct 2009 23:42:51 +0200
Message-ID: <ca2dc2820910041442yf739d96u617f5300e137b0a2@mail.gmail.com>
References: <1254669853.26496.0.camel@carter>
	 <20091004164553.GD10505@khazad-dum.debian.net>
	 <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
	 <4AC8F02B.6080209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758162AbZJDVnb@vger.kernel.org>
In-Reply-To: <4AC8F02B.6080209@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 4, 2009 at 8:57 PM, Alexey Starikovskiy
<astarikovskiy@suse.de> wrote:
> Hi Miguel,
>
> I am going to reject your patch on the basis, that the battery driver=
 should
> report only
> information it gained from battery hardware, not interpret it in any =
way.
> As your patch fall into "interpret" category, it does not belong in t=
he
> kernel and battery
> driver in particular. You may suggest it to any/all user space batter=
y
> monitoring applications,
> this is the place for "interpretations".

I understand your point. However, there are other parts in the same
file that need to do "interpretation", for example:

http://lxr.linux.no/linux+*/drivers/acpi/battery.c#L157

 157        /* fallback to using design values for broken batteries */
 158        if (battery->design_capacity =3D=3D battery->capacity_now)
 159                return 1;

I agree with Rafael, the kernel must interpret the hardware as best as
possible (it is its job, isn't it?). In countless places the kernel
has to "fix" (workaround) hardware bugs in order to present userspace
a unified interface, correct values, etc.

In this case my battery is reporting a obvious wrong value that causes
(apparently) correct userspace applications to misbehave.

Maybe the patch I proposed is not the correct solution; however, the
bug remains.

>
> Not-acknowledged-by: Alexey Starikovskiy
>
>
> Regards,
> Alex.
>
>
> Miguel Ojeda =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On Sun, Oct 4, 2009 at 6:45 PM, Henrique de Moraes Holschuh
>> <hmh@hmh.eng.br> wrote:
>>>
>>> On Sun, 04 Oct 2009, Miguel Ojeda wrote:
>>>>
>>>> Some broken batteries like my DELL NR2227 or a friend's DELL GK479=
8
>>>> return
>>>> the design_capacity (charge_full_design) as capacity_now (charge_n=
ow)
>>>> when completely charged.
>>>>
>>>> I noticed this when looking at a battery plugin that reported "127=
%
>>>> charged".
>>>> Some of these plugins have already "fixed" this in userspace by co=
ding
>>>> something like min(percentage, 100)).
>>>
>>> A battery can be charged above 100%. =C2=A0It just depends what you=
 call 100%,
>>> and the "I am full" level *varies* in a non-monotonic way during th=
e
>>> battery
>>> lifetime...
>>>
>>> So, if you don't want to see > 100%, you have to clamp it to 100% a=
nd
>>> lose
>>> information (when your "100%" level is actually increasing as the t=
hing
>>> keeps charging and you keep raising the baseline so that it doesn't=
 go
>>> over
>>> 100%).
>>
>> If the 100% level increased, then full_charge_capacity (a.k.a. "_las=
t_
>> full capacity" as seen in /proc) will increase as well, won't it? If
>> the battery went over that 100% that means there is a "new" 100%, wh=
y
>> are we losing information?.
>>
>> I am asking, I am not an expert on battery stuff.
>>
>>>> So I discovered that the battery wrongly returns charge_full_desig=
n when
>>>> completely charged instead of charge_full.
>>>
>>> Ick.
>>>
>>>> This patch fixes this by returning min(capacity_now,
>>>> full_charge_capacity)
>>>> on both procfs and sysfs.
>>>
>>> What will it cause on non-broken batteries? =C2=A0Or during gauge r=
eset, when
>>> any
>>> battery that updates full_charge_capacity only at the end of the cy=
cle
>>> will
>>> really have capacity_now > full_charge_capacity ?
>>
>> Well, does it make sense to have capacity_now higher than
>> full_charge_capacity? Wouldn't that information be broken too?
>>
>> Again, I am just wondering.
>>
>>>> Now the userspace plugins report the correct 100% and their usersp=
ace
>>>> check
>>>> may not be needed (if this error is the only one producing >100%
>>>> results).
>>>
>>> Like I said, > 100% can happen, unless what you define to be 100% i=
s very
>>> elastic (and gets updated all the time).
>>
>> I still think it does not make sense to have a battery charged over
>> its 100% capacity whatever the definition of 100% is. Maybe I do not
>> understand your point.
>>
>>> --
>>> =C2=A0"One disk to rule them all, One disk to find them. One disk t=
o bring
>>> =C2=A0them all and in the darkness grind them. In the Land of Redmo=
nd
>>> =C2=A0where the shadows lie." -- The Silicon Valley Tarot
>>> =C2=A0Henrique Holschuh
>>>
>
>
