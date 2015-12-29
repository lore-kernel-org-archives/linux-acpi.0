From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 39/42] ACPICA: Events: Introduce ACPI_REG_DISCONNECT invocation to acpi_ev_execute_reg_methods()
Date: Tue, 29 Dec 2015 14:03:43 +0800
Message-ID: <a56cc4605d89c00d0494bf6c94d18467c8fb844c.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15152 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbbL2GDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 01:03:52 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 1cf1a1e090f61f0c27f1dcf1905c7cc79a9c51c8

It is likely that we should synchronously invoke _REG(DISCONNECT) only when
the acpi_remove_address_space_handler() is invoked because of dependencies.
If it is invoked when the object is not referenced, problem may occur
if the operation region fields accessed in _REG are no longer driven by any
device driver.

Noticed that _REG(CONNECT)/_REG(DISCONNECT) only mean to inform the AML of
the handler availability, no return value is required for the caller.

This patch only introduces ACPI_REG_DISCONNECT invaocation, but doesn't
introduce a real change. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/1cf1a1e0
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acevents.h |    4 ++--
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/evregion.c |   26 +++++++++++++-------------
 drivers/acpi/acpica/evxfregn.c |    2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 772ee3c..d18f184 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -200,9 +200,9 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 
 void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj);
 
-acpi_status
+void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
-			    acpi_adr_space_type space_id);
+			    acpi_adr_space_type space_id, u32 function);
 
 acpi_status
 acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 034402d..24928ec 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -428,6 +428,7 @@ struct acpi_simple_repair_info {
 
 struct acpi_reg_walk_info {
 	acpi_adr_space_type space_id;
+	u32 function;
 	u32 reg_run_count;
 };
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index cf6e878..a43178f 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -97,10 +97,9 @@ acpi_status acpi_ev_initialize_op_regions(void)
 		if (acpi_ev_has_default_handler(acpi_gbl_root_node,
 						acpi_gbl_default_address_spaces
 						[i])) {
-			status =
-			    acpi_ev_execute_reg_methods(acpi_gbl_root_node,
-							acpi_gbl_default_address_spaces
-							[i]);
+			acpi_ev_execute_reg_methods(acpi_gbl_root_node,
+						    acpi_gbl_default_address_spaces
+						    [i], ACPI_REG_CONNECT);
 		}
 	}
 
@@ -683,24 +682,25 @@ cleanup1:
  *
  * PARAMETERS:  node            - Namespace node for the device
  *              space_id        - The address space ID
+ *              function        - Passed to _REG: On (1) or Off (0)
  *
- * RETURN:      Status
+ * RETURN:      None
  *
  * DESCRIPTION: Run all _REG methods for the input Space ID;
  *              Note: assumes namespace is locked, or system init time.
  *
  ******************************************************************************/
 
-acpi_status
+void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
-			    acpi_adr_space_type space_id)
+			    acpi_adr_space_type space_id, u32 function)
 {
-	acpi_status status;
 	struct acpi_reg_walk_info info;
 
 	ACPI_FUNCTION_TRACE(ev_execute_reg_methods);
 
 	info.space_id = space_id;
+	info.function = function;
 	info.reg_run_count = 0;
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
@@ -713,9 +713,9 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	 * regions and _REG methods. (i.e. handlers must be installed for all
 	 * regions of this Space ID before we can run any _REG methods)
 	 */
-	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
-					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
-					NULL, &info, NULL);
+	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
+				     ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run, NULL,
+				     &info, NULL);
 
 	/* Special case for EC: handle "orphan" _REG methods with no region */
 
@@ -728,7 +728,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			      info.reg_run_count,
 			      acpi_ut_get_region_name(info.space_id)));
 
-	return_ACPI_STATUS(status);
+	return_VOID;
 }
 
 /*******************************************************************************
@@ -787,7 +787,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	}
 
 	info->reg_run_count++;
-	status = acpi_ev_execute_reg_method(obj_desc, ACPI_REG_CONNECT);
+	status = acpi_ev_execute_reg_method(obj_desc, info->function);
 	return (status);
 }
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 29f9f39..35f9e60 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -114,7 +114,7 @@ acpi_install_address_space_handler(acpi_handle device,
 
 	/* Run all _REG methods for this address space */
 
-	status = acpi_ev_execute_reg_methods(node, space_id);
+	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
 
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-- 
1.7.10

