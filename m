From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] check that acpi_wakeup_address is below 1MB
Date: Thu, 7 Feb 2008 00:10:48 +0100
Message-ID: <200802070010.48992.rjw@sisk.pl>
References: <47AA38EF.6030307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60803 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763287AbYBFXM1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 18:12:27 -0500
In-Reply-To: <47AA38EF.6030307@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

On Wednesday, 6 of February 2008, matthieu castet wrote:
> Hi,

Hi,

> this patch had a check that the memory allocated is in the first 1MB.
> The check is similar to the one in smp_alloc_memory.
> 
> 
> Signed-off-by: "Matthieu CASTET <castet.matthieu@free.fr>"

Please don't attach patches if possible.  It's easier to comment them if they
are in the message body.

> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 6bc815c..65ab23c 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -65,6 +65,10 @@ void __init acpi_reserve_bootmem(void)
>  	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE*2);
>  	if (!acpi_wakeup_address)
>  		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
> +
> +	/* check if we are in first 1MB of memory */
> +	if (__pa(acpi_wakeup_address) >= 1024*1024-PAGE_SIZE*2)
> +		BUG();

I don't like this.

First, you should use BUG_ON(something) rather that "if (something) BUG();".

Second, and more importantly, it's enough to put "acpi_wakeup_address = 0"
to disable the feature without crashing the kernel.
Of course, I'd add an error message describing what's wrong to that.

>  }

Thanks,
Rafael

 





-- 
"Premature optimization is the root of all evil." - Donald Knuth
