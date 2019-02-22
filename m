From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date: Fri, 22 Feb 2019 09:06:05 -0800
Message-ID: <CA+ASDXObuA4rMz_JeM3Mu933Z=uccmb7_-DFp048v_Cir=GqAQ@mail.gmail.com>
References: <20190220180538.GA42642@google.com> <20190221193429.161300-1-egranata@chromium.org>
 <CAJZ5v0i5KeFN3s1Uydgxre_6-DkS2qH7rAzppk_tGddVm6r4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i5KeFN3s1Uydgxre_6-DkS2qH7rAzppk_tGddVm6r4XQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Enrico Granata <egranata@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Enrico Granata <egranata@google.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 22, 2019 at 1:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 21, 2019 at 8:34 PM <egranata@chromium.org> wrote:
> >
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
> > Changes in v3:
> >  - ensured that -ENOENT return from acpi_dev_gpio_irq_get is not propagated
> >    upwards, as some drivers expect platform_get_irq to return either a valid
> >    IRQ or -ENXIO and will break otherwise

I hope there are no other lurking ways in which this might break things...

Reviewed-by: Brian Norris <briannorris@chromium.org>

> >  drivers/base/platform.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1c958eb33ef4d..afd8b916303e4 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -127,7 +127,24 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> >         }
> >
> > -       return r ? r->start : -ENXIO;
> > +       if (r)
> > +               return r->start;
> > +
> > +       /*
> > +        * For the index 0 interrupt, allow falling back to GpioInt
> > +        * resources. While a device could have both Interrupt and GpioInt
> > +        * resources, making this fallback ambiguous, in many common cases
> > +        * the device will only expose one IRQ, and this fallback
> > +        * allows a common code path across either kind of resource.
> > +        */
> > +       if (num == 0 && has_acpi_companion(&dev->dev)) {
> > +               int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> > +
> > +               if (ret > 0 || ret == -EPROBE_DEFER)
>
> Can't 0 be a valid GPIO IRQ?

acpi_dev_gpio_irq_get() claims:

 * Return: Linux IRQ number (> %0) on success, negative errno on failure.

Should I trust the documentation? It seems like yes, I should:

int gpiod_to_irq(const struct gpio_desc *desc)
{
...
                /* Zero means NO_IRQ */
                if (!retirq)
                        return -ENXIO;


Brian

> > +                       return ret;
> > +       }
> > +
> > +       return -ENXIO;
> >  #endif
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> > --
