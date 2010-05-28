From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 4/4] ACPICA: Remove Extra object
Date: Fri, 28 May 2010 17:57:10 +0400
Message-ID: <20100528135710.26498.96986.stgit@thinkpad>
References: <20100528135648.26498.61828.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:49567 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260Ab0E1N5M (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 May 2010 09:57:12 -0400
In-Reply-To: <20100528135648.26498.61828.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org, devel@acpica.org

With the removal of object cache, there is no sense to have all
the object of the same size. Move Extra data into corresponding
primary objects.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


diff --git a/source/components/debugger/dbexec.c b/source/components/debugger/dbexec.c
index 6e8d618..60c76c9 100644
--- a/source/components/debugger/dbexec.c
+++ b/source/components/debugger/dbexec.c
@@ -315,7 +315,6 @@ AcpiDbExecuteSetup (
     }
 }
 
-
 /*******************************************************************************
  *
  * FUNCTION:    AcpiDbExecutionWalk
diff --git a/source/components/debugger/dbstats.c b/source/components/debugger/dbstats.c
index 4039a4f..a2523e0 100644
--- a/source/components/debugger/dbstats.c
+++ b/source/components/debugger/dbstats.c
@@ -268,10 +268,7 @@ AcpiDbEnumerateObject (
 
     case ACPI_TYPE_BUFFER_FIELD:
 
-        if (AcpiNsGetSecondaryObject (ObjDesc))
-        {
-            AcpiGbl_ObjTypeCount [ACPI_TYPE_BUFFER_FIELD]++;
-        }
+        AcpiGbl_ObjTypeCount [ACPI_TYPE_BUFFER_FIELD]++;
         break;
 
     case ACPI_TYPE_REGION:
@@ -493,7 +490,6 @@ AcpiDbDisplayStatistics (
 
 #ifdef ACPI_USE_LOCAL_CACHE
         AcpiOsPrintf ("\n----Cache Statistics (all in hex)---------\n");
-        AcpiDbListInfo (AcpiGbl_OperandCache);
         AcpiDbListInfo (AcpiGbl_PsNodeCache);
         AcpiDbListInfo (AcpiGbl_PsNodeExtCache);
         AcpiDbListInfo (AcpiGbl_StateCache);
@@ -544,7 +540,6 @@ AcpiDbDisplayStatistics (
         AcpiOsPrintf ("Reference        %3d\n", sizeof (ACPI_OBJECT_REFERENCE));
         AcpiOsPrintf ("Notify           %3d\n", sizeof (ACPI_OBJECT_NOTIFY_HANDLER));
         AcpiOsPrintf ("AddressSpace     %3d\n", sizeof (ACPI_OBJECT_ADDR_HANDLER));
-        AcpiOsPrintf ("Extra            %3d\n", sizeof (ACPI_OBJECT_EXTRA));
         AcpiOsPrintf ("Data             %3d\n", sizeof (ACPI_OBJECT_DATA));
 
         AcpiOsPrintf ("\n");
diff --git a/source/components/dispatcher/dsfield.c b/source/components/dispatcher/dsfield.c
index 23e3378..74f34e4 100644
--- a/source/components/dispatcher/dsfield.c
+++ b/source/components/dispatcher/dsfield.c
@@ -164,7 +164,6 @@ AcpiDsCreateBufferField (
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
     ACPI_OPERAND_OBJECT     *ObjDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc = NULL;
     UINT32                  Flags;
 
 
@@ -269,9 +268,8 @@ AcpiDsCreateBufferField (
      * Remember location in AML stream of the field unit opcode and operands --
      * since the buffer and index operands must be evaluated.
      */
-    SecondDesc                  = ObjDesc->Common.NextObject;
-    SecondDesc->Extra.AmlStart  = Op->Named.Data;
-    SecondDesc->Extra.AmlLength = Op->Named.Length;
+    ObjDesc->BufferField.AmlStart  = Op->Named.Data;
+    ObjDesc->BufferField.AmlLength = Op->Named.Length;
     ObjDesc->BufferField.Node   = Node;
 
     /* Attach constructed field descriptors to parent node */
diff --git a/source/components/dispatcher/dsopcode.c b/source/components/dispatcher/dsopcode.c
index 9d0941d..1d5bf6d 100644
--- a/source/components/dispatcher/dsopcode.c
+++ b/source/components/dispatcher/dsopcode.c
@@ -283,7 +283,6 @@ ACPI_STATUS
 AcpiDsGetBufferFieldArguments (
     ACPI_OPERAND_OBJECT     *ObjDesc)
 {
-    ACPI_OPERAND_OBJECT     *ExtraDesc;
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
 
@@ -298,7 +297,6 @@ AcpiDsGetBufferFieldArguments (
 
     /* Get the AML pointer (method object) and BufferField node */
 
-    ExtraDesc = AcpiNsGetSecondaryObject (ObjDesc);
     Node = ObjDesc->BufferField.Node;
 
     ACPI_DEBUG_EXEC(AcpiUtDisplayInitPathname (ACPI_TYPE_BUFFER_FIELD, Node, NULL));
@@ -308,7 +306,7 @@ AcpiDsGetBufferFieldArguments (
     /* Execute the AML code for the TermArg arguments */
 
     Status = AcpiDsExecuteArguments (Node, Node->Parent,
-                ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
+                ObjDesc->BufferField.AmlLength, ObjDesc->BufferField.AmlStart);
     return_ACPI_STATUS (Status);
 }
 
@@ -330,7 +328,6 @@ ACPI_STATUS
 AcpiDsGetBankFieldArguments (
     ACPI_OPERAND_OBJECT     *ObjDesc)
 {
-    ACPI_OPERAND_OBJECT     *ExtraDesc;
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
 
@@ -345,7 +342,6 @@ AcpiDsGetBankFieldArguments (
 
     /* Get the AML pointer (method object) and BankField node */
 
-    ExtraDesc = AcpiNsGetSecondaryObject (ObjDesc);
     Node = ObjDesc->BankField.Node;
 
     ACPI_DEBUG_EXEC(AcpiUtDisplayInitPathname (ACPI_TYPE_LOCAL_BANK_FIELD, Node, NULL));
@@ -355,7 +351,8 @@ AcpiDsGetBankFieldArguments (
     /* Execute the AML code for the TermArg arguments */
 
     Status = AcpiDsExecuteArguments (Node, Node->Parent,
-                ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
+                ObjDesc->BankField.AmlLength, ObjDesc->BankField.AmlStart);
+
     return_ACPI_STATUS (Status);
 }
 
@@ -477,8 +474,6 @@ AcpiDsGetRegionArguments (
 {
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
-    ACPI_OPERAND_OBJECT     *ExtraDesc;
-
 
     ACPI_FUNCTION_TRACE_PTR (DsGetRegionArguments, ObjDesc);
 
@@ -488,12 +483,6 @@ AcpiDsGetRegionArguments (
         return_ACPI_STATUS (AE_OK);
     }
 
-    ExtraDesc = AcpiNsGetSecondaryObject (ObjDesc);
-    if (!ExtraDesc)
-    {
-        return_ACPI_STATUS (AE_NOT_EXIST);
-    }
-
     /* Get the Region node */
 
     Node = ObjDesc->Region.Node;
@@ -501,12 +490,13 @@ AcpiDsGetRegionArguments (
     ACPI_DEBUG_EXEC (AcpiUtDisplayInitPathname (ACPI_TYPE_REGION, Node, NULL));
 
     ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
-        AcpiUtGetNodeName (Node), ExtraDesc->Extra.AmlStart));
+        AcpiUtGetNodeName (Node), ObjDesc->Region.AmlStart));
 
     /* Execute the argument AML */
 
     Status = AcpiDsExecuteArguments (Node, Node->Parent,
-                ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
+                ObjDesc->Region.AmlLength, ObjDesc->Region.AmlStart);
+
     return_ACPI_STATUS (Status);
 }
 
diff --git a/source/components/events/evregion.c b/source/components/events/evregion.c
index f3e10be..9514c50 100644
--- a/source/components/events/evregion.c
+++ b/source/components/events/evregion.c
@@ -359,20 +359,13 @@ AcpiEvExecuteRegMethod (
 {
     ACPI_EVALUATE_INFO      *Info;
     ACPI_OPERAND_OBJECT     *Args[3];
-    ACPI_OPERAND_OBJECT     *RegionObj2;
     ACPI_STATUS             Status;
 
 
     ACPI_FUNCTION_TRACE (EvExecuteRegMethod);
 
 
-    RegionObj2 = AcpiNsGetSecondaryObject (RegionObj);
-    if (!RegionObj2)
-    {
-        return_ACPI_STATUS (AE_NOT_EXIST);
-    }
-
-    if (RegionObj2->Extra.Method_REG == NULL)
+    if (RegionObj->Region.Method_REG == NULL)
     {
         return_ACPI_STATUS (AE_OK);
     }
@@ -385,7 +378,7 @@ AcpiEvExecuteRegMethod (
         return_ACPI_STATUS (AE_NO_MEMORY);
     }
 
-    Info->PrefixNode = RegionObj2->Extra.Method_REG;
+    Info->PrefixNode = RegionObj->Region.Method_REG;
     Info->Pathname = NULL;
     Info->Parameters = Args;
     Info->Flags = ACPI_IGNORE_RETURN_VALUE;
@@ -463,19 +456,10 @@ AcpiEvAddressSpaceDispatch (
     ACPI_ADR_SPACE_HANDLER  Handler;
     ACPI_ADR_SPACE_SETUP    RegionSetup;
     ACPI_OPERAND_OBJECT     *HandlerDesc;
-    ACPI_OPERAND_OBJECT     *RegionObj2;
     void                    *RegionContext = NULL;
 
-
     ACPI_FUNCTION_TRACE (EvAddressSpaceDispatch);
 
-
-    RegionObj2 = AcpiNsGetSecondaryObject (RegionObj);
-    if (!RegionObj2)
-    {
-        return_ACPI_STATUS (AE_NOT_EXIST);
-    }
-
     /* Ensure that there is a handler associated with this region */
 
     HandlerDesc = RegionObj->Region.Handler;
@@ -538,7 +522,7 @@ AcpiEvAddressSpaceDispatch (
         {
             RegionObj->Region.Flags |= AOPOBJ_SETUP_COMPLETE;
 
-            if (RegionObj2->Extra.RegionContext)
+            if (RegionObj->Region.RegionContext)
             {
                 /* The handler for this region was already installed */
 
@@ -550,7 +534,7 @@ AcpiEvAddressSpaceDispatch (
                  * Save the returned context for use in all accesses to
                  * this particular region
                  */
-                RegionObj2->Extra.RegionContext = RegionContext;
+                RegionObj->Region.RegionContext = RegionContext;
             }
         }
     }
@@ -578,9 +562,9 @@ AcpiEvAddressSpaceDispatch (
 
     /* Call the handler */
 
-    Status = Handler (Function,
-        (RegionObj->Region.Address + RegionOffset), BitWidth, Value,
-        HandlerDesc->AddressSpace.Context, RegionObj2->Extra.RegionContext);
+    Status = Handler (Function, (RegionObj->Region.Address + RegionOffset),
+        BitWidth, Value,
+        HandlerDesc->AddressSpace.Context, RegionObj->Region.RegionContext);
 
     if (ACPI_FAILURE (Status))
     {
@@ -626,19 +610,13 @@ AcpiEvDetachRegion(
     ACPI_OPERAND_OBJECT     **LastObjPtr;
     ACPI_ADR_SPACE_SETUP    RegionSetup;
     void                    **RegionContext;
-    ACPI_OPERAND_OBJECT     *RegionObj2;
     ACPI_STATUS             Status;
 
 
     ACPI_FUNCTION_TRACE (EvDetachRegion);
 
 
-    RegionObj2 = AcpiNsGetSecondaryObject (RegionObj);
-    if (!RegionObj2)
-    {
-        return_VOID;
-    }
-    RegionContext = &RegionObj2->Extra.RegionContext;
+    RegionContext = &RegionObj->Region.RegionContext;
 
     /* Get the address handler from the region object */
 
@@ -1100,10 +1078,6 @@ AcpiEvInstallSpaceHandler (
             goto UnlockAndExit;
         }
 
-        /* Init new descriptor */
-
-        ObjDesc->Common.Type = (UINT8) Type;
-
         /* Attach the new object to the Node */
 
         Status = AcpiNsAttachObject (Node, ObjDesc, Type);
diff --git a/source/components/events/evrgnini.c b/source/components/events/evrgnini.c
index 1cce564..181693f 100644
--- a/source/components/events/evrgnini.c
+++ b/source/components/events/evrgnini.c
@@ -639,8 +639,6 @@ AcpiEvInitializeRegion (
     ACPI_STATUS             Status;
     ACPI_NAMESPACE_NODE     *MethodNode;
     ACPI_NAME               *RegNamePtr = (ACPI_NAME *) METHOD_NAME__REG;
-    ACPI_OPERAND_OBJECT     *RegionObj2;
-
 
     ACPI_FUNCTION_TRACE_U32 (EvInitializeRegion, AcpiNsLocked);
 
@@ -655,19 +653,14 @@ AcpiEvInitializeRegion (
         return_ACPI_STATUS (AE_OK);
     }
 
-    RegionObj2 = AcpiNsGetSecondaryObject (RegionObj);
-    if (!RegionObj2)
-    {
-        return_ACPI_STATUS (AE_NOT_EXIST);
-    }
-
     Node = RegionObj->Region.Node->Parent;
+
     SpaceId = RegionObj->Region.SpaceId;
 
     /* Setup defaults */
 
     RegionObj->Region.Handler = NULL;
-    RegionObj2->Extra.Method_REG = NULL;
+    RegionObj->Region.Method_REG = NULL;
     RegionObj->Common.Flags &= ~(AOPOBJ_SETUP_COMPLETE);
     RegionObj->Common.Flags |= AOPOBJ_OBJECT_INITIALIZED;
 
@@ -682,7 +675,7 @@ AcpiEvInitializeRegion (
          * definition. This will be executed when the handler is attached
          * or removed
          */
-        RegionObj2->Extra.Method_REG = MethodNode;
+        RegionObj->Region.Method_REG = MethodNode;
     }
 
     /*
diff --git a/source/components/executer/excreate.c b/source/components/executer/excreate.c
index 87c4f8a..ed05b45 100644
--- a/source/components/executer/excreate.c
+++ b/source/components/executer/excreate.c
@@ -376,8 +376,6 @@ AcpiExCreateRegion (
     ACPI_STATUS             Status;
     ACPI_OPERAND_OBJECT     *ObjDesc;
     ACPI_NAMESPACE_NODE     *Node;
-    ACPI_OPERAND_OBJECT     *RegionObj2;
-
 
     ACPI_FUNCTION_TRACE (ExCreateRegion);
 
@@ -422,9 +420,8 @@ AcpiExCreateRegion (
      * Remember location in AML stream of address & length
      * operands since they need to be evaluated at run time.
      */
-    RegionObj2 = ObjDesc->Common.NextObject;
-    RegionObj2->Extra.AmlStart = AmlStart;
-    RegionObj2->Extra.AmlLength = AmlLength;
+    ObjDesc->Region.AmlStart = AmlStart;
+    ObjDesc->Region.AmlLength = AmlLength;
 
     /* Init the region from the operands */
 
diff --git a/source/components/executer/exprep.c b/source/components/executer/exprep.c
index 6241404..0743f60 100644
--- a/source/components/executer/exprep.c
+++ b/source/components/executer/exprep.c
@@ -499,7 +499,6 @@ AcpiExPrepFieldValue (
     ACPI_CREATE_FIELD_INFO  *Info)
 {
     ACPI_OPERAND_OBJECT     *ObjDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc = NULL;
     ACPI_STATUS             Status;
     UINT32                  AccessByteWidth;
     UINT32                  Type;
@@ -609,11 +608,8 @@ AcpiExPrepFieldValue (
          * opcode and operands -- since the BankValue
          * operands must be evaluated.
          */
-        SecondDesc = ObjDesc->Common.NextObject;
-        SecondDesc->Extra.AmlStart = ACPI_CAST_PTR (ACPI_PARSE_OBJECT,
-            Info->DataRegisterNode)->Named.Data;
-        SecondDesc->Extra.AmlLength = ACPI_CAST_PTR (ACPI_PARSE_OBJECT,
-            Info->DataRegisterNode)->Named.Length;
+        ObjDesc->BankField.AmlStart  = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Data;
+        ObjDesc->BankField.AmlLength = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Length;
 
         break;
 
diff --git a/source/components/namespace/nsobject.c b/source/components/namespace/nsobject.c
index af5df19..668d0de 100644
--- a/source/components/namespace/nsobject.c
+++ b/source/components/namespace/nsobject.c
@@ -125,6 +125,7 @@
 #define _COMPONENT          ACPI_NAMESPACE
         ACPI_MODULE_NAME    ("nsobject")
 
+#include <stdio.h>
 
 /*******************************************************************************
  *
@@ -383,39 +384,6 @@ AcpiNsGetAttachedObject (
     return_PTR (Node->Object);
 }
 
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiNsGetSecondaryObject
- *
- * PARAMETERS:  Node             - Namespace node
- *
- * RETURN:      Current value of the object field from the Node whose
- *              handle is passed.
- *
- * DESCRIPTION: Obtain a secondary object associated with a namespace node.
- *
- ******************************************************************************/
-
-ACPI_OPERAND_OBJECT *
-AcpiNsGetSecondaryObject (
-    ACPI_OPERAND_OBJECT     *ObjDesc)
-{
-    ACPI_FUNCTION_TRACE_PTR (NsGetSecondaryObject, ObjDesc);
-
-
-    if ((!ObjDesc)                                     ||
-        (ObjDesc->Common.Type== ACPI_TYPE_LOCAL_DATA)  ||
-        (!ObjDesc->Common.NextObject)                  ||
-        ((ObjDesc->Common.NextObject)->Common.Type == ACPI_TYPE_LOCAL_DATA))
-    {
-        return_PTR (NULL);
-    }
-
-    return_PTR (ObjDesc->Common.NextObject);
-}
-
-
 /*******************************************************************************
  *
  * FUNCTION:    AcpiNsAttachData
@@ -447,6 +415,7 @@ AcpiNsAttachData (
     ObjDesc = Node->Object;
     while (ObjDesc)
     {
+        fprintf(stderr, "attach_data: Type=%x\n", ObjDesc->Common.Type);
         if ((ObjDesc->Common.Type == ACPI_TYPE_LOCAL_DATA) &&
             (ObjDesc->Data.Handler == Handler))
         {
@@ -510,6 +479,7 @@ AcpiNsDetachData (
     ObjDesc = Node->Object;
     while (ObjDesc)
     {
+        fprintf(stderr, "detach_data: Type=%x\n", ObjDesc->Common.Type);
         if ((ObjDesc->Common.Type == ACPI_TYPE_LOCAL_DATA) &&
             (ObjDesc->Data.Handler == Handler))
         {
@@ -561,6 +531,7 @@ AcpiNsGetAttachedData (
     ObjDesc = Node->Object;
     while (ObjDesc)
     {
+	fprintf(stderr, "get_attached_data: Type=%x\n", ObjDesc->Common.Type);
         if ((ObjDesc->Common.Type == ACPI_TYPE_LOCAL_DATA) &&
             (ObjDesc->Data.Handler == Handler))
         {
diff --git a/source/components/utilities/utcopy.c b/source/components/utilities/utcopy.c
index c1fccae..15c826b 100644
--- a/source/components/utilities/utcopy.c
+++ b/source/components/utilities/utcopy.c
@@ -809,7 +809,7 @@ AcpiUtCopySimpleObject (
      * Copy the entire source object over the destination object.
      * Note: Source can be either an operand object or namespace node.
      */
-    CopySize = sizeof (ACPI_OPERAND_OBJECT);
+    CopySize = AcpiUtOperandSize(DestDesc->Common.Type);
     if (ACPI_GET_DESCRIPTOR_TYPE (SourceDesc) == ACPI_DESC_TYPE_NAMED)
     {
         CopySize = sizeof (ACPI_NAMESPACE_NODE);
diff --git a/source/components/utilities/utdelete.c b/source/components/utilities/utdelete.c
index 7ef61f8..0c79ddb 100644
--- a/source/components/utilities/utdelete.c
+++ b/source/components/utilities/utdelete.c
@@ -156,7 +156,6 @@ AcpiUtDeleteInternalObj (
 {
     void                    *ObjPointer = NULL;
     ACPI_OPERAND_OBJECT     *HandlerDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc;
     ACPI_OPERAND_OBJECT     *NextDesc;
     ACPI_OPERAND_OBJECT     **LastObjPtr;
 
@@ -307,9 +306,6 @@ AcpiUtDeleteInternalObj (
         ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS,
             "***** Region %p\n", Object));
 
-        SecondDesc = AcpiNsGetSecondaryObject (Object);
-        if (SecondDesc)
-        {
             /*
              * Free the RegionContext if and only if the handler is one of the
              * default handlers -- and therefore, we created the context object
@@ -347,46 +343,14 @@ AcpiUtDeleteInternalObj (
                         (void) HandlerDesc->AddressSpace.Setup (Object,
                             ACPI_REGION_DEACTIVATE,
                             HandlerDesc->AddressSpace.Context,
-                            &SecondDesc->Extra.RegionContext);
+                            &Object->Region.RegionContext);
                     }
                 }
 
                 AcpiUtRemoveReference (HandlerDesc);
             }
-
-            /* Now we can free the Extra object */
-
-            AcpiUtDeleteObjectDesc (SecondDesc);
-        }
         break;
 
-
-    case ACPI_TYPE_BUFFER_FIELD:
-
-        ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS,
-            "***** Buffer Field %p\n", Object));
-
-        SecondDesc = AcpiNsGetSecondaryObject (Object);
-        if (SecondDesc)
-        {
-            AcpiUtDeleteObjectDesc (SecondDesc);
-        }
-        break;
-
-
-    case ACPI_TYPE_LOCAL_BANK_FIELD:
-
-        ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS,
-            "***** Bank Field %p\n", Object));
-
-        SecondDesc = AcpiNsGetSecondaryObject (Object);
-        if (SecondDesc)
-        {
-            AcpiUtDeleteObjectDesc (SecondDesc);
-        }
-        break;
-
-
     default:
         break;
     }
diff --git a/source/components/utilities/utobject.c b/source/components/utilities/utobject.c
index fcc0674..2d15569 100644
--- a/source/components/utilities/utobject.c
+++ b/source/components/utilities/utobject.c
@@ -142,7 +142,7 @@ AcpiUtGetElementLength (
     ACPI_GENERIC_STATE      *State,
     void                    *Context);
 
-
+ACPI_SIZE AcpiUtOperandSize(int Type);
 /*******************************************************************************
  *
  * FUNCTION:    AcpiUtCreateInternalObjectDbg
@@ -155,13 +155,6 @@ AcpiUtGetElementLength (
  * RETURN:      A new internal object, null on failure
  *
  * DESCRIPTION: Create and initialize a new internal object.
- *
- * NOTE:        We always allocate the worst-case object descriptor because
- *              these objects are cached, and we want them to be
- *              one-size-satisifies-any-request.  This in itself may not be
- *              the most memory efficient, but the efficiency of the object
- *              cache should more than make up for this!
- *
  ******************************************************************************/
 
 ACPI_OPERAND_OBJECT  *
@@ -172,50 +165,20 @@ AcpiUtCreateInternalObjectDbg (
     ACPI_OBJECT_TYPE        Type)
 {
     ACPI_OPERAND_OBJECT     *Object;
-    ACPI_OPERAND_OBJECT     *SecondObject;
-
 
     ACPI_FUNCTION_TRACE_STR (UtCreateInternalObjectDbg,
         AcpiUtGetTypeName (Type));
 
 
     /* Allocate the raw object descriptor */
+    Object = ACPI_ALLOCATE_ZEROED(AcpiUtOperandSize(Type));
 
-    Object = AcpiUtAllocateObjectDescDbg (ModuleName, LineNumber, ComponentId);
     if (!Object)
     {
         return_PTR (NULL);
     }
 
-    switch (Type)
-    {
-    case ACPI_TYPE_REGION:
-    case ACPI_TYPE_BUFFER_FIELD:
-    case ACPI_TYPE_LOCAL_BANK_FIELD:
-
-        /* These types require a secondary object */
-
-        SecondObject = AcpiUtAllocateObjectDescDbg (ModuleName,
-                            LineNumber, ComponentId);
-        if (!SecondObject)
-        {
-            AcpiUtDeleteObjectDesc (Object);
-            return_PTR (NULL);
-        }
-
-        SecondObject->Common.Type = ACPI_TYPE_LOCAL_EXTRA;
-        SecondObject->Common.ReferenceCount = 1;
-
-        /* Link the second object to the first */
-
-        Object->Common.NextObject = SecondObject;
-        break;
-
-    default:
-        /* All others have no secondary object */
-        break;
-    }
-
+    ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_OPERAND);
     /* Save the object type in the object descriptor */
 
     Object->Common.Type = (UINT8) Type;
@@ -478,54 +441,6 @@ AcpiUtValidInternalObject (
     return (FALSE);
 }
 
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiUtAllocateObjectDescDbg
- *
- * PARAMETERS:  ModuleName          - Caller's module name (for error output)
- *              LineNumber          - Caller's line number (for error output)
- *              ComponentId         - Caller's component ID (for error output)
- *
- * RETURN:      Pointer to newly allocated object descriptor.  Null on error
- *
- * DESCRIPTION: Allocate a new object descriptor.  Gracefully handle
- *              error conditions.
- *
- ******************************************************************************/
-
-void *
-AcpiUtAllocateObjectDescDbg (
-    const char              *ModuleName,
-    UINT32                  LineNumber,
-    UINT32                  ComponentId)
-{
-    ACPI_OPERAND_OBJECT     *Object;
-
-
-    ACPI_FUNCTION_TRACE (UtAllocateObjectDescDbg);
-
-
-    Object = ACPI_ALLOCATE_ZEROED (sizeof (ACPI_OPERAND_OBJECT));
-    if (!Object)
-    {
-        ACPI_ERROR ((ModuleName, LineNumber,
-            "Could not allocate an object descriptor"));
-
-        return_PTR (NULL);
-    }
-
-    /* Mark the descriptor type */
-
-    ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_OPERAND);
-
-    ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
-            Object, (UINT32) sizeof (ACPI_OPERAND_OBJECT)));
-
-    return_PTR (Object);
-}
-
-
 /*******************************************************************************
  *
  * FUNCTION:    AcpiUtDeleteObjectDesc
@@ -560,6 +475,79 @@ AcpiUtDeleteObjectDesc (
 }
 
 
+ACPI_SIZE AcpiUtOperandSize(int Type)
+{
+    ACPI_SIZE ObjSize = 0;
+
+    switch (Type) {
+	case ACPI_TYPE_INTEGER:
+		ObjSize = sizeof (ACPI_OBJECT_INTEGER);
+		break;
+	case ACPI_TYPE_BUFFER_FIELD:
+		ObjSize = sizeof (ACPI_OBJECT_BUFFER_FIELD);
+		break;
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+		ObjSize = sizeof (ACPI_OBJECT_BANK_FIELD);
+		break;
+	case ACPI_TYPE_LOCAL_INDEX_FIELD:
+		ObjSize = sizeof (ACPI_OBJECT_INDEX_FIELD);
+		break;
+	case ACPI_TYPE_LOCAL_ADDRESS_HANDLER:
+		ObjSize = sizeof (ACPI_OBJECT_ADDR_HANDLER);
+		break;
+	case ACPI_TYPE_MUTEX:
+		ObjSize = sizeof (ACPI_OBJECT_MUTEX);
+		break;
+	case ACPI_TYPE_REGION:
+		ObjSize = sizeof (ACPI_OBJECT_REGION);
+		break;
+	case ACPI_TYPE_STRING:
+		ObjSize = sizeof (ACPI_OBJECT_STRING);
+		break;
+	case ACPI_TYPE_BUFFER:
+		ObjSize = sizeof (ACPI_OBJECT_BUFFER);
+		break;
+	case ACPI_TYPE_PACKAGE:
+		ObjSize = sizeof (ACPI_OBJECT_PACKAGE);
+		break;
+	case ACPI_TYPE_EVENT:
+		ObjSize = sizeof (ACPI_OBJECT_EVENT);
+		break;
+	case ACPI_TYPE_METHOD:
+		ObjSize = sizeof (ACPI_OBJECT_METHOD);
+		break;
+	case ACPI_TYPE_DEVICE:
+		ObjSize = sizeof (ACPI_OBJECT_DEVICE);
+		break;
+	case ACPI_TYPE_POWER:
+		ObjSize = sizeof (ACPI_OBJECT_POWER_RESOURCE);
+		break;
+	case ACPI_TYPE_PROCESSOR:
+		ObjSize = sizeof (ACPI_OBJECT_PROCESSOR);
+		break;
+	case ACPI_TYPE_THERMAL:
+		ObjSize = sizeof (ACPI_OBJECT_THERMAL_ZONE);
+		break;
+	case ACPI_TYPE_LOCAL_REGION_FIELD:
+		ObjSize = sizeof (ACPI_OBJECT_REGION_FIELD);
+		break;
+	case ACPI_TYPE_LOCAL_NOTIFY:
+		ObjSize = sizeof (ACPI_OBJECT_NOTIFY_HANDLER);
+		break;
+	case ACPI_TYPE_LOCAL_REFERENCE:
+		ObjSize = sizeof (ACPI_OBJECT_REFERENCE);
+		break;
+	case ACPI_TYPE_LOCAL_DATA:
+		ObjSize = sizeof (ACPI_OBJECT_DATA);
+		break;
+	default:
+		ACPI_ERROR ((AE_INFO,
+		"Unexpected type of object descriptor"));
+		return 0;
+     }
+     return ObjSize;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    AcpiUtGetSimpleObjectSize
diff --git a/source/include/acnamesp.h b/source/include/acnamesp.h
index 5895e06..8041e6e 100644
--- a/source/include/acnamesp.h
+++ b/source/include/acnamesp.h
@@ -406,10 +406,6 @@ ACPI_OPERAND_OBJECT *
 AcpiNsGetAttachedObject (
     ACPI_NAMESPACE_NODE     *Node);
 
-ACPI_OPERAND_OBJECT *
-AcpiNsGetSecondaryObject (
-    ACPI_OPERAND_OBJECT     *ObjDesc);
-
 ACPI_STATUS
 AcpiNsAttachData (
     ACPI_NAMESPACE_NODE     *Node,
diff --git a/source/include/acobject.h b/source/include/acobject.h
index 5c61567..1cfe371 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -277,6 +277,10 @@ typedef struct acpi_object_region
     union acpi_operand_object       *Next;
     ACPI_PHYSICAL_ADDRESS           Address;
     UINT32                          Length;
+    ACPI_NAMESPACE_NODE             *Method_REG;        /* _REG method for this region (if any) */
+    void                            *RegionContext;     /* Region-specific data */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_REGION;
 
@@ -412,6 +416,8 @@ typedef struct acpi_object_bank_field
     ACPI_COMMON_FIELD_INFO
     union acpi_operand_object       *RegionObj;         /* Containing OpRegion object */
     union acpi_operand_object       *BankObj;           /* BankSelect Register object */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_BANK_FIELD;
 
@@ -438,6 +444,8 @@ typedef struct acpi_object_buffer_field
     ACPI_OBJECT_COMMON_HEADER
     ACPI_COMMON_FIELD_INFO
     union acpi_operand_object       *BufferObj;         /* Containing Buffer object */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_BUFFER_FIELD;
 
@@ -517,25 +525,6 @@ typedef enum
 
 } ACPI_REFERENCE_CLASSES;
 
-
-/*
- * Extra object is used as additional storage for types that
- * have AML code in their declarations (TermArgs) that must be
- * evaluated at run time.
- *
- * Currently: Region and FieldUnit types
- */
-typedef struct acpi_object_extra
-{
-    ACPI_OBJECT_COMMON_HEADER
-    ACPI_NAMESPACE_NODE             *Method_REG;        /* _REG method for this region (if any) */
-    void                            *RegionContext;     /* Region-specific data */
-    UINT8                           *AmlStart;
-    UINT32                          AmlLength;
-
-} ACPI_OBJECT_EXTRA;
-
-
 /* Additional data that can be attached to namespace nodes */
 
 typedef struct acpi_object_data
@@ -576,7 +565,6 @@ typedef union acpi_operand_object
     ACPI_OBJECT_NOTIFY_HANDLER          Notify;
     ACPI_OBJECT_ADDR_HANDLER            AddressSpace;
     ACPI_OBJECT_REFERENCE               Reference;
-    ACPI_OBJECT_EXTRA                   Extra;
     ACPI_OBJECT_DATA                    Data;
 
     /*
@@ -588,7 +576,6 @@ typedef union acpi_operand_object
 
 } ACPI_OPERAND_OBJECT;
 
-
 /******************************************************************************
  *
  * ACPI_DESCRIPTOR - objects that share a common descriptor identifier
diff --git a/source/include/actypes.h b/source/include/actypes.h
index dbab6d2..a50db7d 100644
--- a/source/include/actypes.h
+++ b/source/include/actypes.h
@@ -667,7 +667,6 @@ typedef UINT32                          ACPI_OBJECT_TYPE;
  * These are special object types that never appear in
  * a Namespace node, only in an ACPI_OPERAND_OBJECT
  */
-#define ACPI_TYPE_LOCAL_EXTRA           0x1C
 #define ACPI_TYPE_LOCAL_DATA            0x1D
 
 #define ACPI_TYPE_LOCAL_MAX             0x1D
diff --git a/source/include/acutils.h b/source/include/acutils.h
index ae406c3..3ef4769 100644
--- a/source/include/acutils.h
+++ b/source/include/acutils.h
@@ -397,7 +397,7 @@ AcpiUtCopyIobjectToIobject (
     ACPI_OPERAND_OBJECT     **DestDesc,
     ACPI_WALK_STATE         *WalkState);
 
-
+ACPI_SIZE AcpiUtOperandSize(int Type);
 /*
  * utcreate - Object creation
  */

