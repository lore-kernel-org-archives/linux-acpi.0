From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 12/13] Thermal: Add documentation for platform layer data
Date: Thu,  9 Aug 2012 18:16:04 +0530
Message-ID: <1344516365-7230-13-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469Ab2HIMqq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:46 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds documentation for the structure
thermal_zone_params, and also shows an example of
how to populate them.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ca1a1a3..669720c 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -112,6 +112,36 @@ temperature) and throttle appropriate devices.
     trip: indicates which trip point the cooling devices is associated with
 	  in this thermal zone.
 
+1.4 Thermal Zone Parameters
+1.4.1 struct thermal_zone_params
+    This structure defines the platform level parameters for a thermal zone.
+    This data, for each thermal zone should come from the platform layer.
+    This is an optional feature where some platforms can choose not to
+    provide this data.
+1.4.2 struct thermal_zone_params attributes
+    .thermal_zone_name: Name of the thermal zone, for which these parameters
+			are being defined.
+    .num_cdevs: Number of cooling devices associated with this
+			  thermal zone.
+    .cdevs_name: Names of the cooling devices associated with this
+			   thermal zone.
+    .weights: This parameter defines the 'influence' of a particular cooling
+	      device on this thermal zone, on a percentage scale. The sum of
+	      all these weights cannot exceed 100. The order of values in
+	      this array should match with that of the cdevs_name.
+    .trip_mask: This is a bit mask that gives the binding relation between
+		this thermal zone and cdev, for a particular trip point.
+		If nth bit is set, then the cdev and thermal zone are bound
+		for trip point n.
+1.4.3 An example thermal_zone_params structure
+	struct thermal_zone_params tzp = {
+                .thermal_zone_name = "CPU",
+                .num_cdevs = 2,
+                .cdevs_name = {"CPU", "Memory"},
+                .weights = {70, 30},
+		.trip_mask = {0x0F, 0x08},
+        };
+
 2. sysfs attributes structure
 
 RO	read only value
-- 
1.7.9.5

