From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] ACPI: int340x_thermal: add missing CONFIG_ prefix
Date: Mon, 14 Sep 2015 16:01:54 +0100
Message-ID: <1442242915-14762-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46648 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354AbbINPCD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2015 11:02:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lv Zheng <lv.zheng@intel.com>, Zhang Rui <rui.zhang@intel.com>

This patch adds the missing CONFIG_ prefix to INTEL_SOC_DTS_THERMAL
macros.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/int340x_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
index 9dcf83682e36..6c7c7975f72e 100644
--- a/drivers/acpi/int340x_thermal.c
+++ b/drivers/acpi/int340x_thermal.c
@@ -35,7 +35,7 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 {
 #if defined(CONFIG_INT340X_THERMAL) || defined(CONFIG_INT340X_THERMAL_MODULE)
 	acpi_create_platform_device(adev);
-#elif defined(INTEL_SOC_DTS_THERMAL) || defined(INTEL_SOC_DTS_THERMAL_MODULE)
+#elif defined(CONFIG_INTEL_SOC_DTS_THERMAL) || defined(CONFIG_INTEL_SOC_DTS_THERMAL_MODULE)
 	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
 	if (id->driver_data == INT3401_DEVICE)
 		acpi_create_platform_device(adev);
-- 
1.9.1

