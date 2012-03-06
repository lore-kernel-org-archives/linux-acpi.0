From: Jiang Liu <liuj97@gmail.com>
Subject: [RESEND PATCH v3] Fix a copy & paste error in erst.c.
Date: Wed,  7 Mar 2012 00:29:19 +0800
Message-ID: <1331051359-21539-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab2CFQca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2012 11:32:30 -0500
Received: by iagz16 with SMTP id z16so7261234iag.19
        for <linux-acpi@vger.kernel.org>; Tue, 06 Mar 2012 08:32:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

This patch fixes a copy & paste error in erst.c and it applies
to v3.3-rc6.

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

