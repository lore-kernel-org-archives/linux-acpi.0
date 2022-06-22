Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71DBC433EF
	for <linux-acpi@archiver.kernel.org>; Wed, 22 Jun 2022 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbiFVHn6 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 22 Jun 2022 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354404AbiFVHnv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 03:43:51 -0400
Received: from smtpbguseast3.qq.com. (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AE1EEC3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 00:43:49 -0700 (PDT)
X-QQ-mid: bizesmtp83t1655883815trvmmqa2
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 15:43:24 +0800 (CST)
X-QQ-SSF: 01400000002000B0H000B00A0000000
X-QQ-FEAT: jfdGVjI73+T81TnlSi4p9QOo1iBGF/arBaslIxWtHgMUcP0stsCvvCLX8a36k
        ylxuZOlSgD1fVM5tylCrGMcXAvkXQvmMN+aDY9xtAIfKaVDKBh8tm8caMgrr6pscMUmJ0kf
        4fdBwVRQ5FwisVjc8+hKua0zRHSQPaibrOf8t0EHmw75PEESYBUPli/NO22yxpqKYTfAb9V
        MRq5yxvWY0QuaV1x67bu0qK7ncNyDIxYBu3R3qk1NO64eZBShfsqtPdcVbxYVT3zS/GsPq8
        2eB0WtXz+7qEIkE6st2tpWcSNJVPL4AjjoVAzOKP3/lFAvOTmGTpFCq59m6BONNALRK33eA
        p8Ulac7vkIyLHBxU0E=
X-QQ-GoodBg: 2
From:   Manyi Li <limanyi@uniontech.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manyi Li <limanyi@uniontech.com>
Subject: [PATCH] ACPI: save NVS memory for Lenovo G40-45
Date:   Wed, 22 Jun 2022 15:42:48 +0800
Message-Id: <20220622074248.19004-1-limanyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[821d6f0359b0614792ab8e2fb93b503e25a65079] is to make machines
produced from 2012 to now not saving NVS region to accelerate S3.

But, Lenovo G40-45, a platform released in 2015, still needs NVS memory
saving during S3. A quirk is introduced for this platform.

Signed-off-by: Manyi Li <limanyi@uniontech.com>
---
 drivers/acpi/sleep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 04ea1569df78..974746e6e59d 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -360,6 +360,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
 		},
 	},
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Lenovo G40-45",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "80E1"),
+		},
+	},
 	/*
 	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
 	 * the Low Power S0 Idle firmware interface (see
-- 
2.20.1



