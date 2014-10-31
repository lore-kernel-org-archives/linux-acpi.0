From: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] ACPI / pmic_opregion: AXP288: support virtual GPIO in ACPI table
Date: Fri, 31 Oct 2014 14:08:25 +0800
Message-ID: <1414735705-18366-4-git-send-email-aaron.lu@intel.com>
References: <1414735705-18366-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414735705-18366-1-git-send-email-aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The same virtual GPIO strategy is also used for the AXP288 PMIC in that
various control methods that are used to do power rail handling and
sensor reading/setting will touch GPIO fields defined under the PMIC
device. The GPIO fileds are only defined by the ACPI code while the
actual hardware doesn't really have a GPIO controller, but to make those
control method execution succeed, we have to install a GPIO handler for
the PMIC device handle. Since we do not need the virtual GPIO strategy,
we can simply do nothing in that handler.

Signed-off-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../pmic_opregion/intel_soc_pmic_xpower_opregion.c | 27 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pmic_opregion/intel_soc_pmic_xpower_opregion.c b/drivers/acpi/pmic_opregion/intel_soc_pmic_xpower_opregion.c
index ab462708aecf..e25c83da90a5 100644
--- a/drivers/acpi/pmic_opregion/intel_soc_pmic_xpower_opregion.c
+++ b/drivers/acpi/pmic_opregion/intel_soc_pmic_xpower_opregion.c
@@ -251,13 +251,32 @@ static struct intel_soc_pmic_opregion_data intel_xpower_pmic_opregion_data = {
 	.dptf_table_count = ARRAY_SIZE(dptf_table),
 };
 
+static acpi_status intel_xpower_pmic_gpio_handler(u32 function,
+		acpi_physical_address address, u32 bit_width, u64 *value,
+		void *handler_context, void *region_context)
+{
+	return AE_OK;
+}
 
 static int intel_xpower_pmic_opregion_probe(struct platform_device *pdev)
 {
-	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
-	return intel_soc_pmic_install_opregion_handler(&pdev->dev,
-			ACPI_HANDLE(pdev->dev.parent), axp20x->regmap,
-			&intel_xpower_pmic_opregion_data);
+	struct device *parent = pdev->dev.parent;
+	struct axp20x_dev *axp20x = dev_get_drvdata(parent);
+	acpi_status status;
+	int result;
+
+	result = intel_soc_pmic_install_opregion_handler(&pdev->dev,
+					ACPI_HANDLE(parent), axp20x->regmap,
+					&intel_xpower_pmic_opregion_data);
+	if (!result) {
+		status = acpi_install_address_space_handler(
+				ACPI_HANDLE(parent), ACPI_ADR_SPACE_GPIO,
+				intel_xpower_pmic_gpio_handler, NULL, NULL);
+		if (ACPI_FAILURE(status))
+			result = -ENODEV;
+	}
+
+	return result;
 }
 
 static struct platform_driver intel_xpower_pmic_opregion_driver = {
-- 
1.9.3
