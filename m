From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Warn if packages with invalid references are evaluated
Date: Tue, 11 Mar 2008 23:58:17 -0400
Message-ID: <200803112358.17466.lenb@kernel.org>
References: <1204842824.8741.6.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53263 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbYCLD6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 23:58:33 -0400
In-Reply-To: <1204842824.8741.6.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: ming.m.lin@intel.com, rui.zhang@intel.com, linux-acpi <linux-acpi@vger.kernel.org>

applied.

thanks,
-len

On Thursday 06 March 2008, Thomas Renninger wrote:
> Warn if packages with invalid references are evaluated
> 
> And return an error to avoid NULL pointer access.
> Lin Ming's patch avoids corrupted mem access when
> BIOS has invalid references included, the handle is now zero
> instead of corrupted.
> 
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> ---
> Index: linux-2.6.24/drivers/acpi/utils.c
> ===================================================================
> --- linux-2.6.24.orig/drivers/acpi/utils.c
> +++ linux-2.6.24/drivers/acpi/utils.c
> @@ -407,6 +407,12 @@ acpi_evaluate_reference(acpi_handle hand
>  			break;
>  		}
>  
> +		if (!element->reference.handle) {
> +			printk(KERN_WARNING PREFIX "Invalid reference in"
> +			       " package %s\n", pathname);
> +			status = AE_NULL_ENTRY;
> +			break;
> +		}
>  		/* Get the  acpi_handle. */
>  
>  		list->handles[i] = element->reference.handle;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


