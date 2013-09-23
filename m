From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 09/14] ACPICA: Debugger: Add new command to display full namespace pathnames.
Date: Mon, 23 Sep 2013 09:52:19 +0800
Message-ID: <17757994cc8baee03b43487def7f5ec89a4d14dd.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33710 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab3IWBw2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:52:28 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Paths command displays the full pathname and object type for
the entire namespace. Alternative to the Namespace command.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    2 +
 drivers/acpi/acpica/acnamesp.h |    6 ++
 drivers/acpi/acpica/nsdump.c   |  134 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 30c2d69..27c36a5 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -155,6 +155,8 @@ void acpi_db_set_scope(char *name);
 
 void acpi_db_dump_namespace(char *start_arg, char *depth_arg);
 
+void acpi_db_dump_namespace_paths(void);
+
 void acpi_db_dump_namespace_by_owner(char *owner_arg, char *depth_arg);
 
 acpi_status acpi_db_find_name_in_namespace(char *name_arg);
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 40b04bd..e6138ac 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -213,6 +213,12 @@ acpi_ns_dump_objects(acpi_object_type type,
 		     u8 display_type,
 		     u32 max_depth,
 		     acpi_owner_id owner_id, acpi_handle start_handle);
+
+void
+acpi_ns_dump_object_paths(acpi_object_type type,
+			  u8 display_type,
+			  u32 max_depth,
+			  acpi_owner_id owner_id, acpi_handle start_handle);
 #endif				/* ACPI_FUTURE_USAGE */
 
 /*
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 7418c77..8063385 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -59,6 +59,17 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 #endif
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+
+#ifdef	ACPI_FUTURE_USAGE
+static acpi_status
+acpi_ns_dump_one_object_path(acpi_handle obj_handle,
+			     u32 level, void *context, void **return_value);
+
+static acpi_status
+acpi_ns_get_max_depth(acpi_handle obj_handle,
+		      u32 level, void *context, void **return_value);
+#endif				/* ACPI_FUTURE_USAGE */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_print_pathname
@@ -671,6 +682,129 @@ acpi_ns_dump_objects(acpi_object_type type,
 }
 #endif				/* ACPI_FUTURE_USAGE */
 
+#ifdef	ACPI_FUTURE_USAGE
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_dump_one_object_path, acpi_ns_get_max_depth
+ *
+ * PARAMETERS:  obj_handle          - Node to be dumped
+ *              level               - Nesting level of the handle
+ *              context             - Passed into walk_namespace
+ *              return_value        - Not used
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Dump the full pathname to a namespace object. acp_ns_get_max_depth
+ *              computes the maximum nesting depth in the namespace tree, in
+ *              order to simplify formatting in acpi_ns_dump_one_object_path.
+ *              These procedures are user_functions called by acpi_ns_walk_namespace.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_dump_one_object_path(acpi_handle obj_handle,
+			     u32 level, void *context, void **return_value)
+{
+	u32 max_level = *((u32 *)context);
+	char *pathname;
+	struct acpi_namespace_node *node;
+	int path_indent;
+
+	if (!obj_handle) {
+		return (AE_OK);
+	}
+
+	node = acpi_ns_validate_handle(obj_handle);
+	pathname = acpi_ns_get_external_pathname(node);
+
+	path_indent = 1;
+	if (level <= max_level) {
+		path_indent = max_level - level + 1;
+	}
+
+	acpi_os_printf("%2d%*s%-12s%*s",
+		       level, level, " ", acpi_ut_get_type_name(node->type),
+		       path_indent, " ");
+
+	acpi_os_printf("%s\n", &pathname[1]);
+	ACPI_FREE(pathname);
+	return (AE_OK);
+}
+
+static acpi_status
+acpi_ns_get_max_depth(acpi_handle obj_handle,
+		      u32 level, void *context, void **return_value)
+{
+	u32 *max_level = (u32 *)context;
+
+	if (level > *max_level) {
+		*max_level = level;
+	}
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_dump_object_paths
+ *
+ * PARAMETERS:  type                - Object type to be dumped
+ *              display_type        - 0 or ACPI_DISPLAY_SUMMARY
+ *              max_depth           - Maximum depth of dump. Use ACPI_UINT32_MAX
+ *                                    for an effectively unlimited depth.
+ *              owner_id            - Dump only objects owned by this ID. Use
+ *                                    ACPI_UINT32_MAX to match all owners.
+ *              start_handle        - Where in namespace to start/end search
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump full object pathnames within the loaded namespace. Uses
+ *              acpi_ns_walk_namespace in conjunction with acpi_ns_dump_one_object_path.
+ *
+ ******************************************************************************/
+
+void
+acpi_ns_dump_object_paths(acpi_object_type type,
+			  u8 display_type,
+			  u32 max_depth,
+			  acpi_owner_id owner_id, acpi_handle start_handle)
+{
+	acpi_status status;
+	u32 max_level = 0;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/*
+	 * Just lock the entire namespace for the duration of the dump.
+	 * We don't want any changes to the namespace during this time,
+	 * especially the temporary nodes since we are going to display
+	 * them also.
+	 */
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not acquire namespace mutex\n");
+		return;
+	}
+
+	/* Get the max depth of the namespace tree, for formatting later */
+
+	(void)acpi_ns_walk_namespace(type, start_handle, max_depth,
+				     ACPI_NS_WALK_NO_UNLOCK |
+				     ACPI_NS_WALK_TEMP_NODES,
+				     acpi_ns_get_max_depth, NULL,
+				     (void *)&max_level, NULL);
+
+	/* Now dump the entire namespace */
+
+	(void)acpi_ns_walk_namespace(type, start_handle, max_depth,
+				     ACPI_NS_WALK_NO_UNLOCK |
+				     ACPI_NS_WALK_TEMP_NODES,
+				     acpi_ns_dump_one_object_path, NULL,
+				     (void *)&max_level, NULL);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+}
+#endif				/* ACPI_FUTURE_USAGE */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_entry
-- 
1.7.10

