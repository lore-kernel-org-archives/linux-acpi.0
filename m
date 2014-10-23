From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio:
 Support for unified device properties interface)
Date: Thu, 23 Oct 2014 15:56:55 +0300
Message-ID: <20141023125655.GJ1484@lahna.fi.intel.com>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com>
 <1971792.8pKYWlGxB9@vostro.rjw.lan>
 <20141022145651.GH1484@lahna.fi.intel.com>
 <13758254.acHP1NJN1b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64308 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755648AbaJWM5Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2014 08:57:16 -0400
Content-Disposition: inline
In-Reply-To: <13758254.acHP1NJN1b@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Thu, Oct 23, 2014 at 01:21:06AM +0200, Rafael J. Wysocki wrote:
> OK, would the below make sense, then (completely untested, on top of the v6
> of the device properties patchset)?

Yes it does :-)

With the the below fix it works nicely with the modified rfkill-gpio.c
driver.

> +static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
> +				      const char *name,
> +				      struct acpi_reference_args *args)
> +{
> +	struct acpi_gpio_data *gd;
> +
> +	mutex_lock(&driver_gpio_data_lock);
> +
> +	list_for_each_entry(gd, &adev->driver_gpios, item)
> +		if (!strcmp(name, gd->name)) {
> +			args->adev = adev;
> +			args->args[0] = gd->entry_index;
> +			args->args[1] = gd->pin_index;
> +			args->args[2] = gd->active_low;
> +			args->nargs = 3;

			mutex_unlock(&driver_gpio_data_lock);

> +			return true;
> +		}
> +
> +	mutex_unlock(&driver_gpio_data_lock);
> +
> +	return false;
> +}

Also I think the two functions should be exported to modules as well.

Here are the modifications needed for rfkill-gpio.c driver. I think it
is not that bad considering that now the driver supports both ACPI _DSD
and non-_DSD at the same time.

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 0f62326c0f5e..f8754e7d81ea 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -67,6 +67,8 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
 				  struct rfkill_gpio_data *rfkill)
 {
 	const struct acpi_device_id *id;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
@@ -75,6 +77,20 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
 	rfkill->name = dev_name(dev);
 	rfkill->type = (unsigned)id->driver_data;
 
+	/*
+	 * Add default mapping for ACPI _DSD properties now just in case
+	 * there is no _DSD for this device.
+	 */
+	ret = acpi_dev_add_driver_gpio(adev, "reset-gpios", 0, 0, false);
+	if (ret)
+		return ret;
+
+	ret = acpi_dev_add_driver_gpio(adev, "shutdown-gpios", 1, 0, false);
+	if (ret) {
+		acpi_dev_remove_driver_gpios(adev);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -110,7 +126,7 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 		rfkill->reset_gpio = gpio;
 	}
 
-	gpio = devm_gpiod_get_index(&pdev->dev, "shutdown", 1);
+	gpio = devm_gpiod_get_index(&pdev->dev, "shutdown", 0);
 	if (!IS_ERR(gpio)) {
 		ret = gpiod_direction_output(gpio, 0);
 		if (ret)
@@ -150,6 +166,9 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 	rfkill_unregister(rfkill->rfkill_dev);
 	rfkill_destroy(rfkill->rfkill_dev);
 
+	if (ACPI_COMPANION(&pdev->dev))
+		acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
+
 	return 0;
 }
 
