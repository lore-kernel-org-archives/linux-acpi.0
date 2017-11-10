From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/6] gpiolib: acpi: Add quirks field to struct acpi_gpio_mapping
Date: Fri, 10 Nov 2017 15:40:32 +0200
Message-ID: <20171110134033.85461-5-andriy.shevchenko@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:5480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbdKJNlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Nov 2017 08:41:07 -0500
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some broken ACPI tables might require quirks in the OS.
Introduce quirks field in struct acpi_gpio_mapping.

Propagate them to struct acpi_gpio_info for further use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 ++++++++--
 drivers/gpio/gpiolib.h      |  2 ++
 include/linux/acpi.h        |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 88518afa26bd..711f64b9dd30 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -414,7 +414,8 @@ EXPORT_SYMBOL_GPL(devm_acpi_dev_remove_driver_gpios);
 
 static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 				      const char *name, int index,
-				      struct acpi_reference_args *args)
+				      struct acpi_reference_args *args,
+				      unsigned int *quirks)
 {
 	const struct acpi_gpio_mapping *gm;
 
@@ -430,6 +431,8 @@ static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 			args->args[1] = par->line_index;
 			args->args[2] = par->active_low;
 			args->nargs = 3;
+
+			*quirks = gm->quirks;
 			return true;
 		}
 
@@ -580,6 +583,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct acpi_reference_args args;
+	unsigned int quirks = 0;
 	int ret;
 
 	memset(&args, 0, sizeof(args));
@@ -591,7 +595,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 		if (!adev)
 			return ret;
 
-		if (!acpi_get_driver_gpio_data(adev, propname, index, &args))
+		if (!acpi_get_driver_gpio_data(adev, propname, index, &args,
+					       &quirks))
 			return ret;
 	}
 	/*
@@ -606,6 +611,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	lookup->active_low = !!args.args[2];
 
 	lookup->info.adev = args.adev;
+	lookup->info.quirks = quirks;
 	return 0;
 }
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b23aeaf5ac9e..cd4622863fe1 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -80,6 +80,7 @@ struct gpio_device {
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
+ * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
  */
 struct acpi_gpio_info {
 	struct acpi_device *adev;
@@ -87,6 +88,7 @@ struct acpi_gpio_info {
 	bool gpioint;
 	int polarity;
 	int triggering;
+	unsigned int quirks;
 };
 
 /* gpio suffixes used for ACPI and device tree lookup */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dc1ebfeeb5ec..25fe77fccea0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -978,6 +978,7 @@ struct acpi_gpio_mapping {
 	const char *name;
 	const struct acpi_gpio_params *data;
 	unsigned int size;
+	unsigned int quirks;
 };
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
-- 
2.14.2

