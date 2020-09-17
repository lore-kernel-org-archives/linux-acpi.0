Return-Path: <SRS0=xM78=C2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2164FC43461
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC292083B
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Sep 2020 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIQIET (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:04:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35404 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgIQIDy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90FF1918173FBBE24C6D;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:52 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 17/25] ACPI: processor: Remove the duplicated ACPI_PROCESSOR_CLASS macro
Date:   Thu, 17 Sep 2020 15:38:57 +0800
Message-ID: <1600328345-27627-18-git-send-email-guohanjun@huawei.com>
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

The ACPI_PROCESSOR_CLASS macro is defined in <acpi/processor.h>,
and ACPI processor drivers include <acpi/processor.h>, so we
can remove the duplicated ACPI_PROCESSOR_CLASS macro.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/processor_idle.c       | 1 -
 drivers/acpi/processor_perflib.c    | 1 -
 drivers/acpi/processor_thermal.c    | 2 --
 drivers/acpi/processor_throttling.c | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 71a30b0d..ce24ba0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -31,7 +31,6 @@
 #include <asm/apic.h>
 #endif
 
-#define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8f..06ca924 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -22,7 +22,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_perflib");
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 6c7d05b..677a132 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -19,8 +19,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS            "processor"
-
 #ifdef CONFIG_CPU_FREQ
 
 /* If a passive cooling situation is detected, primarily CPUfreq is used, as it
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a0bd56e..b187653 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -22,7 +22,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
-- 
1.7.12.4

