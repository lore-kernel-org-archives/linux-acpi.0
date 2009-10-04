From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sun, 04 Oct 2009 22:57:47 +0400
Message-ID: <4AC8F02B.6080209@suse.de>
References: <1254669853.26496.0.camel@carter>	 <20091004164553.GD10505@khazad-dum.debian.net> <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757768AbZJDS63@vger.kernel.org>
In-Reply-To: <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Miguel,

I am going to reject your patch on the basis, that the battery driver s=
hould report only
information it gained from battery hardware, not interpret it in any wa=
y.
As your patch fall into "interpret" category, it does not belong in the=
 kernel and battery
driver in particular. You may suggest it to any/all user space battery =
monitoring applications,
this is the place for "interpretations".

Not-acknowledged-by: Alexey Starikovskiy


Regards,
Alex.


Miguel Ojeda =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sun, Oct 4, 2009 at 6:45 PM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
>> On Sun, 04 Oct 2009, Miguel Ojeda wrote:
>>> Some broken batteries like my DELL NR2227 or a friend's DELL GK4798=
 return
>>> the design_capacity (charge_full_design) as capacity_now (charge_no=
w)
>>> when completely charged.
>>>
>>> I noticed this when looking at a battery plugin that reported "127%=
 charged".
>>> Some of these plugins have already "fixed" this in userspace by cod=
ing
>>> something like min(percentage, 100)).
>> A battery can be charged above 100%.  It just depends what you call =
100%,
>> and the "I am full" level *varies* in a non-monotonic way during the=
 battery
>> lifetime...
>>
>> So, if you don't want to see > 100%, you have to clamp it to 100% an=
d lose
>> information (when your "100%" level is actually increasing as the th=
ing
>> keeps charging and you keep raising the baseline so that it doesn't =
go over
>> 100%).
>=20
> If the 100% level increased, then full_charge_capacity (a.k.a. "_last=
_
> full capacity" as seen in /proc) will increase as well, won't it? If
> the battery went over that 100% that means there is a "new" 100%, why
> are we losing information?.
>=20
> I am asking, I am not an expert on battery stuff.
>=20
>>> So I discovered that the battery wrongly returns charge_full_design=
 when
>>> completely charged instead of charge_full.
>> Ick.
>>
>>> This patch fixes this by returning min(capacity_now, full_charge_ca=
pacity)
>>> on both procfs and sysfs.
>> What will it cause on non-broken batteries?  Or during gauge reset, =
when any
>> battery that updates full_charge_capacity only at the end of the cyc=
le will
>> really have capacity_now > full_charge_capacity ?
>=20
> Well, does it make sense to have capacity_now higher than
> full_charge_capacity? Wouldn't that information be broken too?
>=20
> Again, I am just wondering.
>=20
>>> Now the userspace plugins report the correct 100% and their userspa=
ce check
>>> may not be needed (if this error is the only one producing >100% re=
sults).
>> Like I said, > 100% can happen, unless what you define to be 100% is=
 very
>> elastic (and gets updated all the time).
>=20
> I still think it does not make sense to have a battery charged over
> its 100% capacity whatever the definition of 100% is. Maybe I do not
> understand your point.
>=20
>> --
>>  "One disk to rule them all, One disk to find them. One disk to brin=
g
>>  them all and in the darkness grind them. In the Land of Redmond
>>  where the shadows lie." -- The Silicon Valley Tarot
>>  Henrique Holschuh
>>
