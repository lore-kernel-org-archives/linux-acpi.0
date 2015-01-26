From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Mon, 26 Jan 2015 15:06:47 +0200
Message-ID: <20150126130647.GC28539@kuha.fi.intel.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1564228.rcRekIyDUd@vostro.rjw.lan>
 <20150123112122.GD30522@kuha.fi.intel.com>
 <4300012.3cqZ9mP0gj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4300012.3cqZ9mP0gj@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 23, 2015 at 04:14:13PM +0100, Rafael J. Wysocki wrote:
> > That actually makes me think that we could then drop the lookup tables
> > completely and use device properties instead with the help of "generic
> > property" (attached):
> 
> Which reminds me that I've lost track of this one.
> 
> Can you please resend it and CC something like linux-acpi?

OK, I'll resend it.

> Also I'm not sure what you mean by "drop the lookup tables completely".

So I meant removing struct gpio_lookup and struct gpio_lookup_table.

> > We would just need to agree on the format how to describe a gpio
> > property, document it and of course convert the current users as
> > usual. The format could be something like this as an example (I'm
> > writing this out of my head so don't shoot me if you can see it would
> > not work. Just an example):
> > 
> > static const u32 example_gpio[] = { <gpio>, <flags>, };
> > 
> > static struct dev_gen_prop example_prop[] =
> >         {
> >                 .type = DEV_PROP_U32,
> >                 .name = "gpio,<con_id>",
> >                 .nval = 2,
> >                 .num = &example_gpio,
> >         },
> >         { },
> > };
> > 
> > static struct platform_device example_pdev = {
> >         ...
> >         .dev = {
> >                 .gen_prop = &example_prop,
> >         },
> > }
> > 
> > 
> > In gpiolib.c we would then, instead of going through the lookups,
> > simply ask for that property:
> > 
> >         ...
> >         sprintf(propname, "gpio,%s", con_id);
> >         device_property_read_u32_array(dev, propname, &val, 2);
> >         ...
> >         desc = gpio_to_desc(val[0]);
> >         flags = val[1];
> >         ...
> > 
> > 
> > So this is just and idea. I think it would be relatively easy to
> > implement. What do you guys think?
> 
> Well, I need some time to think about that.


Cheers,

-- 
heikki
