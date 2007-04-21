From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 15/20] ACPI: thinkpad-acpi: clean up hotkey
	subdriver
Date: Sat, 21 Apr 2007 11:08:39 -0300
Message-ID: <11771645283975-git-send-email-hmh@hmh.eng.br>
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

Cleanup hotkey subdriver code.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   46 ++++++++++++++++++++++++++---------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 809ec84..344eb55 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -511,6 +511,8 @@ static int hotkey_orig_mask;
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
+	int res;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(hkey);
@@ -530,8 +532,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
 			str_supported(tp_features.hotkey_mask));
 
-		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
-			return -ENODEV;
+		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
+		if (res)
+			return res;
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -539,9 +542,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 static void hotkey_exit(void)
 {
+	int res;
+
 	if (tp_features.hotkey) {
 		dbg_printk(TPACPI_DBG_EXIT, "restoring original hotkey mask\n");
-		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+		res = hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+		if (res)
+			printk(IBM_ERR "failed to restore hotkey to BIOS defaults\n");
 	}
 }
 
@@ -560,13 +567,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 static int hotkey_get(int *status, int *mask)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
-		return 0;
+		return -EIO;
 
 	if (tp_features.hotkey_mask)
 		if (!acpi_evalf(hkey_handle, mask, "DHKN", "d"))
-			return 0;
+			return -EIO;
 
-	return 1;
+	return 0;
 }
 
 static int hotkey_set(int status, int mask)
@@ -574,22 +581,22 @@ static int hotkey_set(int status, int mask)
 	int i;
 
 	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
-		return 0;
+		return -EIO;
 
 	if (tp_features.hotkey_mask)
 		for (i = 0; i < 32; i++) {
 			int bit = ((1 << i) & mask) != 0;
 			if (!acpi_evalf(hkey_handle,
 					NULL, "MHKM", "vdd", i + 1, bit))
-				return 0;
+				return -EIO;
 		}
 
-	return 1;
+	return 0;
 }
 
 static int hotkey_read(char *p)
 {
-	int status, mask;
+	int res, status, mask;
 	int len = 0;
 
 	if (!tp_features.hotkey) {
@@ -597,8 +604,9 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
-	if (!hotkey_get(&status, &mask))
-		return -EIO;
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
 	if (tp_features.hotkey_mask) {
@@ -615,15 +623,16 @@ static int hotkey_read(char *p)
 
 static int hotkey_write(char *buf)
 {
-	int status, mask;
+	int res, status, mask;
 	char *cmd;
 	int do_cmd = 0;
 
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
-	if (!hotkey_get(&status, &mask))
-		return -EIO;
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
@@ -642,8 +651,11 @@ static int hotkey_write(char *buf)
 		do_cmd = 1;
 	}
 
-	if (do_cmd && !hotkey_set(status, mask))
-		return -EIO;
+	if (do_cmd) {
+		res = hotkey_set(status, mask);
+		if (res)
+			return res;
+	}
 
 	return 0;
 }
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
