From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/4] ACPICA: Tools: Update common signon, remove compilation bit width
Date: Wed,  8 Feb 2017 11:00:15 +0800
Message-ID: <945c17a09814625469bcee054190af6577713daa.1486522441.git.lv.zheng@intel.com>
References: <cover.1486522441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486522441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 43e04e75a9849072a1557b674004d8093bddb9ef

Remove the bit width of the compiler that generated the tool
from the tool signon. This was confusing and unnecessary.

Changed the iASL signon to add "disassembler" to the name.

Link: https://github.com/acpica/acpica/commit/43e04e75
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index c32bbe4..b65f273 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -54,23 +54,23 @@
 #define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2017 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
-#define ACPI_WIDTH          "-64"
+#define ACPI_WIDTH          " (64-bit version)"
 
 #elif ACPI_MACHINE_WIDTH == 32
-#define ACPI_WIDTH          "-32"
+#define ACPI_WIDTH          " (32-bit version)"
 
 #else
 #error unknown ACPI_MACHINE_WIDTH
-#define ACPI_WIDTH          "-??"
+#define ACPI_WIDTH          " (unknown bit width, not 32 or 64)"
 
 #endif
 
 /* Macros for signons and file headers */
 
 #define ACPI_COMMON_SIGNON(utility_name) \
-	"\n%s\n%s version %8.8X%s\n%s\n\n", \
+	"\n%s\n%s version %8.8X\n%s\n\n", \
 	ACPICA_NAME, \
-	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, \
+	utility_name, ((u32) ACPI_CA_VERSION), \
 	ACPICA_COPYRIGHT
 
 #define ACPI_COMMON_HEADER(utility_name, prefix) \
-- 
2.7.4
