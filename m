From: Jens Reyer <jens.reyer@gmail.com>
Subject: [PATCH v2] ACPI / video: Disable native backlight on Samsung Series 9 laptops
Date: Tue, 17 Feb 2015 19:07:29 +0100
Message-ID: <1424196449-21813-1-git-send-email-jens.reyer@gmail.com>
References: <20150216052443.GA11266@aaronlu.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:62692 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbbBQSIK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2015 13:08:10 -0500
Received: by mail-wg0-f54.google.com with SMTP id y19so37574375wgg.13
        for <linux-acpi@vger.kernel.org>; Tue, 17 Feb 2015 10:08:09 -0800 (PST)
In-Reply-To: <20150216052443.GA11266@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jens Reyer <jens.reyer@gmail.com>

Add video_disable_native_backlight quirk for SAMSUNG 900X3C/900X3D/
900X3E/900X4C/900X4D laptops.

The native intel backlight controls do not work correctly on SAMSUNG
Series 9 (900X3C/900X3D/900X3E/900X4C/900X4D) laptops:
One machine has an completely dimmed (= black) display after boot at the
GDM login screen and brightness controls work only between 0 and 5%
(= no effect).
Another machine has the same brightness control issues if an external
HDMI monitor is or gets connected, although the initial brightness is
ok.
After login to Gnome both machines always work fine.

Tested on both machines.

Bug-Link: https://bugs.freedesktop.org/show_bug.cgi?id=87286
Bug-Link: https://bugs.debian.org/772440
Signed-off-by: Jens Reyer <jens.reyer@gmail.com>
---
 drivers/acpi/video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 88a4f99..debd309 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -540,6 +540,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
 		},
 	},
+	{
+	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "900X3C/900X3D/900X3E/900X4C/900X4D"),
+		},
+	},
 
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
-- 
2.1.4

