From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] ACPI: Eliminate CONFIG_.*{,_MODULE} #ifdef in favor of IS_ENABLED()
Date: Mon, 14 Sep 2015 16:01:55 +0100
Message-ID: <1442242915-14762-2-git-send-email-sudeep.holla@arm.com>
References: <1442242915-14762-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46654 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156AbbINPCH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2015 11:02:07 -0400
In-Reply-To: <1442242915-14762-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lv Zheng <lv.zheng@intel.com>, Zhang Rui <rui.zhang@intel.com>

This commit removes all CONFIG_.*{,_MODULE} in ACPI code, replacing it
with IS_ENABLED().

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/bus.c             | 12 ++++--------
 drivers/acpi/int340x_thermal.c |  9 ++++-----
 include/acpi/button.h          |  4 ++--
 include/acpi/video.h           |  2 +-
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 46506e7687cd..a212cefae524 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -315,14 +315,10 @@ static void acpi_bus_osc_support(void)
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
-#if defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR) ||\
-			defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR_MODULE)
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
-#endif
-
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
-#endif
+	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR_AGGREGATOR))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 
diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
index 6c7c7975f72e..33505c651f62 100644
--- a/drivers/acpi/int340x_thermal.c
+++ b/drivers/acpi/int340x_thermal.c
@@ -33,13 +33,12 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
-#if defined(CONFIG_INT340X_THERMAL) || defined(CONFIG_INT340X_THERMAL_MODULE)
-	acpi_create_platform_device(adev);
-#elif defined(CONFIG_INTEL_SOC_DTS_THERMAL) || defined(CONFIG_INTEL_SOC_DTS_THERMAL_MODULE)
+	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
+		acpi_create_platform_device(adev);
 	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
-	if (id->driver_data == INT3401_DEVICE)
+	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
+		 id->driver_data == INT3401_DEVICE)
 		acpi_create_platform_device(adev);
-#endif
 	return 1;
 }
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
index 97eea0e4c016..1cad8b2d460c 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -3,7 +3,7 @@
 
 #include <linux/notifier.h>
 
-#if defined(CONFIG_ACPI_BUTTON) || defined(CONFIG_ACPI_BUTTON_MODULE)
+#if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_notifier_register(struct notifier_block *nb);
 extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
 extern int acpi_lid_open(void);
@@ -20,6 +20,6 @@ static inline int acpi_lid_open(void)
 {
 	return 1;
 }
-#endif /* defined(CONFIG_ACPI_BUTTON) || defined(CONFIG_ACPI_BUTTON_MODULE) */
+#endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */
diff --git a/include/acpi/video.h b/include/acpi/video.h
index e840b294c6f5..c62392d9b52a 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -24,7 +24,7 @@ enum acpi_backlight_type {
 	acpi_backlight_native,
 };
 
-#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
+#if IS_ENABLED(CONFIG_ACPI_VIDEO)
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
-- 
1.9.1

