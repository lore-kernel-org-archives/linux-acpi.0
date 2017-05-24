From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Wed, 24 May 2017 14:10:07 +0300
Message-ID: <1495624207.6967.90.camel@linux.intel.com>
References: <20170524075801.9152-1-hdegoede@redhat.com>
         <20170524075801.9152-2-hdegoede@redhat.com>
         <1495621671.6967.88.camel@linux.intel.com>
         <d271bc6b-995e-e850-c090-0975d4796907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:56536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763039AbdEXLNN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 07:13:13 -0400
In-Reply-To: <d271bc6b-995e-e850-c090-0975d4796907@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Wed, 2017-05-24 at 12:40 +0200, Hans de Goede wrote:
> On 24-05-17 12:27, Andy Shevchenko wrote:
> > On Wed, 2017-05-24 at 09:58 +0200, Hans de Goede wrote:

>>> +config GPIO_INT0002
> > > +	tristate "Intel ACPI INT0002 Virtual GPIO"
> > > +	depends on ACPI
> > 
> > && X86 (see below why)
> 
> This is part of:
> 
> menu "Port-mapped I/O GPIO drivers"
>          depends on X86 # Unconditional I/O space access
> 
> So that is already required, which is why I dropped it
> (previous versions did have it).

OK!

> > 
> > > +#include <asm/cpu_device_id.h>
> > > +#include <asm/intel-family.h>
> > 
> > Please, move this after <linux/*> headers with empty line in
> > between.
> 
> I'm using alphabetic sort for #includes, I don't see
> how these are special its not like they are "local" headers,
> e.g. drivers/gpio/gpio-aspeed.c does the same. What if this
> driver were to also need acpi/ headers should those go
> in their block too, etc. ?

Most of the drivers I saw are using such scheme

1. Most generic

2. Less generic

3. Local

<asm/*> category fits 2.

> > > +static int int0002_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	const struct x86_cpu_id *cpu_id;
> > > +	struct gpio_chip *chip;
> > > +	int i, irq, ret;
> > > +
> > > +	/* Menlow has a different INT0002 device? <sigh> */
> > 
> > Perhaps we can remove that all code. I will look at it when I have
> > spare
> > time.
> 
> Even if we remove the code for the INT0002 Menlow device we
> still don't want to bind to it, 

> or are you talking about
> dropping Menlow support in such a way that newer kernels
> will not boot on Menlow at all anymore ?

Latter.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
