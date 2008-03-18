From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/6] thermal: re-document thermal units
Date: Tue, 18 Mar 2008 02:02:10 -0400
Message-ID: <6d7f014e55c5227220da1f021c518487fcfd585a.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55500 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751558AbYCRGGa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:30 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
In-Reply-To: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang, Rui <rui.zhang@intel.com>

(reverting the previous sysfs patch also reverted a fix
 to the thermal units documentation, which is restored by this commit)

The generic thermal driver shows temperature in millidegree Celsius.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ba9c2da..d9f28be 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -143,10 +143,10 @@ type				Strings which represent the thermal zone type.
 				This is given by thermal zone driver as part of registration.
 				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
 				RO
-				Optional
+				Required
 
 temp				Current temperature as reported by thermal zone (sensor)
-				Unit: degree Celsius
+				Unit: millidegree Celsius
 				RO
 				Required
 
@@ -163,7 +163,7 @@ mode				One of the predefined values in [kernel, user]
 					  charge of the thermal management.
 
 trip_point_[0-*]_temp		The temperature above which trip point will be fired
-				Unit: degree Celsius
+				Unit: millidegree Celsius
 				RO
 				Optional
 
@@ -193,7 +193,7 @@ type				String which represents the type of device
 				eg. For memory controller device on intel_menlow platform:
 				this should be "Memory controller"
 				RO
-				Optional
+				Required
 
 max_state			The maximum permissible cooling state of this cooling device.
 				RO
@@ -219,16 +219,16 @@ the sys I/F structure will be built like this:
 
 |thermal_zone1:
 	|-----type:			ACPI thermal zone
-	|-----temp:			37
+	|-----temp:			37000
 	|-----mode:			kernel
-	|-----trip_point_0_temp:	100
+	|-----trip_point_0_temp:	100000
 	|-----trip_point_0_type:	critical
-	|-----trip_point_1_temp:	80
+	|-----trip_point_1_temp:	80000
 	|-----trip_point_1_type:	passive
-	|-----trip_point_2_temp:	70
-	|-----trip_point_2_type:	active[0]
-	|-----trip_point_3_temp:	60
-	|-----trip_point_3_type:	active[1]
+	|-----trip_point_2_temp:	70000
+	|-----trip_point_2_type:	active0
+	|-----trip_point_3_temp:	60000
+	|-----trip_point_3_type:	active1
 	|-----cdev0:			--->/sys/class/thermal/cooling_device0
 	|-----cdev0_trip_point:		1	/* cdev0 can be used for passive */
 	|-----cdev1:			--->/sys/class/thermal/cooling_device3
-- 
1.5.5.rc0.6.gdeda

