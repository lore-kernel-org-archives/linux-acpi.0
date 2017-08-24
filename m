From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC
Date: Thu, 24 Aug 2017 10:11:41 +0200
Message-ID: <20170824081141.5018-4-tiwai@suse.de>
References: <20170824081141.5018-1-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824081141.5018-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds the opregion driver for Dollar Cove TI PMIC on Intel
Cherry Trail devices.  The patch is based on the original work by
Intel, found at:
      https://github.com/01org/ProductionKernelQuilts
with many cleanups and rewrites.

The driver is currently provided only as built-in to follow other
PMIC opregion drivers convention.

The re-enumeration of devices at probe is required for fixing the
issues on HP x2 210 G2.  See bug#195689.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195689
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2:
* get_raw_temp cleanup in opregion driver, mention about register
  endianess

 drivers/acpi/Kconfig                 |   6 ++
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/pmic/intel_pmic_dc_ti.c | 139 +++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_dc_ti.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f84dc23..9da8dcefde7b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,6 +521,12 @@ config CHT_WC_PMIC_OPREGION
 	help
 	  This config adds ACPI operation region support for CHT Whiskey Cove PMIC.
 
+config DC_TI_PMIC_OPREGION
+	bool "ACPI operation region support for Dollar Cove TI PMIC"
+	depends on INTEL_SOC_PMIC_DC_TI
+	help
+	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
+
 endif
 
 config ACPI_CONFIGFS
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b1aacfc62b1f..0a9008b971af 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
+obj-$(CONFIG_DC_TI_PMIC_OPREGION) += pmic/intel_pmic_dc_ti.o
 
 obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
diff --git a/drivers/acpi/pmic/intel_pmic_dc_ti.c b/drivers/acpi/pmic/intel_pmic_dc_ti.c
new file mode 100644
index 000000000000..a2be1270eeeb
--- /dev/null
+++ b/drivers/acpi/pmic/intel_pmic_dc_ti.c
@@ -0,0 +1,139 @@
+/*
+ * Dollar Cove TI PMIC operation region driver
+ * Copyright (C) 2014 Intel Corporation. All rights reserved.
+ *
+ * Rewritten and cleaned up
+ * Copyright (C) 2017 Takashi Iwai <tiwai@suse.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/platform_device.h>
+#include "intel_pmic.h"
+
+/* registers stored in 16bit BE (high:low, total 10bit) */
+#define DC_TI_VBAT	0x54
+#define DC_TI_DIETEMP	0x56
+#define DC_TI_BPTHERM	0x58
+#define DC_TI_GPADC	0x5a
+
+static struct pmic_table dc_ti_power_table[] = {
+	{ .address = 0x00, .reg = 0x41 },
+	{ .address = 0x04, .reg = 0x42 },
+	{ .address = 0x08, .reg = 0x43 },
+	{ .address = 0x0c, .reg = 0x45 },
+	{ .address = 0x10, .reg = 0x46 },
+	{ .address = 0x14, .reg = 0x47 },
+	{ .address = 0x18, .reg = 0x48 },
+	{ .address = 0x1c, .reg = 0x49 },
+	{ .address = 0x20, .reg = 0x4a },
+	{ .address = 0x24, .reg = 0x4b },
+	{ .address = 0x28, .reg = 0x4c },
+	{ .address = 0x2c, .reg = 0x4d },
+	{ .address = 0x30, .reg = 0x4e },
+};
+
+static struct pmic_table dc_ti_thermal_table[] = {
+	{
+		.address = 0x00,
+		.reg = DC_TI_GPADC
+	},
+	{
+		.address = 0x0c,
+		.reg = DC_TI_GPADC
+	},
+	/* TMP2 -> SYSTEMP */
+	{
+		.address = 0x18,
+		.reg = DC_TI_GPADC
+	},
+	/* TMP3 -> BPTHERM */
+	{
+		.address = 0x24,
+		.reg = DC_TI_BPTHERM
+	},
+	{
+		.address = 0x30,
+		.reg = DC_TI_GPADC
+	},
+	/* TMP5 -> DIETEMP */
+	{
+		.address = 0x3c,
+		.reg = DC_TI_DIETEMP
+	},
+};
+
+static int dc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
+				u64 *value)
+{
+	int data;
+
+	if (regmap_read(regmap, reg, &data))
+		return -EIO;
+
+	*value = data & 1;
+	return 0;
+}
+
+static int dc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
+				   bool on)
+{
+	return regmap_update_bits(regmap, reg, 1, on);
+}
+
+static int dc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
+{
+	u8 buf[2];
+	unsigned int val;
+
+	if (regmap_bulk_read(regmap, reg, buf, 2))
+		return -EIO;
+
+	/* stored in big-endian */
+	val = buf[0] & 0x03;
+	return (val << 8) | buf[1];
+}
+
+static struct intel_pmic_opregion_data dc_ti_pmic_opregion_data = {
+	.get_power = dc_ti_pmic_get_power,
+	.update_power = dc_ti_pmic_update_power,
+	.get_raw_temp = dc_ti_pmic_get_raw_temp,
+	.power_table = dc_ti_power_table,
+	.power_table_count = ARRAY_SIZE(dc_ti_power_table),
+	.thermal_table = dc_ti_thermal_table,
+	.thermal_table_count = ARRAY_SIZE(dc_ti_thermal_table),
+};
+
+static int dc_ti_pmic_opregion_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	int err;
+
+	err = intel_pmic_install_opregion_handler(&pdev->dev,
+			ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
+			&dc_ti_pmic_opregion_data);
+	if (err < 0)
+		return err;
+
+	/* Re-enumerate devices depending on PMIC */
+	acpi_walk_dep_device_list(ACPI_HANDLE(pdev->dev.parent));
+	return 0;
+}
+
+static struct platform_device_id dc_ti_pmic_opregion_id_table[] = {
+	{ .name = "dc_ti_region" },
+	{},
+};
+
+static struct platform_driver dc_ti_pmic_opregion_driver = {
+	.probe = dc_ti_pmic_opregion_probe,
+	.driver = {
+		.name = "dollar_cove_ti_pmic",
+	},
+	.id_table = dc_ti_pmic_opregion_id_table,
+};
+module_platform_driver(dc_ti_pmic_opregion_driver);
+
+MODULE_DESCRIPTION("Dollar Cove TI PMIC opregion driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.0
