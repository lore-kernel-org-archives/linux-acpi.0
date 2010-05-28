From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/4] ACPICA: Remove calls to cache code
Date: Fri, 28 May 2010 17:57:03 +0400
Message-ID: <20100528135703.26498.35225.stgit@thinkpad>
References: <20100528135648.26498.61828.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:34643 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab0E1N5F (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 May 2010 09:57:05 -0400
In-Reply-To: <20100528135648.26498.61828.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org, devel@acpica.org

Remove the object cache code.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


diff --git a/source/components/debugger/dbexec.c b/source/components/debugger/dbexec.c
index 3555e8f..6e8d618 100644
--- a/source/components/debugger/dbexec.c
+++ b/source/components/debugger/dbexec.c
@@ -138,10 +138,6 @@ static void
 AcpiDbExecuteSetup (
     ACPI_DB_METHOD_INFO     *Info);
 
-static UINT32
-AcpiDbGetOutstandingAllocations (
-    void);
-
 static void ACPI_SYSTEM_XFACE
 AcpiDbMethodThread (
     void                    *Context);
@@ -320,48 +316,6 @@ AcpiDbExecuteSetup (
 }
 
 
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-UINT32
-AcpiDbGetCacheInfo (
-    ACPI_MEMORY_LIST        *Cache)
-{
-
-    return (Cache->TotalAllocated - Cache->TotalFreed - Cache->CurrentDepth);
-}
-#endif
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiDbGetOutstandingAllocations
- *
- * PARAMETERS:  None
- *
- * RETURN:      Current global allocation count minus cache entries
- *
- * DESCRIPTION: Determine the current number of "outstanding" allocations --
- *              those allocations that have not been freed and also are not
- *              in one of the various object caches.
- *
- ******************************************************************************/
-
-static UINT32
-AcpiDbGetOutstandingAllocations (
-    void)
-{
-    UINT32                  Outstanding = 0;
-
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-
-    Outstanding += AcpiDbGetCacheInfo (AcpiGbl_StateCache);
-    Outstanding += AcpiDbGetCacheInfo (AcpiGbl_PsNodeCache);
-    Outstanding += AcpiDbGetCacheInfo (AcpiGbl_PsNodeExtCache);
-    Outstanding += AcpiDbGetCacheInfo (AcpiGbl_OperandCache);
-#endif
-
-    return (Outstanding);
-}
-
-
 /*******************************************************************************
  *
  * FUNCTION:    AcpiDbExecutionWalk
@@ -439,17 +393,6 @@ AcpiDbExecute (
     ACPI_BUFFER             ReturnObj;
     char                    *NameString;
 
-
-#ifdef ACPI_DEBUG_OUTPUT
-    UINT32                  PreviousAllocations;
-    UINT32                  Allocations;
-
-
-    /* Memory allocation tracking */
-
-    PreviousAllocations = AcpiDbGetOutstandingAllocations ();
-#endif
-
     if (*Name == '*')
     {
         (void) AcpiWalkNamespace (ACPI_TYPE_METHOD, ACPI_ROOT_OBJECT,
@@ -486,22 +429,6 @@ AcpiDbExecute (
      */
     AcpiOsSleep ((UINT64) 10);
 
-
-#ifdef ACPI_DEBUG_OUTPUT
-
-    /* Memory allocation tracking */
-
-    Allocations = AcpiDbGetOutstandingAllocations () - PreviousAllocations;
-
-    AcpiDbSetOutputDestination (ACPI_DB_DUPLICATE_OUTPUT);
-
-    if (Allocations > 0)
-    {
-        AcpiOsPrintf ("Outstanding: 0x%X allocations after execution\n",
-                        Allocations);
-    }
-#endif
-
     if (ACPI_FAILURE (Status))
     {
         AcpiOsPrintf ("Execution of %s failed with status %s\n",
diff --git a/source/components/debugger/dbstats.c b/source/components/debugger/dbstats.c
index ace8263..4039a4f 100644
--- a/source/components/debugger/dbstats.c
+++ b/source/components/debugger/dbstats.c
@@ -189,9 +189,6 @@ static void
 AcpiDbListInfo (
     ACPI_MEMORY_LIST        *List)
 {
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-    UINT32                  Outstanding;
-#endif
 
     AcpiOsPrintf ("\n%s\n", List->ListName);
 
@@ -207,41 +204,6 @@ AcpiDbListInfo (
             (List->CurrentDepth * List->ObjectSize));
     }
 
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-    if (List->MaxDepth > 0)
-    {
-        AcpiOsPrintf (
-            "    Cache: [Requests Hits Misses ObjSize]             %8.2X %8.2X %8.2X %8.2X\n",
-            List->Requests,
-            List->Hits,
-            List->Requests - List->Hits,
-            List->ObjectSize);
-    }
-
-    Outstanding = AcpiDbGetCacheInfo (List);
-
-    if (List->ObjectSize)
-    {
-        AcpiOsPrintf (
-            "    Mem:   [Alloc    Free Max    CurSize Outstanding] %8.2X %8.2X %8.2X %8.2X %8.2X\n",
-            List->TotalAllocated,
-            List->TotalFreed,
-            List->MaxOccupied,
-            Outstanding * List->ObjectSize,
-            Outstanding);
-    }
-    else
-    {
-        AcpiOsPrintf (
-            "    Mem:   [Alloc Free Max CurSize Outstanding Total] %8.2X %8.2X %8.2X %8.2X %8.2X %8.2X\n",
-            List->TotalAllocated,
-            List->TotalFreed,
-            List->MaxOccupied,
-            List->CurrentTotalSize,
-            Outstanding,
-            List->TotalSize);
-    }
-#endif
 }
 #endif
 
diff --git a/source/components/namespace/nsalloc.c b/source/components/namespace/nsalloc.c
index a879fc1..d7997fe 100644
--- a/source/components/namespace/nsalloc.c
+++ b/source/components/namespace/nsalloc.c
@@ -150,7 +150,7 @@ AcpiNsCreateNode (
     ACPI_FUNCTION_TRACE (NsCreateNode);
 
 
-    Node = AcpiOsAcquireObject (AcpiGbl_NamespaceCache);
+    Node = ACPI_ALLOCATE_ZEROED (sizeof (ACPI_NAMESPACE_NODE));
     if (!Node)
     {
         return_PTR (NULL);
@@ -223,7 +223,7 @@ AcpiNsDeleteNode (
 
     /* Now we can delete the node */
 
-    (void) AcpiOsReleaseObject (AcpiGbl_NamespaceCache, Node);
+    ACPI_FREE(Node);
 
     ACPI_MEM_TRACKING (AcpiGbl_NsNodeList->TotalFreed++);
     ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS, "Node %p, Remaining %X\n",
@@ -285,7 +285,8 @@ AcpiNsRemoveNode (
 
     /* Delete the node and any attached objects */
 
-    AcpiNsDeleteNode (Node);
+    AcpiNsDetachObject (Node);
+    ACPI_FREE (Node);
     return_VOID;
 }
 
diff --git a/source/components/parser/psutils.c b/source/components/parser/psutils.c
index 17be364..2fa58c1 100644
--- a/source/components/parser/psutils.c
+++ b/source/components/parser/psutils.c
@@ -232,13 +232,13 @@ AcpiPsAllocOp (
     {
         /* The generic op (default) is by far the most common (16 to 1) */
 
-        Op = AcpiOsAcquireObject (AcpiGbl_PsNodeCache);
+        Op = ACPI_ALLOCATE_ZEROED (sizeof (ACPI_PARSE_OBJ_COMMON));
     }
     else
     {
         /* Extended parseop */
 
-        Op = AcpiOsAcquireObject (AcpiGbl_PsNodeExtCache);
+        Op = ACPI_ALLOCATE_ZEROED (sizeof (ACPI_PARSE_OBJ_NAMED));
     }
 
     /* Initialize the Op */
@@ -280,11 +280,11 @@ AcpiPsFreeOp (
 
     if (Op->Common.Flags & ACPI_PARSEOP_GENERIC)
     {
-        (void) AcpiOsReleaseObject (AcpiGbl_PsNodeCache, Op);
+        ACPI_FREE (Op);
     }
     else
     {
-        (void) AcpiOsReleaseObject (AcpiGbl_PsNodeExtCache, Op);
+        ACPI_FREE (Op);
     }
 }
 
diff --git a/source/components/utilities/utalloc.c b/source/components/utilities/utalloc.c
index f2478b2..0f3b460 100644
--- a/source/components/utilities/utalloc.c
+++ b/source/components/utilities/utalloc.c
@@ -139,48 +139,8 @@ ACPI_STATUS
 AcpiUtCreateCaches (
     void)
 {
-    ACPI_STATUS             Status;
-
-
-    /* Object Caches, for frequently used objects */
-
-    Status = AcpiOsCreateCache ("Acpi-Namespace", sizeof (ACPI_NAMESPACE_NODE),
-                ACPI_MAX_NAMESPACE_CACHE_DEPTH, &AcpiGbl_NamespaceCache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    Status = AcpiOsCreateCache ("Acpi-State", sizeof (ACPI_GENERIC_STATE),
-                ACPI_MAX_STATE_CACHE_DEPTH, &AcpiGbl_StateCache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    Status = AcpiOsCreateCache ("Acpi-Parse", sizeof (ACPI_PARSE_OBJ_COMMON),
-                ACPI_MAX_PARSE_CACHE_DEPTH, &AcpiGbl_PsNodeCache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    Status = AcpiOsCreateCache ("Acpi-ParseExt", sizeof (ACPI_PARSE_OBJ_NAMED),
-                ACPI_MAX_EXTPARSE_CACHE_DEPTH, &AcpiGbl_PsNodeExtCache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    Status = AcpiOsCreateCache ("Acpi-Operand", sizeof (ACPI_OPERAND_OBJECT),
-                ACPI_MAX_OBJECT_CACHE_DEPTH, &AcpiGbl_OperandCache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
+    ACPI_STATUS             Status;
 
     /* Memory allocation lists */
 
@@ -227,25 +187,6 @@ AcpiUtDeleteCaches (
         ACPI_STRCPY (Buffer, "MEMORY");
         (void) AcpiDbDisplayStatistics (Buffer);
     }
-#endif
-
-    (void) AcpiOsDeleteCache (AcpiGbl_NamespaceCache);
-    AcpiGbl_NamespaceCache = NULL;
-
-    (void) AcpiOsDeleteCache (AcpiGbl_StateCache);
-    AcpiGbl_StateCache = NULL;
-
-    (void) AcpiOsDeleteCache (AcpiGbl_OperandCache);
-    AcpiGbl_OperandCache = NULL;
-
-    (void) AcpiOsDeleteCache (AcpiGbl_PsNodeCache);
-    AcpiGbl_PsNodeCache = NULL;
-
-    (void) AcpiOsDeleteCache (AcpiGbl_PsNodeExtCache);
-    AcpiGbl_PsNodeExtCache = NULL;
-
-
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
     /* Debug only - display leftover memory allocation, if any */
 
diff --git a/source/components/utilities/utcache.c b/source/components/utilities/utcache.c
deleted file mode 100644
index bdc3ac9..0000000
--- a/source/components/utilities/utcache.c
+++ /dev/null
@@ -1,362 +0,0 @@
-/******************************************************************************
- *
- * Module Name: utcache - local cache allocation routines
- *
- *****************************************************************************/
-
-/******************************************************************************
- *
- * 1. Copyright Notice
- *
- * Some or all of this work - Copyright (c) 1999 - 2010, Intel Corp.
- * All rights reserved.
- *
- * 2. License
- *
- * 2.1. This is your license from Intel Corp. under its intellectual property
- * rights.  You may have additional license terms from the party that provided
- * you this software, covering your right to use that party's intellectual
- * property rights.
- *
- * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
- * copy of the source code appearing in this file ("Covered Code") an
- * irrevocable, perpetual, worldwide license under Intel's copyrights in the
- * base code distributed originally by Intel ("Original Intel Code") to copy,
- * make derivatives, distribute, use and display any portion of the Covered
- * Code in any form, with the right to sublicense such rights; and
- *
- * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
- * license (with the right to sublicense), under only those claims of Intel
- * patents that are infringed by the Original Intel Code, to make, use, sell,
- * offer to sell, and import the Covered Code and derivative works thereof
- * solely to the minimum extent necessary to exercise the above copyright
- * license, and in no event shall the patent license extend to any additions
- * to or modifications of the Original Intel Code.  No other license or right
- * is granted directly or by implication, estoppel or otherwise;
- *
- * The above copyright and patent license is granted only if the following
- * conditions are met:
- *
- * 3. Conditions
- *
- * 3.1. Redistribution of Source with Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification with rights to further distribute source must include
- * the above Copyright Notice, the above License, this list of Conditions,
- * and the following Disclaimer and Export Compliance provision.  In addition,
- * Licensee must cause all Covered Code to which Licensee contributes to
- * contain a file documenting the changes Licensee made to create that Covered
- * Code and the date of any change.  Licensee must include in that file the
- * documentation of any changes made by any predecessor Licensee.  Licensee
- * must include a prominent statement that the modification is derived,
- * directly or indirectly, from Original Intel Code.
- *
- * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
- * Redistribution of source code of any substantial portion of the Covered
- * Code or modification without rights to further distribute source must
- * include the following Disclaimer and Export Compliance provision in the
- * documentation and/or other materials provided with distribution.  In
- * addition, Licensee may not authorize further sublicense of source of any
- * portion of the Covered Code, and must include terms to the effect that the
- * license from Licensee to its licensee is limited to the intellectual
- * property embodied in the software Licensee provides to its licensee, and
- * not to intellectual property embodied in modifications its licensee may
- * make.
- *
- * 3.3. Redistribution of Executable. Redistribution in executable form of any
- * substantial portion of the Covered Code or modification must reproduce the
- * above Copyright Notice, and the following Disclaimer and Export Compliance
- * provision in the documentation and/or other materials provided with the
- * distribution.
- *
- * 3.4. Intel retains all right, title, and interest in and to the Original
- * Intel Code.
- *
- * 3.5. Neither the name Intel nor any other trademark owned or controlled by
- * Intel shall be used in advertising or otherwise to promote the sale, use or
- * other dealings in products derived from or relating to the Covered Code
- * without prior written authorization from Intel.
- *
- * 4. Disclaimer and Export Compliance
- *
- * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
- * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
- * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASSISTANCE,
- * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE ANY
- * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIMS ANY
- * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
- * PARTICULAR PURPOSE.
- *
- * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
- * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
- * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
- * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
- * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
- * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIMITATIONS
- * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
- * LIMITED REMEDY.
- *
- * 4.3. Licensee shall not export, either directly or indirectly, any of this
- * software or system incorporating such software without first obtaining any
- * required license or other approval from the U. S. Department of Commerce or
- * any other agency or department of the United States Government.  In the
- * event Licensee exports any such software from the United States or
- * re-exports any such software from a foreign destination, Licensee shall
- * ensure that the distribution and export/re-export of the software is in
- * compliance with all laws, regulations, orders, or other restrictions of the
- * U.S. Export Administration Regulations. Licensee agrees that neither it nor
- * any of its subsidiaries will export/re-export any technical data, process,
- * software, or service, directly or indirectly, to any country for which the
- * United States government or any agency thereof requires an export license,
- * other governmental approval, or letter of assurance, without first obtaining
- * such license, approval or letter.
- *
- *****************************************************************************/
-
-#define __UTCACHE_C__
-
-#include "acpi.h"
-#include "accommon.h"
-
-#define _COMPONENT          ACPI_UTILITIES
-        ACPI_MODULE_NAME    ("utcache")
-
-
-#ifdef ACPI_USE_LOCAL_CACHE
-/*******************************************************************************
- *
- * FUNCTION:    AcpiOsCreateCache
- *
- * PARAMETERS:  CacheName       - Ascii name for the cache
- *              ObjectSize      - Size of each cached object
- *              MaxDepth        - Maximum depth of the cache (in objects)
- *              ReturnCache     - Where the new cache object is returned
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Create a cache object
- *
- ******************************************************************************/
-
-ACPI_STATUS
-AcpiOsCreateCache (
-    char                    *CacheName,
-    UINT16                  ObjectSize,
-    UINT16                  MaxDepth,
-    ACPI_MEMORY_LIST        **ReturnCache)
-{
-    ACPI_MEMORY_LIST        *Cache;
-
-
-    ACPI_FUNCTION_ENTRY ();
-
-
-    if (!CacheName || !ReturnCache || (ObjectSize < 16))
-    {
-        return (AE_BAD_PARAMETER);
-    }
-
-    /* Create the cache object */
-
-    Cache = AcpiOsAllocate (sizeof (ACPI_MEMORY_LIST));
-    if (!Cache)
-    {
-        return (AE_NO_MEMORY);
-    }
-
-    /* Populate the cache object and return it */
-
-    ACPI_MEMSET (Cache, 0, sizeof (ACPI_MEMORY_LIST));
-    Cache->LinkOffset = 8;
-    Cache->ListName   = CacheName;
-    Cache->ObjectSize = ObjectSize;
-    Cache->MaxDepth   = MaxDepth;
-
-    *ReturnCache = Cache;
-    return (AE_OK);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiOsPurgeCache
- *
- * PARAMETERS:  Cache           - Handle to cache object
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Free all objects within the requested cache.
- *
- ******************************************************************************/
-
-ACPI_STATUS
-AcpiOsPurgeCache (
-    ACPI_MEMORY_LIST        *Cache)
-{
-    char                    *Next;
-    ACPI_STATUS             Status;
-
-
-    ACPI_FUNCTION_ENTRY ();
-
-
-    if (!Cache)
-    {
-        return (AE_BAD_PARAMETER);
-    }
-
-    Status = AcpiUtAcquireMutex (ACPI_MTX_CACHES);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    /* Walk the list of objects in this cache */
-
-    while (Cache->ListHead)
-    {
-        /* Delete and unlink one cached state object */
-
-        Next = *(ACPI_CAST_INDIRECT_PTR (char,
-                    &(((char *) Cache->ListHead)[Cache->LinkOffset])));
-        ACPI_FREE (Cache->ListHead);
-
-        Cache->ListHead = Next;
-        Cache->CurrentDepth--;
-    }
-
-    (void) AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-    return (AE_OK);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiOsDeleteCache
- *
- * PARAMETERS:  Cache           - Handle to cache object
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Free all objects within the requested cache and delete the
- *              cache object.
- *
- ******************************************************************************/
-
-ACPI_STATUS
-AcpiOsDeleteCache (
-    ACPI_MEMORY_LIST        *Cache)
-{
-    ACPI_STATUS             Status;
-
-
-    ACPI_FUNCTION_ENTRY ();
-
-
-   /* Purge all objects in the cache */
-
-    Status = AcpiOsPurgeCache (Cache);
-    if (ACPI_FAILURE (Status))
-    {
-        return (Status);
-    }
-
-    /* Now we can delete the cache object */
-
-    AcpiOsFree (Cache);
-    return (AE_OK);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiOsReleaseObject
- *
- * PARAMETERS:  Cache       - Handle to cache object
- *              Object      - The object to be released
- *
- * RETURN:      None
- *
- * DESCRIPTION: Release an object to the specified cache.  If cache is full,
- *              the object is deleted.
- *
- ******************************************************************************/
-
-ACPI_STATUS
-AcpiOsReleaseObject (
-    ACPI_MEMORY_LIST        *Cache,
-    void                    *Object)
-{
-    ACPI_FUNCTION_ENTRY ();
-
-    if (!Cache || !Object)
-    {
-        return (AE_BAD_PARAMETER);
-    }
-
-    ACPI_FREE (Object);
-    ACPI_MEM_TRACKING (Cache->TotalFreed++);
-
-    return (AE_OK);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    AcpiOsAcquireObject
- *
- * PARAMETERS:  Cache           - Handle to cache object
- *
- * RETURN:      the acquired object.  NULL on error
- *
- * DESCRIPTION: Get an object from the specified cache.  If cache is empty,
- *              the object is allocated.
- *
- ******************************************************************************/
-
-void *
-AcpiOsAcquireObject (
-    ACPI_MEMORY_LIST        *Cache)
-{
-    ACPI_STATUS             Status;
-
-    ACPI_FUNCTION_NAME (OsAcquireObject);
-
-
-    if (!Cache)
-    {
-        return (NULL);
-    }
-
-    Status = AcpiUtAcquireMutex (ACPI_MTX_CACHES);
-    if (ACPI_FAILURE (Status))
-    {
-        return (NULL);
-    }
-
-    ACPI_MEM_TRACKING (Cache->Requests++);
-
-    /* The cache is empty, create a new object */
-
-    ACPI_MEM_TRACKING (Cache->TotalAllocated++);
-
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
-    if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
-    {
-        Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
-    }
-#endif
-
-    /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
-
-    Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-    if (ACPI_FAILURE (Status))
-    {
-        return (NULL);
-    }
-
-    return ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
-}
-#endif /* ACPI_USE_LOCAL_CACHE */
-
-
diff --git a/source/components/utilities/utobject.c b/source/components/utilities/utobject.c
index 0a9f1e7..fcc0674 100644
--- a/source/components/utilities/utobject.c
+++ b/source/components/utilities/utobject.c
@@ -506,7 +506,7 @@ AcpiUtAllocateObjectDescDbg (
     ACPI_FUNCTION_TRACE (UtAllocateObjectDescDbg);
 
 
-    Object = AcpiOsAcquireObject (AcpiGbl_OperandCache);
+    Object = ACPI_ALLOCATE_ZEROED (sizeof (ACPI_OPERAND_OBJECT));
     if (!Object)
     {
         ACPI_ERROR ((ModuleName, LineNumber,
@@ -555,7 +555,7 @@ AcpiUtDeleteObjectDesc (
         return_VOID;
     }
 
-    (void) AcpiOsReleaseObject (AcpiGbl_OperandCache, Object);
+    ACPI_FREE (Object);
     return_VOID;
 }
 
diff --git a/source/components/utilities/utstate.c b/source/components/utilities/utstate.c
index 08218d1..f9ab1a6 100644
--- a/source/components/utilities/utstate.c
+++ b/source/components/utilities/utstate.c
@@ -250,7 +250,7 @@ AcpiUtCreateGenericState (
     ACPI_FUNCTION_ENTRY ();
 
 
-    State = AcpiOsAcquireObject (AcpiGbl_StateCache);
+    State = ACPI_ALLOCATE_ZEROED (sizeof(ACPI_GENERIC_STATE));
     if (State)
     {
         /* Initialize */
@@ -462,7 +462,7 @@ AcpiUtDeleteGenericState (
 
     if (State)
     {
-        (void) AcpiOsReleaseObject (AcpiGbl_StateCache, State);
+        ACPI_FREE (State);
     }
     return_VOID;
 }
diff --git a/source/components/utilities/utxface.c b/source/components/utilities/utxface.c
index f59a08d..29607b6 100644
--- a/source/components/utilities/utxface.c
+++ b/source/components/utilities/utxface.c
@@ -423,13 +423,6 @@ AcpiInitializeObjects (
         }
     }
 
-    /*
-     * Empty the caches (delete the cached objects) on the assumption that
-     * the table load filled them up more than they will be at runtime --
-     * thus wasting non-paged memory.
-     */
-    Status = AcpiPurgeCachedObjects ();
-
     AcpiGbl_StartupFlags |= ACPI_INITIALIZED_OK;
     return_ACPI_STATUS (Status);
 }
@@ -702,33 +695,5 @@ AcpiInstallInitializationHandler (
 
 ACPI_EXPORT_SYMBOL (AcpiInstallInitializationHandler)
 
-
-/*****************************************************************************
- *
- * FUNCTION:    AcpiPurgeCachedObjects
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Empty all caches (delete the cached objects)
- *
- ****************************************************************************/
-
-ACPI_STATUS
-AcpiPurgeCachedObjects (
-    void)
-{
-    ACPI_FUNCTION_TRACE (AcpiPurgeCachedObjects);
-
-    (void) AcpiOsPurgeCache (AcpiGbl_StateCache);
-    (void) AcpiOsPurgeCache (AcpiGbl_OperandCache);
-    (void) AcpiOsPurgeCache (AcpiGbl_PsNodeCache);
-    (void) AcpiOsPurgeCache (AcpiGbl_PsNodeExtCache);
-    return_ACPI_STATUS (AE_OK);
-}
-
-ACPI_EXPORT_SYMBOL (AcpiPurgeCachedObjects)
-
 #endif /* ACPI_ASL_COMPILER */
 
diff --git a/source/include/acconfig.h b/source/include/acconfig.h
index 7aa4f47..4925105 100644
--- a/source/include/acconfig.h
+++ b/source/include/acconfig.h
@@ -144,14 +144,6 @@
  */
 #define ACPI_OS_NAME                    "Microsoft Windows NT"
 
-/* Maximum objects in the various object caches */
-
-#define ACPI_MAX_STATE_CACHE_DEPTH      96          /* State objects */
-#define ACPI_MAX_PARSE_CACHE_DEPTH      96          /* Parse tree objects */
-#define ACPI_MAX_EXTPARSE_CACHE_DEPTH   96          /* Parse tree objects */
-#define ACPI_MAX_OBJECT_CACHE_DEPTH     96          /* Interpreter operand objects */
-#define ACPI_MAX_NAMESPACE_CACHE_DEPTH  96          /* Namespace objects */
-
 /*
  * Should the subsystem abort the loading of an ACPI table if the
  * table checksum is incorrect?
diff --git a/source/include/acglobal.h b/source/include/acglobal.h
index ec3351e..fdfacc5 100644
--- a/source/include/acglobal.h
+++ b/source/include/acglobal.h
@@ -294,14 +294,6 @@ ACPI_EXTERN ACPI_RW_LOCK                AcpiGbl_NamespaceRwLock;
  *
  ****************************************************************************/
 
-/* Object caches */
-
-ACPI_EXTERN ACPI_CACHE_T               *AcpiGbl_NamespaceCache;
-ACPI_EXTERN ACPI_CACHE_T               *AcpiGbl_StateCache;
-ACPI_EXTERN ACPI_CACHE_T               *AcpiGbl_PsNodeCache;
-ACPI_EXTERN ACPI_CACHE_T               *AcpiGbl_PsNodeExtCache;
-ACPI_EXTERN ACPI_CACHE_T               *AcpiGbl_OperandCache;
-
 /* Global handlers */
 
 ACPI_EXTERN ACPI_OBJECT_NOTIFY_HANDLER  AcpiGbl_DeviceNotify;
diff --git a/source/include/acobject.h b/source/include/acobject.h
index ebb656a..5c61567 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -546,17 +546,6 @@ typedef struct acpi_object_data
 
 } ACPI_OBJECT_DATA;
 
-
-/* Structure used when objects are cached for reuse */
-
-typedef struct acpi_object_cache_list
-{
-    ACPI_OBJECT_COMMON_HEADER
-    union acpi_operand_object       *Next;              /* Link for object cache and internal lists*/
-
-} ACPI_OBJECT_CACHE_LIST;
-
-
 /******************************************************************************
  *
  * ACPI_OPERAND_OBJECT Descriptor - a giant union of all of the above
@@ -589,7 +578,6 @@ typedef union acpi_operand_object
     ACPI_OBJECT_REFERENCE               Reference;
     ACPI_OBJECT_EXTRA                   Extra;
     ACPI_OBJECT_DATA                    Data;
-    ACPI_OBJECT_CACHE_LIST              Cache;
 
     /*
      * Add namespace node to union in order to simplify code that accepts both
diff --git a/source/include/acpiosxf.h b/source/include/acpiosxf.h
index 3a9da6c..4d2a554 100644
--- a/source/include/acpiosxf.h
+++ b/source/include/acpiosxf.h
@@ -283,35 +283,6 @@ AcpiOsGetPhysicalAddress (
     void                    *LogicalAddress,
     ACPI_PHYSICAL_ADDRESS   *PhysicalAddress);
 
-
-/*
- * Memory/Object Cache
- */
-ACPI_STATUS
-AcpiOsCreateCache (
-    char                    *CacheName,
-    UINT16                  ObjectSize,
-    UINT16                  MaxDepth,
-    ACPI_CACHE_T            **ReturnCache);
-
-ACPI_STATUS
-AcpiOsDeleteCache (
-    ACPI_CACHE_T            *Cache);
-
-ACPI_STATUS
-AcpiOsPurgeCache (
-    ACPI_CACHE_T            *Cache);
-
-void *
-AcpiOsAcquireObject (
-    ACPI_CACHE_T            *Cache);
-
-ACPI_STATUS
-AcpiOsReleaseObject (
-    ACPI_CACHE_T            *Cache,
-    void                    *Object);
-
-
 /*
  * Interrupt handlers
  */
diff --git a/source/include/actypes.h b/source/include/actypes.h
index 601e87e..dbab6d2 100644
--- a/source/include/actypes.h
+++ b/source/include/actypes.h
@@ -298,16 +298,6 @@ typedef UINT32                          ACPI_PHYSICAL_ADDRESS;
 #define ACPI_CPU_FLAGS                  ACPI_SIZE
 #endif
 
-/* Object returned from AcpiOsCreateCache */
-
-#ifndef ACPI_CACHE_T
-#ifdef ACPI_USE_LOCAL_CACHE
-#define ACPI_CACHE_T                    ACPI_MEMORY_LIST
-#else
-#define ACPI_CACHE_T                    void *
-#endif
-#endif
-
 /*
  * Synchronization objects - Mutexes, Semaphores, and SpinLocks
  */
diff --git a/source/include/platform/acenv.h b/source/include/platform/acenv.h
index 0567a00..398d764 100644
--- a/source/include/platform/acenv.h
+++ b/source/include/platform/acenv.h
@@ -159,17 +159,10 @@
 #define ACPI_DBG_TRACK_ALLOCATIONS
 #endif
 
-/* Linkable ACPICA library */
-
-#ifdef ACPI_LIBRARY
-#define ACPI_USE_LOCAL_CACHE
-#endif
-
 /* Common for all ACPICA applications */
 
 #ifdef ACPI_APPLICATION
 #define ACPI_USE_SYSTEM_CLIBRARY
-#define ACPI_USE_LOCAL_CACHE
 #endif
 
 /* Common debug support */
diff --git a/source/include/platform/aclinux.h b/source/include/platform/aclinux.h
index 9009689..1c1336b 100644
--- a/source/include/platform/aclinux.h
+++ b/source/include/platform/aclinux.h
@@ -144,7 +144,6 @@
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
-#define ACPI_CACHE_T                struct kmem_cache
 #define ACPI_SPINLOCK               spinlock_t *
 #define ACPI_CPU_FLAGS              unsigned long
 #define ACPI_THREAD_ID              struct task_struct *
diff --git a/source/include/platform/acos2.h b/source/include/platform/acos2.h
index 90e6b2e..86fcb0c 100644
--- a/source/include/platform/acos2.h
+++ b/source/include/platform/acos2.h
@@ -165,7 +165,6 @@ unsigned short OSPMReleaseGlobalLock (void *);
 #endif
 
 #ifndef ACPI_ASL_COMPILER
-#define ACPI_USE_LOCAL_CACHE
 #undef ACPI_DEBUGGER
 #endif
 
diff --git a/source/tools/acpisrc/astable.c b/source/tools/acpisrc/astable.c
index 5a96f06..ee37a03 100644
--- a/source/tools/acpisrc/astable.c
+++ b/source/tools/acpisrc/astable.c
@@ -253,7 +253,6 @@ ACPI_TYPED_IDENTIFIER_TABLE           AcpiIdentifiers[] = {
     {"ACPI_BIT_REGISTER_INFO",              SRC_TYPE_STRUCT},
     {"ACPI_BUFFER",                         SRC_TYPE_STRUCT},
     {"ACPI_BUS_ATTRIBUTE",                  SRC_TYPE_STRUCT},
-    {"ACPI_CACHE_T",                        SRC_TYPE_SIMPLE},
     {"ACPI_COMMON_FACS",                    SRC_TYPE_STRUCT},
     {"ACPI_COMMON_STATE",                   SRC_TYPE_STRUCT},
     {"ACPI_COMMON_DESCRIPTOR",              SRC_TYPE_STRUCT},
@@ -335,7 +334,6 @@ ACPI_TYPED_IDENTIFIER_TABLE           AcpiIdentifiers[] = {
     {"ACPI_OBJECT_BANK_FIELD",              SRC_TYPE_STRUCT},
     {"ACPI_OBJECT_BUFFER",                  SRC_TYPE_STRUCT},
     {"ACPI_OBJECT_BUFFER_FIELD",            SRC_TYPE_STRUCT},
-    {"ACPI_OBJECT_CACHE_LIST",              SRC_TYPE_STRUCT},
     {"ACPI_OBJECT_COMMON",                  SRC_TYPE_STRUCT},
     {"ACPI_OBJECT_DATA",                    SRC_TYPE_STRUCT},
     {"ACPI_OBJECT_DEVICE",                  SRC_TYPE_STRUCT},

