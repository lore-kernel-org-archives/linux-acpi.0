Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2490C48BCD
	for <linux-acpi@archiver.kernel.org>; Thu, 10 Jun 2021 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC31613E3
	for <linux-acpi@archiver.kernel.org>; Thu, 10 Jun 2021 09:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFJJmp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:42:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60979 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhFJJmp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 05:42:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UbxKN6e_1623318041;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbxKN6e_1623318041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jun 2021 17:40:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] ACPI: sleep: Fix kernel-doc
Date:   Thu, 10 Jun 2021 17:40:39 +0800
Message-Id: <1623318039-57133-2-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix function name in sleep.c kernel-doc comment
to remove a warning found by running make W=1 LLVM=1.

drivers/acpi/sleep.c:413: warning: expecting prototype for
acpi_pre_suspend(). Prototype was for acpi_pm_pre_suspend() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aaea10d..3023224 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -407,7 +407,7 @@ static int acpi_pm_freeze(void)
 }
 
 /**
- * acpi_pre_suspend - Enable wakeup devices, "freeze" EC and save NVS.
+ * acpi_pm_pre_suspend - Enable wakeup devices, "freeze" EC and save NVS.
  */
 static int acpi_pm_pre_suspend(void)
 {
-- 
1.8.3.1

