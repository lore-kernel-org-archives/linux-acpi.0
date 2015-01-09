From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] acpi-video: Add disable_native_backlight quirk for Samsung 730U3E/740U3E
Date: Fri,  9 Jan 2015 16:22:57 +0100
Message-ID: <1420816977-14054-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbbAIPXB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2015 10:23:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The Samsung 730U3E/740U3E has integrated ATI Radeon graphics, and backlight
control does not work properly when using the native interfaces.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1094948
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add missing "," so that things actually compile
---
 drivers/acpi/video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 032db45..497d986 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -522,6 +522,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
 		},
 	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 730U3E/740U3E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
+		},
+	},
 
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
-- 
2.1.0

