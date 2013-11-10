From: al.stone@linaro.org
Subject: [PATCH 03/12] ACPI: clean up compiler warning about uninitialized field
Date: Sat,  9 Nov 2013 18:36:13 -0700
Message-ID: <1384047382-20623-4-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:51007 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:35 -0500
Received: by mail-ie0-f177.google.com with SMTP id e14so5724388iej.36
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:35 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 14df305..721e949 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -525,7 +525,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 * generate wakeup events.
 	 */
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
-		acpi_event_status pwr_btn_status;
+		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
 
 		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
 
-- 
1.8.3.1

