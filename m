From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Re: Computer Resets on Resume From S3
Date: Fri, 21 Nov 2003 23:33:10 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311212333.10341.jak97@doc.ic.ac.uk>
References: <200311201522.15255.jak97@doc.ic.ac.uk> <20031121211607.GA882@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121211607.GA882-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 21 November 2003 9:16 pm, Pavel Machek wrote:
>
> Inserting infinite loops can be used for debugging. Or debug leds on
> pci card...
> 								Pavel

Right, I inserted an infinite loop in drivers/acpi/sleep/main.c, just after  
printk(KERN_DEBUG "Back to C!\n"); in acpi_pm_enter()

        /* Johnny's infinite loop */
        for (;;) ;

However, the computer must have rebooted before then. Next thing I tried was 
an infinite loop in arch/i386/kernel/acpi/wakeup.S as the first thing for the 
wakeup_start routine.

ENTRY(wakeup_start)
wakeup_code:
        wakeup_code_start = .
        .code16

1:
        jmp      1b

This too, doesn't catch it. This makes me think that perhaps there is 
something going wrong with the ACPI wake-up address initialisation?

My dmesg (with acpi debugging enabled) is at http://www.doc.ic.ac.uk/~jak97/
dsdt/dmesg.

One warning of possible significance is:
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
The 11.1 device is my IDE controller. Could this be an issue? I do not have 
any problems with disks ordinarily.

Please let me know if anything stands out.

Thanks

John



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
