From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/65] ACPICA: Simplify and optimize NsGetNextNode function
Date: Fri, 29 May 2009 21:42:03 -0400
Message-ID: <8c725bf93706db976e9de495579ca625d493e809.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60019 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbZE3Bmv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:51 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00EJHORHEEA0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:53 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Reduced parameter count and reduced code for this frequently
used function.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |   13 ++++++-
 drivers/acpi/acpica/nsalloc.c  |   14 ++------
 drivers/acpi/acpica/nswalk.c   |   69 ++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/nsxfobj.c  |    2 +-
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 46cb5b4..94cdc2b 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -99,10 +99,19 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_walk_callback user_function,
 		       void *context, void **return_value);
 
-struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct acpi_namespace_node
-						  *parent, struct acpi_namespace_node
+struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
+						  *parent,
+						  struct acpi_namespace_node
 						  *child);
 
+struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
+							struct
+							acpi_namespace_node
+							*parent,
+							struct
+							acpi_namespace_node
+							*child);
+
 /*
  * nsparse - table parsing
  */
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index aceb931..efc971a 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -334,9 +334,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 
 		/* Get the next node in this scope (NULL if none) */
 
-		child_node =
-		    acpi_ns_get_next_node(ACPI_TYPE_ANY, parent_node,
-					  child_node);
+		child_node = acpi_ns_get_next_node(parent_node, child_node);
 		if (child_node) {
 
 			/* Found a child node - detach any attached object */
@@ -345,8 +343,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 
 			/* Check if this node has any children */
 
-			if (acpi_ns_get_next_node
-			    (ACPI_TYPE_ANY, child_node, NULL)) {
+			if (child_node->child) {
 				/*
 				 * There is at least one child of this node,
 				 * visit the node
@@ -432,9 +429,7 @@ void acpi_ns_delete_namespace_by_owner(acpi_owner_id owner_id)
 		 * Get the next child of this parent node. When child_node is NULL,
 		 * the first child of the parent is returned
 		 */
-		child_node =
-		    acpi_ns_get_next_node(ACPI_TYPE_ANY, parent_node,
-					  child_node);
+		child_node = acpi_ns_get_next_node(parent_node, child_node);
 
 		if (deletion_node) {
 			acpi_ns_delete_children(deletion_node);
@@ -452,8 +447,7 @@ void acpi_ns_delete_namespace_by_owner(acpi_owner_id owner_id)
 
 			/* Check if this node has any children */
 
-			if (acpi_ns_get_next_node
-			    (ACPI_TYPE_ANY, child_node, NULL)) {
+			if (child_node->child) {
 				/*
 				 * There is at least one child of this node,
 				 * visit the node
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 83e3aa6..35539df 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -52,8 +52,7 @@ ACPI_MODULE_NAME("nswalk")
  *
  * FUNCTION:    acpi_ns_get_next_node
  *
- * PARAMETERS:  Type                - Type of node to be searched for
- *              parent_node         - Parent node whose children we are
+ * PARAMETERS:  parent_node         - Parent node whose children we are
  *                                    getting
  *              child_node          - Previous child that was found.
  *                                    The NEXT child will be returned
@@ -66,27 +65,68 @@ ACPI_MODULE_NAME("nswalk")
  *              within Scope is returned.
  *
  ******************************************************************************/
-struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct acpi_namespace_node
-						  *parent_node, struct acpi_namespace_node
+struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
+						  *parent_node,
+						  struct acpi_namespace_node
 						  *child_node)
 {
-	struct acpi_namespace_node *next_node = NULL;
-
 	ACPI_FUNCTION_ENTRY();
 
 	if (!child_node) {
 
 		/* It's really the parent's _scope_ that we want */
 
-		next_node = parent_node->child;
+		return parent_node->child;
 	}
 
-	else {
-		/* Start search at the NEXT node */
-
-		next_node = acpi_ns_get_next_valid_node(child_node);
+	/*
+	 * Get the next node.
+	 *
+	 * If we are at the end of this peer list, return NULL
+	 */
+	if (child_node->flags & ANOBJ_END_OF_PEER_LIST) {
+		return NULL;
 	}
 
+	/* Otherwise just return the next peer */
+
+	return child_node->peer;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_get_next_node_typed
+ *
+ * PARAMETERS:  Type                - Type of node to be searched for
+ *              parent_node         - Parent node whose children we are
+ *                                    getting
+ *              child_node          - Previous child that was found.
+ *                                    The NEXT child will be returned
+ *
+ * RETURN:      struct acpi_namespace_node - Pointer to the NEXT child or NULL if
+ *                                    none is found.
+ *
+ * DESCRIPTION: Return the next peer node within the namespace.  If Handle
+ *              is valid, Scope is ignored.  Otherwise, the first node
+ *              within Scope is returned.
+ *
+ ******************************************************************************/
+
+struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
+							struct
+							acpi_namespace_node
+							*parent_node,
+							struct
+							acpi_namespace_node
+							*child_node)
+{
+	struct acpi_namespace_node *next_node = NULL;
+
+	ACPI_FUNCTION_ENTRY();
+
+	next_node = acpi_ns_get_next_node(parent_node, child_node);
+
+
 	/* If any type is OK, we are done */
 
 	if (type == ACPI_TYPE_ANY) {
@@ -186,9 +226,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		/* Get the next node in this scope.  Null if not found */
 
 		status = AE_OK;
-		child_node =
-		    acpi_ns_get_next_node(ACPI_TYPE_ANY, parent_node,
-					  child_node);
+		child_node = acpi_ns_get_next_node(parent_node, child_node);
 		if (child_node) {
 
 			/* Found next child, get the type if we are not searching for ANY */
@@ -269,8 +307,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			 * function has specified that the maximum depth has been reached.
 			 */
 			if ((level < max_depth) && (status != AE_CTRL_DEPTH)) {
-				if (acpi_ns_get_next_node
-				    (ACPI_TYPE_ANY, child_node, NULL)) {
+				if (child_node->child) {
 
 					/* There is at least one child of this node, visit it */
 
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 1c7efc1..dd33d8b 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -268,7 +268,7 @@ acpi_get_next_object(acpi_object_type type,
 
 	/* Internal function does the real work */
 
-	node = acpi_ns_get_next_node(type, parent_node, child_node);
+	node = acpi_ns_get_next_node_typed(type, parent_node, child_node);
 	if (!node) {
 		status = AE_NOT_FOUND;
 		goto unlock_and_exit;
-- 
1.6.0.6

