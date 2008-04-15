From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Wed, 16 Apr 2008 08:42:29 +0930 (CST)
Message-ID: <200804152312.m3FNCTHM022350@turbo.physics.adelaide.edu.au>
References: <1208252200.20860.9.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:45611 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbYDOXMe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 19:12:34 -0400
In-Reply-To: <1208252200.20860.9.camel@earth.gruber.myown> from "nokos@gmx.net" at Apr 15, 2008 11:36:40 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: linux-acpi@vger.kernel.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

> Here is a modularized version of the patch, it also includes autodetection
> of S6410 to switch between the brightness interface (can be overridden by
> module parameter)
> 
> Jonathan can you test it if it doesn't break anything on the S7020?

Will do.  A comment on the patch - there seems to be a fair number of
seemingly cosmetic and unnecessary whitespace/ordering changes.  Perhaps try
to minimise these as it makes the true impact of the patch much clearer
and thus easier to evaluate and work with.

For example:

> diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
> index e2e7c05..9a80d29 100644
> --- a/drivers/misc/fujitsu-laptop.c
> +++ b/drivers/misc/fujitsu-laptop.c
> @@ -2,6 +2,7 @@
:
> @@ -56,21 +65,36 @@
>  #define FUJITSU_LCD_N_LEVELS 8
>  
>  #define ACPI_FUJITSU_CLASS              "fujitsu"
> -#define ACPI_FUJITSU_HID                "FUJ02B1"
> -#define ACPI_FUJITSU_DRIVER_NAME        "Fujitsu laptop FUJ02B1 ACPI extras driver"
> -#define ACPI_FUJITSU_DEVICE_NAME        "Fujitsu FUJ02B1"
> +
> +#define ACPI_FUJITSUB1_DRIVER_NAME        "Fujitsu laptop ACPI extras driver"
> +#define ACPI_FUJITSUB1_HID                "FUJ02B1"
> +#define ACPI_FUJITSUB1_DEVICE_NAME        "Fujitsu FUJ02B1"

As far as I can tell all you've really changed here is
ACPI_FUJITSU_DRIVER_NAME, yet ACPI_FUJITSUB1_HID and
ACPI_FUJITSUB1_DEVICE_NAME are also flagged as changed.

Another one:

>  	status =
> -	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> +	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL,
> +				  &state);

Even though the acpi_evaluate_integer() call hasn't been altered it appears
in the patch due to a minor and unneeded formatting change.

Regards
  jonathan
