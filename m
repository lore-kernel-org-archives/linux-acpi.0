From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] gpio / ACPI: register to ACPI events automatically
Date: Mon, 23 Sep 2013 13:52:18 +0300
Message-ID: <20130923105218.GD28875@intel.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdZ4WNmt5ZO_+Wtpm0+GD4EMAK5VscV-cTN+43heF17FJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56845 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab3IWKqv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Sep 2013 06:46:51 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZ4WNmt5ZO_+Wtpm0+GD4EMAK5VscV-cTN+43heF17FJg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Sep 20, 2013 at 09:08:57PM +0200, Linus Walleij wrote:
> On Fri, Sep 13, 2013 at 5:14 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > Instead of asking each driver to register to the ACPI events we can just
> > call acpi_gpiochip_register_interrupts() for each chip that has ACPI
> > handle. It checks chip->to_irq and if it is set to NULL (a GPIO driver that
> > doesn't do interrupts) the function does nothing.
> >
> > Also make the event interface to be private to gpiolib-acpi and remove call
> > to the API from the one existing user (pinctrl-baytrail.c).
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> The concept looks sane...
> 
> > +void acpi_gpiochip_add(struct gpio_chip *chip)
> > +{
> > +       acpi_gpiochip_request_interrupts(chip);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_gpiochip_add);
> > +
> > +void acpi_gpiochip_remove(struct gpio_chip *chip)
> > +{
> > +       acpi_gpiochip_free_interrupts(chip);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_gpiochip_remove);
> 
> If you're only going to call this from within gpiolib, why are
> you EXPORTing the APIs?
> 
> I think we should maybe create drivers/gpio/gpiolib.h
> for such subsystem-local headers.

Good point. Will do that in the next version.

> > @@ -1221,6 +1222,7 @@ int gpiochip_add(struct gpio_chip *chip)
> >  #endif
> >
> >         of_gpiochip_add(chip);
> > +       acpi_gpiochip_add(chip);
> >
> >         if (status)
> >                 goto fail;
> > @@ -1262,6 +1264,7 @@ int gpiochip_remove(struct gpio_chip *chip)
> >
> >         gpiochip_remove_pin_ranges(chip);
> >         of_gpiochip_remove(chip);
> > +       acpi_gpiochip_remove(chip);
> 
> What happens on a platform that is not using CONFIG_GPIO_ACPI
> when they try to compile this?
> 
> You forgot to add static inline stubs for the non-ACPI case.

This patch adds them to <linux/acpi_gpio.h> which is included from
gpiolib.c.
