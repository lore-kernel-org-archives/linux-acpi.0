From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/4] ACPICA: Drop Operand cache
Date: Thu, 07 May 2009 19:52:13 +0400
Message-ID: <20090507155213.26361.12756.stgit@thinkpad>
References: <20090507155202.26361.38778.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.telecom.mipt.ru ([81.5.91.10]:60200 "EHLO
	relay1.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759925AbZEGQBM (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 7 May 2009 12:01:12 -0400
In-Reply-To: <20090507155202.26361.38778.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/debugger/dbexec.c          |    1 
 source/components/debugger/dbstats.c         |    7 -
 source/components/dispatcher/dsfield.c       |    6 -
 source/components/dispatcher/dsopcode.c      |   20 +--
 source/components/events/evregion.c          |   38 +-----
 source/components/events/evrgnini.c          |   12 --
 source/components/executer/excreate.c        |    7 -
 source/components/executer/exprep.c          |    6 -
 source/components/namespace/nsobject.c       |   33 -----
 source/components/utilities/utcopy.c         |    2 
 source/components/utilities/utdelete.c       |   38 ------
 source/components/utilities/utobject.c       |  164 ++++++++++++--------------
 source/include/acnamesp.h                    |    4 -
 source/include/acobject.h                    |   29 +----
 source/include/actypes.h                     |    1 
 source/include/acutils.h                     |    2 
 source/os_specific/service_layers/osunixxf.c |    2 
 17 files changed, 108 insertions(+), 264 deletions(-)


diff --git a/source/components/debugger/dbexec.c b/source/components/debugger/dbexec.c
index c0bdb84..18c5697 100644
--- a/source/components/debugger/dbexec.c
+++ b/source/components/debugger/dbexec.c
@@ -318,7 +318,6 @@ AcpiDbExecuteSetup (
     }
 }
 
-
 /*******************************************************************************
  *
  * FUNCTION:    AcpiDbExecutionWalk
diff --git a/source/components/debugger/dbstats.c b/source/components/debugger/dbstats.c
index 4ae3f65..eb0f601 100644
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
index 2d8e586..150651b 100644
--- a/source/components/dispatcher/dsfield.c
+++ b/source/components/dispatcher/dsfield.c
@@ -164,7 +164,6 @@ AcpiDsCreateBufferField (
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
     ACPI_OPERAND_OBJECT     *ObjDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc = NULL;
     UINT32                  Flags;
 
 
@@ -266,9 +265,8 @@ AcpiDsCreateBufferField (
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
index 3edbacc..352e5bb 100644
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
 
     Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
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
@@ -355,7 +351,7 @@ AcpiDsGetBankFieldArguments (
     /* Execute the AML code for the TermArg arguments */
 
     Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
-                ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
+                ObjDesc->BankField.AmlLength, ObjDesc->BankField.AmlStart);
     return_ACPI_STATUS (Status);
 }
 
@@ -477,8 +473,6 @@ AcpiDsGetRegionArguments (
 {
     ACPI_NAMESPACE_NODE     *Node;
     ACPI_STATUS             Status;
-    ACPI_OPERAND_OBJECT     *ExtraDesc;
-
 
     ACPI_FUNCTION_TRACE_PTR (DsGetRegionArguments, ObjDesc);
 
@@ -488,12 +482,6 @@ AcpiDsGetRegionArguments (
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
@@ -501,12 +489,12 @@ AcpiDsGetRegionArguments (
     ACPI_DEBUG_EXEC (AcpiUtDisplayInitPathname (ACPI_TYPE_REGION, Node, NULL));
 
     ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
-        AcpiUtGetNodeName (Node), ExtraDesc->Extra.AmlStart));
+        AcpiUtGetNodeName (Node), ObjDesc->Region.AmlStart));
 
     /* Execute the argument AML */
 
     Status = AcpiDsExecuteArguments (Node, AcpiNsGetParentNode (Node),
-                ExtraDesc->Extra.AmlLength, ExtraDesc->Extra.AmlStart);
+                ObjDesc->Region.AmlLength, ObjDesc->Region.AmlStart);
     return_ACPI_STATUS (Status);
 }
 
diff --git a/source/components/events/evregion.c b/source/components/events/evregion.c
index 0993f39..ca36784 100644
--- a/source/components/events/evregion.c
+++ b/source/components/events/evregion.c
@@ -298,20 +298,13 @@ AcpiEvExecuteRegMethod (
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
@@ -324,7 +317,7 @@ AcpiEvExecuteRegMethod (
         return_ACPI_STATUS (AE_NO_MEMORY);
     }
 
-    Info->PrefixNode = RegionObj2->Extra.Method_REG;
+    Info->PrefixNode = RegionObj->Region.Method_REG;
     Info->Pathname = NULL;
     Info->Parameters = Args;
     Info->Flags = ACPI_IGNORE_RETURN_VALUE;
@@ -406,19 +399,10 @@ AcpiEvAddressSpaceDispatch (
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
@@ -481,7 +465,7 @@ AcpiEvAddressSpaceDispatch (
         {
             RegionObj->Region.Flags |= AOPOBJ_SETUP_COMPLETE;
 
-            if (RegionObj2->Extra.RegionContext)
+            if (RegionObj->Region.RegionContext)
             {
                 /* The handler for this region was already installed */
 
@@ -493,7 +477,7 @@ AcpiEvAddressSpaceDispatch (
                  * Save the returned context for use in all accesses to
                  * this particular region
                  */
-                RegionObj2->Extra.RegionContext = RegionContext;
+                RegionObj->Region.RegionContext = RegionContext;
             }
         }
     }
@@ -522,7 +506,7 @@ AcpiEvAddressSpaceDispatch (
     /* Call the handler */
 
     Status = Handler (Function, Address, BitWidth, Value,
-        HandlerDesc->AddressSpace.Context, RegionObj2->Extra.RegionContext);
+        HandlerDesc->AddressSpace.Context, RegionObj->Region.RegionContext);
 
     if (ACPI_FAILURE (Status))
     {
@@ -568,19 +552,13 @@ AcpiEvDetachRegion(
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
 
@@ -1042,10 +1020,6 @@ AcpiEvInstallSpaceHandler (
             goto UnlockAndExit;
         }
 
-        /* Init new descriptor */
-
-        ObjDesc->Common.Type = (UINT8) Type;
-
         /* Attach the new object to the Node */
 
         Status = AcpiNsAttachObject (Node, ObjDesc, Type);
diff --git a/source/components/events/evrgnini.c b/source/components/events/evrgnini.c
index 187aebe..faa30cb 100644
--- a/source/components/events/evrgnini.c
+++ b/source/components/events/evrgnini.c
@@ -675,8 +675,6 @@ AcpiEvInitializeRegion (
     ACPI_STATUS             Status;
     ACPI_NAMESPACE_NODE     *MethodNode;
     ACPI_NAME               *RegNamePtr = (ACPI_NAME *) METHOD_NAME__REG;
-    ACPI_OPERAND_OBJECT     *RegionObj2;
-
 
     ACPI_FUNCTION_TRACE_U32 (EvInitializeRegion, AcpiNsLocked);
 
@@ -691,19 +689,13 @@ AcpiEvInitializeRegion (
         return_ACPI_STATUS (AE_OK);
     }
 
-    RegionObj2 = AcpiNsGetSecondaryObject (RegionObj);
-    if (!RegionObj2)
-    {
-        return_ACPI_STATUS (AE_NOT_EXIST);
-    }
-
     Node = AcpiNsGetParentNode (RegionObj->Region.Node);
     SpaceId = RegionObj->Region.SpaceId;
 
     /* Setup defaults */
 
     RegionObj->Region.Handler = NULL;
-    RegionObj2->Extra.Method_REG = NULL;
+    RegionObj->Region.Method_REG = NULL;
     RegionObj->Common.Flags &= ~(AOPOBJ_SETUP_COMPLETE);
     RegionObj->Common.Flags |= AOPOBJ_OBJECT_INITIALIZED;
 
@@ -718,7 +710,7 @@ AcpiEvInitializeRegion (
          * definition. This will be executed when the handler is attached
          * or removed
          */
-        RegionObj2->Extra.Method_REG = MethodNode;
+        RegionObj->Region.Method_REG = MethodNode;
     }
 
     /*
diff --git a/source/components/executer/excreate.c b/source/components/executer/excreate.c
index 55385a0..cd3ed75 100644
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
index c915361..67369b6 100644
--- a/source/components/executer/exprep.c
+++ b/source/components/executer/exprep.c
@@ -511,7 +511,6 @@ AcpiExPrepFieldValue (
     ACPI_CREATE_FIELD_INFO  *Info)
 {
     ACPI_OPERAND_OBJECT     *ObjDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc = NULL;
     UINT32                  Type;
     ACPI_STATUS             Status;
 
@@ -604,9 +603,8 @@ AcpiExPrepFieldValue (
          * opcode and operands -- since the BankValue
          * operands must be evaluated.
          */
-        SecondDesc                  = ObjDesc->Common.NextObject;
-        SecondDesc->Extra.AmlStart  = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Data;
-        SecondDesc->Extra.AmlLength = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Length;
+        ObjDesc->BankField.AmlStart  = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Data;
+        ObjDesc->BankField.AmlLength = ACPI_CAST_PTR (ACPI_PARSE_OBJECT, Info->DataRegisterNode)->Named.Length;
 
         break;
 
diff --git a/source/components/namespace/nsobject.c b/source/components/namespace/nsobject.c
index 53afe60..9191e79 100644
--- a/source/components/namespace/nsobject.c
+++ b/source/components/namespace/nsobject.c
@@ -373,39 +373,6 @@ AcpiNsGetAttachedObject (
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
diff --git a/source/components/utilities/utcopy.c b/source/components/utilities/utcopy.c
index 20a0e34..785c313 100644
--- a/source/components/utilities/utcopy.c
+++ b/source/components/utilities/utcopy.c
@@ -807,7 +807,7 @@ AcpiUtCopySimpleObject (
     /* Copy the entire source object over the destination object*/
 
     ACPI_MEMCPY ((char *) DestDesc, (char *) SourceDesc,
-                    sizeof (ACPI_OPERAND_OBJECT));
+                    AcpiUtOperandSize(DestDesc->Common.Type));
 
     /* Restore the saved fields */
 
diff --git a/source/components/utilities/utdelete.c b/source/components/utilities/utdelete.c
index 9dd05f6..f37147b 100644
--- a/source/components/utilities/utdelete.c
+++ b/source/components/utilities/utdelete.c
@@ -156,7 +156,6 @@ AcpiUtDeleteInternalObj (
 {
     void                    *ObjPointer = NULL;
     ACPI_OPERAND_OBJECT     *HandlerDesc;
-    ACPI_OPERAND_OBJECT     *SecondDesc;
     ACPI_OPERAND_OBJECT     *NextDesc;
 
 
@@ -306,9 +305,6 @@ AcpiUtDeleteInternalObj (
         ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS,
             "***** Region %p\n", Object));
 
-        SecondDesc = AcpiNsGetSecondaryObject (Object);
-        if (SecondDesc)
-        {
             /*
              * Free the RegionContext if and only if the handler is one of the
              * default handlers -- and therefore, we created the context object
@@ -327,46 +323,14 @@ AcpiUtDeleteInternalObj (
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
index 4d2c64c..e6caba7 100644
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
@@ -443,54 +406,6 @@ AcpiUtValidInternalObject (
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
@@ -525,6 +440,79 @@ AcpiUtDeleteObjectDesc (
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
index 2aa042a..b2a136c 100644
--- a/source/include/acnamesp.h
+++ b/source/include/acnamesp.h
@@ -385,10 +385,6 @@ ACPI_OPERAND_OBJECT *
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
index a82e07d..c78696b 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -275,6 +275,10 @@ typedef struct acpi_object_region
     union acpi_operand_object       *Next;
     ACPI_PHYSICAL_ADDRESS           Address;
     UINT32                          Length;
+    ACPI_NAMESPACE_NODE             *Method_REG;        /* _REG method for this region (if any) */
+    void                            *RegionContext;     /* Region-specific data */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_REGION;
 
@@ -406,6 +410,8 @@ typedef struct acpi_object_bank_field
     ACPI_COMMON_FIELD_INFO
     union acpi_operand_object       *RegionObj;         /* Containing OpRegion object */
     union acpi_operand_object       *BankObj;           /* BankSelect Register object */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_BANK_FIELD;
 
@@ -432,6 +438,8 @@ typedef struct acpi_object_buffer_field
     ACPI_OBJECT_COMMON_HEADER
     ACPI_COMMON_FIELD_INFO
     union acpi_operand_object       *BufferObj;         /* Containing Buffer object */
+    UINT8                           *AmlStart;
+    UINT32                          AmlLength;
 
 } ACPI_OBJECT_BUFFER_FIELD;
 
@@ -511,25 +519,6 @@ typedef enum
 
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
@@ -570,7 +559,6 @@ typedef union acpi_operand_object
     ACPI_OBJECT_NOTIFY_HANDLER          Notify;
     ACPI_OBJECT_ADDR_HANDLER            AddressSpace;
     ACPI_OBJECT_REFERENCE               Reference;
-    ACPI_OBJECT_EXTRA                   Extra;
     ACPI_OBJECT_DATA                    Data;
 
     /*
@@ -582,7 +570,6 @@ typedef union acpi_operand_object
 
 } ACPI_OPERAND_OBJECT;
 
-
 /******************************************************************************
  *
  * ACPI_DESCRIPTOR - objects that share a common descriptor identifier
diff --git a/source/include/actypes.h b/source/include/actypes.h
index 9885f8a..51111ff 100644
--- a/source/include/actypes.h
+++ b/source/include/actypes.h
@@ -669,7 +669,6 @@ typedef UINT32                          ACPI_OBJECT_TYPE;
  * These are special object types that never appear in
  * a Namespace node, only in an ACPI_OPERAND_OBJECT
  */
-#define ACPI_TYPE_LOCAL_EXTRA           0x1C
 #define ACPI_TYPE_LOCAL_DATA            0x1D
 
 #define ACPI_TYPE_LOCAL_MAX             0x1D
diff --git a/source/include/acutils.h b/source/include/acutils.h
index 5573754..b66d3d1 100644
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
diff --git a/source/os_specific/service_layers/osunixxf.c b/source/os_specific/service_layers/osunixxf.c
index b430e83..cd9c5d5 100644
--- a/source/os_specific/service_layers/osunixxf.c
+++ b/source/os_specific/service_layers/osunixxf.c
@@ -575,6 +575,8 @@ AcpiOsDeleteSemaphore (
         return (AE_BAD_PARAMETER);
     }
 
+    AcpiOsFree(Sem);
+
     return (AE_OK);
 }
 

