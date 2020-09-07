Return-Path: <SRS0=PXo4=CQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC6DC2BB84
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEF42145D
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgIGJEh (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:04:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgIGJEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2151A43B1A30621C55C3;
        Mon,  7 Sep 2020 17:04:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 17:04:16 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 5/5] ACPI / APD: Head file including cleanups
Date:   Mon, 7 Sep 2020 16:56:21 +0800
Message-ID: <1599468981-17301-6-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
References: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make the including head files to be alphabetical order, and
remove the not needed head file inclusion.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 561d9ba..5d50ca7 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -7,17 +7,13 @@
  *	Wu, Jeff <Jeff.Wu@amd.com>
  */
 
-#include <linux/clk-provider.h>
-#include <linux/platform_data/clk-fch.h>
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-#include <linux/clkdev.h>
 #include <linux/acpi.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/pm.h>
-
-#include "internal.h"
+#include <linux/platform_data/clk-fch.h>
+#include <linux/platform_device.h>
 
 struct apd_private_data;
 
-- 
1.7.12.4

