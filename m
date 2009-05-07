From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 4/4] ACPICA: Delete NextObject pointer
Date: Thu, 07 May 2009 19:52:18 +0400
Message-ID: <20090507155218.26361.61352.stgit@thinkpad>
References: <20090507155202.26361.38778.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.telecom.mipt.ru ([81.5.91.10]:60227 "EHLO
	relay1.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760397AbZEGQBN (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 7 May 2009 12:01:13 -0400
In-Reply-To: <20090507155202.26361.38778.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org

NextObject field was used for double objects (removed by prev patch) and
for data objects. Data object size is now untangled from all other object
sizes, so we can save size of pointer in all object allocations.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/namespace/nsobject.c |   38 ++++++--------------------------
 source/components/utilities/utcopy.c   |   13 ++++++++---
 source/include/aclocal.h               |    4 ++-
 source/include/acobject.h              |    3 +--
 4 files changed, 19 insertions(+), 39 deletions(-)


diff --git a/source/components/namespace/nsobject.c b/source/components/namespace/nsobject.c
index 9191e79..10e1b4d 100644
--- a/source/components/namespace/nsobject.c
+++ b/source/components/namespace/nsobject.c
@@ -154,7 +154,6 @@ AcpiNsAttachObject (
     ACPI_OBJECT_TYPE        Type)
 {
     ACPI_OPERAND_OBJECT     *ObjDesc;
-    ACPI_OPERAND_OBJECT     *LastObjDesc;
     ACPI_OBJECT_TYPE        ObjectType = ACPI_TYPE_ANY;
 
 
@@ -255,19 +254,6 @@ AcpiNsAttachObject (
          */
         AcpiUtAddReference (ObjDesc);
 
-        /*
-         * Handle objects with multiple descriptors - walk
-         * to the end of the descriptor list
-         */
-        LastObjDesc = ObjDesc;
-        while (LastObjDesc->Common.NextObject)
-        {
-            LastObjDesc = LastObjDesc->Common.NextObject;
-        }
-
-        /* Install the object at the front of the object list */
-
-        LastObjDesc->Common.NextObject = Node->Object;
     }
 
     Node->Type     = (UINT8) ObjectType;
@@ -312,15 +298,6 @@ AcpiNsDetachObject (
     /* Clear the entry in all cases */
 
     Node->Object = NULL;
-    if (ACPI_GET_DESCRIPTOR_TYPE (ObjDesc) == ACPI_DESC_TYPE_OPERAND)
-    {
-        Node->Object = ObjDesc->Common.NextObject;
-        if (Node->Object &&
-           ((Node->Object)->Common.Type != ACPI_TYPE_LOCAL_DATA))
-        {
-            Node->Object = Node->Object->Common.NextObject;
-        }
-    }
 
     /* Reset the node type to untyped */
 
@@ -404,14 +381,13 @@ AcpiNsAttachData (
     ObjDesc = Node->Object;
     while (ObjDesc)
     {
-        if ((ObjDesc->Common.Type == ACPI_TYPE_LOCAL_DATA) &&
-            (ObjDesc->Data.Handler == Handler))
+        if (ObjDesc->Data.Handler == Handler)
         {
             return (AE_ALREADY_EXISTS);
         }
 
         PrevObjDesc = ObjDesc;
-        ObjDesc = ObjDesc->Common.NextObject;
+        ObjDesc = ObjDesc->Data.Next;
     }
 
     /* Create an internal object for the data */
@@ -429,7 +405,7 @@ AcpiNsAttachData (
 
     if (PrevObjDesc)
     {
-        PrevObjDesc->Common.NextObject = DataDesc;
+        PrevObjDesc->Data.Next = DataDesc;
     }
     else
     {
@@ -472,11 +448,11 @@ AcpiNsDetachData (
         {
             if (PrevObjDesc)
             {
-                PrevObjDesc->Common.NextObject = ObjDesc->Common.NextObject;
+                PrevObjDesc->Data.Next = ObjDesc->Data.Next;
             }
             else
             {
-                Node->Object = ObjDesc->Common.NextObject;
+                Node->Object = ObjDesc->Data.Next;
             }
 
             AcpiUtRemoveReference (ObjDesc);
@@ -484,7 +460,7 @@ AcpiNsDetachData (
         }
 
         PrevObjDesc = ObjDesc;
-        ObjDesc = ObjDesc->Common.NextObject;
+        ObjDesc = ObjDesc->Data.Next;
     }
 
     return (AE_NOT_FOUND);
@@ -525,7 +501,7 @@ AcpiNsGetAttachedData (
             return (AE_OK);
         }
 
-        ObjDesc = ObjDesc->Common.NextObject;
+        ObjDesc = ObjDesc->Data.Next;
     }
 
     return (AE_NOT_FOUND);
diff --git a/source/components/utilities/utcopy.c b/source/components/utilities/utcopy.c
index 785c313..192db88 100644
--- a/source/components/utilities/utcopy.c
+++ b/source/components/utilities/utcopy.c
@@ -795,14 +795,17 @@ AcpiUtCopySimpleObject (
     ACPI_OPERAND_OBJECT     *DestDesc)
 {
     UINT16                  ReferenceCount;
-    ACPI_OPERAND_OBJECT     *NextObject;
+    ACPI_OPERAND_OBJECT     *NextObject = NULL;
     ACPI_STATUS             Status;
 
 
     /* Save fields from destination that we don't want to overwrite */
 
     ReferenceCount = DestDesc->Common.ReferenceCount;
-    NextObject = DestDesc->Common.NextObject;
+    if (DestDesc->Common.Type == ACPI_TYPE_LOCAL_DATA)
+    {
+	NextObject = DestDesc->Data.Next;
+    }
 
     /* Copy the entire source object over the destination object*/
 
@@ -812,8 +815,10 @@ AcpiUtCopySimpleObject (
     /* Restore the saved fields */
 
     DestDesc->Common.ReferenceCount = ReferenceCount;
-    DestDesc->Common.NextObject = NextObject;
-
+    if (DestDesc->Common.Type == ACPI_TYPE_LOCAL_DATA)
+    {
+	DestDesc->Data.Next = NextObject;
+    }
     /* New object is not static, regardless of source */
 
     DestDesc->Common.Flags &= ~AOPOBJ_STATIC_POINTER;
diff --git a/source/include/aclocal.h b/source/include/aclocal.h
index 4598d28..eade51f 100644
--- a/source/include/aclocal.h
+++ b/source/include/aclocal.h
@@ -269,7 +269,6 @@ typedef enum
  */
 typedef struct acpi_namespace_node
 {
-    union acpi_operand_object       *Object;        /* Interpreter object */
     UINT8                           DescriptorType; /* Differentiate object descriptor types */
     UINT8                           Type;           /* ACPI Type associated with this name */
     UINT8                           Flags;          /* Miscellaneous flags */
@@ -277,6 +276,7 @@ typedef struct acpi_namespace_node
     ACPI_NAME_UNION                 Name;           /* ACPI Name, always 4 chars per ACPI spec */
     struct acpi_namespace_node      *Child;         /* First child */
     struct acpi_namespace_node      *Peer;          /* Peer. Parent if ANOBJ_END_OF_PEER_LIST set */
+    union acpi_operand_object       *Object;        /* Interpreter object */
 
     /*
      * The following fields are used by the ASL compiler and disassembler only
@@ -852,11 +852,11 @@ typedef union acpi_parse_value
 #endif
 
 #define ACPI_PARSE_COMMON \
-    union acpi_parse_object         *Parent;        /* Parent op */\
     UINT8                           DescriptorType; /* To differentiate various internal objs */\
     UINT8                           Flags;          /* Type of Op */\
     UINT16                          AmlOpcode;      /* AML opcode */\
     UINT32                          AmlOffset;      /* Offset of declaration in AML */\
+    union acpi_parse_object         *Parent;        /* Parent op */\
     union acpi_parse_object         *Next;          /* Next op */\
     ACPI_NAMESPACE_NODE             *Node;          /* For use by interpreter */\
     ACPI_PARSE_VALUE                Value;          /* Value or args associated with the opcode */\
diff --git a/source/include/acobject.h b/source/include/acobject.h
index c78696b..29caa8d 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -152,7 +152,6 @@
  * structures.
  */
 #define ACPI_OBJECT_COMMON_HEADER \
-    union acpi_operand_object       *NextObject;        /* Objects linked to parent NS node */\
     UINT8                           DescriptorType;     /* To differentiate various internal objs */\
     UINT8                           Type;               /* ACPI_OBJECT_TYPE */\
     UINT16                          ReferenceCount;     /* For object deletion management */\
@@ -524,6 +523,7 @@ typedef enum
 typedef struct acpi_object_data
 {
     ACPI_OBJECT_COMMON_HEADER
+    union acpi_operand_object       *Next;        /* Objects linked to parent NS node */
     ACPI_OBJECT_HANDLER             Handler;
     void                            *Pointer;
 
@@ -598,7 +598,6 @@ typedef union acpi_operand_object
 
 typedef struct acpi_common_descriptor
 {
-    void                            *CommonPointer;
     UINT8                           DescriptorType; /* To differentiate various internal objs */
 
 } ACPI_COMMON_DESCRIPTOR;

