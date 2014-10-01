From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 10:13:04 +0200
Message-ID: <2780318.hxubhI9Rvq@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan> <4835699.XutTNxriDg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59480 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaJAINL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 04:13:11 -0400
In-Reply-To: <4835699.XutTNxriDg@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wednesday 01 October 2014 04:17:02 Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/leds/leds-gpio.c
> ===================================================================
> --- linux-pm.orig/drivers/leds/leds-gpio.c
> +++ linux-pm/drivers/leds/leds-gpio.c
> @@ -231,6 +231,13 @@ static const struct of_device_id of_gpio
>  
>  MODULE_DEVICE_TABLE(of, of_gpio_leds_match);
>  
> +static const struct acpi_device_id acpi_gpio_leds_match[] = {
> +       { "PRP0001" }, /* Device Tree shoehorned into ACPI */
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, acpi_gpio_leds_match);
> +
>  static int gpio_led_probe(struct platform_device *pdev)
>  {
>         struct gpio_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
> @@ -286,6 +293,7 @@ static struct platform_driver gpio_led_d
>                 .name   = "leds-gpio",
>                 .owner  = THIS_MODULE,
>                 .of_match_table = of_gpio_leds_match,
> +               .acpi_match_table = acpi_gpio_leds_match,
>         },
>  };

Is this something you'd have to do in every driver you want to support
_PRP based probing? For the ".acpi_match_table =" reference, I think
you could actually provide a generic acpi_device_id table exported from
core code that you refer to, so each driver just does

	.acpi_match_table = acpi_match_by_of_compatible,

(or whatever you want to call it).

Regarding the MODULE_DEVICE_TABLE, I suspect the above won't work the
way you are hoping for, because once you get to dozens or hundreds of
drivers doing this, each device will show up with the same string,
so udev will try to load all the modules that list "PRP0001". That
doesn't look right. With the code from patch 3, you can probably drop
the acpi MODULE_DEVICE_TABLE() entirely and get the correct behavior.

	Arnd
