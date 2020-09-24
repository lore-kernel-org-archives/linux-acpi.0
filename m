Return-Path: <SRS0=CdCY=DB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348AEC4727E
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BFA23600
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIXDFT (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 23 Sep 2020 23:05:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIXDFR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B392B433A21F1C4A5754;
        Thu, 24 Sep 2020 11:05:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:07 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 08/15] ACPI: dock: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:00 +0800
Message-ID: <1600916227-21805-9-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA debug code ACPI_MODULE_NAME() is not used, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/dock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 9bd72c2..45d4b7b6 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -20,8 +20,6 @@
 
 #include "internal.h"
 
-ACPI_MODULE_NAME("dock");
-
 static bool immediate_undock = 1;
 module_param(immediate_undock, bool, 0644);
 MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
-- 
1.7.12.4

