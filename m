From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 05/14] Thermal: Obtain platform data for thermal zone
Date: Mon, 27 Aug 2012 09:58:17 +0530
Message-ID: <1346041706-29642-6-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab2H0E3O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:14 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch retrieves the platform level data for
a zone during its registration. It is not an error
to not have any platform data.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 92a187c..6adda39 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1339,6 +1339,22 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 	kfree(tz->trip_hyst_attrs);
 }
 
+static int retrieve_zone_params(struct thermal_zone_device *tz)
+{
+	int ret;
+
+	/* Check whether the platform data pointer is defined */
+	if (!get_platform_thermal_params)
+		return 0;
+
+	/* It is not an error to not have any platform data */
+	ret = get_platform_thermal_params(tz);
+	if (ret)
+		tz->tzp = NULL;
+
+	return 0;
+}
+
 /**
  * thermal_zone_device_register - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1443,6 +1459,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Retrieve platform level parameters for this zone */
+	result = retrieve_zone_params(tz);
+	if (result)
+		goto unregister;
+
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	if (ops->bind)
-- 
1.7.9.5

