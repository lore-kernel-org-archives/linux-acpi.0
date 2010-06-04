From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/16] ACPICA: Optimization: Reduce the number of namespace
 walks
Date: Fri, 04 Jun 2010 15:51:42 -0400
Message-ID: <d1ca10c372702e4c9cbfd056767b902a14f9d486.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0FHTmT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:19 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:17 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

On control method exit, only walk the namespace if the method is
known to have created namespace objects outside of its local scope.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |   18 ++++++++++++++++--
 drivers/acpi/acpica/nsalloc.c  |   20 ++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 0084633..64750ee 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -584,8 +584,22 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 * want make the objects permanent.
 		 */
 		if (!(method_desc->method.flags & AOPOBJ_MODULE_LEVEL)) {
-			acpi_ns_delete_namespace_by_owner(method_desc->method.
-							  owner_id);
+
+			/* Delete any direct children of (created by) this method */
+
+			acpi_ns_delete_namespace_subtree(walk_state->
+							 method_node);
+
+			/*
+			 * Delete any objects that were created by this method
+			 * elsewhere in the namespace (if any were created).
+			 */
+			if (method_desc->method.
+			    flags & AOPOBJ_MODIFIED_NAMESPACE) {
+				acpi_ns_delete_namespace_by_owner(method_desc->
+								  method.
+								  owner_id);
+			}
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 8d3a43a..1e5ff80 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -219,12 +219,24 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 	ACPI_FUNCTION_TRACE(ns_install_node);
 
-	/*
-	 * Get the owner ID from the Walk state. The owner ID is used to track
-	 * table deletion and deletion of objects created by methods.
-	 */
 	if (walk_state) {
+		/*
+		 * Get the owner ID from the Walk state. The owner ID is used to
+		 * track table deletion and deletion of objects created by methods.
+		 */
 		owner_id = walk_state->owner_id;
+
+		if ((walk_state->method_desc) &&
+		    (parent_node != walk_state->method_node)) {
+			/*
+			 * A method is creating a new node that is not a child of the
+			 * method (it is non-local). Mark the executing method as having
+			 * modified the namespace. This is used for cleanup when the
+			 * method exits.
+			 */
+			walk_state->method_desc->method.flags |=
+			    AOPOBJ_MODIFIED_NAMESPACE;
+		}
 	}
 
 	/* Link the new entry into the parent and existing children */
-- 
1.6.0.6

