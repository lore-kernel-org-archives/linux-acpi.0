From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: High latency on /sys/class/thermal
Date: Mon, 13 Apr 2009 11:02:51 +0800
Message-ID: <1239591771.7661.222.camel@rzhang-dt>
References: <20090411155612.5808570c@ua.pt>
	 <20090411121416.91fe3c88.akpm@linux-foundation.org>
	 <20090411231611.7c5f9b69@ua.pt>	<20090412170320.52e374df@gmail.com>
	 <1239587022.7661.202.camel@rzhang-dt>  <20090413032817.32df07a0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48594 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbZDMDCc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2009 23:02:32 -0400
In-Reply-To: <20090413032817.32df07a0@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tiago =?ISO-8859-1?Q?Sim=F5es?= Batista <tiagosbatista@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

CC Alexey because this is EC related.
The high letancy is probably spent on accessing the EC address space in
_TMP method.

Tiago,
please make sure your kernel is built with CONFIG_ACPI_DEBUG set
and then
1. boot with printk.time=3D1 acpi.debug_level=3D0x07
acpi.debug_layer=3D0x04000018
2. run =EF=BB=BFcat /sys/class/thermal/thermal_zone0/temp
3. attach the full dmesg output.

thanks,
rui

On Mon, 2009-04-13 at 10:28 +0800, Tiago Sim=C3=B5es Batista wrote:
> acpidump output attached.
>=20
> I found no latency on battery iterface, included is another poke at t=
he
> thermal zone for comparison.
>=20
> This problem is still present, but at the moment, I shut down the
> sensors-applet on the gnome panel, so that it no longer makes
> gnome-panel stall.
>=20
> $ time cat /sys/class/thermal/thermal_zone0/temp=20
> 49000
>=20
> real	0m13.476s
> user	0m0.001s
> sys	0m0.001s
> $ time cat /sys/class/power_supply/BAT0/*
> 0
> 29
> 0
> 0
> cat: /sys/class/power_supply/BAT0/device: Is a directory
> 582640000
> 65120000
> 18710000
> SMP-SONY
> 04ZL
> cat: /sys/class/power_supply/BAT0/power: Is a directory
> 0
> 0
> 1
> Full
> cat: /sys/class/power_supply/BAT0/subsystem: Is a directory
> Li-ion
> 270
> Battery
> PHYSDEVPATH=3D/devices/LNXSYSTM:00/device:00/PNP0A03:00/device:0b/PNP=
0C09:00/ACPI0001:00/ACPI0002:00
> PHYSDEVBUS=3Dacpi
> PHYSDEVDRIVER=3Dsbs
> POWER_SUPPLY_NAME=3DBAT0
> POWER_SUPPLY_TYPE=3DBattery
> POWER_SUPPLY_STATUS=3DFull
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D14800000
> POWER_SUPPLY_VOLTAGE_NOW=3D15611000
> POWER_SUPPLY_CURRENT_NOW=3D0
> POWER_SUPPLY_CURRENT_AVG=3D0
> POWER_SUPPLY_POWER_NOW=3D0
> POWER_SUPPLY_POWER_AVG=3D0
> POWER_SUPPLY_CAPACITY=3D29
> POWER_SUPPLY_ENERGY_FULL_DESIGN=3D65120000
> POWER_SUPPLY_ENERGY_FULL=3D582640000
> POWER_SUPPLY_ENERGY_NOW=3D18710000
> POWER_SUPPLY_TEMP=3D270
> POWER_SUPPLY_MODEL_NAME=3D04ZL
> POWER_SUPPLY_MANUFACTURER=3DSMP-SONY
> 14800000
> 15611000
>=20
> real	0m0.110s
> user	0m0.001s
> sys	0m0.004s
>=20
>=20
> On Mon, 13 Apr 2009 09:43:42 +0800
> Zhang Rui <rui.zhang@intel.com> wrote:
>=20
> > this sounds like an EC problem to me. please attach the acpidump
> > output. is there a long latency when you poke other ACPI devices, s=
ay
> > battery?
> >=20
> > thanks,
> > rui
> >=20
> > On Mon, 2009-04-13 at 00:03 +0800, Tiago Sim=C3=B5es Batista wrote:
> > > On Sat, 11 Apr 2009 23:16:11 +0100
> > > Tiago Sim=C3=B5es Batista <tiagosbatista@gmail.com> wrote:
> > >=20
> > > > Sorry about the noise, by brain was stopped when I sent the las=
t
> > > > mail, please ignore the From address, it is wrong!
> > > >=20
> > > > On Sat, 11 Apr 2009 12:14:16 -0700
> > > > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >=20
> > > > > (cc linux-acpi)
> > > > >=20
> > > > > On Sat, 11 Apr 2009 15:56:12 +0100 "Tiago Sim__es Batista"
> > > > > <tiagosbatista@gmail.com> wrote:
> > > > >=20
> > > > > > Hi all
> > > > > >=20
> > > > > > Yesterday, I recompiled my kernel (git + tuxonice)
> > > > > > v2.6.30-rc1-1002-gac91f91, there were a couple of issues, t=
he
> > > > > > main one is ilustrated bellow.
> > > > > >=20
> > > > > > I am not familiar with the kernel code, but if you give me
> > > > > > some pointers, I will be glad to investigate this further
> > > > > >=20
> > > > > > $time cat /sys/class/thermal/thermal_zone0/temp=20
> > > > > > 34000
> > > > > >=20
> > > > > > real	0m6.613s
> > > > > > user	0m0.000s
> > > > > > sys	0m0.001s
> > > > > >=20
> > > > >=20
> > > > > Is this a regression?  Was 2.6.29 OK?
> > > > >=20
> > > > > Thanks.
> > > >=20
> > > > My last kernel was fine:
> > > >=20
> > > > $ time cat /sys/class/thermal/thermal_zone0/temp=20
> > > > 48000
> > > >=20
> > > > real	0m0.007s
> > > > user	0m0.001s
> > > > sys	0m0.007s
> > > >=20
> > > >=20
> > > > I also forgot to add some information about my kernels...
> > > >=20
> > > > The good one is 2.6.29 + tuxonice as it was the day after the
> > > > 2.6.29 kernel was released.
> > > >=20
> > > > The bad one is a pull from linus tree on april the 9th plus
> > > > tuxonice on the same day
> > > >=20
> > > > from git (hope this helps):
> > > > $ git describe v2.6.29-tiago2-ice
> > > > v2.6.29-836-g00492ed
> > > > $ git describe v2.6.30-rc1-tiago1-ice
> > > > v2.6.30-rc1-1002-gac91f91
> > > >=20
> > > >=20
> > > > If tuxonice is a suspect, I will be glad to remove it and
> > > > recompile. If I have the time later this weekend, and nothing w=
as
> > > > found, I will try to bisect this.
> > > >=20
> > >=20
> > > Here are some results from the bisect:
> > > The metric I used to mark a revision as good/bad was
> > > $ time for ((i =3D0; i < 100; i++)); do
> > >       cat /sys/class/thermal/thermal_zone0/temp > /dev/null;=20
> > >   done
> > >=20
> > > The bad ones take forever, i never even finished one bad run. The
> > > good ones take about half a second.
> > >=20
> > > When I checked out revisions v2.6.29-148-g33526a5 and
> > > v2.6.29-159-g8a3f257, it took almost 2 secons to run the command,
> > > so I think some of the latency my have been introduced around
> > > these. Yet, I still marked them as good.
> > >=20
> > > The resut was:
> > > 478c6a43fcbc6c11609f8cee7c7b57223907754f is first bad commit
> > > witch is a merge. I am out of ideas...
> > >=20
> > > I forgot to ask, am I the only one experiencing this? I am using =
a
> > > TravelMate 4000 with the intel graphics chip, can anyone reproduc=
e
> > > this? If no one can reproduce this, I can still test a vanilla
> > > kernel to remove TOI from the equation!
> > >=20
> > > Tiago
> > >=20
> > >=20
> > > Below is the bisect log:
> > > $ git bisect log
> > > git bisect start
> > > # bad: [ac91f917d7ed7d1ebe14532ee137fcd759b4406d] Merge branch
> > > 'all' into all-tuxonice git bisect bad
> > > ac91f917d7ed7d1ebe14532ee137fcd759b4406d # good:
> > > [178a426510a901d9335f39d3391ae5e8628a36d1] Merge branch 'tuxonice=
'
> > > into all-tuxonice git bisect good
> > > 178a426510a901d9335f39d3391ae5e8628a36d1 # good:
> > > [fdf9c9979a355916433262ea5e5e64bed5def86e] V4L/DVB (10465):
> > > dsbr100: Add few lost mutex locks. git bisect good
> > > fdf9c9979a355916433262ea5e5e64bed5def86e # good:
> > > [edbd606c4671fcd439164c8d63e896044d706156] Staging: wlan-ng:
> > > Replace WLAN_LOG_ERROR() with printk() git bisect good
> > > edbd606c4671fcd439164c8d63e896044d706156 # good:
> > > [3516c6a8dc0b1153c611c4cf0dc4a51631f052bb] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6
> > > git bisect good 3516c6a8dc0b1153c611c4cf0dc4a51631f052bb # bad:
> > > [3989203290fba6fdf6bc4825fbf6526e1bf17977] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 git
> > > bisect bad 3989203290fba6fdf6bc4825fbf6526e1bf17977 # bad:
> > > [d7ca6f8cdffa5765e486edb3dada9121fba8e6aa] Merge branch 'for-linu=
s'
> > > of git://git.o-hand.com/linux-rpurdie-backlight git bisect bad
> > > d7ca6f8cdffa5765e486edb3dada9121fba8e6aa # good:
> > > [3b4dadf05d177289c279c50030c7c75e004952bb] Merge branch
> > > 'acpi_enforce_resources' into release git bisect good
> > > 3b4dadf05d177289c279c50030c7c75e004952bb # bad:
> > > [32fb6c17566ec66de87324a834c7776f40e35e78] Merge branch 'release'
> > > of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
> > > git bisect bad 32fb6c17566ec66de87324a834c7776f40e35e78 # good:
> > > [45e36c1666aa6c8b0c538abcf984b336184d8c3f] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 git
> > > bisect good 45e36c1666aa6c8b0c538abcf984b336184d8c3f # good:
> > > [33526a53600ac887d100e3c9b4be3637ac8ae3a5] Merge branch 'x2apic'
> > > into release git bisect good
> > > 33526a53600ac887d100e3c9b4be3637ac8ae3a5 # good:
> > > [c542aadeb4700bc316834d862d52ba3d2664f13a] panasonic-laptop: Fix
> > > autoloading git bisect good
> > > c542aadeb4700bc316834d862d52ba3d2664f13a # bad:
> > > [478c6a43fcbc6c11609f8cee7c7b57223907754f] Merge branch 'linus'
> > > into release git bisect bad
> > > 478c6a43fcbc6c11609f8cee7c7b57223907754f # good:
> > > [15065531c1c5902775ae3ade24eb37d0e688353b] toshiba-acpi: remove
> > > MAINTAINERS entry git bisect good
> > > 15065531c1c5902775ae3ade24eb37d0e688353b # good:
> > > [8a3f257c704e02aee9869decd069a806b45be3f1] Merge branch 'misc' in=
to
> > > release git bisect good 8a3f257c704e02aee9869decd069a806b45be3f1
> >=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
