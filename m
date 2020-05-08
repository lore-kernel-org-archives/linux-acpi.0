Return-Path: <SRS0=aZej=6W=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF15C47247
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 04:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C431820720
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 04:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgEHEMS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 8 May 2020 00:12:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgEHEMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 00:12:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82F1688CE6760E452CDF;
        Fri,  8 May 2020 12:12:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 12:12:03 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] ACPI: GTDT: Put GTDT table after parsing
Date:   Fri, 8 May 2020 12:05:52 +0800
Message-ID: <1588910753-18543-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The mapped GTDT table needs to be released after
the driver init.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

Patch 1/2 2/2 are based on top of for-next/acpi branch of                       
the ARM64 repo.

 drivers/acpi/arm64/gtdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 01962c6..f2d0e59 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -394,7 +394,7 @@ static int __init gtdt_sbsa_gwdt_init(void)
 	 */
 	ret = acpi_gtdt_init(table, &timer_count);
 	if (ret || !timer_count)
-		return ret;
+		goto out_put_gtdt;
 
 	for_each_platform_timer(platform_timer) {
 		if (is_non_secure_watchdog(platform_timer)) {
@@ -408,6 +408,8 @@ static int __init gtdt_sbsa_gwdt_init(void)
 	if (gwdt_count)
 		pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
 
+out_put_gtdt:
+	acpi_put_table(table);
 	return ret;
 }
 
-- 
1.7.12.4

