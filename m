From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 4/4] acpi4asus update: make hotk struct global
Date: Thu, 9 Sep 2004 00:54:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908225415.GD9953@hell.org.pl>
References: <20040908223807.GA9953@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040908224831.GC9953-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
This patch makes the hotk struct used throughout the driver a global
variable. This cleans the code up a bit, but mainly allows most functions
to be called externally when need (read: video driver) arises.
Please apply, TIA

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

Index: asus_core.c
===================================================================
RCS file: /cvsroot/acpi4asus/acpi4asus/driver/asus_core.c,v
retrieving revision 1.106
retrieving revision 1.107
diff -u -r1.106 -r1.107
--- a/drivers/acpi/asus_acpi.c	7 Sep 2004 23:00:29 -0000	1.106
+++ b/drivers/acpi/asus_acpi.c	8 Sep 2004 22:18:26 -0000	1.107
@@ -390,6 +390,9 @@
  */
 static struct acpi_table_header *asus_info;
 
+/* The actual device the driver binds to */
+static struct asus_hotk *hotk;
+
 /*
  * The hotkey driver declaration
  */
@@ -454,7 +457,6 @@
 {
 	int len = 0;
 	int temp;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	char buf[16];		//enough for all info
 	/*
 	 * We use the easy way, we don't care of off and count, so we don't set eof
@@ -513,7 +515,7 @@
 
 /* Generic LED functions */
 static int
-read_led(struct asus_hotk *hotk, const char *ledname, int ledmask)
+read_led(const char *ledname, int ledmask)
 {
 	if (ledname) {
 		int led_status;
@@ -544,7 +546,7 @@
 
 /* FIXME: kill extraneous args so it can be called independently */
 static int
-write_led(const char __user *buffer, unsigned long count, struct asus_hotk *hotk, 
+write_led(const char __user *buffer, unsigned long count,
           char *ledname, int ledmask, int invert)
 {
 	int value;
@@ -574,8 +576,7 @@
 proc_read_mled(char *page, char **start, off_t off, int count, int *eof,
 	       void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->mled_status, MLED_ON));
+	return sprintf(page, "%d\n", read_led(hotk->methods->mled_status, MLED_ON));
 }
 
 
@@ -583,8 +584,7 @@
 proc_write_mled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return write_led(buffer, count, hotk, hotk->methods->mt_mled, MLED_ON, 1);
+	return write_led(buffer, count, hotk->methods->mt_mled, MLED_ON, 1);
 }
 
 /*
@@ -594,16 +594,14 @@
 proc_read_wled(char *page, char **start, off_t off, int count, int *eof,
 	       void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->wled_status, WLED_ON));
+	return sprintf(page, "%d\n", read_led(hotk->methods->wled_status, WLED_ON));
 }
 
 static int
 proc_write_wled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return write_led(buffer, count, hotk, hotk->methods->mt_wled, WLED_ON, 0);
+	return write_led(buffer, count, hotk->methods->mt_wled, WLED_ON, 0);
 }
 
 /*
@@ -613,20 +611,18 @@
 proc_read_tled(char *page, char **start, off_t off, int count, int *eof,
 	       void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->tled_status, TLED_ON));
+	return sprintf(page, "%d\n", read_led(hotk->methods->tled_status, TLED_ON));
 }
 
 static int
 proc_write_tled(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return write_led(buffer, count, hotk, hotk->methods->mt_tled, TLED_ON, 0);
+	return write_led(buffer, count, hotk->methods->mt_tled, TLED_ON, 0);
 }
 
 
-static int get_lcd_state(struct asus_hotk *hotk)
+static int get_lcd_state(void)
 {
 	int lcd = 0;
 
@@ -667,13 +663,13 @@
 	return (lcd & 1);
 }
 
-static int set_lcd_state(struct asus_hotk *hotk, int value)
+static int set_lcd_state(int value)
 {
 	int lcd = 0;
 	acpi_status status = 0;
 
 	lcd = value ? 1 : 0;
-	if (lcd != get_lcd_state(hotk)) {
+	if (lcd != get_lcd_state()) {
 		/* switch */
 		if (hotk->model != L3H) {
 			status =
@@ -696,7 +692,7 @@
 proc_read_lcd(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	return sprintf(page, "%d\n", get_lcd_state((struct asus_hotk *) data));
+	return sprintf(page, "%d\n", get_lcd_state());
 }
 
 
@@ -705,16 +701,15 @@
 	       unsigned long count, void *data)
 {
 	int value;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	
 	count = parse_arg(buffer, count, &value);
 	if (count > 0)
-		set_lcd_state(hotk, value);
+		set_lcd_state(value);
 	return count;
 }
 
 
-static int read_brightness(struct asus_hotk *hotk)
+static int read_brightness(void)
 {
 	int value;
 	
@@ -734,7 +729,7 @@
 /*
  * Change the brightness level
  */
-static void set_brightness(int value, struct asus_hotk *hotk)
+static void set_brightness(int value)
 {
 	acpi_status status = 0;
 
@@ -747,7 +742,7 @@
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= read_brightness(hotk);
+	value -= read_brightness();
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ? 
 					      hotk->methods->brightness_up : 
@@ -764,8 +759,7 @@
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	return sprintf(page, "%d\n", read_brightness(hotk));
+	return sprintf(page, "%d\n", read_brightness());
 }
 
 static int
@@ -773,13 +767,12 @@
 	       unsigned long count, void *data)
 {
 	int value;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
 	count = parse_arg(buffer, count, &value);
 	if (count > 0) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 			/* 0 <= value <= 15 */
-		set_brightness(value, hotk);
+		set_brightness(value);
 	} else if (count < 0) {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
@@ -787,7 +780,7 @@
 	return count;
 }
 
-static void set_display(int value, struct asus_hotk *hotk)
+static void set_display(int value)
 {
 	/* no sanity check needed for now */
 	if (!write_acpi_int(hotk->handle, hotk->methods->display_set, 
@@ -805,7 +798,6 @@
 	      void *data)
 {
 	int value = 0;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	
 	if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
 		printk(KERN_WARNING "Asus ACPI: Error reading display status\n");
@@ -824,11 +816,10 @@
 	       unsigned long count, void *data)
 {
 	int value;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
 	count = parse_arg(buffer, count, &value);
 	if (count > 0)
-		set_display(value, hotk);
+		set_display(value);
 	else if (count < 0)
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 
@@ -863,7 +854,6 @@
 static int __init asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
-	struct asus_hotk *hotk = acpi_driver_data(device);
 	mode_t mode;
 	
 	/*
@@ -928,9 +918,6 @@
 
 static int asus_hotk_remove_fs(struct acpi_device* device)
 {
-	struct asus_hotk* hotk = acpi_driver_data(device);
-
-
 	if(acpi_device_dir(device)) {
 		remove_proc_entry(PROC_INFO,acpi_device_dir(device));
 		if (hotk->methods->mt_wled)
@@ -953,11 +940,7 @@
 
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
-	/* TODO Find a better way to handle events count. Here, in data, we receive
-	 * the hotk, so we can do anything!
-	 */
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-
+	/* TODO Find a better way to handle events count.*/
 	if (!hotk)
 		return;
 
@@ -977,7 +960,7 @@
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
-static int __init asus_hotk_get_info(struct asus_hotk *hotk)
+static int __init asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1113,19 +1096,16 @@
 }
 
 
-static int __init asus_hotk_check(struct asus_hotk *hotk)
+static int __init asus_hotk_check(void)
 {
 	int result = 0;
 
-	if (!hotk)
-		return(-EINVAL);
-
 	result = acpi_bus_get_status(hotk->device);
 	if (result)
 		return(result);
 
 	if (hotk->device->status.present) {
-		result = asus_hotk_get_info(hotk);
+		result = asus_hotk_get_info();
 	} else {
 		printk(KERN_ERR "  Hotkey device not present, aborting\n");
 		return(-EINVAL);
@@ -1137,7 +1117,6 @@
 
 static int __init asus_hotk_add(struct acpi_device *device)
 {
-	struct asus_hotk *hotk = NULL;
 	acpi_status status = AE_OK;
 	int result;
 
@@ -1160,7 +1139,7 @@
 	hotk->device = device;
 
 
-	result = asus_hotk_check(hotk);
+	result = asus_hotk_check();
 	if (result)
 		goto end;
 
@@ -1205,13 +1184,10 @@
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = 0;
-	struct asus_hotk *hotk = NULL;
 
 	if (!device || !acpi_driver_data(device))
 		return(-EINVAL);
 
-	hotk = (struct asus_hotk *) acpi_driver_data(device);
-
 	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
 					    asus_hotk_notify);
 	if (ACPI_FAILURE(status))
 
-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
