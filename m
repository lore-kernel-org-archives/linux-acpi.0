From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/20] ACPICA: Headers: Fix some comments, no functional change.
Date: Tue, 25 Aug 2015 10:29:17 +0800
Message-ID: <81cc61925621eca3ac9b99bbe85d5298fb92700d.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 539f8c03fe64305725bd85343e42f3b6c42aad14

A couple typos and long lines.

Link: https://github.com/acpica/acpica/commit/539f8c03
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 3cedd43..1332537 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -89,8 +89,8 @@
 #endif
 
 /*
- * acpi_bin/acpi_dump/acpi_help/acpi_names/acpi_src/acpi_xtract/Example configuration.
- * All single threaded.
+ * acpi_bin/acpi_dump/acpi_help/acpi_names/acpi_src/acpi_xtract/Example
+ * configuration. All single threaded.
  */
 #if (defined ACPI_BIN_APP)      || \
 	(defined ACPI_DUMP_APP)     || \
@@ -123,7 +123,7 @@
 #define ACPI_USE_NATIVE_RSDP_POINTER
 #endif
 
-/* acpi_dump configuration. Native mapping used if provied by OSPMs */
+/* acpi_dump configuration. Native mapping used if provided by the host */
 
 #ifdef ACPI_DUMP_APP
 #define ACPI_USE_NATIVE_MEMORY_MAPPING
@@ -323,8 +323,8 @@
  * ACPI_USE_STANDARD_HEADERS - Define this if linking to a C library and
  *      the standard header files may be used.
  *
- * The ACPICA subsystem only uses low level C library functions that do not call
- * operating system services and may therefore be inlined in the code.
+ * The ACPICA subsystem only uses low level C library functions that do not
+ * call operating system services and may therefore be inlined in the code.
  *
  * It may be necessary to tailor these include files to the target
  * generation environment.
-- 
1.7.10
