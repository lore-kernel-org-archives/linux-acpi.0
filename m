From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] gpio / ACPI: Add support for retrieving GpioInt resources from a device
Date: Tue, 05 May 2015 01:47:36 +0200
Message-ID: <1988723.gb0XCG22Xj@vostro.rjw.lan>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com> <1430233507-29389-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50540 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751161AbbEDXWg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 19:22:36 -0400
In-Reply-To: <1430233507-29389-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, April 28, 2015 06:05:06 PM Mika Westerberg wrote:
> ACPI specification knows two types of GPIOs: GpioIo and GpioInt. The latter
> is used to describe that a given device interrupt line is connected to a
> specific GPIO pin. Typical ACPI _CRS entry for such device looks like
> below:
> 
>     Name (_CRS, ResourceTemplate ()
>     {
>         I2cSerialBus (0x004A, ControllerInitiated, 0x00061A80,
>                       AddressingMode7Bit, "\\_SB.PCI0.I2C6",
>                       0x00, ResourceConsumer)
>         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
>                 IoRestrictionOutputOnly, "\\_SB.GPO0",
>                 0x00, ResourceConsumer)
>         {
>             0x004B
>         }
>         GpioInt (Level, ActiveLow, Shared, PullDefault, 0x0000,
>                  "\\_SB.GPO0", 0x00, ResourceConsumer)
>         {
>             0x004C
>         }
>     })
> 
> Currently drivers need to request a GPIO corresponding to the right GpioInt
> and then translate that to Linux IRQ number. This adds unnecessary lines of
> boiler-plate code.
> 
> We can ease this a bit by introducing acpi_dev_gpio_irq_get() analogous to
> of_irq_get(). This function translates given GpioInt resource under the
> device in question to the suitable Linux IRQ number.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++++++++
>  include/linux/acpi.h        |  7 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index d2303d50f561..bff29bb0a3fe 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -514,6 +514,35 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>  	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
>  }
>  
> +/**
> + * acpi_dev_gpio_irq_get() - Find GpioInt and translate it to Linux IRQ number
> + * @adev: pointer to a ACPI device to get IRQ from
> + * @index: index of GpioInt resource (starting from %0)
> + *
> + * If the device has one or more GpioInt resources, this function can be
> + * used to translate from the GPIO offset in the resource to the Linux IRQ
> + * number.
> + *
> + * Return: Linux IRQ number (>%0) on success, negative errno on failure.
> + */
> +int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> +{
> +	int idx, i;
> +
> +	for (i = 0, idx = 0; idx <= index; i++) {
> +		struct acpi_gpio_info info;
> +		struct gpio_desc *desc;
> +
> +		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
> +		if (IS_ERR(desc))
> +			break;
> +		if (info.gpioint && idx++ == index)
> +			return gpiod_to_irq(desc);
> +	}
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get);
> +
>  static acpi_status
>  acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  			    u32 bits, u64 *value, void *handler_context,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e4da5e35e29c..f57c440642cd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -721,6 +721,8 @@ static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
>  	if (adev)
>  		adev->driver_gpios = NULL;
>  }
> +
> +int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
>  #else
>  static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>  			      const struct acpi_gpio_mapping *gpios)
> @@ -728,6 +730,11 @@ static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>  	return -ENXIO;
>  }
>  static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
> +
> +static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> +{
> +	return -ENXIO;
> +}
>  #endif
>  
>  /* Device properties */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
