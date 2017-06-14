From: "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>
Subject: [PATCH] ACPI / video: Add quirks for the Dell Precision 7510
Date: Wed, 14 Jun 2017 16:29:16 +0800
Message-ID: <1497428956-31233-1-git-send-email-sylee@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35049 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754590AbdFNI3U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2017 04:29:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so22693478pgc.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jun 2017 01:29:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The Dell Precision 7510 has a broken acpi-video implementation.

The backlight control bits work, but when the brightness is changed via
the acpi-video interface the backlight flickers annoyingly before settling
at the new brightness, switching to using the native interface fixes the
flickering so add a quirk for this (the vendor interface can not change the
brightness at all).

Signed-off-by: Shih-Yuan Lee (FourDollars) <sylee@canonical.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7f48156..d179e8d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -305,6 +305,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 .ident = "Dell Precision 7510",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
+		},
+	},
 	{ },
 };
 
-- 
2.7.4

