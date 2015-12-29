From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 34/42] ACPICA: Events: Uses common_notify for address space handlers
Date: Tue, 29 Dec 2015 14:02:08 +0800
Message-ID: <6464465c6920edd88a36e738e7719a1fd29330b0.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 5ea0fb75fdf1aa7c0aba067dfa4d5dc3a9279461

The address space handlers can be attached to not only Device but also
Processor/thermal_zone objects, so it is better to use their common
class 'CommonNotify' instead. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/5ea0fb75
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbdisply.c  |    6 +++---
 drivers/acpi/acpica/evhandler.c |   12 +++++++-----
 drivers/acpi/acpica/evrgnini.c  |   10 +---------
 drivers/acpi/acpica/evxfregn.c  |    4 ++--
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index a66b4ae..1965b48 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -957,7 +957,7 @@ void acpi_db_display_handlers(void)
 
 			handler_obj =
 			    acpi_ev_find_region_handler(space_id,
-							obj_desc->device.
+							obj_desc->common_notify.
 							handler);
 			if (handler_obj) {
 				acpi_os_printf(ACPI_HANDLER_PRESENT_STRING,
@@ -980,7 +980,7 @@ found_handler:		;
 
 		/* Find all handlers for user-defined space_IDs */
 
-		handler_obj = obj_desc->device.handler;
+		handler_obj = obj_desc->common_notify.handler;
 		while (handler_obj) {
 			if (handler_obj->address_space.space_id >=
 			    ACPI_USER_REGION_BEGIN) {
@@ -1082,7 +1082,7 @@ acpi_db_display_non_root_handlers(acpi_handle obj_handle,
 
 	/* Display all handlers associated with this device */
 
-	handler_obj = obj_desc->device.handler;
+	handler_obj = obj_desc->common_notify.handler;
 	while (handler_obj) {
 		acpi_os_printf(ACPI_PREDEFINED_PREFIX,
 			       acpi_ut_get_region_name((u8)handler_obj->
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 6a7fc11..709419c 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -159,7 +159,7 @@ acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
-		handler_obj = obj_desc->device.handler;
+		handler_obj = obj_desc->common_notify.handler;
 
 		/* Walk the linked list of handlers for this object */
 
@@ -250,7 +250,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 		next_handler_obj =
 		    acpi_ev_find_region_handler(handler_obj->address_space.
 						space_id,
-						obj_desc->device.handler);
+						obj_desc->common_notify.
+						handler);
 		if (next_handler_obj) {
 
 			/* Found a handler, is it for the same address space? */
@@ -444,7 +445,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 		 * the handler is not already installed.
 		 */
 		handler_obj = acpi_ev_find_region_handler(space_id,
-							  obj_desc->device.
+							  obj_desc->
+							  common_notify.
 							  handler);
 
 		if (handler_obj) {
@@ -531,13 +533,13 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 
 	/* Install at head of Device.address_space list */
 
-	handler_obj->address_space.next = obj_desc->device.handler;
+	handler_obj->address_space.next = obj_desc->common_notify.handler;
 
 	/*
 	 * The Device object is the first reference on the handler_obj.
 	 * Each region that uses the handler adds a reference.
 	 */
-	obj_desc->device.handler = handler_obj;
+	obj_desc->common_notify.handler = handler_obj;
 
 	/*
 	 * Walk the namespace finding all of the regions this handler will
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 4df81b5..024689d 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -566,18 +566,10 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 			switch (node->type) {
 			case ACPI_TYPE_DEVICE:
-
-				handler_obj = obj_desc->device.handler;
-				break;
-
 			case ACPI_TYPE_PROCESSOR:
-
-				handler_obj = obj_desc->processor.handler;
-				break;
-
 			case ACPI_TYPE_THERMAL:
 
-				handler_obj = obj_desc->thermal_zone.handler;
+				handler_obj = obj_desc->common_notify.handler;
 				break;
 
 			case ACPI_TYPE_METHOD:
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index dbd9f16..3c90508 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -216,8 +216,8 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 	/* Find the address handler the user requested */
 
-	handler_obj = obj_desc->device.handler;
-	last_obj_ptr = &obj_desc->device.handler;
+	handler_obj = obj_desc->common_notify.handler;
+	last_obj_ptr = &obj_desc->common_notify.handler;
 	while (handler_obj) {
 
 		/* We have a handler, see if user requested this one */
-- 
1.7.10
