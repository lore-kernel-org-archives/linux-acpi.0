From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 3/4] gpio: Rework of_gpiochip_set_names() to use device property accessors
Date: Fri, 21 Oct 2016 17:21:31 +0300
Message-ID: <20161021142132.80539-4-mika.westerberg@linux.intel.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11213 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933290AbcJUOWX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 10:22:23 -0400
In-Reply-To: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org

In order to use "gpio-line-names" property in systems not having DT as
their boot firmware, rework of_gpiochip_set_names() to use device property
accessors. This reworked function is placed in a separate file making it
clear it deals with universal device properties.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/Makefile          |  1 +
 drivers/gpio/gpiolib-devprop.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-of.c      | 47 +-------------------------------
 drivers/gpio/gpiolib.h         |  2 ++
 4 files changed, 66 insertions(+), 46 deletions(-)
 create mode 100644 drivers/gpio/gpiolib-devprop.c

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ab28a2daeacc..5cf9af1c0668 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,6 +5,7 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_GPIO_DEVRES)	+= devres.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
+obj-$(CONFIG_GPIOLIB)		+= gpiolib-devprop.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
new file mode 100644
index 000000000000..17bfc41692ef
--- /dev/null
+++ b/drivers/gpio/gpiolib-devprop.c
@@ -0,0 +1,62 @@
+/*
+ * Device property helpers for GPIO chips.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+
+#include "gpiolib.h"
+
+/**
+ * devprop_gpiochip_set_names - Set GPIO line names using device properties
+ * @chip: GPIO chip whose lines should be named, if possible
+ *
+ * Looks for device property "gpio-line-names" and if it exists assigns
+ * GPIO line names for the chip. The memory allocated for the assigned
+ * names belong to the underlying firmware node and should not be released
+ * by the caller.
+ */
+void devprop_gpiochip_set_names(struct gpio_chip *chip)
+{
+	struct gpio_device *gdev = chip->gpiodev;
+	const char **names;
+	int ret, i;
+
+	ret = device_property_read_string_array(chip->parent, "gpio-line-names",
+						NULL, 0);
+	if (ret < 0)
+		return;
+
+	if (ret != gdev->ngpio) {
+		dev_warn(chip->parent,
+			 "names %d do not match number of GPIOs %d\n", ret,
+			 gdev->ngpio);
+		return;
+	}
+
+	names = kcalloc(gdev->ngpio, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return;
+
+	ret = device_property_read_string_array(chip->parent, "gpio-line-names",
+						names, gdev->ngpio);
+	if (ret < 0) {
+		dev_warn(chip->parent, "failed to read GPIO line names\n");
+		kfree(names);
+		return;
+	}
+
+	for (i = 0; i < gdev->ngpio; i++)
+		gdev->descs[i].name = names[i];
+
+	kfree(names);
+}
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ecad3f0e3b77..3fa4e84b4327 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -222,51 +222,6 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 }
 
 /**
- * of_gpiochip_set_names() - set up the names of the lines
- * @chip: GPIO chip whose lines should be named, if possible
- */
-static void of_gpiochip_set_names(struct gpio_chip *gc)
-{
-	struct gpio_device *gdev = gc->gpiodev;
-	struct device_node *np = gc->of_node;
-	int i;
-	int nstrings;
-
-	nstrings = of_property_count_strings(np, "gpio-line-names");
-	if (nstrings <= 0)
-		/* Lines names not present */
-		return;
-
-	/* This is normally not what you want */
-	if (gdev->ngpio != nstrings)
-		dev_info(&gdev->dev, "gpio-line-names specifies %d line "
-			 "names but there are %d lines on the chip\n",
-			 nstrings, gdev->ngpio);
-
-	/*
-	 * Make sure to not index beyond the end of the number of descriptors
-	 * of the GPIO device.
-	 */
-	for (i = 0; i < gdev->ngpio; i++) {
-		const char *name;
-		int ret;
-
-		ret = of_property_read_string_index(np,
-						    "gpio-line-names",
-						    i,
-						    &name);
-		if (ret) {
-			if (ret != -ENODATA)
-                                dev_err(&gdev->dev,
-                                        "unable to name line %d: %d\n",
-                                        i, ret);
-			break;
-		}
-		gdev->descs[i].name = name;
-	}
-}
-
-/**
  * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
  * @chip:	gpio chip to act on
  *
@@ -522,7 +477,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 	/* If the chip defines names itself, these take precedence */
 	if (!chip->names)
-		of_gpiochip_set_names(chip);
+		devprop_gpiochip_set_names(chip);
 
 	of_node_get(chip->of_node);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 346fbda39220..d10eaf520860 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -209,6 +209,8 @@ static int __maybe_unused gpio_chip_hwgpio(const struct gpio_desc *desc)
 	return desc - &desc->gdev->descs[0];
 }
 
+void devprop_gpiochip_set_names(struct gpio_chip *chip);
+
 /* With descriptor prefix */
 
 #define gpiod_emerg(desc, fmt, ...)					       \
-- 
2.9.3

