From: Len Brown <lenb@kernel.org>
Subject: [PATCH 81/94] ACPICA: Add ACPI_MUTEX_TYPE configuration option
Date: Fri, 09 Jan 2009 04:27:23 -0500
Message-ID: <1685bd404dc2ecce2fdae6410e85ded2f2c0136d.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:63000 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbZAIJ2i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700F2Y6BJG3W6@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:32 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Used to specify whether the OSL mutex interfaces should be used,
or binary semaphores instead.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpiosxf.h         |   13 +++------
 include/acpi/actypes.h          |   54 ++++++++++++++++++++++++++++----------
 include/acpi/platform/acenv.h   |   35 +++++++++++++++++++++----
 include/acpi/platform/aclinux.h |    1 +
 4 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index b91440a..a62720a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -121,8 +121,11 @@ acpi_os_wait_semaphore(acpi_semaphore handle, u32 units, u16 timeout);
 acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
 
 /*
- * Mutex primitives
+ * Mutex primitives. May be configured to use semaphores instead via
+ * ACPI_MUTEX_TYPE (see platform/acenv.h)
  */
+#if (ACPI_MUTEX_TYPE != ACPI_BINARY_SEMAPHORE)
+
 acpi_status acpi_os_create_mutex(acpi_mutex * out_handle);
 
 void acpi_os_delete_mutex(acpi_mutex handle);
@@ -130,13 +133,7 @@ void acpi_os_delete_mutex(acpi_mutex handle);
 acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
 
 void acpi_os_release_mutex(acpi_mutex handle);
-
-/* Temporary macros for Mutex* interfaces, map to existing semaphore xfaces */
-
-#define acpi_os_create_mutex(out_handle)    acpi_os_create_semaphore (1, 1, out_handle)
-#define acpi_os_delete_mutex(handle)        (void) acpi_os_delete_semaphore (handle)
-#define acpi_os_acquire_mutex(handle,time)  acpi_os_wait_semaphore (handle, 1, time)
-#define acpi_os_release_mutex(handle)       (void) acpi_os_signal_semaphore (handle, 1)
+#endif
 
 /*
  * Memory allocation and mapping
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 20f6f9c..24b2cef 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -204,11 +204,10 @@ typedef u32 acpi_physical_address;
 
 /*******************************************************************************
  *
- * OS-dependent and compiler-dependent types
+ * OS-dependent types
  *
  * If the defaults below are not appropriate for the host system, they can
- * be defined in the compiler-specific or OS-specific header, and this will
- * take precedence.
+ * be defined in the OS-specific header, and this will take precedence.
  *
  ******************************************************************************/
 
@@ -218,12 +217,6 @@ typedef u32 acpi_physical_address;
 #define acpi_thread_id			acpi_size
 #endif
 
-/* Object returned from acpi_os_create_lock */
-
-#ifndef acpi_spinlock
-#define acpi_spinlock                   void *
-#endif
-
 /* Flags for acpi_os_acquire_lock/acpi_os_release_lock */
 
 #ifndef acpi_cpu_flags
@@ -240,6 +233,44 @@ typedef u32 acpi_physical_address;
 #endif
 #endif
 
+/*
+ * Synchronization objects - Mutexes, Semaphores, and spin_locks
+ */
+#if (ACPI_MUTEX_TYPE == ACPI_BINARY_SEMAPHORE)
+/*
+ * These macros are used if the host OS does not support a mutex object.
+ * Map the OSL Mutex interfaces to binary semaphores.
+ */
+#define acpi_mutex                      acpi_semaphore
+#define acpi_os_create_mutex(out_handle) acpi_os_create_semaphore (1, 1, out_handle)
+#define acpi_os_delete_mutex(handle)    (void) acpi_os_delete_semaphore (handle)
+#define acpi_os_acquire_mutex(handle,time) acpi_os_wait_semaphore (handle, 1, time)
+#define acpi_os_release_mutex(handle)   (void) acpi_os_signal_semaphore (handle, 1)
+#endif
+
+/* Configurable types for synchronization objects */
+
+#ifndef acpi_spinlock
+#define acpi_spinlock                   void *
+#endif
+
+#ifndef acpi_semaphore
+#define acpi_semaphore                  void *
+#endif
+
+#ifndef acpi_mutex
+#define acpi_mutex                      void *
+#endif
+
+/*******************************************************************************
+ *
+ * Compiler-dependent types
+ *
+ * If the defaults below are not appropriate for the host compiler, they can
+ * be defined in the compiler-specific header, and this will take precedence.
+ *
+ ******************************************************************************/
+
 /* Use C99 uintptr_t for pointer casting if available, "void *" otherwise */
 
 #ifndef acpi_uintptr_t
@@ -353,11 +384,6 @@ struct uint32_struct {
 	u32 hi;
 };
 
-/* Synchronization objects */
-
-#define acpi_mutex                      void *
-#define acpi_semaphore                  void *
-
 /*
  * Acpi integer width. In ACPI version 1, integers are 32 bits. In ACPI
  * version 2, integers are 64 bits. Note that this pertains to the ACPI integer
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index cbae39c..e62f10d 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -44,13 +44,26 @@
 #ifndef __ACENV_H__
 #define __ACENV_H__
 
-/*
+/* Types for ACPI_MUTEX_TYPE */
+
+#define ACPI_BINARY_SEMAPHORE       0
+#define ACPI_OSL_MUTEX              1
+
+/* Types for DEBUGGER_THREADING */
+
+#define DEBUGGER_SINGLE_THREADED    0
+#define DEBUGGER_MULTI_THREADED     1
+
+/******************************************************************************
+ *
  * Configuration for ACPI tools and utilities
- */
+ *
+ *****************************************************************************/
+
 #ifdef ACPI_LIBRARY
 /*
  * Note: The non-debug version of the acpi_library does not contain any
- * debug support, for minimimal size. The debug version uses ACPI_FULL_DEBUG
+ * debug support, for minimal size. The debug version uses ACPI_FULL_DEBUG
  */
 #define ACPI_USE_LOCAL_CACHE
 #endif
@@ -167,6 +180,19 @@
 
 /*! [End] no source code translation !*/
 
+/******************************************************************************
+ *
+ * Miscellaneous configuration
+ *
+ *****************************************************************************/
+
+/*
+ * Are mutexes supported by the host? default is no, use binary semaphores.
+ */
+#ifndef ACPI_MUTEX_TYPE
+#define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
+#endif
+
 /*
  * Debugger threading model
  * Use single threaded if the entire subsystem is contained in an application
@@ -175,9 +201,6 @@
  * By default the model is single threaded if ACPI_APPLICATION is set,
  * multi-threaded if ACPI_APPLICATION is not set.
  */
-#define DEBUGGER_SINGLE_THREADED    0
-#define DEBUGGER_MULTI_THREADED     1
-
 #ifndef DEBUGGER_THREADING
 #ifdef ACPI_APPLICATION
 #define DEBUGGER_THREADING          DEBUGGER_SINGLE_THREADED
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 0515e75..3cabf88 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -46,6 +46,7 @@
 
 #define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_DO_WHILE_0
+#define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 
 #ifdef __KERNEL__
 
-- 
1.5.6.6

