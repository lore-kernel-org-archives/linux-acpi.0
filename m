From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] Warn if packages with invalid references are evaluated
Date: Fri, 07 Mar 2008 09:33:43 +0800
Message-ID: <1204853623.14599.1.camel@minggr.sh.intel.com>
References: <1204842824.8741.6.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32894 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758184AbYCGBgf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2008 20:36:35 -0500
In-Reply-To: <1204842824.8741.6.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: rui.zhang@intel.com, linux-acpi <linux-acpi@vger.kernel.org>


On Thu, 2008-03-06 at 23:33 +0100, Thomas Renninger wrote:
> Warn if packages with invalid references are evaluated
> 
> And return an error to avoid NULL pointer access.
> Lin Ming's patch avoids corrupted mem access when
> BIOS has invalid references included, the handle is now zero
> instead of corrupted.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Thanks,
Lin Ming
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

