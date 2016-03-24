From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/30] ACPICA: Add support for QNX 6.6 platform
Date: Thu, 24 Mar 2016 09:40:26 +0800
Message-ID: <f91a8811ea424e33dab54a980aa0b3045c3af2ab.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Will Miles <wmiles@sgl.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Will Miles <wmiles@sgl.com>

ACPICA commit 37a1dec2391272251e59948c16c60713183ae78f

Link: https://github.com/acpica/acpica/commit/37a1dec2
Signed-off-by: Will Miles <wmiles@sgl.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h                           |    3 +++
 tools/power/acpi/os_specific/service_layers/osunixmap.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 72f85b4..86b5a84 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -219,6 +219,9 @@
 #elif defined(__HAIKU__)
 #include "achaiku.h"
 
+#elif defined(__QNX__)
+#include "acqnx.h"
+
 #else
 
 /* Unknown environment */
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 3818fd0..cbfbce1 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -54,7 +54,7 @@ ACPI_MODULE_NAME("osunixmap")
 #ifndef O_BINARY
 #define O_BINARY 0
 #endif
-#if defined(_dragon_fly) || defined(_free_BSD)
+#if defined(_dragon_fly) || defined(_free_BSD) || defined(_QNX)
 #define MMAP_FLAGS          MAP_SHARED
 #else
 #define MMAP_FLAGS          MAP_PRIVATE
-- 
1.7.10
