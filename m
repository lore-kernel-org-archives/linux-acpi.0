From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 02/10] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Fri, 14 Nov 2008 15:27:42 -0700
Message-ID: <200811141527.43427.bjorn.helgaas@hp.com>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217605083-31003-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:20875 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbYKNW2T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 17:28:19 -0500
In-Reply-To: <1217605083-31003-3-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Friday 01 August 2008 09:37:55 am Thomas Renninger wrote:
> @@ -1013,7 +983,7 @@ static void acpi_device_set_id(struct acpi_device *device,
>  		   will get autoloaded and the device might still match
>  		   against another driver.
>  		*/
> -		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
> +		if (acpi_is_video_device(device))
>  			cid_add = ACPI_VIDEO_HID;
>  		else if (ACPI_SUCCESS(acpi_bay_match(device)))
>  			cid_add = ACPI_BAY_HID;

It doesn't seem right to me to make this core behavior depend
on a config option.  With this approach, the ACPI device tree may
or may not contain an ACPI_VIDEO_HID device, depending on whether
CONFIG_ACPI_VIDEO is set, and that seems capricious.

What is the benefit of moving this code out of scan.c?  It's not
a very big function, and I think the consistency is worth the extra
code.

> +#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
> +
> +extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
> +extern long acpi_is_video_device(struct acpi_device *device);
> +extern int acpi_video_backlight_support(void);
> +extern int acpi_video_display_switch_support(void);
> +
> +#else
> +
> +static inline long acpi_video_get_capabilities(acpi_handle graphics_dev_handle)
> +{
> +	return 0;
> +}
> +
> +static inline long acpi_is_video_device(struct acpi_device *device)
> +{
> +	return 0;
> +}

