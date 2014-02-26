From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/18] ACPICA: Prevent infinite loops when traversing corrupted lists.
Date: Wed, 26 Feb 2014 10:33:47 +0800
Message-ID: <b47500c9e049180e6776ae38f8efb6c7c3950b09.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbaBZCeD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:34:03 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change hardens the ACPICA code to detect circular linked object
lists and prevent an infinite loop if such corruption exists.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evregion.c |   11 +++++++++++
 drivers/acpi/acpica/nsobject.c |   10 ++++++++--
 drivers/acpi/acpica/utdelete.c |   15 +++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index e31049b..9957297 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -314,6 +314,7 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 {
 	union acpi_operand_object *handler_obj;
 	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *start_desc;
 	union acpi_operand_object **last_obj_ptr;
 	acpi_adr_space_setup region_setup;
 	void **region_context;
@@ -341,6 +342,7 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 	/* Find this region in the handler's list */
 
 	obj_desc = handler_obj->address_space.region_list;
+	start_desc = obj_desc;
 	last_obj_ptr = &handler_obj->address_space.region_list;
 
 	while (obj_desc) {
@@ -438,6 +440,15 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 
 		last_obj_ptr = &obj_desc->region.next;
 		obj_desc = obj_desc->region.next;
+
+		/* Prevent infinite loop if list is corrupted */
+
+		if (obj_desc == start_desc) {
+			ACPI_ERROR((AE_INFO,
+				    "Circular handler list in region object %p",
+				    region_obj));
+			return_VOID;
+		}
 	}
 
 	/* If we get here, the region was not in the handler's region list */
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 32845b1..fe54a8c 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -222,13 +222,19 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 		}
 	}
 
-	/* Clear the entry in all cases */
+	/* Clear the Node entry in all cases */
 
 	node->object = NULL;
 	if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) == ACPI_DESC_TYPE_OPERAND) {
+
+		/* Unlink object from front of possible object list */
+
 		node->object = obj_desc->common.next_object;
+
+		/* Handle possible 2-descriptor object */
+
 		if (node->object &&
-		    ((node->object)->common.type != ACPI_TYPE_LOCAL_DATA)) {
+		    (node->object->common.type != ACPI_TYPE_LOCAL_DATA)) {
 			node->object = node->object->common.next_object;
 		}
 	}
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index ed4cb86..a3516de 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -75,6 +75,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 	union acpi_operand_object *handler_desc;
 	union acpi_operand_object *second_desc;
 	union acpi_operand_object *next_desc;
+	union acpi_operand_object *start_desc;
 	union acpi_operand_object **last_obj_ptr;
 
 	ACPI_FUNCTION_TRACE_PTR(ut_delete_internal_obj, object);
@@ -235,10 +236,11 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			if (handler_desc) {
 				next_desc =
 				    handler_desc->address_space.region_list;
+				start_desc = next_desc;
 				last_obj_ptr =
 				    &handler_desc->address_space.region_list;
 
-				/* Remove the region object from the handler's list */
+				/* Remove the region object from the handler list */
 
 				while (next_desc) {
 					if (next_desc == object) {
@@ -247,10 +249,19 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 						break;
 					}
 
-					/* Walk the linked list of handler */
+					/* Walk the linked list of handlers */
 
 					last_obj_ptr = &next_desc->region.next;
 					next_desc = next_desc->region.next;
+
+					/* Prevent infinite loop if list is corrupted */
+
+					if (next_desc == start_desc) {
+						ACPI_ERROR((AE_INFO,
+							    "Circular region list in address handler object %p",
+							    handler_desc));
+						return_VOID;
+					}
 				}
 
 				if (handler_desc->address_space.handler_flags &
-- 
1.7.10

