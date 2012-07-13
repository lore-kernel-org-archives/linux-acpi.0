From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Fri, 13 Jul 2012 14:13:22 +0800
Message-ID: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44128 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030267Ab2GMGN2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 02:13:28 -0400
Received: by pbbrp8 with SMTP id rp8so4969671pbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 23:13:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

If user press the suspend hotkey many times quickly, system will keep
entering S3 after wake up as many times as user pressed.
We do not expect the system enter S3 again after wake up, even if we
press the hotkey many times.

This issue comes from the acpi proc event will queue the events that
didn't process yet, and then report the events one by one when available,
so that system will enter S3 after wake up.

I think it's safe not to generate the proc event while pressing the
suspend hotkey, since "/proc/acpi/event" is deprecated. And system can
enter S3 correctly without it.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/acpi/button.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d27d072..e35bd92 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -298,8 +298,6 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 
 			pm_wakeup_event(&device->dev, 0);
 		}
-
-		acpi_bus_generate_proc_event(device, event, ++button->pushed);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-- 
1.7.9.5

