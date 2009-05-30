From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/65] ACPICA: Linux OSL: cleanup/update/merge
Date: Fri, 29 May 2009 21:41:57 -0400
Message-ID: <e0c437bcca6926b541c738b5c64445654750b365.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbZE3BnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:04 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF004PVORF9LR3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:52 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Merge the OSL with the actual file used by Linux, so that the
file does not require patching when integrated with Linux. General
cleanup and some restructuring.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/platform/aclinux.h |   63 +++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 6d49b2a..fcb8e4b 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -1,11 +1,11 @@
 /******************************************************************************
  *
- * Name: aclinux.h - OS specific defines, etc.
+ * Name: aclinux.h - OS specific defines, etc. for Linux
  *
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2009, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -44,10 +44,13 @@
 #ifndef __ACLINUX_H__
 #define __ACLINUX_H__
 
+/* Common (in-kernel/user-space) ACPICA configuration */
+
 #define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_DO_WHILE_0
 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 
+
 #ifdef __KERNEL__
 
 #include <linux/string.h>
@@ -63,15 +66,18 @@
 #include <linux/spinlock_types.h>
 #include <asm/current.h>
 
-/* Host-dependent types and defines */
+/* Host-dependent types and defines for in-kernel ACPICA */
 
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
-#define acpi_cache_t                        struct kmem_cache
-#define acpi_spinlock                   spinlock_t *
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
-#else				/* !__KERNEL__ */
+#define acpi_cache_t                        struct kmem_cache
+#define acpi_spinlock                       spinlock_t *
+#define acpi_cpu_flags                      unsigned long
+#define acpi_thread_id                      struct task_struct *
+
+#else /* !__KERNEL__ */
 
 #include <stdarg.h>
 #include <string.h>
@@ -79,6 +85,11 @@
 #include <ctype.h>
 #include <unistd.h>
 
+/* Host-dependent types and defines for user-space ACPICA */
+
+#define ACPI_FLUSH_CPU_CACHE()
+#define acpi_thread_id                      pthread_t
+
 #if defined(__ia64__) || defined(__x86_64__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
@@ -94,17 +105,17 @@
 #define __cdecl
 #endif
 
-#define ACPI_FLUSH_CPU_CACHE()
-#endif				/* __KERNEL__ */
+#endif /* __KERNEL__ */
 
 /* Linux uses GCC */
 
 #include "acgcc.h"
 
-#define acpi_cpu_flags unsigned long
-
-#define acpi_thread_id struct task_struct *
 
+#ifdef __KERNEL__
+/*
+ * Overrides for in-kernel ACPICA
+ */
 static inline acpi_thread_id acpi_os_get_thread_id(void)
 {
 	return current;
@@ -119,30 +130,32 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
 #include <acpi/actypes.h>
 static inline void *acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
 }
+
 static inline void *acpi_os_allocate_zeroed(acpi_size size)
 {
-	return kzalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+	return kzalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
 static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
 	return kmem_cache_zalloc(cache,
-				 irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+		irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
-#define ACPI_ALLOCATE(a)	acpi_os_allocate(a)
-#define ACPI_ALLOCATE_ZEROED(a)	acpi_os_allocate_zeroed(a)
-#define ACPI_FREE(a)		kfree(a)
+#define ACPI_ALLOCATE(a)        acpi_os_allocate(a)
+#define ACPI_ALLOCATE_ZEROED(a) acpi_os_allocate_zeroed(a)
+#define ACPI_FREE(a)            kfree(a)
 
-/*
- * We need to show where it is safe to preempt execution of ACPICA
- */
-#define ACPI_PREEMPTION_POINT()		\
-	do {				\
-		if (!irqs_disabled())	\
-			cond_resched();	\
+/* Used within ACPICA to show where it is safe to preempt execution */
+
+#define ACPI_PREEMPTION_POINT() \
+	do { \
+		if (!irqs_disabled()) \
+			cond_resched(); \
 	} while (0)
 
-#endif				/* __ACLINUX_H__ */
+#endif /* __KERNEL__ */
+
+#endif /* __ACLINUX_H__ */
-- 
1.6.0.6

