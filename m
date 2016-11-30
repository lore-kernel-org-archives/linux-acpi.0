From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/11] ACPICA: Namespace: Add acpi_ns_handle_to_name()
Date: Wed, 30 Nov 2016 15:20:52 +0800
Message-ID: <66d49109e2e36fbd001c5bdb77f7327cbed06ffc.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25489 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756753AbcK3HU4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:20:56 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit f9fe27a68a90c9d32dd3156241a5e788fb6956ea

This patch adds acpi_ns_handle_to_name() so that in the acpi_get_name():
1. Logics can be made simpler,
2. Lock held for acpi_ns_handle_to_name() can also be applied to
   acpi_ns_handle_to_pathname().
The lock might be useless (see Link 1 below), but kept as acpi_get_name() is
an external API. Except the lock correction, this patch is a functional
no-op. BZ 1182, Lv Zheng.

Link: https://github.com/acpica/acpica/commit/f9fe27a6
Link: https://bugs.acpica.org/show_bug.cgi?id=1182 [# 1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    3 +++
 drivers/acpi/acpica/nsnames.c  |   45 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsxfname.c |   43 ++++++++++----------------------------
 3 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index bb7fca1..7affdcd 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -292,6 +292,9 @@ char *acpi_ns_get_normalized_pathname(struct acpi_namespace_node *node,
 char *acpi_ns_name_of_current_scope(struct acpi_walk_state *walk_state);
 
 acpi_status
+acpi_ns_handle_to_name(acpi_handle target_handle, struct acpi_buffer *buffer);
+
+acpi_status
 acpi_ns_handle_to_pathname(acpi_handle target_handle,
 			   struct acpi_buffer *buffer, u8 no_trailing);
 
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index f03dd41..94d5d33 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -97,6 +97,51 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_handle_to_name
+ *
+ * PARAMETERS:  target_handle           - Handle of named object whose name is
+ *                                        to be found
+ *              buffer                  - Where the name is returned
+ *
+ * RETURN:      Status, Buffer is filled with name if status is AE_OK
+ *
+ * DESCRIPTION: Build and return a full namespace name
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_handle_to_name(acpi_handle target_handle, struct acpi_buffer *buffer)
+{
+	acpi_status status;
+	struct acpi_namespace_node *node;
+	const char *node_name;
+
+	ACPI_FUNCTION_TRACE_PTR(ns_handle_to_name, target_handle);
+
+	node = acpi_ns_validate_handle(target_handle);
+	if (!node) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Validate/Allocate/Clear caller buffer */
+
+	status = acpi_ut_initialize_buffer(buffer, ACPI_PATH_SEGMENT_LENGTH);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Just copy the ACPI name from the Node and zero terminate it */
+
+	node_name = acpi_ut_get_node_name(node);
+	ACPI_MOVE_NAME(buffer->pointer, node_name);
+	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%4.4s\n", (char *)buffer->pointer));
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ns_handle_to_pathname
  *
  * PARAMETERS:  target_handle           - Handle of named object whose name is
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 76a1bd4..e525cbe 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -158,8 +158,6 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer *buffer)
 {
 	acpi_status status;
-	struct acpi_namespace_node *node;
-	const char *node_name;
 
 	/* Parameter validation */
 
@@ -172,18 +170,6 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 		return (status);
 	}
 
-	if (name_type == ACPI_FULL_PATHNAME ||
-	    name_type == ACPI_FULL_PATHNAME_NO_TRAILING) {
-
-		/* Get the full pathname (From the namespace root) */
-
-		status = acpi_ns_handle_to_pathname(handle, buffer,
-						    name_type ==
-						    ACPI_FULL_PATHNAME ? FALSE :
-						    TRUE);
-		return (status);
-	}
-
 	/*
 	 * Wants the single segment ACPI name.
 	 * Validate handle and convert to a namespace Node
@@ -193,27 +179,20 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 		return (status);
 	}
 
-	node = acpi_ns_validate_handle(handle);
-	if (!node) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Validate/Allocate/Clear caller buffer */
-
-	status = acpi_ut_initialize_buffer(buffer, ACPI_PATH_SEGMENT_LENGTH);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
+	if (name_type == ACPI_FULL_PATHNAME ||
+	    name_type == ACPI_FULL_PATHNAME_NO_TRAILING) {
 
-	/* Just copy the ACPI name from the Node and zero terminate it */
+		/* Get the full pathname (From the namespace root) */
 
-	node_name = acpi_ut_get_node_name(node);
-	ACPI_MOVE_NAME(buffer->pointer, node_name);
-	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
-	status = AE_OK;
+		status = acpi_ns_handle_to_pathname(handle, buffer,
+						    name_type ==
+						    ACPI_FULL_PATHNAME ? FALSE :
+						    TRUE);
+	} else {
+		/* Get the single name */
 
-unlock_and_exit:
+		status = acpi_ns_handle_to_name(handle, buffer);
+	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
-- 
1.7.10

