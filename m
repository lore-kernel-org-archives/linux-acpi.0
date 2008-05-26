From: Thomas Renninger <trenn@suse.de>
Subject: Re: cpufreq limits avilable frequencies to 800MHz on git kernel
Date: Mon, 26 May 2008 13:37:33 +0200
Message-ID: <1211801853.29901.174.camel@queen.suse.de>
References: <200805231944.57320.arekm@maven.pl>
	 <200805251136.24313.arekm@maven.pl>
	 <1211727835.3422.36.camel@linux-2bdv.site>
	 <200805260907.05561.arekm@maven.pl>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:45486 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbYEZLhf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2008 07:37:35 -0400
In-Reply-To: <200805260907.05561.arekm@maven.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>, gnorton@novell.com, miguel@novell.com, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-05-26 at 09:07 +0200, Arkadiusz Miskiewicz wrote:
> On Sunday 25 May 2008, Thomas Renninger wrote:
> > On Sun, 2008-05-25 at 11:36 +0200, Arkadiusz Miskiewicz wrote:
> > > On Saturday 24 May 2008, Andrew Morton wrote:
> > > > On Fri, 23 May 2008 19:44:57 +0200 Arkadiusz Miskiewicz
> > > > <arekm@maven.pl>
> > >
> > > wrote:
> > > > > thinkpad z60m, Intel(R) Pentium(R) M processor 2.00GHz. kerne=
l from
> > > > > git from 1-2 days ago.
> > > > >
> > > > > Unfortunately it seems that suspend to ram/resume causes freq=
uency
> > > > > to be limited to 800MHz only. I can't set it to 2GHz again :-=
/
> > > > >
> > > > > scaling_max_freq is then 800000 and cannot be changed.
> > > > >
> > > > > reboot and the problem disappears until new suspend/resume cy=
cle.
> > > > >
> > > > > cpufreq stuff is driven by acpi-cpufreq
> > > > >
> > > > > $ cpufreq-info
> > > > > cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-200=
6
> > > > > Report errors and bugs to linux@brodo.de, please.
> > > > > analyzing CPU 0:
> > > > >   driver: acpi-cpufreq
> > > > >   CPUs which need to switch frequency at the same time: 0
> > > > >   hardware limits: 800 MHz - 2.00 GHz
> > > > >   available frequency steps: 2.00 GHz, 1.60 GHz, 1.33 GHz, 1.=
07 GHz,
> > > > > 800 MHz available cpufreq governors: powersave, userspace, on=
demand,
> > > > > performance current policy: frequency should be within 800 MH=
z and
> > > > > 800 MHz. The governor "performance" may decide which speed to=
 use
> > > > > within this range.
> > > > >   current CPU frequency is 800 MHz.
> > > > >
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:2000000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_freque=
ncies:20
> > > > >0000 0 1600000 1333000 1066000 800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_govern=
ors:powe
> > > > >rsav e userspace ondemand performance
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpuf=
req
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:perform=
ance
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:800000
> > > > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupp=
orted>
> > > >
> > > > Thanks.  Is this a newly-occurring bug or did earlier kernels d=
o this
> > > > also?
> > > >
> > > > If it was newly added, do you know in which kernel version we m=
ight
> > > > have added it?
> > >
> > > I wasn't able to reproduce the problem on final 2.6.24 but was ab=
le to
> > > reproduce on final 2.6.25. Problem introduced somewhere between i=
t seems.
> > >
> > > Note that 2-3 suspend to ram/resume cycles is needed to get into =
the
> > > problem.
> >
> > Sounds related to:
> > =EF=BB=BF[Bug 374099] T61p speedstep problems (ondemand scheduler)
> > =EF=BB=BFhttps://bugzilla.novell.com/show_bug.cgi?id=3D374099
>=20
> login/pass protected
>=20
> >
> > Miguel speaks from "good boots" and "bad boots".
>=20
> Actually I also got "bad boot" (so no suspend/resume was needed).
>=20
> >
> > Could you check whether the OS thinks it is too hot.
> > =EF=BB=BFI described some basics how to monitor temperature and cpu=
freq (if
> > passive cooling kicks in) here:
> > https://bugzilla.novell.com/show_bug.cgi?id=3D387702#c13
>=20
> Doesn't seem to be overheated
>=20
> [arekm@tarm ~]$ cat /proc/acpi/thermal_zone/*/{temperature,trip_point=
s,state}; cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_{cur_freq,ma=
x_freq}
> temperature:             45 C
> critical (S5):           99 C
> passive:                 95 C: tc1=3D5 tc2=3D4 tsp=3D600 devices=3D C=
PU
> state:                   ok
> 800000
> 800000
>=20
> but still limited to 800MHz.
>=20
> >
> > Hmm, it may just have been fixed by this one:
> > =EF=BB=BFcommit e56a727b023d40d1adf660168883f30f2e6abe0a
> > Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Date:   Mon Apr 28 15:13:43 2008 -0400
> >
> > Miguel, Geoff: This is already in 11.0 for some time and in 10.3 fo=
r
> > some days.
>=20
> Unfortunately it doesn't fix the problem. The patch is in Linus tree =
for long
> time (so I guess I had it when initially reporting the problem) + I u=
pgraded
> today to current git - the problem is still there.

Yep, Dells and some HP should be fixed, it would have been strange if
ThinkPads are now also affected, but thanks for double checking, it
shows the same symptoms.

Then it might be _PPC.
If you compile in CPUFREQ_DEBUG and add the boot param:
cpufreq.debug=3D7
you should see a message in dmesg (if you do not see one, then
everything is fine you have a "good boot" and freq should be at max?):
cpufreq_printk("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
                       (int)ppc, ppc ? "" : "not");

If PPC is zero all frequencies are allowed, if it is one max_freq will
be set to the second highest freq, etc.

If it's that you can workaround that (temporarily, pls help evaluating
this further) you can use:
processor.ignore_ppc=3D1

I remember Ingo Molnar sent a patch to not always evaluate _PPC at
boot/initialization time, but only on processor notification events.
AFAIK this was a recent ThinkPad, so this might be it what you are
seeing. But nobody knew why some ThinkPads had a wrong _PPC value at
initialization time.

If this is PPC related, this is more an ACPI than a cpufreq issue ->
adding linux-acpi list.

   Thomas

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
