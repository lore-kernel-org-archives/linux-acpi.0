From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 06/13] ACPI: thinkpad-acpi: add UWB radio support
Date: Sun, 11 Jan 2009 03:01:03 -0200
Message-ID: <1231650070-21722-7-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50605 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751108AbZAKFBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Ivo van Doorn <IvDoorn@gmail.com>

Add rfkill support for USB UWB radio devices on very recent ThinkPad
laptop models.

The new subdriver is moslty a trimmed down copy of the wwan subdriver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ivo van Doorn <IvDoorn@gmail.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   18 +++
 drivers/platform/x86/thinkpad_acpi.c    |  206 ++++++++++++++++++++++++++++++-
 2 files changed, 223 insertions(+), 1 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index ddc371e..91c0001 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1413,6 +1413,24 @@ Sysfs notes:
 	rfkill controller switch "tpacpi_wwan_sw": refer to
 	Documentation/rfkill.txt for details.
 
+EXPERIMENTAL: UWB
+-----------------
+
+This feature is marked EXPERIMENTAL because it has not been extensively
+tested and validated in various ThinkPad models yet.  The feature may not
+work as expected. USE WITH CAUTION! To use this feature, you need to supply
+the experimental=1 parameter when loading the module.
+
+sysfs rfkill class: switch "tpacpi_uwb_sw"
+
+This feature exports an rfkill controller for the UWB device, if one is
+present and enabled in the BIOS.
+
+Sysfs notes:
+
+	rfkill controller switch "tpacpi_uwb_sw": refer to
+	Documentation/rfkill.txt for details.
+
 Multiple Commands, Module Parameters
 ------------------------------------
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 27d709b..c1d4041 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -169,6 +169,7 @@ enum {
 enum {
 	TPACPI_RFK_BLUETOOTH_SW_ID = 0,
 	TPACPI_RFK_WWAN_SW_ID,
+	TPACPI_RFK_UWB_SW_ID,
 };
 
 /* Debugging */
@@ -261,6 +262,7 @@ static struct {
 	u32 bright_16levels:1;
 	u32 bright_acpimode:1;
 	u32 wan:1;
+	u32 uwb:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
@@ -317,6 +319,8 @@ static int dbg_bluetoothemul;
 static int tpacpi_bluetooth_emulstate;
 static int dbg_wwanemul;
 static int tpacpi_wwan_emulstate;
+static int dbg_uwbemul;
+static int tpacpi_uwb_emulstate;
 #endif
 
 
@@ -967,6 +971,7 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
 			struct rfkill **rfk,
 			const enum rfkill_type rfktype,
 			const char *name,
+			const bool set_default,
 			int (*toggle_radio)(void *, enum rfkill_state),
 			int (*get_state)(void *, enum rfkill_state *))
 {
@@ -978,7 +983,7 @@ static int __init tpacpi_new_rfkill(const unsigned int id,
 		printk(TPACPI_ERR
 			"failed to read initial state for %s, error %d; "
 			"will turn radio off\n", name, res);
-	} else {
+	} else if (set_default) {
 		/* try to set the initial state as the default for the rfkill
 		 * type, since we ask the firmware to preserve it across S5 in
 		 * NVRAM */
@@ -1148,6 +1153,31 @@ static DRIVER_ATTR(wwan_emulstate, S_IWUSR | S_IRUGO,
 		tpacpi_driver_wwan_emulstate_show,
 		tpacpi_driver_wwan_emulstate_store);
 
+/* uwb_emulstate ------------------------------------------------- */
+static ssize_t tpacpi_driver_uwb_emulstate_show(
+					struct device_driver *drv,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_uwb_emulstate);
+}
+
+static ssize_t tpacpi_driver_uwb_emulstate_store(
+					struct device_driver *drv,
+					const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	tpacpi_uwb_emulstate = !!t;
+
+	return count;
+}
+
+static DRIVER_ATTR(uwb_emulstate, S_IWUSR | S_IRUGO,
+		tpacpi_driver_uwb_emulstate_show,
+		tpacpi_driver_uwb_emulstate_store);
 #endif
 
 /* --------------------------------------------------------------------- */
@@ -1175,6 +1205,8 @@ static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
 		res = driver_create_file(drv, &driver_attr_bluetooth_emulstate);
 	if (!res && dbg_wwanemul)
 		res = driver_create_file(drv, &driver_attr_wwan_emulstate);
+	if (!res && dbg_uwbemul)
+		res = driver_create_file(drv, &driver_attr_uwb_emulstate);
 #endif
 
 	return res;
@@ -1191,6 +1223,7 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 	driver_remove_file(drv, &driver_attr_wlsw_emulstate);
 	driver_remove_file(drv, &driver_attr_bluetooth_emulstate);
 	driver_remove_file(drv, &driver_attr_wwan_emulstate);
+	driver_remove_file(drv, &driver_attr_uwb_emulstate);
 #endif
 }
 
@@ -2125,6 +2158,7 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 
 static void bluetooth_update_rfk(void);
 static void wan_update_rfk(void);
+static void uwb_update_rfk(void);
 static void tpacpi_send_radiosw_update(void)
 {
 	int wlsw;
@@ -2134,6 +2168,8 @@ static void tpacpi_send_radiosw_update(void)
 		bluetooth_update_rfk();
 	if (tp_features.wan)
 		wan_update_rfk();
+	if (tp_features.uwb)
+		uwb_update_rfk();
 
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
 		mutex_lock(&tpacpi_inputdev_send_mutex);
@@ -3035,6 +3071,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 				&tpacpi_bluetooth_rfkill,
 				RFKILL_TYPE_BLUETOOTH,
 				"tpacpi_bluetooth_sw",
+				true,
 				tpacpi_bluetooth_rfk_set,
 				tpacpi_bluetooth_rfk_get);
 	if (res) {
@@ -3309,6 +3346,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 				&tpacpi_wan_rfkill,
 				RFKILL_TYPE_WWAN,
 				"tpacpi_wwan_sw",
+				true,
 				tpacpi_wan_rfk_set,
 				tpacpi_wan_rfk_get);
 	if (res) {
@@ -3366,6 +3404,162 @@ static struct ibm_struct wan_driver_data = {
 };
 
 /*************************************************************************
+ * UWB subdriver
+ */
+
+enum {
+	/* ACPI GUWB/SUWB bits */
+	TP_ACPI_UWB_HWPRESENT	= 0x01,	/* UWB hw available */
+	TP_ACPI_UWB_RADIOSSW	= 0x02,	/* UWB radio enabled */
+};
+
+static struct rfkill *tpacpi_uwb_rfkill;
+
+static int uwb_get_radiosw(void)
+{
+	int status;
+
+	if (!tp_features.uwb)
+		return -ENODEV;
+
+	/* WLSW overrides UWB in firmware/hardware, reflect that */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
+		return RFKILL_STATE_HARD_BLOCKED;
+
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_uwbemul)
+		return (tpacpi_uwb_emulstate) ?
+			RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
+#endif
+
+	if (!acpi_evalf(hkey_handle, &status, "GUWB", "d"))
+		return -EIO;
+
+	return ((status & TP_ACPI_UWB_RADIOSSW) != 0) ?
+		RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
+}
+
+static void uwb_update_rfk(void)
+{
+	int status;
+
+	if (!tpacpi_uwb_rfkill)
+		return;
+
+	status = uwb_get_radiosw();
+	if (status < 0)
+		return;
+	rfkill_force_state(tpacpi_uwb_rfkill, status);
+}
+
+static int uwb_set_radiosw(int radio_on, int update_rfk)
+{
+	int status;
+
+	if (!tp_features.uwb)
+		return -ENODEV;
+
+	/* WLSW overrides UWB in firmware/hardware, but there is no
+	 * reason to risk weird behaviour. */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status
+	    && radio_on)
+		return -EPERM;
+
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_uwbemul) {
+		tpacpi_uwb_emulstate = !!radio_on;
+		if (update_rfk)
+			uwb_update_rfk();
+		return 0;
+	}
+#endif
+
+	status = (radio_on) ? TP_ACPI_UWB_RADIOSSW : 0;
+	if (!acpi_evalf(hkey_handle, NULL, "SUWB", "vd", status))
+		return -EIO;
+
+	if (update_rfk)
+		uwb_update_rfk();
+
+	return 0;
+}
+
+/* --------------------------------------------------------------------- */
+
+static int tpacpi_uwb_rfk_get(void *data, enum rfkill_state *state)
+{
+	int uwbs = uwb_get_radiosw();
+
+	if (uwbs < 0)
+		return uwbs;
+
+	*state = uwbs;
+	return 0;
+}
+
+static int tpacpi_uwb_rfk_set(void *data, enum rfkill_state state)
+{
+	return uwb_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
+}
+
+static void uwb_exit(void)
+{
+	if (tpacpi_uwb_rfkill)
+		rfkill_unregister(tpacpi_uwb_rfkill);
+}
+
+static int __init uwb_init(struct ibm_init_struct *iibm)
+{
+	int res;
+	int status = 0;
+
+	vdbg_printk(TPACPI_DBG_INIT, "initializing uwb subdriver\n");
+
+	TPACPI_ACPIHANDLE_INIT(hkey);
+
+	tp_features.uwb = hkey_handle &&
+	    acpi_evalf(hkey_handle, &status, "GUWB", "qd");
+
+	vdbg_printk(TPACPI_DBG_INIT, "uwb is %s, status 0x%02x\n",
+		str_supported(tp_features.uwb),
+		status);
+
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_uwbemul) {
+		tp_features.uwb = 1;
+		printk(TPACPI_INFO
+			"uwb switch emulation enabled\n");
+	} else
+#endif
+	if (tp_features.uwb &&
+	    !(status & TP_ACPI_UWB_HWPRESENT)) {
+		/* no uwb hardware present in system */
+		tp_features.uwb = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "uwb hardware not installed\n");
+	}
+
+	if (!tp_features.uwb)
+		return 1;
+
+	res = tpacpi_new_rfkill(TPACPI_RFK_UWB_SW_ID,
+				&tpacpi_uwb_rfkill,
+				RFKILL_TYPE_UWB,
+				"tpacpi_uwb_sw",
+				false,
+				tpacpi_uwb_rfk_set,
+				tpacpi_uwb_rfk_get);
+
+	return res;
+}
+
+static struct ibm_struct uwb_driver_data = {
+	.name = "uwb",
+	.exit = uwb_exit,
+	.flags.experimental = 1,
+};
+
+/*************************************************************************
  * Video subdriver
  */
 
@@ -6830,6 +7024,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = wan_init,
 		.data = &wan_driver_data,
 	},
+	{
+		.init = uwb_init,
+		.data = &uwb_driver_data,
+	},
 #ifdef CONFIG_THINKPAD_ACPI_VIDEO
 	{
 		.init = video_init,
@@ -6986,6 +7184,12 @@ MODULE_PARM_DESC(dbg_wwanemul, "Enables WWAN switch emulation");
 module_param_named(wwan_state, tpacpi_wwan_emulstate, bool, 0);
 MODULE_PARM_DESC(wwan_state,
 		 "Initial state of the emulated WWAN switch");
+
+module_param(dbg_uwbemul, uint, 0);
+MODULE_PARM_DESC(dbg_uwbemul, "Enables UWB switch emulation");
+module_param_named(uwb_state, tpacpi_uwb_emulstate, bool, 0);
+MODULE_PARM_DESC(uwb_state,
+		 "Initial state of the emulated UWB switch");
 #endif
 
 static void thinkpad_acpi_module_exit(void)
-- 
1.5.6.5

