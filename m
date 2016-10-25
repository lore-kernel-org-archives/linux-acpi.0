From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 4/6] ACPICA: Events: Cleanup acpi_ev_initialize_region()
Date: Tue, 25 Oct 2016 13:21:29 +0800
Message-ID: <fbcb23c2ce09d6f7c9859b61a51f6ac2db7111ab.1477372449.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34252 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbcJYFWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2016 01:22:00 -0400
In-Reply-To: <cover.1477372449.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch changes acpi_ev_initialize_region(), stop returning AE_NOT_EXIST
from it so that, not only in acpi_ds_load2_end_op(), but all places invoking
this function won't emit exceptions.

This patch also removes acpi_ns_locked from acpi_ev_initialize_region() as we
have tuned table/namespace mutexes to be independent to each other, and
decided to deal with namespace node deletion stuffs with new design other
than using the 2 locks (because using them are not working correctly). Thus
this function won't be invoked with the namespace lock held.

No functional changes. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acevents.h |  4 +--
 drivers/acpi/acpica/dsopcode.c |  2 +-
 drivers/acpi/acpica/dswload2.c | 13 +---------
 drivers/acpi/acpica/evrgnini.c | 59 +++++++++++++++++-------------------------
 4 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 92fa47c..8a0049d 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -243,9 +243,7 @@ acpi_ev_default_region_setup(acpi_handle handle,
 			     u32 function,
 			     void *handler_context, void **region_context);
 
-acpi_status
-acpi_ev_initialize_region(union acpi_operand_object *region_obj,
-			  u8 acpi_ns_locked);
+acpi_status acpi_ev_initialize_region(union acpi_operand_object *region_obj);
 
 /*
  * evsci - SCI (System Control Interrupt) handling/dispatch
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 4cc9d98..77fd7c8 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -84,7 +84,7 @@ acpi_status acpi_ds_initialize_region(acpi_handle obj_handle)
 
 	/* Namespace is NOT locked */
 
-	status = acpi_ev_initialize_region(obj_desc, FALSE);
+	status = acpi_ev_initialize_region(obj_desc);
 	return (status);
 }
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index e362182..651f35a 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -609,18 +609,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 
 			status =
 			    acpi_ev_initialize_region
-			    (acpi_ns_get_attached_object(node), FALSE);
-
-			if (ACPI_FAILURE(status)) {
-				/*
-				 *  If AE_NOT_EXIST is returned, it is not fatal
-				 *  because many regions get created before a handler
-				 *  is installed for said region.
-				 */
-				if (AE_NOT_EXIST == status) {
-					status = AE_OK;
-				}
-			}
+			    (acpi_ns_get_attached_object(node));
 			break;
 
 		case AML_NAME_OP:
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 75ddd16..a909225 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -479,7 +479,6 @@ acpi_ev_default_region_setup(acpi_handle handle,
  * FUNCTION:    acpi_ev_initialize_region
  *
  * PARAMETERS:  region_obj      - Region we are initializing
- *              acpi_ns_locked  - Is namespace locked?
  *
  * RETURN:      Status
  *
@@ -497,19 +496,28 @@ acpi_ev_default_region_setup(acpi_handle handle,
  * MUTEX:       Interpreter should be unlocked, because we may run the _REG
  *              method for this region.
  *
+ * NOTE:        Possible incompliance:
+ *              There is a behavior conflict in automatic _REG execution:
+ *              1. When the interpreter is evaluating a method, we can only
+ *                 automatically run _REG for the following case:
+ *                   operation_region (OPR1, 0x80, 0x1000010, 0x4)
+ *              2. When the interpreter is loading a table, we can also
+ *                 automatically run _REG for the following case:
+ *                   operation_region (OPR1, 0x80, 0x1000010, 0x4)
+ *              Though this may not be compliant to the de-facto standard, the
+ *              logic is kept in order not to trigger regressions. And keeping
+ *              this logic should be taken care by the caller of this function.
+ *
  ******************************************************************************/
 
-acpi_status
-acpi_ev_initialize_region(union acpi_operand_object *region_obj,
-			  u8 acpi_ns_locked)
+acpi_status acpi_ev_initialize_region(union acpi_operand_object *region_obj)
 {
 	union acpi_operand_object *handler_obj;
 	union acpi_operand_object *obj_desc;
 	acpi_adr_space_type space_id;
 	struct acpi_namespace_node *node;
-	acpi_status status;
 
-	ACPI_FUNCTION_TRACE_U32(ev_initialize_region, acpi_ns_locked);
+	ACPI_FUNCTION_TRACE(ev_initialize_region);
 
 	if (!region_obj) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
@@ -580,39 +588,17 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 						  handler_obj, region_obj,
 						  obj_desc));
 
-				status =
-				    acpi_ev_attach_region(handler_obj,
-							  region_obj,
-							  acpi_ns_locked);
+				(void)acpi_ev_attach_region(handler_obj,
+							    region_obj, FALSE);
 
 				/*
 				 * Tell all users that this region is usable by
 				 * running the _REG method
 				 */
-				if (acpi_ns_locked) {
-					status =
-					    acpi_ut_release_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(status)) {
-						return_ACPI_STATUS(status);
-					}
-				}
-
 				acpi_ex_exit_interpreter();
-				status =
-				    acpi_ev_execute_reg_method(region_obj,
-							       ACPI_REG_CONNECT);
+				(void)acpi_ev_execute_reg_method(region_obj,
+								 ACPI_REG_CONNECT);
 				acpi_ex_enter_interpreter();
-
-				if (acpi_ns_locked) {
-					status =
-					    acpi_ut_acquire_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(status)) {
-						return_ACPI_STATUS(status);
-					}
-				}
-
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
@@ -622,12 +608,15 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		node = node->parent;
 	}
 
-	/* If we get here, there is no handler for this region */
-
+	/*
+	 * If we get here, there is no handler for this region. This is not
+	 * fatal because many regions get created before a handler is installed
+	 * for said region.
+	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
 			  "No handler for RegionType %s(%X) (RegionObj %p)\n",
 			  acpi_ut_get_region_name(space_id), space_id,
 			  region_obj));
 
-	return_ACPI_STATUS(AE_NOT_EXIST);
+	return_ACPI_STATUS(AE_OK);
 }
-- 
2.7.4

