From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / PMIC: Add opregion driver for Intel CHT WhiskeyCove PMIC
Date: Mon, 27 Feb 2017 11:20:23 +0100
Message-ID: <20170227102023.10272-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbdB0Lhd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 06:37:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>

Add opregion driver for Intel CHT WhiskeyCove PMIC, based on various
non upstreamed CHT WhiskeyCove PMIC patches. This does not include
support for the Thermal opregion (DPTF) due to lacking documentation.

Cc: Bin Gao <bin.gao@intel.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/Kconfig                 |   6 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/pmic/intel_pmic_chtwc.c | 236 +++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_chtwc.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 83e5f7e..41c9f4c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -516,6 +516,12 @@ config BXT_WC_PMIC_OPREGION
 	help
 	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
 
+config CHT_WC_PMIC_OPREGION
+	bool "ACPI operation region support for CHT WhiskeyCove PMIC"
+	depends on INTEL_SOC_PMIC
+	help
+	  This config adds ACPI operation region support for CHT WhiskeyCove PMIC.
+
 endif
 
 config ACPI_CONFIGFS
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9ed0878..1256830 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
+obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
 
 obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
new file mode 100644
index 0000000..d197805
--- /dev/null
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -0,0 +1,236 @@
+/*
+ * intel_pmic_chtwc.c - Intel CHT WhiskeyCove PMIC operation region driver
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
+ * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/mfd/intel_chtwc.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include "intel_pmic.h"
+
+/*
+ * Regulator support is based on the non upstream patch:
+ * "regulator: whiskey_cove: implements WhiskeyCove pmic VRF support"
+ */
+static struct pmic_table power_table[] = {
+	{
+		.address = 0x0,
+		.reg = CHT_WC_V1P8A_CTRL,
+		.bit = 0x01,
+	}, /* V18A */
+	{
+		.address = 0x04,
+		.reg = CHT_WC_V1P8SX_CTRL,
+		.bit = 0x07,
+	}, /* V18X */
+	{
+		.address = 0x08,
+		.reg = CHT_WC_VDDQ_CTRL,
+		.bit = 0x01,
+	}, /* VDDQ */
+	{
+		.address = 0x0c,
+		.reg = CHT_WC_V1P2A_CTRL,
+		.bit = 0x07,
+	}, /* V12A */
+	{
+		.address = 0x10,
+		.reg = CHT_WC_V1P2SX_CTRL,
+		.bit = 0x07,
+	}, /* V12X */
+	{
+		.address = 0x14,
+		.reg = CHT_WC_V2P8SX_CTRL,
+		.bit = 0x07,
+	}, /* V28X */
+	{
+		.address = 0x18,
+		.reg = CHT_WC_V3P3A_CTRL,
+		.bit = 0x01,
+	}, /* V33A */
+	{
+		.address = 0x1c,
+		.reg = CHT_WC_V3P3SD_CTRL,
+		.bit = 0x07,
+	}, /* V3SD */
+	{
+		.address = 0x20,
+		.reg = CHT_WC_VSDIO_CTRL,
+		.bit = 0x07,
+	}, /* VSD */
+/*	{
+		.address = 0x24,
+		.reg = ??,
+		.bit = ??,
+	}, ** VSW2 */
+/*	{
+		.address = 0x28,
+		.reg = ??,
+		.bit = ??,
+	}, ** VSW1 */
+/*	{
+		.address = 0x2c,
+		.reg = ??,
+		.bit = ??,
+	}, ** VUPY */
+/*	{
+		.address = 0x30,
+		.reg = ??,
+		.bit = ??,
+	}, ** VRSO */
+	{
+		.address = 0x34,
+		.reg = CHT_WC_VPROG1A_CTRL,
+		.bit = 0x07,
+	}, /* VP1A */
+	{
+		.address = 0x38,
+		.reg = CHT_WC_VPROG1B_CTRL,
+		.bit = 0x07,
+	}, /* VP1B */
+	{
+		.address = 0x3c,
+		.reg = CHT_WC_VPROG1F_CTRL,
+		.bit = 0x07,
+	}, /* VP1F */
+	{
+		.address = 0x40,
+		.reg = CHT_WC_VPROG2D_CTRL,
+		.bit = 0x07,
+	}, /* VP2D */
+	{
+		.address = 0x44,
+		.reg = CHT_WC_VPROG3A_CTRL,
+		.bit = 0x07,
+	}, /* VP3A */
+	{
+		.address = 0x48,
+		.reg = CHT_WC_VPROG3B_CTRL,
+		.bit = 0x07,
+	}, /* VP3B */
+	{
+		.address = 0x4c,
+		.reg = CHT_WC_VPROG4A_CTRL,
+		.bit = 0x07,
+	}, /* VP4A */
+	{
+		.address = 0x50,
+		.reg = CHT_WC_VPROG4B_CTRL,
+		.bit = 0x07,
+	}, /* VP4B */
+	{
+		.address = 0x54,
+		.reg = CHT_WC_VPROG4C_CTRL,
+		.bit = 0x07,
+	}, /* VP4C */
+	{
+		.address = 0x58,
+		.reg = CHT_WC_VPROG4D_CTRL,
+		.bit = 0x07,
+	}, /* VP4D */
+	{
+		.address = 0x5c,
+		.reg = CHT_WC_VPROG5A_CTRL,
+		.bit = 0x07,
+	}, /* VP5A */
+	{
+		.address = 0x60,
+		.reg = CHT_WC_VPROG5B_CTRL,
+		.bit = 0x07,
+	}, /* VP5B */
+	{
+		.address = 0x64,
+		.reg = CHT_WC_VPROG6A_CTRL,
+		.bit = 0x07,
+	}, /* VP6A */
+	{
+		.address = 0x68,
+		.reg = CHT_WC_VPROG6B_CTRL,
+		.bit = 0x07,
+	}, /* VP6B */
+/*	{
+		.address = 0x6c,
+		.reg = ??,
+		.bit = ??,
+	}  ** VP7A */
+};
+
+static int intel_cht_wc_pmic_get_power(struct regmap *regmap, int reg,
+		int bit, u64 *value)
+{
+	int data;
+
+	if (regmap_read(regmap, reg, &data))
+		return -EIO;
+
+	*value = (data & bit) ? 1 : 0;
+	return 0;
+}
+
+static int intel_cht_wc_pmic_update_power(struct regmap *regmap, int reg,
+		int bit, bool on)
+{
+	u8 val, mask = bit;
+
+	if (on)
+		val = 0x01;
+	else
+		val = 0x00;
+
+	return regmap_update_bits(regmap, reg, mask, val);
+}
+
+/*
+ * The thermal table and ops are empty, we do not support the Thermal opregion
+ * (DPTF) due to lacking documentation.
+ */
+static struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
+	.get_power		= intel_cht_wc_pmic_get_power,
+	.update_power		= intel_cht_wc_pmic_update_power,
+	.power_table		= power_table,
+	.power_table_count	= ARRAY_SIZE(power_table),
+};
+
+static int intel_cht_wc_pmic_opregion_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+
+	return intel_pmic_install_opregion_handler(&pdev->dev,
+			ACPI_HANDLE(pdev->dev.parent),
+			pmic->regmap,
+			&intel_cht_wc_pmic_opregion_data);
+}
+
+static struct platform_device_id cht_wc_opregion_id_table[] = {
+	{ .name = "cht_wcove_region" },
+	{},
+};
+
+static struct platform_driver intel_cht_wc_pmic_opregion_driver = {
+	.probe = intel_cht_wc_pmic_opregion_probe,
+	.driver = {
+		.name = "cht_whiskey_cove_pmic",
+	},
+	.id_table = cht_wc_opregion_id_table,
+};
+
+static int __init intel_cht_wc_pmic_opregion_driver_init(void)
+{
+	return platform_driver_register(&intel_cht_wc_pmic_opregion_driver);
+}
+device_initcall(intel_cht_wc_pmic_opregion_driver_init);
-- 
2.9.3

