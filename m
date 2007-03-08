From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: improve backlight power handling
Date: Thu,  8 Mar 2007 05:28:15 -0300
Message-ID: <11733424953358-git-send-email-hmh@hmh.eng.br>
References: 20070308074326.GA13601@khazad-dum.debian.net <11733424952501-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48395 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030262AbXCHI2V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Mar 2007 03:28:21 -0500
In-Reply-To: <11733424952501-git-send-email-hmh@hmh.eng.br>
In-Reply-To: <20070308074326.GA13601@khazad-dum.debian.net>
References: <20070308074326.GA13601@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Improve the backlight code to emulate as much as possible the power
management events, as we are unable to really power on or power off the
backlight.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/acpi/ibm_acpi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 7c1b418..63d7a85 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -86,6 +86,7 @@
 
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/fb.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -1701,7 +1702,10 @@ static int brightness_write(char *buf)
 
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
1.5.0.3

