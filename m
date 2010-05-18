From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/3] ACPICA: Add direct pointer to parent
Date: Wed, 19 May 2010 00:25:38 +0400
Message-ID: <20100518202538.29771.53703.stgit@thinkpad>
References: <20100518202524.29771.96252.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:60547 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0ERUZk (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:25:40 -0400
In-Reply-To: <20100518202524.29771.96252.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

It is starts to be time consuming to scan list of peers for the parent pointer.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/common/dmextern.c                |    2 -
 source/common/dmrestag.c                |    7 ---
 source/components/dispatcher/dsopcode.c |    6 +--
 source/components/events/evrgnini.c     |   10 ++--
 source/components/executer/exdump.c     |    2 -
 source/components/namespace/nsaccess.c  |    4 +-
 source/components/namespace/nsalloc.c   |   72 ++++++++-----------------------
 source/components/namespace/nsinit.c    |    4 +-
 source/components/namespace/nsnames.c   |    4 +-
 source/components/namespace/nssearch.c  |   16 +------
 source/components/namespace/nsutils.c   |   73 -------------------------------
 source/components/namespace/nswalk.c    |   18 ++------
 source/components/namespace/nsxfobj.c   |    2 -
 source/include/aclocal.h                |    3 +
 source/include/acnamesp.h               |    9 ----
 15 files changed, 44 insertions(+), 188 deletions(-)


diff --git a/source/common/dmextern.c b/source/common/dmextern.c
index ab46b69..530f272 100644
--- a/source/common/dmextern.c
+++ b/source/common/dmextern.c
@@ -252,7 +252,7 @@ AcpiDmNormalizeParentPrefix (
     Node = Op->Common.Node;
     while (Node && (*Path == (UINT8) AML_PARENT_PREFIX))
     {
-        Node = AcpiNsGetParentNode (Node);
+        Node = Node->Parent;
         Path++;
     }
 
diff --git a/source/common/dmrestag.c b/source/common/dmrestag.c
index 97f6c47..e1f340d 100644
--- a/source/common/dmrestag.c
+++ b/source/common/dmrestag.c
@@ -549,13 +549,6 @@ AcpiDmGetResourceNode (
             return (Node);
         }
 
-        /* List is circular, this flag marks the end */
-
-        if (Node->Flags & ANOBJ_END_OF_PEER_LIST)
-        {
-            return (NULL);
-        }
-
         Node = Node->Peer;
     }
 
diff --git a/source/components/dispatcher/dsopcode.c b/source/components/dispatcher/dsopcode.c
index e7ebc76..9d0941d 100644
--- a/source/components/dispatcher/dsopcode.c
+++ b/source/components/dispatcher/dsopcode.c
@@ -307,7 +307,7 @@ AcpiDsGetBufferFieldArguments (
 
     /* Execute the AML code for the TermArg arguments */
 
-    Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
+    Status = AcpiDsExecuteArguments (Node, Node->Parent,
                 ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
     return_ACPI_STATUS (Status);
 }
@@ -354,7 +354,7 @@ AcpiDsGetBankFieldArguments (
 
     /* Execute the AML code for the TermArg arguments */
 
-    Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
+    Status = AcpiDsExecuteArguments (Node, Node->Parent,
                 ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
     return_ACPI_STATUS (Status);
 }
@@ -505,7 +505,7 @@ AcpiDsGetRegionArguments (
 
     /* Execute the argument AML */
 
-    Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
+    Status = AcpiDsExecuteArguments (Node, Node->Parent,
                 ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
     return_ACPI_STATUS (Status);
 }
diff --git a/source/components/events/evrgnini.c b/source/components/events/evrgnini.c
index 8a6cbfd..1cce564 100644
--- a/source/components/events/evrgnini.c
+++ b/source/components/events/evrgnini.c
@@ -294,7 +294,7 @@ AcpiEvPciConfigRegionSetup (
         return_ACPI_STATUS (Status);
     }
 
-    ParentNode = AcpiNsGetParentNode (RegionObj->Region.Node);
+    ParentNode = RegionObj->Region.Node->Parent;
 
     /*
      * Get the _SEG and _BBN values from the device upon which the handler
@@ -348,7 +348,7 @@ AcpiEvPciConfigRegionSetup (
                 break;
             }
 
-            PciRootNode = AcpiNsGetParentNode (PciRootNode);
+            PciRootNode = PciRootNode->Parent;
         }
 
         /* PCI root bridge not found, use namespace root node */
@@ -385,7 +385,7 @@ AcpiEvPciConfigRegionSetup (
     PciDeviceNode = RegionObj->Region.Node;
     while (PciDeviceNode && (PciDeviceNode->Type != ACPI_TYPE_DEVICE))
     {
-        PciDeviceNode = AcpiNsGetParentNode (PciDeviceNode);
+        PciDeviceNode = PciDeviceNode->Parent;
     }
 
     if (!PciDeviceNode)
@@ -661,7 +661,7 @@ AcpiEvInitializeRegion (
         return_ACPI_STATUS (AE_NOT_EXIST);
     }
 
-    Node = AcpiNsGetParentNode (RegionObj->Region.Node);
+    Node = RegionObj->Region.Node->Parent;
     SpaceId = RegionObj->Region.SpaceId;
 
     /* Setup defaults */
@@ -785,7 +785,7 @@ AcpiEvInitializeRegion (
 
         /* This node does not have the handler we need; Pop up one level */
 
-        Node = AcpiNsGetParentNode (Node);
+        Node = Node->Parent;
     }
 
     /* If we get here, there is no handler for this region */
diff --git a/source/components/executer/exdump.c b/source/components/executer/exdump.c
index 5ef9fe8..5752727 100644
--- a/source/components/executer/exdump.c
+++ b/source/components/executer/exdump.c
@@ -948,7 +948,7 @@ AcpiExDumpNamespaceNode (
     AcpiOsPrintf ("%20s : %4.4s\n", "Name", AcpiUtGetNodeName (Node));
     AcpiExOutString  ("Type", AcpiUtGetTypeName (Node->Type));
     AcpiExOutPointer ("Attached Object", AcpiNsGetAttachedObject (Node));
-    AcpiExOutPointer ("Parent", AcpiNsGetParentNode (Node));
+    AcpiExOutPointer ("Parent", Node->Parent);
 
     AcpiExDumpObject (ACPI_CAST_PTR (ACPI_OPERAND_OBJECT, Node),
         AcpiExDumpNode);
diff --git a/source/components/namespace/nsaccess.c b/source/components/namespace/nsaccess.c
index 7a8dc6d..d074ece 100644
--- a/source/components/namespace/nsaccess.c
+++ b/source/components/namespace/nsaccess.c
@@ -435,7 +435,7 @@ AcpiNsLookup (
             while (!AcpiNsOpensScope (PrefixNode->Type) &&
                     PrefixNode->Type != ACPI_TYPE_ANY)
             {
-                PrefixNode = AcpiNsGetParentNode (PrefixNode);
+                PrefixNode = PrefixNode->Parent;
             }
         }
     }
@@ -516,7 +516,7 @@ AcpiNsLookup (
                 /* Backup to the parent node */
 
                 NumCarats++;
-                ThisNode = AcpiNsGetParentNode (ThisNode);
+                ThisNode = ThisNode->Parent;
                 if (!ThisNode)
                 {
                     /* Current scope has no parent scope */
diff --git a/source/components/namespace/nsalloc.c b/source/components/namespace/nsalloc.c
index 16bcdd3..42a5f71 100644
--- a/source/components/namespace/nsalloc.c
+++ b/source/components/namespace/nsalloc.c
@@ -255,7 +255,7 @@ AcpiNsRemoveNode (
     ACPI_FUNCTION_TRACE_PTR (NsRemoveNode, Node);
 
 
-    ParentNode = AcpiNsGetParentNode (Node);
+    ParentNode = Node->Parent;
 
     PrevNode = NULL;
     NextNode = ParentNode->Child;
@@ -265,34 +265,19 @@ AcpiNsRemoveNode (
     while (NextNode != Node)
     {
         PrevNode = NextNode;
-        NextNode = PrevNode->Peer;
+	NextNode = NextNode->Peer;
     }
 
     if (PrevNode)
     {
         /* Node is not first child, unlink it */
-
-        PrevNode->Peer = NextNode->Peer;
-        if (NextNode->Flags & ANOBJ_END_OF_PEER_LIST)
-        {
-            PrevNode->Flags |= ANOBJ_END_OF_PEER_LIST;
-        }
+        PrevNode->Peer = Node->Peer;
     }
     else
     {
         /* Node is first child (has no previous peer) */
-
-        if (NextNode->Flags & ANOBJ_END_OF_PEER_LIST)
-        {
-            /* No peers at all */
-
-            ParentNode->Child = NULL;
-        }
-        else
-        {   /* Link peer list to parent */
-
-            ParentNode->Child = NextNode->Peer;
-        }
+        /* Link peer list to parent */
+	ParentNode->Child = Node->Peer;
     }
 
     /* Delete the node and any attached objects */
@@ -352,26 +337,18 @@ AcpiNsInstallNode (
     /* Link the new entry into the parent and existing children */
 
     ChildNode = ParentNode->Child;
+    Node->Parent = ParentNode;
     if (!ChildNode)
     {
         ParentNode->Child = Node;
-        Node->Flags |= ANOBJ_END_OF_PEER_LIST;
-        Node->Peer = ParentNode;
     }
     else
     {
-        while (!(ChildNode->Flags & ANOBJ_END_OF_PEER_LIST))
+        while (ChildNode->Peer)
         {
             ChildNode = ChildNode->Peer;
         }
-
         ChildNode->Peer = Node;
-
-        /* Clear end-of-list flag */
-
-        ChildNode->Flags &= ~ANOBJ_END_OF_PEER_LIST;
-        Node->Flags |= ANOBJ_END_OF_PEER_LIST;
-        Node->Peer = ParentNode;
     }
 
     /* Init the new entry */
@@ -406,9 +383,7 @@ void
 AcpiNsDeleteChildren (
     ACPI_NAMESPACE_NODE     *ParentNode)
 {
-    ACPI_NAMESPACE_NODE     *ChildNode;
-    ACPI_NAMESPACE_NODE     *NextNode;
-    UINT8                   Flags;
+    ACPI_NAMESPACE_NODE     *NextNode, *DelNode;
 
 
     ACPI_FUNCTION_TRACE_PTR (NsDeleteChildren, ParentNode);
@@ -420,38 +395,27 @@ AcpiNsDeleteChildren (
     }
 
     /* If no children, all done! */
-
-    ChildNode = ParentNode->Child;
-    if (!ChildNode)
-    {
-        return_VOID;
-    }
+    NextNode = ParentNode->Child;
 
     /* Deallocate all children at this level */
 
-    do
+    while (NextNode)
     {
-        /* Get the things we need */
-
-        NextNode = ChildNode->Peer;
-        Flags = ChildNode->Flags;
-
         /* Grandchildren should have all been deleted already */
-
-        if (ChildNode->Child)
+        if (NextNode->Child)
         {
             ACPI_ERROR ((AE_INFO, "Found a grandchild! P=%p C=%p",
-                ParentNode, ChildNode));
+                ParentNode, NextNode));
         }
 
         /*
          * Delete this child node and move on to the next child in the list.
          * No need to unlink the node since we are deleting the entire branch.
          */
-        AcpiNsDeleteNode (ChildNode);
-        ChildNode = NextNode;
-
-    } while (!(Flags & ANOBJ_END_OF_PEER_LIST));
+	DelNode = NextNode;
+        NextNode = NextNode->Peer;
+        AcpiNsDeleteNode (DelNode);
+    };
 
     /* Clear the parent's child pointer */
 
@@ -537,7 +501,7 @@ AcpiNsDeleteNamespaceSubtree (
 
             /* Move up the tree to the grandparent */
 
-            ParentNode = AcpiNsGetParentNode (ParentNode);
+            ParentNode = ParentNode->Parent;
         }
     }
 
@@ -659,7 +623,7 @@ AcpiNsDeleteNamespaceByOwner (
 
             /* Move up the tree to the grandparent */
 
-            ParentNode = AcpiNsGetParentNode (ParentNode);
+            ParentNode = ParentNode->Parent;
         }
     }
 
diff --git a/source/components/namespace/nsinit.c b/source/components/namespace/nsinit.c
index e59eb8e..7cd2a31 100644
--- a/source/components/namespace/nsinit.c
+++ b/source/components/namespace/nsinit.c
@@ -510,7 +510,7 @@ AcpiNsFindIniMethods (
      * The only _INI methods that we care about are those that are
      * present under Device, Processor, and Thermal objects.
      */
-    ParentNode = AcpiNsGetParentNode (Node);
+    ParentNode = Node->Parent;
     switch (ParentNode->Type)
     {
     case ACPI_TYPE_DEVICE:
@@ -522,7 +522,7 @@ AcpiNsFindIniMethods (
         while (ParentNode)
         {
             ParentNode->Flags |= ANOBJ_SUBTREE_HAS_INI;
-            ParentNode = AcpiNsGetParentNode (ParentNode);
+            ParentNode = ParentNode->Parent;
         }
         break;
 
diff --git a/source/components/namespace/nsnames.c b/source/components/namespace/nsnames.c
index 7eb3e54..f05288e 100644
--- a/source/components/namespace/nsnames.c
+++ b/source/components/namespace/nsnames.c
@@ -176,7 +176,7 @@ AcpiNsBuildExternalPath (
         /* Put the name into the buffer */
 
         ACPI_MOVE_32_TO_32 ((NameBuffer + Index), &ParentNode->Name);
-        ParentNode = AcpiNsGetParentNode (ParentNode);
+        ParentNode = ParentNode->Parent;
 
         /* Prefix name with the path separator */
 
@@ -298,7 +298,7 @@ AcpiNsGetPathnameLength (
             return 0;
         }
         Size += ACPI_PATH_SEGMENT_LENGTH;
-        NextNode = AcpiNsGetParentNode (NextNode);
+        NextNode = NextNode->Parent;
     }
 
     if (!Size)
diff --git a/source/components/namespace/nssearch.c b/source/components/namespace/nssearch.c
index fa15b9c..6972da2 100644
--- a/source/components/namespace/nssearch.c
+++ b/source/components/namespace/nssearch.c
@@ -229,19 +229,7 @@ AcpiNsSearchOneScope (
             return_ACPI_STATUS (AE_OK);
         }
 
-        /*
-         * The last entry in the list points back to the parent,
-         * so a flag is used to indicate the end-of-list
-         */
-        if (Node->Flags & ANOBJ_END_OF_PEER_LIST)
-        {
-            /* Searched entire list, we are done */
-
-            break;
-        }
-
         /* Didn't match name, move on to the next peer object */
-
         Node = Node->Peer;
     }
 
@@ -296,7 +284,7 @@ AcpiNsSearchParentTree (
     ACPI_FUNCTION_TRACE (NsSearchParentTree);
 
 
-    ParentNode = AcpiNsGetParentNode (Node);
+    ParentNode = Node->Parent;
 
     /*
      * If there is no parent (i.e., we are at the root) or type is "local",
@@ -341,7 +329,7 @@ AcpiNsSearchParentTree (
 
         /* Not found here, go up another level (until we reach the root) */
 
-        ParentNode = AcpiNsGetParentNode (ParentNode);
+        ParentNode = ParentNode->Parent;
     }
 
     /* Not found in parent tree */
diff --git a/source/components/namespace/nsutils.c b/source/components/namespace/nsutils.c
index 98ec9ff..7d71efb 100644
--- a/source/components/namespace/nsutils.c
+++ b/source/components/namespace/nsutils.c
@@ -1058,77 +1058,6 @@ Cleanup:
     return_ACPI_STATUS (Status);
 }
 
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiNsGetParentNode
- *
- * PARAMETERS:  Node       - Current table entry
- *
- * RETURN:      Parent entry of the given entry
- *
- * DESCRIPTION: Obtain the parent entry for a given entry in the namespace.
- *
- ******************************************************************************/
-
-ACPI_NAMESPACE_NODE *
-AcpiNsGetParentNode (
-    ACPI_NAMESPACE_NODE     *Node)
-{
-    ACPI_FUNCTION_ENTRY ();
-
-
-    if (!Node)
-    {
-        return (NULL);
-    }
-
-    /*
-     * Walk to the end of this peer list. The last entry is marked with a flag
-     * and the peer pointer is really a pointer back to the parent. This saves
-     * putting a parent back pointer in each and every named object!
-     */
-    while (!(Node->Flags & ANOBJ_END_OF_PEER_LIST))
-    {
-        Node = Node->Peer;
-    }
-
-    return (Node->Peer);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiNsGetNextValidNode
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
-ACPI_NAMESPACE_NODE *
-AcpiNsGetNextValidNode (
-    ACPI_NAMESPACE_NODE     *Node)
-{
-
-    /* If we are at the end of this peer list, return NULL */
-
-    if (Node->Flags & ANOBJ_END_OF_PEER_LIST)
-    {
-        return NULL;
-    }
-
-    /* Otherwise just return the next peer */
-
-    return (Node->Peer);
-}
-
-
 #ifdef ACPI_OBSOLETE_FUNCTIONS
 /*******************************************************************************
  *
@@ -1158,7 +1087,7 @@ AcpiNsFindParentName (
     {
         /* Valid entry.  Get the parent Node */
 
-        ParentNode = AcpiNsGetParentNode (ChildNode);
+        ParentNode = ChildNode->Parent;
         if (ParentNode)
         {
             ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
diff --git a/source/components/namespace/nswalk.c b/source/components/namespace/nswalk.c
index b6c573b..edf776a 100644
--- a/source/components/namespace/nswalk.c
+++ b/source/components/namespace/nswalk.c
@@ -155,22 +155,12 @@ AcpiNsGetNextNode (
     {
         /* It's really the parent's _scope_ that we want */
 
-        return (ParentNode->Child);
-    }
-
-    /*
-     * Get the next node.
-     *
-     * If we are at the end of this peer list, return NULL
-     */
-    if (ChildNode->Flags & ANOBJ_END_OF_PEER_LIST)
-    {
-        return NULL;
+        return ParentNode->Child;
     }
 
     /* Otherwise just return the next peer */
 
-    return (ChildNode->Peer);
+    return ChildNode->Peer;
 }
 
 
@@ -229,7 +219,7 @@ AcpiNsGetNextNodeTyped (
 
         /* Otherwise, move on to the next node */
 
-        NextNode = AcpiNsGetNextValidNode (NextNode);
+        NextNode = NextNode->Peer;
     }
 
     /* Not found */
@@ -454,7 +444,7 @@ AcpiNsWalkNamespace (
              */
             Level--;
             ChildNode = ParentNode;
-            ParentNode = AcpiNsGetParentNode (ParentNode);
+            ParentNode = ParentNode->Parent;
 
             NodePreviouslyVisited = TRUE;
         }
diff --git a/source/components/namespace/nsxfobj.c b/source/components/namespace/nsxfobj.c
index aef106e..8e6ed64 100644
--- a/source/components/namespace/nsxfobj.c
+++ b/source/components/namespace/nsxfobj.c
@@ -242,7 +242,7 @@ AcpiGetParent (
 
     /* Get the parent entry */
 
-    ParentNode = AcpiNsGetParentNode (Node);
+    ParentNode = Node->Parent;
     *RetHandle = ACPI_CAST_PTR (ACPI_HANDLE, ParentNode);
 
     /* Return exception if parent is null */
diff --git a/source/include/aclocal.h b/source/include/aclocal.h
index 1deced0..e6c3c90 100644
--- a/source/include/aclocal.h
+++ b/source/include/aclocal.h
@@ -276,7 +276,8 @@ typedef struct acpi_namespace_node
     ACPI_OWNER_ID                   OwnerId;        /* Node creator */
     ACPI_NAME_UNION                 Name;           /* ACPI Name, always 4 chars per ACPI spec */
     struct acpi_namespace_node      *Child;         /* First child */
-    struct acpi_namespace_node      *Peer;          /* Peer. Parent if ANOBJ_END_OF_PEER_LIST set */
+    struct acpi_namespace_node      *Parent;        /* Parent */
+    struct acpi_namespace_node      *Peer;          /* Peer */
 
     /*
      * The following fields are used by the ASL compiler and disassembler only
diff --git a/source/include/acnamesp.h b/source/include/acnamesp.h
index 9ddd12e..5895e06 100644
--- a/source/include/acnamesp.h
+++ b/source/include/acnamesp.h
@@ -562,13 +562,4 @@ void
 AcpiNsTerminate (
     void);
 
-ACPI_NAMESPACE_NODE *
-AcpiNsGetParentNode (
-    ACPI_NAMESPACE_NODE     *Node);
-
-
-ACPI_NAMESPACE_NODE *
-AcpiNsGetNextValidNode (
-    ACPI_NAMESPACE_NODE     *Node);
-
 #endif /* __ACNAMESP_H__ */

