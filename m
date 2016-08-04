From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 28/30] ACPICA: OSL: Cleanup the inclusion order of the compiler-specific headers
Date: Thu,  4 Aug 2016 16:45:40 +0800
Message-ID: <0c47f2f578a71588c5c3c166cc1f9cb167756c71.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32657 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416AbcHDIpr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:47 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit a760a98ec84b1ec782e0bff5f6612af6fb89c10c

Originally compiler specific headers are included by the host-specific
headers. This makes build configuration management very inconvenient. And
many inclusion order issues can be hidden accross different host OSes. It
will then likely that some host builds will be broken just because of
fixing some inclusion order issues for other host builds.

This patch splits the compiler-specific header inclusions out of the
host-specific headers so that compiler-specific inclusion order issues will
not get entangled in the host-specific inclusion orders.

Note that intel compiler defines __GNUC__, so this patch contains special
handling because acintel.h and acgcc.h should be mutual exclusive.

Link: https://github.com/acpica/acpica/commit/a760a98e
Link: https://bugs.acpica.org/show_bug.cgi?id=1303
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h   |   13 ++++++++++++-
 include/acpi/platform/acenvex.h |    8 +++++---
 include/acpi/platform/aclinux.h |    4 ----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index f9af0e0..34cce72 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -166,10 +166,21 @@
 /******************************************************************************
  *
  * Host configuration files. The compiler configuration files are included
- * by the host files.
+ * first.
  *
  *****************************************************************************/
 
+#if defined(__GNUC__) && !defined(__INTEL_COMPILER)
+#include <acpi/platform/acgcc.h>
+
+#elif defined(_MSC_VER)
+#include "acmsvc.h"
+
+#elif defined(__INTEL_COMPILER)
+#include "acintel.h"
+
+#endif
+
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 58ca39c..060fb08 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -56,9 +56,6 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>
 
-#elif defined(WIN32)
-#include "acwinex.h"
-
 #elif defined(__DragonFly__)
 #include "acdragonflyex.h"
 
@@ -72,6 +69,11 @@
 
 #endif
 
+#if defined(_MSC_VER)
+#include "acmsvcex.h"
+
+#endif
+
 /*! [End] no source code translation !*/
 
 #endif				/* __ACENVEX_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 1380ec7..a5d98d1 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -215,8 +215,4 @@
 
 #endif				/* __KERNEL__ */
 
-/* Linux uses GCC */
-
-#include <acpi/platform/acgcc.h>
-
 #endif				/* __ACLINUX_H__ */
-- 
1.7.10

