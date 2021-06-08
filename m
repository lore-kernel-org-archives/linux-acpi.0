Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E04C47082
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A9361182
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhFHMSw (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:18:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4403 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhFHMSv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 08:18:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzpzQ1Mtyz6tq1;
        Tue,  8 Jun 2021 20:13:06 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:16:56 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:16:56 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rafael.j.wysocki@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] PNP: pnpbios: convert list_for_each to entry variant
Date:   Tue, 8 Jun 2021 20:35:32 +0800
Message-ID: <1623155732-62028-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/pnp/pnpbios/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 9b760e7..669ef47 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -298,14 +298,12 @@ struct pnp_protocol pnpbios_protocol = {
 
 static int __init insert_device(struct pnp_bios_node *node)
 {
-	struct list_head *pos;
 	struct pnp_dev *dev;
 	char id[8];
 	int error;
 
 	/* check if the device is already added */
-	list_for_each(pos, &pnpbios_protocol.devices) {
-		dev = list_entry(pos, struct pnp_dev, protocol_list);
+	list_for_each_entry(dev, &pnpbios_protocol.devices, protocol_list) {
 		if (dev->number == node->handle)
 			return -EEXIST;
 	}
-- 
2.6.2

