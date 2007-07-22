From: Len Brown <len.brown@intel.com>
Subject: [PATCH 51/77] ACPI: thinkpad-acpi: make the input event mode the default
Date: Sun, 22 Jul 2007 05:14:36 -0400
Message-ID: <11850957552824-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35103 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763666AbXGVJP5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:57 -0400
In-Reply-To: <11850957541879-git-send-email-len.brown@intel.com>
Message-Id: <1a343760b516ca5466d201bec32b1794858b18a5.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Make the input layer the default way to deal with thinkpad-acpi hot keys,
but add a kernel config option to retain the old way of doing things.

This means we map a lot more keys to useful stuff by default, and also that
we enable hot key handling by default on driver load (like Windows does).

The documentation for proper use of this resource is also updated.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   89 ++++++++++++++++++---------------------
 drivers/misc/Kconfig            |   13 ++++++
 drivers/misc/thinkpad_acpi.c    |   19 +++++++-
 3 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 91d0892..5b59cf5 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -155,52 +155,47 @@ Hot keys
 procfs: /proc/acpi/ibm/hotkey
 sysfs device attribute: hotkey_*
 
-Without this driver, only the Fn-F4 key (sleep button) generates an
-ACPI event. With the driver loaded, the hotkey feature enabled and the
-mask set (see below), the various hot keys generate ACPI events in the
+In a ThinkPad, the ACPI HKEY handler is responsible for comunicating
+some important events and also keyboard hot key presses to the operating
+system.  Enabling the hotkey functionality of thinkpad-acpi signals the
+firmware that such a driver is present, and modifies how the ThinkPad
+firmware will behave in many situations.
+
+When the hotkey feature is enabled and the hot key mask is set (see
+below), the various hot keys either generate ACPI events in the
 following format:
 
 	ibm/hotkey HKEY 00000080 0000xxxx
 
-The last four digits vary depending on the key combination pressed.
-All labeled Fn-Fx key combinations generate distinct events. In
-addition, the lid microswitch and some docking station buttons may
-also generate such events.
-
-Hot keys also generate regular keyboard key press/release events through
-the input layer in addition to the ibm/hotkey ACPI events.  The input
-layer support accepts the standard IOCTLs to remap the keycodes assigned
-to each hotkey.
+or events over the input layer.  The input layer support accepts the
+standard IOCTLs to remap the keycodes assigned to each hotkey.
 
 When the input device is open, the driver will suppress any ACPI hot key
 events that get translated into a meaningful input layer event, in order
 to avoid sending duplicate events to userspace.  Hot keys that are
-mapped to KEY_RESERVED are not translated, and will always generate only
-ACPI hot key event, and no input layer events.
-
-The bit mask allows some control over which hot keys generate ACPI
-events. Not all bits in the mask can be modified. Not all bits that can
-be modified do anything. Not all hot keys can be individually controlled
-by the mask. Some models do not support the mask at all. On those
-models, hot keys cannot be controlled individually.
-
-Note that enabling ACPI events for some keys prevents their default
-behavior. For example, if events for Fn-F5 are enabled, that key will no
-longer enable/disable Bluetooth by itself. This can still be done from
-an acpid handler for the ibm/hotkey event.
-
-On some models, even enabling/disabling the entire hot key feature may
-change the way some keys behave (e.g. in a T43, Fn+F4 will generate an
-button/sleep ACPI event if hot keys are disabled, and it will ignore its
-mask when hot keys are enabled, so the key always does something.  On a
-X40, Fn+F4 respects its mask status, but generates the button/sleep ACPI
-event if masked off).
-
-Note also that not all Fn key combinations are supported through
-ACPI. For example, on the X40, the brightness, volume and "Access IBM"
-buttons do not generate ACPI events even with this driver. They *can*
-be used through the "ThinkPad Buttons" utility, see
-http://www.nongnu.org/tpb/
+mapped to KEY_RESERVED in the keymap are not translated, and will always
+generate an ACPI ibm/hotkey HKEY event, and no input layer events.
+
+The hot key bit mask allows some control over which hot keys generate
+events.  If a key is "masked" (bit set to 0 in the mask), the firmware
+will handle it.  If it is "unmasked", it signals the firmware that
+thinkpad-acpi would prefer to handle it, if the firmware would be so
+kind to allow it (and it often doesn't!).
+
+Not all bits in the mask can be modified.  Not all bits that can be
+modified do anything.  Not all hot keys can be individually controlled
+by the mask.  Some models do not support the mask at all, and in those
+models, hot keys cannot be controlled individually.  The behaviour of
+the mask is, therefore, higly dependent on the ThinkPad model.
+
+Note that unmasking some keys prevents their default behavior.  For
+example, if Fn+F5 is unmasked, that key will no longer enable/disable
+Bluetooth by itself.
+
+Note also that not all Fn key combinations are supported through ACPI.
+For example, on the X40, the brightness, volume and "Access IBM" buttons
+do not generate ACPI events even with this driver.  They *can* be used
+through the "ThinkPad Buttons" utility, see http://www.nongnu.org/tpb/
 
 procfs notes:
 
@@ -221,7 +216,7 @@ sysfs notes:
 		key feature status will be restored to this value.
 
 		0: hot keys were disabled
-		1: hot keys were enabled
+		1: hot keys were enabled (unusual)
 
 	hotkey_bios_mask:
 		Returns the hot keys mask when thinkpad-acpi was loaded.
@@ -236,9 +231,10 @@ sysfs notes:
 		1: enables the hot keys feature / feature enabled
 
 	hotkey_mask:
-		bit mask to enable ACPI event generation for each hot
-		key (see above).  Returns the current status of the hot
-		keys mask, and allows one to modify it.
+		bit mask to enable driver-handling and ACPI event
+		generation for each hot key (see above).  Returns the
+		current status of the hot keys mask, and allows one to
+		modify it.
 
 	hotkey_all_mask:
 		bit mask that should enable event reporting for all
@@ -250,8 +246,9 @@ sysfs notes:
 
 	hotkey_recommended_mask:
 		bit mask that should enable event reporting for all
-		supported hot keys, except those which are handled by
-		the firmware.  Echo it to hotkey_mask above, to use.
+		supported hot keys, except those which are always
+		handled by the firmware anyway.  Echo it to
+		hotkey_mask above, to use.
 
 	hotkey_radio_sw:
 		if the ThinkPad has a hardware radio switch, this
@@ -390,10 +387,6 @@ ACPI hotkey event.
 If a key is mapped to anything else, it will only generate legacy
 thinkpad-acpi ACPI hotkey events if nobody has opened the input device.
 
-For userspace backwards-compatibility purposes, the keycode map is
-initially filled with KEY_RESERVED and KEY_UNKNOWN mappings for scan codes
-0x00 to 0x10 (and maybe others).
-
 Non hot-key ACPI HKEY event map:
 0x5001		Lid closed
 0x5002		Lid opened
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1d516f2..5197f9b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -196,4 +196,17 @@ config THINKPAD_ACPI_BAY
 
 	  If you are not sure, say Y here.
 
+config THINKPAD_ACPI_INPUT_ENABLED
+	bool "Enable input layer support by default"
+	depends on THINKPAD_ACPI
+	default y
+	---help---
+	  Enables hot key handling over the input layer by default.  If unset,
+	  the driver does not enable any hot key handling by default, and also
+	  starts up with a mostly empty keymap.
+
+	  If you are not sure, say Y here.  Say N to retain the deprecated
+	  behavior of ibm-acpi, and thinkpad-acpi for kernels up to 2.6.21.
+
+
 endif # MISC_DEVICES
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5c1bea1..c86b228 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -734,9 +734,9 @@ static u32 hotkey_reserved_mask;
 
 static u16 hotkey_keycode_map[] = {
 	/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
-	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	KEY_FN_F1,	KEY_FN_F2,	KEY_FN_F3,	KEY_SLEEP,
+	KEY_FN_F5,	KEY_FN_F6,	KEY_FN_F7,	KEY_FN_F8,
+	KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
 	/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
 	KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
 	KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
@@ -977,6 +977,11 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		if (res)
 			return res;
 
+#ifndef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
+		for (i = 0; i < 12; i++)
+			hotkey_keycode_map[i] = KEY_UNKNOWN;
+#endif /* ! CONFIG_THINKPAD_ACPI_INPUT_ENABLED */
+
 		set_bit(EV_KEY, tpacpi_inputdev->evbit);
 		set_bit(EV_MSC, tpacpi_inputdev->evbit);
 		set_bit(MSC_SCAN, tpacpi_inputdev->mscbit);
@@ -993,6 +998,14 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			}
 		}
 
+#ifdef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
+		dbg_printk(TPACPI_DBG_INIT,
+				"enabling hot key handling\n");
+		res = hotkey_set(1, (hotkey_all_mask & ~hotkey_reserved_mask)
+					| hotkey_orig_mask);
+		if (res)
+			return res;
+#endif /* CONFIG_THINKPAD_ACPI_INPUT_ENABLED */
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
-- 
1.5.3.rc2.22.g69a9b
