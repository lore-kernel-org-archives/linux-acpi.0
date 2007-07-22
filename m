From: Len Brown <len.brown@intel.com>
Subject: [PATCH 59/77] ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
Date: Sun, 22 Jul 2007 05:14:44 -0400
Message-ID: <11850957641697-git-send-email-len.brown@intel.com>
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
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45767 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764315AbXGVJQF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:05 -0400
In-Reply-To: <11850957633613-git-send-email-len.brown@intel.com>
Message-Id: <edf0e0e56904f794c97ca6c4562d8256e3d8d8e3.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Lenovo ThinkPads have a slightly different key map layout from IBM
ThinkPads (fn+f2 and fn+f3 are swapped).  Knowing which one we are dealing
with, we can properly set a few more hot keys up by default.

Also, export the correct vendor in the input device, as that information
might be useful to userspace.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   40 ++++++++++----
 drivers/misc/thinkpad_acpi.c    |  109 +++++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 40 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index c145bcc..5d827de 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -270,7 +270,8 @@ remapping KEY_UNKNOWN keys.
 The events are available in an input device, with the following id:
 
 	Bus:		BUS_HOST
-	vendor:		0x1014 (PCI_VENDOR_ID_IBM)
+	vendor:		0x1014 (PCI_VENDOR_ID_IBM)  or
+			0x17aa (PCI_VENDOR_ID_LENOVO)
 	product:	0x5054 ("TP")
 	version:	0x4101
 
@@ -290,12 +291,15 @@ ACPI	Scan
 event	code	Key		Notes
 
 0x1001	0x00	FN+F1		-
-0x1002	0x01	FN+F2		-
+0x1002	0x01	FN+F2		IBM: battery (rare)
+				Lenovo: Screen lock
 
-0x1003	0x02	FN+F3		Many models always report this
-				hot key, even with hot keys
+0x1003	0x02	FN+F3		Many IBM models always report
+				this hot key, even with hot keys
 				disabled or with Fn+F3 masked
 				off
+				IBM: screen lock
+				Lenovo: battery
 
 0x1004	0x03	FN+F4		Sleep button (ACPI sleep button
 				semanthics, i.e. sleep-to-RAM).
@@ -313,13 +317,19 @@ event	code	Key		Notes
 				and W-WAN card if left in control
 				of the firmware.  Does not affect
 				the WLAN card.
+				Should be used to turn on/off all
+				radios (bluetooth+W-WAN+WLAN),
+				really.
 
 0x1006	0x05	FN+F6		-
 
 0x1007	0x06	FN+F7		Video output cycle.
 				Do you feel lucky today?
 
-0x1008	0x07	FN+F8		-
+0x1008	0x07	FN+F8		IBM: toggle screen expand
+				Lenovo: configure ultranav
+
+0x1009	0x08	FN+F9		-
 	..	..		..
 0x100B	0x0A	FN+F11		-
 
@@ -338,13 +348,15 @@ event	code	Key		Notes
 0x100F	0x0E	FN+DELETE	-
 
 0x1010	0x0F	FN+HOME		Brightness up.  This key is
-				always handled by the firmware,
-				even when unmasked.  Just leave
-				it alone.
-0x1011	0x10	FN+END		Brightness down. This key is
-				always handled by the firmware,
-				even when unmasked.  Just leave
-				it alone.
+				always handled by the firmware
+				in IBM ThinkPads, even when
+				unmasked.  Just leave it alone.
+				For Lenovo ThinkPads with a new
+				BIOS, it has to be handled either
+				by the ACPI OSI, or by userspace.
+0x1011	0x10	FN+END		Brightness down.  See brightness
+				up for details.
+
 0x1012	0x11	FN+PGUP		Thinklight toggle.  This key is
 				always handled by the firmware,
 				even when unmasked.
@@ -356,9 +368,13 @@ event	code	Key		Notes
 0x1015	0x14	VOLUME UP	Internal mixer volume up. This
 				key is always handled by the
 				firmware, even when unmasked.
+				NOTE: Lenovo seems to be changing
+				this.
 0x1016	0x15	VOLUME DOWN	Internal mixer volume up. This
 				key is always handled by the
 				firmware, even when unmasked.
+				NOTE: Lenovo seems to be changing
+				this.
 0x1017	0x16	MUTE		Mute internal mixer. This
 				key is always handled by the
 				firmware, even when unmasked.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5318eb2..623d36f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -758,29 +758,7 @@ static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
 static u32 hotkey_reserved_mask;
 
-static u16 hotkey_keycode_map[] = {
-	/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
-	KEY_FN_F1,	KEY_FN_F2,	KEY_FN_F3,	KEY_SLEEP,
-	KEY_FN_F5,	KEY_FN_F6,	KEY_FN_F7,	KEY_FN_F8,
-	KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
-	/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
-	KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
-	KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
-	KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
-	KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
-	/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
-	KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
-	KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
-	KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
-	KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
-	KEY_RESERVED,	/* 0x14: VOLUME UP */
-	KEY_RESERVED,	/* 0x15: VOLUME DOWN */
-	KEY_RESERVED,	/* 0x16: MUTE */
-	KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
-	/* (assignments unknown, please report if found) */
-	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-};
+static u16 *hotkey_keycode_map;
 
 static struct attribute_set *hotkey_dev_attributes;
 
@@ -939,6 +917,58 @@ static struct attribute *hotkey_mask_attributes[] = {
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
+
+	static u16 ibm_keycode_map[] __initdata = {
+		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
+		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SLEEP,
+		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
+		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
+		/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
+		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
+		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
+		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
+		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
+		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
+		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
+		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
+		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
+		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
+		KEY_RESERVED,	/* 0x14: VOLUME UP */
+		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
+		KEY_RESERVED,	/* 0x16: MUTE */
+		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
+		/* (assignments unknown, please report if found) */
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	};
+	static u16 lenovo_keycode_map[] __initdata = {
+		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
+		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SLEEP,
+		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
+		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
+		/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
+		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
+		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
+		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
+		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
+		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
+		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
+		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
+		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
+		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
+		KEY_RESERVED,	/* 0x14: VOLUME UP */
+		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
+		KEY_RESERVED,	/* 0x16: MUTE */
+		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
+		/* (assignments unknown, please report if found) */
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+	};
+
+#define TPACPI_HOTKEY_MAP_LEN		ARRAY_SIZE(ibm_keycode_map)
+#define TPACPI_HOTKEY_MAP_SIZE		sizeof(ibm_keycode_map)
+#define TPACPI_HOTKEY_MAP_TYPESIZE	sizeof(ibm_keycode_map[0])
+
 	int res, i;
 	int status;
 
@@ -1003,6 +1033,27 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		if (res)
 			return res;
 
+		/* Set up key map */
+
+		hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
+						GFP_KERNEL);
+		if (!hotkey_keycode_map) {
+			printk(IBM_ERR "failed to allocate memory for key map\n");
+			return -ENOMEM;
+		}
+
+		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
+			dbg_printk(TPACPI_DBG_INIT,
+				   "using Lenovo default hot key map\n");
+			memcpy(hotkey_keycode_map, &lenovo_keycode_map,
+				TPACPI_HOTKEY_MAP_SIZE);
+		} else {
+			dbg_printk(TPACPI_DBG_INIT,
+				   "using IBM default hot key map\n");
+			memcpy(hotkey_keycode_map, &ibm_keycode_map,
+				TPACPI_HOTKEY_MAP_SIZE);
+		}
+
 #ifndef CONFIG_THINKPAD_ACPI_INPUT_ENABLED
 		for (i = 0; i < 12; i++)
 			hotkey_keycode_map[i] = KEY_UNKNOWN;
@@ -1011,10 +1062,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		set_bit(EV_KEY, tpacpi_inputdev->evbit);
 		set_bit(EV_MSC, tpacpi_inputdev->evbit);
 		set_bit(MSC_SCAN, tpacpi_inputdev->mscbit);
-		tpacpi_inputdev->keycodesize = sizeof(hotkey_keycode_map[0]);
-		tpacpi_inputdev->keycodemax = ARRAY_SIZE(hotkey_keycode_map);
-		tpacpi_inputdev->keycode = &hotkey_keycode_map;
-		for (i = 0; i < ARRAY_SIZE(hotkey_keycode_map); i++) {
+		tpacpi_inputdev->keycodesize = TPACPI_HOTKEY_MAP_TYPESIZE;
+		tpacpi_inputdev->keycodemax = TPACPI_HOTKEY_MAP_LEN;
+		tpacpi_inputdev->keycode = hotkey_keycode_map;
+		for (i = 0; i < TPACPI_HOTKEY_MAP_LEN; i++) {
 			if (hotkey_keycode_map[i] != KEY_RESERVED) {
 				set_bit(hotkey_keycode_map[i],
 					tpacpi_inputdev->keybit);
@@ -4618,7 +4669,9 @@ static int __init thinkpad_acpi_module_init(void)
 		tpacpi_inputdev->name = "ThinkPad Extra Buttons";
 		tpacpi_inputdev->phys = IBM_DRVR_NAME "/input0";
 		tpacpi_inputdev->id.bustype = BUS_HOST;
-		tpacpi_inputdev->id.vendor = TPACPI_HKEY_INPUT_VENDOR;
+		tpacpi_inputdev->id.vendor = (thinkpad_id.vendor) ?
+						thinkpad_id.vendor :
+						PCI_VENDOR_ID_IBM;
 		tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
 		tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
 	}
-- 
1.5.3.rc2.22.g69a9b
