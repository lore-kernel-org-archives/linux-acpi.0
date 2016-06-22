From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/2] acpi: pmic: intel: add REGS operation region support
Date: Wed, 22 Jun 2016 17:55:39 +0300
Message-ID: <1466607340-88687-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Bin Gao <bin.gao@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Felipe Balbi <felipe.balbi@linux.intel.com>

At least some of the Broxtons have a third custom OpRegion
named REGS. This adds handling for it.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index bd772cd..3a3d416 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -21,12 +21,19 @@
 
 #define PMIC_POWER_OPREGION_ID		0x8d
 #define PMIC_THERMAL_OPREGION_ID	0x8c
+#define PMIC_REGS_OPREGION_ID		0x8f
+
+struct intel_pmic_regs_handler_ctx {
+	unsigned int val;
+	u16 addr;
+};
 
 struct intel_pmic_opregion {
 	struct mutex lock;
 	struct acpi_lpat_conversion_table *lpat_table;
 	struct regmap *regmap;
 	struct intel_pmic_opregion_data *data;
+	struct intel_pmic_regs_handler_ctx ctx;
 };
 
 static int pmic_get_reg_bit(int address, struct pmic_table *table,
@@ -203,6 +210,48 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	return AE_OK;
 }
 
+static acpi_status intel_pmic_regs_handler(u32 function,
+		acpi_physical_address address, u32 bits, u64 *value64,
+		void *handler_context, void *region_context)
+{
+	struct intel_pmic_opregion *opregion = region_context;
+	int result;
+
+	switch (address) {
+	case 0:
+		return AE_OK;
+	case 1:
+		opregion->ctx.addr |= (*value64 & 0xff) << 8;
+		return AE_OK;
+	case 2:
+		opregion->ctx.addr |= *value64 & 0xff;
+		return AE_OK;
+	case 3:
+		opregion->ctx.val = *value64 & 0xff;
+		return AE_OK;
+	case 4:
+		if (*value64) {
+			result = regmap_write(opregion->regmap, opregion->ctx.addr,
+					      opregion->ctx.val);
+		} else {
+			result = regmap_read(opregion->regmap, opregion->ctx.addr,
+					     &opregion->ctx.val);
+			if (result == 0)
+				*value64 = opregion->ctx.val;
+		}
+		memset(&opregion->ctx, 0x00, sizeof(opregion->ctx));
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
 int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 					struct regmap *regmap,
 					struct intel_pmic_opregion_data *d)
@@ -242,12 +291,28 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
 						  intel_pmic_power_handler);
 		ret = -ENODEV;
-		goto out_error;
+		goto out_remove_power_handler;
+	}
+
+	status = acpi_install_address_space_handler(handle,
+			PMIC_REGS_OPREGION_ID, intel_pmic_regs_handler, NULL,
+			opregion);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto out_remove_thermal_handler;
 	}
 
 	opregion->data = d;
 	return 0;
 
+out_remove_thermal_handler:
+	acpi_remove_address_space_handler(handle, PMIC_THERMAL_OPREGION_ID,
+					  intel_pmic_thermal_handler);
+
+out_remove_power_handler:
+	acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
+					  intel_pmic_power_handler);
+
 out_error:
 	acpi_lpat_free_conversion_table(opregion->lpat_table);
 	return ret;
-- 
2.8.1
