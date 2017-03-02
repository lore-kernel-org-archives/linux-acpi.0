From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] gpio: acpi: Add managed variant of acpi_dev_add_driver_gpios()
Date: Thu, 02 Mar 2017 23:07:28 +0100
Message-ID: <11931412.qmz2QKIKDY@aspire.rjw.lan>
References: <20170302134805.81705-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57630 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751229AbdCBWTW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2017 17:19:22 -0500
In-Reply-To: <20170302134805.81705-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org

On Thursday, March 02, 2017 03:48:05 PM Andy Shevchenko wrote:
> Introduce device managed variant of acpi_dev_add_driver_gpios() and its
> counterpart acpi_dev_remove_driver_gpios().
> 
> The functions in most cases are used in driver's ->probe() and
> ->remove() callbacks, that's why it's useful to have managed variant of
> them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> This is supposed to go through GPIO tree.
> 
> Linus, can you create an immutable branch that other subsystems can use
> it if needed?
> 
> (We currently have one possible leak and devm_*() would help there)
> 
>  drivers/gpio/gpiolib-acpi.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/acpi.h        | 11 +++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 1459e6183194..3fe63d8ed426 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -362,6 +362,37 @@ int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_add_driver_gpios);
>  
> +static void devm_acpi_dev_release_driver_gpios(struct device *dev, void *res)
> +{
> +	acpi_dev_remove_driver_gpios(ACPI_COMPANION(dev));
> +}
> +
> +int devm_acpi_dev_add_driver_gpios(struct device *dev,
> +				   const struct acpi_gpio_mapping *gpios)
> +{
> +	void *res;
> +	int ret;
> +
> +	res = devres_alloc(devm_acpi_dev_release_driver_gpios, 0, GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(dev), gpios);
> +	if (ret) {
> +		devres_free(res);
> +		return ret;
> +	}
> +	devres_add(dev, res);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_acpi_dev_add_driver_gpios);
> +
> +void devm_acpi_dev_remove_driver_gpios(struct device *dev)
> +{
> +	WARN_ON(devres_release(dev, devm_acpi_dev_release_driver_gpios, NULL, NULL));
> +}
> +EXPORT_SYMBOL_GPL(devm_acpi_dev_remove_driver_gpios);
> +
>  static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
>  				      const char *name, int index,
>  				      struct acpi_reference_args *args)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 673acda012af..c8eaaad4a9ed 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -952,6 +952,10 @@ static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
>  		adev->driver_gpios = NULL;
>  }
>  
> +int devm_acpi_dev_add_driver_gpios(struct device *dev,
> +				   const struct acpi_gpio_mapping *gpios);
> +void devm_acpi_dev_remove_driver_gpios(struct device *dev);
> +
>  int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
>  #else
>  static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
> @@ -961,6 +965,13 @@ static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>  }
>  static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
>  
> +static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
> +			      const struct acpi_gpio_mapping *gpios)
> +{
> +	return -ENXIO;
> +}
> +static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev) {}
> +
>  static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  {
>  	return -ENXIO;
> 

ACK for the ACPI header update.

Thanks,
Rafael

