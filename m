From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 36/42] ACPICA: Events: Fix an issue that region object is re-attached to another scope when it is already attached
Date: Tue, 29 Dec 2015 14:02:50 +0800
Message-ID: <f00dcbaa25961f22cf1955b550e034240017eb77.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5261 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbbL2GCz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 01:02:55 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 6ebcb24d3225b6c7715a3ce061c327b4c3a6b76e

The logic in acpi_ev_attach_region() is not correct, it can break address
space handler link. This patch fixes this problem. But be aware that this
fix must be applied along with a region object race issue fix. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/6ebcb24d
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evregion.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 6717e57..19a4e69 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -504,6 +504,12 @@ acpi_ev_attach_region(union acpi_operand_object *handler_obj,
 
 	ACPI_FUNCTION_TRACE(ev_attach_region);
 
+	/* Install the region's handler */
+
+	if (region_obj->region.handler) {
+		return_ACPI_STATUS(AE_ALREADY_EXISTS);
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
 			  "Adding Region [%4.4s] %p to address handler %p [%s]\n",
 			  acpi_ut_get_node_name(region_obj->region.node),
@@ -515,13 +521,6 @@ acpi_ev_attach_region(union acpi_operand_object *handler_obj,
 
 	region_obj->region.next = handler_obj->address_space.region_list;
 	handler_obj->address_space.region_list = region_obj;
-
-	/* Install the region's handler */
-
-	if (region_obj->region.handler) {
-		return_ACPI_STATUS(AE_ALREADY_EXISTS);
-	}
-
 	region_obj->region.handler = handler_obj;
 	acpi_ut_add_reference(handler_obj);
 
-- 
1.7.10

