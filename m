From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/4] ACPI / gpio: Add support for naming GPIOs
Date: Sun, 9 Oct 2016 18:01:27 +0300
Message-ID: <20161009150127.GY30800@lahna.fi.intel.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
 <20160929133944.158596-3-mika.westerberg@linux.intel.com>
 <CAHp75Ve8QctOkt58tXeMpLTqeE5s_jTqjr7D46u41bXPg_NiBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbcJIPBh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Oct 2016 11:01:37 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Ve8QctOkt58tXeMpLTqeE5s_jTqjr7D46u41bXPg_NiBw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 07, 2016 at 08:05:14PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 29, 2016 at 4:39 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > DT has property 'gpio-line-names' to name GPIO lines the controller has if
> > present. Use this very same property in ACPI as well to provide nice names
> > for the GPIOS.
> 
> One nit below.
> 
> > @@ -835,6 +875,9 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
> >                 return;
> >         }
> >
> > +       if (!chip->names)
> > +               acpi_gpiochip_set_names(acpi_gpio);
> > +
> 
> I'm okay with this, though wouldn't be better to call it
> unconditionally like it's done for below call and move check inside?

DT does it like this. I can move the check inside the function as well.

> 
> >         acpi_gpiochip_request_regions(acpi_gpio);
> >         acpi_walk_dep_device_list(handle);
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
