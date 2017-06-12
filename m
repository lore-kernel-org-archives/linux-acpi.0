From: Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v3 1/3] mfd: Add new mfd device TPS68470
Date: Mon, 12 Jun 2017 02:26:50 -0700
Message-ID: <1497259612-38401-2-git-send-email-rajmohan.mani@intel.com>
References: <1497259612-38401-1-git-send-email-rajmohan.mani@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbdFLJeA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jun 2017 05:34:00 -0400
In-Reply-To: <1497259612-38401-1-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rajmohan Mani <rajmohan.mani@intel.com>

The TPS68470 device is an advanced power management
unit that powers a Compact Camera Module (CCM),
generates clocks for image sensors, drives a dual
LED for Flash and incorporates two LED drivers for
general purpose indicators.

This patch adds support for TPS68470 mfd device.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/mfd/Kconfig          |  18 +++++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/tps68470.c       | 156 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tps68470.h | 144 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 drivers/mfd/tps68470.c
 create mode 100644 include/linux/mfd/tps68470.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3eb5c93..2081248 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1311,6 +1311,24 @@ config MFD_TPS65217
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65217.
 
+config MFD_TPS68470
+	bool "TI TPS68470 Power Management / LED chips"
+	depends on ACPI && I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	select I2C_DESIGNWARE_PLATFORM
+	help
+	  If you say yes here you get support for the TPS68470 series of
+	  Power Management / LED chips.
+
+	  These include voltage regulators, led and other features
+	  that are often used in portable devices.
+
+	  This option is a bool as it provides an ACPI operation
+	  region, which must be available before any of the devices
+	  using this, are probed. This option also configures the
+	  designware-i2c driver to be builtin, for the same reason.
+
 config MFD_TI_LP873X
 	tristate "TI LP873X Power Management IC"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c16bf1e..6dd2b94 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
 obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
 obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
 obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
+obj-$(CONFIG_MFD_TPS68470)	+= tps68470.o
 obj-$(CONFIG_MFD_TPS80031)	+= tps80031.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
diff --git a/drivers/mfd/tps68470.c b/drivers/mfd/tps68470.c
new file mode 100644
index 0000000..6ec3302
--- /dev/null
+++ b/drivers/mfd/tps68470.c
@@ -0,0 +1,156 @@
+/*
+ * TPS68470 chip family multi-function driver
+ *
+ * Copyright (C) 2017 Intel Corporation
+ * Authors:
+ * Rajmohan Mani <rajmohan.mani@intel.com>
+ * Tianshu Qiu <tian.shu.qiu@intel.com>
+ * Jian Xu Zheng <jian.xu.zheng@intel.com>
+ * Yuning Pu <yuning.pu@intel.com>
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
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/tps68470.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell tps68470s[] = {
+	{
+		.name = "tps68470-gpio",
+	},
+	{
+		.name = "tps68470_pmic_opregion",
+	},
+};
+
+static const struct regmap_config tps68470_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPS68470_REG_MAX,
+};
+
+static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
+{
+	unsigned int version;
+	int ret;
+
+	ret = regmap_read(regmap, TPS68470_REG_REVID, &version);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read revision register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(regmap, TPS68470_REG_RESET, 0xff);
+	if (ret < 0)
+		return ret;
+
+	/* FIXME: configure these dynamically */
+	/* Enable Daisy Chain LDO and configure relevant GPIOs as output */
+	ret = regmap_write(regmap, TPS68470_REG_S_I2C_CTL, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, TPS68470_REG_GPCTL4A, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, TPS68470_REG_GPCTL5A, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, TPS68470_REG_GPCTL6A, 2);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * When SDA and SCL are routed to GPIO1 and GPIO2, the mode
+	 * for these GPIOs must be configured using their respective
+	 * GPCTLxA registers as inputs with no pull-ups.
+	 */
+	ret = regmap_write(regmap, TPS68470_REG_GPCTL1A, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, TPS68470_REG_GPCTL2A, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Enable daisy chain */
+	ret = regmap_update_bits(regmap, TPS68470_REG_S_I2C_CTL, 1, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Typical PLL startup time is 1 ms */
+	usleep_range(TPS68470_DAISY_CHAIN_DELAY_US,
+			TPS68470_DAISY_CHAIN_DELAY_US + 10);
+
+	dev_info(dev, "TPS68470 REVID: 0x%x\n", version);
+
+	return 0;
+}
+
+static int tps68470_probe(struct i2c_client *client,
+			  const struct i2c_device_id *ids)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "devm_regmap_init_i2c Error %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	i2c_set_clientdata(client, regmap);
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, tps68470s,
+			      ARRAY_SIZE(tps68470s), NULL, 0, NULL);
+	if (ret < 0) {
+		dev_err(dev, "mfd_add_devices failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = tps68470_chip_init(dev, regmap);
+	if (ret < 0) {
+		dev_err(dev, "TPS68470 Init Error %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id tps68470_id_table[] = {
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, tps68470_id_table);
+
+static const struct acpi_device_id tps68470_acpi_ids[] = {
+	{"INT3472"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, tps68470_acpi_ids);
+
+static struct i2c_driver tps68470_driver = {
+	.driver = {
+		   .name = "tps68470",
+		   .acpi_match_table = tps68470_acpi_ids,
+	},
+	.id_table = tps68470_id_table,
+	.probe = tps68470_probe,
+};
+builtin_i2c_driver(tps68470_driver);
diff --git a/include/linux/mfd/tps68470.h b/include/linux/mfd/tps68470.h
new file mode 100644
index 0000000..3fdfc75
--- /dev/null
+++ b/include/linux/mfd/tps68470.h
@@ -0,0 +1,144 @@
+/*
+ * Copyright (c) 2017 Intel Corporation
+ *
+ * Functions to access TPS68470 power management chip.
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
+#ifndef __LINUX_MFD_TPS68470_H
+#define __LINUX_MFD_TPS68470_H
+
+#include <linux/i2c.h>
+
+/* All register addresses */
+#define TPS68470_REG_GSTAT		0x01
+#define TPS68470_REG_VRSTA		0x02
+#define TPS68470_REG_VRSHORT		0x03
+#define TPS68470_REG_INTMASK		0x04
+#define TPS68470_REG_VCOSPEED		0x05
+#define TPS68470_REG_POSTDIV2		0x06
+#define TPS68470_REG_BOOSTDIV		0x07
+#define TPS68470_REG_BUCKDIV		0x08
+#define TPS68470_REG_PLLSWR		0x09
+#define TPS68470_REG_XTALDIV		0x0A
+#define TPS68470_REG_PLLDIV		0x0B
+#define TPS68470_REG_POSTDIV		0x0C
+#define TPS68470_REG_PLLCTL		0x0D
+#define TPS68470_REG_PLLCTL2		0x0E
+#define TPS68470_REG_CLKCFG1		0x0F
+#define TPS68470_REG_CLKCFG2		0x10
+#define TPS68470_REG_GPCTL0A		0x14
+#define TPS68470_REG_GPCTL0B		0x15
+#define TPS68470_REG_GPCTL1A		0x16
+#define TPS68470_REG_GPCTL1B		0x17
+#define TPS68470_REG_GPCTL2A		0x18
+#define TPS68470_REG_GPCTL2B		0x19
+#define TPS68470_REG_GPCTL3A		0x1A
+#define TPS68470_REG_GPCTL3B		0x1B
+#define TPS68470_REG_GPCTL4A		0x1C
+#define TPS68470_REG_GPCTL4B		0x1D
+#define TPS68470_REG_GPCTL5A		0x1E
+#define TPS68470_REG_GPCTL5B		0x1F
+#define TPS68470_REG_GPCTL6A		0x20
+#define TPS68470_REG_GPCTL6B		0x21
+#define TPS68470_REG_SGPO		0x22
+#define TPS68470_REG_PITCTL		0x23
+#define TPS68470_REG_WAKECFG		0x24
+#define TPS68470_REG_IOWAKESTAT		0x25
+#define TPS68470_REG_GPDI		0x26
+#define TPS68470_REG_GPDO		0x27
+#define TPS68470_REG_ILEDCTL		0x28
+#define TPS68470_REG_WLEDSTAT		0x29
+#define TPS68470_REG_VWLEDILIM		0x2A
+#define TPS68470_REG_VWLEDVAL		0x2B
+#define TPS68470_REG_WLEDMAXRER		0x2C
+#define TPS68470_REG_WLEDMAXT		0x2D
+#define TPS68470_REG_WLEDMAXAF		0x2E
+#define TPS68470_REG_WLEDMAXF		0x2F
+#define TPS68470_REG_WLEDTO		0x30
+#define TPS68470_REG_VWLEDCTL		0x31
+#define TPS68470_REG_WLEDTIMER_MSB	0x32
+#define TPS68470_REG_WLEDTIMER_LSB	0x33
+#define TPS68470_REG_WLEDC1		0x34
+#define TPS68470_REG_WLEDC2		0x35
+#define TPS68470_REG_WLEDCTL		0x36
+#define TPS68470_REG_VCMVAL		0x3C
+#define TPS68470_REG_VAUX1VAL		0x3D
+#define TPS68470_REG_VAUX2VAL		0x3E
+#define TPS68470_REG_VIOVAL		0x3F
+#define TPS68470_REG_VSIOVAL		0x40
+#define TPS68470_REG_VAVAL		0x41
+#define TPS68470_REG_VDVAL		0x42
+#define TPS68470_REG_S_I2C_CTL		0x43
+#define TPS68470_REG_VCMCTL		0x44
+#define TPS68470_REG_VAUX1CTL		0x45
+#define TPS68470_REG_VAUX2CTL		0x46
+#define TPS68470_REG_VACTL		0x47
+#define TPS68470_REG_VDCTL		0x48
+#define TPS68470_REG_RESET		0x50
+#define TPS68470_REG_REVID		0xFF
+
+#define TPS68470_REG_MAX		TPS68470_REG_REVID
+
+/* Register field definitions */
+
+#define TPS68470_VAVAL_AVOLT_MASK	GENMASK(6, 0)
+
+#define TPS68470_VDVAL_DVOLT_MASK	GENMASK(5, 0)
+#define TPS68470_VCMVAL_VCVOLT_MASK	GENMASK(6, 0)
+#define TPS68470_VIOVAL_IOVOLT_MASK	GENMASK(6, 0)
+#define TPS68470_VSIOVAL_IOVOLT_MASK	GENMASK(6, 0)
+#define TPS68470_VAUX1VAL_AUX1VOLT_MASK	GENMASK(6, 0)
+#define TPS68470_VAUX2VAL_AUX2VOLT_MASK	GENMASK(6, 0)
+
+#define TPS68470_VACTL_EN_MASK		GENMASK(0, 0)
+#define TPS68470_VDCTL_EN_MASK		GENMASK(0, 0)
+#define TPS68470_VCMCTL_EN_MASK		GENMASK(0, 0)
+#define TPS68470_S_I2C_CTL_EN_MASK	GENMASK(1, 0)
+#define TPS68470_VAUX1CTL_EN_MASK	GENMASK(0, 0)
+#define TPS68470_VAUX2CTL_EN_MASK	GENMASK(0, 0)
+#define TPS68470_PLL_EN_MASK		GENMASK(0, 0)
+
+#define TPS68470_OSC_EXT_CAP_SHIFT	4
+#define TPS68470_OSC_EXT_CAP_DEFAULT	0x05	/* 10pf */
+
+#define TPS68470_CLK_SRC_SHIFT		7
+#define TPS68470_CLK_SRC_GPIO3		0
+#define TPS68470_CLK_SRC_XTAL		1
+
+#define TPS68470_DRV_STR_1MA		0
+#define TPS68470_DRV_STR_2MA		1
+#define TPS68470_DRV_STR_4MA		2
+#define TPS68470_DRV_STR_8MA		3
+#define TPS68470_DRV_STR_A_SHIFT	0
+#define TPS68470_DRV_STR_B_SHIFT	2
+
+#define TPS68470_OUTPUT_XTAL_BUFFERED	1
+#define TPS68470_PLL_OUTPUT_ENABLE	2
+#define TPS68470_PLL_OUTPUT_SS_ENABLE	3
+#define TPS68470_OUTPUT_A_SHIFT		0
+#define TPS68470_OUTPUT_B_SHIFT		2
+
+#define TPS68470_CLKCFG1_MODE_A_MASK	GENMASK(1, 0)
+#define TPS68470_CLKCFG1_MODE_B_MASK	GENMASK(3, 2)
+
+#define TPS68470_GPIO_CTL_REG_A(x)	(TPS68470_REG_GPCTL0A + (x) * 2)
+#define TPS68470_GPIO_CTL_REG_B(x)	(TPS68470_REG_GPCTL0B + (x) * 2)
+#define TPS68470_GPIO_MODE_MASK		GENMASK(1, 0)
+#define TPS68470_GPIO_MODE_IN		0
+#define TPS68470_GPIO_MODE_IN_PULLUP	1
+#define TPS68470_GPIO_MODE_OUT_CMOS	2
+#define TPS68470_GPIO_MODE_OUT_ODRAIN	3
+
+#define TPS68470_PLL_STARTUP_DELAY_US	1000
+#define TPS68470_DAISY_CHAIN_DELAY_US	3000
+
+#endif /* __LINUX_MFD_TPS68470_H */
-- 
1.9.1

