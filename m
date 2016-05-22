From: Ralf Gerbig <rge@quengel.org>
Subject: Patch Thinkpad X201T backlight
Date: Sun, 22 May 2016 19:23:59 +0200
Message-ID: <8737p8aq7k.fsf@quengel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.94.121.46.78.clients.your-server.de ([78.46.121.94]:41383
	"EHLO mail" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753566AbcEXHPB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 May 2016 03:15:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Hi,

the X201 Tablet needs the same treatmant as the X201s,
otherwise you can't change levels.

The patch is against 4.5.5 stable, but should apply to all recent
kernels.

Please be gentle, I am neither a programmer nor a developer.

If you have questions, feel free to ask, but don't expect an answer in
the next 10 to 20 days (going to hospital).

Regards,

Ralf Gerbig

---
commit a10b5a05eae1a990682ce238b8e0ac6ad791a8a9
Author: Ralf Gerbig <rge@quengel.org>
Date:   Sun May 22 18:56:22 2016 +0200

    The Thinkpad X201 Tablet also needs video_detect_force_video
    
    Signed-off-by: Ralf Gerbig <rge@quengel.org>

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 1316ddd..d8d7bd3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -167,6 +167,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
 		},
 	},
+        {
+         .callback = video_detect_force_video,
+         .ident = "ThinkPad X201T",
+         .matches = {
+                DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
+                },
+        },
 
 	/* The native backlight controls do not work on some older machines */
 	{
