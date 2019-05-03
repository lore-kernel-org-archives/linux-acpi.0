Return-Path: <SRS0=ceNZ=TD=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB7C43219
	for <linux-acpi@archiver.kernel.org>; Fri,  3 May 2019 23:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89D2075C
	for <linux-acpi@archiver.kernel.org>; Fri,  3 May 2019 23:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfECXYb (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 3 May 2019 19:24:31 -0400
Received: from foss.arm.com ([217.140.101.70]:40222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfECXYa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 May 2019 19:24:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E37168F;
        Fri,  3 May 2019 16:24:29 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A2CF3F557;
        Fri,  3 May 2019 16:24:29 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com, john.garry@huawei.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 5/5] perf: arm_spe: Enable ACPI/Platform automatic module loading
Date:   Fri,  3 May 2019 18:24:07 -0500
Message-Id: <20190503232407.37195-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503232407.37195-1-jeremy.linton@arm.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503232407.sl7GcPOff4G6akp2kY6dWnr4R4ZCdKCRLGmyFX8rYOs@z>

Lets add the MODULE_TABLE and platform id_table entries so that
the SPE driver can attach to the ACPI platform device created by
the core pmu code.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 7cb766dafe85..a11951b08330 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -38,6 +38,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
@@ -1176,7 +1177,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
 
-static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
+static const struct platform_device_id arm_spe_match[] = {
+	{ ARMV8_SPE_PDEV_NAME, 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, arm_spe_match);
+
+static int arm_spe_pmu_device_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct arm_spe_pmu *spe_pmu;
@@ -1236,11 +1243,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver arm_spe_pmu_driver = {
+	.id_table = arm_spe_match,
 	.driver	= {
 		.name		= DRVNAME,
 		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
 	},
-	.probe	= arm_spe_pmu_device_dt_probe,
+	.probe	= arm_spe_pmu_device_probe,
 	.remove	= arm_spe_pmu_device_remove,
 };
 
-- 
2.21.0

