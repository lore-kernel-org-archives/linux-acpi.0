From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] video: add quirk table for video backlight vendor mode
Date: Mon, 19 Mar 2012 13:31:29 +0000
Message-ID: <20120319133129.GA413@srcf.ucam.org>
References: <1332137027-28327-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50176 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758852Ab2CSNbg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 09:31:36 -0400
Content-Disposition: inline
In-Reply-To: <1332137027-28327-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Thomas Renninger <trenn@suse.de>

On Mon, Mar 19, 2012 at 02:03:47PM +0800, Lee, Chun-Yi wrote:

> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index f3f0fe7..acb15d6 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -132,6 +132,32 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
>  	return AE_OK;
>  }
>  
> +static int video_set_backlight_vendor(const struct dmi_system_id *d)
> +{
> +	acpi_video_support |= ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
> +	return 0;
> +}
> +
> +static const struct dmi_system_id video_vendor_dmi_table[] = {
> +	{
> +	 .callback = video_set_backlight_vendor,
> +	 .ident = "Acer Aspire 4736",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 4736"),
> +		},
> +	},
> +	{
> +	 .callback = video_set_backlight_vendor,
> +	 .ident = "Acer TravelMate 4750",
> +	 .matches = {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4750"),
> +		},
> +	},
> +	{}
> +};
> +

I think it would be neater to put this in the Acer driver and have it 
call unregister_acpi_video().

-- 
Matthew Garrett | mjg59@srcf.ucam.org
