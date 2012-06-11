From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 4/4] RFC Thermal: Platform layer changes to provide thermal data
Date: Mon, 11 Jun 2012 23:09:34 +0530
Message-ID: <1339436374-26881-5-git-send-email-durgadoss.r@intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22592 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab2FLFWz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 01:22:55 -0400
In-Reply-To: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch shows how can we add platform specific thermal data
required by the enhanced thermal framework.
This is just an example patch, and _not_ for merge.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 arch/x86/platform/mrst/mrst.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index e31bcd8..eeb3cd0 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -30,6 +30,7 @@
 #include <linux/mfd/intel_msic.h>
 #include <linux/gpio.h>
 #include <linux/i2c/tc35876x.h>
+#include <linux/thermal.h>
 
 #include <asm/setup.h>
 #include <asm/mpspec_def.h>
@@ -78,6 +79,27 @@ struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
 EXPORT_SYMBOL_GPL(sfi_mrtc_array);
 int sfi_mrtc_num;
 
+#define MRST_THERMAL_ZONES	3
+struct thermal_zone_params tzp[MRST_THERMAL_ZONES] = {
+	{ .thermal_zone_name = "CPU",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 2,
+	.cdevs_name = {"CPU", "Battery"},
+	.weights = {80, 20}, },
+
+	{ .thermal_zone_name = "Battery",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 1,
+	.cdevs_name = {"Battery"},
+	.weights = {100}, },
+
+	{ .thermal_zone_name = "Skin",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_cdevs = 2,
+	.cdevs_name = {"Display", "Battery"},
+	.weights = {50, 50}, }
+};
+
 static void mrst_power_off(void)
 {
 }
@@ -983,10 +1005,27 @@ static int __init sfi_parse_devs(struct sfi_table_header *table)
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
1.7.0.4

