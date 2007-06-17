From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH RESEND] ACPI video: guess flags for devices with non-standard addressing
Date: Sun, 17 Jun 2007 01:02:15 +0100 (BST)
Message-ID: <20070617000215.ADA8D7B409F@zog.reactivated.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:14151 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754721AbXFQACM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2007 20:02:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Dell laptops seem to address video devices without the device_id_scheme bit,
which means that Linux doesn't know the device types of the video devices.

This patch makes the ACPI video driver guess the device type based on the
device name for devices which do not have the device_id_scheme set. This
fixes the flags field for all 4 of my video devices on this laptop
(Inspiron 640m).

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/acpi/video.c
===================================================================
--- linux.orig/drivers/acpi/video.c
+++ linux/drivers/acpi/video.c
@@ -1343,26 +1343,46 @@ acpi_video_bus_get_one_device(struct acp
 
 		attribute = acpi_video_get_device_attr(video, device_id);
 
-		if((attribute != NULL) && attribute->device_id_scheme) {
-			switch (attribute->display_type) {
-			case ACPI_VIDEO_DISPLAY_CRT:
-				data->flags.crt = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_TV:
-				data->flags.tvout = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_DVI:
-				data->flags.dvi = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_LCD:
-				data->flags.lcd = 1;
-				break;
-			default:
-				data->flags.unknown = 1;
-				break;
+		if (attribute) {
+			if (!attribute->device_id_scheme) {
+				char *name = acpi_device_bid(device);
+
+				/* Dell laptops seem to follow standard video
+				 * device addressing but do not set the
+				 * device_id_scheme bit.
+				 * Guess the flags based on the device names.
+				 */
+				if (strcmp(name, "CRT") == 0)
+					data->flags.crt = 1;
+				else if (strcmp(name, "TV") == 0)
+					data->flags.tvout = 1;
+				else if (strcmp(name, "DVI") == 0)
+					data->flags.dvi = 1;
+				else if (strcmp(name, "LCD") == 0)
+					data->flags.lcd = 1;
+				else
+					data->flags.unknown = 1;
+			} else {
+				switch (attribute->display_type) {
+				case ACPI_VIDEO_DISPLAY_CRT:
+					data->flags.crt = 1;
+					break;
+				case ACPI_VIDEO_DISPLAY_TV:
+					data->flags.tvout = 1;
+					break;
+				case ACPI_VIDEO_DISPLAY_DVI:
+					data->flags.dvi = 1;
+					break;
+				case ACPI_VIDEO_DISPLAY_LCD:
+					data->flags.lcd = 1;
+					break;
+				default:
+					data->flags.unknown = 1;
+					break;
+				}
+				if(attribute->bios_can_detect)
+					data->flags.bios = 1;
 			}
-			if(attribute->bios_can_detect)
-				data->flags.bios = 1;
 		} else
 			data->flags.unknown = 1;
 
