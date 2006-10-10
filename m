From: akpm@osdl.org
Subject: [patch 05/12] asus_acpi: fix proc files parsing
Date: Tue, 10 Oct 2006 14:20:35 -0700
Message-ID: <200610102120.k9ALKZKZ024278@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:27810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030532AbWJJVvE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:51:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, darrenrjenkins@gmail.com, adobriyan@gmail.com

From: Darren Jenkins <darrenrjenkins@gmail.com>

ICC complains about a "Pointless comparsion of unsigned interger with zero"
@ line 760 & 808 of asus_acpi.c

parse_arg() mentioned below returns -E but it's copied into unsigned variable...

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   46 ++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-fix-proc-files-parsing drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-fix-proc-files-parsing
+++ a/drivers/acpi/asus_acpi.c
@@ -567,11 +567,11 @@ static int
 write_led(const char __user * buffer, unsigned long count,
 	  char *ledname, int ledmask, int invert)
 {
-	int value;
+	int rv, value;
 	int led_out = 0;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		led_out = value ? 1 : 0;
 
 	hotk->status =
@@ -584,7 +584,7 @@ write_led(const char __user * buffer, un
 		printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
 		       ledname);
 
-	return count;
+	return rv;
 }
 
 /*
@@ -619,20 +619,20 @@ static int
 proc_write_ledd(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0) {
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0) {
 		if (!write_acpi_int
 		    (hotk->handle, hotk->methods->mt_ledd, value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
-	} else if (count < 0)
+	} else if (rv < 0)
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 
-	return count;
+	return rv;
 }
 
 /*
@@ -773,12 +773,12 @@ static int
 proc_write_lcd(struct file *file, const char __user * buffer,
 	       unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		set_lcd_state(value);
-	return count;
+	return rv;
 }
 
 static int read_brightness(void)
@@ -842,18 +842,18 @@ static int
 proc_write_brn(struct file *file, const char __user * buffer,
 	       unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0) {
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 		/* 0 <= value <= 15 */
 		set_brightness(value);
-	} else if (count < 0) {
+	} else if (rv < 0) {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
 
-	return count;
+	return rv;
 }
 
 static void set_display(int value)
@@ -892,15 +892,15 @@ static int
 proc_write_disp(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		set_display(value);
-	else if (count < 0)
+	else if (rv < 0)
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 
-	return count;
+	return rv;
 }
 
 typedef int (proc_readfunc) (char *page, char **start, off_t off, int count,
_
