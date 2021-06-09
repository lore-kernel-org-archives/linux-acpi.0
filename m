Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E6C48BCD
	for <linux-acpi@archiver.kernel.org>; Wed,  9 Jun 2021 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3433613D7
	for <linux-acpi@archiver.kernel.org>; Wed,  9 Jun 2021 17:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFIRfK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:35:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50150 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFIRfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 13:35:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lr24m-00016g-8P; Wed, 09 Jun 2021 17:33:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: scan: ensure ret is initialized to avoid garbage being returned
Date:   Wed,  9 Jun 2021 18:33:12 +0100
Message-Id: <20210609173312.298414-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the unlikely event that there are no callback calls made then ret
will be returned as an uninitialized value. Clean up static analysis
warnings by ensuring ret is initialized.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a9e10e587304 ("ACPI: scan: Extend acpi_walk_dep_device_list()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c3067e8bfc47..0945d952f0fc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2151,7 +2151,7 @@ int acpi_walk_dep_device_list(acpi_handle handle,
 			      void *data)
 {
 	struct acpi_dep_data *dep, *tmp;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&acpi_dep_list_lock);
 	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
-- 
2.31.1

