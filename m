From: al.stone@linaro.org
Subject: [PATCH] ACPI: explicitly initialize a value to silence compiler warning
Date: Mon, 16 Dec 2013 17:01:37 -0700
Message-ID: <1387238497-13788-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40106 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab3LQABs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 19:01:48 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so7481428ieb.22
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 16:01:48 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

In acpi_processor_resume(), the variable resumed_bm_rld is being
used without being initialized, so initialize it.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..86d11a6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -213,7 +213,7 @@ static int acpi_processor_suspend(void)
 
 static void acpi_processor_resume(void)
 {
-	u32 resumed_bm_rld;
+	u32 resumed_bm_rld = 0;
 
 	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_RLD, &resumed_bm_rld);
 	if (resumed_bm_rld == saved_bm_rld)
-- 
1.8.3.1

