From: akpm@osdl.org
Subject: [patch 13/13] Add support for ASUS A6VA, M6V, W5F, V6V laptops in asus-acpi
Date: Mon, 04 Dec 2006 14:49:46 -0800
Message-ID: <200612042250.kB4MotGq007391@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:50337 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967727AbWLDWvy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, papadako@gmail.com, thoenig@suse.de

From: "Panagiotis Papadakos" <papadako@gmail.com>

This patch is based on
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg02277.html
and adds support for ASUS A6VA, M6V, W5F and V6V laptops in asus-acpi.
Also some trailing spaces cleanups.

Cc: Timo Hoenig <thoenig@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |  137 ++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 33 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~add-support-for-asus-a6va-m6v-w5f-v6v-laptops-in-asus-acpi drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~add-support-for-asus-a6va-m6v-w5f-v6v-laptops-in-asus-acpi
+++ a/drivers/acpi/asus_acpi.c
@@ -83,7 +83,7 @@ MODULE_PARM_DESC(asus_uid, "UID for entr
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
 
-/* For each model, all features implemented, 
+/* For each model, all features implemented,
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
 	char *name;		//name of the laptop________________A
@@ -122,24 +122,28 @@ struct asus_hotk {
 		A1x = 0,	//A1340D, A1300F
 		A2x,		//A2500H
 		A4G,		//A4700G
+		A6VA,           //A6VA
 		D1x,		//D1
 		L2D,		//L2000D
 		L3C,		//L3800C
 		L3D,		//L3400D
 		L3H,		//L3H, L2000E, L5D
 		L4R,		//L4500R
-		L5x,		//L5800C 
+		L5x,		//L5800C
 		L8L,		//L8400L
 		M1A,		//M1300A
 		M2E,		//M2400E, L4400L
 		M6N,		//M6800N, W3400N
 		M6R,		//M6700R, A3000G
+		M6V,            //M6A, M6V-B022P, M6V-8012P
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
 		W1N,		//W1000N
-		W5A,		//W5A
 		W3V,            //W3030V
+		W5A,		//W5A
+		W5F,            //W5F
+		V6V,            //V6V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
 		END_MODEL
@@ -194,6 +198,17 @@ static struct model_data model_conf[END_
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "A6VA",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = "\\Q11",
+	 .lcd_status = "\\RGPL",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\ADVG"},
+
+	{
 	 .name = "D1x",
 	 .mt_mled = "MLED",
 	 .mt_lcd_switch = "\\Q0D",
@@ -326,6 +341,20 @@ static struct model_data model_conf[END_
 	 .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
 
 	{
+	 .name = "M6V",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_mled = NULL,
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .bt_status = "\\_SB.PCI0.SBRG.BLTS",
+	 .lcd_status = "\\RGPL",
+	 .wled_status = "\\WLSF",
+	 .display_get = "\\_SB.PCI0.P0P3.VGA.GETD",
+	 .display_set = "SDSP",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV"},
+
+	{
 	 .name = "P30",
 	 .mt_wled = "WLED",
 	 .mt_lcd_switch = P30_PREFIX "_Q0E",
@@ -368,6 +397,17 @@ static struct model_data model_conf[END_
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "W3V",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .lcd_status = "\\BKLT",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\INFB"},
+
+	{
 	 .name = "W5A",
 	 .mt_bt_switch = "BLED",
 	 .mt_wled = "WLED",
@@ -378,17 +418,30 @@ static struct model_data model_conf[END_
 	 .display_get = "\\ADVG"},
 
 	{
-	 .name = "W3V",
-	 .mt_mled = "MLED",
+	 .name = "W5F",
+	 .mt_bt_switch = "BLED",
 	 .mt_wled = "WLED",
+	 .mt_tled = "TLED",
 	 .mt_lcd_switch = xxN_PREFIX "_Q10",
-	 .lcd_status = "\\BKLT",
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\INFB"},
+	 .display_get = "\\ADVG"},
+
+	{
+	 .name = "V6V",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_tled = "TLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .bt_status = "\\_SB.PCI0.SBRG.BLTS",
+	 .display_get = "\\_SB.PCI0.POP1.VGA.GETD",
+	 .display_set = "SDSP",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .lcd_status = "\\BKLT"},
 
-       {
+	{
 	 .name = "xxN",
 	 .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -430,12 +483,12 @@ static struct acpi_driver asus_hotk_driv
 		},
 };
 
-/* 
+/*
  * This function evaluates an ACPI method, given an int as parameter, the
  * method is searched within the scope of the handle, can be NULL. The output
  * of the method is written is output, which can also be NULL
  *
- * returns 1 if write is successful, 0 else. 
+ * returns 1 if write is successful, 0 else.
  */
 static int write_acpi_int(acpi_handle handle, const char *method, int val,
 			  struct acpi_buffer *output)
@@ -487,9 +540,9 @@ proc_read_info(char *page, char **start,
 	len += sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
 	len += sprintf(page + len, "Model reference    : %s\n",
 		       hotk->methods->name);
-	/* 
-	 * The SFUN method probably allows the original driver to get the list 
-	 * of features supported by a given model. For now, 0x0100 or 0x0800 
+	/*
+	 * The SFUN method probably allows the original driver to get the list
+	 * of features supported by a given model. For now, 0x0100 or 0x0800
 	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI card.
 	 * The significance of others is yet to be found.
 	 */
@@ -499,7 +552,7 @@ proc_read_info(char *page, char **start,
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
 	 * battery low and 0x04 for battery critical, its readings tend to be
-	 * more accurate than those provided by _BST. 
+	 * more accurate than those provided by _BST.
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
 	 */
@@ -668,7 +721,7 @@ static int
 proc_write_bluetooth(struct file *file, const char __user * buffer,
 		     unsigned long count, void *data)
 {
-	/* Note: mt_bt_switch controls both internal Bluetooth adapter's 
+	/* Note: mt_bt_switch controls both internal Bluetooth adapter's
 	   presence and its LED */
 	return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 0);
 }
@@ -695,7 +748,7 @@ static int get_lcd_state(void)
 {
 	int lcd = 0;
 
-	if (hotk->model != L3H) {
+	if (hotk->model != A6VA && hotk->model != M6V && hotk->model != L3H) {
 		/* We don't have to check anything if we are here */
 		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
 			printk(KERN_WARNING
@@ -712,12 +765,18 @@ static int get_lcd_state(void)
 
 		input.count = 2;
 		input.pointer = mt_params;
-		/* Note: the following values are partly guessed up, but 
+		/* Note: the following values are partly guessed up, but
 		   otherwise they seem to work */
 		mt_params[0].type = ACPI_TYPE_INTEGER;
-		mt_params[0].integer.value = 0x02;
 		mt_params[1].type = ACPI_TYPE_INTEGER;
-		mt_params[1].integer.value = 0x02;
+
+		if (hotk->model == A6VA || hotk->model == M6V) {
+			mt_params[0].integer.value = 0x15;
+			mt_params[1].integer.value = 0x01;
+		} else if (hotk->model == L3H) {
+			mt_params[0].integer.value = 0x02;
+			mt_params[1].integer.value = 0x02;
+		}
 
 		output.length = sizeof(out_obj);
 		output.pointer = &out_obj;
@@ -727,9 +786,13 @@ static int get_lcd_state(void)
 					 &input, &output);
 		if (status != AE_OK)
 			return -1;
-		if (out_obj.type == ACPI_TYPE_INTEGER)
+		if (out_obj.type == ACPI_TYPE_INTEGER) {
 			/* That's what the AML code does */
-			lcd = out_obj.integer.value >> 8;
+			if (hotk->model == A6VA || hotk->model == M6V)
+				lcd = out_obj.integer.value;
+			else if (hotk->model == L3H)
+				lcd = out_obj.integer.value >> 8;
+		}
 	}
 
 	return (lcd & 1);
@@ -753,7 +816,7 @@ static int set_lcd_state(int value)
 			    (hotk->handle, hotk->methods->mt_lcd_switch, 0x07,
 			     NULL))
 				status = AE_ERROR;
-			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress, 
+			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,
 			   the exact behaviour is simulated here */
 		}
 		if (ACPI_FAILURE(status))
@@ -873,7 +936,7 @@ static void set_display(int value)
 }
 
 /*
- * Now, *this* one could be more user-friendly, but so far, no-one has 
+ * Now, *this* one could be more user-friendly, but so far, no-one has
  * complained. The significance of bits is the same as in proc_write_disp()
  */
 static int
@@ -890,9 +953,9 @@ proc_read_disp(char *page, char **start,
 }
 
 /*
- * Experimental support for display switching. As of now: 1 should activate 
- * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination 
- * (bitwise) of these will suffice. I never actually tested 3 displays hooked up 
+ * Experimental support for display switching. As of now: 1 should activate
+ * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination
+ * (bitwise) of these will suffice. I never actually tested 3 displays hooked up
  * simultaneously, so be warned. See the acpi4asus README for more info.
  */
 static int
@@ -992,9 +1055,9 @@ static int asus_hotk_add_fs(struct acpi_
 			      &proc_read_bluetooth, mode, device);
 	}
 
-	/* 
+	/*
 	 * We need both read node and write method as LCD switch is also accessible
-	 * from keyboard 
+	 * from keyboard
 	 */
 	if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
 		asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode,
@@ -1095,6 +1158,8 @@ static int asus_model_match(char *model)
 		return M1A;
 	else if (strncmp(model, "M2", 2) == 0 || strncmp(model, "L4E", 3) == 0)
 		return M2E;
+	else if (strncmp(model, "M6A", 3) == 0 || strncmp(model, "M6V", 3) == 0)
+		return M6V;
 	else if (strncmp(model, "L2", 2) == 0)
 		return L2D;
 	else if (strncmp(model, "L8", 2) == 0)
@@ -1105,6 +1170,8 @@ static int asus_model_match(char *model)
 		return A1x;
 	else if (strncmp(model, "A2", 2) == 0)
 		return A2x;
+	else if (strncmp(model, "A6VA", 4) == 0)
+		return A6VA;
 	else if (strncmp(model, "J1", 2) == 0)
 		return S2x;
 	else if (strncmp(model, "L5", 2) == 0)
@@ -1117,6 +1184,10 @@ static int asus_model_match(char *model)
 		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
+	else if (strncmp(model, "W5F", 3) == 0)
+		return W5F;
+	else if (strncmp(model, "V6V", 3) == 0)
+		return V6V;
 	else
 		return END_MODEL;
 }
@@ -1135,8 +1206,8 @@ static int asus_hotk_get_info(void)
 	acpi_status status;
 
 	/*
-	 * Get DSDT headers early enough to allow for differentiating between 
-	 * models, but late enough to allow acpi_bus_register_driver() to fail 
+	 * Get DSDT headers early enough to allow for differentiating between
+	 * models, but late enough to allow acpi_bus_register_driver() to fail
 	 * before doing anything ACPI-specific. Should we encounter a machine,
 	 * which needs special handling (i.e. its hotkey device has a different
 	 * HID), this bit will be moved. A global variable asus_info contains
@@ -1163,8 +1234,8 @@ static int asus_hotk_get_info(void)
 
 	/*
 	 * Try to match the object returned by INIT to the specific model.
-	 * Handle every possible object (or the lack of thereof) the DSDT 
-	 * writers might throw at us. When in trouble, we pass NULL to 
+	 * Handle every possible object (or the lack of thereof) the DSDT
+	 * writers might throw at us. When in trouble, we pass NULL to
 	 * asus_model_match() and try something completely different.
 	 */
 	if (buffer.pointer) {
@@ -1204,7 +1275,7 @@ static int asus_hotk_get_info(void)
 	/* Sort of per-model blacklist */
 	if (strncmp(string, "L2B", 3) == 0)
 		hotk->methods->lcd_status = NULL;
-	/* L2B is similar enough to L3C to use its settings, with this only 
+	/* L2B is similar enough to L3C to use its settings, with this only
 	   exception */
 	else if (strncmp(string, "A3G", 3) == 0)
 		hotk->methods->lcd_status = "\\BLFG";
_
