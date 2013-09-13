From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio / ACPI: add support for GPIO operation regions
Date: Fri, 13 Sep 2013 20:36:15 +0300
Message-ID: <20130913173615.GG7393@intel.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
 <1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
 <CAHp75Vcec5MiGMUiusJhAmG6-R63OUZSXZPzafJzP6dC13Dgnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23112 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab3IMRat (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 13:30:49 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vcec5MiGMUiusJhAmG6-R63OUZSXZPzafJzP6dC13Dgnw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-acpi@vger.kernel.org

On Fri, Sep 13, 2013 at 06:55:11PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2013 at 6:14 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > GPIO operation regions is a new feature introduced in ACPI 5.0
> > specification. In practise it means that now ASL code can toggle GPIOs with
> > the help of the OS GPIO driver.
> 
> []
> 
> >  void acpi_gpiochip_add(struct gpio_chip *chip)
> >  {
> > +       struct acpi_gpio_chip_data *data;
> > +       acpi_handle handle;
> > +       acpi_status status;
> > +
> > +       handle = ACPI_HANDLE(chip->dev);
> > +       if (!handle)
> > +               return;
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> 
> May we use devm_kzalloc here?

The ACPI event handling code still uses kzalloc() and we need to call
acpi_gpiolib_remove() anyway (which undoes this), so I think we should
stick with kzalloc() now.
