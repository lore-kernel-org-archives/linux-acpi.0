From: Len Brown <lenb@kernel.org>
Subject: [PATCH 95/140] ACPICA: Update comments
Date: Wed,  7 Feb 2007 13:51:49 -0500
Message-ID: <11708745092323-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <3effba32069514e56bcb778f90cd34fdbac79a50.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:37868 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422836AbXBGSzN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:13 -0500
In-Reply-To: <11708745084156-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nswalk.c |   46 +++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/namespace/nswalk.c b/drivers/acpi/namespace/nswalk.c
index a138fcb..c6619d8 100644
--- a/drivers/acpi/namespace/nswalk.c
+++ b/drivers/acpi/namespace/nswalk.c
@@ -193,21 +193,28 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		    acpi_ns_get_next_node(ACPI_TYPE_ANY, parent_node,
 					  child_node);
 		if (child_node) {
-			/*
-			 * Found node, Get the type if we are not
-			 * searching for ANY
-			 */
+
+			/* Found node, Get the type if we are not searching for ANY */
+
 			if (type != ACPI_TYPE_ANY) {
 				child_type = child_node->type;
 			}
 
+			/*
+			 * 1) Type must match
+			 * 2) Permanent namespace nodes are OK
+			 * 3) Ignore temporary nodes unless told otherwise. Typically,
+			 *    the temporary nodes can cause a race condition where they can
+			 *    be deleted during the execution of the user function. Only the
+			 *    debugger namespace dump will examine the temporary nodes.
+			 */
 			if ((child_type == type) &&
 			    (!(child_node->flags & ANOBJ_TEMPORARY) ||
 			     (child_node->flags & ANOBJ_TEMPORARY)
 			     && (flags & ACPI_NS_WALK_TEMP_NODES))) {
 				/*
-				 * Found a matching node, invoke the user
-				 * callback function
+				 * Found a matching node, invoke the user callback function.
+				 * Unlock the namespace if flag is set.
 				 */
 				if (flags & ACPI_NS_WALK_UNLOCK) {
 					mutex_status =
@@ -219,8 +226,9 @@ acpi_ns_walk_namespace(acpi_object_type type,
 					}
 				}
 
-				status = user_function(child_node, level,
-						       context, return_value);
+				status =
+				    user_function(child_node, level, context,
+						  return_value);
 
 				if (flags & ACPI_NS_WALK_UNLOCK) {
 					mutex_status =
@@ -254,20 +262,17 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			}
 
 			/*
-			 * Depth first search:
-			 * Attempt to go down another level in the namespace
-			 * if we are allowed to.  Don't go any further if we
-			 * have reached the caller specified maximum depth
-			 * or if the user function has specified that the
-			 * maximum depth has been reached.
+			 * Depth first search: Attempt to go down another level in the
+			 * namespace if we are allowed to.  Don't go any further if we have
+			 * reached the caller specified maximum depth or if the user
+			 * function has specified that the maximum depth has been reached.
 			 */
 			if ((level < max_depth) && (status != AE_CTRL_DEPTH)) {
 				if (acpi_ns_get_next_node
 				    (ACPI_TYPE_ANY, child_node, NULL)) {
-					/*
-					 * There is at least one child of this
-					 * node, visit the onde
-					 */
+
+					/* There is at least one child of this node, visit it */
+
 					level++;
 					parent_node = child_node;
 					child_node = NULL;
@@ -275,9 +280,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			}
 		} else {
 			/*
-			 * No more children of this node (acpi_ns_get_next_node
-			 * failed), go back upwards in the namespace tree to
-			 * the node's parent.
+			 * No more children of this node (acpi_ns_get_next_node failed), go
+			 * back upwards in the namespace tree to the node's parent.
 			 */
 			level--;
 			child_node = parent_node;
-- 
1.5.0.rc3.39.gec804
