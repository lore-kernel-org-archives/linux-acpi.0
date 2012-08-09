From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 13/13] Thermal: Platform layer changes to provide thermal data
Date: Thu,  9 Aug 2012 18:16:05 +0530
Message-ID: <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469Ab2HIMqu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:50 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch shows how can we add platform specific thermal data
required by the thermal framework. This is just an example
patch, and _not_ for merge.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 arch/x86/platform/mrst/mrst.c |   42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index fd41a92..0440db5 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -30,6 +30,7 @@
 #include <linux/mfd/intel_msic.h>
 #include <linux/gpio.h>
 #include <linux/i2c/tc35876x.h>
+#include <linux/thermal.h>
 
 #include <asm/setup.h>
 #include <asm/mpspec_def.h>
@@ -78,6 +79,30 @@ struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
 EXPORT_SYMBOL_GPL(sfi_mrtc_array);
 int sfi_mrtc_num;
 
+#define MRST_THERMAL_ZONES	3
+struct thermal_zone_params tzp[MRST_THERMAL_ZONES] = {
+	{ .thermal_zone_name = "CPU",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 2,
+	.cdevs_name = {"CPU", "Battery"},
+	.trip_mask = {0x0F, 0x08},
+	.weights = {80, 20}, },
+
+	{ .thermal_zone_name = "Battery",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 1,
+	.cdevs_name = {"Battery"},
+	.trip_mask = {0x0F},
+	.weights = {100}, },
+
+	{ .thermal_zone_name = "Skin",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 2,
+	.cdevs_name = {"Display", "Battery"},
+	.trip_mask = {0x0F, 0x0F},
+	.weights = {50, 50}, }
+};
+
 static void mrst_power_off(void)
 {
 }
@@ -983,10 +1008,27 @@ static int __init sfi_parse_devs(struct sfi_table_header *table)
 	return 0;
 }
 
+static int mrst_get_thermal_params(struct thermal_zone_device *tz)
+{
+	int i;
+
+	for (i = 0; i < MRST_THERMAL_ZONES; i++) {
+		if (!strcmp(tzp[i].thermal_zone_name, tz->type)) {
+			tz->tzp = &tzp[i];
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
 static int __init mrst_platform_init(void)
 {
 	sfi_table_parse(SFI_SIG_GPIO, NULL, NULL, sfi_parse_gpio);
 	sfi_table_parse(SFI_SIG_DEVS, NULL, NULL, sfi_parse_devs);
+
+	/* Set platform thermal data pointer */
+	get_platform_thermal_params = mrst_get_thermal_params;
+
 	return 0;
 }
 arch_initcall(mrst_platform_init);
-- 
1.7.9.5

