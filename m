From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 6/7] ACPI video: support buggy BIOSes with _BCQ
	implemented
Date: Thu, 12 Mar 2009 16:57:10 +0800
Message-ID: <1236848230.2807.75.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51451 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbZCLI4N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 04:56:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Some buggy BIOSes implements _BCQ instead of _BQC.
Support these buggy BIOSes in ACPI video driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -162,6 +162,7 @@ struct acpi_video_device_cap {
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
 	u8 _BQC:1;		/* Get current brightness level */
+	u8 _BCQ:1;		/* Some buggy BIOS uses _BCQ instead of _BQC */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
@@ -523,8 +524,10 @@ acpi_video_device_lcd_get_level_current(
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
@@ -544,8 +547,8 @@ acpi_video_device_lcd_get_level_current(
 			 * ACPI video backlight still works w/ buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
-			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
-			device->cap._BQC = 0;
+			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
+			device->cap._BQC = device->cap._BCQ = 0;
 		}
 	}
 
@@ -861,6 +864,11 @@ static void acpi_video_device_find_cap(s
 	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
 		device->cap._BQC = 1;
+	else if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCQ",&h_dummy1))) {
+		printk(KERN_WARNING FW_BUG "_BCQ is used instead of _BQC\n");
+		device->cap._BCQ = 1;
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}


