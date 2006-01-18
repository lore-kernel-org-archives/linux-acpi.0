From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 3/9] LED display support
Date: Wed, 18 Jan 2006 22:36:39 +0100
Message-ID: <20060118213639.GD7199@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:31506 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S964871AbWARVgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 16:36:43 -0500
Content-Disposition: inline
In-Reply-To: <20060118212110.GA7199@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch adds handling for front LED displays found on W1N and the li=
ke.
Additionally, W1N is given its own model_data instance.

Patch originally by =C9ric Burghard.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 17:28:11.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 17:29:43.000000000 +0100
@@ -26,6 +26,7 @@
  *  Pontus Fuchs   - Helper functions, cleanup
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting =
point.
+ *  =C9ric Burghard  - LED display support for W1N
  *
  *  TODO:
  *  add Fn key status
@@ -48,6 +49,7 @@
 #define PROC_MLED       "mled"
 #define PROC_WLED       "wled"
 #define PROC_TLED       "tled"
+#define PROC_LEDD       "ledd"
 #define PROC_INFO       "info"
 #define PROC_LCD        "lcd"
 #define PROC_BRN        "brn"
@@ -92,6 +94,7 @@ struct model_data {
 	char *wled_status;	//node to handle wled reading_______A
 	char *mt_tled;		//method to handle tled_____________R
 	char *tled_status;	//node to handle tled reading_______A
+	char *mt_ledd;		//method to handle LED display______R
 	char *mt_lcd_switch;	//method to turn LCD ON/OFF_________A
 	char *lcd_status;	//node to read LCD panel state______A
 	char *brightness_up;	//method to set brightness up_______A
@@ -111,6 +114,7 @@ struct asus_hotk {
 	struct acpi_device *device;	//the device we are in
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
+	u32 ledd_status;	//status of the LED display
 	struct model_data *methods;	//methods available on the laptop
 	u8 brightness;		//brightness level
 	enum {
@@ -131,7 +135,8 @@ struct asus_hotk {
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
-		xxN,		//M2400N, M3700N, M5200N, S1300N, S5200N, W1OOON
+		W1N,		//W1000N
+		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
 		END_MODEL
 	} model;		//Models currently supported
@@ -345,6 +350,18 @@ static struct model_data model_conf[END_
 	 .brightness_down =3D S2x_PREFIX "_Q0A"},
=20
 	{
+	 .name =3D "W1N",
+	 .mt_mled =3D "MLED",
+	 .mt_wled =3D "WLED",
+	 .mt_ledd =3D "SLCM",
+	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\BKLT",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\ADVG"},
+
+	{
 	 .name =3D "xxN",
 	 .mt_mled =3D "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -563,6 +580,36 @@ proc_write_mled(struct file *file, const
 }
=20
 /*
+ * Proc handlers for LED display
+ */
+static int
+proc_read_ledd(char *page, char **start, off_t off, int count, int *eo=
f,
+	       void *data)
+{
+	return sprintf(page, "0x%08x\n", hotk->ledd_status);
+}
+
+static int
+proc_write_ledd(struct file *file, const char __user * buffer,
+		unsigned long count, void *data)
+{
+	int value;
+
+	count =3D parse_arg(buffer, count, &value);
+	if (count > 0) {
+		if (!write_acpi_int
+		    (hotk->handle, hotk->methods->mt_ledd, value, NULL))
+			printk(KERN_WARNING
+			       "Asus ACPI: LED display write failed\n");
+		else
+			hotk->ledd_status =3D (u32) value;
+	} else if (count < 0)
+		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
+
+	return count;
+}
+
+/*
  * Proc handlers for WLED
  */
 static int
@@ -876,6 +923,11 @@ static int __init asus_hotk_add_fs(struc
 			      mode, device);
 	}
=20
+	if (hotk->methods->mt_ledd) {
+		asus_proc_add(PROC_LEDD, &proc_write_ledd, &proc_read_ledd,
+			      mode, device);
+	}
+
 	if (hotk->methods->mt_mled) {
 		asus_proc_add(PROC_MLED, &proc_write_mled, &proc_read_mled,
 			      mode, device);
@@ -919,6 +971,8 @@ static int asus_hotk_remove_fs(struct ac
 			remove_proc_entry(PROC_MLED, acpi_device_dir(device));
 		if (hotk->methods->mt_tled)
 			remove_proc_entry(PROC_TLED, acpi_device_dir(device));
+		if (hotk->methods->mt_ledd)
+			remove_proc_entry(PROC_LEDD, acpi_device_dir(device));
 		if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status)
 			remove_proc_entry(PROC_LCD, acpi_device_dir(device));
 		if ((hotk->methods->brightness_up
@@ -1046,8 +1100,7 @@ static int __init asus_hotk_get_info(voi
 		 strncmp(model->string.pointer, "M5N", 3) =3D=3D 0 ||
 		 strncmp(model->string.pointer, "M6N", 3) =3D=3D 0 ||
 		 strncmp(model->string.pointer, "S1N", 3) =3D=3D 0 ||
-		 strncmp(model->string.pointer, "S5N", 3) =3D=3D 0 ||
-		 strncmp(model->string.pointer, "W1N", 3) =3D=3D 0)
+		 strncmp(model->string.pointer, "S5N", 3) =3D=3D 0)
 		hotk->model =3D xxN;
 	else if (strncmp(model->string.pointer, "M1", 2) =3D=3D 0)
 		hotk->model =3D M1A;
@@ -1068,6 +1121,8 @@ static int __init asus_hotk_get_info(voi
 		hotk->model =3D S2x;
 	else if (strncmp(model->string.pointer, "L5", 2) =3D=3D 0)
 		hotk->model =3D L5x;
+	else if (strncmp(model->string.pointer, "W1N", 3) =3D=3D 0)
+		hotk->model =3D W1N;
=20
 	if (hotk->model =3D=3D END_MODEL) {
 		printk("unsupported, trying default values, supply the "
@@ -1091,10 +1146,9 @@ static int __init asus_hotk_get_info(voi
 		 strncmp(model->string.pointer, "M5N", 3) =3D=3D 0)
 		hotk->methods->mt_mled =3D NULL;
 	/* S5N and M5N have no MLED */
-	else if (strncmp(model->string.pointer, "M2N", 3) =3D=3D 0 ||
-		 strncmp(model->string.pointer, "W1N", 3) =3D=3D 0)
+	else if (strncmp(model->string.pointer, "M2N", 3) =3D=3D 0)
 		hotk->methods->mt_wled =3D "WLED";
-	/* M2N and W1N have a usable WLED */
+	/* M2N has a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) =3D=3D 0)
 			hotk->methods->mled_status =3D NULL;
@@ -1184,6 +1238,9 @@ static int __init asus_hotk_add(struct a
 		}
 	}
=20
+	/* LED display is off by default */
+	hotk->ledd_status =3D 0xFFF;
+
       end:
 	if (result) {
 		kfree(hotk);
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
