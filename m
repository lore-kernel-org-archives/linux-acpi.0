From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] platform/x86: depends instead of select for laptop
 platform drivers
Date: Wed, 25 Feb 2009 18:25:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902251823580.19092@localhost.localdomain>
References: <20090225000317.82c3c3a7.akpm@linux-foundation.org>
 <1235551029-28504-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54240 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbZBYXZy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 18:25:54 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN00231AEPP1TW@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Feb 2009 17:25:37 -0600 (CST)
In-reply-to: <1235551029-28504-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org



--
Len Brown, Intel Open Source Technology Center

On Wed, 25 Feb 2009, Corentin Chary wrote:

> "I hate `select' and will gleefully leap on any s/select/depends/ patch,
> whether it works or not :)"
>   Andrew Morton
> 
> select INPUT is not needed here, because if someone doesn't want INPUT,
> he won't want these drivers either.
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  drivers/platform/x86/Kconfig |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7a46ed8..8cd903c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -39,10 +39,10 @@ config ASUS_LAPTOP
>  	tristate "Asus Laptop Extras (EXPERIMENTAL)"
>  	depends on ACPI
>  	depends on EXPERIMENTAL && !ACPI_ASUS
> +	depends on INPUT
>  	select LEDS_CLASS
>  	select NEW_LEDS
>  	select BACKLIGHT_CLASS_DEVICE
> -	select INPUT
>  	---help---
>  	  This is the new Linux driver for Asus laptops. It may also support some
>  	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
> @@ -185,11 +185,11 @@ config SONYPI_COMPAT
>  config THINKPAD_ACPI
>  	tristate "ThinkPad ACPI Laptop Extras"
>  	depends on ACPI
> +	depends on INPUT
>  	select BACKLIGHT_LCD_SUPPORT
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	select NVRAM
> -	select INPUT
>  	select NEW_LEDS
>  	select LEDS_CLASS
>  	select NET

applied the thinkpad hunk above.
the other two were already handled previously.

all the drivers in that Kconfig now depend on INPUT, rather than selecting 
it

thanks,
Len Brown, Intel Open Source Technology Center

> @@ -307,7 +307,6 @@ config EEEPC_LAPTOP
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	select RFKILL
> -	select INPUT
>  	---help---
>  	  This driver supports the Fn-Fx keys on Eee PC laptops.
>  	  It also adds the ability to switch camera/wlan on/off.
> -- 
> 1.6.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
