From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/20] ACPICA: Debugger: Add option to display namespace summary/counts.
Date: Tue, 25 Aug 2015 10:29:52 +0800
Message-ID: <05df9715b9436312ab36ae4c0a8c43524232243d.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit bba222c15c2ce79076eb3a5e9d4d5f7120db8a00

If "Objects" command is invoked with no arguments, the counts
for each object type are displayed.

Linux kernel is not affected by this commit as currently debugger is
not enabled in the Linux kernel.

Link: https://github.com/acpica/acpica/commit/bba222c1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    4 ++--
 drivers/acpi/acpica/aclocal.h  |    4 ++++
 include/acpi/actypes.h         |    2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 95ed861..c597192 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -346,8 +346,8 @@ ACPI_GLOBAL(char, acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE]);
 /*
  * Statistic globals
  */
-ACPI_GLOBAL(u16, acpi_gbl_obj_type_count[ACPI_TYPE_NS_NODE_MAX + 1]);
-ACPI_GLOBAL(u16, acpi_gbl_node_type_count[ACPI_TYPE_NS_NODE_MAX + 1]);
+ACPI_GLOBAL(u16, acpi_gbl_obj_type_count[ACPI_TOTAL_TYPES]);
+ACPI_GLOBAL(u16, acpi_gbl_node_type_count[ACPI_TOTAL_TYPES]);
 ACPI_GLOBAL(u16, acpi_gbl_obj_type_count_misc);
 ACPI_GLOBAL(u16, acpi_gbl_node_type_count_misc);
 ACPI_GLOBAL(u32, acpi_gbl_num_nodes);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index acbf68b..6f70826 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1131,6 +1131,10 @@ struct acpi_integrity_info {
 #define ACPI_DB_CONSOLE_OUTPUT          0x02
 #define ACPI_DB_DUPLICATE_OUTPUT        0x03
 
+struct acpi_object_info {
+	u32 types[ACPI_TOTAL_TYPES];
+};
+
 /*****************************************************************************
  *
  * Debug
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 531eca4..f914958 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -662,6 +662,7 @@ typedef u32 acpi_object_type;
 #define ACPI_TYPE_DEBUG_OBJECT          0x10
 
 #define ACPI_TYPE_EXTERNAL_MAX          0x10
+#define ACPI_NUM_TYPES                  (ACPI_TYPE_EXTERNAL_MAX + 1)
 
 /*
  * These are object types that do not map directly to the ACPI
@@ -683,6 +684,7 @@ typedef u32 acpi_object_type;
 #define ACPI_TYPE_LOCAL_SCOPE           0x1B	/* 1 Name, multiple object_list Nodes */
 
 #define ACPI_TYPE_NS_NODE_MAX           0x1B	/* Last typecode used within a NS Node */
+#define ACPI_TOTAL_TYPES                (ACPI_TYPE_NS_NODE_MAX + 1)
 
 /*
  * These are special object types that never appear in
-- 
1.7.10
