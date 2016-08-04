From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/30] ACPICA: Clib: Fix wrong mini C library usage
Date: Thu,  4 Aug 2016 16:44:44 +0800
Message-ID: <7159e94ab3296f5c9c94157f34c65ebdff9c2abc.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51546 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbcHDIox (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:53 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 4aab18466b56f3660f27cffd3c0160900737f844

When mini C library is used, we should have the following macros undefined.
The only user should be the EFI applications:
  ACPI_USE_SYSTEM_CLIBRARY=n
  ACPI_USE_STANDARD_HEADERS=n
All other applications uses the compiler specific library:
  ACPI_USE_SYSTEM_CLIBRARY=y
  ACPI_USE_STANDARD_HEADERS=y
Linux/BSD kernels are the kind of hosts providing C library but does not
provide the standard headers:
  ACPI_USE_SYSTEM_CLIBRARY=y
  ACPI_USE_STANDARD_HEADERS=n
But the above logic hasn't been synchronized between the header files.

This patch synchronizes all header files to correct C library usages for
different platforms. This patch moves all ACPI_USE_SYSTEM_CLIRARY and
ACPI_USE_STANDARD_HEADERS to the top most lines of a platform specific
header.

After synchronization, ACPI_USE_SYSTEM_CLIRARY definition can be removed
for ACPI_APPLICATION. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/4aab1846
Link: https://bugs.acpica.org/show_bug.cgi?id=1299
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h   |    7 ++-----
 include/acpi/platform/aclinux.h |    7 ++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index f405113..ee5c0b9 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -149,7 +149,6 @@
 /* Common for all ACPICA applications */
 
 #ifdef ACPI_APPLICATION
-#define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_LOCAL_CACHE
 #endif
 
@@ -326,7 +325,8 @@
  * ACPI_USE_SYSTEM_CLIBRARY - Define this if linking to an actual C library.
  *      Otherwise, local versions of string/memory functions will be used.
  * ACPI_USE_STANDARD_HEADERS - Define this if linking to a C library and
- *      the standard header files may be used.
+ *      the standard header files may be used. Defining this implies that
+ *      ACPI_USE_SYSTEM_CLIBRARY has been defined.
  *
  * The ACPICA subsystem only uses low level C library functions that do not
  * call operating system services and may therefore be inlined in the code.
@@ -334,7 +334,6 @@
  * It may be necessary to tailor these include files to the target
  * generation environment.
  */
-#ifdef ACPI_USE_SYSTEM_CLIBRARY
 
 /* Use the standard C library headers. We want to keep these to a minimum. */
 
@@ -348,8 +347,6 @@
 
 #endif				/* ACPI_USE_STANDARD_HEADERS */
 
-#endif				/* ACPI_USE_SYSTEM_CLIBRARY */
-
 #ifndef ACPI_FILE
 #ifdef ACPI_APPLICATION
 #include <stdio.h>
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 447c33f..1380ec7 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -180,10 +180,11 @@
 
 #else				/* !__KERNEL__ */
 
-#include <string.h>
-#include <stdlib.h>
-#include <ctype.h>
+#define ACPI_USE_STANDARD_HEADERS
+
+#ifdef ACPI_USE_STANDARD_HEADERS
 #include <unistd.h>
+#endif
 
 /* Define/disable kernel-specific declarators */
 
-- 
1.7.10

