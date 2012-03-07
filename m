From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v4] ACPI, APEI, Fix ERST header length check
Date: Wed,  7 Mar 2012 22:15:06 +0800
Message-ID: <1331129706-23712-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44393 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab2CGOR3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 09:17:29 -0500
Received: by iagz16 with SMTP id z16so8688114iag.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Mar 2012 06:17:28 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

This fixes a trivial copy & paste error in ERST header length check.
It's just for future safety because sizeof(struct acpi_table_einj)
equals to sizeof(struct acpi_table_erst) with current ACPI5.0
specification. It applies to v3.3-rc6.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Acked-by: Huang Ying <ying.huang@intel.com>
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

