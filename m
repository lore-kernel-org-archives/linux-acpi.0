From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 09/12] gpio: acpi: Split out
 acpi_gpio_get_irq_resource() helper
Date: Wed, 24 May 2017 14:53:43 +0300
Message-ID: <20170524115343.GC8541@lahna.fi.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
 <20170523170327.18055-10-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523170327.18055-10-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 08:03:24PM +0300, Andy Shevchenko wrote:
> The helper does retrieve pointer to struct acpi_resource_gpio from
> struct acpi_resource if it represents GpioInt() resource.
> 
> It will be used by PNP code later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 23 ++++++++++++++++++-----
>  include/linux/acpi.h        |  7 +++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index e431222edc2b..6bea176b066c 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -165,6 +165,23 @@ static void acpi_gpio_chip_dh(acpi_handle handle, void *data)
>  	/* The address of this function is used as a key. */
>  }

Since this is exported, it might be good idea to provide kernel-doc
here.

Anyway,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> +bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
> +				struct acpi_resource_gpio **agpio)
> +{
> +	struct acpi_resource_gpio *gpio;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
> +		return false;
> +
> +	gpio = &ares->data.gpio;
> +	if (gpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
> +		return false;
> +
> +	*agpio = gpio;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
