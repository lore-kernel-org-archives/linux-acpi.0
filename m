From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 Resume - System Timer Tick fix
Date: Fri, 18 Oct 2002 17:06:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021018150613.GB237@elf.ucw.cz>
References: <1DD88DDBBB83D6119C8C00096BB0408FEC5449@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1DD88DDBBB83D6119C8C00096BB0408FEC5449-CdvpJ7rTi0s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>  I found that upon S3 resume the System Clock Tick wasn't being re-enabled,
> thus a lot of things didn't work correctly afterwards :) I have attached a
> patch against 2.5.42 which seems to fix the clock. 
> 
>  Details:  I added a new routine in arch/i386/kernel/acpi.c called
> acpi_restore_sys_timer(), which is code borrowed from apm.c reinit_timer().

That code should be _killed_ from apm.c. It does not belong there.

> The driver/acpi/sleep.c acpi_system_restore_state() routine was modified to
> call the acpi_restore_sys_timer() function.  This works properly on an a PC
> motherboard with an Intel 810 chipset.
> 
>  Also, in driver/acpi/sleep.c acpi_system_save_state() I added a call to
> pm_send_all(PM_SUSPEND) to inform any driver registered with pm_register()
> that an S3 suspend event is happening.  Then I added a call to
> pm_send_all(PM_RESUME) in acpi_system_restore_state() to get devices to
> restore themselves.

pm_send_all() is obsolete interface. Any new code should not depend on
it. Adding pm_send_all in sleep.c is probably good idea, through.

> diff -urN -X dontdiff linux-2.5.42/arch/i386/kernel/acpi.c
> linux-2.5.42_update/arch/i386/kernel/acpi.c
> --- linux-2.5.42/arch/i386/kernel/acpi.c	Sat Oct 12 00:22:18 2002
> +++ linux-2.5.42_update/arch/i386/kernel/acpi.c	Mon Oct 14 14:19:29 2002
> @@ -559,4 +559,23 @@
>  	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n",
> acpi_wakeup_address);
>  }
>  
> +/**
> + * acpi_restore_sys_timer - 
> + *
> + *  After resume from sleep S2 or S3, resume the System Timer interrupt.
> + *  Should be called before enabling interrupts
> + *
> + *  Code borrowed from apm.c - reinit_timer()
> + */
> +void acpi_restore_sys_timer(void)
> +{
> +	/* set the clock to 100 Hz */
> +	outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
> +	udelay(10);
> +	outb_p(LATCH & 0xff , 0x40);    /* LSB */
> +	udelay(10);
> +	outb(LATCH >> 8 , 0x40);        /* MSB */
> +	udelay(10);
> +}
> +
>  #endif /*CONFIG_ACPI_SLEEP*/

This code should go to the place where time is handled, and that place
should be devicefs-aware so it is called... [I looked through
arch/i386 and could not find the place. Weird.]

> diff -urN -X dontdiff linux-2.5.42/drivers/acpi/sleep.c
> linux-2.5.42_update/drivers/acpi/sleep.c
> --- linux-2.5.42/drivers/acpi/sleep.c	Sat Oct 12 00:21:03 2002
> +++ linux-2.5.42_update/drivers/acpi/sleep.c	Mon Oct 14 14:21:23 2002
> @@ -68,12 +68,18 @@
>  	/* turn all the devices back on */
>  	device_resume(RESUME_POWER_ON);
>  
> +	/* enable the system timer interrupt */
> +	acpi_restore_sys_timer();
> +

No special exceptions for timer, please.

>  	/* enable interrupts once again */
>  	ACPI_ENABLE_IRQS();
>  
>  	/* restore device context */
>  	device_resume(RESUME_RESTORE_STATE);

...it should be normal device handled here.

>  
> +	/* resume drivers registered with PM subsystem */
> +	pm_send_all(PM_RESUME, (void *) 0);
> +        

This seems sane.
								Pavel
-- 
I'm pavel-7aPAsKgELzg@public.gmane.org "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss-q33YXrgyAoMgsBAKwltoeQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
