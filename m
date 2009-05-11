From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 1/4] ACPICA: Remove use of caches in controlled way
Date: Mon, 11 May 2009 16:14:27 +0800
Message-ID: <1242029667.4641.31.camel@minggr.sh.intel.com>
References: <20090507155202.26361.38778.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4a4ORlU/FC32+E25crxF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42739 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbZEKIba (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 04:31:30 -0400
In-Reply-To: <20090507155202.26361.38778.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>


--=-4a4ORlU/FC32+E25crxF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Alexey

The attachment are the linuxized version of your patches.
I added another patch (the 4th) to remove linux specific cache code.

The patches are applied on top of linux-acpi-2.6/acpica branch.

Do you have any suggestion what data I should collect to verify if these
patches have a performance gain?

Lin Ming

On Thu, 2009-05-07 at 23:52 +0800, Alexey Starikovskiy wrote:
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  source/components/utilities/utcache.c |   99 +++++----------------------------
>  1 files changed, 14 insertions(+), 85 deletions(-)
> 
> 
> diff --git a/source/components/utilities/utcache.c b/source/components/utilities/utcache.c
> index aabc0a2..d08d520 100644
> --- a/source/components/utilities/utcache.c
> +++ b/source/components/utilities/utcache.c
> @@ -287,49 +287,15 @@ AcpiOsReleaseObject (
>      ACPI_MEMORY_LIST        *Cache,
>      void                    *Object)
>  {
> -    ACPI_STATUS             Status;
> -
> -
>      ACPI_FUNCTION_ENTRY ();
>  
> -
>      if (!Cache || !Object)
>      {
>          return (AE_BAD_PARAMETER);
>      }
>  
> -    /* If cache is full, just free this object */
> -
> -    if (Cache->CurrentDepth >= Cache->MaxDepth)
> -    {
> -        ACPI_FREE (Object);
> -        ACPI_MEM_TRACKING (Cache->TotalFreed++);
> -    }
> -
> -    /* Otherwise put this object back into the cache */
> -
> -    else
> -    {
> -        Status = AcpiUtAcquireMutex (ACPI_MTX_CACHES);
> -        if (ACPI_FAILURE (Status))
> -        {
> -            return (Status);
> -        }
> -
> -        /* Mark the object as cached */
> -
> -        ACPI_MEMSET (Object, 0xCA, Cache->ObjectSize);
> -        ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_CACHED);
> -
> -        /* Put the object at the head of the cache list */
> -
> -        * (ACPI_CAST_INDIRECT_PTR (char,
> -            &(((char *) Object)[Cache->LinkOffset]))) = Cache->ListHead;
> -        Cache->ListHead = Object;
> -        Cache->CurrentDepth++;
> -
> -        (void) AcpiUtReleaseMutex (ACPI_MTX_CACHES);
> -    }
> +    ACPI_FREE (Object);
> +    ACPI_MEM_TRACKING (Cache->TotalFreed++);
>  
>      return (AE_OK);
>  }
> @@ -353,8 +319,6 @@ AcpiOsAcquireObject (
>      ACPI_MEMORY_LIST        *Cache)
>  {
>      ACPI_STATUS             Status;
> -    void                    *Object;
> -
>  
>      ACPI_FUNCTION_NAME (OsAcquireObject);
>  
> @@ -372,61 +336,26 @@ AcpiOsAcquireObject (
>  
>      ACPI_MEM_TRACKING (Cache->Requests++);
>  
> -    /* Check the cache first */
> +    /* The cache is empty, create a new object */
>  
> -    if (Cache->ListHead)
> -    {
> -        /* There is an object available, use it */
> -
> -        Object = Cache->ListHead;
> -        Cache->ListHead = *(ACPI_CAST_INDIRECT_PTR (char,
> -                                &(((char *) Object)[Cache->LinkOffset])));
> -
> -        Cache->CurrentDepth--;
> -
> -        ACPI_MEM_TRACKING (Cache->Hits++);
> -        ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
> -            "Object %p from %s cache\n", Object, Cache->ListName));
> -
> -        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
> -        if (ACPI_FAILURE (Status))
> -        {
> -            return (NULL);
> -        }
> -
> -        /* Clear (zero) the previously used Object */
> -
> -        ACPI_MEMSET (Object, 0, Cache->ObjectSize);
> -    }
> -    else
> -    {
> -        /* The cache is empty, create a new object */
> -
> -        ACPI_MEM_TRACKING (Cache->TotalAllocated++);
> +    ACPI_MEM_TRACKING (Cache->TotalAllocated++);
>  
>  #ifdef ACPI_DBG_TRACK_ALLOCATIONS
> -        if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
> -        {
> -            Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
> -        }
> +    if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache->MaxOccupied)
> +    {
> +        Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
> +    }
>  #endif
>  
> -        /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
> +    /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
>  
> -        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
> -        if (ACPI_FAILURE (Status))
> -        {
> -            return (NULL);
> -        }
> -
> -        Object = ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
> -        if (!Object)
> -        {
> -            return (NULL);
> -        }
> +    Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
> +    if (ACPI_FAILURE (Status))
> +    {
> +        return (NULL);
>      }
>  
> -    return (Object);
> +    return ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
>  }
>  #endif /* ACPI_USE_LOCAL_CACHE */
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-4a4ORlU/FC32+E25crxF
Content-Disposition: attachment; filename="[PATCH_1_4]_ACPICA:_Remove_cache_code"
Content-Type: text/plain; name="[PATCH_1_4]_ACPICA:_Remove_cache_code"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

    ACPICA: Remove cache code
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/acpica/acconfig.h  |    8 -----
 drivers/acpi/acpica/acglobal.h  |    8 -----
 drivers/acpi/acpica/acobject.h  |    7 ----
 drivers/acpi/acpica/nsalloc.c   |    7 ++--
 drivers/acpi/acpica/psutils.c   |    8 ++--
 drivers/acpi/acpica/utalloc.c   |   66 +--------------------------------------
 drivers/acpi/acpica/utobject.c  |    4 +-
 drivers/acpi/acpica/utstate.c   |    4 +-
 drivers/acpi/acpica/utxface.c   |   30 -----------------
 include/acpi/acpiosxf.h         |   16 ---------
 include/acpi/actypes.h          |   10 ------
 include/acpi/platform/acenv.h   |    9 -----
 include/acpi/platform/aclinux.h |    1 -
 13 files changed, 12 insertions(+), 166 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index e6777fb..aff01be 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -71,14 +71,6 @@
  */
 #define ACPI_OS_NAME                    "Microsoft Windows NT"
 
-/* Maximum objects in the various object caches */
-
-#define ACPI_MAX_STATE_CACHE_DEPTH      96	/* State objects */
-#define ACPI_MAX_PARSE_CACHE_DEPTH      96	/* Parse tree objects */
-#define ACPI_MAX_EXTPARSE_CACHE_DEPTH   96	/* Parse tree objects */
-#define ACPI_MAX_OBJECT_CACHE_DEPTH     96	/* Interpreter operand objects */
-#define ACPI_MAX_NAMESPACE_CACHE_DEPTH  96	/* Namespace objects */
-
 /*
  * Should the subsystem abort the loading of an ACPI table if the
  * table checksum is incorrect?
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 3d87362..c36e1dc 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -216,14 +216,6 @@ ACPI_EXTERN struct acpi_memory_list *acpi_gbl_ns_node_list;
 ACPI_EXTERN u8 acpi_gbl_display_final_mem_stats;
 #endif
 
-/* Object caches */
-
-ACPI_EXTERN acpi_cache_t *acpi_gbl_namespace_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_state_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_ps_node_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_ps_node_ext_cache;
-ACPI_EXTERN acpi_cache_t *acpi_gbl_operand_cache;
-
 /* Global handlers */
 
 ACPI_EXTERN struct acpi_object_notify_handler acpi_gbl_device_notify;
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 544dcf8..a8e1319 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -356,12 +356,6 @@ struct acpi_object_data {
 	void *pointer;
 };
 
-/* Structure used when objects are cached for reuse */
-
-struct acpi_object_cache_list {
-	ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;	/* Link for object cache and internal lists */
-};
-
 /******************************************************************************
  *
  * union acpi_operand_object Descriptor - a giant union of all of the above
@@ -393,7 +387,6 @@ union acpi_operand_object {
 	struct acpi_object_reference reference;
 	struct acpi_object_extra extra;
 	struct acpi_object_data data;
-	struct acpi_object_cache_list cache;
 
 	/*
 	 * Add namespace node to union in order to simplify code that accepts both
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index aceb931..f3d06aa 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -68,7 +68,7 @@ struct acpi_namespace_node *acpi_ns_create_node(u32 name)
 
 	ACPI_FUNCTION_TRACE(ns_create_node);
 
-	node = acpi_os_acquire_object(acpi_gbl_namespace_cache);
+	node = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_namespace_node));
 	if (!node) {
 		return_PTR(NULL);
 	}
@@ -147,7 +147,7 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 	/* Detach an object if there is one, then delete the node */
 
 	acpi_ns_detach_object(node);
-	(void)acpi_os_release_object(acpi_gbl_namespace_cache, node);
+	ACPI_FREE(node);
 	return_VOID;
 }
 
@@ -287,8 +287,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 
 		/* Now we can delete the node */
 
-		(void)acpi_os_release_object(acpi_gbl_namespace_cache,
-					     child_node);
+		ACPI_FREE(child_node);
 
 		/* And move on to the next child in the list */
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index e636e07..913c585 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -139,11 +139,11 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode)
 
 		/* The generic op (default) is by far the most common (16 to 1) */
 
-		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
+		op = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
-		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
+		op = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */
@@ -179,9 +179,9 @@ void acpi_ps_free_op(union acpi_parse_object *op)
 	}
 
 	if (op->common.flags & ACPI_PARSEOP_GENERIC) {
-		(void)acpi_os_release_object(acpi_gbl_ps_node_cache, op);
+		ACPI_FREE(op);
 	} else {
-		(void)acpi_os_release_object(acpi_gbl_ps_node_ext_cache, op);
+		ACPI_FREE(op);
 	}
 }
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 7580f6b..c1c7594 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -61,54 +61,8 @@ ACPI_MODULE_NAME("utalloc")
  ******************************************************************************/
 acpi_status acpi_ut_create_caches(void)
 {
-	acpi_status status;
-
-	/* Object Caches, for frequently used objects */
-
-	status =
-	    acpi_os_create_cache("Acpi-Namespace",
-				 sizeof(struct acpi_namespace_node),
-				 ACPI_MAX_NAMESPACE_CACHE_DEPTH,
-				 &acpi_gbl_namespace_cache);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	status =
-	    acpi_os_create_cache("Acpi-State", sizeof(union acpi_generic_state),
-				 ACPI_MAX_STATE_CACHE_DEPTH,
-				 &acpi_gbl_state_cache);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	status =
-	    acpi_os_create_cache("Acpi-Parse",
-				 sizeof(struct acpi_parse_obj_common),
-				 ACPI_MAX_PARSE_CACHE_DEPTH,
-				 &acpi_gbl_ps_node_cache);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	status =
-	    acpi_os_create_cache("Acpi-ParseExt",
-				 sizeof(struct acpi_parse_obj_named),
-				 ACPI_MAX_EXTPARSE_CACHE_DEPTH,
-				 &acpi_gbl_ps_node_ext_cache);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	status =
-	    acpi_os_create_cache("Acpi-Operand",
-				 sizeof(union acpi_operand_object),
-				 ACPI_MAX_OBJECT_CACHE_DEPTH,
-				 &acpi_gbl_operand_cache);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
+	acpi_status status;
 
 	/* Memory allocation lists */
 
@@ -150,24 +104,6 @@ acpi_status acpi_ut_delete_caches(void)
 		ACPI_STRCPY(buffer, "MEMORY");
 		(void)acpi_db_display_statistics(buffer);
 	}
-#endif
-
-	(void)acpi_os_delete_cache(acpi_gbl_namespace_cache);
-	acpi_gbl_namespace_cache = NULL;
-
-	(void)acpi_os_delete_cache(acpi_gbl_state_cache);
-	acpi_gbl_state_cache = NULL;
-
-	(void)acpi_os_delete_cache(acpi_gbl_operand_cache);
-	acpi_gbl_operand_cache = NULL;
-
-	(void)acpi_os_delete_cache(acpi_gbl_ps_node_cache);
-	acpi_gbl_ps_node_cache = NULL;
-
-	(void)acpi_os_delete_cache(acpi_gbl_ps_node_ext_cache);
-	acpi_gbl_ps_node_ext_cache = NULL;
-
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
 	/* Debug only - display leftover memory allocation, if any */
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 0207b62..294d905 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -355,7 +355,7 @@ void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
 
 	ACPI_FUNCTION_TRACE(ut_allocate_object_desc_dbg);
 
-	object = acpi_os_acquire_object(acpi_gbl_operand_cache);
+	object = ACPI_ALLOCATE_ZEROED(sizeof(union acpi_operand_object));
 	if (!object) {
 		ACPI_ERROR((module_name, line_number,
 			    "Could not allocate an object descriptor"));
@@ -399,7 +399,7 @@ void acpi_ut_delete_object_desc(union acpi_operand_object *object)
 		return_VOID;
 	}
 
-	(void)acpi_os_release_object(acpi_gbl_operand_cache, object);
+	ACPI_FREE(object);
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 0440c95..ab6fbd4 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -158,7 +158,7 @@ union acpi_generic_state *acpi_ut_create_generic_state(void)
 
 	ACPI_FUNCTION_ENTRY();
 
-	state = acpi_os_acquire_object(acpi_gbl_state_cache);
+	state = ACPI_ALLOCATE_ZEROED(sizeof(union acpi_generic_state));
 	if (state) {
 
 		/* Initialize */
@@ -341,7 +341,7 @@ void acpi_ut_delete_generic_state(union acpi_generic_state *state)
 	/* Ignore null state */
 
 	if (state) {
-		(void)acpi_os_release_object(acpi_gbl_state_cache, state);
+		ACPI_FREE(state);
 	}
 	return_VOID;
 }
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 078a227..e239dea 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -296,13 +296,6 @@ acpi_status acpi_initialize_objects(u32 flags)
 			return (status);
 	}
 
-	/*
-	 * Empty the caches (delete the cached objects) on the assumption that
-	 * the table load filled them up more than they will be at runtime --
-	 * thus wasting non-paged memory.
-	 */
-	status = acpi_purge_cached_objects();
-
 	acpi_gbl_startup_flags |= ACPI_INITIALIZED_OK;
 	return_ACPI_STATUS(status);
 }
@@ -486,27 +479,4 @@ acpi_install_initialization_handler(acpi_init_handler handler, u32 function)
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
 #endif				/*  ACPI_FUTURE_USAGE  */
-/*****************************************************************************
- *
- * FUNCTION:    acpi_purge_cached_objects
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Empty all caches (delete the cached objects)
- *
- ****************************************************************************/
-acpi_status acpi_purge_cached_objects(void)
-{
-	ACPI_FUNCTION_TRACE(acpi_purge_cached_objects);
-
-	(void)acpi_os_purge_cache(acpi_gbl_state_cache);
-	(void)acpi_os_purge_cache(acpi_gbl_operand_cache);
-	(void)acpi_os_purge_cache(acpi_gbl_ps_node_cache);
-	(void)acpi_os_purge_cache(acpi_gbl_ps_node_ext_cache);
-	return_ACPI_STATUS(AE_OK);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
 #endif
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 3e79859..f24c2fb 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -153,22 +153,6 @@ acpi_os_get_physical_address(void *logical_address,
 #endif
 
 /*
- * Memory/Object Cache
- */
-acpi_status
-acpi_os_create_cache(char *cache_name,
-		     u16 object_size,
-		     u16 max_depth, acpi_cache_t ** return_cache);
-
-acpi_status acpi_os_delete_cache(acpi_cache_t * cache);
-
-acpi_status acpi_os_purge_cache(acpi_cache_t * cache);
-
-void *acpi_os_acquire_object(acpi_cache_t * cache);
-
-acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object);
-
-/*
  * Interrupt handlers
  */
 acpi_status
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 37ba576..21abd7a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -223,16 +223,6 @@ typedef u32 acpi_physical_address;
 #define acpi_cpu_flags			acpi_size
 #endif
 
-/* Object returned from acpi_os_create_cache */
-
-#ifndef acpi_cache_t
-#ifdef ACPI_USE_LOCAL_CACHE
-#define acpi_cache_t                    struct acpi_memory_list
-#else
-#define acpi_cache_t                    void *
-#endif
-#endif
-
 /*
  * Synchronization objects - Mutexes, Semaphores, and spin_locks
  */
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index e62f10d..d6815c0 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -60,14 +60,6 @@
  *
  *****************************************************************************/
 
-#ifdef ACPI_LIBRARY
-/*
- * Note: The non-debug version of the acpi_library does not contain any
- * debug support, for minimal size. The debug version uses ACPI_FULL_DEBUG
- */
-#define ACPI_USE_LOCAL_CACHE
-#endif
-
 #ifdef ACPI_ASL_COMPILER
 #define ACPI_DEBUG_OUTPUT
 #define ACPI_APPLICATION
@@ -89,7 +81,6 @@
 
 #ifdef ACPI_APPLICATION
 #define ACPI_USE_SYSTEM_CLIBRARY
-#define ACPI_USE_LOCAL_CACHE
 #endif
 
 #ifdef ACPI_FULL_DEBUG
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index fcb8e4b..43bacf2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -72,7 +72,6 @@
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
-#define acpi_cache_t                        struct kmem_cache
 #define acpi_spinlock                       spinlock_t *
 #define acpi_cpu_flags                      unsigned long
 #define acpi_thread_id                      struct task_struct *

--=-4a4ORlU/FC32+E25crxF
Content-Disposition: attachment; filename="[PATCH_2_4]_ACPICA:_Drop_Operand_cache"
Content-Type: text/plain; name="[PATCH_2_4]_ACPICA:_Drop_Operand_cache"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

    ACPICA: Drop Operand cache
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/acpica/acnamesp.h |    4 -
 drivers/acpi/acpica/acobject.h |   23 ++----
 drivers/acpi/acpica/acutils.h  |    1 +
 drivers/acpi/acpica/dsfield.c  |    6 +-
 drivers/acpi/acpica/dsopcode.c |   24 ++-----
 drivers/acpi/acpica/evregion.c |   33 ++-------
 drivers/acpi/acpica/evrgnini.c |   10 +--
 drivers/acpi/acpica/excreate.c |    6 +-
 drivers/acpi/acpica/exprep.c   |    6 +-
 drivers/acpi/acpica/nsobject.c |   30 --------
 drivers/acpi/acpica/utcopy.c   |    2 +-
 drivers/acpi/acpica/utdelete.c |   74 ++++++--------------
 drivers/acpi/acpica/utobject.c |  156 +++++++++++++++++++--------------------
 include/acpi/actypes.h         |    1 -
 14 files changed, 128 insertions(+), 248 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 46cb5b4..70d7d64 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -234,10 +234,6 @@ union acpi_operand_object *acpi_ns_get_attached_object(struct
 						       acpi_namespace_node
 						       *node);
 
-union acpi_operand_object *acpi_ns_get_secondary_object(union
-							acpi_operand_object
-							*obj_desc);
-
 acpi_status
 acpi_ns_attach_data(struct acpi_namespace_node *node,
 		    acpi_object_handler handler, void *data);
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index a8e1319..fdafe1a 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -170,6 +170,10 @@ struct acpi_object_region {
 	union acpi_operand_object *next;
 	acpi_physical_address address;
 	u32 length;
+	struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
+	void *region_context;	/* Region-specific data */
+	u8 *aml_start;
+	u32 aml_length;
 };
 
 struct acpi_object_method {
@@ -255,6 +259,8 @@ struct acpi_object_region_field {
 struct acpi_object_bank_field {
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Containing op_region object */
 	union acpi_operand_object *bank_obj;	/* bank_select Register object */
+	u8 *aml_start;
+	u32 aml_length;
 };
 
 struct acpi_object_index_field {
@@ -271,6 +277,8 @@ struct acpi_object_index_field {
 
 struct acpi_object_buffer_field {
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *buffer_obj;	/* Containing Buffer object */
+	u8 *aml_start;
+	u32 aml_length;
 };
 
 /******************************************************************************
@@ -335,20 +343,6 @@ typedef enum {
 	ACPI_REFCLASS_MAX = 6
 } ACPI_REFERENCE_CLASSES;
 
-/*
- * Extra object is used as additional storage for types that
- * have AML code in their declarations (term_args) that must be
- * evaluated at run time.
- *
- * Currently: Region and field_unit types
- */
-struct acpi_object_extra {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
-	void *region_context;	/* Region-specific data */
-	u8 *aml_start;
-	u32 aml_length;
-};
-
 /* Additional data that can be attached to namespace nodes */
 
 struct acpi_object_data {
@@ -385,7 +379,6 @@ union acpi_operand_object {
 	struct acpi_object_notify_handler notify;
 	struct acpi_object_addr_handler address_space;
 	struct acpi_object_reference reference;
-	struct acpi_object_extra extra;
 	struct acpi_object_data data;
 
 	/*
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 897810b..66e9f1e 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -232,6 +232,7 @@ acpi_ut_copy_iobject_to_iobject(union acpi_operand_object *source_desc,
 				union acpi_operand_object **dest_desc,
 				struct acpi_walk_state *walk_state);
 
+acpi_size acpi_ut_operand_size(int type);
 /*
  * utcreate - Object creation
  */
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 53e27bc..5d4813f 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -85,7 +85,6 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 	struct acpi_namespace_node *node;
 	acpi_status status;
 	union acpi_operand_object *obj_desc;
-	union acpi_operand_object *second_desc = NULL;
 	u32 flags;
 
 	ACPI_FUNCTION_TRACE(ds_create_buffer_field);
@@ -176,9 +175,8 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 	 * Remember location in AML stream of the field unit opcode and operands --
 	 * since the buffer and index operands must be evaluated.
 	 */
-	second_desc = obj_desc->common.next_object;
-	second_desc->extra.aml_start = op->named.data;
-	second_desc->extra.aml_length = op->named.length;
+	obj_desc->buffer_field.aml_start = op->named.data;
+	obj_desc->buffer_field.aml_length = op->named.length;
 	obj_desc->buffer_field.node = node;
 
 	/* Attach constructed field descriptors to parent node */
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 584d766..726eae7 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -191,7 +191,6 @@ acpi_ds_execute_arguments(struct acpi_namespace_node *node,
 acpi_status
 acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 {
-	union acpi_operand_object *extra_desc;
 	struct acpi_namespace_node *node;
 	acpi_status status;
 
@@ -203,7 +202,6 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Get the AML pointer (method object) and buffer_field node */
 
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
 	node = obj_desc->buffer_field.node;
 
 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
@@ -214,8 +212,8 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 	/* Execute the AML code for the term_arg arguments */
 
 	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
+					   obj_desc->buffer_field.aml_length,
+					   obj_desc->buffer_field.aml_start);
 	return_ACPI_STATUS(status);
 }
 
@@ -235,7 +233,6 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 acpi_status
 acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
 {
-	union acpi_operand_object *extra_desc;
 	struct acpi_namespace_node *node;
 	acpi_status status;
 
@@ -247,7 +244,6 @@ acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Get the AML pointer (method object) and bank_field node */
 
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
 	node = obj_desc->bank_field.node;
 
 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
@@ -258,8 +254,8 @@ acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
 	/* Execute the AML code for the term_arg arguments */
 
 	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
+					   obj_desc->bank_field.aml_length,
+					   obj_desc->bank_field.aml_start);
 	return_ACPI_STATUS(status);
 }
 
@@ -368,7 +364,6 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
-	union acpi_operand_object *extra_desc;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_get_region_arguments, obj_desc);
 
@@ -376,11 +371,6 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
-	if (!extra_desc) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
 	/* Get the Region node */
 
 	node = obj_desc->region.node;
@@ -390,13 +380,13 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
 			  acpi_ut_get_node_name(node),
-			  extra_desc->extra.aml_start));
+			  obj_desc->region.aml_start));
 
 	/* Execute the argument AML */
 
 	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
+					   obj_desc->region.aml_length,
+					   obj_desc->region.aml_start);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 538d632..2f02fc0 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -199,17 +199,11 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 {
 	struct acpi_evaluate_info *info;
 	union acpi_operand_object *args[3];
-	union acpi_operand_object *region_obj2;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ev_execute_reg_method);
 
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
-	if (region_obj2->extra.method_REG == NULL) {
+	if (region_obj->region.method_REG == NULL) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -220,7 +214,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	info->prefix_node = region_obj2->extra.method_REG;
+	info->prefix_node = region_obj->region.method_REG;
 	info->pathname = NULL;
 	info->parameters = args;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
@@ -297,16 +291,10 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	acpi_adr_space_handler handler;
 	acpi_adr_space_setup region_setup;
 	union acpi_operand_object *handler_desc;
-	union acpi_operand_object *region_obj2;
 	void *region_context = NULL;
 
 	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
 
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
 	/* Ensure that there is a handler associated with this region */
 
 	handler_desc = region_obj->region.handler;
@@ -373,7 +361,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
 			region_obj->region.flags |= AOPOBJ_SETUP_COMPLETE;
 
-			if (region_obj2->extra.region_context) {
+			if (region_obj->region.region_context) {
 
 				/* The handler for this region was already installed */
 
@@ -383,7 +371,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 				 * Save the returned context for use in all accesses to
 				 * this particular region
 				 */
-				region_obj2->extra.region_context =
+				region_obj->region.region_context =
 				    region_context;
 			}
 		}
@@ -414,7 +402,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 
 	status = handler(function, address, bit_width, value,
 			 handler_desc->address_space.context,
-			 region_obj2->extra.region_context);
+			 region_obj->region.region_context);
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
@@ -457,16 +445,11 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 	union acpi_operand_object **last_obj_ptr;
 	acpi_adr_space_setup region_setup;
 	void **region_context;
-	union acpi_operand_object *region_obj2;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ev_detach_region);
 
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_VOID;
-	}
-	region_context = &region_obj2->extra.region_context;
+	region_context = &region_obj->region.region_context;
 
 	/* Get the address handler from the region object */
 
@@ -900,10 +883,6 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 			goto unlock_and_exit;
 		}
 
-		/* Init new descriptor */
-
-		obj_desc->common.type = (u8) type;
-
 		/* Attach the new object to the Node */
 
 		status = acpi_ns_attach_object(node, obj_desc, type);
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 284a7be..147e427 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -533,7 +533,6 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 	acpi_status status;
 	struct acpi_namespace_node *method_node;
 	acpi_name *reg_name_ptr = (acpi_name *) METHOD_NAME__REG;
-	union acpi_operand_object *region_obj2;
 
 	ACPI_FUNCTION_TRACE_U32(ev_initialize_region, acpi_ns_locked);
 
@@ -545,18 +544,13 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
 	node = acpi_ns_get_parent_node(region_obj->region.node);
 	space_id = region_obj->region.space_id;
 
 	/* Setup defaults */
 
 	region_obj->region.handler = NULL;
-	region_obj2->extra.method_REG = NULL;
+	region_obj->region.method_REG = NULL;
 	region_obj->common.flags &= ~(AOPOBJ_SETUP_COMPLETE);
 	region_obj->common.flags |= AOPOBJ_OBJECT_INITIALIZED;
 
@@ -571,7 +565,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		 * definition. This will be executed when the handler is attached
 		 * or removed
 		 */
-		region_obj2->extra.method_REG = method_node;
+		region_obj->region.method_REG = method_node;
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index a57ad25..598dc5e 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -284,7 +284,6 @@ acpi_ex_create_region(u8 * aml_start,
 	acpi_status status;
 	union acpi_operand_object *obj_desc;
 	struct acpi_namespace_node *node;
-	union acpi_operand_object *region_obj2;
 
 	ACPI_FUNCTION_TRACE(ex_create_region);
 
@@ -326,9 +325,8 @@ acpi_ex_create_region(u8 * aml_start,
 	 * Remember location in AML stream of address & length
 	 * operands since they need to be evaluated at run time.
 	 */
-	region_obj2 = obj_desc->common.next_object;
-	region_obj2->extra.aml_start = aml_start;
-	region_obj2->extra.aml_length = aml_length;
+	obj_desc->region.aml_start = aml_start;
+	obj_desc->region.aml_length = aml_length;
 
 	/* Init the region from the operands */
 
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 52fec07..6819e18 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -413,7 +413,6 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 {
 	union acpi_operand_object *obj_desc;
-	union acpi_operand_object *second_desc = NULL;
 	u32 type;
 	acpi_status status;
 
@@ -502,11 +501,10 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		 * opcode and operands -- since the bank_value
 		 * operands must be evaluated.
 		 */
-		second_desc = obj_desc->common.next_object;
-		second_desc->extra.aml_start =
+		obj_desc->bank_field.aml_start =
 		    ACPI_CAST_PTR(union acpi_parse_object,
 				  info->data_register_node)->named.data;
-		second_desc->extra.aml_length =
+		obj_desc->bank_field.aml_length =
 		    ACPI_CAST_PTR(union acpi_parse_object,
 				  info->data_register_node)->named.length;
 
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 3eb20bf..dfd7184 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -274,36 +274,6 @@ union acpi_operand_object *acpi_ns_get_attached_object(struct
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_get_secondary_object
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
-union acpi_operand_object *acpi_ns_get_secondary_object(union
-							acpi_operand_object
-							*obj_desc)
-{
-	ACPI_FUNCTION_TRACE_PTR(ns_get_secondary_object, obj_desc);
-
-	if ((!obj_desc) ||
-	    (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) ||
-	    (!obj_desc->common.next_object) ||
-	    ((obj_desc->common.next_object)->common.type ==
-	     ACPI_TYPE_LOCAL_DATA)) {
-		return_PTR(NULL);
-	}
-
-	return_PTR(obj_desc->common.next_object);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_attach_data
  *
  * PARAMETERS:  Node            - Namespace node
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 0f0c64b..4587c0b 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -686,7 +686,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 	/* Copy the entire source object over the destination object */
 
 	ACPI_MEMCPY((char *)dest_desc, (char *)source_desc,
-		    sizeof(union acpi_operand_object));
+		    acpi_ut_operand_size(dest_desc->common.type));
 
 	/* Restore the saved fields */
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index a5ee23b..fab0266 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -73,7 +73,6 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 {
 	void *obj_pointer = NULL;
 	union acpi_operand_object *handler_desc;
-	union acpi_operand_object *second_desc;
 	union acpi_operand_object *next_desc;
 
 	ACPI_FUNCTION_TRACE_PTR(ut_delete_internal_obj, object);
@@ -214,61 +213,30 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 				  "***** Region %p\n", object));
 
-		second_desc = acpi_ns_get_secondary_object(object);
-		if (second_desc) {
-			/*
-			 * Free the region_context if and only if the handler is one of the
-			 * default handlers -- and therefore, we created the context object
-			 * locally, it was not created by an external caller.
-			 */
-			handler_desc = object->region.handler;
-			if (handler_desc) {
-				if (handler_desc->address_space.handler_flags &
-				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
-
-					/* Deactivate region and free region context */
-
-					if (handler_desc->address_space.setup) {
-						(void)handler_desc->
-						    address_space.setup(object,
-									ACPI_REGION_DEACTIVATE,
-									handler_desc->
-									address_space.
-									context,
-									&second_desc->
-									extra.
-									region_context);
-					}
+		/*
+		 * Free the region_context if and only if the handler is one of the
+		 * default handlers -- and therefore, we created the context object
+		 * locally, it was not created by an external caller.
+		 */
+		handler_desc = object->region.handler;
+		if (handler_desc) {
+			if (handler_desc->address_space.handler_flags &
+			    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
+
+				/* Deactivate region and free region context */
+
+				if (handler_desc->address_space.setup) {
+					(void)handler_desc->address_space.
+					    setup(object,
+						  ACPI_REGION_DEACTIVATE,
+						  handler_desc->address_space.
+						  context,
+						  &object->region.
+						  region_context);
 				}
-
-				acpi_ut_remove_reference(handler_desc);
 			}
 
-			/* Now we can free the Extra object */
-
-			acpi_ut_delete_object_desc(second_desc);
-		}
-		break;
-
-	case ACPI_TYPE_BUFFER_FIELD:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-				  "***** Buffer Field %p\n", object));
-
-		second_desc = acpi_ns_get_secondary_object(object);
-		if (second_desc) {
-			acpi_ut_delete_object_desc(second_desc);
-		}
-		break;
-
-	case ACPI_TYPE_LOCAL_BANK_FIELD:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-				  "***** Bank Field %p\n", object));
-
-		second_desc = acpi_ns_get_secondary_object(object);
-		if (second_desc) {
-			acpi_ut_delete_object_desc(second_desc);
+			acpi_ut_remove_reference(handler_desc);
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 294d905..de5939d 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -62,6 +62,8 @@ acpi_ut_get_element_length(u8 object_type,
 			   union acpi_operand_object *source_object,
 			   union acpi_generic_state *state, void *context);
 
+acpi_size acpi_ut_operand_size(int type);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_create_internal_object_dbg
@@ -74,13 +76,6 @@ acpi_ut_get_element_length(u8 object_type,
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
 
 union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
@@ -91,48 +86,18 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
 							      type)
 {
 	union acpi_operand_object *object;
-	union acpi_operand_object *second_object;
 
 	ACPI_FUNCTION_TRACE_STR(ut_create_internal_object_dbg,
 				acpi_ut_get_type_name(type));
 
 	/* Allocate the raw object descriptor */
+	object = ACPI_ALLOCATE_ZEROED(acpi_ut_operand_size(type));
 
-	object =
-	    acpi_ut_allocate_object_desc_dbg(module_name, line_number,
-					     component_id);
 	if (!object) {
 		return_PTR(NULL);
 	}
 
-	switch (type) {
-	case ACPI_TYPE_REGION:
-	case ACPI_TYPE_BUFFER_FIELD:
-	case ACPI_TYPE_LOCAL_BANK_FIELD:
-
-		/* These types require a secondary object */
-
-		second_object = acpi_ut_allocate_object_desc_dbg(module_name,
-								 line_number,
-								 component_id);
-		if (!second_object) {
-			acpi_ut_delete_object_desc(object);
-			return_PTR(NULL);
-		}
-
-		second_object->common.type = ACPI_TYPE_LOCAL_EXTRA;
-		second_object->common.reference_count = 1;
-
-		/* Link the second object to the first */
-
-		object->common.next_object = second_object;
-		break;
-
-	default:
-		/* All others have no secondary object */
-		break;
-	}
-
+	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
 	/* Save the object type in the object descriptor */
 
 	object->common.type = (u8) type;
@@ -335,47 +300,6 @@ u8 acpi_ut_valid_internal_object(void *object)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_allocate_object_desc_dbg
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              component_id        - Caller's component ID (for error output)
- *
- * RETURN:      Pointer to newly allocated object descriptor.  Null on error
- *
- * DESCRIPTION: Allocate a new object descriptor.  Gracefully handle
- *              error conditions.
- *
- ******************************************************************************/
-
-void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
-				       u32 line_number, u32 component_id)
-{
-	union acpi_operand_object *object;
-
-	ACPI_FUNCTION_TRACE(ut_allocate_object_desc_dbg);
-
-	object = ACPI_ALLOCATE_ZEROED(sizeof(union acpi_operand_object));
-	if (!object) {
-		ACPI_ERROR((module_name, line_number,
-			    "Could not allocate an object descriptor"));
-
-		return_PTR(NULL);
-	}
-
-	/* Mark the descriptor type */
-
-	memset(object, 0, sizeof(union acpi_operand_object));
-	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
-			  object, (u32) sizeof(union acpi_operand_object)));
-
-	return_PTR(object);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ut_delete_object_desc
  *
  * PARAMETERS:  Object          - An Acpi internal object to be deleted
@@ -403,6 +327,78 @@ void acpi_ut_delete_object_desc(union acpi_operand_object *object)
 	return_VOID;
 }
 
+acpi_size acpi_ut_operand_size(int type)
+{
+	acpi_size obj_size = 0;
+
+	switch (type) {
+	case ACPI_TYPE_INTEGER:
+		obj_size = sizeof(struct acpi_object_integer);
+		break;
+	case ACPI_TYPE_BUFFER_FIELD:
+		obj_size = sizeof(struct acpi_object_buffer_field);
+		break;
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+		obj_size = sizeof(struct acpi_object_bank_field);
+		break;
+	case ACPI_TYPE_LOCAL_INDEX_FIELD:
+		obj_size = sizeof(struct acpi_object_index_field);
+		break;
+	case ACPI_TYPE_LOCAL_ADDRESS_HANDLER:
+		obj_size = sizeof(struct acpi_object_addr_handler);
+		break;
+	case ACPI_TYPE_MUTEX:
+		obj_size = sizeof(struct acpi_object_mutex);
+		break;
+	case ACPI_TYPE_REGION:
+		obj_size = sizeof(struct acpi_object_region);
+		break;
+	case ACPI_TYPE_STRING:
+		obj_size = sizeof(struct acpi_object_string);
+		break;
+	case ACPI_TYPE_BUFFER:
+		obj_size = sizeof(struct acpi_object_buffer);
+		break;
+	case ACPI_TYPE_PACKAGE:
+		obj_size = sizeof(struct acpi_object_package);
+		break;
+	case ACPI_TYPE_EVENT:
+		obj_size = sizeof(struct acpi_object_event);
+		break;
+	case ACPI_TYPE_METHOD:
+		obj_size = sizeof(struct acpi_object_method);
+		break;
+	case ACPI_TYPE_DEVICE:
+		obj_size = sizeof(struct acpi_object_device);
+		break;
+	case ACPI_TYPE_POWER:
+		obj_size = sizeof(struct acpi_object_power_resource);
+		break;
+	case ACPI_TYPE_PROCESSOR:
+		obj_size = sizeof(struct acpi_object_processor);
+		break;
+	case ACPI_TYPE_THERMAL:
+		obj_size = sizeof(struct acpi_object_thermal_zone);
+		break;
+	case ACPI_TYPE_LOCAL_REGION_FIELD:
+		obj_size = sizeof(struct acpi_object_region_field);
+		break;
+	case ACPI_TYPE_LOCAL_NOTIFY:
+		obj_size = sizeof(struct acpi_object_notify_handler);
+		break;
+	case ACPI_TYPE_LOCAL_REFERENCE:
+		obj_size = sizeof(struct acpi_object_reference);
+		break;
+	case ACPI_TYPE_LOCAL_DATA:
+		obj_size = sizeof(struct acpi_object_data);
+		break;
+	default:
+		ACPI_ERROR((AE_INFO, "Unexpected type of object descriptor"));
+		return 0;
+	}
+	return obj_size;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_get_simple_object_size
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 21abd7a..eb98f19 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -588,7 +588,6 @@ typedef u32 acpi_object_type;
  * These are special object types that never appear in
  * a Namespace node, only in a union acpi_operand_object
  */
-#define ACPI_TYPE_LOCAL_EXTRA           0x1C
 #define ACPI_TYPE_LOCAL_DATA            0x1D
 
 #define ACPI_TYPE_LOCAL_MAX             0x1D

--=-4a4ORlU/FC32+E25crxF
Content-Disposition: attachment; filename="[PATCH_3_4]_ACPICA:_Delete_NextObject_pointer"
Content-Type: text/plain; name="[PATCH_3_4]_ACPICA:_Delete_NextObject_pointer"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

    ACPICA: Delete NextObject pointer
    
    NextObject field was used for double objects (removed by prev patch) and
    for data objects. Data object size is now untangled from all other object
    sizes, so we can save size of pointer in all object allocations.
    
    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/acpica/aclocal.h  |    4 ++--
 drivers/acpi/acpica/acobject.h |    5 ++---
 drivers/acpi/acpica/nsobject.c |   36 +++++++-----------------------------
 drivers/acpi/acpica/utcopy.c   |   11 +++++++----
 4 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 772ee5c..7cd8ca5 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -178,7 +178,6 @@ typedef enum {
  * structures.
  */
 struct acpi_namespace_node {
-	union acpi_operand_object *object;	/* Interpreter object */
 	u8 descriptor_type;	/* Differentiate object descriptor types */
 	u8 type;		/* ACPI Type associated with this name */
 	u8 flags;		/* Miscellaneous flags */
@@ -186,6 +185,7 @@ struct acpi_namespace_node {
 	union acpi_name_union name;	/* ACPI Name, always 4 chars per ACPI spec */
 	struct acpi_namespace_node *child;	/* First child */
 	struct acpi_namespace_node *peer;	/* Peer. Parent if ANOBJ_END_OF_PEER_LIST set */
+	union acpi_operand_object *object;	/* Interpreter object */
 
 	/*
 	 * The following fields are used by the ASL compiler and disassembler only
@@ -651,11 +651,11 @@ union acpi_parse_value {
 #endif
 
 #define ACPI_PARSE_COMMON \
-	union acpi_parse_object         *parent;        /* Parent op */\
 	u8                              descriptor_type; /* To differentiate various internal objs */\
 	u8                              flags;          /* Type of Op */\
 	u16                             aml_opcode;     /* AML opcode */\
 	u32                             aml_offset;     /* Offset of declaration in AML */\
+	union acpi_parse_object         *parent;        /* Parent op */\
 	union acpi_parse_object         *next;          /* Next op */\
 	struct acpi_namespace_node      *node;          /* For use by interpreter */\
 	union acpi_parse_value          value;          /* Value or args associated with the opcode */\
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index fdafe1a..91e892a 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -79,7 +79,6 @@
  * structures.
  */
 #define ACPI_OBJECT_COMMON_HEADER \
-	union acpi_operand_object       *next_object;       /* Objects linked to parent NS node */\
 	u8                              descriptor_type;    /* To differentiate various internal objs */\
 	u8                              type;               /* acpi_object_type */\
 	u16                             reference_count;    /* For object deletion management */\
@@ -346,7 +345,8 @@ typedef enum {
 /* Additional data that can be attached to namespace nodes */
 
 struct acpi_object_data {
-	ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
+	ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;	/* Objects linked to parent NS node */
+	acpi_object_handler handler;
 	void *pointer;
 };
 
@@ -415,7 +415,6 @@ union acpi_operand_object {
 #define ACPI_DESC_TYPE_MAX              0x0F
 
 struct acpi_common_descriptor {
-	void *common_pointer;
 	u8 descriptor_type;	/* To differentiate various internal objs */
 };
 
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index dfd7184..5e41985 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -74,7 +74,6 @@ acpi_ns_attach_object(struct acpi_namespace_node *node,
 		      union acpi_operand_object *object, acpi_object_type type)
 {
 	union acpi_operand_object *obj_desc;
-	union acpi_operand_object *last_obj_desc;
 	acpi_object_type object_type = ACPI_TYPE_ANY;
 
 	ACPI_FUNCTION_TRACE(ns_attach_object);
@@ -167,18 +166,6 @@ acpi_ns_attach_object(struct acpi_namespace_node *node,
 		 */
 		acpi_ut_add_reference(obj_desc);
 
-		/*
-		 * Handle objects with multiple descriptors - walk
-		 * to the end of the descriptor list
-		 */
-		last_obj_desc = obj_desc;
-		while (last_obj_desc->common.next_object) {
-			last_obj_desc = last_obj_desc->common.next_object;
-		}
-
-		/* Install the object at the front of the object list */
-
-		last_obj_desc->common.next_object = node->object;
 	}
 
 	node->type = (u8) object_type;
@@ -216,13 +203,6 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 	/* Clear the entry in all cases */
 
 	node->object = NULL;
-	if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) == ACPI_DESC_TYPE_OPERAND) {
-		node->object = obj_desc->common.next_object;
-		if (node->object &&
-		    ((node->object)->common.type != ACPI_TYPE_LOCAL_DATA)) {
-			node->object = node->object->common.next_object;
-		}
-	}
 
 	/* Reset the node type to untyped */
 
@@ -299,13 +279,12 @@ acpi_ns_attach_data(struct acpi_namespace_node *node,
 	prev_obj_desc = NULL;
 	obj_desc = node->object;
 	while (obj_desc) {
-		if ((obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) &&
-		    (obj_desc->data.handler == handler)) {
+		if (obj_desc->data.handler == handler) {
 			return (AE_ALREADY_EXISTS);
 		}
 
 		prev_obj_desc = obj_desc;
-		obj_desc = obj_desc->common.next_object;
+		obj_desc = obj_desc->data.next;
 	}
 
 	/* Create an internal object for the data */
@@ -321,7 +300,7 @@ acpi_ns_attach_data(struct acpi_namespace_node *node,
 	/* Install the data object */
 
 	if (prev_obj_desc) {
-		prev_obj_desc->common.next_object = data_desc;
+		prev_obj_desc->data.next = data_desc;
 	} else {
 		node->object = data_desc;
 	}
@@ -356,10 +335,9 @@ acpi_ns_detach_data(struct acpi_namespace_node * node,
 		if ((obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) &&
 		    (obj_desc->data.handler == handler)) {
 			if (prev_obj_desc) {
-				prev_obj_desc->common.next_object =
-				    obj_desc->common.next_object;
+				prev_obj_desc->data.next = obj_desc->data.next;
 			} else {
-				node->object = obj_desc->common.next_object;
+				node->object = obj_desc->data.next;
 			}
 
 			acpi_ut_remove_reference(obj_desc);
@@ -367,7 +345,7 @@ acpi_ns_detach_data(struct acpi_namespace_node * node,
 		}
 
 		prev_obj_desc = obj_desc;
-		obj_desc = obj_desc->common.next_object;
+		obj_desc = obj_desc->data.next;
 	}
 
 	return (AE_NOT_FOUND);
@@ -402,7 +380,7 @@ acpi_ns_get_attached_data(struct acpi_namespace_node * node,
 			return (AE_OK);
 		}
 
-		obj_desc = obj_desc->common.next_object;
+		obj_desc = obj_desc->data.next;
 	}
 
 	return (AE_NOT_FOUND);
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 4587c0b..d51ac0b 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -675,13 +675,15 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 			   union acpi_operand_object *dest_desc)
 {
 	u16 reference_count;
-	union acpi_operand_object *next_object;
+	union acpi_operand_object *next_object = NULL;
 	acpi_status status;
 
 	/* Save fields from destination that we don't want to overwrite */
 
 	reference_count = dest_desc->common.reference_count;
-	next_object = dest_desc->common.next_object;
+	if (dest_desc->common.type == ACPI_TYPE_LOCAL_DATA) {
+		next_object = dest_desc->data.next;
+	}
 
 	/* Copy the entire source object over the destination object */
 
@@ -691,8 +693,9 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 	/* Restore the saved fields */
 
 	dest_desc->common.reference_count = reference_count;
-	dest_desc->common.next_object = next_object;
-
+	if (dest_desc->common.type == ACPI_TYPE_LOCAL_DATA) {
+		dest_desc->data.next = next_object;
+	}
 	/* New object is not static, regardless of source */
 
 	dest_desc->common.flags &= ~AOPOBJ_STATIC_POINTER;

--=-4a4ORlU/FC32+E25crxF
Content-Disposition: attachment; filename="[PATCH_4_4]_ACPICA:_Remove_linux_cache_code"
Content-Type: text/plain; name="[PATCH_4_4]_ACPICA:_Remove_linux_cache_code"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

    ACPICA: Remove linux specific cache code

    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/osl.c              |   95 ---------------------------------------
 include/acpi/platform/aclinux.h |    6 ---
 2 files changed, 0 insertions(+), 101 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d59f08e..32a6521 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1210,101 +1210,6 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
 
 #ifndef ACPI_USE_LOCAL_CACHE
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_os_create_cache
- *
- * PARAMETERS:  name      - Ascii name for the cache
- *              size      - Size of each cached object
- *              depth     - Maximum depth of the cache (in objects) <ignored>
- *              cache     - Where the new cache object is returned
- *
- * RETURN:      status
- *
- * DESCRIPTION: Create a cache object
- *
- ******************************************************************************/
-
-acpi_status
-acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
-{
-	*cache = kmem_cache_create(name, size, 0, 0, NULL);
-	if (*cache == NULL)
-		return AE_ERROR;
-	else
-		return AE_OK;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_os_purge_cache
- *
- * PARAMETERS:  Cache           - Handle to cache object
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Free all objects within the requested cache.
- *
- ******************************************************************************/
-
-acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
-{
-	kmem_cache_shrink(cache);
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_os_delete_cache
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
-acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
-{
-	kmem_cache_destroy(cache);
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_os_release_object
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
-acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
-{
-	kmem_cache_free(cache, object);
-	return (AE_OK);
-}
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_os_validate_interface
- *
- * PARAMETERS:  interface           - Requested interface to be validated
- *
- * RETURN:      AE_OK if interface is supported, AE_SUPPORT otherwise
- *
- * DESCRIPTION: Match an interface string to the interfaces supported by the
- *              host. Strings originate from an AML call to the _OSI method.
- *
- *****************************************************************************/
-
 acpi_status
 acpi_os_validate_interface (char *interface)
 {
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 43bacf2..36d006a 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -137,12 +137,6 @@ static inline void *acpi_os_allocate_zeroed(acpi_size size)
 	return kzalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
-static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
-{
-	return kmem_cache_zalloc(cache,
-		irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
-}
-
 #define ACPI_ALLOCATE(a)        acpi_os_allocate(a)
 #define ACPI_ALLOCATE_ZEROED(a) acpi_os_allocate_zeroed(a)
 #define ACPI_FREE(a)            kfree(a)

--=-4a4ORlU/FC32+E25crxF--

