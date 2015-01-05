From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell XPS15 L521X
Date: Mon,  5 Jan 2015 08:57:04 +0100
Message-ID: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbbAEH5K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jan 2015 02:57:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The L521X variant of the Dell XPS15 has integrated nvidia graphics, and
backlight control does not work properly when using the native interfaces.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1163574
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index c72e79d2c5..032db45 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -522,6 +522,16 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
 		},
 	},
+
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "Dell XPS15 L521X",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
+		},
+	},
 	{}
 };
 
-- 
2.1.0

