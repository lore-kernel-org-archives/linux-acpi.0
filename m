From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/2] ACPICA: Tables: Fix regression introduced by a too early mechanism enabling
Date: Thu, 27 Apr 2017 16:22:44 +0800
Message-ID: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28365 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936969AbdD0IXF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 04:23:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

In the Linux kernel side, acpi_get_table() clones haven't been fully
balanced by acpi_put_table() invocations. In ACPICA side, due to the design
change, there are also unbalanced acpi_get_table_by_index() invocations
requiring special care to be cleaned up.

So it is not a good timing to report acpi_get_table() counting errors for
this period. The strict balanced validation count check should only be
enabled after confirming that all invocations are safe and compliant to
their designed purposes.

Thus this patch removes the fatal error along with lthe error report to
fix this issue. Reported by Dan Williams, fixed by Lv Zheng.

Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 5a968a7..8175c70 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -418,11 +418,13 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
 
 	table_desc->validation_count++;
 	if (table_desc->validation_count == 0) {
+		table_desc->validation_count--;
+#if 0
 		ACPI_ERROR((AE_INFO,
 			    "Table %p, Validation count is zero after increment\n",
 			    table_desc));
-		table_desc->validation_count--;
 		return_ACPI_STATUS(AE_LIMIT);
+#endif
 	}
 
 	*out_table = table_desc->pointer;
-- 
2.7.4

