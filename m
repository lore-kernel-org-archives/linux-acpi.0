From: Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Tue,  6 Jun 2017 04:55:17 -0700
Message-ID: <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rajmohan Mani <rajmohan.mani@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch adds support for TPS68470 GPIOs.
There are 7 GPIOs and a few sensor related GPIOs.
These GPIOs can be requested and configured as
appropriate.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/gpio/Kconfig         |  10 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps68470.c | 185 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/gpio/gpio-tps68470.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 23ca51e..ed34f9b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1041,6 +1041,16 @@ config GPIO_TPS65912
 	help
 	  This driver supports TPS65912 gpio chip
 
+config GPIO_TPS68470
+	bool "TPS68470 GPIO"
+	depends on MFD_TPS68470
+	help
+	  Select this option to enable GPIO driver for the TPS68470
+	  chip family.
+	  There are 7 GPIOs and few sensor related GPIOs supported
+	  by the TPS68470. These GPIOs can be requested and
+	  configured as appropriate, with this driver.
+
 config GPIO_TWL4030
 	tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
 	depends on TWL4030_CORE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 68b9627..a2659cb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_GPIO_TPS65218)	+= gpio-tps65218.o
 obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
+obj-$(CONFIG_GPIO_TPS68470)	+= gpio-tps68470.o
 obj-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
 obj-$(CONFIG_GPIO_TS4900)	+= gpio-ts4900.o
 obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
new file mode 100644
index 0000000..b599a66
--- /dev/null
+++ b/drivers/gpio/gpio-tps68470.c
@@ -0,0 +1,185 @@
+/*
+ * GPIO driver for TPS68470 PMIC
+ *
+ * Copyright (C) 2017 Intel Corporation
+ * Authors:
+ * Antti Laakso <antti.laakso@intel.com>
+ * Tianshu Qiu <tian.shu.qiu@intel.com>
+ * Jian Xu Zheng <jian.xu.zheng@intel.com>
+ * Yuning Pu <yuning.pu@intel.com>
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
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/mfd/tps68470.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define TPS68470_N_LOGIC_OUTPUT	3
+#define TPS68470_N_REGULAR_GPIO	7
+#define TPS68470_N_GPIO	(TPS68470_N_LOGIC_OUTPUT + TPS68470_N_REGULAR_GPIO)
+
+struct tps68470_gpio_data {
+	struct tps68470 *tps68470;
+	struct gpio_chip gc;
+};
+
+static inline struct tps68470_gpio_data *to_gpio_data(struct gpio_chip *gpiochp)
+{
+	return container_of(gpiochp, struct tps68470_gpio_data, gc);
+}
+
+static int tps68470_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps68470_gpio_data *tps68470_gpio = to_gpio_data(gc);
+	struct tps68470 *tps = tps68470_gpio->tps68470;
+	unsigned int reg = TPS68470_REG_GPDO;
+	int val, ret;
+
+	if (offset >= TPS68470_N_REGULAR_GPIO) {
+		offset -= TPS68470_N_REGULAR_GPIO;
+		reg = TPS68470_REG_SGPO;
+	}
+
+	ret = tps68470_reg_read(tps, reg, &val);
+	if (ret) {
+		dev_err(tps->dev, "reg 0x%x read failed\n", TPS68470_REG_SGPO);
+		return ret;
+	}
+	return !!(val & BIT(offset));
+}
+
+static void tps68470_gpio_set(struct gpio_chip *gc, unsigned int offset,
+				int value)
+{
+	struct tps68470_gpio_data *tps68470_gpio = to_gpio_data(gc);
+	struct tps68470 *tps = tps68470_gpio->tps68470;
+	unsigned int reg = TPS68470_REG_GPDO;
+
+	if (offset >= TPS68470_N_REGULAR_GPIO) {
+		reg = TPS68470_REG_SGPO;
+		offset -= TPS68470_N_REGULAR_GPIO;
+	}
+
+	tps68470_update_bits(tps, reg, BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
+				int value)
+{
+	struct tps68470_gpio_data *tps68470_gpio = to_gpio_data(gc);
+	struct tps68470 *tps = tps68470_gpio->tps68470;
+
+	/* rest are always outputs */
+	if (offset >= TPS68470_N_REGULAR_GPIO)
+		return 0;
+
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
+	return tps68470_update_bits(tps, TPS68470_GPIO_CTL_REG_A(offset),
+				 TPS68470_GPIO_MODE_MASK,
+				 TPS68470_GPIO_MODE_OUT_CMOS);
+}
+
+static int tps68470_gpio_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps68470_gpio_data *tps68470_gpio = to_gpio_data(gc);
+	struct tps68470 *tps = tps68470_gpio->tps68470;
+
+	/* rest are always outputs */
+	if (offset >= TPS68470_N_REGULAR_GPIO)
+		return -EINVAL;
+
+	return tps68470_update_bits(tps, TPS68470_GPIO_CTL_REG_A(offset),
+				   TPS68470_GPIO_MODE_MASK, 0x00);
+}
+
+struct gpiod_lookup_table gpios_table = {
+	.dev_id = NULL,
+	.table = {
+		  GPIO_LOOKUP("tps68470-gpio", 0, "gpio.0", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 1, "gpio.1", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 2, "gpio.2", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 3, "gpio.3", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 4, "gpio.4", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 5, "gpio.5", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 6, "gpio.6", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 7, "s_enable", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 8, "s_idle", GPIO_ACTIVE_HIGH),
+		  GPIO_LOOKUP("tps68470-gpio", 9, "s_resetn", GPIO_ACTIVE_HIGH),
+		  {},
+	},
+};
+
+static int tps68470_gpio_probe(struct platform_device *pdev)
+{
+	struct tps68470 *tps68470 = dev_get_drvdata(pdev->dev.parent);
+	struct tps68470_gpio_data *tps68470_gpio;
+	int i, ret;
+
+	tps68470_gpio = devm_kzalloc(&pdev->dev, sizeof(*tps68470_gpio),
+				     GFP_KERNEL);
+	if (!tps68470_gpio)
+		return -ENOMEM;
+
+	tps68470_gpio->tps68470 = tps68470;
+	tps68470_gpio->gc.label = "tps68470-gpio";
+	tps68470_gpio->gc.owner = THIS_MODULE;
+	tps68470_gpio->gc.direction_input = tps68470_gpio_input;
+	tps68470_gpio->gc.direction_output = tps68470_gpio_output;
+	tps68470_gpio->gc.get = tps68470_gpio_get;
+	tps68470_gpio->gc.set = tps68470_gpio_set;
+	tps68470_gpio->gc.can_sleep = true;
+	tps68470_gpio->gc.ngpio = TPS68470_N_GPIO;
+	tps68470_gpio->gc.base = -1;
+	tps68470_gpio->gc.parent = &pdev->dev;
+
+	ret = gpiochip_add(&tps68470_gpio->gc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register gpio_chip: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_add_lookup_table(&gpios_table);
+
+	platform_set_drvdata(pdev, tps68470_gpio);
+
+	/*
+	 * Initialize all the GPIOs to 0, just to make sure all
+	 * GPIOs start with known default values. This protects against
+	 * any GPIOs getting set with a value of 1, after TPS68470 reset
+	 */
+	for (i = 0; i < tps68470_gpio->gc.ngpio; i++)
+		tps68470_gpio_set(&tps68470_gpio->gc, i, 0);
+
+	return ret;
+}
+
+static int tps68470_gpio_remove(struct platform_device *pdev)
+{
+	struct tps68470_gpio_data *tps68470_gpio = platform_get_drvdata(pdev);
+
+	gpiod_remove_lookup_table(&gpios_table);
+	gpiochip_remove(&tps68470_gpio->gc);
+
+	return 0;
+}
+
+static struct platform_driver tps68470_gpio_driver = {
+	.driver = {
+		   .name = "tps68470-gpio",
+	},
+	.probe = tps68470_gpio_probe,
+	.remove = tps68470_gpio_remove,
+};
+
+builtin_platform_driver(tps68470_gpio_driver)
-- 
1.9.1
