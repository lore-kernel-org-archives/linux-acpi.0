From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH] toshiba_acpi 0.18
Date: Wed, 24 Mar 2004 00:24:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323232438.GA9223@hell.org.pl>
References: <4053C4D5.8000703@neggie.net> <20040314130724.GA1994@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040314130724.GA1994-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Thus wrote Karol Kozimor:
> > It appears that the asus_acpi driver has the same issue, as it was 
> > derived from mine.
> While I think it doesn't oops (at least I can't reproduce it), it doesn't
> work either when CONFIG_X86_4G=y. I'll have a fix later on.

The attached patches introduce copy_from_user() where appropriate. I only
tested this code with 2.6.5-rc1-mm2, where it worked both with and without
CONFIG_X86_4G. For 2.4, compile-test only.

Note: I'm not sure if the 2.4 version is needed, there's no CONFIG_X86_4G
there. Does a highmem-enabled kernel need such a conversion? I can't really
test those changes reliably having only 256 MB RAM, but at least those
changes don't seem to do any harm.

Please apply if you feel so.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="copy_from_user-2.4.diff"

--- a/drivers/acpi/asus_acpi.c	2004-02-18 14:36:31.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2004-03-23 16:41:48.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/proc_fs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
 
 #define ASUS_ACPI_VERSION "0.27"
 
@@ -499,9 +500,16 @@ write_led(const char *buffer, unsigned l
 {
 	int value;
 	int led_out = 0;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		led_out = value ? 1 : 0;
+	kfree(tmp_buffer);
 
 	hotk->status =
 	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
@@ -656,9 +664,17 @@ proc_write_lcd(struct file *file, const 
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 	
-	if (sscanf(buffer, "%i", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		set_lcd_state(hotk, value);
+	kfree(tmp_buffer);
+
 	return count;
 }
 
@@ -723,14 +739,21 @@ proc_write_brn(struct file *file, const 
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1) {
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
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
@@ -772,12 +795,19 @@ proc_write_disp(struct file *file, const
 {
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	char *tmp_buffer;
 
-	if (sscanf(buffer, "%d", &value) == 1)
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="copy_from_user-2.6.diff"

--- asus_acpi.c.orig	2004-03-21 16:48:28.000000000 +0100
+++ asus_acpi.c	2004-03-21 16:55:18.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/proc_fs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
 
 #define ASUS_ACPI_VERSION "0.27"
 
@@ -494,14 +495,21 @@
 
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
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		led_out = value ? 1 : 0;
+	kfree(tmp_buffer);
 
 	hotk->status =
 	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
@@ -651,14 +659,22 @@
 
 
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
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%i", &value) == 1)
 		set_lcd_state(hotk, value);
+	kfree(tmp_buffer);
+
 	return count;
 }
 
@@ -718,19 +734,26 @@
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
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
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
@@ -767,17 +790,24 @@
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
+	if (copy_from_user(tmp_buffer, buffer, count))
+		return -EFAULT;
+	else
+		tmp_buffer[count] = '\0';
+	if (sscanf(tmp_buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
+	kfree(tmp_buffer);
 
 	return count;
 }

--G4iJoqBmSsgzjUCe--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
