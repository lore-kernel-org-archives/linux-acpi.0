From: Jiang Liu <liuj97@gmail.com>
Subject: [RESEND PATCH 1/2] Fix two minor bugs in cper.c.
Date: Mon, 13 Feb 2012 23:52:14 +0800
Message-ID: <1329148335-30534-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54657 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab2BMPwl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2012 10:52:41 -0500
Received: by pbcun15 with SMTP id un15so4653142pbc.19
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2012 07:52:40 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

The function apei_estatus_print() and apei_estatus_check() forget to move ahead
the gdata pointer when dealing with multiple generic error data sections.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/apei/cper.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
index 5d41894..e6defd8 100644
--- a/drivers/acpi/apei/cper.c
+++ b/drivers/acpi/apei/cper.c
@@ -362,6 +362,7 @@ void apei_estatus_print(const char *pfx,
 		gedata_len = gdata->error_data_length;
 		apei_estatus_print_section(pfx, gdata, sec_no);
 		data_len -= gedata_len + sizeof(*gdata);
+		gdata = (void *)(gdata + 1) + gedata_len;
 		sec_no++;
 	}
 }
@@ -396,6 +397,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
 		if (gedata_len > data_len - sizeof(*gdata))
 			return -EINVAL;
 		data_len -= gedata_len + sizeof(*gdata);
+		gdata = (void *)(gdata + 1) + gedata_len;
 	}
 	if (data_len)
 		return -EINVAL;
-- 
1.7.5.4

