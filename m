From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 33/42] ACPICA: Events: Deploys acpi_ev_find_region_handler()
Date: Tue, 29 Dec 2015 14:02:00 +0800
Message-ID: <f88563ef5520f9aaef9d30199b14c5a47de59f41.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit b916a0a0ae9e81db1a85523c63ec6aa32d5c70c8

There are code fragments that can be substituted by
acpi_ev_find_region_handler().
This patch cleans up these code fragments. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/b916a0a0
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    5 +++
 drivers/acpi/acpica/dbdisply.c  |   30 ++++++++--------
 drivers/acpi/acpica/evhandler.c |   58 ++++++++++++++-----------------
 drivers/acpi/acpica/evrgnini.c  |   73 +++++++++++++++++----------------------
 4 files changed, 75 insertions(+), 91 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 228704b7..42975ab 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -161,6 +161,11 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 /*
  * evhandler - Address space handling
  */
+union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
+						       space_id,
+						       union acpi_operand_object
+						       *handler_obj);
+
 u8
 acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id);
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 390a7ca..a66b4ae 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -48,6 +48,7 @@
 #include "acnamesp.h"
 #include "acparser.h"
 #include "acinterp.h"
+#include "acevents.h"
 #include "acdebug.h"
 
 #define _COMPONENT          ACPI_CA_DEBUGGER
@@ -949,28 +950,25 @@ void acpi_db_display_handlers(void)
 	if (obj_desc) {
 		for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_gbl_space_id_list); i++) {
 			space_id = acpi_gbl_space_id_list[i];
-			handler_obj = obj_desc->device.handler;
 
 			acpi_os_printf(ACPI_PREDEFINED_PREFIX,
 				       acpi_ut_get_region_name((u8)space_id),
 				       space_id);
 
-			while (handler_obj) {
-				if (acpi_gbl_space_id_list[i] ==
-				    handler_obj->address_space.space_id) {
-					acpi_os_printf
-					    (ACPI_HANDLER_PRESENT_STRING,
-					     (handler_obj->address_space.
-					      handler_flags &
-					      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)
-					     ? "Default" : "User",
-					     handler_obj->address_space.
-					     handler);
-
-					goto found_handler;
-				}
+			handler_obj =
+			    acpi_ev_find_region_handler(space_id,
+							obj_desc->device.
+							handler);
+			if (handler_obj) {
+				acpi_os_printf(ACPI_HANDLER_PRESENT_STRING,
+					       (handler_obj->address_space.
+						handler_flags &
+						ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)
+					       ? "Default" : "User",
+					       handler_obj->address_space.
+					       handler);
 
-				handler_obj = handler_obj->address_space.next;
+				goto found_handler;
 			}
 
 			/* There is no handler for this space_id */
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 5d6a3b5..6a7fc11 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -55,10 +55,6 @@ static acpi_status
 acpi_ev_install_handler(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
-static union acpi_operand_object
-    *acpi_ev_find_region_handler(acpi_adr_space_type space_id,
-				 union acpi_operand_object *handler_obj);
-
 /* These are the address spaces that will get default handlers */
 
 u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
@@ -251,35 +247,30 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 
 		/* Check if this Device already has a handler for this address space */
 
-		next_handler_obj = obj_desc->device.handler;
-		while (next_handler_obj) {
+		next_handler_obj =
+		    acpi_ev_find_region_handler(handler_obj->address_space.
+						space_id,
+						obj_desc->device.handler);
+		if (next_handler_obj) {
 
 			/* Found a handler, is it for the same address space? */
 
-			if (next_handler_obj->address_space.space_id ==
-			    handler_obj->address_space.space_id) {
-				ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-						  "Found handler for region [%s] in device %p(%p) "
-						  "handler %p\n",
-						  acpi_ut_get_region_name
-						  (handler_obj->address_space.
-						   space_id), obj_desc,
-						  next_handler_obj,
-						  handler_obj));
-
-				/*
-				 * Since the object we found it on was a device, then it
-				 * means that someone has already installed a handler for
-				 * the branch of the namespace from this device on. Just
-				 * bail out telling the walk routine to not traverse this
-				 * branch. This preserves the scoping rule for handlers.
-				 */
-				return (AE_CTRL_DEPTH);
-			}
-
-			/* Walk the linked list of handlers attached to this device */
-
-			next_handler_obj = next_handler_obj->address_space.next;
+			ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+					  "Found handler for region [%s] in device %p(%p) handler %p\n",
+					  acpi_ut_get_region_name(handler_obj->
+								  address_space.
+								  space_id),
+					  obj_desc, next_handler_obj,
+					  handler_obj));
+
+			/*
+			 * Since the object we found it on was a device, then it means
+			 * that someone has already installed a handler for the branch
+			 * of the namespace from this device on. Just bail out telling
+			 * the walk routine to not traverse this branch. This preserves
+			 * the scoping rule for handlers.
+			 */
+			return (AE_CTRL_DEPTH);
 		}
 
 		/*
@@ -325,9 +316,10 @@ acpi_ev_install_handler(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-static union acpi_operand_object
-    *acpi_ev_find_region_handler(acpi_adr_space_type space_id,
-				 union acpi_operand_object *handler_obj)
+union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
+						       space_id,
+						       union acpi_operand_object
+						       *handler_obj)
 {
 
 	/* Walk the handler list for this device */
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 6181f5a..4df81b5 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -602,60 +602,49 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 				break;
 			}
 
-			while (handler_obj) {
+			handler_obj =
+			    acpi_ev_find_region_handler(space_id, handler_obj);
+			if (handler_obj) {
 
-				/* Is this handler of the correct type? */
+				/* Found correct handler */
 
-				if (handler_obj->address_space.space_id ==
-				    space_id) {
+				ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+						  "Found handler %p for region %p in obj %p\n",
+						  handler_obj, region_obj,
+						  obj_desc));
 
-					/* Found correct handler */
-
-					ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-							  "Found handler %p for region %p in obj %p\n",
-							  handler_obj,
+				status =
+				    acpi_ev_attach_region(handler_obj,
 							  region_obj,
-							  obj_desc));
+							  acpi_ns_locked);
 
+				/*
+				 * Tell all users that this region is usable by
+				 * running the _REG method
+				 */
+				if (acpi_ns_locked) {
 					status =
-					    acpi_ev_attach_region(handler_obj,
-								  region_obj,
-								  acpi_ns_locked);
-
-					/*
-					 * Tell all users that this region is usable by
-					 * running the _REG method
-					 */
-					if (acpi_ns_locked) {
-						status =
-						    acpi_ut_release_mutex
-						    (ACPI_MTX_NAMESPACE);
-						if (ACPI_FAILURE(status)) {
-							return_ACPI_STATUS
-							    (status);
-						}
+					    acpi_ut_release_mutex
+					    (ACPI_MTX_NAMESPACE);
+					if (ACPI_FAILURE(status)) {
+						return_ACPI_STATUS(status);
 					}
+				}
 
+				status =
+				    acpi_ev_execute_reg_method(region_obj,
+							       ACPI_REG_CONNECT);
+
+				if (acpi_ns_locked) {
 					status =
-					    acpi_ev_execute_reg_method
-					    (region_obj, ACPI_REG_CONNECT);
-
-					if (acpi_ns_locked) {
-						status =
-						    acpi_ut_acquire_mutex
-						    (ACPI_MTX_NAMESPACE);
-						if (ACPI_FAILURE(status)) {
-							return_ACPI_STATUS
-							    (status);
-						}
+					    acpi_ut_acquire_mutex
+					    (ACPI_MTX_NAMESPACE);
+					if (ACPI_FAILURE(status)) {
+						return_ACPI_STATUS(status);
 					}
-
-					return_ACPI_STATUS(AE_OK);
 				}
 
-				/* Try next handler in the list */
-
-				handler_obj = handler_obj->address_space.next;
+				return_ACPI_STATUS(AE_OK);
 			}
 		}
 
-- 
1.7.10
