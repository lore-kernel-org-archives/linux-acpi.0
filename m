Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D40C04FF3
	for <linux-acpi@archiver.kernel.org>; Mon, 24 May 2021 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25276108B
	for <linux-acpi@archiver.kernel.org>; Mon, 24 May 2021 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhEXJxH (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 24 May 2021 05:53:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5749 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJxG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 05:53:06 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpXSx1ffmzmkr6;
        Mon, 24 May 2021 17:48:01 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:51:33 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:51:33 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: configfs: Replace ACPI_INFO() with pr_debug()
Date:   Mon, 24 May 2021 17:41:05 +0800
Message-ID: <1621849265-22293-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI_INFO() macro is used for message printing in the ACPICA code.
ACPI_INFO() will be empty if the ACPICA debug is not enabled, so
it can be replaced with pr_debug().

Also remove the not needed acpica head file inclusions to decouple
with ACPICA.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

Seems we missed this file for cleaning up the ACPICA message printing,
do it now.

 drivers/acpi/acpi_configfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 3a14859..76b83b1 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -13,9 +13,6 @@
 #include <linux/acpi.h>
 #include <linux/security.h>
 
-#include "acpica/accommon.h"
-#include "acpica/actables.h"
-
 static struct config_group *acpi_table_group;
 
 struct acpi_table {
@@ -226,7 +223,7 @@ static void acpi_table_drop_item(struct config_group *group,
 {
 	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
 
-	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
+	pr_debug("Host-directed Dynamic ACPI Table Unload\n");
 	acpi_unload_table(table->index);
 	config_item_put(cfg);
 }
-- 
1.7.12.4

