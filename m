From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/42] ACPICA: acpiexec/acpinames: Update for error checking macros
Date: Tue, 29 Dec 2015 13:56:46 +0800
Message-ID: <0a15ea0504e61d870ff9315c614460850d068d10.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5bdfb4f43f4d315d23b31b39bac5a0b1ca420c2b

Standardize naming, deploy in common header.

Link: https://github.com/acpica/acpica/commit/5bdfb4f4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 340350f..578e37f 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -89,6 +89,19 @@
 #define ACPI_OPTION(name, description) \
 	acpi_os_printf (" %-18s%s\n", name, description);
 
+/* Check for unexpected exceptions */
+
+#define ACPI_CHECK_STATUS(name, status, expected) \
+	if (status != expected) \
+	{ \
+		acpi_os_printf ("Unexpected %s from %s (%s-%d)\n", \
+			acpi_format_exception (status), #name, _acpi_module_name, __LINE__); \
+	}
+
+/* Check for unexpected non-AE_OK errors */
+
+#define ACPI_CHECK_OK(name, status)   ACPI_CHECK_STATUS (name, status, AE_OK);
+
 #define FILE_SUFFIX_DISASSEMBLY     "dsl"
 #define FILE_SUFFIX_BINARY_TABLE    ".dat"	/* Needs the dot */
 
-- 
1.7.10
