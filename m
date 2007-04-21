From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 18/20] ACPI: thinkpad-acpi: clean up CMOS
	commands subdriver
Date: Sat, 21 Apr 2007 11:08:42 -0300
Message-ID: <11771645292352-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Some ThinkPad CMOS commands subdriver cleanups, and also rename/promote
cmos_eval to a ACPI helper function, as it is used by many other
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   39 ++++++++++++++++++++-------------------
 drivers/misc/thinkpad_acpi.h |    4 +++-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 19c14bb..8829d3c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -273,6 +273,17 @@ static int _sta(acpi_handle handle)
 	return status;
 }
 
+static int issue_thinkpad_cmos_command(int cmos_cmd)
+{
+	if (!cmos_handle)
+		return -ENXIO;
+
+	if (!acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd))
+		return -EIO;
+
+	return 0;
+}
+
 /*************************************************************************
  * ACPI device model
  */
@@ -1550,14 +1561,6 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	return (cmos_handle)? 0 : 1;
 }
 
-static int cmos_eval(int cmos_cmd)
-{
-	if (cmos_handle)
-		return acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd);
-	else
-		return 1;
-}
-
 static int cmos_read(char *p)
 {
 	int len = 0;
@@ -1577,10 +1580,7 @@ static int cmos_read(char *p)
 static int cmos_write(char *buf)
 {
 	char *cmd;
-	int cmos_cmd;
-
-	if (!cmos_handle)
-		return -EINVAL;
+	int cmos_cmd, res;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (sscanf(cmd, "%u", &cmos_cmd) == 1 &&
@@ -1589,8 +1589,9 @@ static int cmos_write(char *buf)
 		} else
 			return -EINVAL;
 
-		if (!cmos_eval(cmos_cmd))
-			return -EIO;
+		res = issue_thinkpad_cmos_command(cmos_cmd);
+		if (res)
+			return res;
 	}
 
 	return 0;
@@ -2093,7 +2094,7 @@ static int brightness_set(int value)
 	cmos_cmd = value > current_value ? TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 	for (i = current_value; i != value; i += inc) {
-		if (!cmos_eval(cmos_cmd))
+		if (issue_thinkpad_cmos_command(cmos_cmd))
 			return -EIO;
 		if (!acpi_ec_write(brightness_offset, i + inc))
 			return -EIO;
@@ -2210,16 +2211,16 @@ static int volume_write(char *buf)
 			cmos_cmd = new_level > level ? TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
-			if (mute && (!cmos_eval(cmos_cmd) ||
+			if (mute && (issue_thinkpad_cmos_command(cmos_cmd) ||
 				     !acpi_ec_write(volume_offset, level)))
 				return -EIO;
 
 			for (i = level; i != new_level; i += inc)
-				if (!cmos_eval(cmos_cmd) ||
+				if (issue_thinkpad_cmos_command(cmos_cmd) ||
 				    !acpi_ec_write(volume_offset, i + inc))
 					return -EIO;
 
-			if (mute && (!cmos_eval(TP_CMOS_VOLUME_MUTE) ||
+			if (mute && (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
 				     !acpi_ec_write(volume_offset,
 						    new_level + mute)))
 				return -EIO;
@@ -2228,7 +2229,7 @@ static int volume_write(char *buf)
 		if (new_mute != mute) {	/* level doesn't change */
 			cmos_cmd = new_mute ? TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
-			if (!cmos_eval(cmos_cmd) ||
+			if (issue_thinkpad_cmos_command(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
 				return -EIO;
 		}
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 3a8718a..fb0abb0 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -116,6 +116,9 @@ static void drv_acpi_handle_init(char *name,
 	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
+/* ThinkPad ACPI helpers */
+static int issue_thinkpad_cmos_command(int cmos_cmd);
+
 /* procfs support */
 static struct proc_dir_entry *proc_dir;
 
@@ -275,7 +278,6 @@ static int brightness_write(char *buf);
  * CMOS subdriver
  */
 
-static int cmos_eval(int cmos_cmd);
 static int cmos_read(char *p);
 static int cmos_write(char *buf);
 
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
