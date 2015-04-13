From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/31] ACPICA: Fix a sscanf format string.
Date: Mon, 13 Apr 2015 11:50:01 +0800
Message-ID: <9815e8c717600299ff791d6dfa68e1ab2549c302.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44808 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbbDMDuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:50:06 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 84f3569db7accc576ace2dae81d101467254fe9d

Was using %d instead of properly using %u.

This patch only affects acpidump tool.

Link: https://github.com/acpica/acpica/commit/84f3569d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 92f1fd7..db15c9d 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -1156,7 +1156,7 @@ osl_table_name_from_file(char *filename, char *signature, u32 *instance)
 	/* Extract instance number */
 
 	if (isdigit((int)filename[ACPI_NAME_SIZE])) {
-		sscanf(&filename[ACPI_NAME_SIZE], "%d", instance);
+		sscanf(&filename[ACPI_NAME_SIZE], "%u", instance);
 	} else if (strlen(filename) != ACPI_NAME_SIZE) {
 		return (AE_BAD_SIGNATURE);
 	} else {
-- 
1.7.10

