From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/5] ACPICA: Add auto-serialization support for ill-behaved control methods.
Date: Mon, 24 Mar 2014 14:49:00 +0800
Message-ID: <9517453585d41226eb4ace3e245e1dca8f75c21b.1395638745.git.lv.zheng@intel.com>
References: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48963 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaCXGtG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:49:06 -0400
In-Reply-To: <cover.1395638745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change adds support to automatically mark a control method as
"serialized" if the method creates any named objects. This will
positively prevent the method from being entered by more than one
thread and thus preventing a possible abort when an attempt is
made to create an object twice.

Implemented by parsing all non-serialize control methods at table
load time.

This feature is disabled by default and this patch also adds a new
Linux kernel parameter "acpi_auto_serialize" to allow this feature
to be turned on for a specific boot.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    8 +++
 drivers/acpi/acpica/acdispat.h      |   13 ++--
 drivers/acpi/acpica/acglobal.h      |    9 +++
 drivers/acpi/acpica/acstruct.h      |    3 +
 drivers/acpi/acpica/dsinit.c        |   59 ++++++++++++----
 drivers/acpi/acpica/dsmethod.c      |  132 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/dswload.c       |   16 +++++
 drivers/acpi/acpica/nsinit.c        |    5 +-
 drivers/acpi/acpica/nsload.c        |    4 +-
 drivers/acpi/acpica/psloop.c        |    4 ++
 drivers/acpi/acpica/psobject.c      |    7 +-
 drivers/acpi/osl.c                  |   16 +++++
 include/acpi/acpixf.h               |    1 +
 13 files changed, 252 insertions(+), 25 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 3eae32f..a159537 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -229,6 +229,14 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			use by PCI
 			Format: <irq>,<irq>...
 
+	acpi_auto_serialize	[HW,ACPI]
+			Enable auto-serialization of AML methods
+			AML control methods that contain the opcodes to create
+			named objects will be marked as "Serialized" by the
+			auto-serialization feature.
+			This feature is disabled by default.
+			This option allows to turn on the feature.
+
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
 
 	acpica_no_return_repair [HW, ACPI]
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 5b472c4..d3e2cc3 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -139,20 +139,21 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 			   struct acpi_walk_state *walk_state);
 
 /*
- * dsload - Parser/Interpreter interface, pass 1 namespace load callbacks
+ * dsload - Parser/Interpreter interface
  */
 acpi_status
 acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number);
 
+/* dsload - pass 1 namespace load callbacks */
+
 acpi_status
 acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 		       union acpi_parse_object **out_op);
 
 acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state);
 
-/*
- * dsload - Parser/Interpreter interface, pass 2 namespace load callbacks
- */
+/* dsload - pass 2 namespace load callbacks */
+
 acpi_status
 acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		       union acpi_parse_object **out_op);
@@ -200,7 +201,9 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state);
 /*
  * dsmethod - Parser/Interpreter interface - control method parsing
  */
-acpi_status acpi_ds_parse_method(struct acpi_namespace_node *node);
+acpi_status
+acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
+			      union acpi_operand_object *obj_desc);
 
 acpi_status
 acpi_ds_call_control_method(struct acpi_thread_state *thread,
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 767556c..ea0f838 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -93,6 +93,15 @@
 ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_interpreter_slack, FALSE);
 
 /*
+ * Automatically serialize all methods that create named objects? Default
+ * is TRUE, meaning that all non_serialized methods are scanned once at
+ * table load time to determine those that create named objects. Methods
+ * that create named objects are marked Serialized in order to prevent
+ * possible run-time problems if they are entered by more than one thread.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_auto_serialize_methods, FALSE);
+
+/*
  * Create the predefined _OSI method in the namespace? Default is TRUE
  * because ACPI CA is fully compatible with other ACPI implementations.
  * Changing this will revert ACPI CA (and machine ASL) to pre-OSI behavior.
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 5d2989a..cf73461 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -133,6 +133,9 @@ struct acpi_init_walk_info {
 	u32 table_index;
 	u32 object_count;
 	u32 method_count;
+	u32 serial_method_count;
+	u32 non_serial_method_count;
+	u32 serialized_method_count;
 	u32 device_count;
 	u32 op_region_count;
 	u32 field_count;
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 96644d5..aee5e45 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -83,8 +83,8 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 	    (struct acpi_init_walk_info *)context;
 	struct acpi_namespace_node *node =
 	    (struct acpi_namespace_node *)obj_handle;
-	acpi_object_type type;
 	acpi_status status;
+	union acpi_operand_object *obj_desc;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -100,9 +100,7 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 
 	/* And even then, we are only interested in a few object types */
 
-	type = acpi_ns_get_type(obj_handle);
-
-	switch (type) {
+	switch (acpi_ns_get_type(obj_handle)) {
 	case ACPI_TYPE_REGION:
 
 		status = acpi_ds_initialize_region(obj_handle);
@@ -117,8 +115,44 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 		break;
 
 	case ACPI_TYPE_METHOD:
-
+		/*
+		 * Auto-serialization support. We will examine each method that is
+		 * not_serialized to determine if it creates any Named objects. If
+		 * it does, it will be marked serialized to prevent problems if
+		 * the method is entered by two or more threads and an attempt is
+		 * made to create the same named object twice -- which results in
+		 * an AE_ALREADY_EXISTS exception and method abort.
+		 */
 		info->method_count++;
+		obj_desc = acpi_ns_get_attached_object(node);
+		if (!obj_desc) {
+			break;
+		}
+
+		/* Ignore if already serialized */
+
+		if (obj_desc->method.info_flags & ACPI_METHOD_SERIALIZED) {
+			info->serial_method_count++;
+			break;
+		}
+
+		if (acpi_gbl_auto_serialize_methods) {
+
+			/* Parse/scan method and serialize it if necessary */
+
+			acpi_ds_auto_serialize_method(node, obj_desc);
+			if (obj_desc->method.
+			    info_flags & ACPI_METHOD_SERIALIZED) {
+
+				/* Method was just converted to Serialized */
+
+				info->serial_method_count++;
+				info->serialized_method_count++;
+				break;
+			}
+		}
+
+		info->non_serial_method_count++;
 		break;
 
 	case ACPI_TYPE_DEVICE:
@@ -170,7 +204,6 @@ acpi_ds_initialize_objects(u32 table_index,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Starting initialization of namespace objects ****\n"));
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "Parsing all Control Methods:"));
 
 	/* Set all init info to zero */
 
@@ -205,14 +238,16 @@ acpi_ds_initialize_objects(u32 table_index,
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nTable [%4.4s](id %4.4X) - %u Objects with %u Devices %u Methods %u Regions\n",
+			      "Table [%4.4s] (id %4.4X) - %4u Objects with %3u Devices, "
+			      "%3u Regions, %3u Methods (%u/%u/%u Serial/Non/Cvt)\n",
 			      table->signature, owner_id, info.object_count,
-			      info.device_count, info.method_count,
-			      info.op_region_count));
+			      info.device_count, info.op_region_count,
+			      info.method_count, info.serial_method_count,
+			      info.non_serial_method_count,
+			      info.serialized_method_count));
 
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%u Methods, %u Regions\n", info.method_count,
-			  info.op_region_count));
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "%u Methods, %u Regions\n",
+			  info.method_count, info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 2c6d42c..97ed86a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -49,16 +49,146 @@
 #ifdef	ACPI_DISASSEMBLER
 #include "acdisasm.h"
 #endif
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsmethod")
 
 /* Local prototypes */
 static acpi_status
+acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
+			     union acpi_parse_object **out_op);
+
+static acpi_status
 acpi_ds_create_method_mutex(union acpi_operand_object *method_desc);
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ds_auto_serialize_method
+ *
+ * PARAMETERS:  node                        - Namespace Node of the method
+ *              obj_desc                    - Method object attached to node
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Parse a control method AML to scan for control methods that
+ *              need serialization due to the creation of named objects.
+ *
+ * NOTE: It is a bit of overkill to mark all such methods serialized, since
+ * there is only a problem if the method actually blocks during execution.
+ * A blocking operation is, for example, a Sleep() operation, or any access
+ * to an operation region. However, it is probably not possible to easily
+ * detect whether a method will block or not, so we simply mark all suspicious
+ * methods as serialized.
+ *
+ * NOTE2: This code is essentially a generic routine for parsing a single
+ * control method.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
+			      union acpi_operand_object *obj_desc)
+{
+	acpi_status status;
+	union acpi_parse_object *op = NULL;
+	struct acpi_walk_state *walk_state;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_auto_serialize_method, node);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+			  "Method auto-serialization parse [%4.4s] %p\n",
+			  acpi_ut_get_node_name(node), node));
+
+	/* Create/Init a root op for the method parse tree */
+
+	op = acpi_ps_alloc_op(AML_METHOD_OP);
+	if (!op) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	acpi_ps_set_name(op, node->name.integer);
+	op->common.node = node;
+
+	/* Create and initialize a new walk state */
+
+	walk_state =
+	    acpi_ds_create_walk_state(node->owner_id, NULL, NULL, NULL);
+	if (!walk_state) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	status =
+	    acpi_ds_init_aml_walk(walk_state, op, node,
+				  obj_desc->method.aml_start,
+				  obj_desc->method.aml_length, NULL, 0);
+	if (ACPI_FAILURE(status)) {
+		acpi_ds_delete_walk_state(walk_state);
+		return_ACPI_STATUS(status);
+	}
+
+	walk_state->descending_callback = acpi_ds_detect_named_opcodes;
+
+	/* Parse the method, scan for creation of named objects */
+
+	status = acpi_ps_parse_aml(walk_state);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	acpi_ps_delete_parse_tree(op);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_detect_named_opcodes
+ *
+ * PARAMETERS:  walk_state      - Current state of the parse tree walk
+ *              out_op          - Unused, required for parser interface
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Descending callback used during the loading of ACPI tables.
+ *              Currently used to detect methods that must be marked serialized
+ *              in order to avoid problems with the creation of named objects.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
+			     union acpi_parse_object **out_op)
+{
+
+	ACPI_FUNCTION_NAME(acpi_ds_detect_named_opcodes);
+
+	/* We are only interested in opcodes that have an associated name */
+
+	if (!(walk_state->op_info->flags & AML_NAMED)) {
+		return (AE_OK);
+	}
+
+	/*
+	 * At this point, we know we have a Named object opcode.
+	 * Mark the method as serialized. Later code will create a mutex for
+	 * this method to enforce serialization.
+	 */
+	walk_state->method_desc->method.info_flags |= ACPI_METHOD_SERIALIZED;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "Method serialized [%4.4s] %p - [%s] (%4.4X)\n",
+			  walk_state->method_node->name.ascii,
+			  walk_state->method_node, walk_state->op_info->name,
+			  walk_state->opcode));
+
+	/* Abort the parse, no need to examine this method any further */
+
+	return (AE_CTRL_TERMINATE);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ds_method_error
  *
  * PARAMETERS:  status          - Execution status
@@ -74,7 +204,7 @@ acpi_ds_create_method_mutex(union acpi_operand_object *method_desc);
  ******************************************************************************/
 
 acpi_status
-acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
+acpi_ds_method_error(acpi_status status, struct acpi_walk_state * walk_state)
 {
 	ACPI_FUNCTION_ENTRY();
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index bd7811c..15623da 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -73,8 +73,20 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 {
 
 	switch (pass_number) {
+	case 0:
+
+		/* Parse only - caller will setup callbacks */
+
+		walk_state->parse_flags = ACPI_PARSE_LOAD_PASS1 |
+		    ACPI_PARSE_DELETE_TREE | ACPI_PARSE_DISASSEMBLE;
+		walk_state->descending_callback = NULL;
+		walk_state->ascending_callback = NULL;
+		break;
+
 	case 1:
 
+		/* Load pass 1 */
+
 		walk_state->parse_flags = ACPI_PARSE_LOAD_PASS1 |
 		    ACPI_PARSE_DELETE_TREE;
 		walk_state->descending_callback = acpi_ds_load1_begin_op;
@@ -83,6 +95,8 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 
 	case 2:
 
+		/* Load pass 2 */
+
 		walk_state->parse_flags = ACPI_PARSE_LOAD_PASS1 |
 		    ACPI_PARSE_DELETE_TREE;
 		walk_state->descending_callback = acpi_ds_load2_begin_op;
@@ -91,6 +105,8 @@ acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number)
 
 	case 3:
 
+		/* Execution pass */
+
 #ifndef ACPI_NO_METHOD_EXECUTION
 		walk_state->parse_flags |= ACPI_PARSE_EXECUTE |
 		    ACPI_PARSE_DELETE_TREE;
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 5b74677..a3fb7e4 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -111,9 +111,8 @@ acpi_status acpi_ns_initialize_objects(void)
 			      info.object_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%u Control Methods found\n", info.method_count));
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%u Op Regions found\n", info.op_region_count));
+			  "%u Control Methods found\n%u Op Regions found\n",
+			  info.method_count, info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 7ae521c..7c9d018 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -128,12 +128,12 @@ unlock:
 	 * parse trees.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "**** Begin Table Method Parsing and Object Initialization\n"));
+			  "**** Begin Table Object Initialization\n"));
 
 	status = acpi_ds_initialize_objects(table_index, node);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "**** Completed Table Method Parsing and Object Initialization\n"));
+			  "**** Completed Table Object Initialization\n"));
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 646d1a3..b058e23 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -480,6 +480,10 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					status = AE_OK;
 				}
 
+				if (status == AE_CTRL_TERMINATE) {
+					return_ACPI_STATUS(status);
+				}
+
 				status =
 				    acpi_ps_complete_op(walk_state, &op,
 							status);
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index af1f46c..a688507 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -219,7 +219,10 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 
 	status = walk_state->descending_callback(walk_state, op);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "During name lookup/catalog"));
+		if (status != AE_CTRL_TERMINATE) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"During name lookup/catalog"));
+		}
 		return_ACPI_STATUS(status);
 	}
 
@@ -230,7 +233,7 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 	status = acpi_ps_next_parse_state(walk_state, *op, status);
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_CTRL_PENDING) {
-			return_ACPI_STATUS(AE_CTRL_PARSE_PENDING);
+			status = AE_CTRL_PARSE_PENDING;
 		}
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5a16cc6..928f0c2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1537,6 +1537,22 @@ static int __init osi_setup(char *str)
 
 __setup("acpi_osi=", osi_setup);
 
+/*
+ * Enable the auto-serialization of named objects creation methods.
+ *
+ * This feature is disabled by default.  It marks the AML control methods
+ * that contain the opcodes to create named objects as "Serialized".
+ */
+static int __init acpi_auto_serialize_setup(char *str)
+{
+	acpi_gbl_auto_serialize_methods = TRUE;
+	pr_info("ACPI: auto-serialization enabled\n");
+
+	return 1;
+}
+
+__setup("acpi_auto_serialize", acpi_auto_serialize_setup);
+
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
  * IO ports and memory declared in ACPI might be used by the ACPI subsystem
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5c2a82a..44f5e97 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -71,6 +71,7 @@ extern u32 acpi_dbg_layer;
 
 /* ACPICA runtime options */
 
+extern u8 acpi_gbl_auto_serialize_methods;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
-- 
1.7.10

