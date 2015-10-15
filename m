From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/13] ACPICA: Remove unnecessary conditional compilation.
Date: Thu, 15 Oct 2015 10:07:47 +0800
Message-ID: <aa7d0bcbc2bcc13cf65b7b9a14fa0e6c7329c3b7.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit eea1f0e561893b6d6417913b2d224082fe3a0a5e

Remove use of ACPI_DEBUGGER and ACPI_DISASSEMBLER where these
defines are used around entire modules.

Note: This type of code also causes problems with IDEs.

Link: https://github.com/acpica/acpica/commit/eea1f0e5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h |    6 ++++++
 drivers/acpi/acpica/rsdump.c  |    3 ---
 include/acpi/platform/acenv.h |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index eb2e926..c928ba4 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -44,6 +44,12 @@
 #ifndef __ACDEBUG_H__
 #define __ACDEBUG_H__
 
+/* The debugger is used in conjunction with the disassembler most of time */
+
+#ifdef ACPI_DISASSEMBLER
+#include "acdisasm.h"
+#endif
+
 #define ACPI_DEBUG_BUFFER_SIZE  0x4000	/* 16K buffer for return objects */
 
 struct acpi_db_command_info {
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index c428bb3..2a09288 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -51,7 +51,6 @@ ACPI_MODULE_NAME("rsdump")
 /*
  * All functions in this module are used by the AML Debugger only
  */
-#if defined(ACPI_DEBUGGER)
 /* Local prototypes */
 static void acpi_rs_out_string(char *title, char *value);
 
@@ -565,5 +564,3 @@ static void acpi_rs_dump_word_list(u16 length, u16 *data)
 		acpi_os_printf("%25s%2.2X : %4.4X\n", "Word", i, data[i]);
 	}
 }
-
-#endif
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ec00e2b..15ef08c 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -142,7 +142,7 @@
 
 #ifdef ACPI_LIBRARY
 #define ACPI_USE_LOCAL_CACHE
-#define ACPI_FUTURE_USAGE
+#define ACPI_FULL_DEBUG
 #endif
 
 /* Common for all ACPICA applications */
-- 
1.7.10
