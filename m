From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/84] acer-wmi: Respect framebuffer blanking in backlight
Date: Sat, 28 Jun 2008 01:43:22 -0400
Message-ID: <662e343664057e1fe7d9364b6044d155fea2c886.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61855 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYF1Fo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:59 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500J7ARYTT4HA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:53 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

If the framebuffer has requested blanking, turn the backlight down. Also
offer the user the option to do this.

Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.5.6.1.89.gd544

