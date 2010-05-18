From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPICA: Remove use of caches in controlled way
Date: Wed, 19 May 2010 00:29:25 +0400
Message-ID: <20100518202925.30221.40122.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:46754 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab0ERU31 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:29:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/utilities/utcache.c |   99 +++++----------------------------
 1 files changed, 14 insertions(+), 85 deletions(-)


diff --git a/source/components/utilities/utcache.c b/source/components/utilities/utcache.c
index 2cee9a1..bdc3ac9 100644
--- a/source/components/utilities/utcache.c
+++ b/source/components/utilities/utcache.c
@@ -287,49 +287,15 @@ AcpiOsReleaseObject (
     ACPI_MEMORY_LIST        *Cache,
     void                    *Object)
 {
-    ACPI_STATUS             Status;
-
-
     ACPI_FUNCTION_ENTRY ();
 
-
     if (!Cache || !Object)
     {
         return (AE_BAD_PARAMETER);
     }
 
-    /* If cache is full, just free this object */
-
-    if (Cache->CurrentDepth >= Cache->MaxDepth)
-    {
-        ACPI_FREE (Object);
-        ACPI_MEM_TRACKING (Cache->TotalFreed++);
-    }
-
-    /* Otherwise put this object back into the cache */
-
-    else
-    {
-        Status = AcpiUtAcquireMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (Status);
-        }
-
-        /* Mark the object as cached */
-
-        ACPI_MEMSET (Object, 0xCA, Cache->ObjectSize);
-        ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_CACHED);
-
-        /* Put the object at the head of the cache list */
-
-        * (ACPI_CAST_INDIRECT_PTR (char,
-            &(((char *) Object)[Cache->LinkOffset]))) = Cache->ListHead;
-        Cache->ListHead = Object;
-        Cache->CurrentDepth++;
-
-        (void) AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-    }
+    ACPI_FREE (Object);
+    ACPI_MEM_TRACKING (Cache->TotalFreed++);
 
     return (AE_OK);
 }
@@ -353,8 +319,6 @@ AcpiOsAcquireObject (
     ACPI_MEMORY_LIST        *Cache)
 {
     ACPI_STATUS             Status;
-    void                    *Object;
-
 
     ACPI_FUNCTION_NAME (OsAcquireObject);
 
@@ -372,61 +336,26 @@ AcpiOsAcquireObject (
 
     ACPI_MEM_TRACKING (Cache->Requests++);
 
-    /* Check the cache first */
+    /* The cache is empty, create a new object */
 
-    if (Cache->ListHead)
-    {
-        /* There is an object available, use it */
-
-        Object = Cache->ListHead;
-        Cache->ListHead = *(ACPI_CAST_INDIRECT_PTR (char,
-                                &(((char *) Object)[Cache->LinkOffset])));
-
-        Cache->CurrentDepth--;
-
-        ACPI_MEM_TRACKING (Cache->Hits++);
-        ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
-            "Object %p from %s cache\n", Object, Cache->ListName));
-
-        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (NULL);
-        }
-
-        /* Clear (zero) the previously used Object */
-
-        ACPI_MEMSET (Object, 0, Cache->ObjectSize);
-    }
-    else
-    {
-        /* The cache is empty, create a new object */
-
-        ACPI_MEM_TRACKING (Cache->TotalAllocated++);
+    ACPI_MEM_TRACKING (Cache->TotalAllocated++);
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
-        if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
-        {
-            Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
-        }
+    if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
+    {
+        Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
+    }
 #endif
 
-        /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
+    /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
 
-        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
-        if (ACPI_FAILURE (Status))
-        {
-            return (NULL);
-        }
-
-        Object = ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
-        if (!Object)
-        {
-            return (NULL);
-        }
+    Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
+    if (ACPI_FAILURE (Status))
+    {
+        return (NULL);
     }
 
-    return (Object);
+    return ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
 }
 #endif /* ACPI_USE_LOCAL_CACHE */
 

