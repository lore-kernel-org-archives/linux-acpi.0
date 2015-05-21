From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/19] ACPICA: Additional dragon_fly BSD support.
Date: Thu, 21 May 2015 10:30:03 +0800
Message-ID: <48edf1309680d3ebd0de594666756a8c1e864fba.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 3e93431674abe947202b0f9a0afa7b625b17caa6

Makefiles and environment defines.
This commit doesn't affect Linux builds.

Link: https://github.com/acpica/acpica/commit/3e934316
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h   |    3 +++
 include/acpi/platform/acenvex.h |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ecdf940..073997d 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -175,6 +175,9 @@
 #elif defined(_APPLE) || defined(__APPLE__)
 #include "acmacosx.h"
 
+#elif defined(__DragonFly__)
+#include "acdragonfly.h"
+
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include "acfreebsd.h"
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 71e5ec5..14dc6f6 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -56,6 +56,9 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>
 
+#elif defined(__DragonFly__)
+#include "acdragonflyex.h"
+
 #endif
 
 /*! [End] no source code translation !*/
-- 
1.7.10
