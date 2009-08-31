From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: workaround buggy _BQC method that exports
	uninitialized value
Date: Mon, 31 Aug 2009 14:39:26 +0800
Message-ID: <1251700766.3483.137.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7957 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbZHaGl0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Aug 2009 02:41:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, alain57@gmail.com


_BQC on some laptops returns an uninitialized value when it's
invoked for the first time.
Set the laptop to the maximum backlight level in this case.
http://bugzilla.kernel.org/show_bug.cgi?id=13955

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -870,7 +870,7 @@ acpi_video_init_brightness(struct acpi_v
 	br->flags._BCM_use_index = br->flags._BCL_use_index;
 
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
-	br->curr = level_old = max_level;
+	br->curr = level = max_level;
 
 	if (!device->cap._BQC)
 		goto set_level;
@@ -892,15 +892,25 @@ acpi_video_init_brightness(struct acpi_v
 
 	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
 
-	if (!br->flags._BQC_use_index)
+	if (!br->flags._BQC_use_index) {
+		/*
+		 * Set the backlight to the initial state.
+		 * On some buggy laptops, _BQC returns an uninitialized value
+		 * when invoked for the first time, i.e. level_old is invalid.
+		 * set the backlight to max_level in this case
+		 */
+		for (i = 2; i < br->count; i++)
+			if (level_old == br->levels[i])
+				level = level_old;
 		goto set_level;
+	}
 
 	if (br->flags._BCL_reversed)
 		level_old = (br->count - 1) - level_old;
-	level_old = br->levels[level_old];
+	level = br->levels[level_old];
 
 set_level:
-	result = acpi_video_device_lcd_set_level(device, level_old);
+	result = acpi_video_device_lcd_set_level(device, level);
 	if (result)
 		goto out_free_levels;
 


