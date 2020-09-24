Return-Path: <SRS0=CdCY=DB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BEC2D0A8
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C7D2311E
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Sep 2020 03:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIXDFR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 23 Sep 2020 23:05:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbgIXDFQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFADA2D6CBA8FF57D763;
        Thu, 24 Sep 2020 11:05:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:09 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 11/15] ACPI: proc: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:03 +0800
Message-ID: <1600916227-21805-12-git-send-email-guohanjun@huawei.com>
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

Remove the not used ACPICA debug code _COMPONENT and ACPI_MODULE_NAME()
which were not used even when proc.c was introduced.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 7892980..0cca799 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -10,15 +10,11 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-
 /*
  * this file provides support for:
  * /proc/acpi/wakeup
  */
 
-ACPI_MODULE_NAME("sleep")
-
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
-- 
1.7.12.4

