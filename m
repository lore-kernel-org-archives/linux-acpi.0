Return-Path: <SRS0=xM78=C2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB73C433E2
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D16822206
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgIQILv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:11:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbgIQIDt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95288322F17BFD3621B5;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:49 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 13/25] ACPI: event: Remove the ACPICA debug code
Date:   Thu, 17 Sep 2020 15:38:53 +0800
Message-ID: <1600328345-27627-14-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA debug code is not used, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/event.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 47f2159..1706439 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -19,9 +19,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("event");
-
 /* ACPI notifier chain */
 static BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
 
-- 
1.7.12.4

