Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4987C001DC
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Jul 2023 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGQLeK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 17 Jul 2023 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQLeJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 07:34:09 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE10E4F;
        Mon, 17 Jul 2023 04:34:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VnblUxn_1689593625;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VnblUxn_1689593625)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 19:34:03 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()
Date:   Mon, 17 Jul 2023 19:33:45 +0800
Message-Id: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ARM IORT specifications DEN 0049 issue E,
the "Number of IDs" field in the ID mapping format reports
the number of IDs in the mapping range minus one.

In iort_node_get_rmr_info(), we erroneously skip ID mappings
whose "Number of IDs" equal to 0, resulting in valid mapping
nodes with a single ID to map being skipped, which is wrong.

Fix iort_node_get_rmr_info() by removing the bogus id_count
check.

Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/acpi/arm64/iort.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3631230..56d8873 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 	for (i = 0; i < node->mapping_count; i++, map++) {
 		struct acpi_iort_node *parent;
 
-		if (!map->id_count)
-			continue;
-
 		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 				      map->output_reference);
 		if (parent != iommu)
-- 
1.8.3.1

