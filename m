From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 4/8] gpio: acpi: Even more tighten up ACPI GPIO
 lookups
Date: Tue, 28 Mar 2017 19:31:24 +0300
Message-ID: <1490718684.708.37.camel@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
         <20170323194618.26548-5-andriy.shevchenko@linux.intel.com>
         <20170323201241.GB2502@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170323201241.GB2502@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2017-03-23 at 13:12 -0700, Dmitry Torokhov wrote:
> On Thu, Mar 23, 2017 at 09:46:14PM +0200, Andy Shevchenko wrote:
> > The commit 10cf4899f8af ("gpiolib: tighten up ACPI legacy gpio
> > lookups")
> > prevents to getting same resource twice if the driver asks twice
> > using same
> 
> s/same/different/
> 
> > connection ID.

Oh, yeah, though it didn't fix a potential issue described below.

> > But the whole idea of fallback might bring some problems. Imagine
> > the case when
> > we have two versions of BIOS/hardware where in one _DSD is
> > introduced along
> > with GPIO resources, but the other one uses just plain GPIO resource
> > for
> > another purpose
> > 
> > Case 1:
> > 
> >     Device (DEVX)
> >     {
> >         ...
> >         Name (_CRS, ResourceTemplate ()
> >         {
> >             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> >                     "\\_SB.GPO0", 0, ResourceConsumer) {15}
> >         })
> >         Name (_DSD, Package ()
> >         {
> >             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >             Package ()
> >             {
> >                 Package () {"some-gpios", Package() {^DEVX, 0, 0, 0
> > }},
> >             }
> >         })
> >     }
> > 
> > Case 2:
> > 
> >     Device (DEVX)
> >     {
> >         ...
> >         Name (_CRS, ResourceTemplate ()
> >         {
> >             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> >                     "\\_SB.GPO0", 0, ResourceConsumer) {27}
> >         })
> >     }
> > 
> > To prevent the possible misconfiguration tighten up even more ACPI
> > GPIO lookups
> > for case without connection ID provided.

> I wonder if this will break Goodix. Irina, Bastien?

It would be helpful if anyone can test it.

Btw, which particular driver do you have in mind that might be broken
after such change? Ah, Goodix is a vendor of touchscreens, right?

I'm going through drivers which are using ACPI enumeration and
gpiod_get() API to create mapping tables. I didn't touch drivers/input/
folder yet.

So, potential problems might be there:

drivers/input/touchscreen/elants_i2c.c
drivers/input/touchscreen/goodix.c
drivers/input/touchscreen/melfas_mip4.c
drivers/input/touchscreen/raydium_i2c_ts.c
drivers/input/touchscreen/silead.c
drivers/input/touchscreen/surface3_spi.c

(except silead which Hans tested few times)

> > In the past the issue had been triggered by "use mctrl_gpio helpers"
> > series
> > [1,2].
> > 
> > Besides above, removal of the main logic of
> > acpi_can_fallback_to_crs()
> > eliminates a potential memory leak when the same device has been
> > unbound and
> > bound again.
> 
> Where? We'll reuse lookup table as ACPI device is still the same.

I used to have issues with unbind/bind cycle with pointer to struct
device * (IIRC platform device), but you probably right since pointer to
struct acpi_device is used here in your change.

I will remove this paragraph from commit message.

Thanks for review!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
