From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: ACPI and the idle loop - possible bug
Date: Sat, 25 Jun 2005 15:19:23 -0700
Message-ID: <20050625151923.738504b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Stefan Baums <baums@u.washington.edu>
List-Id: linux-acpi@vger.kernel.org



Begin forwarded message:

Date: Sat, 25 Jun 2005 14:01:10 -0700
From: Stefan Baums <baums@u.washington.edu>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: ACPI and the idle loop - possible bug


Some Lenove (IBM) ThinkPad models (in my case the ThinkPad X41
2528-6NU) produce irritating high-pitch crackling noises under
Linux in certain conditions, see the discussion here:

   http://thinkwiki.org/wiki/Problem_with_high_pitch_noises

This noise only occurs when the processor is not busy (with, e.g.,
compiling or video playback), so it seems to be related to the
idle loop (see also below about 'idle=halt').  Furthermore, it
seems to be caused by something that ACPI is doing to the
processor: if the 'processor' module (and its dependants:
'speedstep_centrino'/'acpi_cpufreq' and 'thermal') are not loaded,
the high-pitch noise does not occur.

If the 'processor' module (and its dependants) _are_ loaded, then
the noise can be initially avoided by passing the boot parameter

   idle=halt

to the kernel (causing it to halt, not poll, the processor during
idle loops), but this workaround _only_ works until either

   1) the system resumes from either suspend or hibernation, or

   2) the power state changes from battery to plugged-in or vice
      versa.

whereupon the high-pitch noise makes a return.

Taken all together, it would appear that the ACPI system is doubly
at fault:

   - First, for causing the high-pitch noise to start with, though
     it could be argued that this is a hardware defect that is
     just triggered by ACPI.  (However not by Windows XP, on the
     same computer, so it is definitely avoidable.)

   - Second, for apparently not respecting the kernel boot
     parameter "idle=halt" when it resumes or changes power state:
     it seems like ACPI is reverting to idle polling on those
     occasions.

Do you agree with this analysis?  Is it clear what ACPI's root
problem ('first' above) is, and will it be solved?  (Not loading
the 'processor', 'speedstep_centrino'/'acpi_cpufreq' and 'thermal'
modules - and losing their features - is not an acceptable
solution.)

As for the 'idle=halt' workaround: Is there any way to test
whether a running kernel actually uses polling or halt for the
idle loop?  What can I do to force ACPI never to use idle polling,
but halt instead?

My kernel version is Linux 2.6.12, custom-compiled on Ubuntu 5.04.
I have enabled all the usual ACPI features as modules.  The noise
problem occurs both with the 'speedstep_centrino' and the
'acpi_cpufreq' modules.  If necessary for diagnosis, I can put up
my kernel .config file online somewhere.

Many thanks for your help,
Stefan

PS.  Setting the polling frequency to 100 Hz instead of 1000 Hz at
compile time, as recommended by some people on the ThinkWiki page,
did not have any effect on the noise problem on my computer.

-- 
Stefan Baums
Asian Languages and Literature
University of Washington
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
