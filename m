From: Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v6 2/3] gpio: Add support for TPS68470 GPIOs
Date: Fri, 28 Jul 2017 17:30:25 -0700
Message-ID: <1501288226-27469-3-git-send-email-rajmohan.mani@intel.com>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, sakari.ailus@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Rajmohan Mani <rajmohan.mani@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch adds support for TPS68470 GPIOs.
There are 7 GPIOs and a few sensor related GPIOs.
These GPIOs can be requested and configured as
appropriate.

The GPIOs are also provided with descriptive names.
However, the typical use case is that the OS GPIO
driver will interact with TPS68470 GPIO driver
to configure these GPIOs, as requested by the
platform firmware.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig         |  15 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps68470.c | 176 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/gpio/gpio-tps68470.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f235eae..45a58ae 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1064,6 +1064,21 @@ config GPIO_TPS65912
 	help
 	  This driver supports TPS65912 gpio chip
 
+config GPIO_TPS68470
+	bool "TPS68470 GPIO"
+	depends on MFD_TPS68470
+	help
+	  Select this option to enable GPIO driver for the TPS68470
+	  chip family.
+	  There are 7 GPIOs and few sensor related GPIOs supported
+	  by the TPS68470. While the 7 GPIOs can be configured as
+	  input or output as appropriate, the sensor related GPIOs
+	  are "output only" GPIOs.
+
+	  This driver config is bool, as the GPIO functionality
+	  of the TPS68470 must be available before dependent
+	  drivers are loaded.
+
 config GPIO_TWL4030
 	tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
 	depends on TWL4030_CORE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a9fda6c..37f2029 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_GPIO_TPS65218)	+= gpio-tps65218.o
 obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
+obj-$(CONFIG_GPIO_TPS68470)	+= gpio-tps68470.o
 obj-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
 obj-$(CONFIG_GPIO_TS4900)	+= gpio-ts4900.o
 obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
new file mode 100644
index 0000000..fa2662f
--- /dev/null
+++ b/drivers/gpio/gpio-tps68470.c
@@ -0,0 +1,176 @@
+/*
+ * GPIO driver for TPS68470 PMIC
+ *
+ * Copyright (C) 2017 Intel Corporation
+ *
+ * Authors:
+ *	Antti Laakso <antti.laakso@intel.com>
+ *	Tianshu Qiu <tian.shu.qiu@intel.com>
+ *	Jian Xu Zheng <jian.xu.zheng@intel.com>
+ *	Yuning Pu <yuning.pu@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/mfd/tps68470.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define TPS68470_N_LOGIC_OUTPUT	3
+#define TPS68470_N_REGULAR_GPIO	7
+#define TPS68470_N_GPIO	(TPS68470_N_LOGIC_OUTPUT + TPS68470_N_REGULAR_GPIO)
+
+struct tps68470_gpio_data {
+	struct regmap *tps68470_regmap;
+	struct gpio_chip gc;
+};
+
+static int tps68470_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
+	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
+	unsigned int reg = TPS68470_REG_GPDO;
+	int val, ret;
+
+	if (offset >= TPS68470_N_REGULAR_GPIO) {
+		offset -= TPS68470_N_REGULAR_GPIO;
+		reg = TPS68470_REG_SGPO;
+	}
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret) {
+		dev_err(tps68470_gpio->gc.parent, "reg 0x%x read failed\n",
+			TPS68470_REG_SGPO);
+		return ret;
+	}
+	return !!(val & BIT(offset));
+}
+
+/* Return 0 if output, 1 if input */
+static int tps68470_gpio_get_direction(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
+	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
+	int val, ret;
+
+	/* rest are always outputs */
+	if (offset >= TPS68470_N_REGULAR_GPIO)
+		return 0;
+
+	ret = regmap_read(regmap, TPS68470_GPIO_CTL_REG_A(offset), &val);
+	if (ret) {
+		dev_err(tps68470_gpio->gc.parent, "reg 0x%x read failed\n",
+			TPS68470_GPIO_CTL_REG_A(offset));
+		return ret;
+	}
+
+	val &= TPS68470_GPIO_MODE_MASK;
+	return val >= TPS68470_GPIO_MODE_OUT_CMOS ? 0 : 1;
+}
+
+static void tps68470_gpio_set(struct gpio_chip *gc, unsigned int offset,
+				int value)
+{
+	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
+	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
+	unsigned int reg = TPS68470_REG_GPDO;
+
+	if (offset >= TPS68470_N_REGULAR_GPIO) {
+		reg = TPS68470_REG_SGPO;
+		offset -= TPS68470_N_REGULAR_GPIO;
+	}
+
+	regmap_update_bits(regmap, reg, BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
+				int value)
+{
+	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
+	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
+
+	/* rest are always outputs */
+	if (offset >= TPS68470_N_REGULAR_GPIO)
+		return 0;
+
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
+	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
+				 TPS68470_GPIO_MODE_MASK,
+				 TPS68470_GPIO_MODE_OUT_CMOS);
+}
+
+static int tps68470_gpio_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
+	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
+
+	/* rest are always outputs */
+	if (offset >= TPS68470_N_REGULAR_GPIO)
+		return -EINVAL;
+
+	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
+				   TPS68470_GPIO_MODE_MASK, 0x00);
+}
+
+static const char *tps68470_names[TPS68470_N_GPIO] = {
+	"gpio.0", "gpio.1", "gpio.2", "gpio.3",
+	"gpio.4", "gpio.5", "gpio.6",
+	"s_enable", "s_idle", "s_resetn",
+};
+
+static int tps68470_gpio_probe(struct platform_device *pdev)
+{
+	struct tps68470_gpio_data *tps68470_gpio;
+	int ret;
+
+	tps68470_gpio = devm_kzalloc(&pdev->dev, sizeof(*tps68470_gpio),
+				     GFP_KERNEL);
+	if (!tps68470_gpio)
+		return -ENOMEM;
+
+	tps68470_gpio->tps68470_regmap = dev_get_drvdata(pdev->dev.parent);
+	tps68470_gpio->gc.label = "tps68470-gpio";
+	tps68470_gpio->gc.owner = THIS_MODULE;
+	tps68470_gpio->gc.direction_input = tps68470_gpio_input;
+	tps68470_gpio->gc.direction_output = tps68470_gpio_output;
+	tps68470_gpio->gc.get = tps68470_gpio_get;
+	tps68470_gpio->gc.get_direction = tps68470_gpio_get_direction;
+	tps68470_gpio->gc.set = tps68470_gpio_set;
+	tps68470_gpio->gc.can_sleep = true;
+	tps68470_gpio->gc.names = tps68470_names;
+	tps68470_gpio->gc.ngpio = TPS68470_N_GPIO;
+	tps68470_gpio->gc.base = -1;
+	tps68470_gpio->gc.parent = &pdev->dev;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &tps68470_gpio->gc,
+				     tps68470_gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register gpio_chip: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, tps68470_gpio);
+
+	return ret;
+}
+
+static struct platform_driver tps68470_gpio_driver = {
+	.driver = {
+		   .name = "tps68470-gpio",
+	},
+	.probe = tps68470_gpio_probe,
+};
+
+builtin_platform_driver(tps68470_gpio_driver)
-- 
1.9.1
