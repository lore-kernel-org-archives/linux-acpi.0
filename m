From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: [PATCH] Toshiba Laptop Extras v0.13
Date: Sat, 24 Aug 2002 19:56:08 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D676648.3060505@prairienet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010005010501010705050000"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010005010501010705050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andy,

Attached is a patch yielding version 0.13 of the Toshiba laptop extras. 
  Changes:

     * Fix sscanf overrun
     * Add TV out support
     * Add hotkey status
     * Add version info

The driver file should now be 2.4 friendly.  Will you accept a patch to 
the ACPI-patched 2.4 kernel adding my driver?

Regards,
-John


-- 
http:// i      .   /

--------------010005010501010705050000
Content-Type: text/plain;
 name="toshiba_acpi_0.13-linux_2.5.26.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.13-linux_2.5.26.patch"

diff -urN linux-2.5.25-toshiba_acpi-old/drivers/acpi/toshiba_acpi.c linux-2.5.25-toshiba_acpi/drivers/acpi/toshiba_acpi.c
--- linux-2.5.25-toshiba_acpi-old/drivers/acpi/toshiba_acpi.c	Wed Aug 21 22:27:21 2002
+++ linux-2.5.25-toshiba_acpi/drivers/acpi/toshiba_acpi.c	Wed Aug 21 21:52:35 2002
@@ -26,15 +26,15 @@
  *	Jonathan A. Buzzard - Toshiba HCI info, and critical tips on reverse
  *		engineering the Windows drivers
  *	Yasushi Nagato - changes for linux kernel 2.4 -> 2.5
+ *	Rob Miller - TV out and hotkeys help
  *
  *
  *  TODO
- *	provide version info in proc
- *	add Fn key status
  *
  */
 
-#define TOSHIBA_ACPI_VERSION "0.12"
+#define TOSHIBA_ACPI_VERSION	"0.13"
+#define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -43,9 +43,10 @@
 #include <linux/proc_fs.h>
 #include <linux/version.h>
 
-#define KERNEL24 (LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0))
+#include <acconfig.h>
+#define OLD_ACPI_INTERFACE (ACPI_CA_VERSION < 0x20020000)
 
-#if KERNEL24
+#if OLD_ACPI_INTERFACE
 #include <acpi.h>
 extern struct proc_dir_entry* bm_proc_root;
 #define acpi_root_dir bm_proc_root
@@ -82,10 +83,13 @@
 #define HCI_SUCCESS			0x0000
 #define HCI_FAILURE			0x1000
 #define HCI_NOT_SUPPORTED		0x8000
+#define HCI_EMPTY			0x8c00
 
 /* registers */
 #define HCI_FAN				0x0004
+#define HCI_SYSTEM_EVENT		0x0016
 #define HCI_VIDEO_OUT			0x001c
+#define HCI_HOTKEY_EVENT		0x001e
 #define HCI_LCD_BRIGHTNESS		0x002a
 
 /* field definitions */
@@ -94,6 +98,7 @@
 #define HCI_LCD_BRIGHTNESS_LEVELS	(1 << HCI_LCD_BRIGHTNESS_BITS)
 #define HCI_VIDEO_OUT_LCD		0x1
 #define HCI_VIDEO_OUT_CRT		0x2
+#define HCI_VIDEO_OUT_TV		0x4
 
 /* utility
  */
@@ -104,6 +109,23 @@
 	*word = (*word & ~mask) | (mask * value);
 }
 
+/* an sscanf that takes explicit string length */
+static int
+snscanf(const char* str, int n, const char* format, ...)
+{
+	va_list args;
+	int result;
+	char* str2 = kmalloc(n + 1, GFP_KERNEL);
+	if (str2 == 0) return 0;
+	strncpy(str2, str, n);
+	str2[n] = 0;
+	va_start(args, format);
+	result = vsscanf(str2, format, args);
+	va_end(args);
+	kfree(str2);
+	return result;
+}
+
 /* This is the common code at the end of every proc read handler.  I don't
  * understand it yet.
  */
@@ -226,14 +248,15 @@
 #define PROC_LCD		"lcd"
 #define PROC_VIDEO		"video"
 #define PROC_FAN		"fan"
+#define PROC_KEYS		"keys"
+#define PROC_VERSION		"version"
 
 static struct proc_dir_entry*	toshiba_proc_dir = NULL;
 static int			force_fan;
+static int			last_key_event;
+static int			key_event_valid;
 
 /* proc file handlers
- *
- * WARNING: The write handlers are using sscanf on non-zero-terminated
- * buffers.  This may result in memory reads past the buffer bounds.
  */
 
 static int
@@ -270,7 +293,7 @@
 	u32 hci_result;
 
 	/* ISSUE: %i doesn't work with hex values as advertised */
-	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
+	if (snscanf(buffer, count, " brightness : %i", &value) == 1 &&
 			value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
 		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
@@ -297,8 +320,10 @@
 	if (hci_result == HCI_SUCCESS) {
 		int is_lcd = (value & HCI_VIDEO_OUT_LCD) ? 1 : 0;
 		int is_crt = (value & HCI_VIDEO_OUT_CRT) ? 1 : 0;
+		int is_tv  = (value & HCI_VIDEO_OUT_TV ) ? 1 : 0;
 		p += sprintf(p, "lcd_out:                 %d\n", is_lcd);
 		p += sprintf(p, "crt_out:                 %d\n", is_crt);
+		p += sprintf(p, "tv_out:                  %d\n", is_tv);
 	} else {
 		p += sprintf(p, "ERROR\n");
 		goto end;
@@ -316,15 +341,18 @@
 	const char* buffer_end = buffer + count;
 	int lcd_out = -1;
 	int crt_out = -1;
+	int tv_out = -1;
 	u32 hci_result;
 	int video_out;
 
 	/* scan expression.  Multiple expressions may be delimited with ; */
 	do {
-		if (sscanf(buffer, " lcd_out : %i", &value) == 1)
+		if (snscanf(buffer, count, " lcd_out : %i", &value) == 1)
 			lcd_out = value & 1;
-		else if (sscanf(buffer, " crt_out : %i", &value) == 1)
+		else if (snscanf(buffer, count, " crt_out : %i", &value) == 1)
 			crt_out = value & 1;
+		else if (snscanf(buffer, count, " tv_out : %i", &value) == 1)
+			tv_out = value & 1;
 		/* advance to one character past the next ; */
 		do ++buffer;
 		while ((buffer < buffer_end) && (*(buffer-1) != ';'));
@@ -337,6 +365,8 @@
 			_set_bit(&new_video_out, HCI_VIDEO_OUT_LCD, lcd_out);
 		if (crt_out != -1)
 			_set_bit(&new_video_out, HCI_VIDEO_OUT_CRT, crt_out);
+		if (tv_out != -1)
+			_set_bit(&new_video_out, HCI_VIDEO_OUT_TV, tv_out);
 		/* To avoid unnecessary video disruption, only write the new
 		 * video setting if something changed. */
 		if (new_video_out != video_out)
@@ -376,7 +406,7 @@
 	int value;
 	u32 hci_result;
 
-	if (sscanf(buffer, " force_on : %i", &value) == 1 &&
+	if (snscanf(buffer, count, " force_on : %i", &value) == 1 &&
 			value >= 0 && value <= 1) {
 		hci_write1(HCI_FAN, value, &hci_result);
 		if (hci_result != HCI_SUCCESS)
@@ -390,6 +420,68 @@
 	return count;
 }
 
+static int
+proc_read_keys(char* page, char** start, off_t off, int count, int* eof,
+	void* context)
+{
+	char* p = page;
+	u32 hci_result;
+	u32 value;
+
+	if (off != 0) goto end;
+
+	if (!key_event_valid) {
+		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+		if (hci_result == HCI_SUCCESS) {
+			key_event_valid = 1;
+			last_key_event = value;
+		} else if (hci_result == HCI_EMPTY) {
+			/* better luck next time */
+		} else {
+			p += sprintf(p, "ERROR\n");
+			goto end;
+		}
+	}
+
+	p += sprintf(p, "hotkey_ready:            %d\n", key_event_valid);
+	p += sprintf(p, "hotkey:                  0x%04x\n", last_key_event);
+
+end:
+	return end_proc_read(p, page, off, count, start, eof);
+}
+
+static int
+proc_write_keys(struct file* file, const char* buffer, unsigned long count,
+	void* data)
+{
+	int value;
+
+	if (snscanf(buffer, count, " hotkey_ready : %i", &value) == 1 &&
+			value == 0) {
+		key_event_valid = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static int
+proc_read_version(char* page, char** start, off_t off, int count, int* eof,
+	void* context)
+{
+	char* p = page;
+
+	if (off != 0) goto end;
+
+	p += sprintf(p, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
+	p += sprintf(p, "proc_interface:          %d\n",
+		PROC_INTERFACE_VERSION);
+
+end:
+	return end_proc_read(p, page, off, count, start, eof);
+}
+
 /* proc and module init
  */
 
@@ -410,6 +502,13 @@
 		toshiba_proc_dir, proc_read_fan, 0);
 	if (proc) proc->write_proc = proc_write_fan;
 
+	proc = create_proc_read_entry(PROC_KEYS, S_IFREG | S_IRUGO | S_IWUSR,
+		toshiba_proc_dir, proc_read_keys, 0);
+	if (proc) proc->write_proc = proc_write_keys;
+
+	proc = create_proc_read_entry(PROC_VERSION, S_IFREG | S_IRUGO | S_IWUSR,
+		toshiba_proc_dir, proc_read_version, 0);
+
 	return(AE_OK);
 }
 
@@ -419,6 +518,8 @@
 	remove_proc_entry(PROC_LCD, toshiba_proc_dir);
 	remove_proc_entry(PROC_VIDEO, toshiba_proc_dir);
 	remove_proc_entry(PROC_FAN, toshiba_proc_dir);
+	remove_proc_entry(PROC_KEYS, toshiba_proc_dir);
+	remove_proc_entry(PROC_VERSION, toshiba_proc_dir);
 	return(AE_OK);
 }
 
@@ -437,6 +538,10 @@
 	printk("Toshiba Laptop ACPI Extras version %s\n", TOSHIBA_ACPI_VERSION);
 
 	force_fan = 0;
+	key_event_valid = 0;
+
+	/* enable event fifo */
+	hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
 
 	toshiba_proc_dir = proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
 	if (!toshiba_proc_dir) {

--------------010005010501010705050000--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
