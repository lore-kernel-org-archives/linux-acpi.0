From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: strange hang on boot
Date: Tue, 15 Jan 2002 07:56:27 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020115125618.GA2015@zaurus>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF57@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DF57-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> What are some common things that could cause this? I was thinking this could
> be EC-related, but it still happens with no EC support...I thought it might
> be some disk-related IRQ weirdness. Does the IDE driver take interrupts when
> it probes, or only when it transfers data? If only the latter, then maybe a
> lack of IDE interrupts could be the cause?

I do not think so. IDE recovers well from
lost interrupts...
				PavelEnd_of_mail_magic_2033
# New mail (delim 2185)
/usr/sbin/sendmail -oem -oi -N failure,delay -R full -- jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org andrew.grover@intel.com acpi-devel@sourceforge.net << End_of_mail_magic_2185
Date: Tue, 15 Jan 2002 08:23:36 -0500
From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel@sourceforge.net
Subject: Re: [ACPI] Re: ACPI small patch update (20021024)
Message-ID: <20020115132324.GB2015@zaurus>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A467-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org> <m2wuo7tc0g.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wuo7tc0g.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
User-Agent: Mutt/1.3.27i

Hi!

>  Andrew> As soon as Linus gets back, I'll be submitting all the
>  Andrew> outstanding changes to him, and all the patchsets are on
>  Andrew> linux-acpi.bkbits.net if anyone just wants to browse the most
>  Andrew> recent changes.
> 
> Not that I'm running this project, but I'd humbly suggest holding off
> those submissions until at least the recent regressions are fixed.
> 
> 20021022 has blown off /proc/acpi/thermal and /proc/acpi/processor for
> me (and at least for one other person).

As these patches probably fix things for >1
person, too, I think holding them back is bad
idea. Remember, Linus likes small patches.End_of_mail_magic_2185
# New mail (delim 2338)
/usr/sbin/sendmail -oem -oi -N failure,delay -R full -- ak-l3A5Bk7waGM@public.gmane.org andrew@pimlott.net linux-kernel@vger.kernel.org << End_of_mail_magic_2338
Date: Tue, 15 Jan 2002 12:44:28 -0500
From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: andrew-T1OfMDHbC/nR7s880joybQ@public.gmane.org, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20020115174416.GC2015@zaurus>
References: <200210251557.55202.landley-O/U8sLjX0KF0TjvJqrojQs21knjtCldOBscD18MNCCY1H/kThXSrnA@public.gmane.org> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <20021028053004.C2558@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028053004.C2558-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
User-Agent: Mutt/1.3.27i

Hi!

> The point of my patchkit is to allow the file systems
> who support better resolution to handle it properly. Other filesystems
> are not worse than before when they flush inodes (and better off when
> they keep everything in ram for your build because then they will enjoy 
> full time resolution) 

What about always rounding down even when inode is
in memory? That is both simple and consistent.

> If you really wanted that I would recommend to change make.
> When all nanosecond parts are 0 it is reasonable for make to assume that
> the fs doesn't support finegrained resolution. But I'm not sure it's 
> worth it.

Thats really ugly heuristics. What about filling
nanosecond part with ~0 when unavailable?

			PsvelEnd_of_mail_magic_2338
# New mail (delim 2423)
/usr/sbin/sendmail -oem -oi -N failure,delay -R full -- pavel-+ZI9xUNit7I@public.gmane.org << End_of_mail_magic_2423
Date: Tue, 15 Jan 2002 14:31:14 -0500
From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
To: pavel-+ZI9xUNit7I@public.gmane.org
Subject: [PATCH] Hotplug CPUs for i386 2.5.44 (fwd)
Message-ID: <20020115193101.GD2015@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i


----- Forwarded message from Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> -----

To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org, mingo@redhat.com, mochel@osdl.org
Subject: [PATCH] Hotplug CPUs for i386 2.5.44 

Doesn't apply to -mm5 because someone did wierd things with the CPU
placement in driverfs, which clashes with this patch which moves it to
kernel/cpu.c...

Usage:
1) Apply patch, and boot resulting kernel.
2) echo 0 > /devices/root/sys/cpu0/online
3) echo 1 > /devices/root/sys/cpu0/online

The CPU actually spins with interrupts off, doing cpu_relax() and
polling a variable.  It's basically useful for testing the unplug
infrastructure and benchmarking.

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/hotcpu-x86-28-10-2002.2.5.44.diff.gz

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
End_of_mail_magic_2423
# New mail (delim 2439)
/usr/sbin/sendmail -oem -oi -N failure,delay -R full -- rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org linux-kernel@vger.kernel.org akpm@zip.com.au mingo@redhat.com mochel@osdl.org << End_of_mail_magic_2439
Date: Tue, 15 Jan 2002 14:34:02 -0500
From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
To: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm@zip.com.au, mingo@redhat.com,
	mochel-3NddpPZAyC0@public.gmane.org
Subject: Re: [PATCH] Hotplug CPUs for i386 2.5.44
Message-ID: <20020115193356.GE2015@zaurus>
References: <20021028080437.DE7112C0E3-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028080437.DE7112C0E3-w/Ol4Ecudpl8XjKLYN78aQ@public.gmane.org>
User-Agent: Mutt/1.3.27i

Hi!

> Usage:
> 1) Apply patch, and boot resulting kernel.
> 2) echo 0 > /devices/root/sys/cpu0/online
> 3) echo 1 > /devices/root/sys/cpu0/online
> 
> The CPU actually spins with interrupts off, doing cpu_relax() and
> polling a variable.  It's basically useful for testing the unplug
> infrastructure and benchmarking.

Hehe, with this swsusp should be doable on
an smp machine (turn it into UP and suspend;
during resume, turn it into UP, resume, and go
back SMP). I guess I schould get some SMP
to play with...
			Pavel
End_of_mail_magic_2439


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
