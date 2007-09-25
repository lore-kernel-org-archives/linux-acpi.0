From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND] ACPI video: guess flags for devices with
	non-standard addressing
Date: Tue, 25 Sep 2007 09:53:53 +0800
Message-ID: <1190685233.26892.13.camel@acpi-hp.sh.intel.com>
References: <20070617000215.ADA8D7B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21725 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835AbXIYBse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2007 21:48:34 -0400
In-Reply-To: <20070617000215.ADA8D7B409F@zog.reactivated.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, hmh@hmh.eng.br

On Sun, 2007-06-17 at 08:02 +0800, Daniel Drake wrote:
> Dell laptops seem to address video devices without the
> device_id_scheme bit,
> which means that Linux doesn't know the device types of the video
> devices.
> 
> This patch makes the ACPI video driver guess the device type based on
> the
> device name for devices which do not have the device_id_scheme set.
> This
> fixes the flags field for all 4 of my video devices on this laptop
> (Inspiron 640m).

> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> Index: linux/drivers/acpi/video.c
> ===================================================================
> --- linux.orig/drivers/acpi/video.c
> +++ linux/drivers/acpi/video.c
> @@ -1343,26 +1343,46 @@ acpi_video_bus_get_one_device(struct acp
> 
>                 attribute = acpi_video_get_device_attr(video,
> device_id);
> 
> -               if((attribute != NULL) && attribute->device_id_scheme)
> {
> -                       switch (attribute->display_type) {
> -                       case ACPI_VIDEO_DISPLAY_CRT:
> -                               data->flags.crt = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_TV:
> -                               data->flags.tvout = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_DVI:
> -                               data->flags.dvi = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_LCD:
> -                               data->flags.lcd = 1;
> -                               break;
> -                       default:
> -                               data->flags.unknown = 1;
> -                               break;
> +               if (attribute) {
> +                       if (!attribute->device_id_scheme) {
> +                               char *name = acpi_device_bid(device);
> +
> +                               /* Dell laptops seem to follow
> standard video
> +                                * device addressing but do not set
> the
> +                                * device_id_scheme bit.
> +                                * Guess the flags based on the device
> names.
> +                                */
> +                               if (strcmp(name, "CRT") == 0)
> +                                       data->flags.crt = 1;
Thinkpad laptops don't set the device_id_scheme bit as well.
And they use LCD0/CRT0/TV0/DVI0 as the device name.
can we use strncmp(name, "CRT", 3) here?

> +                               else if (strcmp(name, "TV") == 0)
> +                                       data->flags.tvout = 1;
> +                               else if (strcmp(name, "DVI") == 0)
> +                                       data->flags.dvi = 1;
> +                               else if (strcmp(name, "LCD") == 0)
> +                                       data->flags.lcd = 1;
ditto
> +                               else
> +                                       data->flags.unknown = 1;
> +                       } else {
> +                               switch (attribute->display_type) {
> +                               case ACPI_VIDEO_DISPLAY_CRT:
> +                                       data->flags.crt = 1;
> +                                       break;
> +                               case ACPI_VIDEO_DISPLAY_TV:
> +                                       data->flags.tvout = 1;
> +                                       break;
> +                               case ACPI_VIDEO_DISPLAY_DVI:
> +                                       data->flags.dvi = 1;
> +                                       break;
> +                               case ACPI_VIDEO_DISPLAY_LCD:
> +                                       data->flags.lcd = 1;
> +                                       break;
> +                               default:
> +                                       data->flags.unknown = 1;
> +                                       break;
> +                               }
> +                               if(attribute->bios_can_detect)
> +                                       data->flags.bios = 1;
>                         }
> -                       if(attribute->bios_can_detect)
> -                               data->flags.bios = 1;
>                 } else
>                         data->flags.unknown = 1;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
