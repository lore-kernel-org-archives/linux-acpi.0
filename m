From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH] toshiba_acpi 0.18
Date: Wed, 24 Mar 2004 12:17:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040324111720.GA15171@hell.org.pl>
References: <4053C4D5.8000703@neggie.net> <20040314130724.GA1994@hell.org.pl> <20040323232438.GA9223@hell.org.pl> <40610A01.9070904@neggie.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40610A01.9070904-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Thus wrote John Belmonte:
> Note that if copy_from_user fails, this code leaks memory.

Nah, I somehow assumed we don't have to worry after -EFAULT, my bad.
Updated patches attached.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="copy_from_user-2.4.diff"

--- ../../kernels/linux-2.4.25/drivers/acpi/asus_acpi.c	2004-02-18 14:36:31.000000000 +0100
+++ ./asus_acpi.c	2004-03-24 12:07:08.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/proc_fs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
 
 #define ASUS_ACPI_VERSION "0.27"
 
@@ -499,9 +500,17 @@ write_led(const char *buffer, unsigned l
 {
 	int value;
 	int led_out = 0;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		led_out = value ? 1 : 0;
+	kfree(tmp_buffer);
 
 	hotk->status =
 	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
@@ -656,9 +665,18 @@ proc_write_lcd(struct file *file, const 
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 	
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		set_lcd_state(hotk, value);
+	kfree(tmp_buffer);
+
 	return count;
 }
 
@@ -723,14 +741,22 @@ proc_write_brn(struct file *file, const 
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1) {
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 			/* 0 <= value <= 15 */
 		set_brightness(value, hotk);
 	} else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }
@@ -772,12 +798,20 @@ proc_write_disp(struct file *file, const
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }
@@ -1006,7 +1040,6 @@ static int __init asus_hotk_get_info(str
 }
 
 
-
 static int __init asus_hotk_check(struct asus_hotk *hotk)
 {
 	int result = 0;
@@ -1029,7 +1062,6 @@ static int __init asus_hotk_check(struct
 }
 
 
-
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	struct asus_hotk *hotk = NULL;

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="copy_from_user-2.6.diff"

--- ../../kernels/linux-2.6.5/drivers/acpi/asus_acpi.c	2004-03-21 16:48:28.000000000 +0100
+++ ./asus_acpi.c	2004-03-24 12:09:51.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/proc_fs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
 
 #define ASUS_ACPI_VERSION "0.27"
 
@@ -494,14 +495,22 @@ read_led(struct asus_hotk *hotk, const c
 
 /* FIXME: kill extraneous args so it can be called independently */
 static int
-write_led(const char *buffer, unsigned long count, struct asus_hotk *hotk, 
+write_led(const char __user *buffer, unsigned long count, struct asus_hotk *hotk,
           char *ledname, int ledmask, int invert)
 {
 	int value;
 	int led_out = 0;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		led_out = value ? 1 : 0;
+	kfree(tmp_buffer);
 
 	hotk->status =
 	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
@@ -651,14 +660,23 @@ proc_read_lcd(char *page, char **start, 
 
 
 static int
-proc_write_lcd(struct file *file, const char *buffer,
+proc_write_lcd(struct file *file, const char __user *buffer,
 	       unsigned long count, void *data)
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 	
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		set_lcd_state(hotk, value);
+	kfree(tmp_buffer);
+
 	return count;
 }
 
@@ -718,19 +736,27 @@ proc_read_brn(char *page, char **start, 
 }
 
 static int
-proc_write_brn(struct file *file, const char *buffer,
+proc_write_brn(struct file *file, const char __user *buffer,
 	       unsigned long count, void *data)
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1) {
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 			/* 0 <= value <= 15 */
 		set_brightness(value, hotk);
 	} else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }
@@ -767,17 +793,25 @@ proc_read_disp(char *page, char **start,
  * simultaneously, so be warned. See the acpi4asus README for more info.
  */
 static int
-proc_write_disp(struct file *file, const char *buffer,
+proc_write_disp(struct file *file, const char __user *buffer,
 	       unsigned long count, void *data)
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		kfree(tmp_buffer);
+		return -EFAULT;
+	} else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }
@@ -1006,7 +1040,6 @@ static int __init asus_hotk_get_info(str
 }
 
 
-
 static int __init asus_hotk_check(struct asus_hotk *hotk)
 {
 	int result = 0;
@@ -1029,7 +1062,6 @@ static int __init asus_hotk_check(struct
 }
 
 
-
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	struct asus_hotk *hotk = NULL;

--XsQoSWH+UP9D9v3l--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
