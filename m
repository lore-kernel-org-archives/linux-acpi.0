From: Yidi Lin <yidi.lin@canonical.com>
Subject: [PATCH] ACPI / video: Add Dell Inspiron 5737 to the blacklist
Date: Tue, 8 Jul 2014 10:14:59 +0800
Message-ID: <CAFquV7W-aDs=1R=aYOFzWw8rYiqiVNpQ-8T_wWHwvdh-u_wHWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:61506 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaGHCPA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2014 22:15:00 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so4766361vcb.35
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jul 2014 19:14:59 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

With win8 capability, the ACPI backlight control is broken on this model.
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
+       {
+       .callback = video_detect_force_vendor,
+       .ident = "Dell Inspiron 5737",
+       .matches = {
+               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+               DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
+               },
+       },
        { },
 };

--
1.7.9.5
