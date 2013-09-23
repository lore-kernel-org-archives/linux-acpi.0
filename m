From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 08/14] ACPICA: Operation region support: Never free the handler "context" pointer.
Date: Mon, 23 Sep 2013 09:52:12 +0800
Message-ID: <e90db8ba7a6f4e8ab57b556abf6ca7f0073d8f4c.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51727 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab3IWBwW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:52:22 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@intel.com>

From: "David E. Box" <david.e.box@intel.com>

This change removes some dangerous code that attempts to free the
handler context pointer in some (rare) circumstances. The owner of
the handler owns this pointer and the ACPICA code should never
touch it. Although not seen to be an issue in any kernel, it did
show up as a problem under AcpiExec. Also, set the internal storage
field for the context pointer to zero when the region is deactivated,
simply for sanity. David Box.

Signed-off-by: David E. Box <david.e.box@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evregion.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index cea14d6..6293d6b 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -217,16 +217,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
 			region_obj->region.flags |= AOPOBJ_SETUP_COMPLETE;
 
-			if (region_obj2->extra.region_context) {
-
-				/* The handler for this region was already installed */
-
-				ACPI_FREE(region_context);
-			} else {
-				/*
-				 * Save the returned context for use in all accesses to
-				 * this particular region
-				 */
+			/*
+			 * Save the returned context for use in all accesses to
+			 * the handler for this particular region
+			 */
+			if (!(region_obj2->extra.region_context)) {
 				region_obj2->extra.region_context =
 				    region_context;
 			}
@@ -402,6 +397,14 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 						 handler_obj->address_space.
 						 context, region_context);
 
+				/*
+				 * region_context should have been released by the deactivate
+				 * operation. We don't need access to it anymore here.
+				 */
+				if (region_context) {
+					*region_context = NULL;
+				}
+
 				/* Init routine may fail, Just ignore errors */
 
 				if (ACPI_FAILURE(status)) {
-- 
1.7.10

