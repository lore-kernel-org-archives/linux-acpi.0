From: al.stone@linaro.org
Subject: [PATCH] ACPI: clean up compiler warning about uninitialized field
Date: Wed, 20 Nov 2013 15:45:51 -0700
Message-ID: <1384987551-13154-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57735 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab3KTWqE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 17:46:04 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so8529709iec.27
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 14:46:03 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Initialize pwr_btn_status as disabled which (a) makes sure it is
in a proper state to start, and (b) cleans up a compiler warning
about an uninitialized variable.

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

