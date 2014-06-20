From: Edward Lin <yidi.lin@canonical.com>
Subject: [PATCH] ACPI / video: Add Dell Inspiron 5737 to the blacklist
Date: Fri, 20 Jun 2014 16:13:42 +0800
Message-ID: <1403252022-17461-1-git-send-email-yidi.lin@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34842 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbaFTINr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2014 04:13:47 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so2718239pdi.18
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2014 01:13:46 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: yidi.lin@canonical.com

With win8 capabiltiy, the ACPI backlight control is broken.
The system also loses backlight setting when resuming from S3.

Add this model to the the ACPI video detect blacklist to make backlight
functionality work.

Although backlight functionality works via video.use_native_backlight=1,
this approach may be safer.

Signed-off-by: Edward Lin <yidi.lin@canonical.com>
---
 drivers/acpi/video_detect.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 33e3db5..c42feb2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -166,6 +166,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Dell Inspiron 5737",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
+		},
+	},
 	{ },
 };
 
-- 
1.7.9.5

