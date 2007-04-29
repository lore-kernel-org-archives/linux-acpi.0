From: Len Brown <len.brown@intel.com>
Subject: [PATCH 061/105] ACPI: thinkpad-acpi: cleanup bluetooth and wan for sysfs conversion
Date: Sun, 29 Apr 2007 00:51:01 -0400
Message-ID: <117782236226-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756142AbXD2Ewn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:43 -0400
In-Reply-To: <11778223612093-git-send-email-len.brown@intel.com>
Message-Id: <d6fdd1e91a8a4cd852dc1d945165e3a69ac9e257.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Prepare bluetooth and wan driver code to be more easily hooked into sysfs
helpers, by separating the procfs logic from the device attribute handling.

These changes also remove the entries from procfs on notebooks without the
bluetooth/wan hardware installed.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
