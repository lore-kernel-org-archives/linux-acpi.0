From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: [PATCH] Toshiba ACPI Extras 0.14
Date: Sat, 15 Feb 2003 03:06:22 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E4DF4FE.4050708@prairienet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010109060502030004020309"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109060502030004020309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andy,

This is a patch to the latest 2.5 kernel for version 0.14 of my driver. 
   Please apply the resulting file to the linux-2.4-acpi tree also (the 
only change needed is for the old acpi header location).

This version is a code cleanup only, there is no end-user functionality 
change.  By factoring out repetitive code I was able to shave about 20%, 
and the result is much easier to read and maintain.  However, I was only 
able to achieve this by reverting the "seq_file" conversion which 
someone had made to my code.  As I've explained, the interface between 
proc_fs and seq_file is incomplete in that userdata is not propagated. 
With this version I'm relying on userdata to keep my code reasonable.

Please do not apply Pavel Machek's addition of a compile-time warning to 
  toshiba_acpi.c from his Feb 13 patch, as it no longer applies.

Regards,
-John



-- 
http:// if   l .   /

--------------010109060502030004020309
Content-Type: text/plain;
 name="toshiba_acpi_0.14-linux_2.5.61.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.14-linux_2.5.61.patch"

--- linux-2.5.61/drivers/acpi/toshiba_acpi.c	2003-02-14 18:51:10.000000000 -0500
+++ linux-2.5.61-patched/drivers/acpi/toshiba_acpi.c	2003-02-15 02:26:35.000000000 -0500
@@ -2,7 +2,7 @@
  *  toshiba_acpi.c - Toshiba Laptop ACPI Extras
  *
  *
- *  Copyright (C) 2002 John Belmonte
+ *  Copyright (C) 2002-2003 John Belmonte
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -33,7 +33,7 @@
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.13"
+#define TOSHIBA_ACPI_VERSION	"0.14"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -41,19 +41,9 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <linux/version.h>
 
-#include <acpi/acconfig.h>
-#define OLD_ACPI_INTERFACE (ACPI_CA_VERSION < 0x20020000)
-
-#if OLD_ACPI_INTERFACE
-#include <acpi.h>
-extern struct proc_dir_entry* bm_proc_root;
-#define acpi_root_dir bm_proc_root
-#else
 #include <acpi/acpi_drivers.h>
-#endif
 
 MODULE_AUTHOR("John Belmonte");
 MODULE_DESCRIPTION("Toshiba Laptop ACPI Extras Driver");
@@ -101,47 +91,6 @@
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
 
-static int toshiba_lcd_open_fs(struct inode *inode, struct file *file);
-static int toshiba_video_open_fs(struct inode *inode, struct file *file);
-static int toshiba_fan_open_fs(struct inode *inode, struct file *file);
-static int toshiba_keys_open_fs(struct inode *inode, struct file *file);
-static int toshiba_version_open_fs(struct inode *inode, struct file *file);
-
-static struct file_operations toshiba_lcd_fops = {
-	.open		= toshiba_lcd_open_fs,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static struct file_operations toshiba_video_fops = {
-	.open		= toshiba_video_open_fs,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static struct file_operations toshiba_fan_fops = {
-	.open		= toshiba_fan_open_fs,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static struct file_operations toshiba_keys_fops = {
-	.open		= toshiba_keys_open_fs,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static struct file_operations toshiba_version_fops = {
-	.open		= toshiba_version_open_fs,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /* utility
  */
 
@@ -191,8 +140,8 @@
 static int
 read_acpi_int(const char* methodName, int* pVal)
 {
-	acpi_buffer results;
-	acpi_object out_objs[1];
+	struct acpi_buffer results;
+	union acpi_object out_objs[1];
 	acpi_status status;
 
 	results.length = sizeof(out_objs);
@@ -270,22 +219,50 @@
 	return status;
 }
 
-#define PROC_TOSHIBA		"toshiba"
-#define PROC_LCD		"lcd"
-#define PROC_VIDEO		"video"
-#define PROC_FAN		"fan"
-#define PROC_KEYS		"keys"
-#define PROC_VERSION		"version"
-
 static struct proc_dir_entry*	toshiba_proc_dir = NULL;
 static int			force_fan;
 static int			last_key_event;
 static int			key_event_valid;
 
+typedef struct _ProcItem
+{
+	char* name;
+	char* (*read_func)(char*);
+	unsigned long (*write_func)(const char*, unsigned long);
+} ProcItem;
+
 /* proc file handlers
  */
 
-static int toshiba_lcd_seq_show(struct seq_file *seq, void *offset)
+static int
+dispatch_read(char* page, char** start, off_t off, int count, int* eof,
+	ProcItem* item)
+{
+	char* p = page;
+	int len;
+
+	if (off == 0)
+		p = item->read_func(p);
+
+	/* ISSUE: I don't understand this code */
+	len = (p - page);
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+static int
+dispatch_write(struct file* file, const char* buffer, unsigned long count,
+	ProcItem* item)
+{
+	return item->write_func(buffer, count);
+}
+
+static char*
+read_lcd(char* p)
 {
 	u32 hci_result;
 	u32 value;
@@ -293,24 +270,18 @@
 	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		value = value >> HCI_LCD_BRIGHTNESS_SHIFT;
-		seq_printf(seq, "brightness:              %d\n"
-				"brightness_levels:       %d\n",
-				value,
-				HCI_LCD_BRIGHTNESS_LEVELS);
-	} else
-		seq_puts(seq, "ERROR\n");
-
-	return 0;
-}
+		p += sprintf(p, "brightness:              %d\n", value);
+		p += sprintf(p, "brightness_levels:       %d\n",
+			HCI_LCD_BRIGHTNESS_LEVELS);
+	} else {
+		p += sprintf(p, "ERROR\n");
+	}
 
-static int toshiba_lcd_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, toshiba_lcd_seq_show, NULL);
+	return p;
 }
 
-static int
-proc_write_lcd(struct file* file, const char* buffer, size_t count,
-	loff_t* data)
+static unsigned long
+write_lcd(const char* buffer, unsigned long count)
 {
 	int value;
 	/*int byte_count;*/
@@ -330,7 +301,8 @@
 	return count;
 }
 
-static int toshiba_video_seq_show(struct seq_file *seq, void *offset)
+static char*
+read_video(char* p)
 {
 	u32 hci_result;
 	u32 value;
@@ -340,26 +312,18 @@
 		int is_lcd = (value & HCI_VIDEO_OUT_LCD) ? 1 : 0;
 		int is_crt = (value & HCI_VIDEO_OUT_CRT) ? 1 : 0;
 		int is_tv  = (value & HCI_VIDEO_OUT_TV ) ? 1 : 0;
-		seq_printf(seq, "lcd_out:                 %d\n"
-				"crt_out:                 %d\n"
-				"tv_out:                  %d\n",
-				is_lcd,
-				is_crt,
-				is_tv);
-	} else
-		seq_puts(seq, "ERROR\n");
+		p += sprintf(p, "lcd_out:                 %d\n", is_lcd);
+		p += sprintf(p, "crt_out:                 %d\n", is_crt);
+		p += sprintf(p, "tv_out:                  %d\n", is_tv);
+	} else {
+		p += sprintf(p, "ERROR\n");
+	}
 
-	return 0;
+	return p;
 }
 
-static int toshiba_video_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, toshiba_video_seq_show, NULL);
-}
-
-static int
-proc_write_video(struct file* file, const char* buffer, size_t count,
-	loff_t* data)
+static unsigned long
+write_video(const char* buffer, unsigned long count)
 {
 	int value;
 	const char* buffer_end = buffer + count;
@@ -400,31 +364,25 @@
 	return count;
 }
 
-static int toshiba_fan_seq_show(struct seq_file *seq, void *offset)
+static char*
+read_fan(char* p)
 {
 	u32 hci_result;
 	u32 value;
 
 	hci_read1(HCI_FAN, &value, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
-		seq_printf(seq, "running:                 %d\n"
-				"force_on:                %d\n",
-				(value > 0),
-				force_fan);
-	} else
-		seq_puts(seq, "ERROR\n");
-
-	return 0;
-}
+		p += sprintf(p, "running:                 %d\n", (value > 0));
+		p += sprintf(p, "force_on:                %d\n", force_fan);
+	} else {
+		p += sprintf(p, "ERROR\n");
+	}
 
-static int toshiba_fan_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, toshiba_fan_seq_show, NULL);
+	return p;
 }
 
-static int
-proc_write_fan(struct file* file, const char* buffer, size_t count,
-	loff_t* data)
+static unsigned long
+write_fan(const char* buffer, unsigned long count)
 {
 	int value;
 	u32 hci_result;
@@ -443,7 +401,8 @@
 	return count;
 }
 
-static int toshiba_keys_seq_show(struct seq_file *seq, void *offset)
+static char*
+read_keys(char* p)
 {
 	u32 hci_result;
 	u32 value;
@@ -456,28 +415,20 @@
 		} else if (hci_result == HCI_EMPTY) {
 			/* better luck next time */
 		} else {
-			seq_puts(seq, "ERROR\n");
+			p += sprintf(p, "ERROR\n");
 			goto end;
 		}
 	}
 
-	seq_printf(seq, "hotkey_ready:            %d\n"
-			"hotkey:                  0x%04x\n",
-			key_event_valid,
-			last_key_event);
+	p += sprintf(p, "hotkey_ready:            %d\n", key_event_valid);
+	p += sprintf(p, "hotkey:                  0x%04x\n", last_key_event);
 
 end:
-	return 0;
+	return p;
 }
 
-static int toshiba_keys_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, toshiba_keys_seq_show, NULL);
-}
-
-static int
-proc_write_keys(struct file* file, const char* buffer, size_t count,
-	loff_t* data)
+static unsigned long
+write_keys(const char* buffer, unsigned long count)
 {
 	int value;
 
@@ -491,61 +442,44 @@
 	return count;
 }
 
-static int toshiba_version_seq_show(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "driver:                  %s\n"
-			"proc_interface:          %d\n",
-			TOSHIBA_ACPI_VERSION,
-			PROC_INTERFACE_VERSION);
-
-	return 0;
-}
-
-static int toshiba_version_open_fs(struct inode *inode, struct file *file)
+static char*
+read_version(char* p)
 {
-	return single_open(file, toshiba_version_seq_show, NULL);
+	p += sprintf(p, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
+	p += sprintf(p, "proc_interface:          %d\n",
+		PROC_INTERFACE_VERSION);
+	return p;
 }
 
 /* proc and module init
  */
 
+#define PROC_TOSHIBA		"toshiba"
+
+ProcItem proc_items[] =
+{
+	{ "lcd"		, read_lcd	, write_lcd	},
+	{ "video"	, read_video	, write_video	},
+	{ "fan"		, read_fan	, write_fan	},
+	{ "keys"	, read_keys	, write_keys	},
+	{ "version"	, read_version	, 0		},
+	{ 0		, 0		, 0		},
+};
+
 static acpi_status
 add_device(void)
 {
 	struct proc_dir_entry* proc;
+	ProcItem* item;
 
-	proc = create_proc_entry(PROC_LCD, S_IFREG | S_IRUGO | S_IWUSR,
-		toshiba_proc_dir);
-	if (proc) {
-		proc->proc_fops = &toshiba_lcd_fops;
-		proc->proc_fops->write = proc_write_lcd;
-	}
-
-	proc = create_proc_entry(PROC_VIDEO, S_IFREG | S_IRUGO | S_IWUSR,
-		toshiba_proc_dir);
-	if (proc) {
-		proc->proc_fops = &toshiba_video_fops;
-		proc->proc_fops->write = proc_write_video;
-	}
-
-	proc = create_proc_entry(PROC_FAN, S_IFREG | S_IRUGO | S_IWUSR,
-		toshiba_proc_dir);
-	if (proc) {
-		proc->proc_fops = &toshiba_fan_fops;
-		proc->proc_fops->write = proc_write_fan;
-	}
-
-	proc = create_proc_entry(PROC_KEYS, S_IFREG | S_IRUGO | S_IWUSR,
-		toshiba_proc_dir);
-	if (proc) {
-		proc->proc_fops = &toshiba_keys_fops;
-		proc->proc_fops->write = proc_write_keys;
-	}
-
-	proc = create_proc_entry(PROC_VERSION, S_IFREG | S_IRUGO | S_IWUSR,
-		toshiba_proc_dir);
-	if (proc)
-		proc->proc_fops = &toshiba_version_fops;
+	for (item = proc_items; item->name; ++item)
+	{
+		proc = create_proc_read_entry(item->name,
+			S_IFREG | S_IRUGO | S_IWUSR,
+			toshiba_proc_dir, (read_proc_t*)dispatch_read, item);
+		if (proc && item->write_func)
+			proc->write_proc = (write_proc_t*)dispatch_write;
+	}
 
 	return(AE_OK);
 }
@@ -553,11 +487,10 @@
 static acpi_status
 remove_device(void)
 {
-	remove_proc_entry(PROC_LCD, toshiba_proc_dir);
-	remove_proc_entry(PROC_VIDEO, toshiba_proc_dir);
-	remove_proc_entry(PROC_FAN, toshiba_proc_dir);
-	remove_proc_entry(PROC_KEYS, toshiba_proc_dir);
-	remove_proc_entry(PROC_VERSION, toshiba_proc_dir);
+	ProcItem* item;
+
+	for (item = proc_items; item->name; ++item)
+		remove_proc_entry(item->name, toshiba_proc_dir);
 	return(AE_OK);
 }
 

--------------010109060502030004020309--



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
