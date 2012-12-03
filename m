From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Execute "orphan" _REG method for specified EC device
Date: Mon, 03 Dec 2012 16:22:45 +0800
Message-ID: <1354522965.3063.16.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34496 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab2LCIWv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Dec 2012 03:22:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Bob,

what do you think of this patch?
Should we have an ACPICA style patch first and fix the problem in next ACPICA release?
or should I submit the patch to Linux/ACPI first?

>From c1fc8a40c521065ed35e14b44261760bf5cdcd4e Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 30 Nov 2012 10:25:50 +0800
Subject: [PATCH] Execute "orphan" _REG method for specified EC device

Some platforms do not have EC address space Operation Region.
But the AML code depends on EC._REG being invoked to work properly.

The AML code is broken on such platforms because _REG is only evaluated when
there is at least one EC Operation Region.
 
commit e2066ca1b211ff08325c98be9fb8ad95affbaba8
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Apr 13 13:22:04 2011 +0800

    ACPICA: Execute an orphan _REG method under the EC device
    
    This change will force the execution of a _REG method underneath
    the EC device even if there is no corresponding operation region
    of type EmbeddedControl. Fixes a problem seen on some machines
    and apparently is compatible with Windows behavior.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=875
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

Robert Moore has a patch to fix the issue, but the problem is that
this patch only fixes the problem on platforms with ECDT.

Thus the AML code is still broken in bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=15707

This patch makes some enhancement, and it should work for all the platforms,
even if there is no ECDT.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpica/evregion.c |   42 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 0cc6a16..76af11e 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -55,7 +55,7 @@ static u8
 acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id);
 
-static void acpi_ev_orphan_ec_reg_method(void);
+static void acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *node);
 
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
@@ -1092,7 +1092,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	/* Special case for EC: handle "orphan" _REG methods with no region */
 
 	if (space_id == ACPI_ADR_SPACE_EC) {
-		acpi_ev_orphan_ec_reg_method();
+		acpi_ev_orphan_ec_reg_method(node);
 	}
 
 	return_ACPI_STATUS(status);
@@ -1161,7 +1161,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  * FUNCTION:    acpi_ev_orphan_ec_reg_method
  *
- * PARAMETERS:  None
+ * PARAMETERS:  node            - Namespace node for the device
  *
  * RETURN:      None
  *
@@ -1180,51 +1180,29 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-static void acpi_ev_orphan_ec_reg_method(void)
+static void acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *node)
 {
 	struct acpi_table_ecdt *table;
 	acpi_status status;
 	struct acpi_object_list args;
 	union acpi_object objects[2];
-	struct acpi_namespace_node *ec_device_node;
 	struct acpi_namespace_node *reg_method;
 	struct acpi_namespace_node *next_node;
 
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
+	/* Get the EC node */
+	if (!node)
 		return_VOID;
-	}
 
 	/* Namespace is currently locked, must release */
 
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
+	status = acpi_get_handle(node, METHOD_NAME__REG,
+			ACPI_CAST_PTR(acpi_handle, &reg_method));
 	if (ACPI_FAILURE(status)) {
 		goto exit;
 	}
@@ -1236,14 +1214,14 @@ static void acpi_ev_orphan_ec_reg_method(void)
 	 * with other space IDs to be present; but the code below will then
 	 * execute the _REG method with the EC space ID argument.
 	 */
-	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
+	next_node = acpi_ns_get_next_node(node, NULL);
 	while (next_node) {
 		if ((next_node->type == ACPI_TYPE_REGION) &&
 		    (next_node->object) &&
 		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
 			goto exit;	/* Do not execute _REG */
 		}
-		next_node = acpi_ns_get_next_node(ec_device_node, next_node);
+		next_node = acpi_ns_get_next_node(node, next_node);
 	}
 
 	/* Evaluate the _REG(EC,Connect) method */
-- 
1.7.9.5



