From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving
 this functionality
Date: Tue, 11 Nov 2008 15:04:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111331140.4480@localhost.localdomain>
References: <200811081637.45099.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:43314 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYKKUET (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 15:04:19 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA600435QF5LLA9@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 14:04:19 -0600 (CST)
In-reply-to: <200811081637.45099.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

This patch does what it is supposed to do, but it isn't clear
if that is a step forward.

I have satellite pro (original centrino about 4 years old)
where toshiba-acpi exports 8 brightness levels,
and acpi exports just 3 (min, 40%, max)

so when i apply this patch, i get fewer brightness levels.
I prefer to have all 8 brightness levels.

-Len

On Sat, 8 Nov 2008, Andrey Borzenkov wrote:

> Subject: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
> From: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> ---
> 
> This completes backlight series; toshiba_acpi was missing.
> 
>  drivers/acpi/toshiba_acpi.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
> index a7db0c2..c140709 100644
> --- a/drivers/acpi/toshiba_acpi.c
> +++ b/drivers/acpi/toshiba_acpi.c
> @@ -780,19 +780,20 @@ static int __init toshiba_acpi_init(void)
>  		}
>  	}
>  
> -	toshiba_backlight_device = backlight_device_register("toshiba",
> +	if (!acpi_video_backlight_support()) {
> +		toshiba_backlight_device = backlight_device_register("toshiba",
>  						&toshiba_acpi.p_dev->dev,
>  						NULL,
>  						&toshiba_backlight_data);
> -        if (IS_ERR(toshiba_backlight_device)) {
> -		ret = PTR_ERR(toshiba_backlight_device);
> -
> -		printk(KERN_ERR "Could not register toshiba backlight device\n");
> -		toshiba_backlight_device = NULL;
> -		toshiba_acpi_exit();
> -		return ret;
> +		if (IS_ERR(toshiba_backlight_device)) {
> +			ret = PTR_ERR(toshiba_backlight_device);
> +			printk(KERN_ERR "Could not register toshiba backlight device\n");
> +			toshiba_backlight_device = NULL;
> +			toshiba_acpi_exit();
> +			return ret;
> +		}
> +		toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
>  	}
> -        toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
>  
>  	/* Register rfkill switch for Bluetooth */
>  	if (hci_get_bt_present(&bt_present) == HCI_SUCCESS && bt_present) {
> 
