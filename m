Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E9EC4708F
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A42608FE
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFBJIT (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:08:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFBJIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33m1kQVzYsF2;
        Wed,  2 Jun 2021 17:03:48 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 12/18] ACPI: reboot: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:34 +0800
Message-ID: <1622624080-56025-13-git-send-email-guohanjun@huawei.com>
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

The meesage printing in this file is mixed with pr_*() and
printk() but with no prefix and no pr_fmt() defined.

Intoduce pr_fmt() and use pr_*() macros to replace printk(),
to generate a unified format string for prefix.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/reboot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 2a61f88..b79b7c9 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
@@ -63,7 +65,7 @@ void acpi_reboot(void)
 
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
+		pr_debug("ACPI MEMORY or I/O RESET_REG.\n");
 		acpi_reset();
 		break;
 	}
-- 
1.7.12.4

