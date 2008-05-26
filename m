From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: cpufreq limits avilable frequencies to 800MHz on git kernel
Date: Mon, 26 May 2008 18:23:02 +0200
Message-ID: <200805261823.03140.arekm@maven.pl>
References: <200805231944.57320.arekm@maven.pl> <1211801853.29901.174.camel@queen.suse.de> <200805261815.40601.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailmxout.mailmx.agnat.pl ([193.239.44.238]:2150 "EHLO
	mailmxout.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbYEZQXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 May 2008 12:23:07 -0400
In-Reply-To: <200805261815.40601.arekm@maven.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: trenn@suse.de, cpufreq@lists.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>, gnorton@novell.com, miguel@novell.com, linux-acpi <linux-acpi@vger.kernel.org>

On Monday 26 May 2008, Arkadiusz Miskiewicz wrote:
> On Monday 26 May 2008, Thomas Renninger wrote:
> > On Mon, 2008-05-26 at 09:07 +0200, Arkadiusz Miskiewicz wrote:
> > > On Sunday 25 May 2008, Thomas Renninger wrote:
> > > > On Sun, 2008-05-25 at 11:36 +0200, Arkadiusz Miskiewicz wrote:
> > > > > On Saturday 24 May 2008, Andrew Morton wrote:
> > > > > > On Fri, 23 May 2008 19:44:57 +0200 Arkadiusz Miskiewicz
> > > > > > <arekm@maven.pl>
> > > > >
> > > > > wrote:
> > > > > > > thinkpad z60m, Intel(R) Pentium(R) M processor 2.00GHz. k=
ernel
> > > > > > > from git from 1-2 days ago.
> > > > > > >
> > > > > > > Unfortunately it seems that suspend to ram/resume causes
> > > > > > > frequency to be limited to 800MHz only. I can't set it to=
 2GHz
> > > > > > > again :-/
> > > > > > >
> > > > > > > scaling_max_freq is then 800000 and cannot be changed.
> > > > > > >
> > > > > > > reboot and the problem disappears until new suspend/resum=
e
> > > > > > > cycle.
> > > > > > >
> > > > > > > cpufreq stuff is driven by acpi-cpufreq
> > > > > > >
> > > > > > > $ cpufreq-info
> > > > > > > cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004=
-2006
> > > > > > > Report errors and bugs to linux@brodo.de, please.
> > > > > > > analyzing CPU 0:
> > > > > > >   driver: acpi-cpufreq
> > > > > > >   CPUs which need to switch frequency at the same time: 0
> > > > > > >   hardware limits: 800 MHz - 2.00 GHz
> > > > > > >   available frequency steps: 2.00 GHz, 1.60 GHz, 1.33 GHz=
, 1.07
> > > > > > > GHz, 800 MHz available cpufreq governors: powersave, user=
space,
> > > > > > > ondemand, performance current policy: frequency should be
> > > > > > > within 800 MHz and 800 MHz. The governor "performance" ma=
y
> > > > > > > decide which speed to use within this range.
> > > > > > >   current CPU frequency is 800 MHz.
> > > > > > >
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:800=
000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:200=
0000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:800=
000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_fr=
equenc
> > > > > > >ie s:20 0000 0 1600000 1333000 1066000 800000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_go=
vernor
> > > > > > >s: powe rsav e userspace ondemand performance
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800=
000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-=
cpufre
> > > > > > >q
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:per=
forman
> > > > > > >ce /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:8=
00000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:800=
000
> > > > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<un=
suppor
> > > > > > >te d>
> > > > > >
> > > > > > Thanks.  Is this a newly-occurring bug or did earlier kerne=
ls do
> > > > > > this also?
> > > > > >
> > > > > > If it was newly added, do you know in which kernel version =
we
> > > > > > might have added it?
> > > > >
> > > > > I wasn't able to reproduce the problem on final 2.6.24 but wa=
s able
> > > > > to reproduce on final 2.6.25. Problem introduced somewhere be=
tween
> > > > > it seems.
> > > > >
> > > > > Note that 2-3 suspend to ram/resume cycles is needed to get i=
nto
> > > > > the problem.
> > > >
> > > > Sounds related to:
> > > > =EF=BB=BF[Bug 374099] T61p speedstep problems (ondemand schedul=
er)
> > > > =EF=BB=BFhttps://bugzilla.novell.com/show_bug.cgi?id=3D374099
> > >
> > > login/pass protected
> > >
> > > > Miguel speaks from "good boots" and "bad boots".
> > >
> > > Actually I also got "bad boot" (so no suspend/resume was needed).
> > >
> > > > Could you check whether the OS thinks it is too hot.
> > > > =EF=BB=BFI described some basics how to monitor temperature and=
 cpufreq (if
> > > > passive cooling kicks in) here:
> > > > https://bugzilla.novell.com/show_bug.cgi?id=3D387702#c13
> > >
> > > Doesn't seem to be overheated
> > >
> > > [arekm@tarm ~]$ cat
> > > /proc/acpi/thermal_zone/*/{temperature,trip_points,state}; cat
> > > /sys/devices/system/cpu/cpu*/cpufreq/scaling_{cur_freq,max_freq}
> > > temperature:             45 C
> > > critical (S5):           99 C
> > > passive:                 95 C: tc1=3D5 tc2=3D4 tsp=3D600 devices=3D=
 CPU
> > > state:                   ok
> > > 800000
> > > 800000
> > >
> > > but still limited to 800MHz.
> > >
> > > > Hmm, it may just have been fixed by this one:
> > > > =EF=BB=BFcommit e56a727b023d40d1adf660168883f30f2e6abe0a
> > > > Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > > > Date:   Mon Apr 28 15:13:43 2008 -0400
> > > >
> > > > Miguel, Geoff: This is already in 11.0 for some time and in 10.=
3 for
> > > > some days.
> > >
> > > Unfortunately it doesn't fix the problem. The patch is in Linus t=
ree
> > > for long time (so I guess I had it when initially reporting the
> > > problem) + I upgraded today to current git - the problem is still
> > > there.
> >
> > Yep, Dells and some HP should be fixed, it would have been strange =
if
> > ThinkPads are now also affected, but thanks for double checking, it
> > shows the same symptoms.
> >
> > Then it might be _PPC.
> > If you compile in CPUFREQ_DEBUG and add the boot param:
> > cpufreq.debug=3D7
> > you should see a message in dmesg (if you do not see one, then
> > everything is fine you have a "good boot" and freq should be at max=
?):
> > cpufreq_printk("CPU %d: _PPC is %d - frequency %s limited\n", pr->i=
d,
> >                        (int)ppc, ppc ? "" : "not");
> >
> > If PPC is zero all frequencies are allowed, if it is one max_freq w=
ill
> > be set to the second highest freq, etc.
> >
> > If it's that you can workaround that (temporarily, pls help evaluat=
ing
> > this further) you can use:
> > processor.ignore_ppc=3D1
> >
> > I remember Ingo Molnar sent a patch to not always evaluate _PPC at
> > boot/initialization time, but only on processor notification events=
=2E
> > AFAIK this was a recent ThinkPad, so this might be it what you are
> > seeing. But nobody knew why some ThinkPads had a wrong _PPC value a=
t
> > initialization time.
> >
> > If this is PPC related, this is more an ACPI than a cpufreq issue -=
>
> > adding linux-acpi list.
>
> Ok, there is something, see:
>
> [ 4093.625227] cpufreq-core: target for CPU 0: 2000000 kHz, relation =
1
> [ 4095.755272] cpufreq-core: setting new policy for CPU 0: 800000 - 2=
000000
> kHz [ 4095.755508] acpi-cpufreq: acpi_cpufreq_verify
> [ 4095.755642] freq-table: request for verification of policy (800000=
 -
> 2000000 kHz) for cpu 0 [ 4095.755780] freq-table: verification lead t=
o
> (800000 - 2000000 kHz) for cpu 0 [ 4095.755916] acpi-cpufreq:
> acpi_cpufreq_verify
> [ 4095.756042] freq-table: request for verification of policy (800000=
 -
> 800000 kHz) for cpu 0 [ 4095.756179] freq-table: verification lead to
> (800000 - 800000 kHz) for cpu 0 [ 4095.756314] cpufreq-core: new min =
and
> max freqs are 800000 - 800000 kHz

and later back to 2GHz



[ 4095.756042] freq-table: request for verification of policy (800000 -=
 800000=20
kHz) for cpu 0
[ 4095.756179] freq-table: verification lead to (800000 - 800000 kHz) f=
or cpu=20
0
[ 4095.756314] cpufreq-core: new min and max freqs are 800000 - 800000 =
kHz
[ 4095.756447] cpufreq-core: governor: change or update limits
[ 4095.756575] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[ 4216.175207] __ratelimit: 39 messages suppressed
[ 4216.175414] cpufreq-core: CPU 0: _PPC is 0 - frequency not limited
[ 4216.175553] cpufreq-core: updating policy for CPU 0
[ 4216.175682] acpi-cpufreq: get_cur_freq_on_cpu (0)
[ 4216.175809] acpi-cpufreq: get_cur_val =3D 100664850
[ 4216.175936] acpi-cpufreq: cur freq =3D 800000
[ 4216.176061] cpufreq-core: setting new policy for CPU 0: 800000 - 200=
0000=20
kHz
[ 4216.176194] acpi-cpufreq: acpi_cpufreq_verify
[ 4216.176322] freq-table: request for verification of policy (800000 -=
=20
2000000 kHz) for cpu 0
[ 4216.176458] freq-table: verification lead to (800000 - 2000000 kHz) =
for cpu=20
0
[ 4216.176592] acpi-cpufreq: acpi_cpufreq_verify
[ 4216.176719] freq-table: request for verification of policy (800000 -=
=20
2000000 kHz) for cpu 0
[ 4216.176856] freq-table: verification lead to (800000 - 2000000 kHz) =
for cpu=20
0
[ 4216.177405] cpufreq-core: new min and max freqs are 800000 - 2000000=
 kHz
[ 4216.177565] cpufreq-core: governor: change or update limits
[ 4216.177696] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[ 4230.625012] cpufreq-core: target for CPU 0: 2000000 kHz, relation 1
[ 4230.625277] acpi-cpufreq: acpi_cpufreq_target 2000000 (0)
[ 4230.625421] freq-table: request for target 2000000 kHz (relation: 1)=
 for=20
cpu 0
[ 4230.625563] freq-table: target is 0 (2000000 kHz, 0)
[ 4230.625698] cpufreq-core: notification 0 of frequency transition to =
2000000=20
kHz
[ 4230.625838] cpufreq-core: scaling loops_per_jiffy to 7988623 for fre=
quency=20
2000000 kHz
[ 4230.625904] cpufreq-core: notification 1 of frequency transition to =
2000000=20
kHz
[ 4241.624998] __ratelimit: 7 messages suppressed


then back again to 800MHz and back to 2GHz

[ 4313.125215] cpufreq-core: target for CPU 0: 2000000 kHz, relation 1
[ 4315.821316] cpufreq-core: setting new policy for CPU 0: 800000 - 200=
0000=20
kHz
[ 4315.821465] acpi-cpufreq: acpi_cpufreq_verify
[ 4315.821525] freq-table: request for verification of policy (800000 -=
=20
2000000 kHz) for cpu 0
[ 4315.821587] freq-table: verification lead to (800000 - 2000000 kHz) =
for cpu=20
0
[ 4315.821648] acpi-cpufreq: acpi_cpufreq_verify
[ 4315.821705] freq-table: request for verification of policy (800000 -=
 800000=20
kHz) for cpu 0
[ 4315.821765] freq-table: verification lead to (800000 - 800000 kHz) f=
or cpu=20
0
[ 4315.821826] cpufreq-core: new min and max freqs are 800000 - 800000 =
kHz
[ 4315.821885] cpufreq-core: governor: change or update limits
[ 4315.821942] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[ 4315.822000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[ 4315.822080] acpi-cpufreq: acpi_cpufreq_target 800000 (0)
[ 4315.822138] freq-table: request for target 800000 kHz (relation: 1) =
for cpu=20
0
[ 4315.822197] freq-table: target is 4 (800000 kHz, 4)
[ 4315.822255] cpufreq-core: notification 0 of frequency transition to =
800000=20
kHz
[ 4315.822316] cpufreq-core: notification 1 of frequency transition to =
800000=20
kHz
[ 4315.822370] cpufreq-core: scaling loops_per_jiffy to 3195449 for fre=
quency=20
800000 kHz
[ 4459.098165] __ratelimit: 44 messages suppressed
[ 4459.098394] cpufreq-core: CPU 0: _PPC is 0 - frequency not limited
[ 4459.098534] cpufreq-core: updating policy for CPU 0
[ 4459.098663] acpi-cpufreq: get_cur_freq_on_cpu (0)
[ 4459.098791] acpi-cpufreq: get_cur_val =3D 100664850
[ 4459.098918] acpi-cpufreq: cur freq =3D 800000
[ 4459.099044] cpufreq-core: setting new policy for CPU 0: 800000 - 200=
0000=20
kHz
[ 4459.099177] acpi-cpufreq: acpi_cpufreq_verify
[ 4459.099321] freq-table: request for verification of policy (800000 -=
=20
2000000 kHz) for cpu 0
[ 4459.099458] freq-table: verification lead to (800000 - 2000000 kHz) =
for cpu=20
0


--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
