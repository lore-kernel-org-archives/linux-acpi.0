From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 14/14] Thermal: Platform layer changes to provide thermal data
Date: Mon, 27 Aug 2012 09:58:26 +0530
Message-ID: <1346041706-29642-15-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2H0E3c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:32 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch shows how can we add platform specific thermal data
required by the thermal framework. This is just an example
patch, and _not_ for merge.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 arch/x86/platform/mrst/mrst.c |   49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index fd41a92..91587bf 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -30,6 +30,7 @@
 #include <linux/mfd/intel_msic.h>
 #include <linux/gpio.h>
 #include <linux/i2c/tc35876x.h>
+#include <linux/thermal.h>
 
 #include <asm/setup.h>
 #include <asm/mpspec_def.h>
@@ -78,6 +79,37 @@ struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
 EXPORT_SYMBOL_GPL(sfi_mrtc_array);
 int sfi_mrtc_num;
 
+static int thermal_match(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev)
+{
+	if (!strcmp(tz->type, "CPU")) {
+		if (!strcmp(cdev->type, "CPU") ||
+			!strcmp(cdev->type, "Battery"))
+			return 0;
+	}
+	return 1;
+}
+
+static struct thermal_bind_params tz_cpu_params[2] = {
+	{.cdev = NULL,
+	.weight = 80,
+	.trip_mask = 0x0F,
+	.match = thermal_match, },
+
+	{ .cdev = NULL,
+	.weight = 80,
+	.trip_mask = 0x0F,
+	.match = thermal_match, },
+	};
+
+#define MRST_THERMAL_ZONES      1
+struct thermal_zone_params tzp[MRST_THERMAL_ZONES] = {
+	{ .zone_name = "CPU",
+	.throttle_policy = THERMAL_FAIR_SHARE,
+	.num_tbps = 2,
+	.tbp = tz_cpu_params, }
+};
+
 static void mrst_power_off(void)
 {
 }
@@ -983,10 +1015,27 @@ static int __init sfi_parse_devs(struct sfi_table_header *table)
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

