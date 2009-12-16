From: Len Brown <lenb@kernel.org>
Subject: [PATCH 065/103] ACPICA: Update internal namespace node/handle
 interfaces
Date: Wed, 16 Dec 2009 03:36:16 -0500
Message-ID: <f24b664dc44a4ab4df61db2258cea298eeb43a8e.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760671AbZLPMF5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:05:57 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:52 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change deletes the unnecessary acpi_ns_convert_entry_to_handle
interface and renames the acpi_ns_map_handle_to_node interface to
acpi_ns_validate_handle.  ACPICA BZ 798.

http://www.acpica.org/bugzilla/show_bug.cgi?id=798

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    4 +--
 drivers/acpi/acpica/evregion.c |    4 +-
 drivers/acpi/acpica/evxface.c  |    4 +-
 drivers/acpi/acpica/evxfevnt.c |    4 +-
 drivers/acpi/acpica/evxfregn.c |    4 +-
 drivers/acpi/acpica/nsdump.c   |    2 +-
 drivers/acpi/acpica/nsnames.c  |    2 +-
 drivers/acpi/acpica/nsutils.c  |   57 +++++++--------------------------------
 drivers/acpi/acpica/nsxfeval.c |   10 +++---
 drivers/acpi/acpica/nsxfname.c |   10 +++---
 drivers/acpi/acpica/nsxfobj.c  |   14 +++++-----
 drivers/acpi/acpica/rsxface.c  |    2 +-
 12 files changed, 40 insertions(+), 77 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index ab83919..14cef45 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -354,9 +354,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 			 const char *internal_name,
 			 u32 * converted_name_length, char **converted_name);
 
-struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle);
-
-acpi_handle acpi_ns_convert_entry_to_handle(struct acpi_namespace_node *node);
+struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle);
 
 void acpi_ns_terminate(void);
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 0bc807c..5336d91 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -718,7 +718,7 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	if (!node) {
 		return (AE_BAD_PARAMETER);
 	}
@@ -1087,7 +1087,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	if (!node) {
 		return (AE_BAD_PARAMETER);
 	}
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 10b8543..2fe0809 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -259,7 +259,7 @@ acpi_install_notify_handler(acpi_handle device,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(device);
+	node = acpi_ns_validate_handle(device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -425,7 +425,7 @@ acpi_remove_notify_handler(acpi_handle device,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(device);
+	node = acpi_ns_validate_handle(device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 4721f58..eed7a38 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -610,7 +610,7 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 		return (status);
 	}
 
-	node = acpi_ns_map_handle_to_node(gpe_device);
+	node = acpi_ns_validate_handle(gpe_device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -698,7 +698,7 @@ acpi_status acpi_remove_gpe_block(acpi_handle gpe_device)
 		return (status);
 	}
 
-	node = acpi_ns_map_handle_to_node(gpe_device);
+	node = acpi_ns_validate_handle(gpe_device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 7c3d2d3..c98aa7c 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -89,7 +89,7 @@ acpi_install_address_space_handler(acpi_handle device,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(device);
+	node = acpi_ns_validate_handle(device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -155,7 +155,7 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 	/* Convert and validate the device handle */
 
-	node = acpi_ns_map_handle_to_node(device);
+	node = acpi_ns_validate_handle(device);
 	if (!node ||
 	    ((node->type != ACPI_TYPE_DEVICE) &&
 	     (node->type != ACPI_TYPE_PROCESSOR) &&
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2deb986..e37836e 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -180,7 +180,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	this_node = acpi_ns_map_handle_to_node(obj_handle);
+	this_node = acpi_ns_validate_handle(obj_handle);
 	if (!this_node) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid object handle %p\n",
 				  obj_handle));
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index af8e6bc..8f9a487 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -232,7 +232,7 @@ acpi_ns_handle_to_pathname(acpi_handle target_handle,
 
 	ACPI_FUNCTION_TRACE_PTR(ns_handle_to_pathname, target_handle);
 
-	node = acpi_ns_map_handle_to_node(target_handle);
+	node = acpi_ns_validate_handle(target_handle);
 	if (!node) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index ea55ab4..47d91e6 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -671,24 +671,25 @@ acpi_ns_externalize_name(u32 internal_name_length,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_map_handle_to_node
+ * FUNCTION:    acpi_ns_validate_handle
  *
- * PARAMETERS:  Handle          - Handle to be converted to an Node
+ * PARAMETERS:  Handle          - Handle to be validated and typecast to a
+ *                                namespace node.
  *
- * RETURN:      A Name table entry pointer
+ * RETURN:      A pointer to a namespace node
  *
- * DESCRIPTION: Convert a namespace handle to a real Node
+ * DESCRIPTION: Convert a namespace handle to a namespace node. Handles special
+ *              cases for the root node.
  *
- * Note: Real integer handles would allow for more verification
+ * NOTE: Real integer handles would allow for more verification
  *       and keep all pointers within this subsystem - however this introduces
- *       more (and perhaps unnecessary) overhead.
- *
- * The current implemenation is basically a placeholder until such time comes
- * that it is needed.
+ *       more overhead and has not been necessary to this point. Drivers
+ *       holding handles are typically notified before a node becomes invalid
+ *       due to a table unload.
  *
  ******************************************************************************/
 
-struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle)
+struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
 {
 
 	ACPI_FUNCTION_ENTRY();
@@ -710,42 +711,6 @@ struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_convert_entry_to_handle
- *
- * PARAMETERS:  Node          - Node to be converted to a Handle
- *
- * RETURN:      A user handle
- *
- * DESCRIPTION: Convert a real Node to a namespace handle
- *
- ******************************************************************************/
-
-acpi_handle acpi_ns_convert_entry_to_handle(struct acpi_namespace_node *node)
-{
-
-	/*
-	 * Simple implementation for now;
-	 */
-	return ((acpi_handle) node);
-
-/* Example future implementation ---------------------
-
-	if (!Node)
-	{
-		return (NULL);
-	}
-
-	if (Node == acpi_gbl_root_node)
-	{
-		return (ACPI_ROOT_OBJECT);
-	}
-
-	return ((acpi_handle) Node);
-------------------------------------------------------*/
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_terminate
  *
  * PARAMETERS:  none
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f2bd1da..f0c0892 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -190,7 +190,7 @@ acpi_evaluate_object(acpi_handle handle,
 
 	/* Convert and validate the device handle */
 
-	info->prefix_node = acpi_ns_map_handle_to_node(handle);
+	info->prefix_node = acpi_ns_validate_handle(handle);
 	if (!info->prefix_node) {
 		status = AE_BAD_PARAMETER;
 		goto cleanup;
@@ -552,7 +552,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 		return (status);
 	}
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
 		return (status);
@@ -729,7 +729,7 @@ acpi_attach_data(acpi_handle obj_handle,
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -775,7 +775,7 @@ acpi_detach_data(acpi_handle obj_handle, acpi_object_handler handler)
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -822,7 +822,7 @@ acpi_get_data(acpi_handle obj_handle, acpi_object_handler handler, void **data)
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(obj_handle);
+	node = acpi_ns_validate_handle(obj_handle);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index ddc84af..e611dd9 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -93,7 +93,7 @@ acpi_get_handle(acpi_handle parent,
 	/* Convert a parent handle to a prefix node */
 
 	if (parent) {
-		prefix_node = acpi_ns_map_handle_to_node(parent);
+		prefix_node = acpi_ns_validate_handle(parent);
 		if (!prefix_node) {
 			return (AE_BAD_PARAMETER);
 		}
@@ -114,7 +114,7 @@ acpi_get_handle(acpi_handle parent,
 
 		if (!ACPI_STRCMP(pathname, ACPI_NS_ROOT_PATH)) {
 			*ret_handle =
-			    acpi_ns_convert_entry_to_handle(acpi_gbl_root_node);
+			    ACPI_CAST_PTR(acpi_handle, acpi_gbl_root_node);
 			return (AE_OK);
 		}
 	} else if (!prefix_node) {
@@ -129,7 +129,7 @@ acpi_get_handle(acpi_handle parent,
 	status =
 	    acpi_ns_get_node(prefix_node, pathname, ACPI_NS_NO_UPSEARCH, &node);
 	if (ACPI_SUCCESS(status)) {
-		*ret_handle = acpi_ns_convert_entry_to_handle(node);
+		*ret_handle = ACPI_CAST_PTR(acpi_handle, node);
 	}
 
 	return (status);
@@ -186,7 +186,7 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 		return (status);
 	}
 
-	node = acpi_ns_map_handle_to_node(handle);
+	node = acpi_ns_validate_handle(handle);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -291,7 +291,7 @@ acpi_get_object_info(acpi_handle handle,
 		goto cleanup;
 	}
 
-	node = acpi_ns_map_handle_to_node(handle);
+	node = acpi_ns_validate_handle(handle);
 	if (!node) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		return (AE_BAD_PARAMETER);
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 4071bad..0cc6ba0 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -79,7 +79,7 @@ acpi_status acpi_get_id(acpi_handle handle, acpi_owner_id * ret_id)
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(handle);
+	node = acpi_ns_validate_handle(handle);
 	if (!node) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		return (AE_BAD_PARAMETER);
@@ -132,7 +132,7 @@ acpi_status acpi_get_type(acpi_handle handle, acpi_object_type * ret_type)
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(handle);
+	node = acpi_ns_validate_handle(handle);
 	if (!node) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		return (AE_BAD_PARAMETER);
@@ -182,7 +182,7 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 
 	/* Convert and validate the handle */
 
-	node = acpi_ns_map_handle_to_node(handle);
+	node = acpi_ns_validate_handle(handle);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
@@ -191,7 +191,7 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 	/* Get the parent entry */
 
 	parent_node = acpi_ns_get_parent_node(node);
-	*ret_handle = acpi_ns_convert_entry_to_handle(parent_node);
+	*ret_handle = ACPI_CAST_PTR(acpi_handle, parent_node);
 
 	/* Return exception if parent is null */
 
@@ -251,7 +251,7 @@ acpi_get_next_object(acpi_object_type type,
 
 		/* Start search at the beginning of the specified scope */
 
-		parent_node = acpi_ns_map_handle_to_node(parent);
+		parent_node = acpi_ns_validate_handle(parent);
 		if (!parent_node) {
 			status = AE_BAD_PARAMETER;
 			goto unlock_and_exit;
@@ -260,7 +260,7 @@ acpi_get_next_object(acpi_object_type type,
 		/* Non-null handle, ignore the parent */
 		/* Convert and validate the handle */
 
-		child_node = acpi_ns_map_handle_to_node(child);
+		child_node = acpi_ns_validate_handle(child);
 		if (!child_node) {
 			status = AE_BAD_PARAMETER;
 			goto unlock_and_exit;
@@ -276,7 +276,7 @@ acpi_get_next_object(acpi_object_type type,
 	}
 
 	if (ret_handle) {
-		*ret_handle = acpi_ns_convert_entry_to_handle(node);
+		*ret_handle = ACPI_CAST_PTR(acpi_handle, node);
 	}
 
       unlock_and_exit:
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 395212b..f27feb4 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -104,7 +104,7 @@ acpi_rs_validate_parameters(acpi_handle device_handle,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	node = acpi_ns_map_handle_to_node(device_handle);
+	node = acpi_ns_validate_handle(device_handle);
 	if (!node) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
-- 
1.6.0.6

