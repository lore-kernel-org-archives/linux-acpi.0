Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170AFC2D0E4
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Nov 2020 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B044E206B5
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Nov 2020 12:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgKXMhE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:37:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7673 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMhE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2020 07:37:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CgNn5297Jz15PnZ;
        Tue, 24 Nov 2020 20:36:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 20:36:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>
Subject: [PATCH] acpi/nfit: fix application of sizeof to pointer
Date:   Tue, 24 Nov 2020 20:37:21 +0800
Message-ID: <1606221441-58002-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fixed the coccinelle:
drivers/acpi/nfit/core.c:2271:3-10: WARNING use flexible-array member
instead.
drivers/acpi/nfit/core.c:2282:3-10: WARNING use flexible-array member
instead.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/nfit/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4426082..c589371 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2268,7 +2268,7 @@ struct nfit_set_info {
 		u64 region_offset;
 		u32 serial_number;
 		u32 pad;
-	} mapping[0];
+	} mapping[];
 };
 
 struct nfit_set_info2 {
@@ -2279,7 +2279,7 @@ struct nfit_set_info2 {
 		u16 manufacturing_date;
 		u8  manufacturing_location;
 		u8  reserved[31];
-	} mapping[0];
+	} mapping[];
 };
 
 static size_t sizeof_nfit_set_info(int num_mappings)
-- 
2.7.4

