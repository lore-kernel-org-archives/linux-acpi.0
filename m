Return-Path: <SRS0=xM78=C2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC4AC433E2
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CCA22205
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIQILy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:11:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbgIQIDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CEABBD229FD66D67B8D;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:52 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 19/25] ACPI: SBS: Simplify the code using module_acpi_driver()
Date:   Thu, 17 Sep 2020 15:38:59 +0800
Message-ID: <1600328345-27627-20-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using the module_acpi_driver() to simplify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sbs.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index ee13960..6e55e70 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -711,17 +711,4 @@ static int acpi_sbs_resume(struct device *dev)
 		},
 	.drv.pm = &acpi_sbs_pm,
 };
-
-static int __init acpi_sbs_init(void)
-{
-	return acpi_bus_register_driver(&acpi_sbs_driver);
-}
-
-static void __exit acpi_sbs_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_sbs_driver);
-	return;
-}
-
-module_init(acpi_sbs_init);
-module_exit(acpi_sbs_exit);
+module_acpi_driver(acpi_sbs_driver);
-- 
1.7.12.4

