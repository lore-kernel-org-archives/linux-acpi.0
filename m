From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] ACPI video: prevent from reporting birghtness keyevents
Date: Fri, 13 Jul 2012 14:52:47 +0800
Message-ID: <1342162367-10467-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62877 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2GMGwv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 02:52:51 -0400
Received: by pbbrp8 with SMTP id rp8so5017851pbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 23:52:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Corentin Chary <corentincj@iksaif.net>

Prevent ACPI video from reporting brightness keyevents if the driver
already adjust the brightness, or userspace app will adjust the brightness
value again.

We should distinguish keyevent from uevent, keyevent is used to inform the
usespace app to do what the meaning of the key is.
And uevent is used to say that the required action is already taken,
userspace app could monitor uevent to show OSD or do any kind of
notification they want.
The backlight subsystem will emit the uevent once the brightness had
changed, so ACPI video driver doesn't have to report the keyevent.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/acpi/video.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..221cff2 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1546,7 +1546,8 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_notifier_call_chain(device, event, 0);
 
-	if (keycode) {
+	/* Report keyevent only if the driver didn't adjust the brightness */
+	if (keycode && !brightness_switch_enabled) {
 		input_report_key(input, keycode, 1);
 		input_sync(input);
 		input_report_key(input, keycode, 0);
-- 
1.7.9.5

