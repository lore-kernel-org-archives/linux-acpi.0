From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 7/7] ACPI: thinkpad-acpi: fix brightness_set error paths
Date: Tue, 30 Oct 2007 17:46:25 -0200
Message-ID: <1193773585-17202-8-git-send-email-hmh@hmh.eng.br>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56792 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756648AbXJ3Tqe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:46:34 -0400
In-Reply-To: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The code calling brightness_set() can't handle EINTR/ERESTARTSYS well, nor
is it checking brightness_set() return status properly.

Fix it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 306daa5..8c94307 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3278,6 +3278,8 @@ static void brightness_exit(void)
 
 static int brightness_update_status(struct backlight_device *bd)
 {
+	/* it is the backlight class's job (caller) to handle
+	 * EINTR and other errors properly */
 	return brightness_set(
 		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
 		 bd->props.power == FB_BLANK_UNBLANK) ?
@@ -3318,6 +3320,7 @@ static int brightness_get(struct backlight_device *bd)
 	return level;
 }
 
+/* May return EINTR which can always be mapped to ERESTARTSYS */
 static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i, res;
@@ -3381,29 +3384,34 @@ static int brightness_read(char *p)
 static int brightness_write(char *buf)
 {
 	int level;
-	int new_level;
+	int rc;
 	char *cmd;
 	int max_level = (tp_features.bright_16levels) ? 15 : 7;
 
-	while ((cmd = next_cmd(&buf))) {
-		if ((level = brightness_get(NULL)) < 0)
-			return level;
+	level = brightness_get(NULL);
+	if (level < 0)
+		return level;
 
+	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "up") == 0) {
-			new_level = level == (max_level)?
-						max_level : level + 1;
+			if (level < max_level)
+				level++;
 		} else if (strlencmp(cmd, "down") == 0) {
-			new_level = level == 0? 0 : level - 1;
-		} else if (sscanf(cmd, "level %d", &new_level) == 1 &&
-			   new_level >= 0 && new_level <= max_level) {
-			/* new_level set */
+			if (level > 0)
+				level--;
+		} else if (sscanf(cmd, "level %d", &level) == 1 &&
+			   level >= 0 && level <= max_level) {
+			/* new level set */
 		} else
 			return -EINVAL;
-
-		brightness_set(new_level);
 	}
 
-	return 0;
+	/*
+	 * Now we know what the final level should be, so we try to set it.
+	 * Doing it this way makes the syscall restartable in case of EINTR
+	 */
+	rc = brightness_set(level);
+	return (rc == -EINTR)? ERESTARTSYS : rc;
 }
 
 static struct ibm_struct brightness_driver_data = {
-- 
1.5.3.4

