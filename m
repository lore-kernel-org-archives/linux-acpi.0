From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Wed, 29 May 2013 17:16:17 +0530
Message-ID: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40382 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965879Ab3E2MAQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2013 08:00:16 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so8697123pdj.29
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2013 05:00:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org, Huang Ying <ying.huang@intel.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/ghes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d668a8a..e03c20e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1011,8 +1011,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	kfree(ghes);
 
-	platform_set_drvdata(ghes_dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

