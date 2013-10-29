From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/20] ACPICA: Update aclinux.h for new OSL override mechanism.
Date: Tue, 29 Oct 2013 09:30:41 +0800
Message-ID: <e7003b509f979144564b5404f26d37877567d58b.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56563 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769Ab3J2Bau (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:50 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The new ACPICA OSL override mechanism is used to solve these issues
for the Linux OSL:
1. Linux can implement OSL using macro.
2. Linux can implement OSL using inlined function.
3. Linux can leave OSL not implemented for __KERNEL__ undefined code
   fragments.
4. Linux can add sparse declarators (__iomem) to OSL.
5. Linux can add memory tuning declarators (__init/__exit) to OSL.
This patch also moves Linux specific OSL to aclinux.h which has not been
maintained in the ACPICA code base.  Lv Zheng.

Known issue:
1. Inclusion of actypes.h
   From ACPICA's perspective, actypes.h should be included after inclusion
   of acenv.h.  But currently in Linux, aclinux.h included by acenv.h has
   included actypes.h to find ACPICA types for inline functions.  This is a
   known and existing issue and currently there is no real problem caused
   by this issue for Linux kernel build.  Thus this issue is not covered by
   this cleanup commit.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpiosxf.h         |   18 +-----
 include/acpi/platform/aclinux.h |  118 +++++++++++++++++++++++++++++----------
 2 files changed, 91 insertions(+), 45 deletions(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 55165fc..01e6c6d 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -78,7 +78,7 @@ struct acpi_signal_fatal_info {
  * OSL Initialization and shutdown primitives
  */
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize
-acpi_status __init acpi_os_initialize(void);
+acpi_status acpi_os_initialize(void);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate
@@ -192,22 +192,18 @@ void acpi_os_free(void *memory);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_map_memory
-void __iomem *acpi_os_map_memory(acpi_physical_address where,
-				acpi_size length);
+void *acpi_os_map_memory(acpi_physical_address where, acpi_size length);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_unmap_memory
-void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
+void acpi_os_unmap_memory(void *logical_address, acpi_size size);
 #endif
-void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size);
 
-#ifdef ACPI_FUTURE_USAGE
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_physical_address
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
 			     acpi_physical_address * physical_address);
 #endif
-#endif
 
 /*
  * Memory/Object Cache
@@ -251,9 +247,6 @@ acpi_os_remove_interrupt_handler(u32 interrupt_number,
 				 acpi_osd_handler service_routine);
 #endif
 
-void acpi_os_gpe_count(u32 gpe_number);
-void acpi_os_fixed_event_count(u32 fixed_event_number);
-
 /*
  * Threads and Scheduling
  */
@@ -267,9 +260,6 @@ acpi_os_execute(acpi_execute_type type,
 		acpi_osd_exec_callback function, void *context);
 #endif
 
-acpi_status
-acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
-
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_events_complete
 void acpi_os_wait_events_complete(void);
 #endif
@@ -357,14 +347,12 @@ void acpi_os_vprintf(const char *format, va_list args);
 void acpi_os_redirect_output(void *destination);
 #endif
 
-#ifdef ACPI_FUTURE_USAGE
 /*
  * Debug input
  */
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
 acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read);
 #endif
-#endif
 
 /*
  * Obtain ACPI table(s)
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 04e87a3..ab57930 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -50,7 +50,6 @@
 #define ACPI_USE_DO_WHILE_0
 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 
-
 #ifdef __KERNEL__
 
 #include <linux/string.h>
@@ -58,11 +57,13 @@
 #include <linux/ctype.h>
 #include <linux/sched.h>
 #include <linux/atomic.h>
-#include <asm/div64.h>
-#include <asm/acpi.h>
+#include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/spinlock_types.h>
-#include <asm/current.h>
+#ifdef EXPORT_ACPI_INTERFACES
+#include <linux/export.h>
+#endif
+#include <asm/acpi.h>
 
 /* Host-dependent types and defines for in-kernel ACPICA */
 
@@ -109,23 +110,29 @@
 #include <acpi/platform/acgcc.h>
 
 #ifdef __KERNEL__
+
+/*
+ * FIXME: Inclusion of actypes.h
+ * Linux kernel need this before defining inline OSL interfaces as
+ * actypes.h need to be included to find ACPICA type definitions.
+ * Since from ACPICA's perspective, the actypes.h should be included after
+ * acenv.h (aclinux.h), this leads to a inclusion mis-ordering issue.
+ */
 #include <acpi/actypes.h>
+
 /*
  * Overrides for in-kernel ACPICA
  */
-static inline acpi_thread_id acpi_os_get_thread_id(void)
-{
-	return (acpi_thread_id)(unsigned long)current;
-}
+acpi_status __init acpi_os_initialize(void);
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize
+
+acpi_status acpi_os_terminate(void);
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate
 
 /*
  * Memory allocation/deallocation
  */
 
-/* Use native linux version of acpi_os_allocate_zeroed */
-
-#define USE_NATIVE_ALLOCATE_ZEROED
-
 /*
  * The irqs_disabled() check is for resume from RAM.
  * Interrupts are off during resume, just like they are for boot.
@@ -134,26 +141,45 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
  */
 static inline void *acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+	return kmalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
 }
 
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate
+
+/* Use native linux version of acpi_os_allocate_zeroed */
+
 static inline void *acpi_os_allocate_zeroed(acpi_size size)
 {
-	return kzalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+	return kzalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+}
+
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
+#define USE_NATIVE_ALLOCATE_ZEROED
+
+static inline void acpi_os_free(void *memory)
+{
+	kfree(memory);
 }
 
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_free
+
 static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
 	return kmem_cache_zalloc(cache,
-		irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+				 irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
 }
 
-static inline void acpi_os_free(void *a)
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_object
+
+static inline acpi_thread_id acpi_os_get_thread_id(void)
 {
-	kfree(a);
+	return (acpi_thread_id) (unsigned long)current;
 }
 
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
+
 #ifndef CONFIG_PREEMPT
+
 /*
  * Used within ACPICA to show where it is safe to preempt execution
  * when CONFIG_PREEMPT=n
@@ -163,6 +189,7 @@ static inline void acpi_os_free(void *a)
 		if (!irqs_disabled()) \
 			cond_resched(); \
 	} while (0)
+
 #endif
 
 /*
@@ -172,21 +199,52 @@ static inline void acpi_os_free(void *a)
  * all locks to the name of the argument of acpi_os_create_lock(), which
  * prevents lockdep from reporting false positives for ACPICA locks.
  */
-#define acpi_os_create_lock(__handle)				\
-({								\
-	spinlock_t *lock = ACPI_ALLOCATE(sizeof(*lock));	\
-								\
-	if (lock) {						\
-		*(__handle) = lock;				\
-		spin_lock_init(*(__handle));			\
-	}							\
-	lock ? AE_OK : AE_NO_MEMORY;				\
-})
+#define acpi_os_create_lock(__handle) \
+	({ \
+		spinlock_t *lock = ACPI_ALLOCATE(sizeof(*lock)); \
+		if (lock) { \
+			*(__handle) = lock; \
+			spin_lock_init(*(__handle)); \
+		} \
+		lock ? AE_OK : AE_NO_MEMORY; \
+	})
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
 
-#ifdef EXPORT_ACPI_INTERFACES
-#include <linux/export.h>
-#endif
+void __iomem *acpi_os_map_memory(acpi_physical_address where, acpi_size length);
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_map_memory
+
+void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_unmap_memory
+
+/*
+ * OSL interfaces used by debugger/disassembler
+ */
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
+
+/*
+ * OSL interfaces used by utilities
+ */
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_name
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_index
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_address
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_open_directory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_next_filename
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_directory
+
+/*
+ * OSL interfaces added by Linux
+ */
+void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size);
+
+void acpi_os_gpe_count(u32 gpe_number);
+
+void acpi_os_fixed_event_count(u32 fixed_event_number);
+
+acpi_status
+acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
 
 #endif				/* __KERNEL__ */
 
-- 
1.7.10

