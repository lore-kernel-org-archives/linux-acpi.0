From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/30] ACPICA: Clib/EFI: Fix wrong order of standard integer types/IO handles
Date: Thu,  4 Aug 2016 16:44:52 +0800
Message-ID: <b0d6f3b6d09e44a7f91f8631d66d58c52a90a360.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757395AbcHDIpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:16 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 7f9b359b7c78c69b07f62eb2d58f710c351fd75d

EFI header should use standard C library stuffs (integer types and IO
handles) rather than implementing such standard stuffs.
This patch fixes this issue by:
1. Implementing standard integer types for ACPI_USE_STANDARD_HADERS=n;
2. Defining EFI types using standard integer types and standard IO handles;
3. Tuning header inclusion order and environment definition order;
4. Removing wrong standard header inclusion from ACPICA core files;
5. Moving several application headers from acpidump.h to acenv.h.
This patch corrects some of them. Lv Zheng.

Except some harmless header inclusion re-ordering, Linux kernel is not
affected by this change.

Link: https://github.com/acpica/acpica/commit/7f9b359b
Link: https://bugs.acpica.org/show_bug.cgi?id=1300
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h               |    2 --
 drivers/acpi/acpica/utpredef.c             |    2 --
 include/acpi/platform/acenv.h              |   23 ++++++++++++++---------
 include/acpi/platform/acenvex.h            |   14 ++++++++------
 tools/power/acpi/common/cmfsize.c          |    1 -
 tools/power/acpi/tools/acpidump/acpidump.h |    5 -----
 6 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index ca2c060..247f30c 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -44,8 +44,6 @@
 #ifndef _ACAPPS
 #define _ACAPPS
 
-#include <stdio.h>
-
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 770a177..ce18346 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -176,8 +176,6 @@ void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes)
  ******************************************************************************/
 
 #if (defined ACPI_ASL_COMPILER || defined ACPI_HELP_APP)
-#include <stdio.h>
-#include <string.h>
 
 /* Local prototypes */
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ee5c0b9..1e2fe95 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -209,18 +209,20 @@
 #elif defined(__OS2__)
 #include "acos2.h"
 
-#elif defined(_AED_EFI)
-#include "acefi.h"
-
-#elif defined(_GNU_EFI)
-#include "acefi.h"
-
 #elif defined(__HAIKU__)
 #include "achaiku.h"
 
 #elif defined(__QNX__)
 #include "acqnx.h"
 
+/*
+ * EFI applications can be built with -nostdlib, in this case, it must be
+ * included after including all other host environmental definitions, in
+ * order to override the definitions.
+ */
+#elif defined(_AED_EFI) || defined(_GNU_EFI)
+#include "acefi.h"
+
 #else
 
 /* Unknown environment */
@@ -344,12 +346,16 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#ifdef ACPI_APPLICATION
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/stat.h>
+#endif
 
 #endif				/* ACPI_USE_STANDARD_HEADERS */
 
-#ifndef ACPI_FILE
 #ifdef ACPI_APPLICATION
-#include <stdio.h>
 #define ACPI_FILE              FILE *
 #define ACPI_FILE_OUT          stdout
 #define ACPI_FILE_ERR          stderr
@@ -358,7 +364,6 @@
 #define ACPI_FILE_OUT          NULL
 #define ACPI_FILE_ERR          NULL
 #endif				/* ACPI_APPLICATION */
-#endif				/* ACPI_FILE */
 
 #ifndef ACPI_INIT_FUNCTION
 #define ACPI_INIT_FUNCTION
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 4f15c1d..b672615 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -59,15 +59,17 @@
 #elif defined(WIN32)
 #include "acwinex.h"
 
-#elif defined(_AED_EFI)
-#include "acefiex.h"
-
-#elif defined(_GNU_EFI)
-#include "acefiex.h"
-
 #elif defined(__DragonFly__)
 #include "acdragonflyex.h"
 
+/*
+ * EFI applications can be built with -nostdlib, in this case, it must be
+ * included after including all other host environmental definitions, in
+ * order to override the definitions.
+ */
+#elif defined(_AED_EFI) || defined(_GNU_EFI)
+#include "acefiex.h"
+
 #endif
 
 /*! [End] no source code translation !*/
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index e73a79f..d2240e6 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -44,7 +44,6 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acapps.h"
-#include <stdio.h>
 
 #define _COMPONENT          ACPI_TOOLS
 ACPI_MODULE_NAME("cmfsize")
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 94dd8a1..9f7db00 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -56,11 +56,6 @@
 #include "accommon.h"
 #include "actables.h"
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/stat.h>
-
 /* Globals */
 
 EXTERN u8 INIT_GLOBAL(gbl_summary_mode, FALSE);
-- 
1.7.10

