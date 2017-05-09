From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 1/4] ACPICA: Tables: Fix regression introduced by a too early mechanism enabling
Date: Tue,  9 May 2017 13:57:31 +0800
Message-ID: <03ff0e3d2a01c2de1d00ed0475310d8cfd87d2a1.1494309338.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19290 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdEIF5j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 May 2017 01:57:39 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Anush Seetharaman <anush.seetharaman@intel.com>, Dan Williams <dan.j.williams@intel.com>

In the Linux kernel side, acpi_get_table() clones haven't been fully
balanced by acpi_put_table() invocations. In ACPICA side, due to the design
change, there are also unbalanced acpi_get_table_by_index() invocations
requiring special care.

So it is not a good timing to report acpi_get_table() counting errors. The
strict balanced validation count check should only be enabled after
confirming that all invocations are safe and compliant to their designed
purposes.

Thus this patch removes the fatal error along with the error report to
fix this issue. Reported by Dan Williams, fixed by Lv Zheng.

Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Cc: <stable@vger.kernel.org>
Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Cc: Anush Seetharaman <anush.seetharaman@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 5a968a7..7abe665 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -418,11 +418,7 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
 
 	table_desc->validation_count++;
 	if (table_desc->validation_count == 0) {
-		ACPI_ERROR((AE_INFO,
-			    "Table %p, Validation count is zero after increment\n",
-			    table_desc));
 		table_desc->validation_count--;
-		return_ACPI_STATUS(AE_LIMIT);
 	}
 
 	*out_table = table_desc->pointer;
-- 
2.7.4

