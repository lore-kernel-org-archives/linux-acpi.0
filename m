From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sun, 4 Oct 2009 19:46:42 +0200
Message-ID: <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
References: <1254669853.26496.0.camel@carter>
	 <20091004164553.GD10505@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757478AbZJDRrV@vger.kernel.org>
In-Reply-To: <20091004164553.GD10505@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 4, 2009 at 6:45 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Sun, 04 Oct 2009, Miguel Ojeda wrote:
>> Some broken batteries like my DELL NR2227 or a friend's DELL GK4798 =
return
>> the design_capacity (charge_full_design) as capacity_now (charge_now=
)
>> when completely charged.
>>
>> I noticed this when looking at a battery plugin that reported "127% =
charged".
>> Some of these plugins have already "fixed" this in userspace by codi=
ng
>> something like min(percentage, 100)).
>
> A battery can be charged above 100%. =A0It just depends what you call=
 100%,
> and the "I am full" level *varies* in a non-monotonic way during the =
battery
> lifetime...
>
> So, if you don't want to see > 100%, you have to clamp it to 100% and=
 lose
> information (when your "100%" level is actually increasing as the thi=
ng
> keeps charging and you keep raising the baseline so that it doesn't g=
o over
> 100%).

If the 100% level increased, then full_charge_capacity (a.k.a. "_last_
full capacity" as seen in /proc) will increase as well, won't it? If
the battery went over that 100% that means there is a "new" 100%, why
are we losing information?.

I am asking, I am not an expert on battery stuff.

>
>> So I discovered that the battery wrongly returns charge_full_design =
when
>> completely charged instead of charge_full.
>
> Ick.
>
>> This patch fixes this by returning min(capacity_now, full_charge_cap=
acity)
>> on both procfs and sysfs.
>
> What will it cause on non-broken batteries? =A0Or during gauge reset,=
 when any
> battery that updates full_charge_capacity only at the end of the cycl=
e will
> really have capacity_now > full_charge_capacity ?

Well, does it make sense to have capacity_now higher than
full_charge_capacity? Wouldn't that information be broken too?

Again, I am just wondering.

>
>> Now the userspace plugins report the correct 100% and their userspac=
e check
>> may not be needed (if this error is the only one producing >100% res=
ults).
>
> Like I said, > 100% can happen, unless what you define to be 100% is =
very
> elastic (and gets updated all the time).

I still think it does not make sense to have a battery charged over
its 100% capacity whatever the definition of 100% is. Maybe I do not
understand your point.

>
> --
> =A0"One disk to rule them all, One disk to find them. One disk to bri=
ng
> =A0them all and in the darkness grind them. In the Land of Redmond
> =A0where the shadows lie." -- The Silicon Valley Tarot
> =A0Henrique Holschuh
>
