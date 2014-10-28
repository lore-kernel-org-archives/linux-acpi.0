From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH RESEND] net: rfkill: gpio: Add ACPI default GPIO driver mappings
Date: Tue, 28 Oct 2014 23:18:44 +0100
Message-ID: <1726782.TCzbPOGKzX@vostro.rjw.lan>
References: <1414490628-107823-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414490628-107823-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, October 28, 2014 12:03:48 PM Mika Westerberg wrote:
> The driver uses devm_gpiod_get_index(..., index) so that the index refers
> directly to the GpioIo resource under the ACPI device. The problem with
> this is that if the ordering changes we get wrong GPIOs.
> 
> With ACPI 5.1 _DSD we can now use names instead to reference GPIOs
> analogous to Device Tree. However, we still have systems out there that do
> not provide _DSD at all. These systems must be supported as well.
> 
> Luckily we now have acpi_dev_add_driver_gpios() that can be used to provide
> mappings for systems where _DSD is not provided and still take advantage of
> _DSD if it exists.
> 
> This patch converts the rfkill-gpio.c driver to create default GPIO
> mappings to the two GPIOs in case we are running on ACPI system.
> 
> While there we can drop the indices completely.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
> Acked-by: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
> Acked-by: John W. Linville <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>

Applied, thanks!

> ---
> Resending with linux-acpi included. I also added ACKs from Johannes and
> John. The patch itself is intact.
> 
>  net/rfkill/rfkill-gpio.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> index 0f62326c0f5e..2a4717967502 100644
> --- a/net/rfkill/rfkill-gpio.c
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -63,6 +63,15 @@ static const struct rfkill_ops rfkill_gpio_ops = {
>  	.set_block = rfkill_gpio_set_power,
>  };
>  
> +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> +static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping acpi_rfkill_default_gpios[] = {
> +	{ "reset-gpios", &reset_gpios, 1 },
> +	{ "shutdown-gpios", &shutdown_gpios, 1 },
> +	{ },
> +};
> +
>  static int rfkill_gpio_acpi_probe(struct device *dev,
>  				  struct rfkill_gpio_data *rfkill)
>  {
> @@ -75,7 +84,8 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
>  	rfkill->name = dev_name(dev);
>  	rfkill->type = (unsigned)id->driver_data;
>  
> -	return 0;
> +	return acpi_dev_add_driver_gpios(ACPI_COMPANION(dev),
> +					 acpi_rfkill_default_gpios);
>  }
>  
>  static int rfkill_gpio_probe(struct platform_device *pdev)
> @@ -102,7 +112,7 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
>  
>  	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
>  
> -	gpio = devm_gpiod_get_index(&pdev->dev, "reset", 0);
> +	gpio = devm_gpiod_get(&pdev->dev, "reset");
>  	if (!IS_ERR(gpio)) {
>  		ret = gpiod_direction_output(gpio, 0);
>  		if (ret)
> @@ -110,7 +120,7 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
>  		rfkill->reset_gpio = gpio;
>  	}
>  
> -	gpio = devm_gpiod_get_index(&pdev->dev, "shutdown", 1);
> +	gpio = devm_gpiod_get(&pdev->dev, "shutdown");
>  	if (!IS_ERR(gpio)) {
>  		ret = gpiod_direction_output(gpio, 0);
>  		if (ret)
> @@ -150,6 +160,8 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
>  	rfkill_unregister(rfkill->rfkill_dev);
>  	rfkill_destroy(rfkill->rfkill_dev);
>  
> +	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
> +
>  	return 0;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
