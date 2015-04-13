From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/31] ACPICA: Unix: Cleanup to use ACPI_TO_INTEGER() to calc page offset.
Date: Mon, 13 Apr 2015 11:48:24 +0800
Message-ID: <3bbc0eab7349e36bc242007960540a05b263acf0.1428893936.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50899 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbbDMDs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:48:28 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 9e2d8180f4d5e61949b17513bae8aff6412f62dd

The offset calculation needn't convert a pointer to a special integer type.
So this patch uses ACPI_TO_INTEGER() instead.

This patch only affects acpidump tool.

Link: https://github.com/acpica/acpica/commit/9e2d8180
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 3853a73..0b1fa29 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -146,6 +146,6 @@ void acpi_os_unmap_memory(void *where, acpi_size length)
 	acpi_size page_size;
 
 	page_size = acpi_os_get_page_size();
-	offset = (acpi_physical_address) where % page_size;
+	offset = ACPI_TO_INTEGER(where) % page_size;
 	munmap((u8 *)where - offset, (length + offset));
 }
-- 
1.7.10

