From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] disable _BQC/_BCQ if it returns invalid values
Date: Thu, 09 Jul 2009 08:57:31 +0800
Message-ID: <1247101051.15520.194.camel@rzhang-dt>
References: <4A54FE96.2030407@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31885 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470AbZGIA4o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jul 2009 20:56:44 -0400
In-Reply-To: <4A54FE96.2030407@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-07-09 at 04:16 +0800, Hector Martin wrote:
> Validate the result of the _BQC or _BCQ method when querying the current
> backlight level. If the value is out of range, the support for this
> method is disabled. This does not break functionality as long as the
> hardware doesn't touch the backlight level on it own, since the driver
> will just use the last cached value.
> 
> Acer Aspire 8930G with BIOS v1.10 (latest) has this issue.
> 
> Signed-off-by: Hector Martin <hector@marcansoft.com>
> --- linux-2.6.30/drivers/acpi/video.c	2009-07-08 22:04:54.000000000 +0200
> +++ linux-2.6.30-mod/drivers/acpi/video.c	2009-07-08 22:12:19.000000000 +0200
> @@ -602,15 +605,29 @@ acpi_video_device_lcd_get_level_current(
>  						NULL, level);
>  		if (ACPI_SUCCESS(status)) {
>  			if (device->brightness->flags._BQC_use_index) {
> +				if (*level >= (device->brightness->count - 2)) {
> +					ACPI_WARNING((AE_INFO,
> +						"%s is broken (returned %llu)",
> +						buf, *level));
> +					device->cap._BQC = device->cap._BCQ = 0;
> +					*level = device->brightness->curr;
> +					return 0;
> +				}
>  				if (device->brightness->flags._BCL_reversed)
>  					*level = device->brightness->count
>  								 - 3 - (*level);
>  				*level = device->brightness->levels[*level + 2];
>  
>  			}
> -			*level += bqc_offset_aml_bug_workaround;
> -			device->brightness->curr = *level;
> -			return 0;
> +			if (*level > 100) {
> +				ACPI_WARNING((AE_INFO, "%s is broken "
> +					"(returned %llu)", buf, *level));
_BQC returns a value larger than 100?
is this true on your laptop?

thanks,
rui

> +				device->cap._BQC = device->cap._BCQ = 0;
> +			} else {
> +				*level += bqc_offset_aml_bug_workaround;
> +				device->brightness->curr = *level;
> +				return 0;
> +			}
>  		} else {
>  			/* Fixme:
>  			 * should we return an error or ignore this failure?
> 
> 

