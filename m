From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] toshiba_acpi 0.18
Date: Sun, 14 Mar 2004 01:02:58 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4053F592.80001@neggie.net>
References: <4053C4D5.8000703@neggie.net> <1079242701.2168.121.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jvb.vm.bytemark.co.uk-17584-1079244181-0001-2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079242701.2168.121.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Julien Lerouge <julien.lerouge-GANU6spQydw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jvb.vm.bytemark.co.uk-17584-1079244181-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Len Brown wrote:
> I think that the "__user" attribute is needed on the user pointer param
> to copy_from_user() -- at least in 2.6.

Thanks Len, updated patch attached.

-John


-- 
http:// if  ile.org/

--=_jvb.vm.bytemark.co.uk-17584-1079244181-0001-2
Content-Type: text/x-patch; name="toshiba_acpi_0.18-linux_2.6.4.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.18-linux_2.6.4.patch"

diff -urN linux-2.6.4/drivers/acpi/toshiba_acpi.c new/drivers/acpi/toshiba_acpi.c
--- linux-2.6.4/drivers/acpi/toshiba_acpi.c	2004-03-13 21:09:26.000000000 -0500
+++ new/drivers/acpi/toshiba_acpi.c	2004-03-14 00:59:45.000000000 -0500
@@ -33,7 +33,7 @@
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.17"
+#define TOSHIBA_ACPI_VERSION	"0.18"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -105,24 +106,6 @@
 	*word = (*word & ~mask) | (mask * value);
 }
 
-/* an sscanf that takes explicit string length */
-static int
-snscanf(const char* str, int n, const char* format, ...)
-{
-	va_list args;
-	int result;
-	char* str2 = kmalloc(n + 1, GFP_KERNEL);
-	if (str2 == 0) return 0;
-	/* NOTE: don't even _think_ about replacing this with strlcpy */
-	strncpy(str2, str, n);
-	str2[n] = 0;
-	va_start(args, format);
-	result = vsscanf(str2, format, args);
-	va_end(args);
-	kfree(str2);
-	return result;
-}
-
 /* acpi interface wrappers
  */
 
@@ -269,10 +252,26 @@
 }
 
 static int
-dispatch_write(struct file* file, const char* buffer, unsigned long count,
-	ProcItem* item)
+dispatch_write(struct file* file, __user const char* buffer,
+	unsigned long count, ProcItem* item)
 {
-	return item->write_func(buffer, count);
+	int result;
+	char* tmp_buffer;
+
+	/* Arg buffer points to userspace memory, which can't be accessed
+	 * directly.  Since we're making a copy, zero-terminate the
+	 * destination so that sscanf can be used on it safely.
+	 */
+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (copy_from_user(tmp_buffer, buffer, count)) {
+		result = -EFAULT;
+	}
+	else {
+		tmp_buffer[count] = 0;
+		result = item->write_func(tmp_buffer, count);
+	}
+	kfree(tmp_buffer);
+	return result;
 }
 
 static char*
@@ -300,7 +299,7 @@
 	int value;
 	u32 hci_result;
 
-	if (snscanf(buffer, count, " brightness : %i", &value) == 1 &&
+	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
 			value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
 		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
@@ -350,11 +349,11 @@
 	 *  NOTE: to keep scanning simple, invalid fields are ignored
 	 */
 	while (remain) {
-		if (snscanf(buffer, remain, " lcd_out : %i", &value) == 1)
+		if (sscanf(buffer, " lcd_out : %i", &value) == 1)
 			lcd_out = value & 1;
-		else if (snscanf(buffer, remain, " crt_out : %i", &value) == 1)
+		else if (sscanf(buffer, " crt_out : %i", &value) == 1)
 			crt_out = value & 1;
-		else if (snscanf(buffer, remain, " tv_out : %i", &value) == 1)
+		else if (sscanf(buffer, " tv_out : %i", &value) == 1)
 			tv_out = value & 1;
 		/* advance to one character past the next ; */
 		do {
@@ -407,7 +406,7 @@
 	int value;
 	u32 hci_result;
 
-	if (snscanf(buffer, count, " force_on : %i", &value) == 1 &&
+	if (sscanf(buffer, " force_on : %i", &value) == 1 &&
 			value >= 0 && value <= 1) {
 		hci_write1(HCI_FAN, value, &hci_result);
 		if (hci_result != HCI_SUCCESS)
@@ -458,7 +457,7 @@
 {
 	int value;
 
-	if (snscanf(buffer, count, " hotkey_ready : %i", &value) == 1 &&
+	if (sscanf(buffer, " hotkey_ready : %i", &value) == 1 &&
 			value == 0) {
 		key_event_valid = 0;
 	} else {

--=_jvb.vm.bytemark.co.uk-17584-1079244181-0001-2--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
