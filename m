From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/6] gpiolib: acpi: Consolidate debug output in acpi_gpio_update_gpiod_flags()
Date: Fri, 10 Nov 2017 15:40:31 +0200
Message-ID: <20171110134033.85461-4-andriy.shevchenko@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752710AbdKJNmH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Nov 2017 08:42:07 -0500
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We have the duplicated debug strings printed whenever
acpi_gpio_update_gpiod_flags() fails. Instead of doing this by callers,
move the debug output inside function.

In one case convert almost useless pr_debug() to dev_dbg() where
actual consumer of GPIO resource is disclosed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 23 ++++++++++++++++-------
 drivers/gpio/gpiolib.c      |  4 +---
 drivers/gpio/gpiolib.h      |  4 ++--
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7d0664a3d1b9..88518afa26bd 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -461,8 +461,8 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio)
 	}
 }
 
-int
-acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
+static int
+__acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
 {
 	int ret = 0;
 
@@ -489,6 +489,19 @@ acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
 	return ret;
 }
 
+int
+acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
+{
+	struct device *dev = &info->adev->dev;
+	int ret;
+
+	ret = __acpi_gpio_update_gpiod_flags(flags, info->flags);
+	if (ret)
+		dev_dbg(dev, "Override GPIO initialization flags\n");
+
+	return ret;
+}
+
 struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
 	int index;
@@ -661,7 +674,6 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
-	int err;
 	int i;
 
 	/* Try first from _DSD */
@@ -700,10 +712,7 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 	if (info.polarity == GPIO_ACTIVE_LOW)
 		*lookupflags |= GPIO_ACTIVE_LOW;
 
-	err = acpi_gpio_update_gpiod_flags(dflags, info.flags);
-	if (err)
-		dev_dbg(dev, "Override GPIO initialization flags\n");
-
+	acpi_gpio_update_gpiod_flags(dflags, &info);
 	return desc;
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 029ad1a0a0d5..ab464f29d41a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3584,9 +3584,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
 		if (!IS_ERR(desc)) {
 			active_low = info.polarity == GPIO_ACTIVE_LOW;
-			ret = acpi_gpio_update_gpiod_flags(&dflags, info.flags);
-			if (ret)
-				pr_debug("Override GPIO initialization flags\n");
+			acpi_gpio_update_gpiod_flags(&dflags, &info);
 		}
 	}
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index e8d0bfa57288..b23aeaf5ac9e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -126,7 +126,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
 int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
-				 enum gpiod_flags update);
+				 struct acpi_gpio_info *info);
 
 struct gpio_desc *acpi_find_gpio(struct device *dev,
 				 const char *con_id,
@@ -151,7 +151,7 @@ static inline void
 acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
 
 static inline int
-acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
+acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
 {
 	return 0;
 }
-- 
2.14.2

