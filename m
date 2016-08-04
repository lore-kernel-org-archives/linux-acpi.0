From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/30] ACPICA: Clib: Cleanup va_arg related code
Date: Thu,  4 Aug 2016 16:44:38 +0800
Message-ID: <ad7298c4a518d13b08b44ad89684b10281a731e3.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15310 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801AbcHDIop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:45 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 32701b33cdc48d9bc43da8c9274cf172135b68fc

We in fact is always using the compiler specific stdarg.h for GCC even
when ACPI_USE_STANDARD_HEADERS is not defined. So that the va_arg usages
can always be correct for different compiler options.

Likewise, the va_arg implemented in acenv.h is actually MSVC specific,
this patch also moves it to acmsvc.h and tunes acwin.h to correctly use
it.

After cleaning up, this patch removes all <stdarg.h> inclusions from
other files, but doesn't touch the BSD headers. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/32701b33
Link: https://bugs.acpica.org/show_bug.cgi?id=1298
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h   |   40 ---------------------------------------
 include/acpi/platform/acgcc.h   |    6 ++++++
 include/acpi/platform/aclinux.h |    1 -
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 50ae2d6..f405113 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -342,52 +342,12 @@
 
 /* Use the standard headers from the standard locations */
 
-#include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
 
 #endif				/* ACPI_USE_STANDARD_HEADERS */
 
-/* We will be linking to the standard Clib functions */
-
-#else
-
-/******************************************************************************
- *
- * Not using native C library, use local implementations
- *
- *****************************************************************************/
-
-/*
- * Use local definitions of C library macros and functions. These function
- * implementations may not be as efficient as an inline or assembly code
- * implementation provided by a native C library, but they are functionally
- * equivalent.
- */
-#ifndef va_arg
-
-#ifndef _VALIST
-#define _VALIST
-typedef char *va_list;
-#endif				/* _VALIST */
-
-/* Storage alignment properties */
-
-#define  _AUPBND                (sizeof (acpi_native_int) - 1)
-#define  _ADNBND                (sizeof (acpi_native_int) - 1)
-
-/* Variable argument list macro definitions */
-
-#define _bnd(X, bnd)            (((sizeof (X)) + (bnd)) & (~(bnd)))
-#define va_arg(ap, T)           (*(T *)(((ap) += (_bnd (T, _AUPBND))) - (_bnd (T,_ADNBND))))
-#define va_end(ap)              (ap = (va_list) NULL)
-#define va_start(ap, A)         (void) ((ap) = (((char *) &(A)) + (_bnd (A,_AUPBND))))
-
-#endif				/* va_arg */
-
-/* Use the local (ACPICA) definitions of the clib functions */
-
 #endif				/* ACPI_USE_SYSTEM_CLIBRARY */
 
 #ifndef ACPI_FILE
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index c5a216c..9f79e98 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -44,6 +44,12 @@
 #ifndef __ACGCC_H__
 #define __ACGCC_H__
 
+/*
+ * Use compiler specific <stdarg.h> is a good practice for even when
+ * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
+ */
+#include <stdarg.h>
+
 #define ACPI_INLINE             __inline__
 
 /* Function name is used for debug output. Non-ANSI, compiler-dependent */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index cde6f33..447c33f 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -180,7 +180,6 @@
 
 #else				/* !__KERNEL__ */
 
-#include <stdarg.h>
 #include <string.h>
 #include <stdlib.h>
 #include <ctype.h>
-- 
1.7.10

