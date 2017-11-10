From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Fri, 10 Nov 2017 15:40:33 +0200
Message-ID: <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Allow to relax IoRestriction for certain cases.

One of the use case is incorrectly cooked ACPI table where interrupt pin is
defined with GpioIo() macro with IoRestrictionOutputOnly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 ++++++++++---
 include/linux/acpi.h        |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 711f64b9dd30..430a1475212d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -496,11 +496,18 @@ int
 acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
 {
 	struct device *dev = &info->adev->dev;
+	enum gpiod_flags old = *flags;
 	int ret;
 
-	ret = __acpi_gpio_update_gpiod_flags(flags, info->flags);
-	if (ret)
-		dev_dbg(dev, "Override GPIO initialization flags\n");
+	ret = __acpi_gpio_update_gpiod_flags(&old, info->flags);
+	if (info->quirks & ACPI_GPIO_QUIRK_NO_IO_RESTRICTION) {
+		if (ret)
+			dev_warn(dev, FW_BUG "GPIO not in correct mode, fixing\n");
+	} else {
+		if (ret)
+			dev_dbg(dev, "Override GPIO initialization flags\n");
+		*flags = old;
+	}
 
 	return ret;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 25fe77fccea0..06b6eb775115 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -978,6 +978,10 @@ struct acpi_gpio_mapping {
 	const char *name;
 	const struct acpi_gpio_params *data;
 	unsigned int size;
+
+/* Ignore IoRestriction field */
+#define ACPI_GPIO_QUIRK_NO_IO_RESTRICTION	BIT(0)
+
 	unsigned int quirks;
 };
 
-- 
2.14.2

