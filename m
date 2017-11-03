From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] ACPI / PMIC: Make some pointers, structure field and function argument as const
Date: Fri,  3 Nov 2017 16:03:47 +0100
Message-ID: <1509721428-6147-2-git-send-email-bhumirks@gmail.com>
References: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Make some pointers of type intel_pmic_opregion_data as const as they
do not modify the fields of the structure they point too.
After this change, make the data field of intel_pmic_opregion
structure const as this data field is used for initializing the above pointers
that are now const.
Finally, make the struct intel_pmic_opregion_data * argument of the
function intel_pmic_install_opregion_handler as const as it is only
getting stored in the data field of the intel_pmic_opregion
structure which is now made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/acpi/pmic/intel_pmic.c | 10 +++++-----
 drivers/acpi/pmic/intel_pmic.h |  4 +++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index ca18e0d..553fa4f 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -32,7 +32,7 @@ struct intel_pmic_opregion {
 	struct mutex lock;
 	struct acpi_lpat_conversion_table *lpat_table;
 	struct regmap *regmap;
-	struct intel_pmic_opregion_data *data;
+	const struct intel_pmic_opregion_data *data;
 	struct intel_pmic_regs_handler_ctx ctx;
 };
 
@@ -58,7 +58,7 @@ static acpi_status intel_pmic_power_handler(u32 function,
 {
 	struct intel_pmic_opregion *opregion = region_context;
 	struct regmap *regmap = opregion->regmap;
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	int reg, bit, result;
 
 	if (bits != 32 || !value64)
@@ -140,7 +140,7 @@ static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
 static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
 			    int bit, u32 function, u64 *value)
 {
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	struct regmap *regmap = opregion->regmap;
 
 	if (!d->get_policy || !d->update_policy)
@@ -176,7 +176,7 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 		void *handler_context, void *region_context)
 {
 	struct intel_pmic_opregion *opregion = region_context;
-	struct intel_pmic_opregion_data *d = opregion->data;
+	const struct intel_pmic_opregion_data *d = opregion->data;
 	int reg, bit, result;
 
 	if (bits != 32 || !value64)
@@ -255,7 +255,7 @@ static acpi_status intel_pmic_regs_handler(u32 function,
 
 int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 					struct regmap *regmap,
-					struct intel_pmic_opregion_data *d)
+					const struct intel_pmic_opregion_data *d)
 {
 	acpi_status status;
 	struct intel_pmic_opregion *opregion;
diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
index e8bfa7b..754b7bd 100644
--- a/drivers/acpi/pmic/intel_pmic.h
+++ b/drivers/acpi/pmic/intel_pmic.h
@@ -20,6 +20,8 @@ struct intel_pmic_opregion_data {
 	int thermal_table_count;
 };
 
-int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle, struct regmap *regmap, struct intel_pmic_opregion_data *d);
+int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
+					struct regmap *regmap,
+					const struct intel_pmic_opregion_data *d);
 
 #endif
-- 
1.9.1
