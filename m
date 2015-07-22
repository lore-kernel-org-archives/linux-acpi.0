From: Mathieu OTHACEHE <m.othacehe@gmail.com>
Subject: [PATCH] acpi-video: Fix brightness keys for Thinkpad X240
Date: Wed, 22 Jul 2015 07:52:26 +0200
Message-ID: <1437544346-32285-1-git-send-email-m.othacehe@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38626 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbbGVFwj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jul 2015 01:52:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu OTHACEHE <m.othacehe@gmail.com>

Thinkpad X240 laptop has a working acpi_video backlight control but
using the default native backlight control, brightness keys does not work.

This patch force acpi_video use for this laptop by adding an exception in
video_detect_dmi_table.

Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 815f75e..c4bc5f2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -173,6 +173,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
 		},
 	},
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad X240",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X240"),
+		},
+	},
 
 	/* The native backlight controls do not work on some older machines */
 	{
-- 
2.4.5

