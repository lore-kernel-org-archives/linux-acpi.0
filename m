From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [help] strange fan problems, partially solved in DSDT
Date: Mon, 09 Mar 2009 11:18:30 +0800
Message-ID: <1236568710.2820.70.camel@rzhang-dt>
References: <49B11032.1080706@costela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42814 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbZCIDRo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Mar 2009 23:17:44 -0400
In-Reply-To: <49B11032.1080706@costela.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leo Antunes <leo@costela.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Fri, 2009-03-06 at 19:59 +0800, Leo Antunes wrote:
>=20
> Linux booted OK, but had a non-working thermal zone which always repl=
ied
> a temperature of 0C (though the coretemp module worked ok) and an
> apparently non-working fan interface which always seemed ON and didn'=
t
> respond to
> 'echo 3 > /proc/acpi/fan/FAN/state' (kernel logged the usual "failed =
to
> transition to D3" message).
> The fan also didn't seem to react to the processor temperature, sudde=
nly
> springing to full-power when it reached the 80C trip point (which was=
n't
> even reported in trip_points) and never switching off again.
>=20
> These problems manifested with 2.6.2{6,8,9-rc7}.
so the problem exists in all the kernels you have tried, right?

>=20
> I suspected there could be some problems in the thermal zone definiti=
on
> so I tried the DSDT (both original and new version attached).
> This was my first attempt at reading the ACPI spec and coding ASL, so
> please bear with me if my assumptions are completely off-mark.
>=20
> Opening the DSDT it became obvious that the FAN declaration was bogus=
,
> always returning ON and not implementing the _ON and _OFF methods.
You are right that bogus ACPI fan implemented on this laptop.
This means that the FAN are not controlled via ACPI, but via BIOS or
something else, like EC in this case.

> The next step was debugging the temperature problem, since it seemed =
to
> be an awful big chunk of code to be simply useless, and the fan probl=
em
> seemed harder to find now that I didn't know where else to look.
> While I was stumbling with the _TMP method and adding debugging outpu=
t
> all around the code, the fan suddenly became responsive during one of
> the boot cycles.
> I traced it back to reading from any field inside the EC
> OperationRegion, through a "Store(\_SB.PCI0.LPC.EC0.FNST, Debug)" (I
> started with FNST because it looked like it might mean "fan status", =
but
> reading from other fields also reliably triggered the same behavior).
> FNST itself seems to return 0 in all situations I tried, so I still
> don't know what it actually stands for.
>=20
> At this point I also got the _TMP method working, albeit with an
> apparent temperature skew of a few degrees in relation to the temps
> reported by coretemp, but this wasn't so important as the fan problem=
=2E
>=20
> Debugging blindly a bit further I noticed whenever the fan crossed th=
e
> 35C/50C/60C/80C barriers (again: not the same as trip_points) the _Q1=
1
> method got called and this seemed to adjust the fan speed to whatever
> speed was appropriate.
> Changing just the "Store(\_SB.PCI0.LPC.EC0.FNST, Debug)" line to read
> from some other value not inside the EC made this stop working.
>=20
Interesting.
Alexey may have some comments on this.

> Another interesting characteristic: it stopped working after a full
> suspend-resume cycle, but continued to work when put through all the
> test levels in /sys/power/pm-test, only stopping when we actually cut
> the power and entered S3 proper.
>=20
> To "fix" this I made the fan's _PSC method call _Q11() and read from =
the
> EC, which seemed to keep things working through suspend-resume.
>=20
> Right now everything seems to be working almost perfectly, though I h=
ave
> seen the fan control stop working and only jerk back into action afte=
r a
> suspend-resume cycle, without being able to reproduce the failure rel=
iably.
> I'm totally aware that this is far from a perfect solution and was - =
in
> fact - just a fluke.
>=20
> My questions are:
> - am I right in assuming the EC could be playing behind ACPI's back a=
nd
> controlling the fan speed by itself, only depending on ACPI to react
> when issued the _Q11 event?
I think so, EC needs a notification (ACPI interrupt) to change the fan
speed when temperature changes.

>  Or did I completely misunderstand the way
> the _Qxx methods are supposed to work?
>=20
> - should this problem be understood as a failure in the DSDT for not
> explicitly initializing something; a failure in ACPI for not implicit=
ly
> initializing something or a failure in the hardware/BIOS for dependin=
g
> on partially non-ACPI behavior to control fan speed?
Not sure it's a hardware/software problem.
=EF=BB=BFI don't know what difference "=EF=BB=BFStore(\_SB.PCI0.LPC.EC0=
=2EFNST, Debug)"
brings us.
Alexey, can you have a look at this problem please?

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
