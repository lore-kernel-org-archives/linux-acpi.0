From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/14] ACPICA: Debugger: Add subcommand for predefined name execution
Date: Wed,  7 Sep 2016 14:05:41 +0800
Message-ID: <91522422532ebf3d024b7a83934d5f556f5921a0.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59317 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbcIGGFs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:05:48 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit be5808f0e642ff9963d86f362521b4af2340e2f5

"Execute Predefined" will execute all predefined (public) names
within the namespace.

Link: https://github.com/acpica/acpica/commit/be5808f0
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    2 +-
 drivers/acpi/acpica/dbexec.c   |   62 ++++++++++---------
 drivers/acpi/acpica/dbinput.c  |    2 +
 drivers/acpi/acpica/dbmethod.c |  132 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index f6404ea..94737f8 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -155,7 +155,7 @@ acpi_status acpi_db_disassemble_method(char *name);
 
 void acpi_db_disassemble_aml(char *statements, union acpi_parse_object *op);
 
-void acpi_db_batch_execute(char *count_arg);
+void acpi_db_evaluate_predefined_names(void);
 
 /*
  * dbnames - namespace commands
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index 12df291..fe3da7c 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -392,42 +392,48 @@ acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 					  acpi_db_execution_walk, NULL, NULL,
 					  NULL);
 		return;
-	} else {
-		name_string = ACPI_ALLOCATE(strlen(name) + 1);
-		if (!name_string) {
-			return;
-		}
+	}
 
-		memset(&acpi_gbl_db_method_info, 0,
-		       sizeof(struct acpi_db_method_info));
+	name_string = ACPI_ALLOCATE(strlen(name) + 1);
+	if (!name_string) {
+		return;
+	}
 
-		strcpy(name_string, name);
-		acpi_ut_strupr(name_string);
-		acpi_gbl_db_method_info.name = name_string;
-		acpi_gbl_db_method_info.args = args;
-		acpi_gbl_db_method_info.types = types;
-		acpi_gbl_db_method_info.flags = flags;
+	memset(&acpi_gbl_db_method_info, 0, sizeof(struct acpi_db_method_info));
+	strcpy(name_string, name);
+	acpi_ut_strupr(name_string);
 
-		return_obj.pointer = NULL;
-		return_obj.length = ACPI_ALLOCATE_BUFFER;
+	/* Subcommand to Execute all predefined names in the namespace */
 
-		status = acpi_db_execute_setup(&acpi_gbl_db_method_info);
-		if (ACPI_FAILURE(status)) {
-			ACPI_FREE(name_string);
-			return;
-		}
+	if (!strncmp(name_string, "PREDEF", 6)) {
+		acpi_db_evaluate_predefined_names();
+		ACPI_FREE(name_string);
+		return;
+	}
 
-		/* Get the NS node, determines existence also */
+	acpi_gbl_db_method_info.name = name_string;
+	acpi_gbl_db_method_info.args = args;
+	acpi_gbl_db_method_info.types = types;
+	acpi_gbl_db_method_info.flags = flags;
 
-		status = acpi_get_handle(NULL, acpi_gbl_db_method_info.pathname,
-					 &acpi_gbl_db_method_info.method);
-		if (ACPI_SUCCESS(status)) {
-			status =
-			    acpi_db_execute_method(&acpi_gbl_db_method_info,
-						   &return_obj);
-		}
+	return_obj.pointer = NULL;
+	return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+	status = acpi_db_execute_setup(&acpi_gbl_db_method_info);
+	if (ACPI_FAILURE(status)) {
 		ACPI_FREE(name_string);
+		return;
+	}
+
+	/* Get the NS node, determines existence also */
+
+	status = acpi_get_handle(NULL, acpi_gbl_db_method_info.pathname,
+				 &acpi_gbl_db_method_info.method);
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_db_execute_method(&acpi_gbl_db_method_info,
+						&return_obj);
 	}
+	ACPI_FREE(name_string);
 
 	/*
 	 * Allow any handlers in separate threads to complete.
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 7cd5d2e..068214f 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -286,6 +286,8 @@ static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
 	{1, "     \"Ascii String\"", "String method argument\n"},
 	{1, "     (Hex Byte List)", "Buffer method argument\n"},
 	{1, "     [Package Element List]", "Package method argument\n"},
+	{5, "  Execute predefined",
+	 "Execute all predefined (public) methods\n"},
 	{1, "  Go", "Allow method to run to completion\n"},
 	{1, "  Information", "Display info about the current method\n"},
 	{1, "  Into", "Step into (not over) a method call\n"},
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index f17a86f..314b94c 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -52,6 +52,11 @@
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbmethod")
 
+/* Local prototypes */
+static acpi_status
+acpi_db_walk_for_execute(acpi_handle obj_handle,
+			 u32 nesting_level, void *context, void **return_value);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_set_method_breakpoint
@@ -66,6 +71,7 @@ ACPI_MODULE_NAME("dbmethod")
  *              AML offset
  *
  ******************************************************************************/
+
 void
 acpi_db_set_method_breakpoint(char *location,
 			      struct acpi_walk_state *walk_state,
@@ -367,3 +373,129 @@ acpi_status acpi_db_disassemble_method(char *name)
 	acpi_ut_release_owner_id(&obj_desc->method.owner_id);
 	return (AE_OK);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_execute
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Batch execution module. Currently only executes predefined
+ *              ACPI names.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_execute(acpi_handle obj_handle,
+			 u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	struct acpi_db_execute_walk *info =
+	    (struct acpi_db_execute_walk *)context;
+	struct acpi_buffer return_obj;
+	acpi_status status;
+	char *pathname;
+	u32 i;
+	struct acpi_device_info *obj_info;
+	struct acpi_object_list param_objects;
+	union acpi_object params[ACPI_METHOD_NUM_ARGS];
+	const union acpi_predefined_info *predefined;
+
+	predefined = acpi_ut_match_predefined_method(node->name.ascii);
+	if (!predefined) {
+		return (AE_OK);
+	}
+
+	if (node->type == ACPI_TYPE_LOCAL_SCOPE) {
+		return (AE_OK);
+	}
+
+	pathname = acpi_ns_get_external_pathname(node);
+	if (!pathname) {
+		return (AE_OK);
+	}
+
+	/* Get the object info for number of method parameters */
+
+	status = acpi_get_object_info(obj_handle, &obj_info);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	param_objects.pointer = NULL;
+	param_objects.count = 0;
+
+	if (obj_info->type == ACPI_TYPE_METHOD) {
+
+		/* Setup default parameters */
+
+		for (i = 0; i < obj_info->param_count; i++) {
+			params[i].type = ACPI_TYPE_INTEGER;
+			params[i].integer.value = 1;
+		}
+
+		param_objects.pointer = params;
+		param_objects.count = obj_info->param_count;
+	}
+
+	ACPI_FREE(obj_info);
+	return_obj.pointer = NULL;
+	return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+	/* Do the actual method execution */
+
+	acpi_gbl_method_executing = TRUE;
+
+	status = acpi_evaluate_object(node, NULL, &param_objects, &return_obj);
+
+	acpi_os_printf("%-32s returned %s\n", pathname,
+		       acpi_format_exception(status));
+	acpi_gbl_method_executing = FALSE;
+	ACPI_FREE(pathname);
+
+	/* Ignore status from method execution */
+
+	status = AE_OK;
+
+	/* Update count, check if we have executed enough methods */
+
+	info->count++;
+	if (info->count >= info->max_count) {
+		status = AE_CTRL_TERMINATE;
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_evaluate_predefined_names
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Namespace batch execution. Execute predefined names in the
+ *              namespace, up to the max count, if specified.
+ *
+ ******************************************************************************/
+
+void acpi_db_evaluate_predefined_names(void)
+{
+	struct acpi_db_execute_walk info;
+
+	info.count = 0;
+	info.max_count = ACPI_UINT32_MAX;
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_walk_for_execute,
+				  NULL, (void *)&info, NULL);
+
+	acpi_os_printf("Evaluated %u predefined names in the namespace\n",
+		       info.count);
+}
-- 
1.7.10

