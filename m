From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 09/12] thinkpad-acpi: enhanced debugging messages for rfkill subdrivers
Date: Sat,  4 Apr 2009 01:25:50 -0300
Message-ID: <1238819153-16004-10-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59692 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751609AbZDDE0F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:05 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Enhance debugging messages for all rfkill subdrivers in thinkpad-acpi.

Also, log a warning if the deprecated sysfs attributes are in use.
These attributes are going to be removed sometime in 2010.

There is an user-visible side-effect: we now coalesce attempts to
enable/disable bluetooth or WWAN in the procfs interface, instead of
hammering the firmware with multiple requests.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +
 drivers/platform/x86/thinkpad_acpi.c    |  117 +++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index bce1d95..7daca05 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1494,6 +1494,8 @@ to enable more than one output class, just add their values.
 				accessing some functions of the driver
 	0x0001			Initialization and probing
 	0x0002			Removal
+	0x0004			RF Transmitter control (RFKILL)
+				(bluetooth, WWAN, UWB...)
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d03b76a..92fff8d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -189,6 +189,7 @@ enum {
 #define TPACPI_DBG_DISCLOSETASK	0x8000
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
+#define TPACPI_DBG_RFKILL	0x0004
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -1016,10 +1017,13 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
 		/* try to set the initial state as the default for the rfkill
 		 * type, since we ask the firmware to preserve it across S5 in
 		 * NVRAM */
-		rfkill_set_default(rfktype,
+		if (rfkill_set_default(rfktype,
 				(initial_state == RFKILL_STATE_UNBLOCKED) ?
 					RFKILL_STATE_UNBLOCKED :
-					RFKILL_STATE_SOFT_BLOCKED);
+					RFKILL_STATE_SOFT_BLOCKED) == -EPERM)
+			vdbg_printk(TPACPI_DBG_RFKILL,
+				    "Default state for %s cannot be changed\n",
+				    name);
 	}
 
 	*rfk = rfkill_allocate(&tpacpi_pdev->dev, rfktype);
@@ -3018,13 +3022,17 @@ enum {
 	TP_ACPI_BLTH_SAVE_STATE		= 0x05, /* Save state for S4/S5 */
 };
 
+#define TPACPI_RFK_BLUETOOTH_SW_NAME	"tpacpi_bluetooth_sw"
+
 static struct rfkill *tpacpi_bluetooth_rfkill;
 
 static void bluetooth_suspend(pm_message_t state)
 {
 	/* Try to make sure radio will resume powered off */
-	acpi_evalf(NULL, NULL, "\\BLTH", "vd",
-		   TP_ACPI_BLTH_PWR_OFF_ON_RESUME);
+	if (!acpi_evalf(NULL, NULL, "\\BLTH", "vd",
+		   TP_ACPI_BLTH_PWR_OFF_ON_RESUME))
+		vdbg_printk(TPACPI_DBG_RFKILL,
+			"bluetooth power down on resume request failed\n");
 }
 
 static int bluetooth_get_radiosw(void)
@@ -3062,6 +3070,10 @@ static void bluetooth_update_rfk(void)
 	if (status < 0)
 		return;
 	rfkill_force_state(tpacpi_bluetooth_rfkill, status);
+
+	vdbg_printk(TPACPI_DBG_RFKILL,
+		"forced rfkill state to %d\n",
+		status);
 }
 
 static int bluetooth_set_radiosw(int radio_on, int update_rfk)
@@ -3077,6 +3089,9 @@ static int bluetooth_set_radiosw(int radio_on, int update_rfk)
 	    && radio_on)
 		return -EPERM;
 
+	vdbg_printk(TPACPI_DBG_RFKILL,
+		"will %s bluetooth\n", radio_on ? "enable" : "disable");
+
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_bluetoothemul) {
 		tpacpi_bluetooth_emulstate = !!radio_on;
@@ -3129,6 +3144,8 @@ static ssize_t bluetooth_enable_store(struct device *dev,
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
+	tpacpi_disclose_usertask("bluetooth_enable", "set to %ld\n", t);
+
 	res = bluetooth_set_radiosw(t, 1);
 
 	return (res) ? res : count;
@@ -3162,6 +3179,8 @@ static int tpacpi_bluetooth_rfk_get(void *data, enum rfkill_state *state)
 
 static int tpacpi_bluetooth_rfk_set(void *data, enum rfkill_state state)
 {
+	dbg_printk(TPACPI_DBG_RFKILL,
+		   "request to change radio state to %d\n", state);
 	return bluetooth_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
 }
 
@@ -3172,6 +3191,9 @@ static void bluetooth_shutdown(void)
 			TP_ACPI_BLTH_SAVE_STATE))
 		printk(TPACPI_NOTICE
 			"failed to save bluetooth state to NVRAM\n");
+	else
+		vdbg_printk(TPACPI_DBG_RFKILL,
+			"bluestooth state saved to NVRAM\n");
 }
 
 static void bluetooth_exit(void)
@@ -3190,7 +3212,8 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	int res;
 	int status = 0;
 
-	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+			"initializing bluetooth subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(hkey);
 
@@ -3199,7 +3222,8 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	tp_features.bluetooth = hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GBDC", "qd");
 
-	vdbg_printk(TPACPI_DBG_INIT, "bluetooth is %s, status 0x%02x\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+		"bluetooth is %s, status 0x%02x\n",
 		str_supported(tp_features.bluetooth),
 		status);
 
@@ -3214,7 +3238,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
 		/* no bluetooth hardware present in system */
 		tp_features.bluetooth = 0;
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 			   "bluetooth hardware not installed\n");
 	}
 
@@ -3229,7 +3253,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	res = tpacpi_new_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID,
 				&tpacpi_bluetooth_rfkill,
 				RFKILL_TYPE_BLUETOOTH,
-				"tpacpi_bluetooth_sw",
+				TPACPI_RFK_BLUETOOTH_SW_NAME,
 				true,
 				tpacpi_bluetooth_rfk_set,
 				tpacpi_bluetooth_rfk_get);
@@ -3262,19 +3286,27 @@ static int bluetooth_read(char *p)
 static int bluetooth_write(char *buf)
 {
 	char *cmd;
+	int state = -1;
 
 	if (!tp_features.bluetooth)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			bluetooth_set_radiosw(1, 1);
+			state = 1;
 		} else if (strlencmp(cmd, "disable") == 0) {
-			bluetooth_set_radiosw(0, 1);
+			state = 0;
 		} else
 			return -EINVAL;
 	}
 
+	if (state != -1) {
+		tpacpi_disclose_usertask("procfs bluetooth",
+			"attempt to %s\n",
+			state ? "enable" : "disable");
+		bluetooth_set_radiosw(state, 1);
+	}
+
 	return 0;
 }
 
@@ -3299,13 +3331,17 @@ enum {
 						   off / last state */
 };
 
+#define TPACPI_RFK_WWAN_SW_NAME		"tpacpi_wwan_sw"
+
 static struct rfkill *tpacpi_wan_rfkill;
 
 static void wan_suspend(pm_message_t state)
 {
 	/* Try to make sure radio will resume powered off */
-	acpi_evalf(NULL, NULL, "\\WGSV", "qvd",
-		   TP_ACPI_WGSV_PWR_OFF_ON_RESUME);
+	if (!acpi_evalf(NULL, NULL, "\\WGSV", "qvd",
+		   TP_ACPI_WGSV_PWR_OFF_ON_RESUME))
+		vdbg_printk(TPACPI_DBG_RFKILL,
+			"WWAN power down on resume request failed\n");
 }
 
 static int wan_get_radiosw(void)
@@ -3343,6 +3379,10 @@ static void wan_update_rfk(void)
 	if (status < 0)
 		return;
 	rfkill_force_state(tpacpi_wan_rfkill, status);
+
+	vdbg_printk(TPACPI_DBG_RFKILL,
+		"forced rfkill state to %d\n",
+		status);
 }
 
 static int wan_set_radiosw(int radio_on, int update_rfk)
@@ -3358,6 +3398,9 @@ static int wan_set_radiosw(int radio_on, int update_rfk)
 	    && radio_on)
 		return -EPERM;
 
+	vdbg_printk(TPACPI_DBG_RFKILL,
+		"will %s WWAN\n", radio_on ? "enable" : "disable");
+
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_wwanemul) {
 		tpacpi_wwan_emulstate = !!radio_on;
@@ -3410,6 +3453,8 @@ static ssize_t wan_enable_store(struct device *dev,
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
+	tpacpi_disclose_usertask("wwan_enable", "set to %ld\n", t);
+
 	res = wan_set_radiosw(t, 1);
 
 	return (res) ? res : count;
@@ -3443,6 +3488,8 @@ static int tpacpi_wan_rfk_get(void *data, enum rfkill_state *state)
 
 static int tpacpi_wan_rfk_set(void *data, enum rfkill_state state)
 {
+	dbg_printk(TPACPI_DBG_RFKILL,
+		   "request to change radio state to %d\n", state);
 	return wan_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
 }
 
@@ -3453,6 +3500,9 @@ static void wan_shutdown(void)
 			TP_ACPI_WGSV_SAVE_STATE))
 		printk(TPACPI_NOTICE
 			"failed to save WWAN state to NVRAM\n");
+	else
+		vdbg_printk(TPACPI_DBG_RFKILL,
+			"WWAN state saved to NVRAM\n");
 }
 
 static void wan_exit(void)
@@ -3471,14 +3521,16 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 	int res;
 	int status = 0;
 
-	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+			"initializing wan subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(hkey);
 
 	tp_features.wan = hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GWAN", "qd");
 
-	vdbg_printk(TPACPI_DBG_INIT, "wan is %s, status 0x%02x\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+		"wan is %s, status 0x%02x\n",
 		str_supported(tp_features.wan),
 		status);
 
@@ -3493,7 +3545,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
 		/* no wan hardware present in system */
 		tp_features.wan = 0;
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 			   "wan hardware not installed\n");
 	}
 
@@ -3508,7 +3560,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 	res = tpacpi_new_rfkill(TPACPI_RFK_WWAN_SW_ID,
 				&tpacpi_wan_rfkill,
 				RFKILL_TYPE_WWAN,
-				"tpacpi_wwan_sw",
+				TPACPI_RFK_WWAN_SW_NAME,
 				true,
 				tpacpi_wan_rfk_set,
 				tpacpi_wan_rfk_get);
@@ -3526,6 +3578,8 @@ static int wan_read(char *p)
 	int len = 0;
 	int status = wan_get_radiosw();
 
+	tpacpi_disclose_usertask("procfs wan", "read");
+
 	if (!tp_features.wan)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else {
@@ -3541,19 +3595,27 @@ static int wan_read(char *p)
 static int wan_write(char *buf)
 {
 	char *cmd;
+	int state = -1;
 
 	if (!tp_features.wan)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			wan_set_radiosw(1, 1);
+			state = 1;
 		} else if (strlencmp(cmd, "disable") == 0) {
-			wan_set_radiosw(0, 1);
+			state = 0;
 		} else
 			return -EINVAL;
 	}
 
+	if (state != -1) {
+		tpacpi_disclose_usertask("procfs wan",
+			"attempt to %s\n",
+			state ? "enable" : "disable");
+		wan_set_radiosw(state, 1);
+	}
+
 	return 0;
 }
 
@@ -3576,6 +3638,8 @@ enum {
 	TP_ACPI_UWB_RADIOSSW	= 0x02,	/* UWB radio enabled */
 };
 
+#define TPACPI_RFK_UWB_SW_NAME	"tpacpi_uwb_sw"
+
 static struct rfkill *tpacpi_uwb_rfkill;
 
 static int uwb_get_radiosw(void)
@@ -3613,6 +3677,10 @@ static void uwb_update_rfk(void)
 	if (status < 0)
 		return;
 	rfkill_force_state(tpacpi_uwb_rfkill, status);
+
+	vdbg_printk(TPACPI_DBG_RFKILL,
+		"forced rfkill state to %d\n",
+		status);
 }
 
 static int uwb_set_radiosw(int radio_on, int update_rfk)
@@ -3628,6 +3696,9 @@ static int uwb_set_radiosw(int radio_on, int update_rfk)
 	    && radio_on)
 		return -EPERM;
 
+	vdbg_printk(TPACPI_DBG_RFKILL,
+			"will %s UWB\n", radio_on ? "enable" : "disable");
+
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_uwbemul) {
 		tpacpi_uwb_emulstate = !!radio_on;
@@ -3662,6 +3733,8 @@ static int tpacpi_uwb_rfk_get(void *data, enum rfkill_state *state)
 
 static int tpacpi_uwb_rfk_set(void *data, enum rfkill_state state)
 {
+	dbg_printk(TPACPI_DBG_RFKILL,
+		   "request to change radio state to %d\n", state);
 	return uwb_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
 }
 
@@ -3676,14 +3749,16 @@ static int __init uwb_init(struct ibm_init_struct *iibm)
 	int res;
 	int status = 0;
 
-	vdbg_printk(TPACPI_DBG_INIT, "initializing uwb subdriver\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+			"initializing uwb subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(hkey);
 
 	tp_features.uwb = hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GUWB", "qd");
 
-	vdbg_printk(TPACPI_DBG_INIT, "uwb is %s, status 0x%02x\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+		"uwb is %s, status 0x%02x\n",
 		str_supported(tp_features.uwb),
 		status);
 
@@ -3708,7 +3783,7 @@ static int __init uwb_init(struct ibm_init_struct *iibm)
 	res = tpacpi_new_rfkill(TPACPI_RFK_UWB_SW_ID,
 				&tpacpi_uwb_rfkill,
 				RFKILL_TYPE_UWB,
-				"tpacpi_uwb_sw",
+				TPACPI_RFK_UWB_SW_NAME,
 				false,
 				tpacpi_uwb_rfk_set,
 				tpacpi_uwb_rfk_get);
-- 
1.6.2.1

