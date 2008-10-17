From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.26.stable] ACPI: Ignore _BQC object when registering
 backlight device
Date: Fri, 17 Oct 2008 02:16:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810170213450.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:59952 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYJQGQo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 02:16:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K8V00J8IDFVYN94@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 01:16:43 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

upstream commmit: c2c789057f075022658b38b498755c29c1ba8055

According to acpi spec , the objectes of  _BCL and _BCM are required if
integrated LCD is present and supports brightness level and the _BQC is
the optional object. So the _BQC object will be ignored when the backlight
device is registered.
At the same time when there is no _BQC object, the current brightness will be
set to the maximum.

http://bugzilla.kernel.org/show_bug.cgi?id=10206

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/acpi/video.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6.26.y/drivers/acpi/video.c
===================================================================
--- linux-2.6.26.y.orig/drivers/acpi/video.c
+++ linux-2.6.26.y/drivers/acpi/video.c
@@ -720,7 +720,7 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
-	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
+	if (device->cap._BCL && device->cap._BCM && max_level > 0) {
 		int result;
 		static int count = 0;
 		char *name;
@@ -732,7 +732,17 @@ static void acpi_video_device_find_cap(s
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
 
