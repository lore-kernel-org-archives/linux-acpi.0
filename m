From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/6] ACPICA: Add support to delete all objects attached to the root namespace node.
Date: Thu, 21 Nov 2013 12:20:06 +0800
Message-ID: <531e4c6aef4d98599f25fe9f704f2c5e17279496.1384747397.git.lv.zheng@intel.com>
References: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21447 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab3KUEU1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:20:27 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This fix deletes any and all objects that have been attached to the
root node (via AcpiAttachData). Reported by Tomasz Nowicki.
ACPICA BZ 1026.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsalloc.c |    6 ++++++
 drivers/acpi/acpica/nsutils.c |   18 ++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index bc3f598..fd1ff54 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -134,6 +134,12 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 		obj_desc = next_desc;
 	}
 
+	/* Special case for the statically allocated root node */
+
+	if (node == acpi_gbl_root_node) {
+		return;
+	}
+
 	/* Now we can delete the node */
 
 	(void)acpi_os_release_object(acpi_gbl_namespace_cache, node);
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index cc2fea9..4a0665b 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -593,24 +593,26 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
 
 void acpi_ns_terminate(void)
 {
-	union acpi_operand_object *obj_desc;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ns_terminate);
 
 	/*
-	 * 1) Free the entire namespace -- all nodes and objects
-	 *
-	 * Delete all object descriptors attached to namepsace nodes
+	 * Free the entire namespace -- all nodes and all objects
+	 * attached to the nodes
 	 */
 	acpi_ns_delete_namespace_subtree(acpi_gbl_root_node);
 
-	/* Detach any objects attached to the root */
+	/* Delete any objects attached to the root node */
 
-	obj_desc = acpi_ns_get_attached_object(acpi_gbl_root_node);
-	if (obj_desc) {
-		acpi_ns_detach_object(acpi_gbl_root_node);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
 	}
 
+	acpi_ns_delete_node(acpi_gbl_root_node);
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Namespace freed\n"));
 	return_VOID;
 }
-- 
1.7.10

