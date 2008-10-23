From: Len Brown <lenb@kernel.org>
Subject: [PATCH 062/122] asus_acpi: whitespace and comment cleanup
Date: Thu, 23 Oct 2008 02:38:36 -0400
Message-ID: <c6c38bac2608b0f439b9ede72394780fe7fe1951.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbYJWGkL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KAUIITS8A2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:06 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mike Dahlgren <dahlgren@gmail.com>, Len Brown <len.brown@intel.com>

From: Mike Dahlgren <dahlgren@gmail.com>

Signed-off-by: Mike Dahlgren <dahlgren@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |  221 +++++++++++++++++++++++-----------------------
 1 files changed, 110 insertions(+), 111 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index d3d0886..3f7adf6 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -42,7 +42,7 @@
 
 #define ASUS_ACPI_VERSION "0.30"
 
-#define PROC_ASUS       "asus"	//the directory
+#define PROC_ASUS       "asus"	/* The directory */
 #define PROC_MLED       "mled"
 #define PROC_WLED       "wled"
 #define PROC_TLED       "tled"
@@ -66,10 +66,10 @@
 /*
  * Flags for hotk status
  */
-#define MLED_ON     0x01	//mail LED
-#define WLED_ON     0x02	//wireless LED
-#define TLED_ON     0x04	//touchpad LED
-#define BT_ON       0x08	//internal Bluetooth
+#define MLED_ON     0x01	/* Mail LED */
+#define WLED_ON     0x02	/* Wireless LED */
+#define TLED_ON     0x04	/* Touchpad LED */
+#define BT_ON       0x08	/* Internal Bluetooth */
 
 MODULE_AUTHOR("Julien Lerouge, Karol Kozimor");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
@@ -82,28 +82,28 @@ MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus");
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus");
 
-/* For each model, all features implemented, 
+/* For each model, all features implemented,
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
-	char *name;		//name of the laptop________________A
-	char *mt_mled;		//method to handle mled_____________R
-	char *mled_status;	//node to handle mled reading_______A
-	char *mt_wled;		//method to handle wled_____________R
-	char *wled_status;	//node to handle wled reading_______A
-	char *mt_tled;		//method to handle tled_____________R
-	char *tled_status;	//node to handle tled reading_______A
-	char *mt_ledd;		//method to handle LED display______R
-	char *mt_bt_switch;	//method to switch Bluetooth on/off_R
-	char *bt_status;	//no model currently supports this__?
-	char *mt_lcd_switch;	//method to turn LCD on/off_________A
-	char *lcd_status;	//node to read LCD panel state______A
-	char *brightness_up;	//method to set brightness up_______A
-	char *brightness_down;	//guess what ?______________________A
-	char *brightness_set;	//method to set absolute brightness_R
-	char *brightness_get;	//method to get absolute brightness_R
-	char *brightness_status;	//node to get brightness____________A
-	char *display_set;	//method to set video output________R
-	char *display_get;	//method to get video output________R
+	char *name;		/* name of the laptop________________A */
+	char *mt_mled;		/* method to handle mled_____________R */
+	char *mled_status;	/* node to handle mled reading_______A */
+	char *mt_wled;		/* method to handle wled_____________R */
+	char *wled_status;	/* node to handle wled reading_______A */
+	char *mt_tled;		/* method to handle tled_____________R */
+	char *tled_status;	/* node to handle tled reading_______A */
+	char *mt_ledd;		/* method to handle LED display______R */
+	char *mt_bt_switch;	/* method to switch Bluetooth on/off_R */
+	char *bt_status;	/* no model currently supports this__? */
+	char *mt_lcd_switch;	/* method to turn LCD on/off_________A */
+	char *lcd_status;	/* node to read LCD panel state______A */
+	char *brightness_up;	/* method to set brightness up_______A */
+	char *brightness_down;	/* method to set brightness down ____A */
+	char *brightness_set;	/* method to set absolute brightness_R */
+	char *brightness_get;	/* method to get absolute brightness_R */
+	char *brightness_status;/* node to get brightness____________A */
+	char *display_set;	/* method to set video output________R */
+	char *display_get;	/* method to get video output________R */
 };
 
 /*
@@ -111,41 +111,41 @@ struct model_data {
  * about the hotk device
  */
 struct asus_hotk {
-	struct acpi_device *device;	//the device we are in
-	acpi_handle handle;	//the handle of the hotk device
-	char status;		//status of the hotk, for LEDs, ...
-	u32 ledd_status;	//status of the LED display
-	struct model_data *methods;	//methods available on the laptop
-	u8 brightness;		//brightness level
+	struct acpi_device *device;	/* the device we are in */
+	acpi_handle handle;		/* the handle of the hotk device */
+	char status;			/* status of the hotk, for LEDs */
+	u32 ledd_status;		/* status of the LED display */
+	struct model_data *methods;	/* methods available on the laptop */
+	u8 brightness;			/* brightness level */
 	enum {
-		A1x = 0,	//A1340D, A1300F
-		A2x,		//A2500H
-		A4G,		//A4700G
-		D1x,		//D1
-		L2D,		//L2000D
-		L3C,		//L3800C
-		L3D,		//L3400D
-		L3H,		//L3H, L2000E, L5D
-		L4R,		//L4500R
-		L5x,		//L5800C 
-		L8L,		//L8400L
-		M1A,		//M1300A
-		M2E,		//M2400E, L4400L
-		M6N,		//M6800N, W3400N
-		M6R,		//M6700R, A3000G
-		P30,		//Samsung P30
-		S1x,		//S1300A, but also L1400B and M2400A (L84F)
-		S2x,		//S200 (J1 reported), Victor MP-XP7210
-		W1N,		//W1000N
-		W5A,		//W5A
-		W3V,            //W3030V
-		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
-		A4S,            //Z81sp
-		//(Centrino)
-		F3Sa,
+		A1x = 0,	/* A1340D, A1300F */
+		A2x,		/* A2500H */
+		A4G,		/* A4700G */
+		D1x,		/* D1 */
+		L2D,		/* L2000D */
+		L3C,		/* L3800C */
+		L3D,		/* L3400D */
+		L3H,		/* L3H, L2000E, L5D */
+		L4R,		/* L4500R */
+		L5x,		/* L5800C */
+		L8L,		/* L8400L */
+		M1A,		/* M1300A */
+		M2E,		/* M2400E, L4400L */
+		M6N,		/* M6800N, W3400N */
+		M6R,		/* M6700R, A3000G */
+		P30,		/* Samsung P30 */
+		S1x,		/* S1300A, but also L1400B and M2400A (L84F) */
+		S2x,		/* S200 (J1 reported), Victor MP-XP7210 */
+		W1N,		/* W1000N */
+		W5A,		/* W5A */
+		W3V,            /* W3030V */
+		xxN,		/* M2400N, M3700N, M5200N, M6800N,
+							 S1300N, S5200N*/
+		A4S,            /* Z81sp */
+		F3Sa,		/* (Centrino) */
 		END_MODEL
-	} model;		//Models currently supported
-	u16 event_count[128];	//count for each event TODO make this better
+	} model;		/* Models currently supported */
+	u16 event_count[128];	/* Count for each event TODO make this better */
 };
 
 /* Here we go */
@@ -459,18 +459,18 @@ static struct acpi_driver asus_hotk_driver = {
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
 {
-	struct acpi_object_list params;	//list of input parameters (an int here)
-	union acpi_object in_obj;	//the only param we use
+	struct acpi_object_list params;	/* list of input parameters (int) */
+	union acpi_object in_obj;	/* the only param we use */
 	acpi_status status;
 
 	params.count = 1;
@@ -507,18 +507,18 @@ proc_read_info(char *page, char **start, off_t off, int count, int *eof,
 {
 	int len = 0;
 	int temp;
-	char buf[16];		//enough for all info
+	char buf[16];		/* enough for all info */
 	/*
-	 * We use the easy way, we don't care of off and count, so we don't set eof
-	 * to 1
+	 * We use the easy way, we don't care of off and count,
+	 * so we don't set eof to 1
 	 */
 
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
@@ -528,7 +528,7 @@ proc_read_info(char *page, char **start, off_t off, int count, int *eof,
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
 	 * battery low and 0x04 for battery critical, its readings tend to be
-	 * more accurate than those provided by _BST. 
+	 * more accurate than those provided by _BST.
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
 	 */
@@ -579,7 +579,7 @@ static int read_led(const char *ledname, int ledmask)
 	return (hotk->status & ledmask) ? 1 : 0;
 }
 
-static int parse_arg(const char __user * buf, unsigned long count, int *val)
+static int parse_arg(const char __user *buf, unsigned long count, int *val)
 {
 	char s[32];
 	if (!count)
@@ -596,7 +596,7 @@ static int parse_arg(const char __user * buf, unsigned long count, int *val)
 
 /* FIXME: kill extraneous args so it can be called independently */
 static int
-write_led(const char __user * buffer, unsigned long count,
+write_led(const char __user *buffer, unsigned long count,
 	  char *ledname, int ledmask, int invert)
 {
 	int rv, value;
@@ -631,7 +631,7 @@ proc_read_mled(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_mled(struct file *file, const char __user * buffer,
+proc_write_mled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
 	return write_led(buffer, count, hotk->methods->mt_mled, MLED_ON, 1);
@@ -648,7 +648,7 @@ proc_read_ledd(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_ledd(struct file *file, const char __user * buffer,
+proc_write_ledd(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
 	int rv, value;
@@ -677,7 +677,7 @@ proc_read_wled(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_wled(struct file *file, const char __user * buffer,
+proc_write_wled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
 	return write_led(buffer, count, hotk->methods->mt_wled, WLED_ON, 0);
@@ -694,10 +694,10 @@ proc_read_bluetooth(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_bluetooth(struct file *file, const char __user * buffer,
+proc_write_bluetooth(struct file *file, const char __user *buffer,
 		     unsigned long count, void *data)
 {
-	/* Note: mt_bt_switch controls both internal Bluetooth adapter's 
+	/* Note: mt_bt_switch controls both internal Bluetooth adapter's
 	   presence and its LED */
 	return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 0);
 }
@@ -714,7 +714,7 @@ proc_read_tled(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_tled(struct file *file, const char __user * buffer,
+proc_write_tled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
 	return write_led(buffer, count, hotk->methods->mt_tled, TLED_ON, 0);
@@ -734,7 +734,7 @@ static int get_lcd_state(void)
 
 		input.count = 2;
 		input.pointer = mt_params;
-		/* Note: the following values are partly guessed up, but 
+		/* Note: the following values are partly guessed up, but
 		   otherwise they seem to work */
 		mt_params[0].type = ACPI_TYPE_INTEGER;
 		mt_params[0].integer.value = 0x02;
@@ -796,12 +796,13 @@ static int set_lcd_state(int value)
 			    acpi_evaluate_object(NULL,
 						 hotk->methods->mt_lcd_switch,
 						 NULL, NULL);
-		} else {	/* L3H and the like have to be handled differently */
+		} else {
+			/* L3H and the like must be handled differently */
 			if (!write_acpi_int
 			    (hotk->handle, hotk->methods->mt_lcd_switch, 0x07,
 			     NULL))
 				status = AE_ERROR;
-			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress, 
+			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,
 			   the exact behaviour is simulated here */
 		}
 		if (ACPI_FAILURE(status))
@@ -819,7 +820,7 @@ proc_read_lcd(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_lcd(struct file *file, const char __user * buffer,
+proc_write_lcd(struct file *file, const char __user *buffer,
 	       unsigned long count, void *data)
 {
 	int rv, value;
@@ -897,7 +898,7 @@ proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 }
 
 static int
-proc_write_brn(struct file *file, const char __user * buffer,
+proc_write_brn(struct file *file, const char __user *buffer,
 	       unsigned long count, void *data)
 {
 	int rv, value;
@@ -921,7 +922,7 @@ static void set_display(int value)
 }
 
 /*
- * Now, *this* one could be more user-friendly, but so far, no-one has 
+ * Now, *this* one could be more user-friendly, but so far, no-one has
  * complained. The significance of bits is the same as in proc_write_disp()
  */
 static int
@@ -933,18 +934,18 @@ proc_read_disp(char *page, char **start, off_t off, int count, int *eof,
 	if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
 		printk(KERN_WARNING
 		       "Asus ACPI: Error reading display status\n");
-	value &= 0x07;		/* needed for some models, shouldn't hurt others */
+	value &= 0x07;	/* needed for some models, shouldn't hurt others */
 	return sprintf(page, "%d\n", value);
 }
 
 /*
- * Experimental support for display switching. As of now: 1 should activate 
- * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination 
- * (bitwise) of these will suffice. I never actually tested 3 displays hooked up 
- * simultaneously, so be warned. See the acpi4asus README for more info.
+ * Experimental support for display switching. As of now: 1 should activate
+ * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination
+ * (bitwise) of these will suffice. I never actually tested 3 displays hooked
+ * up simultaneously, so be warned. See the acpi4asus README for more info.
  */
 static int
-proc_write_disp(struct file *file, const char __user * buffer,
+proc_write_disp(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
 	int rv, value;
@@ -957,12 +958,12 @@ proc_write_disp(struct file *file, const char __user * buffer,
 
 typedef int (proc_readfunc) (char *page, char **start, off_t off, int count,
 			     int *eof, void *data);
-typedef int (proc_writefunc) (struct file * file, const char __user * buffer,
+typedef int (proc_writefunc) (struct file *file, const char __user *buffer,
 			      unsigned long count, void *data);
 
 static int
-asus_proc_add(char *name, proc_writefunc * writefunc,
-		     proc_readfunc * readfunc, mode_t mode,
+asus_proc_add(char *name, proc_writefunc *writefunc,
+		     proc_readfunc *readfunc, mode_t mode,
 		     struct acpi_device *device)
 {
 	struct proc_dir_entry *proc =
@@ -1040,9 +1041,9 @@ static int asus_hotk_add_fs(struct acpi_device *device)
 			      &proc_read_bluetooth, mode, device);
 	}
 
-	/* 
-	 * We need both read node and write method as LCD switch is also accessible
-	 * from keyboard 
+	/*
+	 * We need both read node and write method as LCD switch is also
+	 * accessible from the keyboard
 	 */
 	if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
 		asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode,
@@ -1096,11 +1097,10 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 	if (!hotk)
 		return;
 
-	if ((event & ~((u32) BR_UP)) < 16) {
+	if ((event & ~((u32) BR_UP)) < 16)
 		hotk->brightness = (event & ~((u32) BR_UP));
-	} else if ((event & ~((u32) BR_DOWN)) < 16) {
+	else if ((event & ~((u32) BR_DOWN)) < 16)
 		hotk->brightness = (event & ~((u32) BR_DOWN));
-	}
 
 	acpi_bus_generate_proc_event(hotk->device, event,
 				hotk->event_count[event % 128]++);
@@ -1186,8 +1186,8 @@ static int asus_hotk_get_info(void)
 	acpi_status status;
 
 	/*
-	 * Get DSDT headers early enough to allow for differentiating between 
-	 * models, but late enough to allow acpi_bus_register_driver() to fail 
+	 * Get DSDT headers early enough to allow for differentiating between
+	 * models, but late enough to allow acpi_bus_register_driver() to fail
 	 * before doing anything ACPI-specific. Should we encounter a machine,
 	 * which needs special handling (i.e. its hotkey device has a different
 	 * HID), this bit will be moved. A global variable asus_info contains
@@ -1212,8 +1212,8 @@ static int asus_hotk_get_info(void)
 
 	/*
 	 * Try to match the object returned by INIT to the specific model.
-	 * Handle every possible object (or the lack of thereof) the DSDT 
-	 * writers might throw at us. When in trouble, we pass NULL to 
+	 * Handle every possible object (or the lack of thereof) the DSDT
+	 * writers might throw at us. When in trouble, we pass NULL to
 	 * asus_model_match() and try something completely different.
 	 */
 	if (buffer.pointer) {
@@ -1254,7 +1254,7 @@ static int asus_hotk_get_info(void)
 	/* Sort of per-model blacklist */
 	if (strncmp(string, "L2B", 3) == 0)
 		hotk->methods->lcd_status = NULL;
-	/* L2B is similar enough to L3C to use its settings, with this only 
+	/* L2B is similar enough to L3C to use its settings, with this only
 	   exception */
 	else if (strncmp(string, "A3G", 3) == 0)
 		hotk->methods->lcd_status = "\\BLFG";
@@ -1366,10 +1366,9 @@ static int asus_hotk_add(struct acpi_device *device)
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
 
-      end:
-	if (result) {
+end:
+	if (result)
 		kfree(hotk);
-	}
 
 	return result;
 }
@@ -1394,8 +1393,8 @@ static int asus_hotk_remove(struct acpi_device *device, int type)
 }
 
 static struct backlight_ops asus_backlight_data = {
-        .get_brightness = read_brightness,
-        .update_status  = set_brightness_status,
+	.get_brightness = read_brightness,
+	.update_status  = set_brightness_status,
 };
 
 static void asus_acpi_exit(void)
@@ -1442,15 +1441,15 @@ static int __init asus_acpi_init(void)
 		return -ENODEV;
 	}
 
-	asus_backlight_device = backlight_device_register("asus",NULL,NULL,
+	asus_backlight_device = backlight_device_register("asus", NULL, NULL,
 							  &asus_backlight_data);
-        if (IS_ERR(asus_backlight_device)) {
+	if (IS_ERR(asus_backlight_device)) {
 		printk(KERN_ERR "Could not register asus backlight device\n");
 		asus_backlight_device = NULL;
 		asus_acpi_exit();
 		return -ENODEV;
 	}
-        asus_backlight_device->props.max_brightness = 15;
+	asus_backlight_device->props.max_brightness = 15;
 
 	return 0;
 }
-- 
1.5.5.1

