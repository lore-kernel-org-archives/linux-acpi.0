From: RUC_SoftSec <rucsoftsec@gmail.com>
Subject: [PATCH 1/1] acpi: check return value of acpi_os_map_memory
Date: Mon, 28 Oct 2013 14:04:19 +0800
Message-ID: <1382940259-15183-1-git-send-email-rucsoftsec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, RUC_SoftSec <rucsoftsec@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Function acpi_os_map_memory() may return a NULL pointer, it should be validated non-NULL before used.
This bug is found by a static tool developed by RUC_SoftSec, supported by China.X.Orion.

Signed-off-by: RUC_SoftSec <rucsoftsec@gmail.com>
---
 drivers/acpi/osl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e5f416c..bf8f93f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -717,6 +717,8 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
+		if (table == NULL)
+			return AE_OK;
 
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-- 
1.7.9.5
