From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] ACPI / PMIC: make intel_pmic_opregion_data structures const
Date: Fri,  3 Nov 2017 16:03:48 +0100
Message-ID: <1509721428-6147-3-git-send-email-bhumirks@gmail.com>
References: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Make these structures as const as they are only passed to the function
intel_pmic_install_opregion_handler having the argument as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/acpi/pmic/intel_pmic_bxtwc.c  | 2 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c  | 2 +-
 drivers/acpi/pmic/intel_pmic_crc.c    | 2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index 90011aa..fd698c6 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -377,7 +377,7 @@ static int intel_bxtwc_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	return regmap_update_bits(regmap, reg, mask, val);
 }
 
-static struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
 	.get_power      = intel_bxtwc_pmic_get_power,
 	.update_power   = intel_bxtwc_pmic_update_power,
 	.get_raw_temp   = intel_bxtwc_pmic_get_raw_temp,
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 85636d7..240359b 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -243,7 +243,7 @@ static int intel_cht_wc_pmic_update_power(struct regmap *regmap, int reg,
  * The thermal table and ops are empty, we do not support the Thermal opregion
  * (DPTF) due to lacking documentation.
  */
-static struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
 	.get_power		= intel_cht_wc_pmic_get_power,
 	.update_power		= intel_cht_wc_pmic_update_power,
 	.power_table		= power_table,
diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
index d7f1761..cad1fe1 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_crc.c
@@ -174,7 +174,7 @@ static int intel_crc_pmic_update_policy(struct regmap *regmap,
 	return 0;
 }
 
-static struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
 	.get_power	= intel_crc_pmic_get_power,
 	.update_power	= intel_crc_pmic_update_power,
 	.get_raw_temp	= intel_crc_pmic_get_raw_temp,
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 6c99d3f..96718af 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -231,7 +231,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	return ret;
 }
 
-static struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
+static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.get_power = intel_xpower_pmic_get_power,
 	.update_power = intel_xpower_pmic_update_power,
 	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
-- 
1.9.1
