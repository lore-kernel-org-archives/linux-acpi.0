From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 05/13] Thermal: Obtain platform data for thermal zone
Date: Thu,  9 Aug 2012 18:15:57 +0530
Message-ID: <1344516365-7230-6-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab2HIMq0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:26 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch retrieves the platform level data for
a zone during its registration. It is not an error
to not have any platform data.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index f043cd6..243a3f0 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -142,6 +142,22 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
+static void retrieve_zone_params(struct thermal_zone_device *tz)
+{
+	int ret;
+
+	/* Check whether the platform data pointer is defined */
+	if (!get_platform_thermal_params)
+		return;
+
+	ret = get_platform_thermal_params(tz);
+	if (ret) {
+		dev_err(&tz->device,
+		"parameters for zone %s not defined:%d\n", tz->type, ret);
+		tz->tzp = NULL;
+	}
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -1460,6 +1476,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Retrieve platform level parameters for this zone */
+	retrieve_zone_params(tz);
+
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	if (ops->bind)
-- 
1.7.9.5

