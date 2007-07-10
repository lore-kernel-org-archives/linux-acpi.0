From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 5/5] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 11 Jul 2007 00:04:35 +0900
Message-ID: <11840798801243-git-send-email-malattia@linux.it>
References: <1184079875379-git-send-email-malattia@linux.it>
 <11840798753720-git-send-email-malattia@linux.it>
 <11840798752561-git-send-email-malattia@linux.it>
 <11840798753415-git-send-email-malattia@linux.it>
 <11840798802272-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:43944 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbXGJPFF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2007 11:05:05 -0400
In-Reply-To: <11840798802272-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Richard Hughes <richard@hughsie.com>

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Richard Hughes <richard@hughsie.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |  134 +++++++++++++++++++++++++++----------------
 1 files changed, 84 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 5300cad..39d22b9 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -143,44 +143,69 @@ struct sony_laptop_keypress {
 };
 
 /* Correspondance table between sonypi events and input layer events */
-static struct {
-	int sonypiev;
-	int inputev;
-} sony_laptop_inputkeys[] = {
-	{ SONYPI_EVENT_CAPTURE_PRESSED,	 	KEY_CAMERA },
-	{ SONYPI_EVENT_FNKEY_ONLY, 		KEY_FN },
-	{ SONYPI_EVENT_FNKEY_ESC, 		KEY_FN_ESC },
-	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
-	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
-	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
-	{ SONYPI_EVENT_FNKEY_F4, 		KEY_FN_F4 },
-	{ SONYPI_EVENT_FNKEY_F5, 		KEY_FN_F5 },
-	{ SONYPI_EVENT_FNKEY_F6, 		KEY_FN_F6 },
-	{ SONYPI_EVENT_FNKEY_F7, 		KEY_FN_F7 },
-	{ SONYPI_EVENT_FNKEY_F8, 		KEY_FN_F8 },
-	{ SONYPI_EVENT_FNKEY_F9,		KEY_FN_F9 },
-	{ SONYPI_EVENT_FNKEY_F10,		KEY_FN_F10 },
-	{ SONYPI_EVENT_FNKEY_F11, 		KEY_FN_F11 },
-	{ SONYPI_EVENT_FNKEY_F12,		KEY_FN_F12 },
-	{ SONYPI_EVENT_FNKEY_1, 		KEY_FN_1 },
-	{ SONYPI_EVENT_FNKEY_2, 		KEY_FN_2 },
-	{ SONYPI_EVENT_FNKEY_D,			KEY_FN_D },
-	{ SONYPI_EVENT_FNKEY_E,			KEY_FN_E },
-	{ SONYPI_EVENT_FNKEY_F,			KEY_FN_F },
-	{ SONYPI_EVENT_FNKEY_S,			KEY_FN_S },
-	{ SONYPI_EVENT_FNKEY_B,			KEY_FN_B },
-	{ SONYPI_EVENT_BLUETOOTH_PRESSED, 	KEY_BLUE },
-	{ SONYPI_EVENT_BLUETOOTH_ON, 		KEY_BLUE },
-	{ SONYPI_EVENT_PKEY_P1, 		KEY_PROG1 },
-	{ SONYPI_EVENT_PKEY_P2, 		KEY_PROG2 },
-	{ SONYPI_EVENT_PKEY_P3, 		KEY_PROG3 },
-	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
-	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
-	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
-	{ SONYPI_EVENT_WIRELESS_ON, 		KEY_WLAN },
-	{ SONYPI_EVENT_WIRELESS_OFF, 		KEY_WLAN },
-	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
-	{ 0, 0 },
+static int sony_laptop_input_keycode_map[] = {
+	KEY_RESERVED,	 /* no event... */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_DOWN */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_UP */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_UP_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_RELEASED */
+	KEY_CAMERA,	/* SONYPI_EVENT_CAPTURE_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_CAPTURE_RELEASED */
+	KEY_RESERVED,	/* SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
+	KEY_FN_ESC,	/* SONYPI_EVENT_FNKEY_ESC */
+	KEY_FN_F1,	/* SONYPI_EVENT_FNKEY_F1 */
+	KEY_FN_F2,	/* SONYPI_EVENT_FNKEY_F2 */
+	KEY_FN_F3,	/* SONYPI_EVENT_FNKEY_F3 */
+	KEY_FN_F4,	/* SONYPI_EVENT_FNKEY_F4 */
+	KEY_FN_F5,	/* SONYPI_EVENT_FNKEY_F5 */
+	KEY_FN_F6,	/* SONYPI_EVENT_FNKEY_F6 */
+	KEY_FN_F7,	/* SONYPI_EVENT_FNKEY_F7 */
+	KEY_FN_F8,	/* SONYPI_EVENT_FNKEY_F8 */
+	KEY_FN_F9,	/* SONYPI_EVENT_FNKEY_F9 */
+	KEY_FN_F10,	/* SONYPI_EVENT_FNKEY_F10 */
+	KEY_FN_F11,	/* SONYPI_EVENT_FNKEY_F11 */
+	KEY_FN_F12,	/* SONYPI_EVENT_FNKEY_F12 */
+	KEY_FN_F1,	/* SONYPI_EVENT_FNKEY_1 */
+	KEY_FN_F2,	/* SONYPI_EVENT_FNKEY_2 */
+	KEY_FN_D,	/* SONYPI_EVENT_FNKEY_D */
+	KEY_FN_E,	/* SONYPI_EVENT_FNKEY_E */
+	KEY_FN_F,	/* SONYPI_EVENT_FNKEY_F */
+	KEY_FN_S,	/* SONYPI_EVENT_FNKEY_S */
+	KEY_FN_B,	/* SONYPI_EVENT_FNKEY_B */
+	KEY_BLUE,	/* SONYPI_EVENT_BLUETOOTH_PRESSED */
+	KEY_PROG1,	/* SONYPI_EVENT_PKEY_P1 */
+	KEY_PROG2,	/* SONYPI_EVENT_PKEY_P2 */
+	KEY_PROG3,	/* SONYPI_EVENT_PKEY_P3 */
+	KEY_BACK,	/* SONYPI_EVENT_BACK_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_LID_CLOSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_LID_OPENED */
+	KEY_BLUE,	/* SONYPI_EVENT_BLUETOOTH_ON */
+	KEY_BLUE,	/* SONYPI_EVENT_BLUETOOTH_OFF */
+	KEY_HELP,	/* SONYPI_EVENT_HELP_PRESSED */
+	KEY_FN,		/* SONYPI_EVENT_FNKEY_ONLY */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_FAST_UP */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
+	KEY_ZOOM,	/* SONYPI_EVENT_ZOOM_PRESSED */
+	BTN_THUMB,	/* SONYPI_EVENT_THUMBPHRASE_PRESSED */
+	KEY_RESERVED,	/* SONYPI_EVENT_MEYE_FACE */
+	KEY_RESERVED,	/* SONYPI_EVENT_MEYE_OPPOSITE */
+	KEY_RESERVED,	/* SONYPI_EVENT_MEMORYSTICK_INSERT */
+	KEY_RESERVED,	/* SONYPI_EVENT_MEMORYSTICK_EJECT */
+	KEY_RESERVED,	/* SONYPI_EVENT_ANYBUTTON_RELEASED */
+	KEY_RESERVED,	/* SONYPI_EVENT_BATTERY_INSERT */
+	KEY_RESERVED,	/* SONYPI_EVENT_BATTERY_REMOVE */
+	KEY_RESERVED,	/* SONYPI_EVENT_FNKEY_RELEASED */
+	KEY_WLAN,	/* SONYPI_EVENT_WIRELESS_ON */
+	KEY_WLAN,	/* SONYPI_EVENT_WIRELESS_OFF */
 };
 
 /* release buttons after a short delay if pressed */
@@ -204,7 +229,6 @@ static void sony_laptop_report_input_event(u8 event)
 	struct input_dev *jog_dev = sony_laptop_input.jog_dev;
 	struct input_dev *key_dev = sony_laptop_input.key_dev;
 	struct sony_laptop_keypress kp = { NULL };
-	int i;
 
 	if (event == SONYPI_EVENT_FNKEY_RELEASED) {
 		/* Nothing, not all VAIOs generate this event */
@@ -233,17 +257,20 @@ static void sony_laptop_report_input_event(u8 event)
 		break;
 
 	default:
-		for (i = 0; sony_laptop_inputkeys[i].sonypiev; i++)
-			if (event == sony_laptop_inputkeys[i].sonypiev) {
-				kp.dev = key_dev;
-				kp.key = sony_laptop_inputkeys[i].inputev;
-				break;
-			}
+		if (event > ARRAY_SIZE (sony_laptop_input_keycode_map)) {
+			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
+			break;
+		}
+		kp.key = sony_laptop_input_keycode_map[event];
+		if (kp.key != KEY_UNKNOWN)
+			kp.dev = key_dev;
 		break;
 	}
 
 	if (kp.dev) {
 		input_report_key(kp.dev, kp.key, 1);
+		/* we emit the scancode so we can always remap the key */
+		input_event(kp.dev, EV_MSC, MSC_SCAN, event);
 		input_sync(kp.dev);
 		kfifo_put(sony_laptop_input.fifo,
 			  (unsigned char *)&kp, sizeof(kp));
@@ -298,11 +325,18 @@ static int sony_laptop_setup_input(void)
 	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
 
 	/* Initialize the Input Drivers: special keys */
-	key_dev->evbit[0] = BIT(EV_KEY);
-	for (i = 0; sony_laptop_inputkeys[i].sonypiev; i++)
-		if (sony_laptop_inputkeys[i].inputev)
-			set_bit(sony_laptop_inputkeys[i].inputev,
-					key_dev->keybit);
+	set_bit(EV_KEY, key_dev->evbit);
+	set_bit(EV_MSC, key_dev->evbit);
+	set_bit(MSC_SCAN, key_dev->mscbit);
+	key_dev->keycodesize = sizeof(sony_laptop_input_keycode_map[0]);
+	key_dev->keycodemax = ARRAY_SIZE(sony_laptop_input_keycode_map);
+	key_dev->keycode = &sony_laptop_input_keycode_map;
+	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
+		if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
+			set_bit(sony_laptop_input_keycode_map[i],
+				key_dev->keybit);
+		}
+	}
 
 	error = input_register_device(key_dev);
 	if (error)
-- 
1.5.2.3

