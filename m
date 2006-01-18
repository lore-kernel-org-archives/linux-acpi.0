From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 6/9] handle internal Bluetooth / support W5A
Date: Wed, 18 Jan 2006 22:48:59 +0100
Message-ID: <20060118214859.GG7199@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:56838 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1161016AbWARVtD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 16:49:03 -0500
Content-Disposition: inline
In-Reply-To: <20060118212110.GA7199@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch creates a new file named "bluetooth" under /proc/acpi/asus/.
This file controls both the internal Bluetooth adapter's presence on the
USB bus and the associated LED.

echo 1 > /proc/acpi/asus/bluetooth to enable, 0 to disable.

Additionally, the patch add support for Asus W5A, the first model that uses
this feature.

Patch originally by Fernando A. P. Gomes.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 17:44:03.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 17:56:16.000000000 +0100
@@ -49,6 +49,7 @@
 #define PROC_MLED       "mled"
 #define PROC_WLED       "wled"
 #define PROC_TLED       "tled"
+#define PROC_BT         "bluetooth"
 #define PROC_LEDD       "ledd"
 #define PROC_INFO       "info"
 #define PROC_LCD        "lcd"
@@ -69,9 +70,10 @@
 /*
  * Flags for hotk status
  */
-#define MLED_ON     0x01	//is MLED ON ?
-#define WLED_ON     0x02
-#define TLED_ON     0x04
+#define MLED_ON     0x01	//mail LED
+#define WLED_ON     0x02	//wireless LED
+#define TLED_ON     0x04	//touchpad LED
+#define BT_ON       0x08	//internal Bluetooth
 
 MODULE_AUTHOR("Julien Lerouge, Karol Kozimor");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
@@ -95,7 +97,9 @@ struct model_data {
 	char *mt_tled;		//method to handle tled_____________R
 	char *tled_status;	//node to handle tled reading_______A
 	char *mt_ledd;		//method to handle LED display______R
-	char *mt_lcd_switch;	//method to turn LCD ON/OFF_________A
+	char *mt_bt_switch;	//method to switch Bluetooth on/off_R
+	char *bt_status;	//no model currently supports this__?
+	char *mt_lcd_switch;	//method to turn LCD on/off_________A
 	char *lcd_status;	//node to read LCD panel state______A
 	char *brightness_up;	//method to set brightness up_______A
 	char *brightness_down;	//guess what ?______________________A
@@ -137,6 +141,7 @@ struct asus_hotk {
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
 		W1N,		//W1000N
+		W5A,		//W5A
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
 		END_MODEL
@@ -373,6 +378,16 @@ static struct model_data model_conf[END_
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "W5A",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\ADVG"},
+
+	{
 	 .name = "xxN",
 	 .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -639,6 +654,25 @@ proc_write_wled(struct file *file, const
 }
 
 /*
+ * Proc handlers for Bluetooth
+ */
+static int
+proc_read_bluetooth(char *page, char **start, off_t off, int count, int *eof,
+		    void *data)
+{
+	return sprintf(page, "%d\n", read_led(hotk->methods->bt_status, BT_ON));
+}
+
+static int
+proc_write_bluetooth(struct file *file, const char __user * buffer,
+		     unsigned long count, void *data)
+{
+	/* Note: mt_bt_switch controls both internal Bluetooth adapter's 
+	   presence and its LED */
+	return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 0);
+}
+
+/*
  * Proc handlers for TLED
  */
 static int
@@ -949,6 +983,11 @@ static int __init asus_hotk_add_fs(struc
 			      mode, device);
 	}
 
+	if (hotk->methods->mt_bt_switch) {
+		asus_proc_add(PROC_BT, &proc_write_bluetooth,
+			      &proc_read_bluetooth, mode, device);
+	}
+
 	/* 
 	 * We need both read node and write method as LCD switch is also accessible
 	 * from keyboard 
@@ -984,6 +1023,8 @@ static int asus_hotk_remove_fs(struct ac
 			remove_proc_entry(PROC_TLED, acpi_device_dir(device));
 		if (hotk->methods->mt_ledd)
 			remove_proc_entry(PROC_LEDD, acpi_device_dir(device));
+		if (hotk->methods->mt_bt_switch)
+			remove_proc_entry(PROC_BT, acpi_device_dir(device));
 		if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status)
 			remove_proc_entry(PROC_LCD, acpi_device_dir(device));
 		if ((hotk->methods->brightness_up
@@ -1137,6 +1178,8 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = A4G;
 	else if (strncmp(model->string.pointer, "W1N", 3) == 0)
 		hotk->model = W1N;
+	else if (strncmp(model->string.pointer, "W5A", 3) == 0)
+		hotk->model = W5A;
 
 	if (hotk->model == END_MODEL) {
 		printk("unsupported, trying default values, supply the "
