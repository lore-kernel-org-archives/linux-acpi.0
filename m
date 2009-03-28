From: Len Brown <lenb@kernel.org>
Subject: [PATCH 93/98] ACPI video: support buggy BIOSes with _BCQ implemented
Date: Sat, 28 Mar 2009 00:32:08 -0400
Message-ID: <c60d638e29c780b75b648283a197d0226e3576c3.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8549 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502AbZC1Edv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EIT8OBS1ME@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:48 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Some buggy BIOSes implements _BCQ instead of _BQC.
Male ACPI video driver support these buggy BIOS.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1f1625c..9730ec1 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -162,6 +162,7 @@ struct acpi_video_device_cap {
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
 	u8 _BQC:1;		/* Get current brightness level */
+	u8 _BCQ:1;		/* Some buggy BIOS uses _BCQ instead of _BQC */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
@@ -523,8 +524,10 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 {
 	acpi_status status = AE_OK;
 
-	if (device->cap._BQC) {
-		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
+	if (device->cap._BQC || device->cap._BCQ) {
+		char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
+
+		status = acpi_evaluate_integer(device->dev->handle, buf,
 						NULL, level);
 		if (ACPI_SUCCESS(status)) {
 			if (device->brightness->flags._BQC_use_index) {
@@ -544,8 +547,8 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 			 * ACPI video backlight still works w/ buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
-			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
-			device->cap._BQC = 0;
+			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
+			device->cap._BQC = device->cap._BCQ = 0;
 		}
 	}
 
@@ -861,6 +864,12 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
 		device->cap._BQC = 1;
+	else if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCQ",
+				&h_dummy1))) {
+		printk(KERN_WARNING FW_BUG "_BCQ is used instead of _BQC\n");
+		device->cap._BCQ = 1;
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
-- 
1.6.0.6

