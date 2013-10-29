From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/20] ACPICA: Cleanup memory allocation macros and configurability.
Date: Tue, 29 Oct 2013 09:29:27 +0800
Message-ID: <9d12cb9b1fc9173e62650ae9a9a7c4af0130ee35.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21760 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757171Ab3J2B3h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:37 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

In the common case, the ACPI_ALLOCATE and related macros now resolve
directly to their respective acpi_os* OSL interfaces. Two options:
1) The ACPI_ALLOCATE_ZEROED macro defaults to a simple local implementation
   by default, unless overridden by the USE_NATIVE_ALLOCATE_ZEROED define.
2) For ACPI execution simulation environment (AcpiExec) which is not
   shipped in the kernel, the macros can optionally be resolved to the
   local interfaces that track each allocation (used to immediately detect
   memory leaks).

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acmacros.h  |   31 -----------
 drivers/acpi/acpica/acutils.h   |    6 ---
 drivers/acpi/acpica/utalloc.c   |  113 ++++++++++++---------------------------
 drivers/acpi/acpica/uttrack.c   |   29 ++++++++--
 include/acpi/acpiosxf.h         |    2 +
 include/acpi/acpixf.h           |    9 ----
 include/acpi/actypes.h          |   27 ++++++++++
 include/acpi/platform/aclinux.h |   15 ++++--
 8 files changed, 100 insertions(+), 132 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 530a2f8..2a86c65 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -410,37 +410,6 @@
 #endif
 
 /*
- * Memory allocation tracking (DEBUG ONLY)
- */
-#define ACPI_MEM_PARAMETERS         _COMPONENT, _acpi_module_name, __LINE__
-
-#ifndef ACPI_DBG_TRACK_ALLOCATIONS
-
-/* Memory allocation */
-
-#ifndef ACPI_ALLOCATE
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size) (a), ACPI_MEM_PARAMETERS)
-#endif
-#ifndef ACPI_ALLOCATE_ZEROED
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size) (a), ACPI_MEM_PARAMETERS)
-#endif
-#ifndef ACPI_FREE
-#define ACPI_FREE(a)                acpi_os_free(a)
-#endif
-#define ACPI_MEM_TRACKING(a)
-
-#else
-
-/* Memory allocation */
-
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
-#define ACPI_FREE(a)                acpi_ut_free_and_track(a, ACPI_MEM_PARAMETERS)
-#define ACPI_MEM_TRACKING(a)        a
-
-#endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
-
-/*
  * Macros used for ACPICA utilities only
  */
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 4f25e8f..be8180c 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -663,12 +663,6 @@ acpi_status
 acpi_ut_initialize_buffer(struct acpi_buffer *buffer,
 			  acpi_size required_length);
 
-void *acpi_ut_allocate(acpi_size size,
-		       u32 component, const char *module, u32 line);
-
-void *acpi_ut_allocate_zeroed(acpi_size size,
-			      u32 component, const char *module, u32 line);
-
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 void *acpi_ut_allocate_and_track(acpi_size size,
 				 u32 component, const char *module, u32 line);
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index e0ffb58..d844796 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -48,6 +48,39 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utalloc")
 
+#if !defined (USE_NATIVE_ALLOCATE_ZEROED)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_allocate_zeroed
+ *
+ * PARAMETERS:  size                - Size of the allocation
+ *
+ * RETURN:      Address of the allocated memory on success, NULL on failure.
+ *
+ * DESCRIPTION: Subsystem equivalent of calloc. Allocate and zero memory.
+ *              This is the default implementation. Can be overridden via the
+ *              USE_NATIVE_ALLOCATE_ZEROED flag.
+ *
+ ******************************************************************************/
+void *acpi_os_allocate_zeroed(acpi_size size)
+{
+	void *allocation;
+
+	ACPI_FUNCTION_ENTRY();
+
+	allocation = acpi_os_allocate(size);
+	if (allocation) {
+
+		/* Clear the memory block */
+
+		ACPI_MEMSET(allocation, 0, size);
+	}
+
+	return (allocation);
+}
+
+#endif				/* !USE_NATIVE_ALLOCATE_ZEROED */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_create_caches
@@ -59,6 +92,7 @@ ACPI_MODULE_NAME("utalloc")
  * DESCRIPTION: Create all local caches
  *
  ******************************************************************************/
+
 acpi_status acpi_ut_create_caches(void)
 {
 	acpi_status status;
@@ -302,82 +336,3 @@ acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
 	ACPI_MEMSET(buffer->pointer, 0, required_length);
 	return (AE_OK);
 }
-
-#ifdef NOT_USED_BY_LINUX
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_allocate
- *
- * PARAMETERS:  size                - Size of the allocation
- *              component           - Component type of caller
- *              module              - Source file name of caller
- *              line                - Line number of caller
- *
- * RETURN:      Address of the allocated memory on success, NULL on failure.
- *
- * DESCRIPTION: Subsystem equivalent of malloc.
- *
- ******************************************************************************/
-
-void *acpi_ut_allocate(acpi_size size,
-		       u32 component, const char *module, u32 line)
-{
-	void *allocation;
-
-	ACPI_FUNCTION_TRACE_U32(ut_allocate, size);
-
-	/* Check for an inadvertent size of zero bytes */
-
-	if (!size) {
-		ACPI_WARNING((module, line,
-			      "Attempt to allocate zero bytes, allocating 1 byte"));
-		size = 1;
-	}
-
-	allocation = acpi_os_allocate(size);
-	if (!allocation) {
-
-		/* Report allocation error */
-
-		ACPI_WARNING((module, line,
-			      "Could not allocate size %u", (u32) size));
-
-		return_PTR(NULL);
-	}
-
-	return_PTR(allocation);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_allocate_zeroed
- *
- * PARAMETERS:  size                - Size of the allocation
- *              component           - Component type of caller
- *              module              - Source file name of caller
- *              line                - Line number of caller
- *
- * RETURN:      Address of the allocated memory on success, NULL on failure.
- *
- * DESCRIPTION: Subsystem equivalent of calloc. Allocate and zero memory.
- *
- ******************************************************************************/
-
-void *acpi_ut_allocate_zeroed(acpi_size size,
-			      u32 component, const char *module, u32 line)
-{
-	void *allocation;
-
-	ACPI_FUNCTION_ENTRY();
-
-	allocation = acpi_ut_allocate(size, component, module, line);
-	if (allocation) {
-
-		/* Clear the memory block */
-
-		ACPI_MEMSET(allocation, 0, size);
-	}
-
-	return (allocation);
-}
-#endif
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 160f13f..77e3eb7 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -130,10 +130,23 @@ void *acpi_ut_allocate_and_track(acpi_size size,
 	struct acpi_debug_mem_block *allocation;
 	acpi_status status;
 
+	/* Check for an inadvertent size of zero bytes */
+
+	if (!size) {
+		ACPI_WARNING((module, line,
+			      "Attempt to allocate zero bytes, allocating 1 byte"));
+		size = 1;
+	}
+
 	allocation =
-	    acpi_ut_allocate(size + sizeof(struct acpi_debug_mem_header),
-			     component, module, line);
+	    acpi_os_allocate(size + sizeof(struct acpi_debug_mem_header));
 	if (!allocation) {
+
+		/* Report allocation error */
+
+		ACPI_WARNING((module, line,
+			      "Could not allocate size %u", (u32)size));
+
 		return (NULL);
 	}
 
@@ -179,9 +192,17 @@ void *acpi_ut_allocate_zeroed_and_track(acpi_size size,
 	struct acpi_debug_mem_block *allocation;
 	acpi_status status;
 
+	/* Check for an inadvertent size of zero bytes */
+
+	if (!size) {
+		ACPI_WARNING((module, line,
+			      "Attempt to allocate zero bytes, allocating 1 byte"));
+		size = 1;
+	}
+
 	allocation =
-	    acpi_ut_allocate_zeroed(size + sizeof(struct acpi_debug_mem_header),
-				    component, module, line);
+	    acpi_os_allocate_zeroed(size +
+				    sizeof(struct acpi_debug_mem_header));
 	if (!allocation) {
 
 		/* Report allocation error */
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 64b8c76..7f95215 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -146,6 +146,8 @@ void acpi_os_release_mutex(acpi_mutex handle);
  */
 void *acpi_os_allocate(acpi_size size);
 
+void *acpi_os_allocate_zeroed(acpi_size size);
+
 void acpi_os_free(void *memory);
 
 void __iomem *acpi_os_map_memory(acpi_physical_address where,
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ebab0d8..ddde61b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -159,15 +159,6 @@ acpi_decode_pld_buffer(u8 *in_buffer,
 		       acpi_size length, struct acpi_pld_info **return_buffer);
 
 /*
- * ACPI Memory management
- */
-void *acpi_allocate(u32 size);
-
-void *acpi_callocate(u32 size);
-
-void acpi_free(void *address);
-
-/*
  * ACPI table load/unload interfaces
  */
 acpi_status acpi_load_table(struct acpi_table_header *table);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f6abf23..fed5af2 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -306,6 +306,33 @@ typedef u32 acpi_physical_address;
 #define ACPI_EXPORT_SYMBOL(symbol)
 #endif
 
+/*******************************************************************************
+ *
+ * Configuration
+ *
+ ******************************************************************************/
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+/*
+ * Memory allocation tracking (used by acpi_exec to detect memory leaks)
+ */
+#define ACPI_MEM_PARAMETERS             _COMPONENT, _acpi_module_name, __LINE__
+#define ACPI_ALLOCATE(a)                acpi_ut_allocate_and_track ((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE_ZEROED(a)         acpi_ut_allocate_zeroed_and_track ((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_FREE(a)                    acpi_ut_free_and_track (a, ACPI_MEM_PARAMETERS)
+#define ACPI_MEM_TRACKING(a)            a
+
+#else
+/*
+ * Normal memory allocation directly via the OS services layer
+ */
+#define ACPI_ALLOCATE(a)                acpi_os_allocate ((acpi_size) (a))
+#define ACPI_ALLOCATE_ZEROED(a)         acpi_os_allocate_zeroed ((acpi_size) (a))
+#define ACPI_FREE(a)                    acpi_os_free (a)
+#define ACPI_MEM_TRACKING(a)
+
+#endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index fda0f3e..7346a92 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -119,6 +119,14 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
 }
 
 /*
+ * Memory allocation/deallocation
+ */
+
+/* Use native linux version of acpi_os_allocate_zeroed */
+
+#define USE_NATIVE_ALLOCATE_ZEROED
+
+/*
  * The irqs_disabled() check is for resume from RAM.
  * Interrupts are off during resume, just like they are for boot.
  * However, boot has  (system_state != SYSTEM_RUNNING)
@@ -140,9 +148,10 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 		irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
-#define ACPI_ALLOCATE(a)        acpi_os_allocate(a)
-#define ACPI_ALLOCATE_ZEROED(a) acpi_os_allocate_zeroed(a)
-#define ACPI_FREE(a)            kfree(a)
+static inline void acpi_os_free(void *a)
+{
+	kfree(a);
+}
 
 #ifndef CONFIG_PREEMPT
 /*
-- 
1.7.10

