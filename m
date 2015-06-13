From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 11/12] ACPI / video: constify ACPI and DMI id tables
Date: Sat, 13 Jun 2015 14:26:59 +0200
Message-ID: <1434198420-8519-12-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36659 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbFMM1X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:23 -0400
Received: by wigg3 with SMTP id g3so36844021wig.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:21 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Make the video ACPI device ID array static and constify the DMI system
IDs array. Safes us a little bit of code.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/video_detect.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c42feb2bacd0..be825802b228 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -109,7 +109,7 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	struct pci_dev *dev;
 	struct acpi_device *acpi_dev;
 
-	const struct acpi_device_id video_ids[] = {
+	static const struct acpi_device_id video_ids[] = {
 		{ACPI_VIDEO_HID, 0},
 		{"", 0},
 	};
@@ -134,7 +134,7 @@ static int video_detect_force_vendor(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id video_detect_dmi_table[] = {
+static const struct dmi_system_id video_detect_dmi_table[] = {
 	/* On Samsung X360, the BIOS will set a flag (VDRV) if generic
 	 * ACPI backlight device is used. This flag will definitively break
 	 * the backlight interface (even the vendor interface) untill next
-- 
1.7.10.4

