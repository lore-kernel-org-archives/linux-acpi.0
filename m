From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/3] asus-laptop: Fix coding style for comments
Date: Sat, 29 Aug 2009 10:28:29 +0200
Message-ID: <1251534511-8479-1-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.20]:59671 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZH2I3e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 04:29:34 -0400
In-Reply-To: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |  108 +++++++++++++++++++++---------------
 1 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 5b912cc..b39d2bb 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -77,16 +77,16 @@
  * Flags for hotk status
  * WL_ON and BT_ON are also used for wireless_status()
  */
-#define WL_ON       0x01	//internal Wifi
-#define BT_ON       0x02	//internal Bluetooth
-#define MLED_ON     0x04	//mail LED
-#define TLED_ON     0x08	//touchpad LED
-#define RLED_ON     0x10	//Record LED
-#define PLED_ON     0x20	//Phone LED
-#define GLED_ON     0x40	//Gaming LED
-#define LCD_ON      0x80	//LCD backlight
-#define GPS_ON      0x100	//GPS
-#define KEY_ON      0x200       //Keyboard backlight
+#define WL_ON       0x01	/* internal Wifi */
+#define BT_ON       0x02	/* internal Bluetooth */
+#define MLED_ON     0x04	/* mail LED */
+#define TLED_ON     0x08	/* touchpad LED */
+#define RLED_ON     0x10	/* Record LED */
+#define PLED_ON     0x20	/* Phone LED */
+#define GLED_ON     0x40	/* Gaming LED */
+#define LCD_ON      0x80	/* LCD backlight */
+#define GPS_ON      0x100	/* GPS */
+#define KEY_ON      0x200	/* Keyboard backlight */
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -99,7 +99,8 @@ MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
 MODULE_DESCRIPTION(ASUS_HOTK_NAME);
 MODULE_LICENSE("GPL");
 
-/* WAPF defines the behavior of the Fn+Fx wlan key
+/*
+ * WAPF defines the behavior of the Fn+Fx wlan key
  * The significance of values is yet to be found, but
  * most of the time:
  * 0x0 will do nothing
@@ -126,7 +127,8 @@ ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED");	/* G1, G2 (probably) */
 /* LEDD */
 ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
 
-/* Bluetooth and WLAN
+/*
+ * Bluetooth and WLAN
  * WLED and BLED are not handled like other XLED, because in some dsdt
  * they also control the WLAN/Bluetooth device.
  */
@@ -150,22 +152,32 @@ ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10",	/* All new models */
 
 /* Display */
 ASUS_HANDLE(display_set, ASUS_HOTK_PREFIX "SDSP");
-ASUS_HANDLE(display_get, "\\_SB.PCI0.P0P1.VGA.GETD",	/*  A6B, A6K A6R A7D F3JM L4R M6R A3G
-							   M6A M6V VX-1 V6J V6V W3Z */
-	    "\\_SB.PCI0.P0P2.VGA.GETD",	/* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V
-					   S5A M5A z33A W1Jc W2V G1 */
-	    "\\_SB.PCI0.P0P3.VGA.GETD",	/* A6V A6Q */
-	    "\\_SB.PCI0.P0PA.VGA.GETD",	/* A6T, A6M */
-	    "\\_SB.PCI0.PCI1.VGAC.NMAP",	/* L3C */
-	    "\\_SB.PCI0.VGA.GETD",	/* Z96F */
-	    "\\ACTD",		/* A2D */
-	    "\\ADVG",		/* A4G Z71A W1N W5A W5F M2N M3N M5N M6N S1N S5N */
-	    "\\DNXT",		/* P30 */
-	    "\\INFB",		/* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
-	    "\\SSTE");		/* A3F A6F A3N A3L M6N W3N W6A */
-
-ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC");	/* Z71A Z71V */
-ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL");	/* Z71A Z71V */
+ASUS_HANDLE(display_get,
+	    /* A6B, A6K A6R A7D F3JM L4R M6R A3G M6A M6V VX-1 V6J V6V W3Z */
+	    "\\_SB.PCI0.P0P1.VGA.GETD",
+	    /* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V S5A M5A z33A W1Jc W2V G1 */
+	    "\\_SB.PCI0.P0P2.VGA.GETD",
+	    /* A6V A6Q */
+	    "\\_SB.PCI0.P0P3.VGA.GETD",
+	    /* A6T, A6M */
+	    "\\_SB.PCI0.P0PA.VGA.GETD",
+	    /* L3C */
+	    "\\_SB.PCI0.PCI1.VGAC.NMAP",
+	    /* Z96F */
+	    "\\_SB.PCI0.VGA.GETD",
+	    /* A2D */
+	    "\\ACTD",
+	    /* A4G Z71A W1N W5A W5F M2N M3N M5N M6N S1N S5N */
+	    "\\ADVG",
+	    /* P30 */
+	    "\\DNXT",
+	    /* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
+	    "\\INFB",
+	    /* A3F A6F A3N A3L M6N W3N W6A */
+	    "\\SSTE");
+
+ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC"); /* Z71A Z71V */
+ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL");	 /* Z71A Z71V */
 
 /* GPS */
 /* R2H use different handle for GPS on/off */
@@ -182,14 +194,14 @@ ASUS_HANDLE(kled_get, ASUS_HOTK_PREFIX "GLKB");
  * about the hotk device
  */
 struct asus_hotk {
-	char *name;		//laptop name
-	struct acpi_device *device;	//the device we are in
-	acpi_handle handle;	//the handle of the hotk device
-	char status;		//status of the hotk, for LEDs, ...
-	u32 ledd_status;	//status of the LED display
-	u8 light_level;		//light sensor level
-	u8 light_switch;	//light sensor switch value
-	u16 event_count[128];	//count for each event TODO make this better
+	char *name;		/* laptop name */
+	struct acpi_device *device;	/* the device we are in */
+	acpi_handle handle;	/* the handle of the hotk device */
+	char status;		/* status of the hotk, for LEDs, ... */
+	u32 ledd_status;	/* status of the LED display */
+	u8 light_level;		/* light sensor level */
+	u8 light_switch;	/* light sensor switch value */
+	u16 event_count[128];	/* count for each event TODO make this better */
 	struct input_dev *inputdev;
 	u16 *keycode_map;
 };
@@ -242,10 +254,12 @@ static struct backlight_ops asusbl_ops = {
 	.update_status = update_bl_status,
 };
 
-/* These functions actually update the LED's, and are called from a
+/*
+ * These functions actually update the LED's, and are called from a
  * workqueue. By doing this as separate work rather than when the LED
  * subsystem asks, we avoid messing with the Asus ACPI stuff during a
- * potentially bad time, such as a timer interrupt. */
+ * potentially bad time, such as a timer interrupt.
+ */
 static struct workqueue_struct *led_workqueue;
 
 #define ASUS_LED(object, ledname, max)					\
@@ -318,8 +332,8 @@ static struct key_entry asus_keymap[] = {
 static int write_acpi_int(acpi_handle handle, const char *method, int val,
 			  struct acpi_buffer *output)
 {
-	struct acpi_object_list params;	//list of input parameters (an int here)
-	union acpi_object in_obj;	//the only param we use
+	struct acpi_object_list params;	/* list of input parameters (an int) */
+	union acpi_object in_obj;	/* the only param we use */
 	acpi_status status;
 
 	if (!handle)
@@ -574,7 +588,7 @@ static ssize_t show_infos(struct device *dev,
 {
 	int len = 0;
 	unsigned long long temp;
-	char buf[16];		//enough for all info
+	char buf[16];		/* enough for all info */
 	acpi_status rv = AE_OK;
 
 	/*
@@ -734,8 +748,10 @@ static int read_display(void)
 	unsigned long long value = 0;
 	acpi_status rv = AE_OK;
 
-	/* In most of the case, we know how to set the display, but sometime
-	   we can't read it */
+	/*
+	 * In most of the case, we know how to set the display, but sometime
+	 * we can't read it
+	 */
 	if (display_get_handle) {
 		rv = acpi_evaluate_integer(display_get_handle, NULL,
 					   NULL, &value);
@@ -1152,8 +1168,10 @@ static int asus_hotk_get_info(void)
 	ASUS_HANDLE_INIT(display_set);
 	ASUS_HANDLE_INIT(display_get);
 
-	/* There is a lot of models with "ALSL", but a few get
-	   a real light sens, so we need to check it. */
+	/*
+	 * There is a lot of models with "ALSL", but a few get
+	 * a real light sens, so we need to check it.
+	 */
 	if (!ASUS_HANDLE_INIT(ls_switch))
 		ASUS_HANDLE_INIT(ls_level);
 
-- 
1.6.4.1


