From: "xiaofeng.yan" <yanxiaofeng@inspur.com>
Subject: [PATCH] ACPI, Repair of outdated variable
Date: Thu,  2 Jul 2015 11:05:44 +0800
Message-ID: <1435806344-4060-1-git-send-email-yanxiaofeng@inspur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m50-110.126.com ([123.125.50.110]:47113 "EHLO m50-110.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbbGBDGK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 23:06:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, "xiaofeng.yan" <yanxiaofeng@inspur.com>

variable "value" in struct acpi_pnp_device_id has been changed
to "string".

Signed-off-by: xiaofeng.yan <yanxiaofeng@inspur.com>
---
 drivers/acpi/acpica/nsdumpdv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 7dc367e..1af1af7 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -89,7 +89,7 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES,
 				      "    HID: %s, ADR: %8.8X%8.8X, Status: %X\n",
-				      info->hardware_id.value,
+				      info->hardware_id.string,
 				      ACPI_FORMAT_UINT64(info->address),
 				      info->current_status));
 		ACPI_FREE(info);
-- 
1.9.1


