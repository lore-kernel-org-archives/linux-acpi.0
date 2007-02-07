From: Len Brown <lenb@kernel.org>
Subject: [PATCH 92/140] ACPICA: Fix race condition with AcpiWalkNamespace.
Date: Wed,  7 Feb 2007 13:51:46 -0500
Message-ID: <11708745063772-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <d1fdda83f7c567f376ddd4305833de09f7919ca9.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422796AbXBGSzL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:11 -0500
In-Reply-To: <117087450515-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -756,9 +756,9 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
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
@@ -226,6 +226,12 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
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
 
@@ -623,7 +629,8 @@ acpi_ns_dump_objects(acpi_object_type type,
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
@@ -402,6 +402,10 @@ acpi_ns_search_and_enter(u32 target_name,
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
@@ -126,7 +126,7 @@ struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type,
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
@@ -201,12 +201,15 @@ acpi_ns_walk_namespace(acpi_object_type type,
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
@@ -219,7 +222,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
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
1.5.0.rc3.39.gec804
