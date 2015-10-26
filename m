From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi: video: Add a quirk to force acpi-video backlight on Dell XPS L421X
Date: Mon, 26 Oct 2015 15:20:46 +0100
Message-ID: <1445869246-29276-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbbJZOUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2015 10:20:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Just like the Dell XPS 15 (L521X) the Dell XPS 14 (L421X) needs to use
the acpi-video backlight interface rather then the native one for backlight
control to work, add a quirk for this.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1272633
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0d3a384..daaf1c4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -233,6 +233,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1272633 */
+	 .callback = video_detect_force_video,
+	 .ident = "Dell XPS14 L421X",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
+		},
+	},
+	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
 	 .callback = video_detect_force_video,
 	 .ident = "Dell XPS15 L521X",
-- 
2.5.0

