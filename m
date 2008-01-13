From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 5/6] sony-laptop: add Type4 model
Date: Sun, 13 Jan 2008 13:23:31 +0900
Message-ID: <1200198212-10526-6-git-send-email-malattia@linux.it>
References: <1200198212-10526-1-git-send-email-malattia@linux.it>
 <1200198212-10526-2-git-send-email-malattia@linux.it>
 <1200198212-10526-3-git-send-email-malattia@linux.it>
 <1200198212-10526-4-git-send-email-malattia@linux.it>
 <1200198212-10526-5-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:57021 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYAMEXz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 23:23:55 -0500
In-Reply-To: <1200198212-10526-5-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Recent Vaio models (UX, SZ and presumably TZ and others) add more
events and a slightly different handling of Fn key events for
additional hotkeys (s1, s2, zoom-in/out, etc.).

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |  284 ++++++++++++++++++++++++++------------------
 include/linux/sonypi.h     |    2 +
 2 files changed, 172 insertions(+), 114 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 84430b4..4089751 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -146,68 +146,70 @@ struct sony_laptop_keypress {
  * and input layer indexes in the keymap
  */
 static int sony_laptop_input_index[] = {
-	-1,	/* no event */
-	-1,	/* SONYPI_EVENT_JOGDIAL_DOWN */
-	-1,	/* SONYPI_EVENT_JOGDIAL_UP */
-	-1,	/* SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
-	-1,	/* SONYPI_EVENT_JOGDIAL_UP_PRESSED */
-	-1,	/* SONYPI_EVENT_JOGDIAL_PRESSED */
-	-1,	/* SONYPI_EVENT_JOGDIAL_RELEASED */
-	 0,	/* SONYPI_EVENT_CAPTURE_PRESSED */
-	 1,	/* SONYPI_EVENT_CAPTURE_RELEASED */
-	 2,	/* SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
-	 3,	/* SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
-	 4,	/* SONYPI_EVENT_FNKEY_ESC */
-	 5,	/* SONYPI_EVENT_FNKEY_F1 */
-	 6,	/* SONYPI_EVENT_FNKEY_F2 */
-	 7,	/* SONYPI_EVENT_FNKEY_F3 */
-	 8,	/* SONYPI_EVENT_FNKEY_F4 */
-	 9,	/* SONYPI_EVENT_FNKEY_F5 */
-	10,	/* SONYPI_EVENT_FNKEY_F6 */
-	11,	/* SONYPI_EVENT_FNKEY_F7 */
-	12,	/* SONYPI_EVENT_FNKEY_F8 */
-	13,	/* SONYPI_EVENT_FNKEY_F9 */
-	14,	/* SONYPI_EVENT_FNKEY_F10 */
-	15,	/* SONYPI_EVENT_FNKEY_F11 */
-	16,	/* SONYPI_EVENT_FNKEY_F12 */
-	17,	/* SONYPI_EVENT_FNKEY_1 */
-	18,	/* SONYPI_EVENT_FNKEY_2 */
-	19,	/* SONYPI_EVENT_FNKEY_D */
-	20,	/* SONYPI_EVENT_FNKEY_E */
-	21,	/* SONYPI_EVENT_FNKEY_F */
-	22,	/* SONYPI_EVENT_FNKEY_S */
-	23,	/* SONYPI_EVENT_FNKEY_B */
-	24,	/* SONYPI_EVENT_BLUETOOTH_PRESSED */
-	25,	/* SONYPI_EVENT_PKEY_P1 */
-	26,	/* SONYPI_EVENT_PKEY_P2 */
-	27,	/* SONYPI_EVENT_PKEY_P3 */
-	28,	/* SONYPI_EVENT_BACK_PRESSED */
-	-1,	/* SONYPI_EVENT_LID_CLOSED */
-	-1,	/* SONYPI_EVENT_LID_OPENED */
-	29,	/* SONYPI_EVENT_BLUETOOTH_ON */
-	30,	/* SONYPI_EVENT_BLUETOOTH_OFF */
-	31,	/* SONYPI_EVENT_HELP_PRESSED */
-	32,	/* SONYPI_EVENT_FNKEY_ONLY */
-	33,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN */
-	34,	/* SONYPI_EVENT_JOGDIAL_FAST_UP */
-	35,	/* SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
-	36,	/* SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
-	37,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
-	38,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP */
-	39,	/* SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
-	40,	/* SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
-	41,	/* SONYPI_EVENT_ZOOM_PRESSED */
-	42,	/* SONYPI_EVENT_THUMBPHRASE_PRESSED */
-	43,	/* SONYPI_EVENT_MEYE_FACE */
-	44,	/* SONYPI_EVENT_MEYE_OPPOSITE */
-	45,	/* SONYPI_EVENT_MEMORYSTICK_INSERT */
-	46,	/* SONYPI_EVENT_MEMORYSTICK_EJECT */
-	-1,	/* SONYPI_EVENT_ANYBUTTON_RELEASED */
-	-1,	/* SONYPI_EVENT_BATTERY_INSERT */
-	-1,	/* SONYPI_EVENT_BATTERY_REMOVE */
-	-1,	/* SONYPI_EVENT_FNKEY_RELEASED */
-	47,	/* SONYPI_EVENT_WIRELESS_ON */
-	48,	/* SONYPI_EVENT_WIRELESS_OFF */
+	-1,	/*  0 no event */
+	-1,	/*  1 SONYPI_EVENT_JOGDIAL_DOWN */
+	-1,	/*  2 SONYPI_EVENT_JOGDIAL_UP */
+	-1,	/*  3 SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
+	-1,	/*  4 SONYPI_EVENT_JOGDIAL_UP_PRESSED */
+	-1,	/*  5 SONYPI_EVENT_JOGDIAL_PRESSED */
+	-1,	/*  6 SONYPI_EVENT_JOGDIAL_RELEASED */
+	 0,	/*  7 SONYPI_EVENT_CAPTURE_PRESSED */
+	 1,	/*  8 SONYPI_EVENT_CAPTURE_RELEASED */
+	 2,	/*  9 SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
+	 3,	/* 10 SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
+	 4,	/* 11 SONYPI_EVENT_FNKEY_ESC */
+	 5,	/* 12 SONYPI_EVENT_FNKEY_F1 */
+	 6,	/* 13 SONYPI_EVENT_FNKEY_F2 */
+	 7,	/* 14 SONYPI_EVENT_FNKEY_F3 */
+	 8,	/* 15 SONYPI_EVENT_FNKEY_F4 */
+	 9,	/* 16 SONYPI_EVENT_FNKEY_F5 */
+	10,	/* 17 SONYPI_EVENT_FNKEY_F6 */
+	11,	/* 18 SONYPI_EVENT_FNKEY_F7 */
+	12,	/* 19 SONYPI_EVENT_FNKEY_F8 */
+	13,	/* 20 SONYPI_EVENT_FNKEY_F9 */
+	14,	/* 21 SONYPI_EVENT_FNKEY_F10 */
+	15,	/* 22 SONYPI_EVENT_FNKEY_F11 */
+	16,	/* 23 SONYPI_EVENT_FNKEY_F12 */
+	17,	/* 24 SONYPI_EVENT_FNKEY_1 */
+	18,	/* 25 SONYPI_EVENT_FNKEY_2 */
+	19,	/* 26 SONYPI_EVENT_FNKEY_D */
+	20,	/* 27 SONYPI_EVENT_FNKEY_E */
+	21,	/* 28 SONYPI_EVENT_FNKEY_F */
+	22,	/* 29 SONYPI_EVENT_FNKEY_S */
+	23,	/* 30 SONYPI_EVENT_FNKEY_B */
+	24,	/* 31 SONYPI_EVENT_BLUETOOTH_PRESSED */
+	25,	/* 32 SONYPI_EVENT_PKEY_P1 */
+	26,	/* 33 SONYPI_EVENT_PKEY_P2 */
+	27,	/* 34 SONYPI_EVENT_PKEY_P3 */
+	28,	/* 35 SONYPI_EVENT_BACK_PRESSED */
+	-1,	/* 36 SONYPI_EVENT_LID_CLOSED */
+	-1,	/* 37 SONYPI_EVENT_LID_OPENED */
+	29,	/* 38 SONYPI_EVENT_BLUETOOTH_ON */
+	30,	/* 39 SONYPI_EVENT_BLUETOOTH_OFF */
+	31,	/* 40 SONYPI_EVENT_HELP_PRESSED */
+	32,	/* 41 SONYPI_EVENT_FNKEY_ONLY */
+	33,	/* 42 SONYPI_EVENT_JOGDIAL_FAST_DOWN */
+	34,	/* 43 SONYPI_EVENT_JOGDIAL_FAST_UP */
+	35,	/* 44 SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
+	36,	/* 45 SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
+	37,	/* 46 SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
+	38,	/* 47 SONYPI_EVENT_JOGDIAL_VFAST_UP */
+	39,	/* 48 SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
+	40,	/* 49 SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
+	41,	/* 50 SONYPI_EVENT_ZOOM_PRESSED */
+	42,	/* 51 SONYPI_EVENT_THUMBPHRASE_PRESSED */
+	43,	/* 52 SONYPI_EVENT_MEYE_FACE */
+	44,	/* 53 SONYPI_EVENT_MEYE_OPPOSITE */
+	45,	/* 54 SONYPI_EVENT_MEMORYSTICK_INSERT */
+	46,	/* 55 SONYPI_EVENT_MEMORYSTICK_EJECT */
+	-1,	/* 56 SONYPI_EVENT_ANYBUTTON_RELEASED */
+	-1,	/* 57 SONYPI_EVENT_BATTERY_INSERT */
+	-1,	/* 58 SONYPI_EVENT_BATTERY_REMOVE */
+	-1,	/* 59 SONYPI_EVENT_FNKEY_RELEASED */
+	47,	/* 60 SONYPI_EVENT_WIRELESS_ON */
+	48,	/* 61 SONYPI_EVENT_WIRELESS_OFF */
+	49,	/* 62 SONYPI_EVENT_ZOOM_IN_PRESSED */
+	50,	/* 63 SONYPI_EVENT_ZOOM_OUT_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -260,6 +262,8 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_RESERVED,	/* 46 SONYPI_EVENT_MEMORYSTICK_EJECT */
 	KEY_WLAN,	/* 47 SONYPI_EVENT_WIRELESS_ON */
 	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
+	KEY_ZOOMIN,	/* 49 SONYPI_EVENT_ZOOM_IN_PRESSED */
+	KEY_ZOOMOUT	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -1178,10 +1182,12 @@ static struct acpi_driver sony_nc_driver = {
 #define SONYPI_DEVICE_TYPE1	0x00000001
 #define SONYPI_DEVICE_TYPE2	0x00000002
 #define SONYPI_DEVICE_TYPE3	0x00000004
+#define SONYPI_DEVICE_TYPE4	0x00000008
 
 #define SONYPI_TYPE1_OFFSET	0x04
 #define SONYPI_TYPE2_OFFSET	0x12
 #define SONYPI_TYPE3_OFFSET	0x12
+#define SONYPI_TYPE4_OFFSET	0x12
 
 struct sony_pic_ioport {
 	struct acpi_resource_io	io1;
@@ -1202,7 +1208,7 @@ struct sonypi_eventtypes {
 
 struct device_ctrl {
 	int				model;
-	int				(*handle_irq)(void);
+	int				(*handle_irq)(const u8, const u8);
 	u16				evport_offset;
 	u8				has_camera;
 	u8				has_bluetooth;
@@ -1277,6 +1283,7 @@ static struct sonypi_event sonypi_joggerev[] = {
 static struct sonypi_event sonypi_captureev[] = {
 	{ 0x05, SONYPI_EVENT_CAPTURE_PARTIALPRESSED },
 	{ 0x07, SONYPI_EVENT_CAPTURE_PRESSED },
+	{ 0x40, SONYPI_EVENT_CAPTURE_PRESSED },
 	{ 0x01, SONYPI_EVENT_CAPTURE_PARTIALRELEASED },
 	{ 0, 0 }
 };
@@ -1313,7 +1320,6 @@ static struct sonypi_event sonypi_pkeyev[] = {
 	{ 0x01, SONYPI_EVENT_PKEY_P1 },
 	{ 0x02, SONYPI_EVENT_PKEY_P2 },
 	{ 0x04, SONYPI_EVENT_PKEY_P3 },
-	{ 0x5c, SONYPI_EVENT_PKEY_P1 },
 	{ 0, 0 }
 };
 
@@ -1355,6 +1361,8 @@ static struct sonypi_event sonypi_lidev[] = {
 /* The set of possible zoom events */
 static struct sonypi_event sonypi_zoomev[] = {
 	{ 0x39, SONYPI_EVENT_ZOOM_PRESSED },
+	{ 0x10, SONYPI_EVENT_ZOOM_IN_PRESSED },
+	{ 0x20, SONYPI_EVENT_ZOOM_OUT_PRESSED },
 	{ 0, 0 }
 };
 
@@ -1424,55 +1432,19 @@ static struct sonypi_eventtypes type3_events[] = {
 	{ 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ 0 },
 };
-
-static struct device_ctrl spic_types[] = {
-	{
-		.model = SONYPI_DEVICE_TYPE1,
-		.handle_irq = NULL,
-		.evport_offset = SONYPI_TYPE1_OFFSET,
-		.event_types = type1_events,
-	},
-	{
-		.model = SONYPI_DEVICE_TYPE2,
-		.handle_irq = NULL,
-		.evport_offset = SONYPI_TYPE2_OFFSET,
-		.event_types = type2_events,
-	},
-	{
-		.model = SONYPI_DEVICE_TYPE3,
-		.handle_irq = NULL,
-		.evport_offset = SONYPI_TYPE3_OFFSET,
-		.event_types = type3_events,
-	},
+static struct sonypi_eventtypes type4_events[] = {
+	{ 0, 0xffffffff, sonypi_releaseev },
+	{ 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ 0x31, SONYPI_WIRELESS_MASK, sonypi_wlessev },
+	{ 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ 0x05, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ 0x05, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ 0x05, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ 0 },
 };
 
-static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
-{
-	struct pci_dev *pcidev;
-
-	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
-		dev->control = &spic_types[0];
-
-	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
-		dev->control = &spic_types[2];
-
-	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-					  PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
-		dev->control = &spic_types[2];
-
-	else
-		dev->control = &spic_types[1];
-
-	if (pcidev)
-		pci_dev_put(pcidev);
-
-	printk(KERN_INFO DRV_PFX "detected Type%d model\n",
-			dev->control->model == SONYPI_DEVICE_TYPE1 ? 1 :
-			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
-}
-
+/* low level spic calls */
 #define ITERATIONS_LONG		10000
 #define ITERATIONS_SHORT	10
 #define wait_on_command(command, iterations) {				\
@@ -1527,6 +1499,86 @@ static u8 sony_pic_call3(u8 dev, u8 fn, u8 v)
 	return v1;
 }
 
+/*
+ * minidrivers for SPIC models
+ */
+static int type4_handle_irq(const u8 data_mask, const u8 ev) {
+	/*
+	 * 0x31 could mean we have to take some extra action and wait for the next irq
+	 * for some Type4 models, it will generate a new irq and we can read new
+	 * data from the device:
+	 *  - 0x5c and 0x5f requires 0xA0
+	 *  - 0x61 requires 0xB3
+	 */
+	if (data_mask == 0x31) {
+		if (ev == 0x5c || ev == 0x5f)
+			sony_pic_call1(0xA0);
+		else if (ev == 0x61)
+			sony_pic_call1(0xB3);
+		return 0;
+	}
+	return 1;
+}
+
+static struct device_ctrl spic_types[] = {
+	{
+		.model = SONYPI_DEVICE_TYPE1,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE1_OFFSET,
+		.event_types = type1_events,
+	},
+	{
+		.model = SONYPI_DEVICE_TYPE2,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE2_OFFSET,
+		.event_types = type2_events,
+	},
+	{
+		.model = SONYPI_DEVICE_TYPE3,
+		.handle_irq = NULL,
+		.evport_offset = SONYPI_TYPE3_OFFSET,
+		.event_types = type3_events,
+	},
+	{
+		.model = SONYPI_DEVICE_TYPE4,
+		.handle_irq = type4_handle_irq,
+		.evport_offset = SONYPI_TYPE4_OFFSET,
+		.event_types = type4_events,
+	},
+};
+
+static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
+{
+	struct pci_dev *pcidev;
+
+	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
+		dev->control = &spic_types[0];
+
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
+		dev->control = &spic_types[2];
+
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
+		dev->control = &spic_types[3];
+
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH8_4, NULL)))
+		dev->control = &spic_types[3];
+
+	else
+		dev->control = &spic_types[1];
+
+	if (pcidev)
+		pci_dev_put(pcidev);
+
+	printk(KERN_INFO DRV_PFX "detected Type%d model\n",
+			dev->control->model == SONYPI_DEVICE_TYPE1 ? 1 :
+			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 :
+			dev->control->model == SONYPI_DEVICE_TYPE3 ? 3 : 4);
+}
+
 /* camera tests and poweron/poweroff */
 #define SONYPI_CAMERA_PICTURE		5
 #define SONYPI_CAMERA_CONTROL		0x10
@@ -2402,13 +2454,17 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 			}
 		}
 	}
-  	dprintk("unknown event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
- 			ev, data_mask, dev->cur_ioport->io1.minimum, dev->control->evport_offset);
+	/* Still not able to decode the event try to pass it over to the minidriver */
+	if (dev->control->handle_irq && dev->control->handle_irq(data_mask, ev) == 0)
+		return IRQ_HANDLED;
+
+	dprintk("unknown event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
+			ev, data_mask, dev->cur_ioport->io1.minimum, dev->control->evport_offset);
 	return IRQ_HANDLED;
 
 found:
 	sony_laptop_report_input_event(device_event);
- 	acpi_bus_generate_proc_event(dev->acpi_dev, 1, device_event);
+	acpi_bus_generate_proc_event(dev->acpi_dev, 1, device_event);
 	sonypi_compat_report_event(device_event);
 
 	return IRQ_HANDLED;
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index 40c7b5d..f41ffd7 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -101,6 +101,8 @@
 #define SONYPI_EVENT_FNKEY_RELEASED		59
 #define SONYPI_EVENT_WIRELESS_ON		60
 #define SONYPI_EVENT_WIRELESS_OFF		61
+#define SONYPI_EVENT_ZOOM_IN_PRESSED		62
+#define SONYPI_EVENT_ZOOM_OUT_PRESSED		63
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.5.3.7

