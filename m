Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD4C47092
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A74B60C40
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFBJIS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:08:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3509 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFBJIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33m27P6zYsSm;
        Wed,  2 Jun 2021 17:03:48 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:47 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 18/18] ACPI: Remove the macro PREFIX "ACPI: "
Date:   Wed, 2 Jun 2021 16:54:40 +0800
Message-ID: <1622624080-56025-19-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now the macro PREFIX for ACPI message printing is not used
anymore, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e21611c..bbe1064 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -11,8 +11,6 @@
 
 #include <linux/idr.h>
 
-#define PREFIX "ACPI: "
-
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
-- 
1.7.12.4

