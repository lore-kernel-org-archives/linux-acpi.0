Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57787C47083
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B5D608FE
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFBJIR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:08:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2847 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFBJIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw31T54cczWpZ2;
        Wed,  2 Jun 2021 17:01:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 06/18] ACPI: nvs: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:28 +0800
Message-ID: <1622624080-56025-7-git-send-email-guohanjun@huawei.com>
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

The message printing in nvs.c is mixed with pr_*() and
printk(), but with no prefix and also no pr_fmt() defined.

Introduce pr_fmt() and use pr_*() macros to replace printk(),
to generate a unified format string for prefix.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/nvs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 9f8712a5..7f02e39 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2008-2011 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  */
 
+#define pr_fmt(fmt) "ACPI: PM: " fmt
+
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -94,7 +96,7 @@ static int suspend_nvs_register(unsigned long start, unsigned long size)
 {
 	struct nvs_page *entry, *next;
 
-	pr_info("PM: Registering ACPI NVS region [mem %#010lx-%#010lx] (%ld bytes)\n",
+	pr_info("Registering ACPI NVS region [mem %#010lx-%#010lx] (%ld bytes)\n",
 		start, start + size - 1, size);
 
 	while (size > 0) {
@@ -170,7 +172,7 @@ int suspend_nvs_save(void)
 {
 	struct nvs_page *entry;
 
-	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+	pr_info("Saving platform NVS memory\n");
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
@@ -202,7 +204,7 @@ void suspend_nvs_restore(void)
 {
 	struct nvs_page *entry;
 
-	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+	pr_info("Restoring platform NVS memory\n");
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data)
-- 
1.7.12.4

