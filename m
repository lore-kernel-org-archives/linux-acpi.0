From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/11] ACPICA: Tables: Add an error message complaining driver bugs
Date: Wed, 30 Nov 2016 15:21:34 +0800
Message-ID: <e97e0342dadcd25b0ff681cbcd7ff0c13848b93f.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9706 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756753AbcK3HVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:21:47 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 68af3c3aa238dd8040e846ac6b4827a016434d8d

During early OS boot stage, drivers that have mapped system memory should
unmap it during the same stage. Linux kernel has an error message
indicating the unbalanced early memory mappings.

This patch back ports such error message into ACPICA for the early table
mappings, so that ACPICA development environment is also aware of this OS
specific requirement and thus is able to ensure the consistent quality
locally. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/68af3c3a
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxface.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 4ab6b9c..d5adb7a 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -167,6 +167,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count)
 acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 {
 	acpi_status status;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -178,6 +179,21 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
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
+				    "Table [%4.4s] is not invalidated during early boot stage",
+				    acpi_gbl_root_table_list.tables[i].
+				    signature.ascii));
+		}
+	}
+
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ALLOW_RESIZE;
 
 	status = acpi_tb_resize_root_table_list();
-- 
1.7.10

