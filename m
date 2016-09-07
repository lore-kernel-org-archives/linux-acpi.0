From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/14] ACPICA: Tables: Add new table events indicating table installation/uninstallation
Date: Wed,  7 Sep 2016 14:06:32 +0800
Message-ID: <2a3eb0b035a0f1ac1be8f8cbc34284f3077fa9ad.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34621 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbcIGGGi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:06:38 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit ed6a5fbc694f3a27d93014391aa9a6f6fe490461

This patch adds 2 new table events to indicate table
installation/uninstallation.

Currently, as ACPICA never uninstalls tables, this patch thus only adds
table handler invocation for the table installation event. Lv Zheng.

The 2 events are to be used to fix a sysfs table handling issue related to
LoadTable opcode (see Link # [1] below). The actual sysfs fixing code is
not included, the sysfs fixes will be sent as separate patches.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=150841 # [1]
Link: https://github.com/acpica/acpica/commit/ed6a5fbc
Reported-by: Jason Voelz <jason.voelz@intel.com>
Reported-by: Francisco Leoner <francisco.j.lenoer.soto@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
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

