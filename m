From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/14] ACPICA: Fix possible memory leak for Scope ASL operator
Date: Wed, 09 Dec 2009 12:22:05 -0500
Message-ID: <50b77eda9b12ff0ccf12b4021b7193d71778c0a9.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:52594 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZLIRW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:27 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE002KCAX72L14@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:25 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Using Scope(\) to change the scope to the root could cause a
single object memory leak.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dswload.c |   50 +++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 6de3a99..10fc785 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -639,26 +639,42 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		break;
 
 	case AML_SCOPE_OP:
-		/*
-		 * The Path is an object reference to an existing object.
-		 * Don't enter the name into the namespace, but look it up
-		 * for use later.
-		 */
-		status =
-		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-				   object_type, ACPI_IMODE_EXECUTE,
-				   ACPI_NS_SEARCH_PARENT, walk_state, &(node));
-		if (ACPI_FAILURE(status)) {
-#ifdef ACPI_ASL_COMPILER
-			if (status == AE_NOT_FOUND) {
-				status = AE_OK;
-			} else {
-				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+
+		/* Special case for Scope(\) -> refers to the Root node */
+
+		if (op && (op->named.node == acpi_gbl_root_node)) {
+			node = op->named.node;
+
+			status =
+			    acpi_ds_scope_stack_push(node, object_type,
+						     walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
 			}
+		} else {
+			/*
+			 * The Path is an object reference to an existing object.
+			 * Don't enter the name into the namespace, but look it up
+			 * for use later.
+			 */
+			status =
+			    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
+					   object_type, ACPI_IMODE_EXECUTE,
+					   ACPI_NS_SEARCH_PARENT, walk_state,
+					   &(node));
+			if (ACPI_FAILURE(status)) {
+#ifdef ACPI_ASL_COMPILER
+				if (status == AE_NOT_FOUND) {
+					status = AE_OK;
+				} else {
+					ACPI_ERROR_NAMESPACE(buffer_ptr,
+							     status);
+				}
 #else
-			ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
 #endif
-			return_ACPI_STATUS(status);
+				return_ACPI_STATUS(status);
+			}
 		}
 
 		/*
-- 
1.6.0.6

