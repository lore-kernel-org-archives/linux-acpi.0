From: al.stone@linaro.org
Subject: [PATCH] ACPI: remove trailing whitespace
Date: Wed,  4 Dec 2013 12:59:11 -0700
Message-ID: <1386187151-27250-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60208 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3LDT7X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 14:59:23 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so23045700pdj.4
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 11:59:23 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Minor cleanup: remove some extra trailing white space.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/osl.c            | 2 +-
 drivers/acpi/processor_idle.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 54a20ff..44c07eb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1282,7 +1282,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 		jiffies = MAX_SCHEDULE_TIMEOUT;
 	else
 		jiffies = msecs_to_jiffies(timeout);
-	
+
 	ret = down_timeout(sem, jiffies);
 	if (ret)
 		status = AE_TIME;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 644516d..597cdab 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -598,7 +598,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		case ACPI_STATE_C2:
 			if (!cx->address)
 				break;
-			cx->valid = 1; 
+			cx->valid = 1;
 			break;
 
 		case ACPI_STATE_C3:
-- 
1.8.3.1

