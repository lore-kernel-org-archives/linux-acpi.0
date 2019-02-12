From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date: Tue, 12 Feb 2019 10:18:53 +0100
Message-ID: <CAJZ5v0jEf-PVxbrUABX2BrsNEFq3-aqU-_Zztmzssq9gNu4LxQ@mail.gmail.com>
References: <20190207185917.167829-1-egranata@google.com> <20190211190112.209286-1-egranata@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Enrico Granata <egranata@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Enrico Granata <egranata@google.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 11, 2019 at 8:01 PM <egranata@chromium.org> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
>
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
>
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources. This requires drivers to
> either have to support only one possible IRQ resource, or to have code
> in place to try both as a failsafe.
>
> While there is a possibility of ambiguity for devices that exposes
> multiple IRQs, it is easy and feasible to support the common case
> of devices that only expose one IRQ which would be of either type
> depending on the underlying system's architecture.
>
> This commit adds support for parsing a GpioInt resource in order
> to fulfill a request for the index 0 IRQ for a platform device.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in v2:
>  - only support IRQ index 0
>
>  drivers/base/platform.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..0d3611cd1b3bc 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>         }
>
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       /*
> +        * For the index 0 interrupt, allow falling back to GpioInt
> +        * resources. While a device could have both Interrupt and GpioInt
> +        * resources, making this fallback ambiguous, in many common cases
> +        * the device will only expose one IRQ, and this fallback
> +        * allows a common code path across either kind of resource.
> +        */
> +       if (num == 0 && has_acpi_companion(&dev->dev))
> +               return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
> 2.20.1.791.gb4d0f1c61a-goog
>
