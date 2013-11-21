From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/6] ACPICA: Delete all attached data objects during namespace node deletion.
Date: Thu, 21 Nov 2013 12:19:55 +0800
Message-ID: <ffb87e09e4cc4747b62cd5084f66b00c230becd3.1384747397.git.lv.zheng@intel.com>
References: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab3KUEUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:20:17 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This fix updates namespace node deletion to delete the entire list
of attached objects (attached via AcpiAttachObject) instead of
just one of the attached items. ACPICA BZ 1024.
Tomasz Nowicki (tomasz.nowicki@linaro.org).

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsalloc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 2437373..bc3f598 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -106,6 +106,7 @@ struct acpi_namespace_node *acpi_ns_create_node(u32 name)
 void acpi_ns_delete_node(struct acpi_namespace_node *node)
 {
 	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *next_desc;
 
 	ACPI_FUNCTION_NAME(ns_delete_node);
 
@@ -114,12 +115,13 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 	acpi_ns_detach_object(node);
 
 	/*
-	 * Delete an attached data object if present (an object that was created
-	 * and attached via acpi_attach_data). Note: After any normal object is
-	 * detached above, the only possible remaining object is a data object.
+	 * Delete an attached data object list if present (objects that were
+	 * attached via acpi_attach_data). Note: After any normal object is
+	 * detached above, the only possible remaining object(s) are data
+	 * objects, in a linked list.
 	 */
 	obj_desc = node->object;
-	if (obj_desc && (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA)) {
+	while (obj_desc && (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA)) {
 
 		/* Invoke the attached data deletion handler if present */
 
@@ -127,7 +129,9 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 			obj_desc->data.handler(node, obj_desc->data.pointer);
 		}
 
+		next_desc = obj_desc->common.next_object;
 		acpi_ut_remove_reference(obj_desc);
+		obj_desc = next_desc;
 	}
 
 	/* Now we can delete the node */
-- 
1.7.10

