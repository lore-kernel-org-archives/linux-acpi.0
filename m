From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/7] ACPI video: introduce module parameter
 video.use_bios_initial_backlight
Date: Tue, 14 Dec 2010 00:10:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012140006400.23573@x980>
References: <1291619067.19296.580.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:33029 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0LNFKd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 00:10:33 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDE00HWCJPAKTO2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 23:10:23 -0600 (CST)
In-reply-to: <1291619067.19296.580.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Mon, 6 Dec 2010, Zhang Rui wrote:

> 
> Introduce module parameter video.use_bios_initial_backlight.

there must be a more concise way to say that...

> Some BIOSes claim they use the minimum backlight at boot,
> and this may bring dimming screen after boot.
> https://bugzilla.kernel.org/show_bug.cgi?id=21212
> 
> use video.use_bios_initl_backlight=0 to use
> the maximum backlight level after boot.

this looks like a BIOS workaround.
should there be a way to invoke this workaround automatically?

thanks,
-Len

> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -80,6 +80,13 @@ module_param(brightness_switch_enabled, 
>  static int allow_duplicates;
>  module_param(allow_duplicates, bool, 0644);
>  
> +/*
> + * Some BIOSes claim they use minimum backlight at boot,
> + * and this may bring dimming screen after boot
> + */
> +static int use_bios_initial_backlight = 1;
> +module_param(use_bios_initial_backlight, bool, 0644);
> +
>  static int register_count = 0;
>  static int acpi_video_bus_add(struct acpi_device *device);
>  static int acpi_video_bus_remove(struct acpi_device *device, int type);
> @@ -705,9 +712,11 @@ acpi_video_init_brightness(struct acpi_v
>  		 * when invoked for the first time, i.e. level_old is invalid.
>  		 * set the backlight to max_level in this case
>  		 */
> -		for (i = 2; i < br->count; i++)
> -			if (level_old == br->levels[i])
> -				level = level_old;
> +		if (use_bios_initial_backlight) {
> +			for (i = 2; i < br->count; i++)
> +				if (level_old == br->levels[i])
> +					level = level_old;
> +		}
>  		goto set_level;
>  	}
>  
> 
> 
