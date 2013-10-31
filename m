From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/15] ACPICA: Update namespace dump code.
Date: Thu, 31 Oct 2013 09:30:10 +0800
Message-ID: <011a428a31fea7f7c357c2c60ccecd1836e9fb10.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20647 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab3JaBap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:30:45 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch does not affect the generation of the Linux binary.
This patch decreases 31 lines of divergences.

This patch merges namespace dump code updates from ACPICA upstream to
reduce the source code differences between Linux and ACPICA upstream.  No
functional changes as currently nsdumpdv.c is not used by Linux.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsdumpdv.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 409ae80..2837625 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -69,6 +69,7 @@ static acpi_status
 acpi_ns_dump_one_device(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value)
 {
+	struct acpi_buffer buffer;
 	struct acpi_device_info *info;
 	acpi_status status;
 	u32 i;
@@ -78,15 +79,17 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 	status =
 	    acpi_ns_dump_one_object(obj_handle, level, context, return_value);
 
-	status = acpi_get_object_info(obj_handle, &info);
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_get_object_info(obj_handle, &buffer);
 	if (ACPI_SUCCESS(status)) {
+		info = buffer.pointer;
 		for (i = 0; i < level; i++) {
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES, " "));
 		}
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES,
 				      "    HID: %s, ADR: %8.8X%8.8X, Status: %X\n",
-				      info->hardware_id.string,
+				      info->hardware_id.value,
 				      ACPI_FORMAT_UINT64(info->address),
 				      info->current_status));
 		ACPI_FREE(info);
-- 
1.7.10

