From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Fri, 20 Jul 2007 02:01:57 +0900
Message-ID: <20070719170157.GC5412@inferi.kami.home>
References: <1184520879452-git-send-email-malattia@linux.it> <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it> <d120d5000707160622v7b62eeb5sd962e6e96dafdfec@mail.gmail.com> <20070718113321.GG5711@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:41298 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935070AbXGSRCK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2007 13:02:10 -0400
Content-Disposition: inline
In-Reply-To: <20070718113321.GG5711@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,
the following is the only way I could think of to hide some events as
per Dmitry suggestions while still using the default {set,get}keycode
implementation. 
Unfortunately I don't have enough time to put more work in the
sony-laptop module right now.

I'll send an updated patch series later (tomorrow?).

commit 20c3d84c721706fd0893ba5f73c1b4f1c231322b
Author: Richard Hughes <richard@hughsie.com>
Date:   Fri Jul 20 01:41:57 2007 +0900

    Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
    
    Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Signed-off-by: Richard Hughes <richard@hughsie.com>
    Signed-off-by: Mattia Dongili <malattia@linux.it>

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 5300cad..af69b3b 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -142,45 +142,124 @@ struct sony_laptop_keypress {
 	int key;
 };
 
-/* Correspondance table between sonypi events and input layer events */
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
+/* Correspondance table between sonypi events
+ * and input layer indexes in the keymap
+ */
+static int sony_laptop_input_index[] = {
+	-1,	/* no event */
+	-1,	/* SONYPI_EVENT_JOGDIAL_DOWN */
+	-1,	/* SONYPI_EVENT_JOGDIAL_UP */
+	-1,	/* SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
+	-1,	/* SONYPI_EVENT_JOGDIAL_UP_PRESSED */
+	-1,	/* SONYPI_EVENT_JOGDIAL_PRESSED */
+	-1,	/* SONYPI_EVENT_JOGDIAL_RELEASED */
+	 0,	/* SONYPI_EVENT_CAPTURE_PRESSED */
+	 1,	/* SONYPI_EVENT_CAPTURE_RELEASED */
+	 2,	/* SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
+	 3,	/* SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
+	 4,	/* SONYPI_EVENT_FNKEY_ESC */
+	 5,	/* SONYPI_EVENT_FNKEY_F1 */
+	 6,	/* SONYPI_EVENT_FNKEY_F2 */
+	 7,	/* SONYPI_EVENT_FNKEY_F3 */
+	 8,	/* SONYPI_EVENT_FNKEY_F4 */
+	 9,	/* SONYPI_EVENT_FNKEY_F5 */
+	10,	/* SONYPI_EVENT_FNKEY_F6 */
+	11,	/* SONYPI_EVENT_FNKEY_F7 */
+	12,	/* SONYPI_EVENT_FNKEY_F8 */
+	13,	/* SONYPI_EVENT_FNKEY_F9 */
+	14,	/* SONYPI_EVENT_FNKEY_F10 */
+	15,	/* SONYPI_EVENT_FNKEY_F11 */
+	16,	/* SONYPI_EVENT_FNKEY_F12 */
+	17,	/* SONYPI_EVENT_FNKEY_1 */
+	18,	/* SONYPI_EVENT_FNKEY_2 */
+	19,	/* SONYPI_EVENT_FNKEY_D */
+	20,	/* SONYPI_EVENT_FNKEY_E */
+	21,	/* SONYPI_EVENT_FNKEY_F */
+	22,	/* SONYPI_EVENT_FNKEY_S */
+	23,	/* SONYPI_EVENT_FNKEY_B */
+	24,	/* SONYPI_EVENT_BLUETOOTH_PRESSED */
+	25,	/* SONYPI_EVENT_PKEY_P1 */
+	26,	/* SONYPI_EVENT_PKEY_P2 */
+	27,	/* SONYPI_EVENT_PKEY_P3 */
+	28,	/* SONYPI_EVENT_BACK_PRESSED */
+	-1,	/* SONYPI_EVENT_LID_CLOSED */
+	-1,	/* SONYPI_EVENT_LID_OPENED */
+	29,	/* SONYPI_EVENT_BLUETOOTH_ON */
+	30,	/* SONYPI_EVENT_BLUETOOTH_OFF */
+	31,	/* SONYPI_EVENT_HELP_PRESSED */
+	32,	/* SONYPI_EVENT_FNKEY_ONLY */
+	33,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN */
+	34,	/* SONYPI_EVENT_JOGDIAL_FAST_UP */
+	35,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
+	36,	/* SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
+	37,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
+	38,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP */
+	39,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
+	40,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
+	41,	/* SONYPI_EVENT_ZOOM_PRESSED */
+	42,	/* SONYPI_EVENT_THUMBPHRASE_PRESSED */
+	43,	/* SONYPI_EVENT_MEYE_FACE */
+	44,	/* SONYPI_EVENT_MEYE_OPPOSITE */
+	45,	/* SONYPI_EVENT_MEMORYSTICK_INSERT */
+	46,	/* SONYPI_EVENT_MEMORYSTICK_EJECT */
+	-1,	/* SONYPI_EVENT_ANYBUTTON_RELEASED */
+	-1,	/* SONYPI_EVENT_BATTERY_INSERT */
+	-1,	/* SONYPI_EVENT_BATTERY_REMOVE */
+	-1,	/* SONYPI_EVENT_FNKEY_RELEASED */
+	47,	/* SONYPI_EVENT_WIRELESS_ON */
+	48,	/* SONYPI_EVENT_WIRELESS_OFF */
+};
+
+static int sony_laptop_input_keycode_map[] = {
+	KEY_CAMERA,	/*  0 SONYPI_EVENT_CAPTURE_PRESSED */
+	KEY_RESERVED,	/*  1 SONYPI_EVENT_CAPTURE_RELEASED */
+	KEY_RESERVED,	/*  2 SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
+	KEY_RESERVED,	/*  3 SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
+	KEY_FN_ESC,	/*  4 SONYPI_EVENT_FNKEY_ESC */
+	KEY_FN_F1,	/*  5 SONYPI_EVENT_FNKEY_F1 */
+	KEY_FN_F2,	/*  6 SONYPI_EVENT_FNKEY_F2 */
+	KEY_FN_F3,	/*  7 SONYPI_EVENT_FNKEY_F3 */
+	KEY_FN_F4,	/*  8 SONYPI_EVENT_FNKEY_F4 */
+	KEY_FN_F5,	/*  9 SONYPI_EVENT_FNKEY_F5 */
+	KEY_FN_F6,	/* 10 SONYPI_EVENT_FNKEY_F6 */
+	KEY_FN_F7,	/* 11 SONYPI_EVENT_FNKEY_F7 */
+	KEY_FN_F8,	/* 12 SONYPI_EVENT_FNKEY_F8 */
+	KEY_FN_F9,	/* 13 SONYPI_EVENT_FNKEY_F9 */
+	KEY_FN_F10,	/* 14 SONYPI_EVENT_FNKEY_F10 */
+	KEY_FN_F11,	/* 15 SONYPI_EVENT_FNKEY_F11 */
+	KEY_FN_F12,	/* 16 SONYPI_EVENT_FNKEY_F12 */
+	KEY_FN_F1,	/* 17 SONYPI_EVENT_FNKEY_1 */
+	KEY_FN_F2,	/* 18 SONYPI_EVENT_FNKEY_2 */
+	KEY_FN_D,	/* 19 SONYPI_EVENT_FNKEY_D */
+	KEY_FN_E,	/* 20 SONYPI_EVENT_FNKEY_E */
+	KEY_FN_F,	/* 21 SONYPI_EVENT_FNKEY_F */
+	KEY_FN_S,	/* 22 SONYPI_EVENT_FNKEY_S */
+	KEY_FN_B,	/* 23 SONYPI_EVENT_FNKEY_B */
+	KEY_BLUETOOTH,	/* 24 SONYPI_EVENT_BLUETOOTH_PRESSED */
+	KEY_PROG1,	/* 25 SONYPI_EVENT_PKEY_P1 */
+	KEY_PROG2,	/* 26 SONYPI_EVENT_PKEY_P2 */
+	KEY_PROG3,	/* 27 SONYPI_EVENT_PKEY_P3 */
+	KEY_BACK,	/* 28 SONYPI_EVENT_BACK_PRESSED */
+	KEY_BLUETOOTH,	/* 29 SONYPI_EVENT_BLUETOOTH_ON */
+	KEY_BLUETOOTH,	/* 30 SONYPI_EVENT_BLUETOOTH_OFF */
+	KEY_HELP,	/* 31 SONYPI_EVENT_HELP_PRESSED */
+	KEY_FN,		/* 32 SONYPI_EVENT_FNKEY_ONLY */
+	KEY_RESERVED,	/* 33 SONYPI_EVENT_JOGDIAL_FAST_DOWN */
+	KEY_RESERVED,	/* 34 SONYPI_EVENT_JOGDIAL_FAST_UP */
+	KEY_RESERVED,	/* 35 SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
+	KEY_RESERVED,	/* 36 SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
+	KEY_RESERVED,	/* 37 SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
+	KEY_RESERVED,	/* 38 SONYPI_EVENT_JOGDIAL_VFAST_UP */
+	KEY_RESERVED,	/* 39 SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
+	KEY_RESERVED,	/* 40 SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
+	KEY_ZOOM,	/* 41 SONYPI_EVENT_ZOOM_PRESSED */
+	BTN_THUMB,	/* 42 SONYPI_EVENT_THUMBPHRASE_PRESSED */
+	KEY_RESERVED,	/* 43 SONYPI_EVENT_MEYE_FACE */
+	KEY_RESERVED,	/* 44 SONYPI_EVENT_MEYE_OPPOSITE */
+	KEY_RESERVED,	/* 45 SONYPI_EVENT_MEMORYSTICK_INSERT */
+	KEY_RESERVED,	/* 46 SONYPI_EVENT_MEMORYSTICK_EJECT */
+	KEY_WLAN,	/* 47 SONYPI_EVENT_WIRELESS_ON */
+	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
 };
 
 /* release buttons after a short delay if pressed */
@@ -204,7 +283,6 @@ static void sony_laptop_report_input_event(u8 event)
 	struct input_dev *jog_dev = sony_laptop_input.jog_dev;
 	struct input_dev *key_dev = sony_laptop_input.key_dev;
 	struct sony_laptop_keypress kp = { NULL };
-	int i;
 
 	if (event == SONYPI_EVENT_FNKEY_RELEASED) {
 		/* Nothing, not all VAIOs generate this event */
@@ -233,17 +311,22 @@ static void sony_laptop_report_input_event(u8 event)
 		break;
 
 	default:
-		for (i = 0; sony_laptop_inputkeys[i].sonypiev; i++)
-			if (event == sony_laptop_inputkeys[i].sonypiev) {
+		if (event > ARRAY_SIZE (sony_laptop_input_keycode_map)) {
+			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
+			break;
+		}
+		if (sony_laptop_input_index[event] != -1) {
+			kp.key = sony_laptop_input_keycode_map[sony_laptop_input_index[event]];
+			if (kp.key != KEY_UNKNOWN)
 				kp.dev = key_dev;
-				kp.key = sony_laptop_inputkeys[i].inputev;
-				break;
-			}
+		}
 		break;
 	}
 
 	if (kp.dev) {
 		input_report_key(kp.dev, kp.key, 1);
+		/* we emit the scancode so we can always remap the key */
+		input_event(kp.dev, EV_MSC, MSC_SCAN, event);
 		input_sync(kp.dev);
 		kfifo_put(sony_laptop_input.fifo,
 			  (unsigned char *)&kp, sizeof(kp));
@@ -298,11 +381,18 @@ static int sony_laptop_setup_input(void)
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
mattia
:wq!
