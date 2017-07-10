From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/16] ACPICA: Tools: Deallocate memory allocated by ac_get_all_tables_from_file via ac_delete_table_list
Date: Mon, 10 Jul 2017 15:22:56 +0800
Message-ID: <7c9f16493ed69fd4cdcd7aea9d6efa368b4c6256.1499671181.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdGJHXF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:23:05 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 8521b98ebdea450011fa62c14a77fed9affa4236

Link: https://github.com/acpica/acpica/commit/8521b98e
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index bb6a84b..7a1a68b 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -114,6 +114,8 @@ ac_get_all_tables_from_file(char *filename,
 			    u8 get_only_aml_tables,
 			    struct acpi_new_table_desc **return_list_head);
 
+void ac_delete_table_list(struct acpi_new_table_desc *list_head);
+
 u8 ac_is_file_binary(FILE * file);
 
 acpi_status ac_validate_table_header(FILE * file, long table_offset);
-- 
2.7.4

