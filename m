From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/28] ACPICA: Add a missing field for debug dump of mutex objects.
Date: Fri,  4 Apr 2014 12:38:12 +0800
Message-ID: <e228900eb4911caa4dc8b363cac1f5a1edd45db2.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22769 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbaDDEiP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:15 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Adds "OriginalSyncLevel" field to the output.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdump.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 973fdae..925202a 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -134,9 +134,11 @@ static struct acpi_exdump_info acpi_ex_dump_method[9] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(method.aml_start), "Aml Start"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_mutex[5] = {
+static struct acpi_exdump_info acpi_ex_dump_mutex[6] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_mutex), NULL},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(mutex.sync_level), "Sync Level"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(mutex.original_sync_level),
+	 "Original Sync Level"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(mutex.owner_thread), "Owner Thread"},
 	{ACPI_EXD_UINT16, ACPI_EXD_OFFSET(mutex.acquisition_depth),
 	 "Acquire Depth"},
-- 
1.7.10

