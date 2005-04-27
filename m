From: Ron Rechenmacher <ron-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org>
Subject: RE: Suspend2ram on Toshiba Tecra A3 OR problem with S3 on new 915PM
 chipset system appears to be with SATA/IDE
Date: Wed, 27 Apr 2005 17:44:37 -0500
Message-ID: <200504272244.j3RMibEf032018@fnapcf.fnal.gov>
Reply-To: ron_-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: kojm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ron-13hema8v3vg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm wondering if I'm having the same problem.
I was using a Dell M60 w/ 2.6.10 and 2.6.11.7 with no problems.
The M60 has 855PM chipset with integrated (ICH4) ATA IDE and the disk
is a parallel IDE disk.

The M70 is 915PM based with integrated SATA controller which somehow
(experts know?) can work with the IDE driver, but slow, but with the
SATA driver + SCSI works better. Anyway, the disk is still a parallel
IDE disk, so I suppose there must be some serial <-> parallel magic 
going on.
Anywho, when I suspend, all seems well, but when I try to wake, the
disk doesn't come back and if I wait long enough, I get some:
     journal commit I/O error
and sometimes some other disk timeout errors.
Sometimes the video screen comes pack and the mouse works and I can type,
but, b/c the disk isn't working, I can't do anything. Sometimes the video
doesn't come back, but the caps lock still works.

I've tried 2.6.10, 2.6.11.7, and 2.6.12-rc2

So, which driver(s) should I look at?
Or is there a simple chant to /proc that can wake up the disk correctly?
Or am I not doing something correctly before/after I
   echo mem >/sys/power/state
Or is the 915PM and/or SATA acpi stuff just (too) new and I should help
get it working?

The system does successfully suspend to RAM and wake up under windows XP :(

Any ideas/suggestions/comments or work for me to do?

Thanks,
Ron

Tomasz Kojm <tk@lo...> said:
> Dear power experts,
>    I"m fighting with S3 on Toshiba Tecra A3 without success for a few
> days
>  now. I"ve tried all combinations of acpi_sleep on various kernels
>  (including -mm ones) down to 2.6.8 and the effect is always the same:
>  laptop properly(?) suspends but on resume it doesn"t initialize
> graphics
>  (LCD is off) and seem to be hanged (at least the keyboard, because
> the
>  system doesn"t react on any commands, including ctrl+alt+del). The
>  computer is based on the Intel 915 GM chipset with integrated
> graphics.
>    I hope someone can drive me in a good direction. For the last three
>  years I was successfully using suspend2ram (via APM) on my old and
> good
>  Portege notebook and now suspend to disk doesn"t look as a good
>  alternative from my point of view.
>    Thank you in advance,
>  





-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
