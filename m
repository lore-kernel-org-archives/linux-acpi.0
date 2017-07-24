From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/7] gpio: of: Improve kerneldoc
Date: Mon, 24 Jul 2017 16:57:23 +0200
Message-ID: <20170724145728.7662-2-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33299 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756266AbdGXO5d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 10:57:33 -0400
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add descriptions for missing fields and fix up some parameter references
to match the code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib-of.c   |  7 +++----
 include/linux/gpio/driver.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 54ce8dc58ad0..9c1b8a5d2f33 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -273,14 +273,13 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 }
 
 /**
- * of_gpio_simple_xlate - translate gpio_spec to the GPIO number and flags
+ * of_gpio_simple_xlate - translate gpiospec to the GPIO number and flags
  * @gc:		pointer to the gpio_chip structure
- * @np:		device node of the GPIO chip
- * @gpio_spec:	gpio specifier as found in the device tree
+ * @gpiospec:	GPIO specifier as found in the device tree
  * @flags:	a flags pointer to fill in
  *
  * This is simple translation function, suitable for the most 1:1 mapped
- * gpio chips. This function performs only one sanity check: whether gpio
+ * GPIO chips. This function performs only one sanity check: whether GPIO
  * is less than ngpios (that is specified in the gpio_chip).
  */
 int of_gpio_simple_xlate(struct gpio_chip *gc,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index ad4150d075c3..fe66c9306caf 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -180,8 +180,27 @@ struct gpio_chip {
 	 * If CONFIG_OF is enabled, then all GPIO controllers described in the
 	 * device tree automatically may have an OF translation
 	 */
+
+	/**
+	 * @of_node:
+	 *
+	 * Pointer to a device tree node representing this GPIO controller.
+	 */
 	struct device_node *of_node;
+
+	/**
+	 * @of_gpio_n_cells:
+	 *
+	 * Number of cells used to form the GPIO specifier.
+	 */
 	int of_gpio_n_cells;
+
+	/**
+	 * @of_xlate:
+	 *
+	 * Callback to translate a device tree GPIO specifier into a chip-
+	 * relative GPIO number and flags.
+	 */
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
 #endif
-- 
2.13.3

