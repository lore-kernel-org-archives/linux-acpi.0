From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fixes to suspend-to-RAM
Date: Tue, 18 Feb 2003 15:14:03 -0600 (CST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302181509070.1035-100000@localhost.localdomain>
References: <20030218211741.GA1039@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030218211741.GA1039-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


>  void __init acpi_reserve_bootmem(void)
>  {
>  	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
> +	if (!acpi_wakeup_address)
> +		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
>  	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
>  		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
> -	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);

If you say you're disabling S3, then please really do so and flip the bit 
in the sleep_states[] array.

> --- clean/drivers/acpi/sleep/main.c	2003-02-15 18:51:17.000000000 +0100
> +++ linux/drivers/acpi/sleep/main.c	2003-02-15 18:57:27.000000000 +0100
> @@ -103,6 +103,10 @@
>  			return error;
>  		}
>  
> +		error = device_suspend(state, SUSPEND_DISABLE);
> +		if (error)
> +			panic("Sorry, devices really should know how to disable\n");
> +

Why is every error condition a panic()? That certainly does not add 
robustness to the code..

Also, you say that the APIC needs this state. I wonder if that should be
done in the SUSPEND_POWER_DOWN stage with interrupts disabled?

	-pat
