From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/18] ACPICA: Execute an orphan _REG method under the EC device
Date: Sun, 29 May 2011 05:44:06 -0400
Message-ID: <e2066ca1b211ff08325c98be9fb8ad95affbaba8.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1E2J57 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:59 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:58 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change will force the execution of a _REG method underneath
the EC device even if there is no corresponding operation region
of type EmbeddedControl. Fixes a problem seen on some machines
and apparently is compatible with Windows behavior.

http://www.acpica.org/bugzilla/show_bug.cgi?id=875

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evregion.c |  121 +++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/evrgnini.c |    2 +-
 drivers/acpi/acpica/evxfregn.c |   13 ++--
 include/acpi/actypes.h         |    5 ++
 4 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index bea7223..f0edf5c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -55,6 +55,8 @@ static u8
 acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id);
 
+static void acpi_ev_orphan_ec_reg_method(void);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -561,7 +563,9 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 
 			/* Now stop region accesses by executing the _REG method */
 
-			status = acpi_ev_execute_reg_method(region_obj, 0);
+			status =
+			    acpi_ev_execute_reg_method(region_obj,
+						       ACPI_REG_DISCONNECT);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"from region _REG, [%s]",
@@ -1062,6 +1066,12 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
 					NULL, &space_id, NULL);
 
+	/* Special case for EC: handle "orphan" _REG methods with no region */
+
+	if (space_id == ACPI_ADR_SPACE_EC) {
+		acpi_ev_orphan_ec_reg_method();
+	}
+
 	return_ACPI_STATUS(status);
 }
 
@@ -1120,6 +1130,113 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	status = acpi_ev_execute_reg_method(obj_desc, 1);
+	status = acpi_ev_execute_reg_method(obj_desc, ACPI_REG_CONNECT);
 	return (status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_orphan_ec_reg_method
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Execute an "orphan" _REG method that appears under the EC
+ *              device. This is a _REG method that has no corresponding region
+ *              within the EC device scope. The orphan _REG method appears to
+ *              have been enabled by the description of the ECDT in the ACPI
+ *              specification: "The availability of the region space can be
+ *              detected by providing a _REG method object underneath the
+ *              Embedded Controller device."
+ *
+ *              To quickly access the EC device, we use the EC_ID that appears
+ *              within the ECDT. Otherwise, we would need to perform a time-
+ *              consuming namespace walk, executing _HID methods to find the
+ *              EC device.
+ *
+ ******************************************************************************/
+
+static void acpi_ev_orphan_ec_reg_method(void)
+{
+	struct acpi_table_ecdt *table;
+	acpi_status status;
+	struct acpi_object_list args;
+	union acpi_object objects[2];
+	struct acpi_namespace_node *ec_device_node;
+	struct acpi_namespace_node *reg_method;
+	struct acpi_namespace_node *next_node;
+
+	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
+
+	/* Get the ECDT (if present in system) */
+
+	status = acpi_get_table(ACPI_SIG_ECDT, 0,
+				ACPI_CAST_INDIRECT_PTR(struct acpi_table_header,
+						       &table));
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
+	}
+
+	/* We need a valid EC_ID string */
+
+	if (!(*table->id)) {
+		return_VOID;
+	}
+
+	/* Namespace is currently locked, must release */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+	/* Get a handle to the EC device referenced in the ECDT */
+
+	status = acpi_get_handle(NULL,
+				 ACPI_CAST_PTR(char, table->id),
+				 ACPI_CAST_PTR(acpi_handle, &ec_device_node));
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Get a handle to a _REG method immediately under the EC device */
+
+	status = acpi_get_handle(ec_device_node,
+				 METHOD_NAME__REG, ACPI_CAST_PTR(acpi_handle,
+								 &reg_method));
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/*
+	 * Execute the _REG method only if there is no Operation Region in
+	 * this scope with the Embedded Controller space ID. Otherwise, it
+	 * will already have been executed. Note, this allows for Regions
+	 * with other space IDs to be present; but the code below will then
+	 * execute the _REG method with the EC space ID argument.
+	 */
+	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
+	while (next_node) {
+		if ((next_node->type == ACPI_TYPE_REGION) &&
+		    (next_node->object) &&
+		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
+			goto exit;	/* Do not execute _REG */
+		}
+		next_node = acpi_ns_get_next_node(ec_device_node, next_node);
+	}
+
+	/* Evaluate the _REG(EC,Connect) method */
+
+	args.count = 2;
+	args.pointer = objects;
+	objects[0].type = ACPI_TYPE_INTEGER;
+	objects[0].integer.value = ACPI_ADR_SPACE_EC;
+	objects[1].type = ACPI_TYPE_INTEGER;
+	objects[1].integer.value = ACPI_REG_CONNECT;
+
+	status = acpi_evaluate_object(reg_method, NULL, &args, NULL);
+
+      exit:
+	/* We ignore all errors from above, don't care */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	return_VOID;
+}
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 9659cee..55a5d35 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -637,7 +637,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 					status =
 					    acpi_ev_execute_reg_method
-					    (region_obj, 1);
+					    (region_obj, ACPI_REG_CONNECT);
 
 					if (acpi_ns_locked) {
 						status =
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index c85c8c4..00cd956 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -130,20 +130,21 @@ acpi_install_address_space_handler(acpi_handle device,
 	case ACPI_ADR_SPACE_PCI_CONFIG:
 	case ACPI_ADR_SPACE_DATA_TABLE:
 
-		if (acpi_gbl_reg_methods_executed) {
+		if (!acpi_gbl_reg_methods_executed) {
 
-			/* Run all _REG methods for this address space */
-
-			status = acpi_ev_execute_reg_methods(node, space_id);
+			/* We will defer execution of the _REG methods for this space */
+			goto unlock_and_exit;
 		}
 		break;
 
 	default:
-
-		status = acpi_ev_execute_reg_methods(node, space_id);
 		break;
 	}
 
+	/* Run all _REG methods for this address space */
+
+	status = acpi_ev_execute_reg_methods(node, space_id);
+
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f3b29fa..a6412b8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -726,6 +726,11 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
 #define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 0x7F
 
+/* Values for _REG connection code */
+
+#define ACPI_REG_DISCONNECT             0
+#define ACPI_REG_CONNECT                1
+
 /*
  * bit_register IDs
  *
-- 
1.7.5.3.367.ga9930.dirty

