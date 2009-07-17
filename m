From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] ACPICA: Support both preorder and postorder namespace
	walks
Date: Fri, 17 Jul 2009 11:27:26 -0600
Message-ID: <20090717172726.24968.87065.stgit@bob.kio>
References: <20090717172248.24968.31911.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:7214 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934069AbZGQR10 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2009 13:27:26 -0400
In-Reply-To: <20090717172248.24968.31911.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We need to handle device addition in preorder (so we add a new device
before any children), but device removal in postorder (so we remove any
children before removing the parent).

The callback from AcpiWalkNamespace() is done in preorder.  This patch adds
a new AcpiWalkNamespace2() that takes both preorder and a postorder
callbacks.

This patch may be used under either the GPL v2 or the BSD-style license
used for the Intel ACPICA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/acpica/acnamesp.h |    9 +++
 drivers/acpi/acpica/nswalk.c   |  106 ++++++++++++++++++++++++++++++++++++----
 drivers/acpi/acpica/nsxfeval.c |   41 +++++++++++----
 include/acpi/acpixf.h          |    8 +++
 4 files changed, 141 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 94cdc2b..cb3a34f 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -99,6 +99,15 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_walk_callback user_function,
 		       void *context, void **return_value);
 
+acpi_status
+acpi_ns_walk_namespace2(acpi_object_type type,
+			acpi_handle start_object,
+			u32 max_depth,
+			u32 flags,
+			acpi_walk_callback pre_user_function,
+			acpi_walk_callback post_user_function,
+			void *context, void **return_value);
+
 struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
 						  *parent,
 						  struct acpi_namespace_node
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 572a181..4b01550 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -168,6 +168,10 @@ acpi_call_user_function(acpi_object_type type,
 	acpi_status status;
 	acpi_status mutex_status;
 
+	if (!user_function) {
+		return (AE_OK);
+	}
+
 	/*
 	 * Ignore all temporary namespace nodes (created during control
 	 * method execution) unless told otherwise. These temporary nodes
@@ -219,8 +223,11 @@ acpi_call_user_function(acpi_object_type type,
  *              max_depth           - Depth to which search is to reach
  *              Flags               - Whether to unlock the NS before invoking
  *                                    the callback routine
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
+ *              pre_user_function   - Called in preorder when an object of
+ *				      "Type" is found
+ *              post_user_function  - Called in postorder when an object of
+ *				      "Type" is found
+ *              Context             - Passed to user functions
  *              return_value        - from the user_function if terminated early.
  *                                    Otherwise, returns NULL.
  * RETURNS:     Status
@@ -241,12 +248,13 @@ acpi_call_user_function(acpi_object_type type,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_walk_namespace(acpi_object_type type,
-		       acpi_handle start_node,
-		       u32 max_depth,
-		       u32 flags,
-		       acpi_walk_callback user_function,
-		       void *context, void **return_value)
+acpi_ns_walk_namespace2(acpi_object_type type,
+		        acpi_handle start_node,
+		        u32 max_depth,
+		        u32 flags,
+		        acpi_walk_callback pre_user_function,
+		        acpi_walk_callback post_user_function,
+		        void *context, void **return_value)
 {
 	acpi_status status;
 	struct acpi_namespace_node *child_node;
@@ -283,7 +291,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		if (child_node) {
 
 			status = acpi_call_user_function(type, flags,
-					user_function, child_node, level,
+					pre_user_function, child_node, level,
 					context, return_value);
 
 			switch (status) {
@@ -320,16 +328,79 @@ acpi_ns_walk_namespace(acpi_object_type type,
 					level++;
 					parent_node = child_node;
 					child_node = NULL;
+				} else {
+
+					/*
+					 * This node has no children, so visit
+					 * it in postorder before going back
+					 * upwards.
+					 */
+
+					status = acpi_call_user_function(type, flags,
+						post_user_function, child_node, level,
+						context, return_value);
+
+					switch (status) {
+					case AE_OK:
+					case AE_CTRL_DEPTH:
+
+						/* Just keep going */
+						break;
+
+					case AE_CTRL_TERMINATE:
+
+						/* Exit now, with OK status */
+
+						return_ACPI_STATUS(AE_OK);
+
+					default:
+
+						/* All others are valid exceptions */
+
+						return_ACPI_STATUS(status);
+					}
 				}
 			}
 		} else {
 			/*
-			 * No more children of this node (acpi_ns_get_next_node failed), go
-			 * back upwards in the namespace tree to the node's parent.
+			 * No more children of this node (acpi_ns_get_next_node failed),
+			 * call the postorder user function and go back upwards in the
+			 * namespace tree to the node's parent.
 			 */
 			level--;
 			child_node = parent_node;
 			parent_node = acpi_ns_get_parent_node(parent_node);
+
+			/*
+			 * We don't visit the starting node in preorder, so
+			 * don't visit it in postorder either.
+			 */
+
+			if (level > 0) {
+				status = acpi_call_user_function(type, flags,
+					post_user_function, child_node, level,
+					context, return_value);
+
+				switch (status) {
+				case AE_OK:
+				case AE_CTRL_DEPTH:
+
+					/* Just keep going */
+					break;
+
+				case AE_CTRL_TERMINATE:
+
+					/* Exit now, with OK status */
+
+					return_ACPI_STATUS(AE_OK);
+
+				default:
+
+					/* All others are valid exceptions */
+
+					return_ACPI_STATUS(status);
+				}
+			}
 		}
 	}
 
@@ -337,3 +408,16 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 	return_ACPI_STATUS(AE_OK);
 }
+
+acpi_status
+acpi_ns_walk_namespace(acpi_object_type type,
+		       acpi_handle start_node,
+		       u32 max_depth,
+		       u32 flags,
+		       acpi_walk_callback user_function,
+		       void *context, void **return_value)
+{
+	return acpi_ns_walk_namespace2(type, start_node, max_depth, flags,
+				       user_function, NULL,
+				       context, return_value);
+}
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index daf4ad3..2cc5ce4 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -428,13 +428,16 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_walk_namespace
+ * FUNCTION:    acpi_walk_namespace2
  *
  * PARAMETERS:  Type                - acpi_object_type to search for
  *              start_object        - Handle in namespace where search begins
  *              max_depth           - Depth to which search is to reach
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
+ *              pre_user_function   - Called in preorder when an object of
+ *				      "Type" is found
+ *              post_user_function  - Called in postorder when an object of
+ *				      "Type" is found
+ *              Context             - Passed to user functions
  *              return_value        - Location where return value of
  *                                    user_function is put if terminated early
  *
@@ -457,11 +460,12 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  ******************************************************************************/
 
 acpi_status
-acpi_walk_namespace(acpi_object_type type,
-		    acpi_handle start_object,
-		    u32 max_depth,
-		    acpi_walk_callback user_function,
-		    void *context, void **return_value)
+acpi_walk_namespace2(acpi_object_type type,
+		     acpi_handle start_object,
+		     u32 max_depth,
+		     acpi_walk_callback pre_user_function,
+		     acpi_walk_callback post_user_function,
+		     void *context, void **return_value)
 {
 	acpi_status status;
 
@@ -469,7 +473,8 @@ acpi_walk_namespace(acpi_object_type type,
 
 	/* Parameter validation */
 
-	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) || (!user_function)) {
+	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) ||
+	    ((!pre_user_function) && (!post_user_function))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -500,9 +505,10 @@ acpi_walk_namespace(acpi_object_type type,
 		goto unlock_and_exit;
 	}
 
-	status = acpi_ns_walk_namespace(type, start_object, max_depth,
-					ACPI_NS_WALK_UNLOCK, user_function,
-					context, return_value);
+	status = acpi_ns_walk_namespace2(type, start_object, max_depth,
+					 ACPI_NS_WALK_UNLOCK, pre_user_function,
+					 post_user_function,
+					 context, return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
@@ -511,6 +517,17 @@ acpi_walk_namespace(acpi_object_type type,
 	return_ACPI_STATUS(status);
 }
 
+acpi_status
+acpi_walk_namespace(acpi_object_type type,
+		    acpi_handle start_object,
+		    u32 max_depth,
+		    acpi_walk_callback user_function,
+		    void *context, void **return_value)
+{
+	return acpi_walk_namespace2(type, start_object, max_depth,
+				    user_function, NULL, context, return_value);
+}
+
 ACPI_EXPORT_SYMBOL(acpi_walk_namespace)
 
 /*******************************************************************************
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 82ec6a3..8404879 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -157,6 +157,14 @@ acpi_walk_namespace(acpi_object_type type,
 		    void *context, void **return_value);
 
 acpi_status
+acpi_walk_namespace2(acpi_object_type type,
+		     acpi_handle start_object,
+		     u32 max_depth,
+		     acpi_walk_callback pre_user_function,
+		     acpi_walk_callback post_user_function,
+		     void *context, void **return_value);
+
+acpi_status
 acpi_get_devices(const char *HID,
 		 acpi_walk_callback user_function,
 		 void *context, void **return_value);

