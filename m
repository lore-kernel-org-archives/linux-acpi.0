From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/20] ACPI: ibm-acpi: improve backlight power handling
Date: Fri,  9 Mar 2007 22:49:31 -0500
Message-ID: <11734985891723-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965834AbXCJDtu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:50 -0500
In-Reply-To: <11734985882949-git-send-email-len.brown@intel.com>
Message-Id: <c9bf296b6467968ecb9d988e7ed754a19c2e63d9.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Improve the backlight code to emulate as much as possible the power
management events, as we are unable to really power on or power off the
backlight.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ibm_acpi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index e7309a6..3690136 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -86,6 +86,7 @@
 
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/fb.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -1707,7 +1708,10 @@ static int brightness_write(char *buf)
 
 static int brightness_update_status(struct backlight_device *bd)
 {
-	return brightness_set(bd->props.brightness);
+	return brightness_set(
+		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+				bd->props.brightness : 0);
 }
 
 static struct backlight_ops ibm_backlight_data = {
-- 
1.5.0.3.310.g05ef5
