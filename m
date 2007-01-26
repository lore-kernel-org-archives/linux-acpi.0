From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/7] asus-laptop: add backlight support
Date: Fri, 26 Jan 2007 02:46:21 -0500
Message-ID: <200701260246.21515.lenb@kernel.org>
References: <200701251254.50198.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37991 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030834AbXAZHxl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 02:53:41 -0500
In-Reply-To: <200701251254.50198.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> Add backlight support using backlight class. We now change the brightness
> *and toggle the backlight !* via /sys/class/backlight/asus-laptop/ .
> 
> If the user switch the backlight using the keyboard, asus_hotk_notify looks for
> ATKD_LCD_OFF and ATKD_LCD_ON events, and store the right state into hotk->status
> and bd->props->power .
> 
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>  Kconfig       |    1
>  asus-laptop.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-

> diff -Naur a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> --- a/drivers/misc/Kconfig	2007-01-21 15:29:27.000000000 +0100
> +++ b/drivers/misc/Kconfig	2007-01-21 15:34:26.000000000 +0100
> @@ -75,6 +75,7 @@
>          depends on ACPI
>  	depends on EXPERIMENTAL && !ASUS_ACPI
>  	select LEDS_CLASS
> +	select BACKLIGHT_CLASS_DEVICE

wups, my message about LED  CLASS was garbled.
What I should have written is:

Both of these select's should be "depends on"
select is generally considered evil and should be avoided if at all possible.

>          ---help---
>  	  This is the new Linux driver for Asus laptops. It may also support some
>  	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
> 
