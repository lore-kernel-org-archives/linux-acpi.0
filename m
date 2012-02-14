From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 2/2] Fix a copy & paste error in erst.c.
Date: Wed, 15 Feb 2012 00:01:45 +0800
Message-ID: <1329235305-780-2-git-send-email-jiang.liu@huawei.com>
References: <1329235305-780-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36158 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2BNQCK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2012 11:02:10 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so73437dae.19
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2012 08:02:09 -0800 (PST)
In-Reply-To: <1329235305-780-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/apei/erst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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

