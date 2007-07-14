From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: ACPI: thinkpad-acpi: add input device support to
	hotkey subdriver
Date: Sat, 14 Jul 2007 11:11:59 -0300
Message-ID: <11844223334107-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11844223322928-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add input device support to the hotkey subdriver.

Hot keys that have a valid keycode mapping are reported through the input
layer if the input device is open.  Otherwise, they will be reported as
ACPI events, as they were before.

Scan codes are reported (using EV_MSC MSC_SCAN events) along with EV_KEY
KEY_UNKNOWN events.

For backwards compatibility purposes, hot keys that used to be reported
through ACPI events are not mapped to anything meaningful by default.
Userspace is supposed to remap them if it wants to use the input device for
hot key reporting.

This patch is based on a patch by Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |  151 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.c    |  108 +++++++++++++++++++++++++++-
 2 files changed, 255 insertions(+), 4 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index bd00d14..91d0892 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -167,6 +167,17 @@ All labeled Fn-Fx key combinations generate distinct events. In
 addition, the lid microswitch and some docking station buttons may
 also generate such events.
 
+Hot keys also generate regular keyboard key press/release events through
+the input layer in addition to the ibm/hotkey ACPI events.  The input
+layer support accepts the standard IOCTLs to remap the keycodes assigned
+to each hotkey.
+
+When the input device is open, the driver will suppress any ACPI hot key
+events that get translated into a meaningful input layer event, in order
+to avoid sending duplicate events to userspace.  Hot keys that are
+mapped to KEY_RESERVED are not translated, and will always generate only
+ACPI hot key event, and no input layer events.
+
 The bit mask allows some control over which hot keys generate ACPI
 events. Not all bits in the mask can be modified. Not all bits that can
 be modified do anything. Not all hot keys can be individually controlled
@@ -248,6 +259,146 @@ sysfs notes:
 		disabled" postition, and 1 if the switch is in the
 		"radios enabled" position.
 
+input layer notes:
+
+A Hot key is mapped to a single input layer EV_KEY event, possibly
+followed by an EV_MSC MSC_SCAN event that shall contain that key's scan
+code.  An EV_SYN event will always be generated to mark the end of the
+event block.
+
+Do not use the EV_MSC MSC_SCAN events to process keys.  They are to be
+used as a helper to remap keys, only.  They are particularly useful when
+remapping KEY_UNKNOWN keys.
+
+The events are available in an input device, with the following id:
+
+	Bus:		BUS_HOST
+	vendor:		0x1014 (PCI_VENDOR_ID_IBM)
+	product:	0x5054 ("TP")
+	version:	0x4101
+
+The version will have its LSB incremented if the keymap changes in a
+backwards-compatible way.  The MSB shall always be 0x41 for this input
+device.  If the MSB is not 0x41, do not use the device as described in
+this section, as it is either something else (e.g. another input device
+exported by a thinkpad driver, such as HDAPS) or its functionality has
+been changed in a non-backwards compatible way.
+
+Adding other event types for other functionalities shall be considered a
+backwards-compatible change for this input device.
+
+Thinkpad-acpi Hot Key event map (version 0x4101):
+
+ACPI	Scan
+event	code	Key		Notes
+
+0x1001	0x00	FN+F1		-
+0x1002	0x01	FN+F2		-
+
+0x1003	0x02	FN+F3		Many models always report this
+				hot key, even with hot keys
+				disabled or with Fn+F3 masked
+				off
+
+0x1004	0x03	FN+F4		Sleep button (ACPI sleep button
+				semanthics, i.e. sleep-to-RAM).
+				It is always generate some kind
+				of event, either the hot key
+				event or a ACPI sleep button
+				event. The firmware may
+				refuse to generate further FN+F4
+				key presses until a S3 or S4 ACPI
+				sleep cycle is performed or some
+				time passes.
+
+0x1005	0x04	FN+F5		Radio.  Enables/disables
+				the internal BlueTooth hardware
+				and W-WAN card if left in control
+				of the firmware.  Does not affect
+				the WLAN card.
+
+0x1006	0x05	FN+F6		-
+
+0x1007	0x06	FN+F7		Video output cycle.
+				Do you feel lucky today?
+
+0x1008	0x07	FN+F8		-
+	..	..		..
+0x100B	0x0A	FN+F11		-
+
+0x100C	0x0B	FN+F12		Sleep to disk.  You are always
+				supposed to handle it yourself,
+				either through the ACPI event,
+				or through a hotkey event.
+				The firmware may refuse to
+				generate further FN+F4 key
+				press events until a S3 or S4
+				ACPI sleep cycle is performed,
+				or some time passes.
+
+0x100D	0x0C	FN+BACKSPACE	-
+0x100E	0x0D	FN+INSERT	-
+0x100F	0x0E	FN+DELETE	-
+
+0x1010	0x0F	FN+HOME		Brightness up.  This key is
+				always handled by the firmware,
+				even when unmasked.  Just leave
+				it alone.
+0x1011	0x10	FN+END		Brightness down. This key is
+				always handled by the firmware,
+				even when unmasked.  Just leave
+				it alone.
+0x1012	0x11	FN+PGUP		Thinklight toggle.  This key is
+				always handled by the firmware,
+				even when unmasked.
+
+0x1013	0x12	FN+PGDOWN	-
+
+0x1014	0x13	FN+SPACE	Zoom key
+
+0x1015	0x14	VOLUME UP	Internal mixer volume up. This
+				key is always handled by the
+				firmware, even when unmasked.
+0x1016	0x15	VOLUME DOWN	Internal mixer volume up. This
+				key is always handled by the
+				firmware, even when unmasked.
+0x1017	0x16	MUTE		Mute internal mixer. This
+				key is always handled by the
+				firmware, even when unmasked.
+
+0x1018	0x17	THINKPAD	Thinkpad/Access IBM/Lenovo key
+
+0x1019	0x18	unknown
+..	..	..
+0x1020	0x1F	unknown
+
+The ThinkPad firmware does not allow one to differentiate when most hot
+keys are pressed or released (either that, or we don't know how to, yet).
+For these keys, the driver generates a set of events for a key press and
+immediately issues the same set of events for a key release.  It is
+unknown by the driver if the ThinkPad firmware triggered these events on
+hot key press or release, but the firmware will do it for either one, not
+both.
+
+If a key is mapped to KEY_RESERVED, it generates no input events at all,
+and it may generate a legacy thinkpad-acpi ACPI hotkey event.
+
+If a key is mapped to KEY_UNKNOWN, it generates an input event that
+includes an scan code, and it may also generate a legacy thinkpad-acpi
+ACPI hotkey event.
+
+If a key is mapped to anything else, it will only generate legacy
+thinkpad-acpi ACPI hotkey events if nobody has opened the input device.
+
+For userspace backwards-compatibility purposes, the keycode map is
+initially filled with KEY_RESERVED and KEY_UNKNOWN mappings for scan codes
+0x00 to 0x10 (and maybe others).
+
+Non hot-key ACPI HKEY event map:
+0x5001		Lid closed
+0x5002		Lid opened
+0x7000		Radio Switch may have changed state
+
 
 Bluetooth
 ---------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4427c99..5c1bea1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -730,7 +730,31 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
-static u32 hotkey_reserved_mask = 0x00778000;
+static u32 hotkey_reserved_mask;
+
+static u16 hotkey_keycode_map[] = {
+	/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
+	KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
+	KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
+	KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
+	KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
+	/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
+	KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
+	KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
+	KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
+	KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
+	KEY_RESERVED,	/* 0x14: VOLUME UP */
+	KEY_RESERVED,	/* 0x15: VOLUME DOWN */
+	KEY_RESERVED,	/* 0x16: MUTE */
+	KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
+	/* (assignments unknown, please report if found) */
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+};
 
 static struct attribute_set *hotkey_dev_attributes;
 
@@ -889,11 +913,13 @@ static struct attribute *hotkey_mask_attributes[] = {
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
-	int res;
+	int res, i;
 	int status;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
+	BUG_ON(!tpacpi_inputdev);
+
 	IBM_ACPIHANDLE_INIT(hkey);
 	mutex_init(&hotkey_mutex);
 
@@ -950,6 +976,23 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 					&tpacpi_pdev->dev.kobj);
 		if (res)
 			return res;
+
+		set_bit(EV_KEY, tpacpi_inputdev->evbit);
+		set_bit(EV_MSC, tpacpi_inputdev->evbit);
+		set_bit(MSC_SCAN, tpacpi_inputdev->mscbit);
+		tpacpi_inputdev->keycodesize = sizeof(hotkey_keycode_map[0]);
+		tpacpi_inputdev->keycodemax = ARRAY_SIZE(hotkey_keycode_map);
+		tpacpi_inputdev->keycode = &hotkey_keycode_map;
+		for (i = 0; i < ARRAY_SIZE(hotkey_keycode_map); i++) {
+			if (hotkey_keycode_map[i] != KEY_RESERVED) {
+				set_bit(hotkey_keycode_map[i],
+					tpacpi_inputdev->keybit);
+			} else {
+				if (i < sizeof(hotkey_reserved_mask)*8)
+					hotkey_reserved_mask |= 1 << i;
+			}
+		}
+
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -972,12 +1015,69 @@ static void hotkey_exit(void)
 	}
 }
 
+static void tpacpi_input_send_key(unsigned int scancode,
+				  unsigned int keycode)
+{
+	if (keycode != KEY_RESERVED) {
+		input_report_key(tpacpi_inputdev, keycode, 1);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+
+		input_report_key(tpacpi_inputdev, keycode, 0);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+	}
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
-	int hkey;
+	u32 hkey;
+	unsigned int keycode, scancode;
+	int sendacpi = 1;
 
 	if (event == 0x80 && acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
-		acpi_bus_generate_event(ibm->acpi->device, event, hkey);
+		if (tpacpi_inputdev->users > 0) {
+			switch (hkey >> 12) {
+			case 1:
+				/* 0x1000-0x1FFF: key presses */
+				scancode = hkey & 0xfff;
+				if (scancode > 0 && scancode < 0x21) {
+					scancode--;
+					keycode = hotkey_keycode_map[scancode];
+					tpacpi_input_send_key(scancode, keycode);
+					sendacpi = (keycode == KEY_RESERVED
+						|| keycode == KEY_UNKNOWN);
+				} else {
+					printk(IBM_ERR
+					       "hotkey 0x%04x out of range for keyboard map\n",
+					       hkey);
+				}
+				break;
+			case 5:
+				/* 0x5000-0x5FFF: LID */
+				/* we don't handle it through this path, just
+				 * eat up known LID events */
+				if (hkey != 0x5001 && hkey != 0x5002) {
+					printk(IBM_ERR
+						"unknown LID-related hotkey event: 0x%04x\n",
+						hkey);
+				}
+				break;
+			default:
+				/* case 2: dock-related */
+				/*	0x2305 - T43 waking up due to bay lever eject while aslept */
+				/* case 3: ultra-bay related. maybe bay in dock? */
+				/*	0x3003 - T43 after wake up by bay lever eject (0x2305) */
+				printk(IBM_NOTICE "unhandled hotkey event 0x%04x\n", hkey);
+			}
+		}
+
+		if (sendacpi)
+			acpi_bus_generate_event(ibm->acpi->device, event, hkey);
 	} else {
 		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
 		acpi_bus_generate_event(ibm->acpi->device, event, 0);
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
