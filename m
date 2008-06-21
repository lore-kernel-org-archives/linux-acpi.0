From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/7] acer-wmi: Respect framebuffer blanking in backlight
Date: Sat, 21 Jun 2008 09:09:27 +0100
Message-ID: <20080621080927.26920.58383.stgit@pacifica>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755151AbYFUIgO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:14 -0400
In-Reply-To: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

If the framebuffer has requested blanking, turn the backlight down. Also
offer the user the option to do this.

Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index b82ff25..e35825f 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
+#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
@@ -830,7 +831,15 @@ static int read_brightness(struct backlight_device *bd)
 
 static int update_bl_status(struct backlight_device *bd)
 {
-	set_u32(bd->props.brightness, ACER_CAP_BRIGHTNESS);
+	int intensity = bd->props.brightness;
+
+	if (bd->props.power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+
+	set_u32(intensity, ACER_CAP_BRIGHTNESS);
+
 	return 0;
 }
 
@@ -852,8 +861,9 @@ static int __devinit acer_backlight_init(struct device *dev)
 
 	acer_backlight_device = bd;
 
+	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.brightness = max_brightness;
 	bd->props.max_brightness = max_brightness;
-	bd->props.brightness = read_brightness(NULL);
 	backlight_update_status(bd);
 	return 0;
 }

