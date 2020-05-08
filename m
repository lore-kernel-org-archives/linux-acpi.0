Return-Path: <SRS0=aZej=6W=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297AEC47247
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0942520736
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 04:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgEHEHf (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 8 May 2020 00:07:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725271AbgEHEHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 00:07:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09A5D6B05BE399D5515D;
        Fri,  8 May 2020 12:07:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 12:07:25 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2] ACPI: IORT: Add extra message "applying workaround" for off-by-1 issue
Date:   Fri, 8 May 2020 11:56:38 +0800
Message-ID: <1588910198-8348-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As we already applied a workaround for the off-by-1 issue,
it's good to add extra message "applying workaround" to make
people less uneasy to see FW_BUG message in the boot log.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

v2:
 - Print the extra message only for rid_in == map->input_base;
 - Still based on top of for-next/acpi branch of ARM64 repo

 drivers/acpi/arm64/iort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index b011d25..6e445bc 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -332,6 +332,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       map, rid_in);
 		if (rid_in != map->input_base)
 			return -ENXIO;
+
+		pr_err(FW_BUG "applying workaround.\n");
 	}
 
 	*rid_out = map->output_base + (rid_in - map->input_base);
-- 
1.7.12.4

