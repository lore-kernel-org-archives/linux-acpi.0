From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/23] ACPI: thinkpad-acpi: debug facility to emulate the rf
 switches
Date: Fri, 16 Jan 2009 15:24:52 -0500
Message-ID: <a73f30916ee524437253739eacc682f6fb0f3ea8.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38904 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759497AbZAPUZb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:31 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK001U3ZE3EFS0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:22 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This code is required to keep the thinkpad-acpi maintainer sane, and
it is disabled by default.

Add a debug facility to simulate an rfkill hardware rocker switch, a
bluetooth rfkill soft-switch, a WWAN rfkill soft-switch on thinkpads.

The simulated switches obviously do not kill any radios in hardware or
firmware (unlike the real one).  They also don't issue deprecated proc
events.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/Kconfig         |   11 ++
 drivers/platform/x86/thinkpad_acpi.c |  190 ++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e65448e..431772b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -192,6 +192,17 @@ config THINKPAD_ACPI
 
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
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ee3fa00..a086ce8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -288,6 +288,16 @@ struct tpacpi_led_classdev {
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
@@ -1006,6 +1016,94 @@ static DRIVER_ATTR(version, S_IRUGO,
 
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
@@ -1022,6 +1120,15 @@ static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
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
 
@@ -1031,6 +1138,12 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 
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
@@ -1216,6 +1329,12 @@ static struct attribute_set *hotkey_dev_attributes;
 
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
@@ -2222,6 +2341,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
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
@@ -2656,6 +2782,12 @@ static int bluetooth_get_radiosw(void)
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
 
@@ -2689,6 +2821,15 @@ static int bluetooth_set_radiosw(int radio_on, int update_rfk)
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
@@ -2792,6 +2933,13 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
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
@@ -2890,6 +3038,12 @@ static int wan_get_radiosw(void)
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
 
@@ -2923,6 +3077,15 @@ static int wan_set_radiosw(int radio_on, int update_rfk)
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
@@ -3024,6 +3187,13 @@ static int __init wan_init(struct ibm_init_struct *iibm)
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
@@ -6701,6 +6871,26 @@ TPACPI_PARAM(brightness);
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
1.5.6.6

