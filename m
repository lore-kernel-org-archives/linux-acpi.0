From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 06/10] ACPI: thinkpad-acpi: fix
	brightness_set error paths
Date: Sat, 13 Oct 2007 17:22:55 -0300
Message-ID: <1192306979-26886-7-git-send-email-hmh@hmh.eng.br>
References: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192306979-26886-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The code calling brightness_set() can't handle EINTR/ERESTARTSYS well, nor
is it checking brightness_set() return status properly.

Fix it.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 793f654..3b78d51 100644
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
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
