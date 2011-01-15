From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: on builds/randconfigs
Date: Sat, 15 Jan 2011 13:24:59 +0100
Message-ID: <AANLkTinpjHZgKhLN19kn=0o6aXbMAJEooEUtHSxGyotm@mail.gmail.com>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1101121257580.18873@x980>
	<20110112131800.d64c1a86.akpm@linux-foundation.org>
	<201101122224.54330.rjw@sisk.pl>
	<alpine.LFD.2.02.1101121654000.19754@x980>
	<4D2EEEAA.7040200@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4D2EEEAA.7040200@suse.cz>
Sender: linux-next-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimn@jasper.es, Arnaud Lacombe <lacombar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 13 January 2011 13:23, Michal Marek <mmarek@suse.cz> wrote:
> On 12.1.2011 22:58, Len Brown wrote:
>>>> These unusable config combinations should be prevented via Kconfig=
=2E
>>>> That prevents users from selecting them, which otherwise adds to
>>>> our workload and to theirs. =C2=A0It also prevents false-positives
>>>> during our useful randconfig testing.
>>>
>>> But it is kind of difficult to achieve IMhO. =C2=A0For example, the=
re are options
>>> that are only SELECTed if something else is set, but randconfig doe=
sn't seem
>>> to care.
>>
>> Kconfig select needs to be fixed so that it is not possible to
>> select something if that something's dependencies are not met.
>
> Right now, it issues a warning in such case. I think changing it to a
> fatal error would be too premature, not long ago there were a couple =
of
> annoying false positives.
>
> But from the rest of the thread, I conclude that you actually meant "=
not
> possible to select something if that something's dependencies CANNOT =
be
> met", i.e. automatically select dependencies if that is possible. Tha=
t
> was actually one of the goals of Vegard Nossum's GSoC poject last yea=
r,
> but I haven't heard of any outcome yet. Vegard, is there something we
> could use, be it code or mistakes we could learn from?

Maybe I am wrong, but doesn't conf_write() actually take care of this
when it does that sym_calc_value() for all the symbols? Or maybe
that's the problem (i.e. that it doesn't).

Current satconfig code can be changed to produce random configs (that
nevertheless respect the user's choices) with a 1-line patch. But
there are some other issues to be worked out, mainly that conf_write()
doesn't respect all the choices that the SAT solver made. There could
be several reasons for that: 1. satconfig doesn't deal with
hex/int/string values and relies on conf_write() to fill in those
(this is a plain old bug), 2. the translation into boolean logic is
subtly wrong, perhaps a corner case or something like that, and/or 3.
conf_write() does something wrong.

I'll be happy to give a tour of the satconfig code if you or anybody
else would like to start hacking on it.


Vegard
