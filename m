From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4] asus-laptop: use select instead of depends on
Date: Wed, 25 Feb 2009 18:19:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902251817300.19092@localhost.localdomain>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-5-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:43009 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653AbZBYXTi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 18:19:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN00LZ4A3YMQH7@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Feb 2009 17:19:16 -0600 (CST)
In-reply-to: <1234722621-14498-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org


On Sun, 15 Feb 2009, Corentin Chary wrote:

> Like thinkpad_acpi or eeepc-laptop, asus-laptop will
> now use "select" instead of "depends on".
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  drivers/platform/x86/Kconfig |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6f46bc6..000a4b7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -39,10 +39,10 @@ config ASUS_LAPTOP
>  	tristate "Asus Laptop Extras (EXPERIMENTAL)"
>  	depends on ACPI
>  	depends on EXPERIMENTAL && !ACPI_ASUS
> -	depends on LEDS_CLASS
> -	depends on NEW_LEDS
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	depends on INPUT
> +	select LEDS_CLASS
> +	select NEW_LEDS

okay, i guess that is more consistent (except for ACER)

> +	select BACKLIGHT_CLASS_DEVICE

this one is a little less consistent

I should probably just whack the file to make all the drivers
do exactly the same thing with these...

> +	select INPUT

switched thta one back to "depends on INPUT"

applied.
thanks,
-Len Brown, Intel Opoen Source Technology Center

>  	---help---
>  	  This is the new Linux driver for Asus laptops. It may also support some
>  	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
> -- 
> 1.6.1.2
> 
> 
