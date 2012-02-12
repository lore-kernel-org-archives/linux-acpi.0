From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH] Fix two minor bugs in cper.c.
Date: Mon, 13 Feb 2012 00:33:46 +0800
Message-ID: <1329064426-26178-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59439 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab2BLQd5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Feb 2012 11:33:57 -0500
Received: by daed14 with SMTP id d14so3795673dae.19
        for <linux-acpi@vger.kernel.org>; Sun, 12 Feb 2012 08:33:57 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Matthew Garrett <mjg@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

The function apei_estatus_print() and apei_estatus_check() forget to move ahead
the gdata pointer when dealing with multiple generic error data sections.
Also fix another copy & paste error in erst.c

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/apei/cper.c |    2 ++
 drivers/acpi/apei/erst.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

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
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index eb9fab5..e4d9d24 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -917,7 +917,7 @@ static int erst_check_table(struct acpi_table_erst *erst_tab)
 {
 	if ((erst_tab->header_length !=
 	     (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
-	    && (erst_tab->header_length != sizeof(struct acpi_table_einj)))
+	    && (erst_tab->header_length != sizeof(struct acpi_table_erst)))
 		return -EINVAL;
 	if (erst_tab->header.length < sizeof(struct acpi_table_erst))
 		return -EINVAL;
-- 
1.7.5.4

