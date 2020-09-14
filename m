Return-Path: <SRS0=0XZn=CX=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C76C43461
	for <linux-acpi@archiver.kernel.org>; Mon, 14 Sep 2020 00:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6296621D1A
	for <linux-acpi@archiver.kernel.org>; Mon, 14 Sep 2020 00:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgINArY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 13 Sep 2020 20:47:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgINArY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 13 Sep 2020 20:47:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C60D1802ACFD753FA8B
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2020 08:47:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 08:47:10 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] PNP: Fix duplicate included pci.h
Date:   Mon, 14 Sep 2020 08:44:50 +0800
Message-ID: <1600044290-12475-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

linux/pci.h is included more than once, Remove the one that isn't
necessary.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/pnp/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index de99f37..ac98b99 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -226,8 +226,6 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 	dev_info(&dev->dev, "made independent IRQ optional\n");
 }
 
-#include <linux/pci.h>
-
 static void quirk_system_pci_resources(struct pnp_dev *dev)
 {
 	struct pci_dev *pdev = NULL;
-- 
2.7.4

