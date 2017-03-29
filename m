From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 4/8] gpio: acpi: Even more tighten up ACPI GPIO lookups
Date: Wed, 29 Mar 2017 00:04:47 -0700
Message-ID: <20170329070447.GA38261@dtor-ws>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
 <20170323194618.26548-5-andriy.shevchenko@linux.intel.com>
 <20170323201241.GB2502@dtor-ws>
 <1490718684.708.37.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490718684.708.37.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2017 at 07:31:24PM +0300, Andy Shevchenko wrote:
> On Thu, 2017-03-23 at 13:12 -0700, Dmitry Torokhov wrote:
> > On Thu, Mar 23, 2017 at 09:46:14PM +0200, Andy Shevchenko wrote:
> > > The commit 10cf4899f8af ("gpiolib: tighten up ACPI legacy gpio
> > > lookups")
> > > prevents to getting same resource twice if the driver asks twice
> > > using same
> > 
> > s/same/different/
> > 
> > > connection ID.
> 
> Oh, yeah, though it didn't fix a potential issue described below.
> 
> > > But the whole idea of fallback might bring some problems. Imagine
> > > the case when
> > > we have two versions of BIOS/hardware where in one _DSD is
> > > introduced along
> > > with GPIO resources, but the other one uses just plain GPIO resource
> > > for
> > > another purpose
> > > 
> > > Case 1:
> > > 
> > >     Device (DEVX)
> > >     {
> > >         ...
> > >         Name (_CRS, ResourceTemplate ()
> > >         {
> > >             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> > >                     "\\_SB.GPO0", 0, ResourceConsumer) {15}
> > >         })
> > >         Name (_DSD, Package ()
> > >         {
> > >             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >             Package ()
> > >             {
> > >                 Package () {"some-gpios", Package() {^DEVX, 0, 0, 0
> > > }},
> > >             }
> > >         })
> > >     }
> > > 
> > > Case 2:
> > > 
> > >     Device (DEVX)
> > >     {
> > >         ...
> > >         Name (_CRS, ResourceTemplate ()
> > >         {
> > >             GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> > >                     "\\_SB.GPO0", 0, ResourceConsumer) {27}
> > >         })
> > >     }
> > > 
> > > To prevent the possible misconfiguration tighten up even more ACPI
> > > GPIO lookups
> > > for case without connection ID provided.
> 
> > I wonder if this will break Goodix. Irina, Bastien?
> 
> It would be helpful if anyone can test it.
> 
> Btw, which particular driver do you have in mind that might be broken
> after such change? Ah, Goodix is a vendor of touchscreens, right?

Yes, and it uses named GPIOs.

-- 
Dmitry
