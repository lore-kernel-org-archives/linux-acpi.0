From: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Subject: Re: Ask devices to powerdown before S3 sleep
Date: Mon, 20 Jan 2003 17:27:06 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.10.10301201714120.16070-100000@master.linux-ide.org>
References: <20030119214642.GA27885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030119214642.GA27885-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi! Pavel,

Could you do me just one tiny favor?
Please consider attempting an error recovery level path, maybe ...

Every patch I have glanced at has 'panic("blah blah");'

If you do not have enough hardware to generate an accurate path for
recovery, then please do not force the kernel into panic.  Would you
consider failing the request making it jump back to S1 ?  This at least
allows it crash like a power failure.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Sun, 19 Jan 2003, Pavel Machek wrote:

> Hi!
> 
> SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> SUSPEND_DISABLE should be so simple that errors just should not be
> there, and besides we would not know how to safely enable devices from
> such weird state, anyway]. Please apply,
> 
> 								Pavel
> 
> --- clean/drivers/acpi/sleep.c	2003-01-05 22:58:25.000000000 +0100
> +++ linux-swsusp/drivers/acpi/sleep.c	2003-01-19 21:27:00.000000000 +0100
> @@ -143,6 +143,10 @@
>  			return error;
>  		}
>  
> +		error = device_suspend(state, SUSPEND_DISABLE);
> +		if (error)
> +			panic("Sorry, devices really should know how to disable\n");
> +
>  		/* flush caches */
>  		ACPI_FLUSH_CPU_CACHE();
> 
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
