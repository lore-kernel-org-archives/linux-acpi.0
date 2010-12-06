From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 6/7] ACPI video: introduce module parameter
 video.use_bios_initial_backlight
Date: Mon, 6 Dec 2010 08:03:40 -0800
Message-ID: <20101206080340.8773aee3.randy.dunlap@oracle.com>
References: <1291619067.19296.580.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:65039 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0LFQFA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2010 11:05:00 -0500
In-Reply-To: <1291619067.19296.580.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Mon, 06 Dec 2010 15:04:27 +0800 Zhang Rui wrote:

> 
> Introduce module parameter video.use_bios_initial_backlight.
> 
> Some BIOSes claim they use the minimum backlight at boot,
> and this may bring dimming screen after boot.
> https://bugzilla.kernel.org/show_bug.cgi?id=21212
> 
> use video.use_bios_initl_backlight=0 to use
> the maximum backlight level after boot.

Hi,
Where is this documented?


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
> --


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
