From: Stephan Krings <stephan-6/4LMolCrz7QLMG2gba6HQ@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Tue, 29 Apr 2003 09:52:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16046.12075.401266.747712@hotzenplotz.chateau-neukoelln.de>
References: <3EAB29E2.5030702@woogie.net>
	<20030427100023.A16436@fermat.unipv.it>
	<1051436106.2388.9.camel@calvin.hjblocal.nl>
	<16045.32403.175503.231256@hotzenplotz.chateau-neukoelln.de>
	<1051562943.2523.53.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1051562943.2523.53.camel-PDBFyMGeMq1aCPxV5EPtfPP6llvjuJOh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hilbert Barelds <list-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

> RedHat 9 has XFree 4.3.0 it seems that the 2.4.20 kernel has a working
> Fn 7, fn 8 and lid switcht, bit 2.4.21-pre4 not

Do you have direct rendering (DRI) in XFree86 enabled? Maybe try to
disable that and reboot your machine. It might help. Otherwise I don't
know what might be causing this problem.

> Hmmm, I think the radeon frame buffer and XFree byte each other. I think
> I am going to try that later this week.

No, they don't, normally they can happily work side by side.

> the cpufreq patch seems te work, but I don't notice any difference in
> power consumption reported the battery status

You mean by looking at the "present rate" for the battery? Well, then
its obvious why you can't notice any difference: When your power is
online the discharging rate is 0 usually, so it does not report
current power consumption properly. If, however, you're offline, the
BIOS will automatically switch the CPU to power saving mode (1.2 GHz
in my case). Both cpufreq and /proc/cpuinfo don't see that
transition. If you use cpufreq then, the CPU is already in power
saving mode and the power consumption is no longer affected.

Seems the engineers at Compaq didn't trust the OS very much: Although
ACPI suggests that the operating system is responsible for handling
power management, the BIOS for the Evo N800 series is doing quite a
lot of work behind the scenes like toggling CPU frequency, disabling
the graphics when the lid is closed and so on. I'm not sure I like
that approach...

Regards,

Stephan




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
