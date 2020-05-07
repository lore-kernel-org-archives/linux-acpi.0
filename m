Return-Path: <SRS0=rlKP=6V=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EEEC54E4B
	for <linux-acpi@archiver.kernel.org>; Thu,  7 May 2020 09:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36702075E
	for <linux-acpi@archiver.kernel.org>; Thu,  7 May 2020 09:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGJQM (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 7 May 2020 05:16:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgEGJQM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7689028CC491182D81A4;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:15:58 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/9] ACPI: LPIT: Put the low power idle table after using it
Date:   Thu, 7 May 2020 17:09:13 +0800
Message-ID: <1588842561-32907-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
References: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The mapped LPIT table is not used for runtime after init,
put the ACPI table to release the table mapping.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_lpit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 953437a..48e5059 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -151,10 +151,11 @@ void acpi_init_lpit(void)
 	struct acpi_table_lpit *lpit;
 
 	status = acpi_get_table(ACPI_SIG_LPIT, 0, (struct acpi_table_header **)&lpit);
-
 	if (ACPI_FAILURE(status))
 		return;
 
 	lpit_process((u64)lpit + sizeof(*lpit),
 		     (u64)lpit + lpit->header.length);
+
+	acpi_put_table((struct acpi_table_header *)lpit);
 }
-- 
1.7.12.4

