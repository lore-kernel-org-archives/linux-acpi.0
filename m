From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 16/20] ACPI: thinkpad-acpi: cleanup
	bluetooth and wan for sysfs conversion
Date: Sat, 21 Apr 2007 11:08:40 -0300
Message-ID: <1177164529354-git-send-email-hmh@hmh.eng.br>
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

Prepare bluetooth and wan driver code to be more easily hooked into sysfs
helpers, by separating the procfs logic from the device attribute handling.

These changes also remove the entries from procfs on notebooks without the
bluetooth/wan hardware installed.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  130 +++++++++++++++++++++++++++++-------------
 drivers/misc/thinkpad_acpi.h |   20 ++++++-
 2 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 344eb55..a77368f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -681,6 +681,8 @@ static struct ibm_struct hotkey_driver_data = {
 
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
+	int status = 0;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(hkey);
@@ -688,36 +690,65 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
 	tp_features.bluetooth = hkey_handle &&
-	    acpi_evalf(hkey_handle, NULL, "GBDC", "qv");
+	    acpi_evalf(hkey_handle, &status, "GBDC", "qd");
 
-	vdbg_printk(TPACPI_DBG_INIT, "bluetooth is %s\n",
-		str_supported(tp_features.bluetooth));
+	vdbg_printk(TPACPI_DBG_INIT, "bluetooth is %s, status 0x%02x\n",
+		str_supported(tp_features.bluetooth),
+		status);
+
+	if (tp_features.bluetooth &&
+	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
+		/* no bluetooth hardware present in system */
+		tp_features.bluetooth = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "bluetooth hardware not installed\n");
+	}
 
 	return (tp_features.bluetooth)? 0 : 1;
 }
 
-static int bluetooth_status(void)
+static int bluetooth_get_radiosw(void)
 {
 	int status;
 
-	if (!tp_features.bluetooth ||
-	    !acpi_evalf(hkey_handle, &status, "GBDC", "d"))
-		status = 0;
+	if (!tp_features.bluetooth)
+		return -ENODEV;
 
-	return status;
+	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
+		return -EIO;
+
+	return ((status & TP_ACPI_BLUETOOTH_RADIOSSW) != 0);
+}
+
+static int bluetooth_set_radiosw(int radio_on)
+{
+	int status;
+
+	if (!tp_features.bluetooth)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
+		return -EIO;
+	if (radio_on)
+		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
+	else
+		status &= ~TP_ACPI_BLUETOOTH_RADIOSSW;
+	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
+		return -EIO;
+
+	return 0;
 }
 
 static int bluetooth_read(char *p)
 {
 	int len = 0;
-	int status = bluetooth_status();
+	int status = bluetooth_get_radiosw();
 
 	if (!tp_features.bluetooth)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
-	else if (!(status & 1))
-		len += sprintf(p + len, "status:\t\tnot installed\n");
 	else {
-		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 1));
+		len += sprintf(p + len, "status:\t\t%s\n",
+				(status)? "enabled" : "disabled");
 		len += sprintf(p + len, "commands:\tenable, disable\n");
 	}
 
@@ -726,26 +757,20 @@ static int bluetooth_read(char *p)
 
 static int bluetooth_write(char *buf)
 {
-	int status = bluetooth_status();
 	char *cmd;
-	int do_cmd = 0;
 
 	if (!tp_features.bluetooth)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			status |= 2;
+			bluetooth_set_radiosw(1);
 		} else if (strlencmp(cmd, "disable") == 0) {
-			status &= ~2;
+			bluetooth_set_radiosw(0);
 		} else
 			return -EINVAL;
-		do_cmd = 1;
 	}
 
-	if (do_cmd && !acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
-		return -EIO;
-
 	return 0;
 }
 
@@ -761,41 +786,72 @@ static struct ibm_struct bluetooth_driver_data = {
 
 static int __init wan_init(struct ibm_init_struct *iibm)
 {
+	int status = 0;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(hkey);
 
 	tp_features.wan = hkey_handle &&
-			  acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
+	    acpi_evalf(hkey_handle, &status, "GWAN", "qd");
 
-	vdbg_printk(TPACPI_DBG_INIT, "wan is %s\n",
-		str_supported(tp_features.wan));
+	vdbg_printk(TPACPI_DBG_INIT, "wan is %s, status 0x%02x\n",
+		str_supported(tp_features.wan),
+		status);
+
+	if (tp_features.wan &&
+	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
+		/* no wan hardware present in system */
+		tp_features.wan = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "wan hardware not installed\n");
+	}
 
 	return (tp_features.wan)? 0 : 1;
 }
 
-static int wan_status(void)
+static int wan_get_radiosw(void)
 {
 	int status;
 
-	if (!tp_features.wan ||
-	    !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
-		status = 0;
+	if (!tp_features.wan)
+		return -ENODEV;
 
-	return status;
+	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		return -EIO;
+
+	return ((status & TP_ACPI_WANCARD_RADIOSSW) != 0);
+}
+
+static int wan_set_radiosw(int radio_on)
+{
+	int status;
+
+	if (!tp_features.wan)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		return -EIO;
+	if (radio_on)
+		status |= TP_ACPI_WANCARD_RADIOSSW;
+	else
+		status &= ~TP_ACPI_WANCARD_RADIOSSW;
+	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
+		return -EIO;
+
+	return 0;
 }
 
 static int wan_read(char *p)
 {
 	int len = 0;
-	int status = wan_status();
+	int status = wan_get_radiosw();
 
 	if (!tp_features.wan)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
-	else if (!(status & 1))
-		len += sprintf(p + len, "status:\t\tnot installed\n");
 	else {
-		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 1));
+		len += sprintf(p + len, "status:\t\t%s\n",
+				(status)? "enabled" : "disabled");
 		len += sprintf(p + len, "commands:\tenable, disable\n");
 	}
 
@@ -804,26 +860,20 @@ static int wan_read(char *p)
 
 static int wan_write(char *buf)
 {
-	int status = wan_status();
 	char *cmd;
-	int do_cmd = 0;
 
 	if (!tp_features.wan)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			status |= 2;
+			wan_set_radiosw(1);
 		} else if (strlencmp(cmd, "disable") == 0) {
-			status &= ~2;
+			wan_set_radiosw(0);
 		} else
 			return -EINVAL;
-		do_cmd = 1;
 	}
 
-	if (do_cmd && !acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
-		return -EIO;
-
 	return 0;
 }
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 1b4cd16..e06bad5 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -241,8 +241,16 @@ static int beep_write(char *buf);
  * Bluetooth subdriver
  */
 
+enum {
+	/* ACPI GBDC/SBDC bits */
+	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
+	TP_ACPI_BLUETOOTH_RADIOSSW	= 0x02,	/* Bluetooth radio enabled */
+	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
+};
+
 static int bluetooth_init(struct ibm_init_struct *iibm);
-static int bluetooth_status(void);
+static int bluetooth_get_radiosw(void);
+static int bluetooth_set_radiosw(int radio_on);
 static int bluetooth_read(char *p);
 static int bluetooth_write(char *buf);
 
@@ -467,8 +475,16 @@ static int volume_write(char *buf);
  * Wan subdriver
  */
 
+enum {
+	/* ACPI GWAN/SWAN bits */
+	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
+	TP_ACPI_WANCARD_RADIOSSW	= 0x02,	/* Wan radio enabled */
+	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
+};
+
 static int wan_init(struct ibm_init_struct *iibm);
-static int wan_status(void);
+static int wan_get_radiosw(void);
+static int wan_set_radiosw(int radio_on);
 static int wan_read(char *p);
 static int wan_write(char *buf);
 
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
