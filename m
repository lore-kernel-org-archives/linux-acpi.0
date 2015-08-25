From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/20] ACPICA: Header support to improve compatibility with MSVC.
Date: Tue, 25 Aug 2015 10:30:11 +0800
Message-ID: <9bd50a1d9431bc6ddc637994e311ffbe973a3e06.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5b4087fba991d8383046b550bbe22f3d8d9b9c8f

Needed to improve MSVC editor support for symbols.

For Linux kernel, this change is a no-op.

Link: https://github.com/acpica/acpica/commit/5b4087fb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 1332537..ec00e2b 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -70,13 +70,14 @@
 
 #ifdef ACPI_ASL_COMPILER
 #define ACPI_APPLICATION
-#define ACPI_DISASSEMBLER
 #define ACPI_DEBUG_OUTPUT
 #define ACPI_CONSTANT_EVAL_ONLY
 #define ACPI_LARGE_NAMESPACE_NODE
 #define ACPI_DATA_TABLE_DISASSEMBLY
 #define ACPI_SINGLE_THREADED
 #define ACPI_32BIT_PHYSICAL_ADDRESS
+
+#define ACPI_DISASSEMBLER 1
 #endif
 
 /* acpi_exec configuration. Multithreaded with full AML debugger */
@@ -151,12 +152,12 @@
 #define ACPI_USE_LOCAL_CACHE
 #endif
 
-/* Common debug support */
+/* Common debug/disassembler support */
 
 #ifdef ACPI_FULL_DEBUG
-#define ACPI_DEBUGGER
 #define ACPI_DEBUG_OUTPUT
-#define ACPI_DISASSEMBLER
+#define ACPI_DEBUGGER 1
+#define ACPI_DISASSEMBLER 1
 #endif
 
 
-- 
1.7.10
