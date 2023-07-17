Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE9C001DE
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Jul 2023 10:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGQKTP (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGQKTO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 06:19:14 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C01BE;
        Mon, 17 Jul 2023 03:19:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VnaoQQL_1689589138;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VnaoQQL_1689589138)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 18:19:05 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: [PATCH v1] ACPI/IORT: fix IORT Reserved Memory Range node mapping error
Date:   Mon, 17 Jul 2023 18:18:58 +0800
Message-Id: <1689589138-58042-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the ARM IORT specifications DEN 0049E.d, the recommended ID mapping format：
Field		Note Description
--------------------------------
Input base	The lowest value in the input range
Number of IDs	The number of IDs in the range "minus" one

When there is only one id mapping in the Reserved Memory Range
(RMR) node, the node filed: "Number of IDs" is zero and
iort_node_get_rmr_info will not analyse id mapping. This is
not in compliance with the regulations.

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

