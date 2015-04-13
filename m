From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/31] ACPICA: Applications: Remove use of __DATE__ macro.
Date: Mon, 13 Apr 2015 11:49:18 +0800
Message-ID: <1318d9d24561d4cb2b85081e9780b55b0186c467.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

ACPICA commit 3d9fb6d1f216a78ad098d3ad23f1304376c2f4ef

The macro __DATE__ and friends is not allowed in the Linux kernel. Also,
including the build time in output doesn't seem to provide any value.

Link: https://github.com/acpica/acpica/commit/3d9fb6d1
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index d863016..e9f0833 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -64,15 +64,15 @@
 /* Macros for signons and file headers */
 
 #define ACPI_COMMON_SIGNON(utility_name) \
-	"\n%s\n%s version %8.8X%s [%s]\n%s\n\n", \
+	"\n%s\n%s version %8.8X%s\n%s\n\n", \
 	ACPICA_NAME, \
-	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
+	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, \
 	ACPICA_COPYRIGHT
 
 #define ACPI_COMMON_HEADER(utility_name, prefix) \
-	"%s%s\n%s%s version %8.8X%s [%s]\n%s%s\n%s\n", \
+	"%s%s\n%s%s version %8.8X%s\n%s%s\n%s\n", \
 	prefix, ACPICA_NAME, \
-	prefix, utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
+	prefix, utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, \
 	prefix, ACPICA_COPYRIGHT, \
 	prefix
 
-- 
1.7.10
