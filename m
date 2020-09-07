Return-Path: <SRS0=PXo4=CQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD7C433E2
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D54D215A4
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgIGNGJ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:06:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbgIGNFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 09:05:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 91824E8FDE701B7CD569;
        Mon,  7 Sep 2020 21:05:29 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:05:07 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <lkp@intel.com>,
        Ken Xue <Ken.Xue@amd.com>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 3/5] ACPI / APD: Remove ACPI_MODULE_NAME()
Date:   Mon, 7 Sep 2020 20:57:31 +0800
Message-ID: <1599483453-26635-4-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
References: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_MODULE_NAME() is used for ACPI debug output when using
ACPI debug print functions, but ACPI debug print functions are
not used in acpi_apd.c, remove the ACPI_MODULE_NAME().

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index c4bc4ab..4dbf85b 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -19,7 +19,6 @@
 
 #include "internal.h"
 
-ACPI_MODULE_NAME("acpi_apd");
 struct apd_private_data;
 
 /**
-- 
1.7.12.4

