From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/18] ACPICA: Harden _PRT repair code; check for minimum package length.
Date: Wed, 26 Feb 2014 10:30:25 +0800
Message-ID: <3f0cbc48d77573009afbc116798307603a8e5f45.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38603 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaBZCah (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:30:37 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change prevents a fault during the repair by checking up
front if the _PRT subpackage contains the minimum number of
elements (4).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 53b4b42..c57cd4a 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -611,6 +611,7 @@ acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
 	union acpi_operand_object **top_object_list;
 	union acpi_operand_object **sub_object_list;
 	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *sub_package;
 	u32 element_count;
 	u32 index;
 
@@ -620,7 +621,12 @@ acpi_ns_repair_PRT(struct acpi_evaluate_info *info,
 	element_count = package_object->package.count;
 
 	for (index = 0; index < element_count; index++) {
-		sub_object_list = (*top_object_list)->package.elements;
+		sub_package = *top_object_list;
+		sub_object_list = sub_package->package.elements;
+
+		if (sub_package->package.count < 4) {	/* Minimum required element count */
+			return (AE_OK);
+		}
 
 		/*
 		 * If the BIOS has erroneously reversed the _PRT source_name (index 2)
-- 
1.7.10

