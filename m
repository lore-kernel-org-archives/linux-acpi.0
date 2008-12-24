From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Wed, 24 Dec 2008 11:07:38 +0800
Message-ID: <1230088058.562.219.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12579 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYLXDJb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Dec 2008 22:09:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rpurdie@rpsys.net
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

bd->props.brightness is a cached value.
the current code has some potential problems when poking the
backlight I/F.

For example,
1. set the brightness level to 5 via sysfs I/F
2. set the backlight to another level via the procfs,
3. setting it back to 5 doesn't work because bd->props.brightness
is still 5.

http://bugzilla.kernel.org/show_bug.cgi?id=12249

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/video/backlight/backlight.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/video/backlight/backlight.c
===================================================================
--- linux-2.6.orig/drivers/video/backlight/backlight.c
+++ linux-2.6/drivers/video/backlight/backlight.c
@@ -134,10 +134,8 @@ static ssize_t backlight_store_brightnes
 		else {
 			pr_debug("backlight: set brightness to %d\n",
 				 brightness);
-			if (bd->props.brightness != brightness) {
-				bd->props.brightness = brightness;
-				backlight_update_status(bd);
-			}
+			bd->props.brightness = brightness;
+			backlight_update_status(bd);
 			rc = count;
 		}
 	}


