From: Lv Zheng <lv.zheng@intel.com>
Subject: [RESEND PATCH v2 02/19] ACPICA: Update compilation environment settings.
Date: Thu, 20 Dec 2012 09:07:15 +0800
Message-ID: <ff943bd4ff3613dbc92547a86b4ee6282c19a0d6.1355810293.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9900 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab2LTBHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 20:07:25 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch does not affect the generation of the Linux binary.
This patch decreases 300 lines of 20121018 divergence.diff.

This patch updates architecture specific environment settings for compiling
ACPICA as such enhancement already has been done in ACPICA.

Note that the appended compiler default settings in the
<acpi/platform/acenv.h> will deprecate some of the macros defined in the
architecture specific <asm/acpi.h>. Thus two of the <asm/acpi.h> headers
have been cleaned up in this patch accordingly.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  No changes can be found.
---
Divergences fixing result:
  Before applying: 3420 Lines, 115.8 Kbytes
  After applying: 3120 Lines, 107.7 Kbytes
---
 arch/ia64/include/asm/acpi.h  |    4 -
 arch/x86/include/asm/acpi.h   |    4 -
 include/acpi/platform/acenv.h |  217 +++++++++++++++++++----------------------
 include/acpi/platform/acgcc.h |    4 -
 4 files changed, 102 insertions(+), 127 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 301609c..cd0746c 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -52,10 +52,6 @@
 
 /* Asm macros */
 
-#define ACPI_ASM_MACROS
-#define BREAKPOINT3
-#define ACPI_DISABLE_IRQS() local_irq_disable()
-#define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()
 
 static inline int
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 0c44630..b31bf97 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -49,10 +49,6 @@
 
 /* Asm macros */
 
-#define ACPI_ASM_MACROS
-#define BREAKPOINT3
-#define ACPI_DISABLE_IRQS() local_irq_disable()
-#define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
 int __acpi_acquire_global_lock(unsigned int *lock);
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index e3409b6..68a58a1 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -44,6 +44,11 @@
 #ifndef __ACENV_H__
 #define __ACENV_H__
 
+/*
+ * Environment configuration. The purpose of this file is to interface ACPICA
+ * to the local environment. This includes compiler-specific, OS-specific,
+ * and machine-specific configuration.
+ */
 /* Types for ACPI_MUTEX_TYPE */
 
 #define ACPI_BINARY_SEMAPHORE       0
@@ -99,99 +104,101 @@
 #define ACPI_DISASSEMBLER
 #endif
 
-/*
- * Environment configuration.  The purpose of this file is to interface to the
- * local generation environment.
- *
- * 1) ACPI_USE_SYSTEM_CLIBRARY - Define this if linking to an actual C library.
- *      Otherwise, local versions of string/memory functions will be used.
- * 2) ACPI_USE_STANDARD_HEADERS - Define this if linking to a C library and
- *      the standard header files may be used.
- *
- * The ACPI subsystem only uses low level C library functions that do not call
- * operating system services and may therefore be inlined in the code.
- *
- * It may be necessary to tailor these include files to the target
- * generation environment.
- *
- *
- * Functions and constants used from each header:
- *
- * string.h:    memcpy
- *              memset
- *              strcat
- *              strcmp
- *              strcpy
- *              strlen
- *              strncmp
- *              strncat
- *              strncpy
- *
- * stdlib.h:    strtoul
- *
- * stdarg.h:    va_list
- *              va_arg
- *              va_start
- *              va_end
- *
- */
 
 /*! [Begin] no source code translation */
 
+/******************************************************************************
+ *
+ * Host configuration files. The compiler configuration files are included
+ * by the host files.
+ *
+ *****************************************************************************/
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
-#elif defined(_AED_EFI)
-#include "acefi.h"
-
-#elif defined(WIN32)
-#include "acwin.h"
-
-#elif defined(WIN64)
-#include "acwin64.h"
-
-#elif defined(MSDOS)		/* Must appear after WIN32 and WIN64 check */
-#include "acdos16.h"
-
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include "acfreebsd.h"
 
 #elif defined(__NetBSD__)
 #include "acnetbsd.h"
 
+#elif defined(__sun)
+#include "acsolaris.h"
+
 #elif defined(MODESTO)
 #include "acmodesto.h"
 
 #elif defined(NETWARE)
 #include "acnetware.h"
 
-#elif defined(__sun)
-#include "acsolaris.h"
+#elif defined(_CYGWIN)
+#include "accygwin.h"
 
-#else
+#elif defined(WIN32)
+#include "acwin.h"
+
+#elif defined(WIN64)
+#include "acwin64.h"
 
-/* All other environments */
+#elif defined(_WRS_LIB_BUILD)
+#include "acvxworks.h"
 
-#define ACPI_USE_STANDARD_HEADERS
+#elif defined(__OS2__)
+#include "acos2.h"
 
-#define COMPILER_DEPENDENT_INT64   long long
-#define COMPILER_DEPENDENT_UINT64  unsigned long long
+#elif defined(_AED_EFI)
+#include "acefi.h"
+
+#elif defined(__HAIKU__)
+#include "achaiku.h"
+
+#else
+
+/* Unknown environment */
 
+#error Unknown target environment
 #endif
 
 /*! [End] no source code translation !*/
 
 /******************************************************************************
  *
- * Miscellaneous configuration
+ * Setup defaults for the required symbols that were not defined in one of
+ * the host/compiler files above.
  *
  *****************************************************************************/
 
+/* 64-bit data types */
+
+#ifndef COMPILER_DEPENDENT_INT64
+#define COMPILER_DEPENDENT_INT64   long long
+#endif
+
+#ifndef COMPILER_DEPENDENT_UINT64
+#define COMPILER_DEPENDENT_UINT64  unsigned long long
+#endif
+
 /* Type of mutex supported by host. Default is binary semaphores. */
 #ifndef ACPI_MUTEX_TYPE
 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 #endif
 
+/* Global Lock acquire/release */
+
+#ifndef ACPI_ACQUIRE_GLOBAL_LOCK
+#define ACPI_ACQUIRE_GLOBAL_LOCK(Glptr, acquired) acquired = 1
+#endif
+
+#ifndef ACPI_RELEASE_GLOBAL_LOCK
+#define ACPI_RELEASE_GLOBAL_LOCK(Glptr, pending) pending = 0
+#endif
+
+/* Flush CPU cache - used when going to sleep. Wbinvd or similar. */
+
+#ifndef ACPI_FLUSH_CPU_CACHE
+#define ACPI_FLUSH_CPU_CACHE()
+#endif
+
 /* "inline" keywords - configurable since inline is not standardized */
 
 #ifndef ACPI_INLINE
@@ -199,6 +206,30 @@
 #endif
 
 /*
+ * Configurable calling conventions:
+ *
+ * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
+ * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
+ * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
+ * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
+ */
+#ifndef ACPI_SYSTEM_XFACE
+#define ACPI_SYSTEM_XFACE
+#endif
+
+#ifndef ACPI_EXTERNAL_XFACE
+#define ACPI_EXTERNAL_XFACE
+#endif
+
+#ifndef ACPI_INTERNAL_XFACE
+#define ACPI_INTERNAL_XFACE
+#endif
+
+#ifndef ACPI_INTERNAL_VAR_XFACE
+#define ACPI_INTERNAL_VAR_XFACE
+#endif
+
+/*
  * Debugger threading model
  * Use single threaded if the entire subsystem is contained in an application
  * Use multiple threaded when the subsystem is running in the kernel.
@@ -223,11 +254,22 @@
 
 #define ACPI_IS_ASCII(c)  ((c) < 0x80)
 
-#ifdef ACPI_USE_SYSTEM_CLIBRARY
 /*
- * Use the standard C library headers.
- * We want to keep these to a minimum.
+ * ACPI_USE_SYSTEM_CLIBRARY - Define this if linking to an actual C library.
+ *      Otherwise, local versions of string/memory functions will be used.
+ * ACPI_USE_STANDARD_HEADERS - Define this if linking to a C library and
+ *      the standard header files may be used.
+ *
+ * The ACPICA subsystem only uses low level C library functions that do not call
+ * operating system services and may therefore be inlined in the code.
+ *
+ * It may be necessary to tailor these include files to the target
+ * generation environment.
  */
+#ifdef ACPI_USE_SYSTEM_CLIBRARY
+
+/* Use the standard C library headers. We want to keep these to a minimum. */
+
 #ifdef ACPI_USE_STANDARD_HEADERS
 /* Use the standard headers from the standard locations */
 #include <stdarg.h>
@@ -290,7 +332,7 @@ typedef char *va_list;
 /* Variable argument list macro definitions */
 #define _bnd(X, bnd)            (((sizeof (X)) + (bnd)) & (~(bnd)))
 #define va_arg(ap, T)           (*(T *)(((ap) += (_bnd (T, _AUPBND))) - (_bnd (T,_ADNBND))))
-#define va_end(ap)              (void) 0
+#define va_end(ap)              (ap = (va_list) NULL)
 #define va_start(ap, A)         (void) ((ap) = (((char *) &(A)) + (_bnd (A,_AUPBND))))
 
 #endif				/* va_arg */
@@ -314,59 +356,4 @@ typedef char *va_list;
 
 #endif				/* ACPI_USE_SYSTEM_CLIBRARY */
 
-/******************************************************************************
- *
- * Assembly code macros
- *
- *****************************************************************************/
-
-/*
- * Handle platform- and compiler-specific assembly language differences.
- * These should already have been defined by the platform includes above.
- *
- * Notes:
- * 1) Interrupt 3 is used to break into a debugger
- * 2) Interrupts are turned off during ACPI register setup
- */
-
-/* Unrecognized compiler, use defaults */
-
-#ifndef ACPI_ASM_MACROS
-
-/*
- * Calling conventions:
- *
- * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
- * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
- * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
- * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
- */
-#define ACPI_SYSTEM_XFACE
-#define ACPI_EXTERNAL_XFACE
-#define ACPI_INTERNAL_XFACE
-#define ACPI_INTERNAL_VAR_XFACE
-
-#define ACPI_ASM_MACROS
-#define BREAKPOINT3
-#define ACPI_DISABLE_IRQS()
-#define ACPI_ENABLE_IRQS()
-#define ACPI_ACQUIRE_GLOBAL_LOCK(Glptr, acq)
-#define ACPI_RELEASE_GLOBAL_LOCK(Glptr, acq)
-
-#endif				/* ACPI_ASM_MACROS */
-
-#ifdef ACPI_APPLICATION
-
-/* Don't want software interrupts within a ring3 application */
-
-#undef BREAKPOINT3
-#define BREAKPOINT3
-#endif
-
-/******************************************************************************
- *
- * Compiler-specific information is contained in the compiler-specific
- * headers.
- *
- *****************************************************************************/
 #endif				/* __ACENV_H__ */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 72553b0..7433ad1 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -64,8 +64,4 @@
  */
 #define ACPI_UNUSED_VAR __attribute__ ((unused))
 
-#ifdef _ANSI
-#define inline
-#endif
-
 #endif				/* __ACGCC_H__ */
-- 
1.7.10

