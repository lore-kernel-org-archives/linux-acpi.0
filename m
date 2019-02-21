From: Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date: Thu, 21 Feb 2019 10:58:15 -0800
Message-ID: <CAPR809uFwmg8GUPbT81tNooDpKQD2oZ2UqsTGwYH--Jh_CWGGQ@mail.gmail.com>
References: <20190207185917.167829-1-egranata@google.com> <20190211190112.209286-1-egranata@chromium.org>
 <20190220180538.GA42642@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220180538.GA42642@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Enrico Granata <egranata@chromium.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Thanks for catching that and sorry for the delayed response, I was on vacation.

I think your analysis makes sense. I would personally lean towards the
former suggestion (keeping the change localized to the return value of
platform_get_irq() which is the function that apparently has an
informal contract about returning -ENXIO specifically).

I am happy to post a PATCH v3 to that effect if this seems amenable.

Thanks

Enrico Granata | egranata@google.com | ChromeOS | MTV1600


On Wed, Feb 20, 2019 at 10:05 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 11, 2019 at 11:01:12AM -0800, egranata@chromium.org wrote:
> > From: Enrico Granata <egranata@chromium.org>
> >
> > ACPI 5 added support for GpioInt resources as a way to provide
> > information about interrupts mediated via a GPIO controller.
> >
> > Several device buses (e.g. SPI, I2C) have support for retrieving
> > an IRQ specified via this type of resource, and providing it
> > directly to the driver as an IRQ number.
> >
> > This is not currently done for the platform drivers, as platform_get_irq()
> > does not try to parse GpioInt() resources. This requires drivers to
> > either have to support only one possible IRQ resource, or to have code
> > in place to try both as a failsafe.
> >
> > While there is a possibility of ambiguity for devices that exposes
> > multiple IRQs, it is easy and feasible to support the common case
> > of devices that only expose one IRQ which would be of either type
> > depending on the underlying system's architecture.
> >
> > This commit adds support for parsing a GpioInt resource in order
> > to fulfill a request for the index 0 IRQ for a platform device.
> >
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > ---
> > Changes in v2:
> >  - only support IRQ index 0
> >
> >  drivers/base/platform.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1c958eb33ef4d..0d3611cd1b3bc 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >               irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> >       }
> >
> > -     return r ? r->start : -ENXIO;
> > +     if (r)
> > +             return r->start;
> > +
> > +     /*
> > +      * For the index 0 interrupt, allow falling back to GpioInt
> > +      * resources. While a device could have both Interrupt and GpioInt
> > +      * resources, making this fallback ambiguous, in many common cases
> > +      * the device will only expose one IRQ, and this fallback
> > +      * allows a common code path across either kind of resource.
> > +      */
> > +     if (num == 0 && has_acpi_companion(&dev->dev))
> > +             return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
>
> For ACPI devices, this changes the return code for a missing interrupt
> 0 from ENXIO to ENOENT, because acpi_dev_gpio_irq_get() uses ENOENT
> instead of ENXIO. While ENXIO isn't exactly documented as the *specific*
> error code for a missing interrupt in platform_get_irq(), there are
> definitely drivers out there that are looking specifically for ENXIO
> (grepping the tree finds several Rockchip platform drivers and a few
> ethernet drivers at a minimum). And it also incidentally broke some
> usage of the very driver you were trying to support
> (drivers/platform/chrome/cros_ec_lpc.c).
>
> I suspect a good strategy here would be to check
> acpi_dev_gpio_irq_get()'s return codes here with something like:
>
>         if (ret > 0 || ret == -EPROBE_DEFER)
>                 return ret;
>         return -ENXIO;
>
> Although, the gpiolib functions embedded in there also can return EIO,
> so maybe something like this is better?
>
>         if (ret == -ENOENT || ret == 0)
>                 return -ENXIO;
>         return ret;
>
> I'm kinda unsure what to do with error codes besides PROBE_DEFER or
> "missing", since most users don't really have it in their mind that
> platform_get_irq() can fail with EIO or similar.
>
> Brian
>
> > +
> > +     return -ENXIO;
> >  #endif
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> > --
> > 2.20.1.791.gb4d0f1c61a-goog
> >
