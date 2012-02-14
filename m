From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 1/2] CPER failed to handle generic error records with multiple sections
Date: Wed, 15 Feb 2012 00:01:44 +0800
Message-ID: <1329235305-780-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36158 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab2BNQCA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2012 11:02:00 -0500
Received: by daed14 with SMTP id d14so73437dae.19
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2012 08:01:59 -0800 (PST)
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

