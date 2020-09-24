Return-Path: <SRS0=CdCY=DB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57EC4727E
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9768235F7
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIXDFY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 23 Sep 2020 23:05:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgIXDFX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3DE56DDAC3C933C9CED;
        Thu, 24 Sep 2020 11:05:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:10 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 13/15] ACPI: tiny-power-button: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:05 +0800
Message-ID: <1600916227-21805-14-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA debug code is not used, can be removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/tiny-power-button.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 6273d73..420e61b 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -4,7 +4,6 @@
 #include <linux/acpi.h>
 #include <acpi/button.h>
 
-ACPI_MODULE_NAME("tiny-power-button");
 MODULE_AUTHOR("Josh Triplett");
 MODULE_DESCRIPTION("ACPI Tiny Power Button Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.12.4

