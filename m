From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 6/7] ACPICA: Update for "orphan" embedded controller _REG method support
Date: Wed, 29 May 2013 10:09:32 +0800
Message-ID: <b3a259fc4221a78d406e1224f2570efc59a5e0b3.1367913047.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24455 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:39 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zheng@intel.com>

From: Zhang Rui <rui.zheng@intel.com>

This refers to _REG methods under the EC device that have no
corresponding operation region. This is allowed by the ACPI
specification. This update removes a dependency on having an
ECDT table, and will execute an orphan _REG method as long as
the handler for the EC is installed at the EC device node (not
the namespace root).  Rui Zhang (original update), Bob Moore
(update/integrate).

Signed-off-by: Zhang Rui <rui.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evregion.c |   61 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 8ae8f5b..cea14d6 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -54,7 +54,8 @@ extern u8 acpi_gbl_default_address_spaces[];
 
 /* Local prototypes */
 
-static void acpi_ev_orphan_ec_reg_method(void);
+static void
+acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node);
 
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
@@ -612,7 +613,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	/* Special case for EC: handle "orphan" _REG methods with no region */
 
 	if (space_id == ACPI_ADR_SPACE_EC) {
-		acpi_ev_orphan_ec_reg_method();
+		acpi_ev_orphan_ec_reg_method(node);
 	}
 
 	return_ACPI_STATUS(status);
@@ -681,7 +682,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  * FUNCTION:    acpi_ev_orphan_ec_reg_method
  *
- * PARAMETERS:  None
+ * PARAMETERS:  ec_device_node      - Namespace node for an EC device
  *
  * RETURN:      None
  *
@@ -693,37 +694,27 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *              detected by providing a _REG method object underneath the
  *              Embedded Controller device."
  *
- *              To quickly access the EC device, we use the EC_ID that appears
- *              within the ECDT. Otherwise, we would need to perform a time-
- *              consuming namespace walk, executing _HID methods to find the
- *              EC device.
+ *              To quickly access the EC device, we use the ec_device_node used
+ *              during EC handler installation. Otherwise, we would need to
+ *              perform a time consuming namespace walk, executing _HID
+ *              methods to find the EC device.
+ *
+ *  MUTEX:      Assumes the namespace is locked
  *
  ******************************************************************************/
 
-static void acpi_ev_orphan_ec_reg_method(void)
+static void
+acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 {
-	struct acpi_table_ecdt *table;
+	acpi_handle reg_method;
+	struct acpi_namespace_node *next_node;
 	acpi_status status;
 	struct acpi_object_list args;
 	union acpi_object objects[2];
-	struct acpi_namespace_node *ec_device_node;
-	struct acpi_namespace_node *reg_method;
-	struct acpi_namespace_node *next_node;
 
 	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
 
-	/* Get the ECDT (if present in system) */
-
-	status = acpi_get_table(ACPI_SIG_ECDT, 0,
-				ACPI_CAST_INDIRECT_PTR(struct acpi_table_header,
-						       &table));
-	if (ACPI_FAILURE(status)) {
-		return_VOID;
-	}
-
-	/* We need a valid EC_ID string */
-
-	if (!(*table->id)) {
+	if (!ec_device_node) {
 		return_VOID;
 	}
 
@@ -731,22 +722,11 @@ static void acpi_ev_orphan_ec_reg_method(void)
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
-	/* Get a handle to the EC device referenced in the ECDT */
-
-	status = acpi_get_handle(NULL,
-				 ACPI_CAST_PTR(char, table->id),
-				 ACPI_CAST_PTR(acpi_handle, &ec_device_node));
-	if (ACPI_FAILURE(status)) {
-		goto exit;
-	}
-
 	/* Get a handle to a _REG method immediately under the EC device */
 
-	status = acpi_get_handle(ec_device_node,
-				 METHOD_NAME__REG, ACPI_CAST_PTR(acpi_handle,
-								 &reg_method));
+	status = acpi_get_handle(ec_device_node, METHOD_NAME__REG, &reg_method);
 	if (ACPI_FAILURE(status)) {
-		goto exit;
+		goto exit;	/* There is no _REG method present */
 	}
 
 	/*
@@ -754,19 +734,20 @@ static void acpi_ev_orphan_ec_reg_method(void)
 	 * this scope with the Embedded Controller space ID. Otherwise, it
 	 * will already have been executed. Note, this allows for Regions
 	 * with other space IDs to be present; but the code below will then
-	 * execute the _REG method with the EC space ID argument.
+	 * execute the _REG method with the embedded_control space_ID argument.
 	 */
 	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
 	while (next_node) {
 		if ((next_node->type == ACPI_TYPE_REGION) &&
 		    (next_node->object) &&
 		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
-			goto exit;	/* Do not execute _REG */
+			goto exit;	/* Do not execute the _REG */
 		}
+
 		next_node = acpi_ns_get_next_node(ec_device_node, next_node);
 	}
 
-	/* Evaluate the _REG(EC,Connect) method */
+	/* Evaluate the _REG(embedded_control,Connect) method */
 
 	args.count = 2;
 	args.pointer = objects;
-- 
1.7.10

