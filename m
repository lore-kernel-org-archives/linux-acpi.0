From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 11/16] ACPI: thinkpad-acpi: make the input
	event mode the default
Date: Thu,  5 Jul 2007 23:42:23 -0300
Message-ID: <11836897492902-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make the input layer the default way to deal with thinkpad-acpi hot keys,
but add a kernel config option to retain the old way of doing things.

This means we map a lot more keys to useful stuff by default, and also that
we enable hot key handling by default on driver load (like Windows does).

The documentation for proper use of this resource is also updated.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   89 ++++++++++++++++++---------------------
 drivers/misc/Kconfig            |   12 +++++
 drivers/misc/thinkpad_acpi.c    |   19 +++++++-
 3 files changed, 69 insertions(+), 51 deletions(-)

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
index 2f2fbff..bbe24bc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -187,6 +187,18 @@ config THINKPAD_ACPI_BAY
 
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
 config BLINK
 	tristate "Keyboard blink driver"
 	help
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
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
