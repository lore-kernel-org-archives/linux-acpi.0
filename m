From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] ACPI: thinkpad-acpi: revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED option
Date: Tue,  4 Sep 2007 11:13:15 -0300
Message-ID: <11889151974187-git-send-email-hmh@hmh.eng.br>
References: <1188915196931-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35057 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761AbXIDON0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Sep 2007 10:13:26 -0400
In-Reply-To: <1188915196931-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Richard Hughes <hughsient@gmail.com>

Revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED Kconfig option because
it would create a legacy we don't want to support.

CONFIG_THINKPAD_ACPI_INPUT_ENABLED was added to try to fix an issue that is
now moot with the addition of the netlink ACPI event report interface to
the ACPI core.

Now that ACPI core can send events over netlink, we can use a different
strategy to keep backwards compatibility with older userspace, without the
need for the CONFIG_THINKPAD_ACPI_INPUT_ENABLED games.  And it arrived
before CONFIG_THINKPAD_ACPI_INPUT_ENABLED made it to a stable mainline
kernel, even, which is Good.

This patch is in sync with some changes to thinkpad-acpi backports, that
will keep things sane for userspace across different combinations of kernel
versions, thinkpad-acpi backports (or the lack thereof), and userspace
capabilities:

Unless a module parameter is used, thinkpad-acpi will now behave in such a
way that it will work well (by default) with userspace that still uses only
the old ACPI procfs event interface and doesn't care for thinkpad-acpi
input devices.

It will also always work well with userspace that has been updated to use
both the thinkpad-acpi input devices, and ACPI core netlink event
interface, regardless of any module parameter.

The module parameter was added to allow thinkpad-acpi to work with
userspace that has been partially updated to use thinkpad-acpi input
devices, but not the new ACPI core netlink event interface.  To use this
mode of hot key reporting, one has to specify the hotkey_report_mode=2
module parameter.

The thinkpad-acpi driver exports the value of hotkey_report_mode through
sysfs, as well.  thinkpad-acpi backports to older kernels, that do not
support the new ACPI core netlink interface, have code to allow userspace
to switch hotkey_report_mode at runtime through sysfs.  This capability
will not be provided in mainline thinkpad-acpi as it is not needed there.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Michael S. Tsirkin <mst@dev.mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: Richard Hughes <hughsient@gmail.com>
---
 Documentation/thinkpad-acpi.txt |   92 ++++++++++++++++++++-----
 drivers/misc/Kconfig            |   20 ------
 drivers/misc/thinkpad_acpi.c    |  142 +++++++++++++++++++++++---------------
 drivers/misc/thinkpad_acpi.h    |    1 +
 4 files changed, 162 insertions(+), 93 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index eb2f598..ca89711 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -161,20 +161,22 @@ system.  Enabling the hotkey functionality of thinkpad-acpi signals the
 firmware that such a driver is present, and modifies how the ThinkPad
 firmware will behave in many situations.
 
+The driver enables the hot key feature automatically when loaded.  The
+feature can later be disabled and enabled back at runtime.  The driver
+will also restore the hot key feature to its previous state and mask
+when it is unloaded.
+
 When the hotkey feature is enabled and the hot key mask is set (see
-below), the various hot keys either generate ACPI events in the
-following format:
+below), the driver will report HKEY events in the following format:
 
 	ibm/hotkey HKEY 00000080 0000xxxx
 
-or events over the input layer.  The input layer support accepts the
-standard IOCTLs to remap the keycodes assigned to each hotkey.
+Some of these events refer to hot key presses, but not all.
 
-When the input device is open, the driver will suppress any ACPI hot key
-events that get translated into a meaningful input layer event, in order
-to avoid sending duplicate events to userspace.  Hot keys that are
-mapped to KEY_RESERVED in the keymap are not translated, and will always
-generate an ACPI ibm/hotkey HKEY event, and no input layer events.
+The driver will generate events over the input layer for hot keys and
+radio switches, and over the ACPI netlink layer for other events.  The
+input layer support accepts the standard IOCTLs to remap the keycodes
+assigned to each hot key.
 
 The hot key bit mask allows some control over which hot keys generate
 events.  If a key is "masked" (bit set to 0 in the mask), the firmware
@@ -256,6 +258,20 @@ sysfs notes:
 		disabled" postition, and 1 if the switch is in the
 		"radios enabled" position.
 
+	hotkey_report_mode:
+		Returns the state of the procfs ACPI event report mode
+		filter for hot keys.  If it is set to 1 (the default),
+		all hot key presses are reported both through the input
+		layer and also as ACPI events through procfs (but not
+		through netlink).  If it is set to 2, hot key presses
+		are reported only through the input layer.
+
+		This attribute is read-only in kernels 2.6.23 or later,
+		and read-write on earlier kernels.
+
+		May return -EPERM (write access locked out by module
+		parameter) or -EACCES (read-only).
+
 input layer notes:
 
 A Hot key is mapped to a single input layer EV_KEY event, possibly
@@ -393,21 +409,63 @@ unknown by the driver if the ThinkPad firmware triggered these events on
 hot key press or release, but the firmware will do it for either one, not
 both.
 
-If a key is mapped to KEY_RESERVED, it generates no input events at all,
-and it may generate a legacy thinkpad-acpi ACPI hotkey event.
-
+If a key is mapped to KEY_RESERVED, it generates no input events at all.
 If a key is mapped to KEY_UNKNOWN, it generates an input event that
-includes an scan code, and it may also generate a legacy thinkpad-acpi
-ACPI hotkey event.
-
-If a key is mapped to anything else, it will only generate legacy
-thinkpad-acpi ACPI hotkey events if nobody has opened the input device.
+includes an scan code.  If a key is mapped to anything else, it will
+generate input device EV_KEY events.
 
 Non hot-key ACPI HKEY event map:
 0x5001		Lid closed
 0x5002		Lid opened
 0x7000		Radio Switch may have changed state
 
+The above events are not propagated by the driver, except for legacy
+compatibility purposes when hotkey_report_mode is set to 1.
+
+Compatibility notes:
+
+ibm-acpi and thinkpad-acpi 0.15 (mainline kernels before 2.6.23) never
+supported the input layer, and sent events over the procfs ACPI event
+interface.
+
+To avoid sending duplicate events over the input layer and the ACPI
+event interface, thinkpad-acpi 0.16 implements a module parameter
+(hotkey_report_mode), and also a sysfs device attribute with the same
+name.
+
+Make no mistake here: userspace is expected to switch to using the input
+layer interface of thinkpad-acpi, together with the ACPI netlink event
+interface in kernels 2.6.23 and later, or with the ACPI procfs event
+interface in kernels 2.6.22 and earlier.
+
+If no hotkey_report_mode module parameter is specified (or it is set to
+zero), the driver defaults to mode 1 (see below), and on kernels 2.6.22
+and earlier, also allows one to change the hotkey_report_mode through
+sysfs.  In kernels 2.6.23 and later, where the netlink ACPI event
+interface is available, hotkey_report_mode cannot be changed through
+sysfs (it is read-only).
+
+If the hotkey_report_mode module parameter is set to 1 or 2, it cannot
+be changed later through sysfs (any writes will return -EPERM to signal
+that hotkey_report_mode was locked.  On 2.6.23 and later, where
+hotkey_report_mode cannot be changed at all, writes will return -EACES).
+
+hotkey_report_mode set to 1 makes the driver export through the procfs
+ACPI event interface all hot key presses (which are *also* sent to the
+input layer).  This is a legacy compatibility behaviour, and it is also
+the default mode of operation for the driver.
+
+hotkey_report_mode set to 2 makes the driver filter out the hot key
+presses from the procfs ACPI event interface, so these events will only
+be sent through the input layer.  Userspace that has been updated to use
+the thinkpad-acpi input layer interface should set hotkey_report_mode to
+2.
+
+Hot key press events are never sent to the ACPI netlink event interface.
+Really up-to-date userspace under kernel 2.6.23 and later is to use the
+netlink interface and the input layer interface, and don't bother at all
+with hotkey_report_mode.
+
 
 Bluetooth
 ---------
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a266558..73e248f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -202,25 +202,5 @@ config THINKPAD_ACPI_BAY
 
 	  If you are not sure, say Y here.
 
-config THINKPAD_ACPI_INPUT_ENABLED
-	bool "Enable input layer support by default"
-	depends on THINKPAD_ACPI
-	default n
-	---help---
-	  This option enables thinkpad-acpi hot key handling over the input
-	  layer at driver load time.  When it is unset, the driver does not
-	  enable hot key handling by default, and also starts up with a mostly
-	  empty keymap.
-
-	  This option should be enabled if you have a new enough HAL or other
-	  userspace support that properly handles the thinkpad-acpi event
-	  device.  It auto-tunes the hot key support to those reported by the
-	  firmware and enables it automatically.
-
-	  If unsure, say N here to retain the old behaviour of ibm-acpi, and
-	  thinkpad-acpi up to kernel 2.6.21: userspace will have to enable and
-	  set up the thinkpad-acpi hot key handling using the sysfs interace
-	  after loading the driver.
-
 
 endif # MISC_DEVICES
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index bb8956d..3d849d1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -906,9 +906,26 @@ static ssize_t hotkey_radio_sw_show(struct device *dev,
 static struct device_attribute dev_attr_hotkey_radio_sw =
 	__ATTR(hotkey_radio_sw, S_IRUGO, hotkey_radio_sw_show, NULL);
 
+/* sysfs hotkey report_mode -------------------------------------------- */
+static ssize_t hotkey_report_mode_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+		(hotkey_report_mode != 0) ? hotkey_report_mode : 1);
+}
+
+static struct device_attribute dev_attr_hotkey_report_mode =
+	__ATTR(hotkey_report_mode, S_IRUGO, hotkey_report_mode_show, NULL);
+
 /* --------------------------------------------------------------------- */
 
-static struct attribute *hotkey_mask_attributes[] = {
+static struct attribute *hotkey_attributes[] __initdata = {
+	&dev_attr_hotkey_enable.attr,
+	&dev_attr_hotkey_report_mode.attr,
+};
+
+static struct attribute *hotkey_mask_attributes[] __initdata = {
 	&dev_attr_hotkey_mask.attr,
 	&dev_attr_hotkey_bios_enabled.attr,
 	&dev_attr_hotkey_bios_mask.attr,
@@ -987,11 +1004,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(7, NULL);
+		hotkey_dev_attributes = create_attr_set(8, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
-		res = add_to_attr_set(hotkey_dev_attributes,
-				&dev_attr_hotkey_enable.attr);
+		res = add_many_to_attr_set(hotkey_dev_attributes,
+				hotkey_attributes,
+				ARRAY_SIZE(hotkey_attributes));
 		if (res)
 			return res;
 
@@ -1055,11 +1073,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				TPACPI_HOTKEY_MAP_SIZE);
 		}
 
-#ifndef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
-		for (i = 0; i < 12; i++)
-			hotkey_keycode_map[i] = KEY_UNKNOWN;
-#endif /* ! CONFIG_THINKPAD_ACPI_INPUT_ENABLED */
-
 		set_bit(EV_KEY, tpacpi_inputdev->evbit);
 		set_bit(EV_MSC, tpacpi_inputdev->evbit);
 		set_bit(MSC_SCAN, tpacpi_inputdev->mscbit);
@@ -1081,14 +1094,17 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			set_bit(SW_RADIO, tpacpi_inputdev->swbit);
 		}
 
-#ifdef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
 		dbg_printk(TPACPI_DBG_INIT,
 				"enabling hot key handling\n");
 		res = hotkey_set(1, (hotkey_all_mask & ~hotkey_reserved_mask)
 					| hotkey_orig_mask);
 		if (res)
 			return res;
-#endif /* CONFIG_THINKPAD_ACPI_INPUT_ENABLED */
+
+		dbg_printk(TPACPI_DBG_INIT,
+				"legacy hot key reporting over procfs %s\n",
+				(hotkey_report_mode < 2) ?
+					"enabled" : "disabled");
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -1142,58 +1158,65 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
 	unsigned int keycode, scancode;
-	int sendacpi = 1;
+	int send_acpi_ev = 0;
 
 	if (event == 0x80 && acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
-		if (tpacpi_inputdev->users > 0) {
-			switch (hkey >> 12) {
-			case 1:
-				/* 0x1000-0x1FFF: key presses */
-				scancode = hkey & 0xfff;
-				if (scancode > 0 && scancode < 0x21) {
-					scancode--;
-					keycode = hotkey_keycode_map[scancode];
-					tpacpi_input_send_key(scancode, keycode);
-					sendacpi = (keycode == KEY_RESERVED
-						|| keycode == KEY_UNKNOWN);
-				} else {
-					printk(IBM_ERR
-					       "hotkey 0x%04x out of range for keyboard map\n",
-					       hkey);
-				}
-				break;
-			case 5:
-				/* 0x5000-0x5FFF: LID */
-				/* we don't handle it through this path, just
-				 * eat up known LID events */
-				if (hkey != 0x5001 && hkey != 0x5002) {
-					printk(IBM_ERR
-						"unknown LID-related hotkey event: 0x%04x\n",
-						hkey);
-				}
+		switch (hkey >> 12) {
+		case 1:
+			/* 0x1000-0x1FFF: key presses */
+			scancode = hkey & 0xfff;
+			if (scancode > 0 && scancode < 0x21) {
+				scancode--;
+				keycode = hotkey_keycode_map[scancode];
+				tpacpi_input_send_key(scancode, keycode);
+			} else {
+				printk(IBM_ERR
+				       "hotkey 0x%04x out of range for keyboard map\n",
+				       hkey);
+				send_acpi_ev = 1;
+			}
+			break;
+		case 5:
+			/* 0x5000-0x5FFF: LID */
+			/* we don't handle it through this path, just
+			 * eat up known LID events */
+			if (hkey != 0x5001 && hkey != 0x5002) {
+				printk(IBM_ERR
+					"unknown LID-related hotkey event: 0x%04x\n",
+					hkey);
+				send_acpi_ev = 1;
+			}
+			break;
+		case 7:
+			/* 0x7000-0x7FFF: misc */
+			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
+				tpacpi_input_send_radiosw();
 				break;
-			case 7:
-				/* 0x7000-0x7FFF: misc */
-				if (tp_features.hotkey_wlsw && hkey == 0x7000) {
-						tpacpi_input_send_radiosw();
-						sendacpi = 0;
-					break;
-				}
-				/* fallthrough to default */
-			default:
-				/* case 2: dock-related */
-				/*	0x2305 - T43 waking up due to bay lever eject while aslept */
-				/* case 3: ultra-bay related. maybe bay in dock? */
-				/*	0x3003 - T43 after wake up by bay lever eject (0x2305) */
-				printk(IBM_NOTICE "unhandled hotkey event 0x%04x\n", hkey);
 			}
+			/* fallthrough to default */
+		default:
+			/* case 2: dock-related */
+			/*	0x2305 - T43 waking up due to bay lever eject while aslept */
+			/* case 3: ultra-bay related. maybe bay in dock? */
+			/*	0x3003 - T43 after wake up by bay lever eject (0x2305) */
+			printk(IBM_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
+			send_acpi_ev = 1;
 		}
-
-		if (sendacpi)
-			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
 	} else {
 		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
-		acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
+		hkey = 0;
+		send_acpi_ev = 1;
+	}
+
+	/* Legacy events */
+	if (send_acpi_ev || hotkey_report_mode < 2)
+		acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
+
+	/* netlink events */
+	if (send_acpi_ev) {
+		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
+						ibm->acpi->device->dev.bus_id,
+						event, hkey);
 	}
 }
 
@@ -4623,6 +4646,9 @@ module_param_named(fan_control, fan_control_allowed, bool, 0);
 static int brightness_mode;
 module_param_named(brightness_mode, brightness_mode, int, 0);
 
+static unsigned int hotkey_report_mode;
+module_param(hotkey_report_mode, uint, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
@@ -4648,6 +4674,10 @@ static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
+	/* Parameter checking */
+	if (hotkey_report_mode > 2)
+		return -EINVAL;
+
 	/* Driver-level probe */
 
 	get_thinkpad_model_data(&thinkpad_id);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index eee8809..082a1cb 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -181,6 +181,7 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 static int experimental;
 static u32 dbg_level;
 static int force_load;
+static unsigned int hotkey_report_mode;
 
 static int thinkpad_acpi_module_init(void);
 static void thinkpad_acpi_module_exit(void);
-- 
1.5.2.4

