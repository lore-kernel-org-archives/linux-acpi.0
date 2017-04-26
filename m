From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH] ACPICA: Tables: Fix regression introduced by a too early mechanism enabling
Date: Wed, 26 Apr 2017 09:49:53 +0800
Message-ID: <1493171393-1825-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1434481AbdDZBt7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Apr 2017 21:49:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

In the Linux kernel side, acpi_get_table() hasn't been fully balanced by
acpi_put_table() invocations. So it is not a good timing to report errors.
The strict balanced validation count check should only be enabled after
confirming that all kernel side invocations are safe.

Thus this patch removes the fatal error but leaves the error report to
indicate the leak so that developers can notice the required engineering
change. Reported by Dan Williams, fixed by Lv Zheng.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 5a968a7..9e7d95cf 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -422,7 +422,6 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
 			    "Table %p, Validation count is zero after increment\n",
 			    table_desc));
 		table_desc->validation_count--;
-		return_ACPI_STATUS(AE_LIMIT);
 	}
 
 	*out_table = table_desc->pointer;
-- 
2.7.4

