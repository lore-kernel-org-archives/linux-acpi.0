Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE76C433E0
	for <linux-acpi@archiver.kernel.org>; Thu, 28 Jan 2021 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE0364DD9
	for <linux-acpi@archiver.kernel.org>; Thu, 28 Jan 2021 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA1LVK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:21:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1LVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 06:21:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRHzj3Sg9zjFSQ;
        Thu, 28 Jan 2021 19:19:13 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 19:20:19 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <rui.zhang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPI: tables: Mark acpi_init_fpdt with static keyword
Date:   Thu, 28 Jan 2021 19:31:19 +0800
Message-ID: <1611833479-87653-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following sparse warning:

drivers/acpi/acpi_fpdt.c:230:6: warning: symbol 'acpi_init_fpdt' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/acpi_fpdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index b810811..968f9cc 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -227,7 +227,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 	return 0;
 }
 
-void acpi_init_fpdt(void)
+static void acpi_init_fpdt(void)
 {
 	acpi_status status;
 	struct acpi_table_header *header;
-- 
2.6.2

