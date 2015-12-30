From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: Add a quirk to force acpi-video backlight on
 SAMSUNG 530U4E/540U4E
Date: Wed, 30 Dec 2015 13:11:24 +0800
Message-ID: <5683677C.1030407@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42841 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbL3FL1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Dec 2015 00:11:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, adam bk <adamdd55@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>

The native interface on SAMSUNG 530U4E/540U4E doesn't work even though
the firmware claims Win8 compatible while the acpi_video interface
works, add a quirk for this.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=108971
Reported-and-tested-by: adam bk <adamdd55@gmail.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index daaf1c4e1e0f..518f9cdc929d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -250,6 +250,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
 		},
 	},
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=108971 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 530U4E/540U4E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
+		},
+	},
 
 	/* Non win8 machines which need native backlight nevertheless */
 	{
-- 
2.5.0

