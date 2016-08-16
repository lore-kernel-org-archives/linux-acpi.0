From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/5] ACPICA: Tables: Add new table events indicating table installation/uninstallation
Date: Tue, 16 Aug 2016 16:53:01 +0800
Message-ID: <3475c7a63173c57eedd5181650b4d94db9e8f06b.1471337441.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds 2 new table events to indicate table
installation/uninstallation.

Currently, as ACPICA never uninstalls tables, this patch thus only add
table handler invocation for the table installation event. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |    8 ++++++++
 include/acpi/actypes.h         |    4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index d461864..5fdf251 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -301,6 +301,14 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	acpi_tb_install_table_with_override(&new_table_desc, override,
 					    table_index);
 
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_INSTALL,
+					     new_table_desc.pointer,
+					     acpi_gbl_table_handler_context);
+	}
+
 release_and_exit:
 
 	/* Release the temporary table descriptor */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 892595f..1d798ab 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1089,7 +1089,9 @@ acpi_status (*acpi_table_handler) (u32 event, void *table, void *context);
 
 #define ACPI_TABLE_EVENT_LOAD           0x0
 #define ACPI_TABLE_EVENT_UNLOAD         0x1
-#define ACPI_NUM_TABLE_EVENTS           2
+#define ACPI_TABLE_EVENT_INSTALL        0x2
+#define ACPI_TABLE_EVENT_UNINSTALL      0x3
+#define ACPI_NUM_TABLE_EVENTS           4
 
 /* Address Spaces (For Operation Regions) */
 
-- 
1.7.10
