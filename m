From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/73] ACPICA: Fix for Alias operator to see target child objects
Date: Sat, 12 Apr 2008 00:25:05 -0400
Message-ID: <511a18245a849c40edee30071a354ac3f25aa091.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753015AbYDLE2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:06 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the Alias operator when the target of the
alias is a named ASL operator that opens a new scope -- Scope,
Device, PowerResource, Processor, and ThermalZone. In these cases,
any children of the original operator could not be accessed via
the alias, potentially causing unexpected AE_NOT_FOUND exceptions.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/excreate.c  |   20 ++++++--
 drivers/acpi/namespace/nsaccess.c |   96 +++++++++++++++++++++++--------------
 2 files changed, 75 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index 6e9a23e..b391439 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -96,6 +96,9 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	 * to the original Node.
 	 */
 	switch (target_node->type) {
+
+		/* For these types, the sub-object can change dynamically via a Store */
+
 	case ACPI_TYPE_INTEGER:
 	case ACPI_TYPE_STRING:
 	case ACPI_TYPE_BUFFER:
@@ -103,9 +106,18 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	case ACPI_TYPE_BUFFER_FIELD:
 
 		/*
+		 * These types open a new scope, so we need the NS node in order to access
+		 * any children.
+		 */
+	case ACPI_TYPE_DEVICE:
+	case ACPI_TYPE_POWER:
+	case ACPI_TYPE_PROCESSOR:
+	case ACPI_TYPE_THERMAL:
+	case ACPI_TYPE_LOCAL_SCOPE:
+
+		/*
 		 * The new alias has the type ALIAS and points to the original
-		 * NS node, not the object itself.  This is because for these
-		 * types, the object can change dynamically via a Store.
+		 * NS node, not the object itself.
 		 */
 		alias_node->type = ACPI_TYPE_LOCAL_ALIAS;
 		alias_node->object =
@@ -115,9 +127,7 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	case ACPI_TYPE_METHOD:
 
 		/*
-		 * The new alias has the type ALIAS and points to the original
-		 * NS node, not the object itself.  This is because for these
-		 * types, the object can change dynamically via a Store.
+		 * Control method aliases need to be differentiated
 		 */
 		alias_node->type = ACPI_TYPE_LOCAL_METHOD_ALIAS;
 		alias_node->object =
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index 32a0167..54852fb 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -581,44 +581,68 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			return_ACPI_STATUS(status);
 		}
 
-		/*
-		 * Sanity typecheck of the target object:
-		 *
-		 * If 1) This is the last segment (num_segments == 0)
-		 *    2) And we are looking for a specific type
-		 *       (Not checking for TYPE_ANY)
-		 *    3) Which is not an alias
-		 *    4) Which is not a local type (TYPE_SCOPE)
-		 *    5) And the type of target object is known (not TYPE_ANY)
-		 *    6) And target object does not match what we are looking for
-		 *
-		 * Then we have a type mismatch.  Just warn and ignore it.
-		 */
-		if ((num_segments == 0) &&
-		    (type_to_check_for != ACPI_TYPE_ANY) &&
-		    (type_to_check_for != ACPI_TYPE_LOCAL_ALIAS) &&
-		    (type_to_check_for != ACPI_TYPE_LOCAL_METHOD_ALIAS) &&
-		    (type_to_check_for != ACPI_TYPE_LOCAL_SCOPE) &&
-		    (this_node->type != ACPI_TYPE_ANY) &&
-		    (this_node->type != type_to_check_for)) {
-
-			/* Complain about a type mismatch */
-
-			ACPI_WARNING((AE_INFO,
-				      "NsLookup: Type mismatch on %4.4s (%s), searching for (%s)",
-				      ACPI_CAST_PTR(char, &simple_name),
-				      acpi_ut_get_type_name(this_node->type),
-				      acpi_ut_get_type_name
-				      (type_to_check_for)));
+		/* More segments to follow? */
+
+		if (num_segments > 0) {
+			/*
+			 * If we have an alias to an object that opens a scope (such as a
+			 * device or processor), we need to dereference the alias here so that
+			 * we can access any children of the original node (via the remaining
+			 * segments).
+			 */
+			if (this_node->type == ACPI_TYPE_LOCAL_ALIAS) {
+				if (acpi_ns_opens_scope
+				    (((struct acpi_namespace_node *)this_node->
+				      object)->type)) {
+					this_node =
+					    (struct acpi_namespace_node *)
+					    this_node->object;
+				}
+			}
 		}
 
-		/*
-		 * If this is the last name segment and we are not looking for a
-		 * specific type, but the type of found object is known, use that type
-		 * to see if it opens a scope.
-		 */
-		if ((num_segments == 0) && (type == ACPI_TYPE_ANY)) {
-			type = this_node->type;
+		/* Special handling for the last segment (num_segments == 0) */
+
+		else {
+			/*
+			 * Sanity typecheck of the target object:
+			 *
+			 * If 1) This is the last segment (num_segments == 0)
+			 *    2) And we are looking for a specific type
+			 *       (Not checking for TYPE_ANY)
+			 *    3) Which is not an alias
+			 *    4) Which is not a local type (TYPE_SCOPE)
+			 *    5) And the type of target object is known (not TYPE_ANY)
+			 *    6) And target object does not match what we are looking for
+			 *
+			 * Then we have a type mismatch. Just warn and ignore it.
+			 */
+			if ((type_to_check_for != ACPI_TYPE_ANY) &&
+			    (type_to_check_for != ACPI_TYPE_LOCAL_ALIAS) &&
+			    (type_to_check_for != ACPI_TYPE_LOCAL_METHOD_ALIAS)
+			    && (type_to_check_for != ACPI_TYPE_LOCAL_SCOPE)
+			    && (this_node->type != ACPI_TYPE_ANY)
+			    && (this_node->type != type_to_check_for)) {
+
+				/* Complain about a type mismatch */
+
+				ACPI_WARNING((AE_INFO,
+					      "NsLookup: Type mismatch on %4.4s (%s), searching for (%s)",
+					      ACPI_CAST_PTR(char, &simple_name),
+					      acpi_ut_get_type_name(this_node->
+								    type),
+					      acpi_ut_get_type_name
+					      (type_to_check_for)));
+			}
+
+			/*
+			 * If this is the last name segment and we are not looking for a
+			 * specific type, but the type of found object is known, use that type
+			 * to (later) see if it opens a scope.
+			 */
+			if (type == ACPI_TYPE_ANY) {
+				type = this_node->type;
+			}
 		}
 
 		/* Point to next name segment and make this node current */
-- 
1.5.5.29.g7134

