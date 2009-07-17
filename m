From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] ACPICA: Factor out user callback function from namespace
	walk
Date: Fri, 17 Jul 2009 11:27:21 -0600
Message-ID: <20090717172721.24968.92501.stgit@bob.kio>
References: <20090717172248.24968.31911.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:35135 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933899AbZGQR1V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2009 13:27:21 -0400
In-Reply-To: <20090717172248.24968.31911.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch factors out the code to call a user callback function while
walking the namespace.  This makes the "tree navigation" part of the
walk more visible and will make it easier to add a postorder callback.

This patch may be used under either the GPL v2 or the BSD-style license
used for the Intel ACPICA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/acpica/nswalk.c |  130 ++++++++++++++++++++++--------------------
 1 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 35539df..572a181 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -156,6 +156,60 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
 	return (NULL);
 }
 
+static acpi_status
+acpi_call_user_function(acpi_object_type type,
+			u32 flags,
+			acpi_walk_callback user_function,
+			struct acpi_namespace_node *node,
+			u32 level,
+			void *context,
+			void **return_value)
+{
+	acpi_status status;
+	acpi_status mutex_status;
+
+	/*
+	 * Ignore all temporary namespace nodes (created during control
+	 * method execution) unless told otherwise. These temporary nodes
+	 * can cause a race condition because they can be deleted during
+	 * the execution of the user function (if the namespace is
+	 * unlocked before invocation of the user function.) Only the
+	 * debugger namespace dump will examine the temporary nodes.
+	 */
+	if ((node->flags & ANOBJ_TEMPORARY) &&
+	    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
+		return (AE_CTRL_DEPTH);
+	}
+
+	/* Type must match requested type unless we want ACPI_TYPE_ANY */
+
+	if (node->type != type && type != ACPI_TYPE_ANY) {
+		return (AE_OK);
+	}
+
+	/*
+	 * Found a matching node, invoke the user callback function.
+	 * Unlock the namespace if flag is set.
+	 */
+	if (flags & ACPI_NS_WALK_UNLOCK) {
+		mutex_status = acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(mutex_status)) {
+			return (mutex_status);
+		}
+	}
+
+	status = user_function(node, level, context, return_value);
+
+	if (flags & ACPI_NS_WALK_UNLOCK) {
+		mutex_status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(mutex_status)) {
+			return (mutex_status);
+		}
+	}
+
+	return (status);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_walk_namespace
@@ -195,7 +249,6 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       void *context, void **return_value)
 {
 	acpi_status status;
-	acpi_status mutex_status;
 	struct acpi_namespace_node *child_node;
 	struct acpi_namespace_node *parent_node;
 	acpi_object_type child_type;
@@ -229,75 +282,28 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		child_node = acpi_ns_get_next_node(parent_node, child_node);
 		if (child_node) {
 
-			/* Found next child, get the type if we are not searching for ANY */
+			status = acpi_call_user_function(type, flags,
+					user_function, child_node, level,
+					context, return_value);
 
-			if (type != ACPI_TYPE_ANY) {
-				child_type = child_node->type;
-			}
+			switch (status) {
+			case AE_OK:
+			case AE_CTRL_DEPTH:
 
-			/*
-			 * Ignore all temporary namespace nodes (created during control
-			 * method execution) unless told otherwise. These temporary nodes
-			 * can cause a race condition because they can be deleted during
-			 * the execution of the user function (if the namespace is
-			 * unlocked before invocation of the user function.) Only the
-			 * debugger namespace dump will examine the temporary nodes.
-			 */
-			if ((child_node->flags & ANOBJ_TEMPORARY) &&
-			    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
-				status = AE_CTRL_DEPTH;
-			}
-
-			/* Type must match requested type */
-
-			else if (child_type == type) {
-				/*
-				 * Found a matching node, invoke the user callback function.
-				 * Unlock the namespace if flag is set.
-				 */
-				if (flags & ACPI_NS_WALK_UNLOCK) {
-					mutex_status =
-					    acpi_ut_release_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(mutex_status)) {
-						return_ACPI_STATUS
-						    (mutex_status);
-					}
-				}
-
-				status =
-				    user_function(child_node, level, context,
-						  return_value);
-
-				if (flags & ACPI_NS_WALK_UNLOCK) {
-					mutex_status =
-					    acpi_ut_acquire_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(mutex_status)) {
-						return_ACPI_STATUS
-						    (mutex_status);
-					}
-				}
-
-				switch (status) {
-				case AE_OK:
-				case AE_CTRL_DEPTH:
+				/* Just keep going */
+				break;
 
-					/* Just keep going */
-					break;
+			case AE_CTRL_TERMINATE:
 
-				case AE_CTRL_TERMINATE:
+				/* Exit now, with OK status */
 
-					/* Exit now, with OK status */
+				return_ACPI_STATUS(AE_OK);
 
-					return_ACPI_STATUS(AE_OK);
+			default:
 
-				default:
+				/* All others are valid exceptions */
 
-					/* All others are valid exceptions */
-
-					return_ACPI_STATUS(status);
-				}
+				return_ACPI_STATUS(status);
 			}
 
 			/*

