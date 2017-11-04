From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/5] iio: proximity: sx9500: Add GPIO ACPI mapping
 table
Date: Sat, 4 Nov 2017 03:14:27 +0000
Message-ID: <20171104031403.000073b0@huawei.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
        <20171103130340.42459-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171103130340.42459-2-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 3 Nov 2017 15:03:37 +0200
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> In order to satisfy GPIO ACPI library requirements convert users of
> gpiod_get_index() to correctly behave when there no mapping is
> provided by firmware.
> 
> Here we add explicit mapping between _CRS GpioIo() resources and
> their names used in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Added cc's as for previous patch.  I guess this makes sense if we
accept that fixes like the previous one should be in drivers at all.

If not the reset part still makes sense I suppose.

> ---
>  drivers/iio/proximity/sx9500.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c
> b/drivers/iio/proximity/sx9500.c index df23dbcc030a..eb687b3dd442
> 100644 --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -32,9 +32,6 @@
>  #define SX9500_DRIVER_NAME		"sx9500"
>  #define SX9500_IRQ_NAME			"sx9500_event"
>  
> -#define SX9500_GPIO_INT			"interrupt"
> -#define SX9500_GPIO_RESET		"reset"
> -
>  /* Register definitions. */
>  #define SX9500_REG_IRQ_SRC		0x00
>  #define SX9500_REG_STAT			0x01
> @@ -866,26 +863,40 @@ static int sx9500_init_device(struct iio_dev
> *indio_dev) return sx9500_init_compensation(indio_dev);
>  }
>  
> +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> +static const struct acpi_gpio_params interrupt_gpios = { 2, 0,
> false }; +
> +static const struct acpi_gpio_mapping acpi_sx9500_gpios[] = {
> +	{ "reset-gpios", &reset_gpios, 1 },
> +	{ "interrupt-gpios", &interrupt_gpios, 1 },
> +	{ },
> +};
> +
>  static void sx9500_gpio_probe(struct i2c_client *client,
>  			      struct sx9500_data *data)
>  {
>  	struct gpio_desc *gpiod_int;
>  	struct device *dev;
> +	int ret;
>  
>  	if (!client)
>  		return;
>  
>  	dev = &client->dev;
>  
> +	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_sx9500_gpios);
> +	if (ret)
> +		dev_dbg(dev, "Unable to add GPIO mapping table\n");
> +
>  	if (client->irq <= 0) {
> -		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT,
> GPIOD_IN);
> +		gpiod_int = devm_gpiod_get(dev, "interrupt",
> GPIOD_IN); if (IS_ERR(gpiod_int))
>  			dev_err(dev, "gpio get irq failed\n");
>  		else
>  			client->irq = gpiod_to_irq(gpiod_int);
>  	}
>  
> -	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET,
> GPIOD_OUT_HIGH);
> +	data->gpiod_rst = devm_gpiod_get(dev, "reset",
> GPIOD_OUT_HIGH); if (IS_ERR(data->gpiod_rst)) {
>  		dev_warn(dev, "gpio get reset pin failed\n");
>  		data->gpiod_rst = NULL;
