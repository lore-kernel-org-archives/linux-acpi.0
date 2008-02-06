From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] check that acpi_wakeup_address is below 1MB
Date: Wed, 6 Feb 2008 23:56:36 +0100
Message-ID: <20080206225636.GC4316@elte.hu>
References: <47AA38EF.6030307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36128 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761319AbYBFW4s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 17:56:48 -0500
Content-Disposition: inline
In-Reply-To: <47AA38EF.6030307@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org


* matthieu castet <castet.matthieu@free.fr> wrote:

> Hi,
>
> this patch had a check that the memory allocated is in the first 1MB.
> The check is similar to the one in smp_alloc_memory.
>
>
> Signed-off-by: "Matthieu CASTET <castet.matthieu@free.fr>"

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

please never BUG() out unless totally unavoidable - especially in such 
early bootup code - that might prevent people from being able to report 
anything beyond 'my bootup hung'.

print a WARN_ON() (that way kerneloops.org can pick it up), and perhaps 
disable ACPI sleep functionality. BUG()-ing out is way too drastic and 
way too user-unfriendly.

	Ingo
