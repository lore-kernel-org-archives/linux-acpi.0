From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/60] ACPICA: Make acpi_thread_id no longer configurable,
 always u64
Date: Mon, 25 Oct 2010 02:20:16 -0400
Message-ID: <28eb3fcf8762a3b52f4fef5af29dce50d23c7151.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:41773 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0JYGVw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 02:21:52 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU009761NZP205@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 01:21:44 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Change definition of acpi_thread_id to always be a u64. This
simplifies the code, especially any printf output. u64 is
the only common data type for all thread_id types across all
operating systems. We now force the OSL to cast the native
thread_id type to u64 before returning the value to ACPICA
(via acpi_os_get_thread_id).

Signed-off-by: Lin Ming <ming.m.lin@intel.com
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/achware.h   |    2 +-
 drivers/acpi/acpica/aclocal.h   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    2 +-
 drivers/acpi/acpica/evmisc.c    |    2 +-
 drivers/acpi/acpica/exmutex.c   |   10 +++++-----
 drivers/acpi/acpica/utdebug.c   |    7 +++----
 drivers/acpi/acpica/utmutex.c   |   29 ++++++++++++++++-------------
 include/acpi/actypes.h          |   17 ++++++++++-------
 include/acpi/platform/aclinux.h |    7 +++----
 9 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index e7c5545..167470a 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -121,7 +121,6 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
 				 void *context);
 
-#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwpci - PCI configuration support
  */
@@ -129,6 +128,7 @@ acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
 
+#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwtimer - ACPI Timer prototypes
  */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 53f7512..04ce322 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1001,7 +1001,7 @@ struct acpi_port_info {
 struct acpi_db_method_info {
 	acpi_handle main_thread_gate;
 	acpi_handle thread_complete_gate;
-	u32 *threads;
+	acpi_thread_id *threads;
 	u32 num_threads;
 	u32 num_created;
 	u32 num_completed;
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 64750ee..d94dd89 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -573,7 +573,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 				acpi_os_release_mutex(method_desc->method.
 						      mutex->mutex.os_mutex);
-				method_desc->method.mutex->mutex.thread_id = NULL;
+				method_desc->method.mutex->mutex.thread_id = 0;
 			}
 		}
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index df0aea9..fcaed9f 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -553,7 +553,7 @@ acpi_status acpi_ev_release_global_lock(void)
 	acpi_gbl_global_lock_acquired = FALSE;
 
 	/* Release the local GL mutex */
-	acpi_ev_global_lock_thread_id = NULL;
+	acpi_ev_global_lock_thread_id = 0;
 	acpi_ev_global_lock_acquired = 0;
 	acpi_os_release_mutex(acpi_gbl_global_lock_mutex->mutex.os_mutex);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index f73be97..6af14e4 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -336,7 +336,7 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 
 	/* Clear mutex info */
 
-	obj_desc->mutex.thread_id = NULL;
+	obj_desc->mutex.thread_id = 0;
 	return_ACPI_STATUS(status);
 }
 
@@ -393,10 +393,10 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	if ((owner_thread->thread_id != walk_state->thread->thread_id) &&
 	    (obj_desc != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
-			    ACPI_CAST_PTR(void, walk_state->thread->thread_id),
+			    "Thread %u cannot release Mutex [%4.4s] acquired by thread %u",
+			    (u32)walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    ACPI_CAST_PTR(void, owner_thread->thread_id)));
+			    (u32)owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
@@ -488,7 +488,7 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 		/* Mark mutex unowned */
 
 		obj_desc->mutex.owner_thread = NULL;
-		obj_desc->mutex.thread_id = NULL;
+		obj_desc->mutex.thread_id = 0;
 
 		/* Update Thread sync_level (Last mutex is the important one) */
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 9835106..f21c486 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -179,9 +179,8 @@ acpi_debug_print(u32 requested_debug_level,
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %p to TID %p ****\n\n",
-			     ACPI_CAST_PTR(void, acpi_gbl_prev_thread_id),
-			     ACPI_CAST_PTR(void, thread_id));
+			    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
+			     (u32)acpi_gbl_prev_thread_id, (u32)thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +193,7 @@ acpi_debug_print(u32 requested_debug_level,
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%p] ", ACPI_CAST_PTR(void, thread_id));
+		acpi_os_printf("[%u] ", (u32)thread_id);
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index b07b425..d9efa49 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -228,18 +228,17 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					ACPI_ERROR((AE_INFO,
-						    "Mutex [%s] already acquired by this thread [%p]",
+						    "Mutex [%s] already acquired by this thread [%u]",
 						    acpi_ut_get_mutex_name
 						    (mutex_id),
-						    ACPI_CAST_PTR(void,
-								  this_thread_id)));
+						    (u32)this_thread_id));
 
 					return (AE_ALREADY_ACQUIRED);
 				}
 
 				ACPI_ERROR((AE_INFO,
-					    "Invalid acquire order: Thread %p owns [%s], wants [%s]",
-					    ACPI_CAST_PTR(void, this_thread_id),
+					    "Invalid acquire order: Thread %u owns [%s], wants [%s]",
+					    (u32)this_thread_id,
 					    acpi_ut_get_mutex_name(i),
 					    acpi_ut_get_mutex_name(mutex_id)));
 
@@ -250,24 +249,24 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %p attempting to acquire Mutex [%s]\n",
-			  ACPI_CAST_PTR(void, this_thread_id),
+			  "Thread %u attempting to acquire Mutex [%s]\n",
+			  (u32)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %p acquired Mutex [%s]\n",
-				  ACPI_CAST_PTR(void, this_thread_id),
+				  "Thread %u acquired Mutex [%s]\n",
+				  (u32)this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %p could not acquire Mutex [0x%X]",
-				ACPI_CAST_PTR(void, this_thread_id), mutex_id));
+				"Thread %u could not acquire Mutex [0x%X]",
+				(u32)this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -287,10 +286,14 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 
 acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 {
+	acpi_thread_id this_thread_id;
+
 	ACPI_FUNCTION_NAME(ut_release_mutex);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %p releasing Mutex [%s]\n",
-			  ACPI_CAST_PTR(void, acpi_os_get_thread_id()),
+	this_thread_id = acpi_os_get_thread_id();
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %u releasing Mutex [%s]\n",
+			  (u32)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 332d076..864cfae 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -115,7 +115,6 @@
  *
  * ACPI_SIZE        16/32/64-bit unsigned value
  * ACPI_NATIVE_INT  16/32/64-bit signed value
- *
  */
 
 /*******************************************************************************
@@ -132,6 +131,16 @@ typedef COMPILER_DEPENDENT_INT64 INT64;
 
 /*! [End] no source code translation !*/
 
+/*
+ * Value returned by acpi_os_get_thread_id. There is no standard "thread_id"
+ * across operating systems or even the various UNIX systems. Since ACPICA
+ * only needs the thread ID as a unique thread identifier, we use a u64
+ * as the only common data type - it will accommodate any type of pointer or
+ * any type of integer. It is up to the host-dependent OSL to cast the
+ * native thread ID type to a u64 (in acpi_os_get_thread_id).
+ */
+#define acpi_thread_id                  u64
+
 /*******************************************************************************
  *
  * Types specific to 64-bit targets
@@ -211,12 +220,6 @@ typedef u32 acpi_physical_address;
  *
  ******************************************************************************/
 
-/* Value returned by acpi_os_get_thread_id */
-
-#ifndef acpi_thread_id
-#define acpi_thread_id			acpi_size
-#endif
-
 /* Flags for acpi_os_acquire_lock/acpi_os_release_lock */
 
 #ifndef acpi_cpu_flags
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 103f08a..572189e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -75,7 +75,6 @@
 #define acpi_cache_t                        struct kmem_cache
 #define acpi_spinlock                       spinlock_t *
 #define acpi_cpu_flags                      unsigned long
-#define acpi_thread_id                      struct task_struct *
 
 #else /* !__KERNEL__ */
 
@@ -88,7 +87,7 @@
 /* Host-dependent types and defines for user-space ACPICA */
 
 #define ACPI_FLUSH_CPU_CACHE()
-#define acpi_thread_id                      pthread_t
+#define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
 #if defined(__ia64__) || defined(__x86_64__)
 #define ACPI_MACHINE_WIDTH          64
@@ -113,12 +112,13 @@
 
 
 #ifdef __KERNEL__
+#include <acpi/actypes.h>
 /*
  * Overrides for in-kernel ACPICA
  */
 static inline acpi_thread_id acpi_os_get_thread_id(void)
 {
-	return current;
+	return (acpi_thread_id)(unsigned long)current;
 }
 
 /*
@@ -127,7 +127,6 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
  * However, boot has  (system_state != SYSTEM_RUNNING)
  * to quiet __might_sleep() in kmalloc() and resume does not.
  */
-#include <acpi/actypes.h>
 static inline void *acpi_os_allocate(acpi_size size)
 {
 	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
-- 
1.7.3.2.90.gd4c43

