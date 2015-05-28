From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi_video: Add enable_native_backlight quirk for MacbookPro12,1
Date: Thu, 28 May 2015 18:29:48 +0200
Message-ID: <1432830588-12635-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbbE1Q3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 May 2015 12:29:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Christopher Beland <beland@alum.mit.edu>

It seems that the latest generation of MacbookPro needs to use the
native backlight driver, just like most modern laptops do, but it does
not automatically get enabled as the Apple BIOS does not advertise
Windows 8 compatibility. So add a quirk for this.

Cc: Christopher Beland <beland@alum.mit.edu>
Reported-by: Christopher Beland <beland@alum.mit.edu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cc79d3f..518f0e1 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -583,6 +583,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
 		},
 	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
+	 .callback = video_enable_native_backlight,
+	 .ident = "Apple MacBook Pro 12,1",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
+		},
+	},
 	{}
 };
 
-- 
2.4.1

