From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/6] ACPI EC: remove potential deadlock from EC
Date: Sat, 11 Aug 2007 22:27:03 -0400
Message-ID: <200708112227.04045.lenb@kernel.org>
References: <200708102045.l7AKjJ0m007836@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34429 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756962AbXHLC1L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2007 22:27:11 -0400
In-Reply-To: <200708102045.l7AKjJ0m007836@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Applied
(with From: e-mail address typo fixed)

thanks,
-Len

On Friday 10 August 2007 16:45, akpm@linux-foundation.org wrote:
> From: Alexey Starikovskiy <astarikivskiy@suse.de>
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/ec.c |    2 --
>  1 files changed, 2 deletions(-)
> 
> diff -puN drivers/acpi/ec.c~acpi-ec-remove-potential-deadlock-from-ec drivers/acpi/ec.c
> --- a/drivers/acpi/ec.c~acpi-ec-remove-potential-deadlock-from-ec
> +++ a/drivers/acpi/ec.c
> @@ -710,9 +710,7 @@ static int acpi_ec_add(struct acpi_devic
>  	/* Check if we found the boot EC */
>  	if (boot_ec) {
>  		if (boot_ec->gpe == ec->gpe) {
> -			mutex_lock(&boot_ec->lock);
>  			ec_remove_handlers(boot_ec);
> -			mutex_unlock(&boot_ec->lock);
>  			mutex_destroy(&boot_ec->lock);
>  			kfree(boot_ec);
>  			first_ec = boot_ec = NULL;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
