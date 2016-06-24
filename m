From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v4 1/3] acpi/pmic: modify the pen function signature to take
 bit field
Date: Thu, 23 Jun 2016 17:45:35 -0700
Message-ID: <20160624004535.GD83592@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10031 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbcFXAll (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 20:41:41 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

Issue description: On some pmics, the policy enable for thermal alerts
refers to different bit fields of the same registers, whereas on other
pmics, the policy enable refers to the same bit field on different
registers. Previous implementation did not provide the flexibility for
supporting the first approach.

Solution: Modified the policy enable function to take bit field as well.
The use of bit field is left to the pmic specific opregion driver.

Signed-off-by: Yegnesh Iyer <yegnesh.s.iyer@intel.com>
Signed-off-by: Bin Gao <bin.gao@intel.com>
---
Changes in v4: none
Changes in v3: none
Changes in v2:
 - Fixed subject line.
 drivers/acpi/pmic/intel_pmic.c     | 13 +++++++------
 drivers/acpi/pmic/intel_pmic.h     |  4 ++--
 drivers/acpi/pmic/intel_pmic_crc.c |  5 +++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index bd772cd..410e96f 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -131,7 +131,7 @@ static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
 }
 
 static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
-			    u32 function, u64 *value)
+			    int bit, u32 function, u64 *value)
 {
 	struct intel_pmic_opregion_data *d = opregion->data;
 	struct regmap *regmap = opregion->regmap;
@@ -140,12 +140,12 @@ static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
 		return -ENXIO;
 
 	if (function == ACPI_READ)
-		return d->get_policy(regmap, reg, value);
+		return d->get_policy(regmap, reg, bit, value);
 
 	if (*value != 0 && *value != 1)
 		return -EINVAL;
 
-	return d->update_policy(regmap, reg, *value);
+	return d->update_policy(regmap, reg, bit, *value);
 }
 
 static bool pmic_thermal_is_temp(int address)
@@ -170,13 +170,13 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 {
 	struct intel_pmic_opregion *opregion = region_context;
 	struct intel_pmic_opregion_data *d = opregion->data;
-	int reg, result;
+	int reg, bit, result;
 
 	if (bits != 32 || !value64)
 		return AE_BAD_PARAMETER;
 
 	result = pmic_get_reg_bit(address, d->thermal_table,
-				  d->thermal_table_count, &reg, NULL);
+				  d->thermal_table_count, &reg, &bit);
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
@@ -187,7 +187,8 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	else if (pmic_thermal_is_aux(address))
 		result = pmic_thermal_aux(opregion, reg, function, value64);
 	else if (pmic_thermal_is_pen(address))
-		result = pmic_thermal_pen(opregion, reg, function, value64);
+		result = pmic_thermal_pen(opregion, reg, bit,
+						function, value64);
 	else
 		result = -EINVAL;
 
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index d4e90af..e8bfa7b 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -12,8 +12,8 @@ struct intel_pmic_opregion_data {
 	int (*update_power)(struct regmap *r, int reg, int bit, bool on);
 	int (*get_raw_temp)(struct regmap *r, int reg);
 	int (*update_aux)(struct regmap *r, int reg, int raw_temp);
-	int (*get_policy)(struct regmap *r, int reg, u64 *value);
-	int (*update_policy)(struct regmap *r, int reg, int enable);
+	int (*get_policy)(struct regmap *r, int reg, int bit, u64 *value);
+	int (*update_policy)(struct regmap *r, int reg, int bit, int enable);
 	struct pmic_table *power_table;
 	int power_table_count;
 	struct pmic_table *thermal_table;
diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
index fcd1852..d7f1761 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_crc.c
@@ -141,7 +141,8 @@ static int intel_crc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
 		regmap_update_bits(regmap, reg - 1, 0x3, raw >> 8) ? -EIO : 0;
 }
 
-static int intel_crc_pmic_get_policy(struct regmap *regmap, int reg, u64 *value)
+static int intel_crc_pmic_get_policy(struct regmap *regmap,
+					int reg, int bit, u64 *value)
 {
 	int pen;
 
@@ -152,7 +153,7 @@ static int intel_crc_pmic_get_policy(struct regmap *regmap, int reg, u64 *value)
 }
 
 static int intel_crc_pmic_update_policy(struct regmap *regmap,
-					int reg, int enable)
+					int reg, int bit, int enable)
 {
 	int alert0;
 
-- 
1.9.1

