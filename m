From: Len Brown <len.brown@intel.com>
Subject: [PATCH 51/65] ACPICA: Fix race condition with AcpiWalkNamespace.
Date: Fri, 24 Nov 2006 02:19:01 -0500
Message-ID: <11643528124177-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934477AbWKXHQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:14 -0500
In-Reply-To: <11643528111088-git-send-email-len.brown@intel.com>
Message-Id: <de2576c39bf22ea81e46280dee9a7543176852b1.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Fixed a problem with a possible race condition between threads executing
AcpiWalkNamespace and the AML interpreter. This condition was removed by
modifying AcpiWalkNamespace to (by default) ignore all temporary
namespace entries created during any concurrent control method execution

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dswload.c |    4 ++--
 drivers/acpi/namespace/nsdump.c   |    9 ++++++++-
 drivers/acpi/namespace/nssearch.c |    4 ++++
 drivers/acpi/namespace/nswalk.c   |   13 ++++++++-----
 include/acpi/aclocal.h            |    2 +-
 include/acpi/acnamesp.h           |   10 +++++++---
 6 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/dispatcher/dswload.c
index 565d455..4ed0868 100644
--- a/drivers/acpi/dispatcher/dswload.c
+++ b/drivers/acpi/dispatcher/dswload.c
@@ -756,9 +756,9 @@ acpi_ds_load2_begin_op(struct acpi_walk_
 		flags = ACPI_NS_NO_UPSEARCH;
 		if (walk_state->pass_number == 3) {
 
-			/* Execution mode, node cannot already exist */
+			/* Execution mode, node cannot already exist, node is temporary */
 
-			flags |= ACPI_NS_ERROR_IF_FOUND;
+			flags |= (ACPI_NS_ERROR_IF_FOUND | ACPI_NS_TEMPORARY);
 		}
 
 		/* Add new entry or lookup existing entry */
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index da88834..ec5ce59 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -226,6 +226,12 @@ acpi_ns_dump_one_object(acpi_handle obj_
 	obj_desc = acpi_ns_get_attached_object(this_node);
 	acpi_dbg_level = dbg_level;
 
+	/* Temp nodes are those nodes created by a control method */
+
+	if (this_node->flags & ANOBJ_TEMPORARY) {
+		acpi_os_printf("(T) ");
+	}
+
 	switch (info->display_type & ACPI_DISPLAY_MASK) {
 	case ACPI_DISPLAY_SUMMARY:
 
@@ -623,7 +629,8 @@ acpi_ns_dump_objects(acpi_object_type ty
 	info.display_type = display_type;
 
 	(void)acpi_ns_walk_namespace(type, start_handle, max_depth,
-				     ACPI_NS_WALK_NO_UNLOCK,
+				     ACPI_NS_WALK_NO_UNLOCK |
+				     ACPI_NS_WALK_TEMP_NODES,
 				     acpi_ns_dump_one_object, (void *)&info,
 				     NULL);
 }
diff --git a/drivers/acpi/namespace/nssearch.c b/drivers/acpi/namespace/nssearch.c
index 566f0a4..d261c9b 100644
--- a/drivers/acpi/namespace/nssearch.c
+++ b/drivers/acpi/namespace/nssearch.c
@@ -402,6 +402,10 @@ acpi_ns_search_and_enter(u32 target_name
 	}
 #endif
 
+	if (flags & ACPI_NS_TEMPORARY) {
+		new_node->flags |= ANOBJ_TEMPORARY;
+	}
+
 	/* Install the new object into the parent's list of children */
 
 	acpi_ns_install_node(walk_state, node, new_node, type);
diff --git a/drivers/acpi/namespace/nswalk.c b/drivers/acpi/namespace/nswalk.c
index c8f6bef..a138fcb 100644
--- a/drivers/acpi/namespace/nswalk.c
+++ b/drivers/acpi/namespace/nswalk.c
@@ -126,7 +126,7 @@ struct acpi_namespace_node *acpi_ns_get_
  * PARAMETERS:  Type                - acpi_object_type to search for
  *              start_node          - Handle in namespace where search begins
  *              max_depth           - Depth to which search is to reach
- *              unlock_before_callback- Whether to unlock the NS before invoking
+ *              Flags               - Whether to unlock the NS before invoking
  *                                    the callback routine
  *              user_function       - Called when an object of "Type" is found
  *              Context             - Passed to user function
@@ -153,7 +153,7 @@ acpi_status
 acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_node,
 		       u32 max_depth,
-		       u8 unlock_before_callback,
+		       u32 flags,
 		       acpi_walk_callback user_function,
 		       void *context, void **return_value)
 {
@@ -201,12 +201,15 @@ acpi_ns_walk_namespace(acpi_object_type
 				child_type = child_node->type;
 			}
 
-			if (child_type == type) {
+			if ((child_type == type) &&
+			    (!(child_node->flags & ANOBJ_TEMPORARY) ||
+			     (child_node->flags & ANOBJ_TEMPORARY)
+			     && (flags & ACPI_NS_WALK_TEMP_NODES))) {
 				/*
 				 * Found a matching node, invoke the user
 				 * callback function
 				 */
-				if (unlock_before_callback) {
+				if (flags & ACPI_NS_WALK_UNLOCK) {
 					mutex_status =
 					    acpi_ut_release_mutex
 					    (ACPI_MTX_NAMESPACE);
@@ -219,7 +222,7 @@ acpi_ns_walk_namespace(acpi_object_type
 				status = user_function(child_node, level,
 						       context, return_value);
 
-				if (unlock_before_callback) {
+				if (flags & ACPI_NS_WALK_UNLOCK) {
 					mutex_status =
 					    acpi_ut_acquire_mutex
 					    (ACPI_MTX_NAMESPACE);
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 553763d..287da6f 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -204,7 +204,7 @@ struct acpi_namespace_node {
 /* Namespace Node flags */
 
 #define ANOBJ_END_OF_PEER_LIST          0x01	/* End-of-list, Peer field points to parent */
-#define ANOBJ_RESERVED                  0x02	/* Available for future use */
+#define ANOBJ_TEMPORARY                 0x02	/* Node is create by a method and is temporary */
 #define ANOBJ_METHOD_ARG                0x04	/* Node is a method argument */
 #define ANOBJ_METHOD_LOCAL              0x08	/* Node is a method local */
 #define ANOBJ_SUBTREE_HAS_INI           0x10	/* Used to optimize device initialization */
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index b3b9f0e..19a6129 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -65,9 +65,13 @@
 #define ACPI_NS_ERROR_IF_FOUND      0x08
 #define ACPI_NS_PREFIX_IS_SCOPE     0x10
 #define ACPI_NS_EXTERNAL            0x20
+#define ACPI_NS_TEMPORARY           0x40
 
-#define ACPI_NS_WALK_UNLOCK         TRUE
-#define ACPI_NS_WALK_NO_UNLOCK      FALSE
+/* Flags for acpi_ns_walk_namespace */
+
+#define ACPI_NS_WALK_NO_UNLOCK      0
+#define ACPI_NS_WALK_UNLOCK         0x01
+#define ACPI_NS_WALK_TEMP_NODES     0x02
 
 /*
  * nsinit - Namespace initialization
@@ -92,7 +96,7 @@ acpi_status
 acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_object,
 		       u32 max_depth,
-		       u8 unlock_before_callback,
+		       u32 flags,
 		       acpi_walk_callback user_function,
 		       void *context, void **return_value);
 
-- 
1.4.4.1
