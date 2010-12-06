From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/7] ACPI video: introduce module parameter
 video.use_bios_initial_backlight
Date: Mon, 06 Dec 2010 15:04:27 +0800
Message-ID: <1291619067.19296.580.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37697 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0LFHHh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce module parameter video.use_bios_initial_backlight.

Some BIOSes claim they use the minimum backlight at boot,
and this may bring dimming screen after boot.
https://bugzilla.kernel.org/show_bug.cgi?id=21212

use video.use_bios_initl_backlight=0 to use
the maximum backlight level after boot.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -80,6 +80,13 @@ module_param(brightness_switch_enabled, 
 static int allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
+/*
+ * Some BIOSes claim they use minimum backlight at boot,
+ * and this may bring dimming screen after boot
+ */
+static int use_bios_initial_backlight = 1;
+module_param(use_bios_initial_backlight, bool, 0644);
+
 static int register_count = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
@@ -705,9 +712,11 @@ acpi_video_init_brightness(struct acpi_v
 		 * when invoked for the first time, i.e. level_old is invalid.
 		 * set the backlight to max_level in this case
 		 */
-		for (i = 2; i < br->count; i++)
-			if (level_old == br->levels[i])
-				level = level_old;
+		if (use_bios_initial_backlight) {
+			for (i = 2; i < br->count; i++)
+				if (level_old == br->levels[i])
+					level = level_old;
+		}
 		goto set_level;
 	}
 


