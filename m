From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI / video: Add force_none quirk for Dell OptiPlex 9020M
Date: Wed, 12 Jul 2017 17:45:57 -0700
Message-ID: <1499906757-8562-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdGMAqE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2017 20:46:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, alex.hung@canonical.com

Dell OptiPlex 9020M is a micro PC desktop that has no built-in
LCD panel and it's acpi_video does not work.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/video_detect.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d179e8d..601e5d3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -103,6 +103,12 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int video_detect_force_none(const struct dmi_system_id *d)
+{
+	acpi_backlight_dmi = acpi_backlight_none;
+	return 0;
+}
+
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/* On Samsung X360, the BIOS will set a flag (VDRV) if generic
 	 * ACPI backlight device is used. This flag will definitively break
@@ -313,6 +319,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_none,
+	 .ident = "Dell OptiPlex 9020M",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
+		},
+	},
 	{ },
 };
 
-- 
2.7.4

