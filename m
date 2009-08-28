From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 19/24] asus-laptop: Add support for Keyboard backlight
Date: Fri, 28 Aug 2009 14:56:50 +0200
Message-ID: <1251464215-6540-20-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-19-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60889 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
In-Reply-To: <1251464215-6540-19-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Add support for keyboard backlight found in Asus U50VG.

The SMC driver for the Apples does it via LED. To be
consistent with that we create /sys/class/leds/asus::kbd_backlight/
to control the keyboard backlight.

SLKB and GLKB are used to get/set the backlight. On
the U50VG is supports 4 brightness level, but this may
change with other models.

SLKB take a 8 bit integer where the higher bit is used
to toggle the backlight, and the over 7 bits control the
brightness level.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   79 +++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 652902e..0fb4e59 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -86,6 +86,7 @@
 #define GLED_ON     0x40	//Gaming LED
 #define LCD_ON      0x80	//LCD backlight
 #define GPS_ON      0x100	//GPS
+#define KEY_ON      0x200       //Keyboard backlight
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -172,6 +173,10 @@ ASUS_HANDLE(gps_on, ASUS_HOTK_PREFIX "SDON");	/* R2H */
 ASUS_HANDLE(gps_off, ASUS_HOTK_PREFIX "SDOF");	/* R2H */
 ASUS_HANDLE(gps_status, ASUS_HOTK_PREFIX "GPST");
 
+/* Keyboard light */
+ASUS_HANDLE(kled_set, ASUS_HOTK_PREFIX "SLKB");
+ASUS_HANDLE(kled_get, ASUS_HOTK_PREFIX "GLKB");
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -263,6 +268,7 @@ ASUS_LED(tled, "touchpad", 1);
 ASUS_LED(rled, "record", 1);
 ASUS_LED(pled, "phone", 1);
 ASUS_LED(gled, "gaming", 1);
+ASUS_LED(kled, "kbd_backlight", 3);
 
 struct key_entry {
 	char type;
@@ -419,6 +425,60 @@ ASUS_LED_HANDLER(rled, RLED_ON);
 ASUS_LED_HANDLER(tled, TLED_ON);
 ASUS_LED_HANDLER(gled, GLED_ON);
 
+/*
+ * Keyboard backlight
+ */
+static int get_kled_lvl(void)
+{
+	unsigned long long kblv;
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+	acpi_status rv;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = 2;
+
+	rv = acpi_evaluate_integer(kled_get_handle, NULL, &params, &kblv);
+	if (ACPI_FAILURE(rv)) {
+		pr_warning("Error reading kled level\n");
+		return 0;
+	}
+	return kblv;
+}
+
+static int set_kled_lvl(int kblv)
+{
+	if (kblv > 0)
+		kblv = (1 << 7) | (kblv & 0x7F);
+	else
+		kblv = 0;
+
+	if (write_acpi_int(kled_set_handle, NULL, kblv, NULL)) {
+		pr_warning("Keyboard LED display write failed\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void kled_led_set(struct led_classdev *led_cdev,
+			 enum led_brightness value)
+{
+	kled_led_wk = value;
+	queue_work(led_workqueue, &kled_led_work);
+}
+
+static void kled_led_update(struct work_struct *ignored)
+{
+	set_kled_lvl(kled_led_wk);
+}
+
+static enum led_brightness kled_led_get(struct led_classdev *led_cdev)
+{
+	return get_kled_lvl();
+}
+
 static int get_lcd_state(void)
 {
 	return read_status(LCD_ON);
@@ -1059,6 +1119,9 @@ static int asus_hotk_get_info(void)
 
 	ASUS_HANDLE_INIT(ledd_set);
 
+	ASUS_HANDLE_INIT(kled_set);
+	ASUS_HANDLE_INIT(kled_get);
+
 	/*
 	 * The HWRS method return informations about the hardware.
 	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
@@ -1190,6 +1253,10 @@ static int asus_hotk_add(struct acpi_device *device)
 	/* LCD Backlight is on by default */
 	write_status(NULL, 1, LCD_ON);
 
+	/* Keyboard Backlight is on by default */
+	if (kled_set_handle)
+		set_kled_lvl(1);
+
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
 
@@ -1244,6 +1311,7 @@ static void asus_led_exit(void)
 	ASUS_LED_UNREGISTER(pled);
 	ASUS_LED_UNREGISTER(rled);
 	ASUS_LED_UNREGISTER(gled);
+	ASUS_LED_UNREGISTER(kled);
 }
 
 static void asus_input_exit(void)
@@ -1323,13 +1391,20 @@ static int asus_led_init(struct device *dev)
 	if (rv)
 		goto out4;
 
+	if (kled_set_handle && kled_get_handle)
+		rv = ASUS_LED_REGISTER(kled, dev);
+	if (rv)
+		goto out5;
+
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!led_workqueue)
-		goto out5;
+		goto out6;
 
 	return 0;
-out5:
+out6:
 	rv = -ENOMEM;
+	ASUS_LED_UNREGISTER(kled);
+out5:
 	ASUS_LED_UNREGISTER(gled);
 out4:
 	ASUS_LED_UNREGISTER(pled);
-- 
1.6.4


