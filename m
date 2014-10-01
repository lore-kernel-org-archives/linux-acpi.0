From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 1 Oct 2014 09:30:25 -0700
Message-ID: <20141001163025.GE23115@dtor-glaptop>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1852462.V1jlbi8OPt@vostro.rjw.lan>
 <4835699.XutTNxriDg@vostro.rjw.lan>
 <2780318.hxubhI9Rvq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40713 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaJAQa3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 12:30:29 -0400
Content-Disposition: inline
In-Reply-To: <2780318.hxubhI9Rvq@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wed, Oct 01, 2014 at 10:13:04AM +0200, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 04:17:02 Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/leds/leds-gpio.c
> > ===================================================================
> > --- linux-pm.orig/drivers/leds/leds-gpio.c
> > +++ linux-pm/drivers/leds/leds-gpio.c
> > @@ -231,6 +231,13 @@ static const struct of_device_id of_gpio
> >  
> >  MODULE_DEVICE_TABLE(of, of_gpio_leds_match);
> >  
> > +static const struct acpi_device_id acpi_gpio_leds_match[] = {
> > +       { "PRP0001" }, /* Device Tree shoehorned into ACPI */
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(acpi, acpi_gpio_leds_match);
> > +
> >  static int gpio_led_probe(struct platform_device *pdev)
> >  {
> >         struct gpio_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > @@ -286,6 +293,7 @@ static struct platform_driver gpio_led_d
> >                 .name   = "leds-gpio",
> >                 .owner  = THIS_MODULE,
> >                 .of_match_table = of_gpio_leds_match,
> > +               .acpi_match_table = acpi_gpio_leds_match,
> >         },
> >  };
> 
> Is this something you'd have to do in every driver you want to support
> _PRP based probing? For the ".acpi_match_table =" reference, I think
> you could actually provide a generic acpi_device_id table exported from
> core code that you refer to, so each driver just does
> 
> 	.acpi_match_table = acpi_match_by_of_compatible,

No, I think in absence of drv->acpi_match_table ACPI core should just go and
use drv->of_match_table to do the matching and be done with it.

Thanks.

-- 
Dmitry
