From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: swsusp documentation updates
Date: Wed, 5 May 2004 23:43:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040505214301.GA27339@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi, swsusp
Bcc: 
Subject: Re: swsusp documentation updates
Reply-To: 
In-Reply-To: <1Srcw-5NU-25-p/DGQlpaD6yawLM+qSUpQg@public.gmane.org>

Thus wrote Pavel Machek:
> +Q: Does linux support ACPI S4?
> +
> +A: No.

I believe pmdisk uses proper S4 by default.

> +That means that machine does not enter S4 on suspend-to-disk, but
> +simply enters S5. That has few advantages, you can for example boot
> +windows on next boot, and return to your Linux session later. You
> +could even have few different Linuxes on your box (not sharing any
> +partitions), and switch between them.

That's bogus. Entering S4 does not prevent booting multiple systems, or at
least the ACPI spec does not contradict this possibility. S4 and S5 are
nearly identical in that matter (see section 9.1.4).

> +It also has disadvantages. On HP nx5000, if you unplug power cord
> +while machine is suspended-to-disk, Linux will fail to notice that.

Hmm, people were reporting that on the swsusp mailing list. The
aforementioned section contains some notes about hardware state changes
over suspend, but I don't really know if Linux makes use of that.

Apart from that, there seem to differences in handling PMEs -- the RTC
alarm event works fine for me if the box enters S4 and does not if it's at
S5. Wake-On-LAN may suffer the same problems, depending on the machine.

If I may suggest something, it would be stupid to turn down S4 completely,
especially that infrastructure to chose S4 over pm_power_off() already
exists (/sys/power/).

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
