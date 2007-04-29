From: Len Brown <len.brown@intel.com>
Subject: [PATCH 057/105] ACPI: thinkpad-acpi: use bitfields for module flags
Date: Sun, 29 Apr 2007 00:50:57 -0400
Message-ID: <11778223581484-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602AbXD2Ewl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:41 -0400
In-Reply-To: <11778223571390-git-send-email-len.brown@intel.com>
Message-Id: <d8fd94d9f08237ffda7e44e6825b057bf20a90e3.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use a bitfield to hold boolean module-wide flags, to conserve some memory.
It is easy and it is clean, so we do it just for the heck of it even if it
saves very little space.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |  147 +++++++++++++++++++-----------------------
 drivers/misc/thinkpad_acpi.h |   28 +++++----
 2 files changed, 83 insertions(+), 92 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a5efd06..e2a1b63 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -501,8 +501,6 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
  * Hotkey subdriver
  */
 
-static int hotkey_supported;
-static int hotkey_mask_supported;
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
@@ -513,30 +511,30 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	IBM_HANDLE_INIT(hkey);
 
 	/* hotkey not supported on 570 */
-	hotkey_supported = hkey_handle != NULL;
+	tp_features.hotkey = hkey_handle != NULL;
 
 	vdbg_printk(TPACPI_DBG_INIT, "hotkeys are %s\n",
-		str_supported(hotkey_supported));
+		str_supported(tp_features.hotkey));
 
-	if (hotkey_supported) {
+	if (tp_features.hotkey) {
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 		   A30, R30, R31, T20-22, X20-21, X22-24 */
-		hotkey_mask_supported =
-		    acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
+		tp_features.hotkey_mask =
+			acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
 
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
-			str_supported(hotkey_mask_supported));
+			str_supported(tp_features.hotkey_mask));
 
 		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
 			return -ENODEV;
 	}
 
-	return (hotkey_supported)? 0 : 1;
+	return (tp_features.hotkey)? 0 : 1;
 }
 
 static void hotkey_exit(void)
 {
-	if (hotkey_supported) {
+	if (tp_features.hotkey) {
 		dbg_printk(TPACPI_DBG_EXIT, "restoring original hotkey mask\n");
 		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
 	}
@@ -559,7 +557,7 @@ static int hotkey_get(int *status, int *mask)
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
 		return 0;
 
-	if (hotkey_mask_supported)
+	if (tp_features.hotkey_mask)
 		if (!acpi_evalf(hkey_handle, mask, "DHKN", "d"))
 			return 0;
 
@@ -573,7 +571,7 @@ static int hotkey_set(int status, int mask)
 	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
 		return 0;
 
-	if (hotkey_mask_supported)
+	if (tp_features.hotkey_mask)
 		for (i = 0; i < 32; i++) {
 			int bit = ((1 << i) & mask) != 0;
 			if (!acpi_evalf(hkey_handle,
@@ -589,7 +587,7 @@ static int hotkey_read(char *p)
 	int status, mask;
 	int len = 0;
 
-	if (!hotkey_supported) {
+	if (!tp_features.hotkey) {
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 		return len;
 	}
@@ -598,7 +596,7 @@ static int hotkey_read(char *p)
 		return -EIO;
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
-	if (hotkey_mask_supported) {
+	if (tp_features.hotkey_mask) {
 		len += sprintf(p + len, "mask:\t\t0x%04x\n", mask);
 		len += sprintf(p + len,
 			       "commands:\tenable, disable, reset, <mask>\n");
@@ -616,7 +614,7 @@ static int hotkey_write(char *buf)
 	char *cmd;
 	int do_cmd = 0;
 
-	if (!hotkey_supported)
+	if (!tp_features.hotkey)
 		return -ENODEV;
 
 	if (!hotkey_get(&status, &mask))
@@ -660,8 +658,6 @@ static struct ibm_struct hotkey_driver_data = {
  * Bluetooth subdriver
  */
 
-static int bluetooth_supported;
-
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
@@ -670,20 +666,20 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
-	bluetooth_supported = hkey_handle &&
+	tp_features.bluetooth = hkey_handle &&
 	    acpi_evalf(hkey_handle, NULL, "GBDC", "qv");
 
 	vdbg_printk(TPACPI_DBG_INIT, "bluetooth is %s\n",
-		str_supported(bluetooth_supported));
+		str_supported(tp_features.bluetooth));
 
-	return (bluetooth_supported)? 0 : 1;
+	return (tp_features.bluetooth)? 0 : 1;
 }
 
 static int bluetooth_status(void)
 {
 	int status;
 
-	if (!bluetooth_supported ||
+	if (!tp_features.bluetooth ||
 	    !acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		status = 0;
 
@@ -695,7 +691,7 @@ static int bluetooth_read(char *p)
 	int len = 0;
 	int status = bluetooth_status();
 
-	if (!bluetooth_supported)
+	if (!tp_features.bluetooth)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else if (!(status & 1))
 		len += sprintf(p + len, "status:\t\tnot installed\n");
@@ -713,7 +709,7 @@ static int bluetooth_write(char *buf)
 	char *cmd;
 	int do_cmd = 0;
 
-	if (!bluetooth_supported)
+	if (!tp_features.bluetooth)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
@@ -742,28 +738,27 @@ static struct ibm_struct bluetooth_driver_data = {
  * Wan subdriver
  */
 
-static int wan_supported;
-
 static int __init wan_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
 
 	IBM_HANDLE_INIT(hkey);
 
-	wan_supported = hkey_handle &&
-	    acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
+	tp_features.wan = hkey_handle &&
+			  acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
 
 	vdbg_printk(TPACPI_DBG_INIT, "wan is %s\n",
-		str_supported(wan_supported));
+		str_supported(tp_features.wan));
 
-	return (wan_supported)? 0 : 1;
+	return (tp_features.wan)? 0 : 1;
 }
 
 static int wan_status(void)
 {
 	int status;
 
-	if (!wan_supported || !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+	if (!tp_features.wan ||
+	    !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		status = 0;
 
 	return status;
@@ -774,7 +769,7 @@ static int wan_read(char *p)
 	int len = 0;
 	int status = wan_status();
 
-	if (!wan_supported)
+	if (!tp_features.wan)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else if (!(status & 1))
 		len += sprintf(p + len, "status:\t\tnot installed\n");
@@ -792,7 +787,7 @@ static int wan_write(char *buf)
 	char *cmd;
 	int do_cmd = 0;
 
-	if (!wan_supported)
+	if (!tp_features.wan)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
@@ -1051,9 +1046,6 @@ static struct ibm_struct video_driver_data = {
  * Light (thinklight) subdriver
  */
 
-static int light_supported;
-static int light_status_supported;
-
 IBM_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
 IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
@@ -1066,18 +1058,18 @@ static int __init light_init(struct ibm_init_struct *iibm)
 	IBM_HANDLE_INIT(cmos);
 
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
-	light_supported = (cmos_handle || lght_handle) && !ledb_handle;
+	tp_features.light = (cmos_handle || lght_handle) && !ledb_handle;
 
-	if (light_supported)
+	if (tp_features.light)
 		/* light status not supported on
 		   570, 600e/x, 770e, 770x, G4x, R30, R31, R32, X20 */
-		light_status_supported = acpi_evalf(ec_handle, NULL,
-						    "KBLT", "qv");
+		tp_features.light_status =
+			acpi_evalf(ec_handle, NULL, "KBLT", "qv");
 
 	vdbg_printk(TPACPI_DBG_INIT, "light is %s\n",
-		str_supported(light_supported));
+		str_supported(tp_features.light));
 
-	return (light_supported)? 0 : 1;
+	return (tp_features.light)? 0 : 1;
 }
 
 static int light_read(char *p)
@@ -1085,9 +1077,9 @@ static int light_read(char *p)
 	int len = 0;
 	int status = 0;
 
-	if (!light_supported) {
+	if (!tp_features.light) {
 		len += sprintf(p + len, "status:\t\tnot supported\n");
-	} else if (!light_status_supported) {
+	} else if (!tp_features.light_status) {
 		len += sprintf(p + len, "status:\t\tunknown\n");
 		len += sprintf(p + len, "commands:\ton, off\n");
 	} else {
@@ -1106,7 +1098,7 @@ static int light_write(char *buf)
 	char *cmd;
 	int success;
 
-	if (!light_supported)
+	if (!tp_features.light)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
@@ -1251,11 +1243,6 @@ static struct ibm_struct dock_driver_data[2] = {
  */
 
 #ifdef CONFIG_THINKPAD_ACPI_BAY
-static int bay_status_supported;
-static int bay_status2_supported;
-static int bay_eject_supported;
-static int bay_eject2_supported;
-
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
@@ -1282,25 +1269,25 @@ static int __init bay_init(struct ibm_init_struct *iibm)
 	if (bay2_handle)
 		IBM_HANDLE_INIT(bay2_ej);
 
-	bay_status_supported = bay_handle &&
-	    acpi_evalf(bay_handle, NULL, "_STA", "qv");
-	bay_status2_supported = bay2_handle &&
-	    acpi_evalf(bay2_handle, NULL, "_STA", "qv");
+	tp_features.bay_status = bay_handle &&
+		acpi_evalf(bay_handle, NULL, "_STA", "qv");
+	tp_features.bay_status2 = bay2_handle &&
+		acpi_evalf(bay2_handle, NULL, "_STA", "qv");
 
-	bay_eject_supported = bay_handle && bay_ej_handle &&
-	    (strlencmp(bay_ej_path, "_EJ0") == 0 || experimental);
-	bay_eject2_supported = bay2_handle && bay2_ej_handle &&
-	    (strlencmp(bay2_ej_path, "_EJ0") == 0 || experimental);
+	tp_features.bay_eject = bay_handle && bay_ej_handle &&
+		(strlencmp(bay_ej_path, "_EJ0") == 0 || experimental);
+	tp_features.bay_eject2 = bay2_handle && bay2_ej_handle &&
+		(strlencmp(bay2_ej_path, "_EJ0") == 0 || experimental);
 
 	vdbg_printk(TPACPI_DBG_INIT,
 		"bay 1: status %s, eject %s; bay 2: status %s, eject %s\n",
-		str_supported(bay_status_supported),
-		str_supported(bay_eject_supported),
-		str_supported(bay_status2_supported),
-		str_supported(bay_eject2_supported));
+		str_supported(tp_features.bay_status),
+		str_supported(tp_features.bay_eject),
+		str_supported(tp_features.bay_status2),
+		str_supported(tp_features.bay_eject2));
 
-	return (bay_status_supported || bay_eject_supported ||
-		bay_status2_supported || bay_eject2_supported)? 0 : 1;
+	return (tp_features.bay_status || tp_features.bay_eject ||
+		tp_features.bay_status2 || tp_features.bay_eject2)? 0 : 1;
 }
 
 static void bay_notify(struct ibm_struct *ibm, u32 event)
@@ -1317,15 +1304,16 @@ static int bay_read(char *p)
 	int occupied2 = bay_occupied(bay2);
 	int eject, eject2;
 
-	len += sprintf(p + len, "status:\t\t%s\n", bay_status_supported ?
-		       (occupied ? "occupied" : "unoccupied") :
-		       "not supported");
-	if (bay_status2_supported)
+	len += sprintf(p + len, "status:\t\t%s\n",
+		tp_features.bay_status ?
+			(occupied ? "occupied" : "unoccupied") :
+				"not supported");
+	if (tp_features.bay_status2)
 		len += sprintf(p + len, "status2:\t%s\n", occupied2 ?
 			       "occupied" : "unoccupied");
 
-	eject = bay_eject_supported && occupied;
-	eject2 = bay_eject2_supported && occupied2;
+	eject = tp_features.bay_eject && occupied;
+	eject2 = tp_features.bay_eject2 && occupied2;
 
 	if (eject && eject2)
 		len += sprintf(p + len, "commands:\teject, eject2\n");
@@ -1341,14 +1329,14 @@ static int bay_write(char *buf)
 {
 	char *cmd;
 
-	if (!bay_eject_supported && !bay_eject2_supported)
+	if (!tp_features.bay_eject && !tp_features.bay_eject2)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
-		if (bay_eject_supported && strlencmp(cmd, "eject") == 0) {
+		if (tp_features.bay_eject && strlencmp(cmd, "eject") == 0) {
 			if (!acpi_evalf(bay_ej_handle, NULL, NULL, "vd", 1))
 				return -EIO;
-		} else if (bay_eject2_supported &&
+		} else if (tp_features.bay_eject2 &&
 			   strlencmp(cmd, "eject2") == 0) {
 			if (!acpi_evalf(bay2_ej_handle, NULL, NULL, "vd", 1))
 				return -EIO;
@@ -2188,7 +2176,6 @@ static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
 
-static int fan_control_status_known;
 static u8 fan_control_initial_status;
 
 static void fan_watchdog_fire(struct work_struct *ignored);
@@ -2210,8 +2197,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	fan_status_access_mode = TPACPI_FAN_NONE;
 	fan_control_access_mode = TPACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
-	fan_control_status_known = 1;
 	fan_watchdog_maxinterval = 0;
+	tp_features.fan_ctrl_status_undef = 0;
 
 	IBM_HANDLE_INIT(fans);
 	IBM_HANDLE_INIT(gfan);
@@ -2248,7 +2235,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 				       "fan_init: initial fan status is "
 				       "unknown, assuming it is in auto "
 				       "mode\n");
-				fan_control_status_known = 0;
+				tp_features.fan_ctrl_status_undef = 1;
 			}
 		} else {
 			printk(IBM_ERR
@@ -2411,7 +2398,7 @@ static int fan_set_level(int level)
 		if (!acpi_ec_write(fan_status_offset, level))
 			return -EIO;
 		else
-			fan_control_status_known = 1;
+			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
 	default:
@@ -2438,7 +2425,7 @@ static int fan_set_enable(void)
 		if (!acpi_ec_write(fan_status_offset, s))
 			return -EIO;
 		else
-			fan_control_status_known = 1;
+			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
@@ -2469,7 +2456,7 @@ static int fan_set_disable(void)
 		if (!acpi_ec_write(fan_status_offset, 0x00))
 			return -EIO;
 		else
-			fan_control_status_known = 1;
+			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
@@ -2524,9 +2511,9 @@ static int fan_read(char *p)
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
 
-		if (unlikely(!fan_control_status_known)) {
+		if (unlikely(tp_features.fan_ctrl_status_undef)) {
 			if (status != fan_control_initial_status)
-				fan_control_status_known = 1;
+				tp_features.fan_ctrl_status_undef = 0;
 			else
 				/* Return most likely status. In fact, it
 				 * might be the only possible status */
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 8b72061..4d3ab40 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -173,6 +173,22 @@ struct ibm_init_struct {
 	struct ibm_struct *data;
 };
 
+static struct {
+#ifdef CONFIG_THINKPAD_ACPI_BAY
+	u16 bay_status:1;
+	u16 bay_eject:1;
+	u16 bay_status2:1;
+	u16 bay_eject2:1;
+#endif
+	u16 bluetooth:1;
+	u16 hotkey:1;
+	u16 hotkey_mask:1;
+	u16 light:1;
+	u16 light_status:1;
+	u16 wan:1;
+	u16 fan_ctrl_status_undef:1;
+} tp_features;
+
 static struct list_head tpacpi_all_drivers;
 
 static struct ibm_init_struct ibms_init[];
@@ -193,9 +209,6 @@ static int thinkpad_acpi_driver_read(char *p);
  */
 
 #ifdef CONFIG_THINKPAD_ACPI_BAY
-static int bay_status_supported, bay_eject_supported;
-static int bay_status2_supported, bay_eject2_supported;
-
 static acpi_handle bay_handle, bay_ej_handle;
 static acpi_handle bay2_handle, bay2_ej_handle;
 
@@ -220,8 +233,6 @@ static int beep_write(char *buf);
  * Bluetooth subdriver
  */
 
-static int bluetooth_supported;
-
 static int bluetooth_init(struct ibm_init_struct *iibm);
 static int bluetooth_status(void);
 static int bluetooth_read(char *p);
@@ -311,7 +322,6 @@ enum fan_control_commands {
 static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
-static int fan_control_status_known;
 static u8 fan_control_initial_status;
 static int fan_watchdog_maxinterval;
 
@@ -340,8 +350,6 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
  * Hotkey subdriver
  */
 
-static int hotkey_supported;
-static int hotkey_mask_supported;
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
@@ -382,8 +390,6 @@ static int led_write(char *buf);
  * Light (thinklight) subdriver
  */
 
-static int light_supported;
-static int light_status_supported;
 static acpi_handle lght_handle, ledb_handle;
 
 static int light_init(struct ibm_init_struct *iibm);
@@ -453,8 +459,6 @@ static int volume_write(char *buf);
  * Wan subdriver
  */
 
-static int wan_supported;
-
 static int wan_init(struct ibm_init_struct *iibm);
 static int wan_status(void);
 static int wan_read(char *p);
-- 
1.5.2.rc0.34.gda94
