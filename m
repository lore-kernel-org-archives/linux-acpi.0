From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/7] asus-laptop: add led support
Date: Fri, 26 Jan 2007 02:43:25 -0500
Message-ID: <200701260243.25372.lenb@kernel.org>
References: <200701251254.43674.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37923 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030793AbXAZHuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 02:50:46 -0500
In-Reply-To: <200701251254.43674.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> Add led support, using generic led class.
> Thomas Tuttle's patch <http://lkml.org/lkml/2006/7/6/247> was very usefull.
> We use hotk->status to store led status because it's very hard to find acpi method
> to get the right status...
> To reduce the code, I use a lot of macro (ASUS_LED, ASUS_LED_REGISTER, etc ...), because
> the code is the same for all leds ...
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>  Kconfig       |    1
>  asus-laptop.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 147 insertions(+)
> ---
> 
> diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
...
> diff -Naur a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> --- a/drivers/misc/Kconfig	2007-01-21 15:27:49.000000000 +0100
> +++ b/drivers/misc/Kconfig	2007-01-21 15:24:26.000000000 +0100
> @@ -74,6 +74,7 @@
>          depends on X86
>          depends on ACPI
>  	depends on EXPERIMENTAL && !ASUS_ACPI
> +	select LEDS_CLASS

Why isn't this depends on BACKLIGHT_CLASS_DEVICE
like msi-laptop?

>          ---help---
>  	  This is the new Linux driver for Asus laptops. It may also support some
>  	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
> 
