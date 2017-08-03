From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: Interpreter: Update handling for Alias operator
Date: Thu,  3 Aug 2017 14:27:09 +0800
Message-ID: <c9da4a747431585e1b1648940c8ef8147ad345da.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30275 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdHCG1M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:12 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 719d0bdd48e3e8e7a62a86c04922b9f41da6def0

Provide common creation code for the Alias operator. All objects
are now handled the same, with the only exception being the
Method() operator. It has a special internal Alias type.

Link: https://github.com/acpica/acpica/commit/719d0bdd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/excreate.c | 61 ++++++++++--------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 6867586..b8adb11 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -88,72 +88,39 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	}
 
 	/* Ensure that the target node is valid */
+
 	if (!target_node) {
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
-	/*
-	 * For objects that can never change (i.e., the NS node will
-	 * permanently point to the same object), we can simply attach
-	 * the object to the new NS node. For other objects (such as
-	 * Integers, buffers, etc.), we have to point the Alias node
-	 * to the original Node.
-	 */
-	switch (target_node->type) {
-
-		/* For these types, the sub-object can change dynamically via a Store */
-
-	case ACPI_TYPE_INTEGER:
-	case ACPI_TYPE_STRING:
-	case ACPI_TYPE_BUFFER:
-	case ACPI_TYPE_PACKAGE:
-	case ACPI_TYPE_BUFFER_FIELD:
-		/*
-		 * These types open a new scope, so we need the NS node in order to access
-		 * any children.
-		 */
-	case ACPI_TYPE_DEVICE:
-	case ACPI_TYPE_POWER:
-	case ACPI_TYPE_PROCESSOR:
-	case ACPI_TYPE_THERMAL:
-	case ACPI_TYPE_LOCAL_SCOPE:
-		/*
-		 * The new alias has the type ALIAS and points to the original
-		 * NS node, not the object itself.
-		 */
-		alias_node->type = ACPI_TYPE_LOCAL_ALIAS;
-		alias_node->object =
-		    ACPI_CAST_PTR(union acpi_operand_object, target_node);
-		break;
+	/* Construct the alias object (a namespace node) */
 
+	switch (target_node->type) {
 	case ACPI_TYPE_METHOD:
 		/*
-		 * Control method aliases need to be differentiated
+		 * Control method aliases need to be differentiated with
+		 * a special type
 		 */
 		alias_node->type = ACPI_TYPE_LOCAL_METHOD_ALIAS;
-		alias_node->object =
-		    ACPI_CAST_PTR(union acpi_operand_object, target_node);
 		break;
 
 	default:
-
-		/* Attach the original source object to the new Alias Node */
-
 		/*
-		 * The new alias assumes the type of the target, and it points
-		 * to the same object. The reference count of the object has an
-		 * additional reference to prevent deletion out from under either the
-		 * target node or the alias Node
+		 * All other object types.
+		 *
+		 * The new alias has the type ALIAS and points to the original
+		 * NS node, not the object itself.
 		 */
-		status = acpi_ns_attach_object(alias_node,
-					       acpi_ns_get_attached_object
-					       (target_node),
-					       target_node->type);
+		alias_node->type = ACPI_TYPE_LOCAL_ALIAS;
+		alias_node->object =
+		    ACPI_CAST_PTR(union acpi_operand_object, target_node);
 		break;
 	}
 
 	/* Since both operands are Nodes, we don't need to delete them */
 
+	alias_node->object =
+	    ACPI_CAST_PTR(union acpi_operand_object, target_node);
 	return_ACPI_STATUS(status);
 }
 
-- 
2.7.4

