From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 03/11] ACPI: thinkpad-acpi: debug facility to emulate the rf switches
Date: Sat, 22 Nov 2008 09:48:45 -0200
Message-ID: <1227354533-19788-4-git-send-email-hmh@hmh.eng.br>
References: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39926 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757405AbYKVLtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 06:49:00 -0500
In-Reply-To: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This code is required to keep the thinkpad-acpi maintainer sane, and
it is disabled by default.

Add a debug facility to simulate an rfkill hardware rocker switch, a
bluetooth rfkill soft-switch, a WWAN rfkill soft-switch on thinkpads.

The simulated switches obviously do not kill any radios in hardware or
firmware (unlike the real one).  They also don't issue deprecated proc
events.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/Kconfig         |   11 +++
 drivers/misc/thinkpad_acpi.c |  190 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fee7304..2f517fc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -329,6 +329,17 @@ config THINKPAD_ACPI
 
 	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
 
+config THINKPAD_ACPI_DEBUGFACILITIES
+	bool "Maintainer debug facilities"
+	depends on THINKPAD_ACPI
+	default n
+	---help---
+	  Enables extra stuff in the thinkpad-acpi which is completely useless
+	  for normal use.  Read the driver source to find out what it does.
+
+	  Say N here, unless you were told by a kernel maintainer to do
+	  otherwise.
+
 config THINKPAD_ACPI_DEBUG
 	bool "Verbose debug mode"
 	depends on THINKPAD_ACPI
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 948e867..6c048b8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -289,6 +289,16 @@ struct tpacpi_led_classdev {
 	unsigned int led;
 };
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+static int dbg_wlswemul;
+static int tpacpi_wlsw_emulstate;
+static int dbg_bluetoothemul;
+static int tpacpi_bluetooth_emulstate;
+static int dbg_wwanemul;
+static int tpacpi_wwan_emulstate;
+#endif
+
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -1007,6 +1017,94 @@ static DRIVER_ATTR(version, S_IRUGO,
 
 /* --------------------------------------------------------------------- */
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+
+static void tpacpi_send_radiosw_update(void);
+
+/* wlsw_emulstate ------------------------------------------------------ */
+static ssize_t tpacpi_driver_wlsw_emulstate_show(struct device_driver *drv,
+						char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wlsw_emulstate);
+}
+
+static ssize_t tpacpi_driver_wlsw_emulstate_store(struct device_driver *drv,
+						const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	if (tpacpi_wlsw_emulstate != t) {
+		tpacpi_wlsw_emulstate = !!t;
+		tpacpi_send_radiosw_update();
+	} else
+		tpacpi_wlsw_emulstate = !!t;
+
+	return count;
+}
+
+static DRIVER_ATTR(wlsw_emulstate, S_IWUSR | S_IRUGO,
+		tpacpi_driver_wlsw_emulstate_show,
+		tpacpi_driver_wlsw_emulstate_store);
+
+/* bluetooth_emulstate ------------------------------------------------- */
+static ssize_t tpacpi_driver_bluetooth_emulstate_show(
+					struct device_driver *drv,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_bluetooth_emulstate);
+}
+
+static ssize_t tpacpi_driver_bluetooth_emulstate_store(
+					struct device_driver *drv,
+					const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	tpacpi_bluetooth_emulstate = !!t;
+
+	return count;
+}
+
+static DRIVER_ATTR(bluetooth_emulstate, S_IWUSR | S_IRUGO,
+		tpacpi_driver_bluetooth_emulstate_show,
+		tpacpi_driver_bluetooth_emulstate_store);
+
+/* wwan_emulstate ------------------------------------------------- */
+static ssize_t tpacpi_driver_wwan_emulstate_show(
+					struct device_driver *drv,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!tpacpi_wwan_emulstate);
+}
+
+static ssize_t tpacpi_driver_wwan_emulstate_store(
+					struct device_driver *drv,
+					const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	tpacpi_wwan_emulstate = !!t;
+
+	return count;
+}
+
+static DRIVER_ATTR(wwan_emulstate, S_IWUSR | S_IRUGO,
+		tpacpi_driver_wwan_emulstate_show,
+		tpacpi_driver_wwan_emulstate_store);
+
+#endif
+
+/* --------------------------------------------------------------------- */
+
 static struct driver_attribute *tpacpi_driver_attributes[] = {
 	&driver_attr_debug_level, &driver_attr_version,
 	&driver_attr_interface_version,
@@ -1023,6 +1121,15 @@ static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
 		i++;
 	}
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (!res && dbg_wlswemul)
+		res = driver_create_file(drv, &driver_attr_wlsw_emulstate);
+	if (!res && dbg_bluetoothemul)
+		res = driver_create_file(drv, &driver_attr_bluetooth_emulstate);
+	if (!res && dbg_wwanemul)
+		res = driver_create_file(drv, &driver_attr_wwan_emulstate);
+#endif
+
 	return res;
 }
 
@@ -1032,6 +1139,12 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 
 	for (i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
 		driver_remove_file(drv, tpacpi_driver_attributes[i]);
+
+#ifdef THINKPAD_ACPI_DEBUGFACILITIES
+	driver_remove_file(drv, &driver_attr_wlsw_emulstate);
+	driver_remove_file(drv, &driver_attr_bluetooth_emulstate);
+	driver_remove_file(drv, &driver_attr_wwan_emulstate);
+#endif
 }
 
 /****************************************************************************
@@ -1217,6 +1330,12 @@ static struct attribute_set *hotkey_dev_attributes;
 
 static int hotkey_get_wlsw(int *status)
 {
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_wlswemul) {
+		*status = !!tpacpi_wlsw_emulstate;
+		return 0;
+	}
+#endif
 	if (!acpi_evalf(hkey_handle, status, "WLSW", "d"))
 		return -EIO;
 	return 0;
@@ -2223,6 +2342,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		    hotkey_source_mask, hotkey_poll_freq);
 #endif
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_wlswemul) {
+		tp_features.hotkey_wlsw = 1;
+		printk(TPACPI_INFO
+			"radio switch emulation enabled\n");
+	} else
+#endif
 	/* Not all thinkpads have a hardware radio switch */
 	if (acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
 		tp_features.hotkey_wlsw = 1;
@@ -2657,6 +2783,12 @@ static int bluetooth_get_radiosw(void)
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
 		return RFKILL_STATE_HARD_BLOCKED;
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_bluetoothemul)
+		return (tpacpi_bluetooth_emulstate) ?
+			RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
+#endif
+
 	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		return -EIO;
 
@@ -2690,6 +2822,15 @@ static int bluetooth_set_radiosw(int radio_on, int update_rfk)
 	    && radio_on)
 		return -EPERM;
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_bluetoothemul) {
+		tpacpi_bluetooth_emulstate = !!radio_on;
+		if (update_rfk)
+			bluetooth_update_rfk();
+		return 0;
+	}
+#endif
+
 	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		return -EIO;
 	if (radio_on)
@@ -2793,6 +2934,13 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.bluetooth),
 		status);
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_bluetoothemul) {
+		tp_features.bluetooth = 1;
+		printk(TPACPI_INFO
+			"bluetooth switch emulation enabled\n");
+	} else
+#endif
 	if (tp_features.bluetooth &&
 	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
 		/* no bluetooth hardware present in system */
@@ -2891,6 +3039,12 @@ static int wan_get_radiosw(void)
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
 		return RFKILL_STATE_HARD_BLOCKED;
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_wwanemul)
+		return (tpacpi_wwan_emulstate) ?
+			RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
+#endif
+
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 
@@ -2924,6 +3078,15 @@ static int wan_set_radiosw(int radio_on, int update_rfk)
 	    && radio_on)
 		return -EPERM;
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_wwanemul) {
+		tpacpi_wwan_emulstate = !!radio_on;
+		if (update_rfk)
+			wan_update_rfk();
+		return 0;
+	}
+#endif
+
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 	if (radio_on)
@@ -3025,6 +3188,13 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.wan),
 		status);
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	if (dbg_wwanemul) {
+		tp_features.wan = 1;
+		printk(TPACPI_INFO
+			"wwan switch emulation enabled\n");
+	} else
+#endif
 	if (tp_features.wan &&
 	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
 		/* no wan hardware present in system */
@@ -6702,6 +6872,26 @@ TPACPI_PARAM(brightness);
 TPACPI_PARAM(volume);
 TPACPI_PARAM(fan);
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+module_param(dbg_wlswemul, uint, 0);
+MODULE_PARM_DESC(dbg_wlswemul, "Enables WLSW emulation");
+module_param_named(wlsw_state, tpacpi_wlsw_emulstate, bool, 0);
+MODULE_PARM_DESC(wlsw_state,
+		 "Initial state of the emulated WLSW switch");
+
+module_param(dbg_bluetoothemul, uint, 0);
+MODULE_PARM_DESC(dbg_bluetoothemul, "Enables bluetooth switch emulation");
+module_param_named(bluetooth_state, tpacpi_bluetooth_emulstate, bool, 0);
+MODULE_PARM_DESC(bluetooth_state,
+		 "Initial state of the emulated bluetooth switch");
+
+module_param(dbg_wwanemul, uint, 0);
+MODULE_PARM_DESC(dbg_wwanemul, "Enables WWAN switch emulation");
+module_param_named(wwan_state, tpacpi_wwan_emulstate, bool, 0);
+MODULE_PARM_DESC(wwan_state,
+		 "Initial state of the emulated WWAN switch");
+#endif
+
 static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;
-- 
1.5.6.5

