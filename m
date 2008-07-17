From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]  ACPI:  Ignore _BQC object when registering backlight
	device
Date: Thu, 17 Jul 2008 10:46:05 +0800
Message-ID: <1216262765.7169.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15243 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbYGQCei (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 22:34:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

>From : Zhao Yakui <yakui.zhao@intel.com>

According to acpi spec , the objectes of  _BCL and _BCM are required if
integrated LCD is present and supports brightness level and the _BQC is
the optional object. So the _BQC object will be ignored when the backlight 
device is registered.
At the same time when there is no _BQC object, the current brightness will be
set to the maximum.

http://bugzilla.kernel.org/show_bug.cgi?id=10206

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/video.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -741,7 +741,7 @@ static void acpi_video_device_find_cap(s
 
 	max_level = acpi_video_init_brightness(device);
 
-	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
+	if (device->cap._BCL && device->cap._BCM && max_level > 0) {
 		int result;
 		static int count = 0;
 		char *name;
@@ -753,7 +753,17 @@ static void acpi_video_device_find_cap(s
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
 		device->backlight->props.max_brightness = device->brightness->count-3;
-		device->backlight->props.brightness = acpi_video_get_brightness(device->backlight);
+		/*
+		 * If there exists the _BQC object, the _BQC object will be
+		 * called to get the current backlight brightness. Otherwise
+		 * the brightness will be set to the maximum.
+		 */
+		if (device->cap._BQC)
+			device->backlight->props.brightness =
+				acpi_video_get_brightness(device->backlight);
+		else
+			device->backlight->props.brightness =
+				device->backlight->props.max_brightness;
 		backlight_update_status(device->backlight);
 		kfree(name);
 


