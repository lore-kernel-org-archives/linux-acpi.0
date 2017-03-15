From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 4/7] ACPICA: Tables: Fix an unwanted exception for table reloading
Date: Wed, 15 Mar 2017 14:37:17 +0800
Message-ID: <a1a830f0382819424a9a1dedb1f914f61d518999.1489558845.git.lv.zheng@intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32793 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdCOGhh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 02:37:37 -0400
In-Reply-To: <cover.1489558845.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

When Load/load_table opcode is called again for the same table, it is likely
that the table has already been loaded, so AE_ALREADY_EXISTS shouldn't be a
fatal error but a notice for the caller to skip acpi_ns_load_table(). Reported
by Hans de Goede, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/tbdata.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index b7bff76..1a4371b 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -952,6 +952,13 @@ acpi_tb_load_table(u32 *table_index, struct acpi_namespace_node *parent_node)
 
 	status = acpi_tb_validate_table_for_load(table_index, &table);
 	if (ACPI_FAILURE(status)) {
+		if (status == AE_ALREADY_EXISTS) {
+			/*
+			 * Skip the table loading process but return the table index to
+			 * the caller with the exception muted.
+			 */
+			status = AE_OK;
+		}
 		return_ACPI_STATUS(status);
 	}
 
-- 
2.7.4

