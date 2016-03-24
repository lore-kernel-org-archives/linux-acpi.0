From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 1/8] ACPICA: Tables: Add an error message complaining driver bugs
Date: Thu, 24 Mar 2016 16:30:31 +0800
Message-ID: <dedafad7c2c73678ce83cbdb93ec7889c640fdf0.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16788 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIac (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:30:32 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch adds an error message to complain a driver bug that the
early mappings are not unmapped by the drivers. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxface.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 326df65..5700e72 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -167,6 +167,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
 acpi_status __init acpi_reallocate_root_table(void)
 {
 	acpi_status status;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -178,6 +179,21 @@ acpi_status __init acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
+	/*
+	 * Ensure OS early boot logic, which is required by some hosts. If the
+	 * table state is reported to be wrong, developers should fix the
+	 * issue by invoking acpi_put_table() for the reported table during the
+	 * early stage.
+	 */
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+		if (acpi_gbl_root_table_list.tables[i].pointer) {
+			ACPI_ERROR((AE_INFO,
+				    "BUG: Table [%4.4s] isn't invalidated after booting",
+				    acpi_gbl_root_table_list.tables[i].
+				    signature.ascii));
+		}
+	}
+
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ALLOW_RESIZE;
 
 	status = acpi_tb_resize_root_table_list();
-- 
1.7.10

