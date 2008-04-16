From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 7/7] Who controls brightness functionality: vendor
	specific or generic video driver
Date: Wed, 16 Apr 2008 18:01:08 -0300
Message-ID: <20080416210108.GB3396@khazad-dum.debian.net>
References: <1208372572.1784.352.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58225 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540AbYDPVBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 17:01:15 -0400
Content-Disposition: inline
In-Reply-To: <1208372572.1784.352.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Mattia Dongili <malattia@linux.it>

On Wed, 16 Apr 2008, Thomas Renninger wrote:
> Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
> ===================================================================
> --- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/thinkpad_acpi.c
> +++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
> @@ -4381,6 +4381,13 @@ static int __init brightness_init(struct
>  			   "module parameter\n");
>  		return 1;
>  	} else if (brightness_enable > 1) {
> +		if ((acpi_video_support & ACPI_VIDEO_BRIGHTNESS) &&
> +		    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
> +			printk(TPACPI_INFO "Brightness ignored, must be "
> +			       "controlled by ACPI video driver\n");
> +			return 1;
> +		}
> +		/* Above, generic approach should make this check obsolete */
>  		if (brightness_check_std_acpi_support()) {
>  			printk(TPACPI_NOTICE
>  			       "standard ACPI backlight interface "

Ack.  But I am sure I will have to change this hunk a bit on
thinkpad-acpi 0.20.  This is not a big issue, and if you prefer, I can
handle adding the above support for thinkpad-acpi 0.20 since it is
likely going to be merged late due to its dependency on some stuff for
the LED class that needs to be in mainline first...

Otherwise, merging it now is also fine for acpi-test, and I will resend
the thinkpad-acpi queue adjusted accordingly.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
