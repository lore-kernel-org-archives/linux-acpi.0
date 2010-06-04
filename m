From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/16] ACPICA: Performance enhancement for namespace search and
 access
Date: Fri, 04 Jun 2010 15:51:40 -0400
Message-ID: <516666e120fe1b622fd975db52abe79f597afacc.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab0FHTmT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:19 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:18 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

This change enhances the performance of namespace searches and
walks by adding a backpointer to the parent in each namespace
node. On large namespaces, this change can improve overall ACPI
performance by up to 9X.  Adding a pointer to each namespace node
increases the overall size of the internal namespace by about 5%,
since each namespace entry usually consists of both a namespace
node and an ACPI operand object.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    5 +-
 drivers/acpi/acpica/acnamesp.h |    7 ---
 drivers/acpi/acpica/dsmthdat.c |    6 +--
 drivers/acpi/acpica/dsopcode.c |    6 +-
 drivers/acpi/acpica/evrgnini.c |   10 ++--
 drivers/acpi/acpica/exdump.c   |    2 +-
 drivers/acpi/acpica/nsaccess.c |    5 +-
 drivers/acpi/acpica/nsalloc.c  |   74 +++++++++-----------------
 drivers/acpi/acpica/nsinit.c   |    4 +-
 drivers/acpi/acpica/nsnames.c  |    4 +-
 drivers/acpi/acpica/nssearch.c |   15 +-----
 drivers/acpi/acpica/nsutils.c  |  113 ----------------------------------------
 drivers/acpi/acpica/nswalk.c   |   15 +----
 drivers/acpi/acpica/nsxfobj.c  |    2 +-
 drivers/acpi/acpica/utglobal.c |    2 +-
 15 files changed, 52 insertions(+), 218 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 147a7e6..eb2d420 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -184,8 +184,9 @@ struct acpi_namespace_node {
 	u8 flags;		/* Miscellaneous flags */
 	acpi_owner_id owner_id;	/* Node creator */
 	union acpi_name_union name;	/* ACPI Name, always 4 chars per ACPI spec */
+	struct acpi_namespace_node *parent;	/* Parent node */
 	struct acpi_namespace_node *child;	/* First child */
-	struct acpi_namespace_node *peer;	/* Peer. Parent if ANOBJ_END_OF_PEER_LIST set */
+	struct acpi_namespace_node *peer;	/* First peer */
 
 	/*
 	 * The following fields are used by the ASL compiler and disassembler only
@@ -199,7 +200,7 @@ struct acpi_namespace_node {
 
 /* Namespace Node flags */
 
-#define ANOBJ_END_OF_PEER_LIST          0x01	/* End-of-list, Peer field points to parent */
+#define ANOBJ_RESERVED                  0x01	/* Available for use */
 #define ANOBJ_TEMPORARY                 0x02	/* Node is create by a method and is temporary */
 #define ANOBJ_METHOD_ARG                0x04	/* Node is a method argument */
 #define ANOBJ_METHOD_LOCAL              0x08	/* Node is a method local */
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 258159c..9f60ff0 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -369,11 +369,4 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle);
 
 void acpi_ns_terminate(void);
 
-struct acpi_namespace_node *acpi_ns_get_parent_node(struct acpi_namespace_node
-						    *node);
-
-struct acpi_namespace_node *acpi_ns_get_next_valid_node(struct
-							acpi_namespace_node
-							*node);
-
 #endif				/* __ACNAMESP_H__ */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index d5e927f..8095306 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -102,8 +102,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
 		walk_state->arguments[i].name.integer |= (i << 24);
 		walk_state->arguments[i].descriptor_type = ACPI_DESC_TYPE_NAMED;
 		walk_state->arguments[i].type = ACPI_TYPE_ANY;
-		walk_state->arguments[i].flags =
-		    ANOBJ_END_OF_PEER_LIST | ANOBJ_METHOD_ARG;
+		walk_state->arguments[i].flags = ANOBJ_METHOD_ARG;
 	}
 
 	/* Init the method locals */
@@ -116,8 +115,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
 		walk_state->local_variables[i].descriptor_type =
 		    ACPI_DESC_TYPE_NAMED;
 		walk_state->local_variables[i].type = ACPI_TYPE_ANY;
-		walk_state->local_variables[i].flags =
-		    ANOBJ_END_OF_PEER_LIST | ANOBJ_METHOD_LOCAL;
+		walk_state->local_variables[i].flags = ANOBJ_METHOD_LOCAL;
 	}
 
 	return_VOID;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 53a7e41..7c0e742 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -213,7 +213,7 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the AML code for the term_arg arguments */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	return_ACPI_STATUS(status);
@@ -257,7 +257,7 @@ acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the AML code for the term_arg arguments */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	return_ACPI_STATUS(status);
@@ -394,7 +394,7 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the argument AML */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 2e3b033..f40d271 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -199,7 +199,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 		return_ACPI_STATUS(status);
 	}
 
-	parent_node = acpi_ns_get_parent_node(region_obj->region.node);
+	parent_node = region_obj->region.node->parent;
 
 	/*
 	 * Get the _SEG and _BBN values from the device upon which the handler
@@ -248,7 +248,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 				break;
 			}
 
-			pci_root_node = acpi_ns_get_parent_node(pci_root_node);
+			pci_root_node = pci_root_node->parent;
 		}
 
 		/* PCI root bridge not found, use namespace root node */
@@ -280,7 +280,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	 */
 	pci_device_node = region_obj->region.node;
 	while (pci_device_node && (pci_device_node->type != ACPI_TYPE_DEVICE)) {
-		pci_device_node = acpi_ns_get_parent_node(pci_device_node);
+		pci_device_node = pci_device_node->parent;
 	}
 
 	if (!pci_device_node) {
@@ -521,7 +521,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	node = acpi_ns_get_parent_node(region_obj->region.node);
+	node = region_obj->region.node->parent;
 	space_id = region_obj->region.space_id;
 
 	/* Setup defaults */
@@ -654,7 +654,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 		/* This node does not have the handler we need; Pop up one level */
 
-		node = acpi_ns_get_parent_node(node);
+		node = node->parent;
 	}
 
 	/* If we get here, there is no handler for this region */
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index cdb66d1..f067bbb 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -812,7 +812,7 @@ void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags)
 	acpi_ex_out_string("Type", acpi_ut_get_type_name(node->type));
 	acpi_ex_out_pointer("Attached Object",
 			    acpi_ns_get_attached_object(node));
-	acpi_ex_out_pointer("Parent", acpi_ns_get_parent_node(node));
+	acpi_ex_out_pointer("Parent", node->parent);
 
 	acpi_ex_dump_object(ACPI_CAST_PTR(union acpi_operand_object, node),
 			    acpi_ex_dump_node);
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 2cebfa9..0cd925b 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -338,8 +338,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			 */
 			while (!acpi_ns_opens_scope(prefix_node->type) &&
 			       prefix_node->type != ACPI_TYPE_ANY) {
-				prefix_node =
-				    acpi_ns_get_parent_node(prefix_node);
+				prefix_node = prefix_node->parent;
 			}
 		}
 	}
@@ -419,7 +418,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				/* Backup to the parent node */
 
 				num_carats++;
-				this_node = acpi_ns_get_parent_node(this_node);
+				this_node = this_node->parent;
 				if (!this_node) {
 
 					/* Current scope has no parent scope */
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 982269c..8d3a43a 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -159,7 +159,7 @@ void acpi_ns_remove_node(struct acpi_namespace_node *node)
 
 	ACPI_FUNCTION_TRACE_PTR(ns_remove_node, node);
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 
 	prev_node = NULL;
 	next_node = parent_node->child;
@@ -168,29 +168,20 @@ void acpi_ns_remove_node(struct acpi_namespace_node *node)
 
 	while (next_node != node) {
 		prev_node = next_node;
-		next_node = prev_node->peer;
+		next_node = next_node->peer;
 	}
 
 	if (prev_node) {
 
 		/* Node is not first child, unlink it */
 
-		prev_node->peer = next_node->peer;
-		if (next_node->flags & ANOBJ_END_OF_PEER_LIST) {
-			prev_node->flags |= ANOBJ_END_OF_PEER_LIST;
-		}
+		prev_node->peer = node->peer;
 	} else {
-		/* Node is first child (has no previous peer) */
-
-		if (next_node->flags & ANOBJ_END_OF_PEER_LIST) {
-
-			/* No peers at all */
-
-			parent_node->child = NULL;
-		} else {	/* Link peer list to parent */
-
-			parent_node->child = next_node->peer;
-		}
+		/*
+		 * Node is first child (has no previous peer).
+		 * Link peer list to parent
+		 */
+		parent_node->child = node->peer;
 	}
 
 	/* Delete the node and any attached objects */
@@ -238,23 +229,20 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 	/* Link the new entry into the parent and existing children */
 
+	node->peer = NULL;
+	node->parent = parent_node;
 	child_node = parent_node->child;
+
 	if (!child_node) {
 		parent_node->child = node;
-		node->flags |= ANOBJ_END_OF_PEER_LIST;
-		node->peer = parent_node;
 	} else {
-		while (!(child_node->flags & ANOBJ_END_OF_PEER_LIST)) {
+		/* Add node to the end of the peer list */
+
+		while (child_node->peer) {
 			child_node = child_node->peer;
 		}
 
 		child_node->peer = node;
-
-		/* Clear end-of-list flag */
-
-		child_node->flags &= ~ANOBJ_END_OF_PEER_LIST;
-		node->flags |= ANOBJ_END_OF_PEER_LIST;
-		node->peer = parent_node;
 	}
 
 	/* Init the new entry */
@@ -288,9 +276,8 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 {
-	struct acpi_namespace_node *child_node;
 	struct acpi_namespace_node *next_node;
-	u8 flags;
+	struct acpi_namespace_node *node_to_delete;
 
 	ACPI_FUNCTION_TRACE_PTR(ns_delete_children, parent_node);
 
@@ -298,37 +285,26 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 		return_VOID;
 	}
 
-	/* If no children, all done! */
-
-	child_node = parent_node->child;
-	if (!child_node) {
-		return_VOID;
-	}
-
 	/* Deallocate all children at this level */
 
-	do {
-
-		/* Get the things we need */
-
-		next_node = child_node->peer;
-		flags = child_node->flags;
+	next_node = parent_node->child;
+	while (next_node) {
 
 		/* Grandchildren should have all been deleted already */
 
-		if (child_node->child) {
+		if (next_node->child) {
 			ACPI_ERROR((AE_INFO, "Found a grandchild! P=%p C=%p",
-				    parent_node, child_node));
+				    parent_node, next_node));
 		}
 
 		/*
 		 * Delete this child node and move on to the next child in the list.
 		 * No need to unlink the node since we are deleting the entire branch.
 		 */
-		acpi_ns_delete_node(child_node);
-		child_node = next_node;
-
-	} while (!(flags & ANOBJ_END_OF_PEER_LIST));
+		node_to_delete = next_node;
+		next_node = next_node->peer;
+		acpi_ns_delete_node(node_to_delete);
+	};
 
 	/* Clear the parent's child pointer */
 
@@ -405,7 +381,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 
 			/* Move up the tree to the grandparent */
 
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 	}
 
@@ -510,7 +486,7 @@ void acpi_ns_delete_namespace_by_owner(acpi_owner_id owner_id)
 
 			/* Move up the tree to the grandparent */
 
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index f0e49df..660a272 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -410,7 +410,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 	 * The only _INI methods that we care about are those that are
 	 * present under Device, Processor, and Thermal objects.
 	 */
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 	switch (parent_node->type) {
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_PROCESSOR:
@@ -420,7 +420,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 
 		while (parent_node) {
 			parent_node->flags |= ANOBJ_SUBTREE_HAS_INI;
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 7dea003..d3104af 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -93,7 +93,7 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
 		/* Put the name into the buffer */
 
 		ACPI_MOVE_32_TO_32((name_buffer + index), &parent_node->name);
-		parent_node = acpi_ns_get_parent_node(parent_node);
+		parent_node = parent_node->parent;
 
 		/* Prefix name with the path separator */
 
@@ -198,7 +198,7 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 			return 0;
 		}
 		size += ACPI_PATH_SEGMENT_LENGTH;
-		next_node = acpi_ns_get_parent_node(next_node);
+		next_node = next_node->parent;
 	}
 
 	if (!size) {
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index a8e42b5..41102a8 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -152,17 +152,6 @@ acpi_ns_search_one_scope(u32 target_name,
 			return_ACPI_STATUS(AE_OK);
 		}
 
-		/*
-		 * The last entry in the list points back to the parent,
-		 * so a flag is used to indicate the end-of-list
-		 */
-		if (node->flags & ANOBJ_END_OF_PEER_LIST) {
-
-			/* Searched entire list, we are done */
-
-			break;
-		}
-
 		/* Didn't match name, move on to the next peer object */
 
 		node = node->peer;
@@ -217,7 +206,7 @@ acpi_ns_search_parent_tree(u32 target_name,
 
 	ACPI_FUNCTION_TRACE(ns_search_parent_tree);
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 
 	/*
 	 * If there is no parent (i.e., we are at the root) or type is "local",
@@ -261,7 +250,7 @@ acpi_ns_search_parent_tree(u32 target_name,
 
 		/* Not found here, go up another level (until we reach the root) */
 
-		parent_node = acpi_ns_get_parent_node(parent_node);
+		parent_node = parent_node->parent;
 	}
 
 	/* Not found in parent tree */
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index bab5597..e1add34 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -847,116 +847,3 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_get_parent_node
- *
- * PARAMETERS:  Node       - Current table entry
- *
- * RETURN:      Parent entry of the given entry
- *
- * DESCRIPTION: Obtain the parent entry for a given entry in the namespace.
- *
- ******************************************************************************/
-
-struct acpi_namespace_node *acpi_ns_get_parent_node(struct acpi_namespace_node
-						    *node)
-{
-	ACPI_FUNCTION_ENTRY();
-
-	if (!node) {
-		return (NULL);
-	}
-
-	/*
-	 * Walk to the end of this peer list. The last entry is marked with a flag
-	 * and the peer pointer is really a pointer back to the parent. This saves
-	 * putting a parent back pointer in each and every named object!
-	 */
-	while (!(node->flags & ANOBJ_END_OF_PEER_LIST)) {
-		node = node->peer;
-	}
-
-	return (node->peer);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_get_next_valid_node
- *
- * PARAMETERS:  Node       - Current table entry
- *
- * RETURN:      Next valid Node in the linked node list. NULL if no more valid
- *              nodes.
- *
- * DESCRIPTION: Find the next valid node within a name table.
- *              Useful for implementing NULL-end-of-list loops.
- *
- ******************************************************************************/
-
-struct acpi_namespace_node *acpi_ns_get_next_valid_node(struct
-							acpi_namespace_node
-							*node)
-{
-
-	/* If we are at the end of this peer list, return NULL */
-
-	if (node->flags & ANOBJ_END_OF_PEER_LIST) {
-		return NULL;
-	}
-
-	/* Otherwise just return the next peer */
-
-	return (node->peer);
-}
-
-#ifdef ACPI_OBSOLETE_FUNCTIONS
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_find_parent_name
- *
- * PARAMETERS:  *child_node            - Named Obj whose name is to be found
- *
- * RETURN:      The ACPI name
- *
- * DESCRIPTION: Search for the given obj in its parent scope and return the
- *              name segment, or "????" if the parent name can't be found
- *              (which "should not happen").
- *
- ******************************************************************************/
-
-acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node * child_node)
-{
-	struct acpi_namespace_node *parent_node;
-
-	ACPI_FUNCTION_TRACE(ns_find_parent_name);
-
-	if (child_node) {
-
-		/* Valid entry.  Get the parent Node */
-
-		parent_node = acpi_ns_get_parent_node(child_node);
-		if (parent_node) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Parent of %p [%4.4s] is %p [%4.4s]\n",
-					  child_node,
-					  acpi_ut_get_node_name(child_node),
-					  parent_node,
-					  acpi_ut_get_node_name(parent_node)));
-
-			if (parent_node->name.integer) {
-				return_VALUE((acpi_name) parent_node->name.
-					     integer);
-			}
-		}
-
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Unable to find parent of %p (%4.4s)\n",
-				  child_node,
-				  acpi_ut_get_node_name(child_node)));
-	}
-
-	return_VALUE(ACPI_UNKNOWN_NAME);
-}
-#endif
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 00e79fb..2cd5be8 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -79,15 +79,6 @@ struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
 		return parent_node->child;
 	}
 
-	/*
-	 * Get the next node.
-	 *
-	 * If we are at the end of this peer list, return NULL
-	 */
-	if (child_node->flags & ANOBJ_END_OF_PEER_LIST) {
-		return NULL;
-	}
-
 	/* Otherwise just return the next peer */
 
 	return child_node->peer;
@@ -146,9 +137,9 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
 			return (next_node);
 		}
 
-		/* Otherwise, move on to the next node */
+		/* Otherwise, move on to the next peer node */
 
-		next_node = acpi_ns_get_next_valid_node(next_node);
+		next_node = next_node->peer;
 	}
 
 	/* Not found */
@@ -355,7 +346,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			 */
 			level--;
 			child_node = parent_node;
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 
 			node_previously_visited = TRUE;
 		}
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index eafef24..a1f04e9 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -190,7 +190,7 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 
 	/* Get the parent entry */
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 	*ret_handle = ACPI_CAST_PTR(acpi_handle, parent_node);
 
 	/* Return exception if parent is null */
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 6611675..0558747 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -813,10 +813,10 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_root_node_struct.name.integer = ACPI_ROOT_NAME;
 	acpi_gbl_root_node_struct.descriptor_type = ACPI_DESC_TYPE_NAMED;
 	acpi_gbl_root_node_struct.type = ACPI_TYPE_DEVICE;
+	acpi_gbl_root_node_struct.parent = NULL;
 	acpi_gbl_root_node_struct.child = NULL;
 	acpi_gbl_root_node_struct.peer = NULL;
 	acpi_gbl_root_node_struct.object = NULL;
-	acpi_gbl_root_node_struct.flags = ANOBJ_END_OF_PEER_LIST;
 
 #ifdef ACPI_DEBUG_OUTPUT
 	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);
-- 
1.6.0.6

