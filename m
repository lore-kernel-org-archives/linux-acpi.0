From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/14] ACPICA: Add post-order callback to acpi_walk_namespace
Date: Wed, 09 Dec 2009 12:22:09 -0500
Message-ID: <2263576cfc6e8f6ab038126c3254404b9fcb1c33.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:48335 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbZLIRWh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:37 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00I9DAXBRC96@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:37 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

The existing interface only has a pre-order callback. This change
adds an additional parameter for a post-order callback which will
be more useful for bus scans. ACPICA BZ 779.

Also update the external calls to acpi_walk_namespace.

http://www.acpica.org/bugzilla/show_bug.cgi?id=779

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c     |    2 +-
 arch/x86/kernel/cpu/cpufreq/longhaul.c |    2 +-
 drivers/acpi/acpi_memhotplug.c         |    4 +-
 drivers/acpi/acpica/acnamesp.h         |    3 +-
 drivers/acpi/acpica/dsinit.c           |    2 +-
 drivers/acpi/acpica/evgpeblk.c         |    8 +-
 drivers/acpi/acpica/evregion.c         |    6 +-
 drivers/acpi/acpica/nsdump.c           |    4 +-
 drivers/acpi/acpica/nsdumpdv.c         |    3 +-
 drivers/acpi/acpica/nsinit.c           |    8 +-
 drivers/acpi/acpica/nswalk.c           |  200 +++++++++++++++++++-------------
 drivers/acpi/acpica/nsxfeval.c         |   32 +++--
 drivers/acpi/container.c               |    4 +-
 drivers/acpi/dock.c                    |    8 +-
 drivers/acpi/ec.c                      |    2 +-
 drivers/acpi/glue.c                    |    2 +-
 drivers/acpi/pci_slot.c                |    8 +-
 drivers/acpi/processor_core.c          |    4 +-
 drivers/acpi/scan.c                    |    2 +-
 drivers/acpi/video_detect.c            |    6 +-
 drivers/gpu/drm/i915/intel_lvds.c      |    2 +-
 drivers/i2c/busses/i2c-scmi.c          |    2 +-
 drivers/pci/hotplug/acpi_pcihp.c       |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c     |   22 ++--
 drivers/pci/hotplug/acpiphp_ibm.c      |    2 +-
 drivers/platform/x86/intel_menlow.c    |    2 +-
 drivers/platform/x86/sony-laptop.c     |    2 +-
 drivers/platform/x86/thinkpad_acpi.c   |    2 +-
 include/acpi/acpixf.h                  |    3 +-
 29 files changed, 197 insertions(+), 152 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index fd50ff9..66f633b 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -390,7 +390,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
 	pcidev_match.handle = NULL;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, rootbus_handle, ACPI_UINT32_MAX,
-			    find_matching_device, &pcidev_match, NULL);
+			    find_matching_device, NULL, &pcidev_match, NULL);
 
 	if (!pcidev_match.handle) {
 		printk(KERN_ERR
diff --git a/arch/x86/kernel/cpu/cpufreq/longhaul.c b/arch/x86/kernel/cpu/cpufreq/longhaul.c
index cabd2fa..7e7eea4 100644
--- a/arch/x86/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/x86/kernel/cpu/cpufreq/longhaul.c
@@ -885,7 +885,7 @@ static int __init longhaul_cpu_init(struct cpufreq_policy *policy)
 
 	/* Find ACPI data for processor */
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-				ACPI_UINT32_MAX, &longhaul_walk_callback,
+				ACPI_UINT32_MAX, &longhaul_walk_callback, NULL,
 				NULL, (void *)&pr);
 
 	/* Check ACPI support for C3 state */
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 28ccdbc..3597d73 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -537,7 +537,7 @@ static int __init acpi_memory_device_init(void)
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     acpi_memory_register_notify_handler,
+				     acpi_memory_register_notify_handler, NULL,
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status)) {
@@ -561,7 +561,7 @@ static void __exit acpi_memory_device_exit(void)
 	 */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     acpi_memory_deregister_notify_handler,
+				     acpi_memory_deregister_notify_handler, NULL,
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status))
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 09a2764..168e608 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -104,7 +104,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_object,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback user_function,
+		       acpi_walk_callback pre_order_visit,
+		       acpi_walk_callback post_order_visit,
 		       void *context, void **return_value);
 
 struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 3aae13f..f23fa0b 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -192,7 +192,7 @@ acpi_ds_initialize_objects(u32 table_index,
 	status =
 	    acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
 				   ACPI_NS_WALK_UNLOCK, acpi_ds_init_one_object,
-				   &info, NULL);
+				   NULL, &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index a60aaa7..2479209 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -945,8 +945,8 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ev_save_method_info, gpe_block,
-					NULL);
+					acpi_ev_save_method_info, NULL,
+					gpe_block, NULL);
 
 	/* Return the new block */
 
@@ -1022,8 +1022,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 		status =
 		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					   acpi_ev_match_prw_and_gpe, &gpe_info,
-					   NULL);
+					   acpi_ev_match_prw_and_gpe, NULL,
+					   &gpe_info, NULL);
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index c9fa040..582b0af 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -1025,8 +1025,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK,
-					acpi_ev_install_handler, handler_obj,
-					NULL);
+					acpi_ev_install_handler, NULL,
+					handler_obj, NULL);
 
       unlock_and_exit:
 	return_ACPI_STATUS(status);
@@ -1062,7 +1062,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
-					&space_id, NULL);
+					NULL, &space_id, NULL);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2bad613..2deb986 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -634,8 +634,8 @@ acpi_ns_dump_objects(acpi_object_type type,
 	(void)acpi_ns_walk_namespace(type, start_handle, max_depth,
 				     ACPI_NS_WALK_NO_UNLOCK |
 				     ACPI_NS_WALK_TEMP_NODES,
-				     acpi_ns_dump_one_object, (void *)&info,
-				     NULL);
+				     acpi_ns_dump_one_object, NULL,
+				     (void *)&info, NULL);
 }
 #endif				/* ACPI_FUTURE_USAGE */
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 0fe87f1..36be7f0 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -131,7 +131,8 @@ void acpi_ns_dump_root_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, sys_bus_handle,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ns_dump_one_device, NULL, NULL);
+					acpi_ns_dump_one_device, NULL, NULL,
+					NULL);
 }
 
 #endif
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 1d5b360..4f8abac 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -96,7 +96,7 @@ acpi_status acpi_ns_initialize_objects(void)
 	/* Walk entire namespace from the supplied root */
 
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX, acpi_ns_init_one_object,
+				     ACPI_UINT32_MAX, acpi_ns_init_one_object, NULL,
 				     &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
@@ -156,7 +156,8 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_find_ini_methods, &info, NULL);
+					acpi_ns_find_ini_methods, NULL, &info,
+					NULL);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
 	}
@@ -189,7 +190,8 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_init_one_device, &info, NULL);
+					acpi_ns_init_one_device, NULL, &info,
+					NULL);
 
 	ACPI_FREE(info.evaluate_info);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 35539df..d7e6b52 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -165,24 +165,27 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
  *              max_depth           - Depth to which search is to reach
  *              Flags               - Whether to unlock the NS before invoking
  *                                    the callback routine
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
- *              return_value        - from the user_function if terminated early.
- *                                    Otherwise, returns NULL.
+ *              pre_order_visit     - Called during tree pre-order visit
+ *                                    when an object of "Type" is found
+ *              post_order_visit    - Called during tree post-order visit
+ *                                    when an object of "Type" is found
+ *              Context             - Passed to user function(s) above
+ *              return_value        - from the user_function if terminated
+ *                                    early. Otherwise, returns NULL.
  * RETURNS:     Status
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the node specified by start_handle.
- *              The user_function is called whenever a node that matches
- *              the type parameter is found.  If the user function returns
+ *              The callback function is called whenever a node that matches
+ *              the type parameter is found. If the callback function returns
  *              a non-zero value, the search is terminated immediately and
  *              this value is returned to the caller.
  *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
- *              provide multiple services;  the User Function can be tailored
- *              to each task, whether it is a print function, a compare
- *              function, etc.
+ *              provide multiple services; the callback function(s) can be
+ *              tailored to each task, whether it is a print function,
+ *              a compare function, etc.
  *
  ******************************************************************************/
 
@@ -191,7 +194,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_node,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback user_function,
+		       acpi_walk_callback pre_order_visit,
+		       acpi_walk_callback post_order_visit,
 		       void *context, void **return_value)
 {
 	acpi_status status;
@@ -200,6 +204,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	struct acpi_namespace_node *parent_node;
 	acpi_object_type child_type;
 	u32 level;
+	u8 node_previously_visited = FALSE;
 
 	ACPI_FUNCTION_TRACE(ns_walk_namespace);
 
@@ -212,7 +217,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	/* Null child means "get first node" */
 
 	parent_node = start_node;
-	child_node = NULL;
+	child_node = acpi_ns_get_next_node(parent_node, NULL);
 	child_type = ACPI_TYPE_ANY;
 	level = 1;
 
@@ -221,102 +226,129 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	 * started. When Level is zero, the loop is done because we have
 	 * bubbled up to (and passed) the original parent handle (start_entry)
 	 */
-	while (level > 0) {
+	while (level > 0 && child_node) {
+		status = AE_OK;
 
-		/* Get the next node in this scope.  Null if not found */
+		/* Found next child, get the type if we are not searching for ANY */
 
-		status = AE_OK;
-		child_node = acpi_ns_get_next_node(parent_node, child_node);
-		if (child_node) {
+		if (type != ACPI_TYPE_ANY) {
+			child_type = child_node->type;
+		}
 
-			/* Found next child, get the type if we are not searching for ANY */
+		/*
+		 * Ignore all temporary namespace nodes (created during control
+		 * method execution) unless told otherwise. These temporary nodes
+		 * can cause a race condition because they can be deleted during
+		 * the execution of the user function (if the namespace is
+		 * unlocked before invocation of the user function.) Only the
+		 * debugger namespace dump will examine the temporary nodes.
+		 */
+		if ((child_node->flags & ANOBJ_TEMPORARY) &&
+		    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
+			status = AE_CTRL_DEPTH;
+		}
 
-			if (type != ACPI_TYPE_ANY) {
-				child_type = child_node->type;
-			}
+		/* Type must match requested type */
 
+		else if (child_type == type) {
 			/*
-			 * Ignore all temporary namespace nodes (created during control
-			 * method execution) unless told otherwise. These temporary nodes
-			 * can cause a race condition because they can be deleted during
-			 * the execution of the user function (if the namespace is
-			 * unlocked before invocation of the user function.) Only the
-			 * debugger namespace dump will examine the temporary nodes.
+			 * Found a matching node, invoke the user callback function.
+			 * Unlock the namespace if flag is set.
 			 */
-			if ((child_node->flags & ANOBJ_TEMPORARY) &&
-			    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
-				status = AE_CTRL_DEPTH;
+			if (flags & ACPI_NS_WALK_UNLOCK) {
+				mutex_status =
+				    acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+				if (ACPI_FAILURE(mutex_status)) {
+					return_ACPI_STATUS(mutex_status);
+				}
 			}
 
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
+			/*
+			 * Invoke the user function, either pre-order or post-order
+			 * or both.
+			 */
+			if (!node_previously_visited) {
+				if (pre_order_visit) {
+					status =
+					    pre_order_visit(child_node, level,
+							    context,
+							    return_value);
 				}
+			} else {
+				if (post_order_visit) {
+					status =
+					    post_order_visit(child_node, level,
+							     context,
+							     return_value);
+				}
+			}
 
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
+			if (flags & ACPI_NS_WALK_UNLOCK) {
+				mutex_status =
+				    acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+				if (ACPI_FAILURE(mutex_status)) {
+					return_ACPI_STATUS(mutex_status);
 				}
+			}
 
-				switch (status) {
-				case AE_OK:
-				case AE_CTRL_DEPTH:
+			switch (status) {
+			case AE_OK:
+			case AE_CTRL_DEPTH:
 
-					/* Just keep going */
-					break;
+				/* Just keep going */
+				break;
 
-				case AE_CTRL_TERMINATE:
+			case AE_CTRL_TERMINATE:
 
-					/* Exit now, with OK status */
+				/* Exit now, with OK status */
 
-					return_ACPI_STATUS(AE_OK);
+				return_ACPI_STATUS(AE_OK);
 
-				default:
+			default:
 
-					/* All others are valid exceptions */
+				/* All others are valid exceptions */
 
-					return_ACPI_STATUS(status);
-				}
+				return_ACPI_STATUS(status);
+			}
+		}
+
+		/*
+		 * Depth first search: Attempt to go down another level in the
+		 * namespace if we are allowed to.  Don't go any further if we have
+		 * reached the caller specified maximum depth or if the user
+		 * function has specified that the maximum depth has been reached.
+		 */
+		if (!node_previously_visited &&
+		    (level < max_depth) && (status != AE_CTRL_DEPTH)) {
+			if (child_node->child) {
+
+				/* There is at least one child of this node, visit it */
+
+				level++;
+				parent_node = child_node;
+				child_node =
+				    acpi_ns_get_next_node(parent_node, NULL);
+				continue;
 			}
+		}
 
-			/*
-			 * Depth first search: Attempt to go down another level in the
-			 * namespace if we are allowed to.  Don't go any further if we have
-			 * reached the caller specified maximum depth or if the user
-			 * function has specified that the maximum depth has been reached.
-			 */
-			if ((level < max_depth) && (status != AE_CTRL_DEPTH)) {
-				if (child_node->child) {
+		/* No more children, re-visit this node */
 
-					/* There is at least one child of this node, visit it */
+		if (!node_previously_visited) {
+			node_previously_visited = TRUE;
+			continue;
+		}
 
-					level++;
-					parent_node = child_node;
-					child_node = NULL;
-				}
-			}
-		} else {
+		/* No more children, visit peers */
+
+		child_node = acpi_ns_get_next_node(parent_node, child_node);
+		if (child_node) {
+			node_previously_visited = FALSE;
+		}
+
+		/* No peers, re-visit parent */
+
+		else {
 			/*
 			 * No more children of this node (acpi_ns_get_next_node failed), go
 			 * back upwards in the namespace tree to the node's parent.
@@ -324,6 +356,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			level--;
 			child_node = parent_node;
 			parent_node = acpi_ns_get_parent_node(parent_node);
+
+			node_previously_visited = TRUE;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 4929dbd..f2bd1da 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -433,8 +433,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  * PARAMETERS:  Type                - acpi_object_type to search for
  *              start_object        - Handle in namespace where search begins
  *              max_depth           - Depth to which search is to reach
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
+ *              pre_order_visit     - Called during tree pre-order visit
+ *                                    when an object of "Type" is found
+ *              post_order_visit    - Called during tree post-order visit
+ *                                    when an object of "Type" is found
+ *              Context             - Passed to user function(s) above
  *              return_value        - Location where return value of
  *                                    user_function is put if terminated early
  *
@@ -443,16 +446,16 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the object specified by start_handle.
- *              The user_function is called whenever an object that matches
- *              the type parameter is found.  If the user function returns
+ *              The callback function is called whenever an object that matches
+ *              the type parameter is found. If the callback function returns
  *              a non-zero value, the search is terminated immediately and this
  *              value is returned to the caller.
  *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
- *              provide multiple services;  the User Function can be tailored
- *              to each task, whether it is a print function, a compare
- *              function, etc.
+ *              provide multiple services; the callback function(s) can be
+ *              tailored to each task, whether it is a print function,
+ *              a compare function, etc.
  *
  ******************************************************************************/
 
@@ -460,7 +463,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback user_function,
+		    acpi_walk_callback pre_order_visit,
+		    acpi_walk_callback post_order_visit,
 		    void *context, void **return_value)
 {
 	acpi_status status;
@@ -469,7 +473,8 @@ acpi_walk_namespace(acpi_object_type type,
 
 	/* Parameter validation */
 
-	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) || (!user_function)) {
+	if ((type > ACPI_TYPE_LOCAL_MAX) ||
+	    (!max_depth) || (!pre_order_visit && !post_order_visit)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -501,8 +506,9 @@ acpi_walk_namespace(acpi_object_type type,
 	}
 
 	status = acpi_ns_walk_namespace(type, start_object, max_depth,
-					ACPI_NS_WALK_UNLOCK, user_function,
-					context, return_value);
+					ACPI_NS_WALK_UNLOCK, pre_order_visit,
+					post_order_visit, context,
+					return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
@@ -681,8 +687,8 @@ acpi_get_devices(const char *HID,
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					acpi_ns_get_device_callback, &info,
-					return_value);
+					acpi_ns_get_device_callback, NULL,
+					&info, return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 642bb30..5faf6c2 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -258,7 +258,7 @@ static int __init acpi_container_init(void)
 	acpi_walk_namespace(ACPI_TYPE_DEVICE,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    container_walk_namespace_cb, &action, NULL);
+			    container_walk_namespace_cb, NULL, &action, NULL);
 
 	return (0);
 }
@@ -271,7 +271,7 @@ static void __exit acpi_container_exit(void)
 	acpi_walk_namespace(ACPI_TYPE_DEVICE,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    container_walk_namespace_cb, &action, NULL);
+			    container_walk_namespace_cb, NULL, &action, NULL);
 
 	acpi_bus_unregister_driver(&acpi_container_driver);
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7338b6a..30be3c1 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -1030,8 +1030,8 @@ static int dock_add(acpi_handle handle)
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock_devices, dock_station,
-			    NULL);
+			    ACPI_UINT32_MAX, find_dock_devices, NULL,
+			    dock_station, NULL);
 
 	/* add the dock station as a device dependent on itself */
 	dd = alloc_dock_dependent_device(handle);
@@ -1127,11 +1127,11 @@ static int __init dock_init(void)
 
 	/* look for a dock station */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock, NULL, NULL);
+			    ACPI_UINT32_MAX, find_dock, NULL, NULL, NULL);
 
 	/* look for bay */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_bay, NULL, NULL);
+			ACPI_UINT32_MAX, find_bay, NULL, NULL, NULL);
 	if (!dock_station_count) {
 		printk(KERN_INFO PREFIX "No dock devices found.\n");
 		return 0;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index baef28c..75b147f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -820,7 +820,7 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
-			    acpi_ec_register_query_methods, ec, NULL);
+			    acpi_ec_register_query_methods, NULL, ec, NULL);
 
 	if (!first_ec)
 		first_ec = ec;
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index c6645f2..4c8fcff 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -113,7 +113,7 @@ acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address)
 	if (!parent)
 		return NULL;
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, parent,
-			    1, do_acpi_find_child, &find, NULL);
+			    1, do_acpi_find_child, NULL, &find, NULL);
 	return find.handle;
 }
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 45da2ba..11f2197 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -219,12 +219,12 @@ walk_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	dbg("p2p bridge walk, pci_bus = %x\n", dev->subordinate->number);
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     user_function, &child_context, NULL);
+				     user_function, NULL, &child_context, NULL);
 	if (ACPI_FAILURE(status))
 		goto out;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     walk_p2p_bridge, &child_context, NULL);
+				     walk_p2p_bridge, NULL, &child_context, NULL);
 out:
 	pci_dev_put(dev);
 	return AE_OK;
@@ -277,12 +277,12 @@ walk_root_bridge(acpi_handle handle, acpi_walk_callback user_function)
 
 	dbg("root bridge walk, pci_bus = %x\n", pci_bus->number);
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     user_function, &context, NULL);
+				     user_function, NULL, &context, NULL);
 	if (ACPI_FAILURE(status))
 		return status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     walk_p2p_bridge, &context, NULL);
+				     walk_p2p_bridge, NULL, &context, NULL);
 	if (ACPI_FAILURE(status))
 		err("%s: walk_p2p_bridge failure - %d\n", __func__, status);
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ec742a4..cb4283f 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -1102,7 +1102,7 @@ void acpi_processor_install_hotplug_notify(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    processor_walk_namespace_cb, &action, NULL);
+			    processor_walk_namespace_cb, NULL, &action, NULL);
 #endif
 	register_hotcpu_notifier(&acpi_cpu_notifier);
 }
@@ -1115,7 +1115,7 @@ void acpi_processor_uninstall_hotplug_notify(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    processor_walk_namespace_cb, &action, NULL);
+			    processor_walk_namespace_cb, NULL, &action, NULL);
 #endif
 	unregister_hotcpu_notifier(&acpi_cpu_notifier);
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 14a7481..ff9f622 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1332,7 +1332,7 @@ static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops,
 	status = acpi_bus_check_add(handle, 0, ops, &device);
 	if (ACPI_SUCCESS(status))
 		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add, ops, &device);
+				    acpi_bus_check_add, NULL, ops, &device);
 
 	if (child)
 		*child = device;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 575593a..8c1b431 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -101,7 +101,7 @@ long acpi_is_video_device(struct acpi_device *device)
 	/* Only check for backlight functionality if one of the above hit. */
 	if (video_caps)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
-				    ACPI_UINT32_MAX, acpi_backlight_cap_match,
+				    ACPI_UINT32_MAX, acpi_backlight_cap_match, NULL,
 				    &video_caps, NULL);
 
 	return video_caps;
@@ -151,7 +151,7 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 	if (!graphics_handle) {
 		/* Only do the global walk through all graphics devices once */
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				    ACPI_UINT32_MAX, find_video,
+				    ACPI_UINT32_MAX, find_video, NULL,
 				    &caps, NULL);
 		/* There might be boot param flags set already... */
 		acpi_video_support |= caps;
@@ -173,7 +173,7 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 			return 0;
 		}
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, graphics_handle,
-				    ACPI_UINT32_MAX, find_video,
+				    ACPI_UINT32_MAX, find_video, NULL,
 				    &caps, NULL);
 	}
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "We have 0x%lX video support %s %s\n",
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 05598ae..eb36502 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -899,7 +899,7 @@ static int intel_lid_present(void)
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				ACPI_UINT32_MAX,
-				check_lid_device, &lid_present, NULL);
+				check_lid_device, NULL, &lid_present, NULL);
 
 	return lid_present;
 }
diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index b4a55d4..365e0be 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -363,7 +363,7 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 	smbus_cmi->cap_write = 0;
 
 	acpi_walk_namespace(ACPI_TYPE_METHOD, smbus_cmi->handle, 1,
-			    acpi_smbus_cmi_query_methods, smbus_cmi, NULL);
+			    acpi_smbus_cmi_query_methods, NULL, smbus_cmi, NULL);
 
 	if (smbus_cmi->cap_info == 0)
 		goto err;
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index a73028e..0f32571 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -471,7 +471,7 @@ int acpi_pci_detect_ejectable(acpi_handle handle)
 		return found;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
-			    check_hotplug, (void *)&found, NULL);
+			    check_hotplug, NULL, (void *)&found, NULL);
 	return found;
 }
 EXPORT_SYMBOL_GPL(acpi_pci_detect_ejectable);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 58d25a1..df1b0ea 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -266,7 +266,7 @@ static int detect_ejectable_slots(acpi_handle handle)
 	int found = acpi_pci_detect_ejectable(handle);
 	if (!found) {
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				    is_pci_dock_device, (void *)&found, NULL);
+				    is_pci_dock_device, NULL, (void *)&found, NULL);
 	}
 	return found;
 }
@@ -281,7 +281,7 @@ static void init_bridge_misc(struct acpiphp_bridge *bridge)
 
 	/* register all slot objects under this bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge->handle, (u32)1,
-				     register_slot, bridge, NULL);
+				     register_slot, NULL, bridge, NULL);
 	if (ACPI_FAILURE(status)) {
 		list_del(&bridge->list);
 		return;
@@ -447,7 +447,7 @@ find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	/* search P2P bridges under this p2p bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, NULL, NULL);
+				     find_p2p_bridge, NULL, NULL, NULL);
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge failed (error code = 0x%x)\n", status);
 
@@ -485,7 +485,7 @@ static int add_bridge(acpi_handle handle)
 
 	/* search P2P bridges under this host bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, NULL, NULL);
+				     find_p2p_bridge, NULL, NULL, NULL);
 
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge failed (error code = 0x%x)\n", status);
@@ -573,7 +573,7 @@ cleanup_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 	/* cleanup p2p bridges under this P2P bridge
 	   in a depth-first manner */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				cleanup_p2p_bridge, NULL, NULL);
+				cleanup_p2p_bridge, NULL, NULL, NULL);
 
 	bridge = acpiphp_handle_to_bridge(handle);
 	if (bridge)
@@ -589,7 +589,7 @@ static void remove_bridge(acpi_handle handle)
 	/* cleanup p2p bridges under this host bridge
 	   in a depth-first manner */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				(u32)1, cleanup_p2p_bridge, NULL, NULL);
+				(u32)1, cleanup_p2p_bridge, NULL, NULL, NULL);
 
 	/*
 	 * On root bridges with hotplug slots directly underneath (ie,
@@ -778,7 +778,7 @@ static int acpiphp_configure_ioapics(acpi_handle handle)
 {
 	ioapic_add(handle, 0, NULL, NULL);
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL);
+			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -786,7 +786,7 @@ static int acpiphp_unconfigure_ioapics(acpi_handle handle)
 {
 	ioapic_remove(handle, 0, NULL, NULL);
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_remove, NULL, NULL);
+			    ACPI_UINT32_MAX, ioapic_remove, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -1367,7 +1367,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 	bridge = acpiphp_handle_to_bridge(handle);
 	if (type == ACPI_NOTIFY_BUS_CHECK) {
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
-			count_sub_bridges, &num_sub_bridges, NULL);
+			count_sub_bridges, NULL, &num_sub_bridges, NULL);
 	}
 
 	if (!bridge && !num_sub_bridges) {
@@ -1388,7 +1388,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 		}
 		if (num_sub_bridges)
 			acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL);
+				ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL, NULL);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -1512,7 +1512,7 @@ int __init acpiphp_glue_init(void)
 	int num = 0;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_root_bridges, &num, NULL);
+			ACPI_UINT32_MAX, find_root_bridges, NULL, &num, NULL);
 
 	if (num <= 0)
 		return -1;
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index e7be66d..aa5df48 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -434,7 +434,7 @@ static int __init ibm_acpiphp_init(void)
 	dbg("%s\n", __func__);
 
 	if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, ibm_find_acpi_device,
+			ACPI_UINT32_MAX, ibm_find_acpi_device, NULL,
 			&ibm_acpi_handle, NULL) != FOUND_APCI) {
 		err("%s: acpi_walk_namespace failed\n", __func__);
 		retval = -ENODEV;
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index 29432a5..f0a90a6 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -510,7 +510,7 @@ static int __init intel_menlow_module_init(void)
 	/* Looking for sensors in each ACPI thermal zone */
 	status = acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     intel_menlow_register_sensor, NULL, NULL);
+				     intel_menlow_register_sensor, NULL, NULL, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a2a742c..7a2cc8a 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1203,7 +1203,7 @@ static int sony_nc_add(struct acpi_device *device)
 
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_nc_acpi_handle,
-					     1, sony_walk_callback, NULL, NULL);
+					     1, sony_walk_callback, NULL, NULL, NULL);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_WARNING DRV_PFX "unable to walk acpi resources\n");
 			result = -ENODEV;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d93108d..22cb50f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1087,7 +1087,7 @@ static int __init tpacpi_check_std_acpi_brightness_support(void)
 	 */
 
 	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
-				     tpacpi_acpi_walk_find_bcl, NULL,
+				     tpacpi_acpi_walk_find_bcl, NULL, NULL,
 				     &bcl_ptr);
 
 	if (ACPI_SUCCESS(status) && bcl_levels > 2) {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0e7efea..f9b8b28 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -154,7 +154,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback user_function,
+		    acpi_walk_callback pre_order_visit,
+		    acpi_walk_callback post_order_visit,
 		    void *context, void **return_value);
 
 acpi_status
-- 
1.6.0.6

