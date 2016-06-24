From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v4 3/3] acpi/pmic: Add support for PMIC regs operation region
Date: Thu, 23 Jun 2016 17:52:53 -0700
Message-ID: <20160624005253.GF83592@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42791 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbcFXAs7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 20:48:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

Broxton platform firmware has defined new customized operation regions
called regs for PMIC chip - regs op region is used to handle the
PMIC gpio mainly intended for the TYPE-C VBUS and Orientation.

The intel_gpio_ctx  structure is created for the purpose of handling
the PMIC gpio register read and write.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Chandra Sekhar Anagani <chandra.sekhar.anagani@intel.com>
Signed-off-by: Bin Gao <bin.gao@intel.com>
---
Changes in v4:
 - various fixes to address Aaron's comments.
Changes in v3: none
Changes in v2: none
 drivers/acpi/pmic/intel_pmic.c | 74 ++++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/pmic/intel_pmic.h |  5 +++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 410e96f..e11d1e0 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -21,12 +21,14 @@
 
 #define PMIC_POWER_OPREGION_ID		0x8d
 #define PMIC_THERMAL_OPREGION_ID	0x8c
+#define PMIC_REGS_OPREGION_ID		0x8f
 
 struct intel_pmic_opregion {
 	struct mutex lock;
 	struct acpi_lpat_conversion_table *lpat_table;
 	struct regmap *regmap;
 	struct intel_pmic_opregion_data *data;
+	struct pmic_gpio_ctx	ctx;
 };
 
 static int pmic_get_reg_bit(int address, struct pmic_table *table,
@@ -204,6 +206,56 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	return AE_OK;
 }
 
+static acpi_status intel_pmic_gpio_handler(u32 function,
+	acpi_physical_address address, u32 bits, u64 *value64,
+		void *handler_context, void *region_context)
+{
+	struct intel_pmic_opregion *opregion = region_context;
+	int result;
+
+	switch (address) {
+	case 0:
+		return AE_OK;
+	case 1:
+		opregion->ctx.address |= (*value64 & 0xff) << 8;
+		return AE_OK;
+	case 2:
+		opregion->ctx.address |= *value64 & 0xff;
+		return AE_OK;
+	case 3:
+		opregion->ctx.value = *value64 & 0xff;
+		return AE_OK;
+	case 4:
+		if (*value64) {
+			result = regmap_write(opregion->regmap,
+					 opregion->ctx.address,
+					opregion->ctx.value);
+		} else {
+			result = regmap_read(opregion->regmap,
+					opregion->ctx.address,
+					&opregion->ctx.value);
+			if (result == 0)
+				*value64 = opregion->ctx.value;
+		}
+		memset(&opregion->ctx, 0x00, sizeof(opregion->ctx));
+		break;
+	default:
+		pr_err("%s(): Inavlid address %llu, please check the BIOS\n",
+							 __func__, address);
+		return AE_ERROR;
+	}
+
+	if (result < 0) {
+		if (result == -EINVAL)
+			return AE_BAD_PARAMETER;
+		else
+			return AE_ERROR;
+	}
+
+	return AE_OK;
+}
+
+
 int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 					struct regmap *regmap,
 					struct intel_pmic_opregion_data *d)
@@ -240,15 +292,31 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 						    intel_pmic_thermal_handler,
 						    NULL, opregion);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
-						  intel_pmic_power_handler);
 		ret = -ENODEV;
-		goto out_error;
+		goto remove_pmic_power_handler;
+	}
+
+	status = acpi_install_address_space_handler(handle,
+						    PMIC_REGS_OPREGION_ID,
+						    intel_pmic_gpio_handler,
+						    NULL, opregion);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto remove_pmic_thermal_handler;
 	}
 
 	opregion->data = d;
 	return 0;
 
+remove_pmic_thermal_handler:
+		acpi_remove_address_space_handler(handle,
+						PMIC_POWER_OPREGION_ID,
+						intel_pmic_thermal_handler);
+remove_pmic_power_handler:
+		acpi_remove_address_space_handler(handle,
+						PMIC_POWER_OPREGION_ID,
+						intel_pmic_power_handler);
+
 out_error:
 	acpi_lpat_free_conversion_table(opregion->lpat_table);
 	return ret;
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index e8bfa7b..c87c2ef 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -7,6 +7,11 @@ struct pmic_table {
 	int bit;	/* control bit for power */
 };
 
+struct pmic_gpio_ctx {
+	u16 address;		/* pmic regs address */
+	unsigned int value;	/* value to write @regs address */
+};
+
 struct intel_pmic_opregion_data {
 	int (*get_power)(struct regmap *r, int reg, int bit, u64 *value);
 	int (*update_power)(struct regmap *r, int reg, int bit, bool on);
-- 
1.9.1


