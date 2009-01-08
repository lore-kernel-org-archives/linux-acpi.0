From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 1/2] backlight: always update the brightness when
	poking "brightness"
Date: Thu, 08 Jan 2009 14:32:20 +0800
Message-ID: <1231396340.20746.80.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32316 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbZAHGbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 01:31:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rpurdie@rpsys.net
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

bd->props.brightness doesn't reflect the actual backlight level.
Always invoke backlight_update_status when users want to change
the backlight.

For setups where brightness change is an expensive operation,
this could be done in the driver rather than the core.

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


