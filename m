From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/18] ACPICA: Do not abort _PRT repair on a single subpackage failure.
Date: Wed, 26 Feb 2014 10:30:43 +0800
Message-ID: <7efa10101c62f237af5a04ed608b8384e48237f7.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2597 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaBZCaw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:30:52 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Always examine all subpackages for reversed entries.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index c57cd4a..1801214 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -620,12 +620,16 @@ acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
 	top_object_list = package_object->package.elements;
 	element_count = package_object->package.count;
 
-	for (index = 0; index < element_count; index++) {
+	/* Examine each subpackage */
+
+	for (index = 0; index < element_count; index++, top_object_list++) {
 		sub_package = *top_object_list;
 		sub_object_list = sub_package->package.elements;
 
-		if (sub_package->package.count < 4) {	/* Minimum required element count */
-			return (AE_OK);
+		/* Check for minimum required element count */
+
+		if (sub_package->package.count < 4) {
+			continue;
 		}
 
 		/*
@@ -640,15 +644,12 @@ acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
 			sub_object_list[2] = obj_desc;
 			info->return_flags |= ACPI_OBJECT_REPAIRED;
 
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO,
+					      info->full_pathname,
 					      info->node_flags,
 					      "PRT[%X]: Fixed reversed SourceName and SourceIndex",
 					      index));
 		}
-
-		/* Point to the next union acpi_operand_object in the top level package */
-
-		top_object_list++;
 	}
 
 	return (AE_OK);
-- 
1.7.10

