From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: use _STA bit names rather than 0x0F
Date: Wed, 25 Apr 2007 14:21:04 -0400
Message-ID: <200704251421.04766.lenb@kernel.org>
References: <200704201056.51472.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54471 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423372AbXDYSXA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 14:23:00 -0400
In-Reply-To: <200704201056.51472.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Applied.

thanks,
-Len

On Friday 20 April 2007 12:56, Bjorn Helgaas wrote:
> Be explicit about what "device->status = 0x0F" really means.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: w/drivers/acpi/scan.c
> ===================================================================
> --- w.orig/drivers/acpi/scan.c	2007-04-19 21:35:42.000000000 -0600
> +++ w/drivers/acpi/scan.c	2007-04-19 21:36:50.000000000 -0600
> @@ -1068,7 +1068,9 @@
>  		}
>  		break;
>  	default:
> -		STRUCT_TO_INT(device->status) = 0x0F;
> +		STRUCT_TO_INT(device->status) =
> +		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
> +		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
>  		break;
>  	}
>  
> Index: w/drivers/acpi/bus.c
> ===================================================================
> --- w.orig/drivers/acpi/bus.c	2007-04-19 21:35:42.000000000 -0600
> +++ w/drivers/acpi/bus.c	2007-04-19 21:37:52.000000000 -0600
> @@ -103,7 +103,9 @@
>  	else if (device->parent)
>  		device->status = device->parent->status;
>  	else
> -		STRUCT_TO_INT(device->status) = 0x0F;
> +		STRUCT_TO_INT(device->status) =
> +		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
> +		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
>  
>  	if (device->status.functional && !device->status.present) {
>  		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
> 
