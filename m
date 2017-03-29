From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 6/8] gpio: acpi: Explain how to get GPIO descriptors
 in ACPI case
Date: Wed, 29 Mar 2017 18:04:24 +0300
Message-ID: <1490799864.708.50.camel@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
         <20170323194618.26548-7-andriy.shevchenko@linux.intel.com>
         <20170323202838.GA11818@dtor-ws> <1490719163.708.40.camel@linux.intel.com>
         <20170329071235.GB38261@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329071235.GB38261@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2017-03-29 at 00:12 -0700, Dmitry Torokhov wrote:
> On Tue, Mar 28, 2017 at 07:39:23PM +0300, Andy Shevchenko wrote:
> > On Thu, 2017-03-23 at 13:28 -0700, Dmitry Torokhov wrote:
> > > On Thu, Mar 23, 2017 at 09:46:16PM +0200, Andy Shevchenko wrote:
> > 
> > 
> > > > +Using the _CRS fallback
> > > > +-----------------------
> > > > +
> > > > +If a device does not have _DSD or the driver does not create
> > > > ACPI
> > > > GPIO
> > > > +mapping, the Linux GPIO framework refuses to return any GPIOs.
> > > > This
> > > > is
> > > > +because the driver does not know what it actually gets. For
> > > > example
> > > > if we
> > > > +have a device like below:
> > > > +
> > > > +  Device (BTH)
> > > > +  {
> > > > +      Name (_HID, ...)
> > > > +
> > > > +      Name (_CRS, ResourceTemplate () {
> > > > +          GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
> > > > +                  "\\_SB.GPO0", 0, ResourceConsumer) {15}
> > > > +          GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
> > > > +                  "\\_SB.GPO0", 0, ResourceConsumer) {27}
> > > > +      })
> > > > +  }
> > > > +
> > > > +The driver might expect to get the right GPIO when it does:
> > > > +
> > > > +  desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > > > +
> > > > +but since there is no way to know the mapping between "reset"
> > > > and
> > > > +the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
> > > > +
> > > > +The driver author can solve this by passing the mapping
> > > > explictly
> > > > +(the recommended way and documented in the above chapter).
> > > 
> > > If the driver is not platform specific, then it would have no idea
> > > about
> > > mapping between _CRS GPIOs and names. All such stuff should be
> > > hidden
> > > in
> > > platform glue (i.e drivers/platform/x86/platform_crap.c).
> > 
> > It might be interpreted that all platform data from all the drivers
> > should gone. While ideal case should be like this and I totally
> > agree
> > with you, we are living in non-ideal world, that's why we used to
> > and
> > continue using some ID-based quirks (PCI enumeration, I2C
> > enumeration,
> > ACPI enumeration, SPI enumeration, UART enumeration, an so on, so
> > on).
> > 
> > Moreover ACPI comes into ARM(64) world which might have its own
> > troubles
> > with generating correct tables and we might end up with quirks
> > there.
> 
> *gasp* I thought ACPI was the magic that would fix all issues with
> cure
> embedded hacks.

In which version of the spec? I think ACPI r6.2 (anticipating soon)
would have solved a lot of issues regarding GPIO and pin configuration.

I also was and is thinking that ACPI has its own strong sides.

> > 
> > So, I disagree that here is possible to hide like you said "all such
> > stuff in ...platform_crap.c".
> 
> Well, Hans already posted such patch for select x86 platforms with
> Silead touchscreens. I am sure these platforms have more warts that
> could be added to the same file in platform/x86/...

So, do we agree on the following paragraph will be added to this
documentation?

"GPIO ACPI mapping tables should not contaminate drivers that are not
knowing about which exact device they are servicing on. It implies that
GPIO ACPI mapping tables are hardly linked to ACPI ID of the device in
question and their location is determined solely by location of the ACPI
ID table."

> > > > +
> > > > +Getting GPIO descriptor
> > > > +-----------------------
> > > > +
> > > > +There are two main approaches to get GPIO resource from ACPI:
> > > > +	desc = gpiod_get(dev, connection_id, flags);
> > > > +	desc = gpiod_get_index(dev, connection_id, index,
> > > > flags);
> > > > +
> > > > +We may consider two different cases here, i.e. when connection
> > > > ID
> > > > is
> > > > +provided and otherwise.
> > > > +
> > > > +Case 1:
> > > > +	desc = gpiod_get(dev, "non-null-connection-id", flags);
> > > > +	desc = gpiod_get_index(dev, "non-null-connection-id",
> > > > index, flags);
> > > > +
> > > > +Case 2:
> > > > +	desc = gpiod_get(dev, NULL, flags);
> > > > +	desc = gpiod_get_index(dev, NULL, index, flags);
> > > > +
> > > > +Case 1 assumes that corresponding ACPI device description must
> > > > have
> > > > +defined device properties and will prevent to getting any GPIO
> > > > resources
> > > > +otherwise.
> > > > +
> > > > +Case 2 explicitly tells GPIO core to look for resources in
> > > > _CRS.
> > > > +
> > > > +Be aware that gpiod_get_index() in cases 1 and 2, assuming that
> > > > there
> > > > +are two versions of ACPI device description provided and no
> > > > mapping
> > > > is
> > > > +present in the driver, will return different resources. That's
> > > > why
> > > > a
> > > > +certain driver has to handle them carefully as explained in
> > > > previous
> > > > +chapter.
> > > 
> > > I think that this wording is too x86-centric. We are talking about
> > > consumers of GPIOs here (i.e. drivers), which need unified
> > > behavior
> > > between ACPI, DT, and static board properties, they do not really
> > > care
> > > about _CRS or _DSD.
> > 
> > If the certain driver cares about ACPI enumerated devices it might
> > care
> > about supporting it disregarding on how new firmware is used
> > (supporting
> > _DSD or not).
> 
> The drivers might care about ACPI enumerations, but they do not care
> about warts of particular platform that chose to implement their ACPI
> tables with missing or invalid data. I say that such knowledge should
> not go into generic driver, but rather some other entity that woudl
> fix
> up whatever wrong the platform did. It could be an ACPI table
> override,
> or block of code in platform/x86/..., DT overlay, it does not really
> matter as long as we do not litter drivers with hacks for random
> boxes.

> Yes, we used to do that (DMI tables, etc), because there was no better
> alternative. Now that we have generic device properties, we have
> better
> ways of addressing these issues.

See above.

Otherwise I'm reading something like this:
"If we have platform driverX.c which has DT/platform and ACPI
enumeration, we must split ACPI part out, duplicate a lot of code and
use platform driver as a library."

Is that what you mean?

P.S. This all _CRS fallback shouldn't be allowed in the first place. Now
I'm trying to sort this crap out to nicely work with _DSD enabled
firmwares without breaking devices with *old* firmwares. I see no
other/better way to do such things and I'm open to any _example_ how it
can be done differently.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
