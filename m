From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Computer Resets on Resume From S3
Date: Sat, 22 Nov 2003 14:19:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031122131957.GA1162@atrey.karlin.mff.cuni.cz>
References: <200311201522.15255.jak97@doc.ic.ac.uk> <20031121211607.GA882@elf.ucw.cz> <200311212333.10341.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200311212333.10341.jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Inserting infinite loops can be used for debugging. Or debug leds on
> > pci card...
> 
> Right, I inserted an infinite loop in drivers/acpi/sleep/main.c, just after  
> printk(KERN_DEBUG "Back to C!\n"); in acpi_pm_enter()
> 
>         /* Johnny's infinite loop */
>         for (;;) ;
> 
> However, the computer must have rebooted before then. Next thing I tried was 
> an infinite loop in arch/i386/kernel/acpi/wakeup.S as the first thing for the 
> wakeup_start routine.
> 
> ENTRY(wakeup_start)
> wakeup_code:
>         wakeup_code_start = .
>         .code16
> 
> 1:
>         jmp      1b
> 
> This too, doesn't catch it. This makes me think that perhaps there
> > is 

I've seen something similar before -- it usually meant we left
hardware in "weird" state and it crashed in BIOS.

Can you add "noapic" first, then turn off all unneccesary drivers? No
SMP, please.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
