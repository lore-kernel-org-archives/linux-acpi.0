From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/13] ACPICA: iASL: General cleanup of the file suffix #defines
Date: Thu, 15 Oct 2015 10:08:26 +0800
Message-ID: <257a6ec5105a9be6d7879bc8873e71a1714e3a66.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit bed456ed2976bdaafdef406b982fdf6c539befc0

Removed some extraneous defines, reordered others.

Link: https://github.com/acpica/acpica/commit/bed456ed
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h              |    2 +-
 tools/power/acpi/tools/acpidump/apfiles.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index e9f0833..e4cc48f 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -88,7 +88,7 @@
 	acpi_os_printf (" %-18s%s\n", name, description);
 
 #define FILE_SUFFIX_DISASSEMBLY     "dsl"
-#define ACPI_TABLE_FILE_SUFFIX      ".dat"
+#define FILE_SUFFIX_BINARY_TABLE    ".dat"	/* Needs the dot */
 
 /*
  * getopt
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index a37f970..a1c62de 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -150,7 +150,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 		strcat(filename, instance_str);
 	}
 
-	strcat(filename, ACPI_TABLE_FILE_SUFFIX);
+	strcat(filename, FILE_SUFFIX_BINARY_TABLE);
 
 	if (gbl_verbose_mode) {
 		acpi_log_error
-- 
1.7.10
