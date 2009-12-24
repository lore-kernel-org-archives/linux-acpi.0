From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/34] toshiba_acpi: convert to seq_file
Date: Thu, 24 Dec 2009 01:23:57 -0500
Message-ID: <936c8bcd7f5b418d0e040be539ceb4d2ac3bc0b8.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838AbZLXTb3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:29 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:10 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>, "John W. Linville" <linville@tuxdriver.com>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c |  259 ++++++++++++++++++++---------------
 1 files changed, 147 insertions(+), 112 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 51c0a8b..77bf5d8 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/backlight.h>
 #include <linux/platform_device.h>
 #include <linux/rfkill.h>
@@ -357,63 +358,6 @@ static int force_fan;
 static int last_key_event;
 static int key_event_valid;
 
-typedef struct _ProcItem {
-	const char *name;
-	char *(*read_func) (char *);
-	unsigned long (*write_func) (const char *, unsigned long);
-} ProcItem;
-
-/* proc file handlers
- */
-
-static int
-dispatch_read(char *page, char **start, off_t off, int count, int *eof,
-	      ProcItem * item)
-{
-	char *p = page;
-	int len;
-
-	if (off == 0)
-		p = item->read_func(p);
-
-	/* ISSUE: I don't understand this code */
-	len = (p - page);
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-	return len;
-}
-
-static int
-dispatch_write(struct file *file, const char __user * buffer,
-	       unsigned long count, ProcItem * item)
-{
-	int result;
-	char *tmp_buffer;
-
-	/* Arg buffer points to userspace memory, which can't be accessed
-	 * directly.  Since we're making a copy, zero-terminate the
-	 * destination so that sscanf can be used on it safely.
-	 */
-	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
-	if (!tmp_buffer)
-		return -ENOMEM;
-
-	if (copy_from_user(tmp_buffer, buffer, count)) {
-		result = -EFAULT;
-	} else {
-		tmp_buffer[count] = 0;
-		result = item->write_func(tmp_buffer, count);
-	}
-	kfree(tmp_buffer);
-	return result;
-}
-
 static int get_lcd(struct backlight_device *bd)
 {
 	u32 hci_result;
@@ -426,19 +370,24 @@ static int get_lcd(struct backlight_device *bd)
 		return -EFAULT;
 }
 
-static char *read_lcd(char *p)
+static int lcd_proc_show(struct seq_file *m, void *v)
 {
 	int value = get_lcd(NULL);
 
 	if (value >= 0) {
-		p += sprintf(p, "brightness:              %d\n", value);
-		p += sprintf(p, "brightness_levels:       %d\n",
+		seq_printf(m, "brightness:              %d\n", value);
+		seq_printf(m, "brightness_levels:       %d\n",
 			     HCI_LCD_BRIGHTNESS_LEVELS);
 	} else {
 		printk(MY_ERR "Error reading LCD brightness\n");
 	}
 
-	return p;
+	return 0;
+}
+
+static int lcd_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lcd_proc_show, NULL);
 }
 
 static int set_lcd(int value)
@@ -458,12 +407,20 @@ static int set_lcd_status(struct backlight_device *bd)
 	return set_lcd(bd->props.brightness);
 }
 
-static unsigned long write_lcd(const char *buffer, unsigned long count)
+static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *pos)
 {
+	char cmd[42];
+	size_t len;
 	int value;
 	int ret;
 
-	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
+	len = min(count, sizeof(cmd) - 1);
+	if (copy_from_user(cmd, buf, len))
+		return -EFAULT;
+	cmd[len] = '\0';
+
+	if (sscanf(cmd, " brightness : %i", &value) == 1 &&
 	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		ret = set_lcd(value);
 		if (ret == 0)
@@ -474,7 +431,16 @@ static unsigned long write_lcd(const char *buffer, unsigned long count)
 	return ret;
 }
 
-static char *read_video(char *p)
+static const struct file_operations lcd_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= lcd_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= lcd_proc_write,
+};
+
+static int video_proc_show(struct seq_file *m, void *v)
 {
 	u32 hci_result;
 	u32 value;
@@ -484,18 +450,25 @@ static char *read_video(char *p)
 		int is_lcd = (value & HCI_VIDEO_OUT_LCD) ? 1 : 0;
 		int is_crt = (value & HCI_VIDEO_OUT_CRT) ? 1 : 0;
 		int is_tv = (value & HCI_VIDEO_OUT_TV) ? 1 : 0;
-		p += sprintf(p, "lcd_out:                 %d\n", is_lcd);
-		p += sprintf(p, "crt_out:                 %d\n", is_crt);
-		p += sprintf(p, "tv_out:                  %d\n", is_tv);
+		seq_printf(m, "lcd_out:                 %d\n", is_lcd);
+		seq_printf(m, "crt_out:                 %d\n", is_crt);
+		seq_printf(m, "tv_out:                  %d\n", is_tv);
 	} else {
 		printk(MY_ERR "Error reading video out status\n");
 	}
 
-	return p;
+	return 0;
 }
 
-static unsigned long write_video(const char *buffer, unsigned long count)
+static int video_proc_open(struct inode *inode, struct file *file)
 {
+	return single_open(file, video_proc_show, NULL);
+}
+
+static ssize_t video_proc_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *pos)
+{
+	char *cmd, *buffer;
 	int value;
 	int remain = count;
 	int lcd_out = -1;
@@ -504,6 +477,17 @@ static unsigned long write_video(const char *buffer, unsigned long count)
 	u32 hci_result;
 	u32 video_out;
 
+	cmd = kmalloc(count + 1, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+	if (copy_from_user(cmd, buf, count)) {
+		kfree(cmd);
+		return -EFAULT;
+	}
+	cmd[count] = '\0';
+
+	buffer = cmd;
+
 	/* scan expression.  Multiple expressions may be delimited with ;
 	 *
 	 *  NOTE: to keep scanning simple, invalid fields are ignored
@@ -523,6 +507,8 @@ static unsigned long write_video(const char *buffer, unsigned long count)
 		while (remain && *(buffer - 1) != ';');
 	}
 
+	kfree(cmd);
+
 	hci_read1(HCI_VIDEO_OUT, &video_out, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		unsigned int new_video_out = video_out;
@@ -543,28 +529,50 @@ static unsigned long write_video(const char *buffer, unsigned long count)
 	return count;
 }
 
-static char *read_fan(char *p)
+static const struct file_operations video_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= video_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= video_proc_write,
+};
+
+static int fan_proc_show(struct seq_file *m, void *v)
 {
 	u32 hci_result;
 	u32 value;
 
 	hci_read1(HCI_FAN, &value, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
-		p += sprintf(p, "running:                 %d\n", (value > 0));
-		p += sprintf(p, "force_on:                %d\n", force_fan);
+		seq_printf(m, "running:                 %d\n", (value > 0));
+		seq_printf(m, "force_on:                %d\n", force_fan);
 	} else {
 		printk(MY_ERR "Error reading fan status\n");
 	}
 
-	return p;
+	return 0;
+}
+
+static int fan_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fan_proc_show, NULL);
 }
 
-static unsigned long write_fan(const char *buffer, unsigned long count)
+static ssize_t fan_proc_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *pos)
 {
+	char cmd[42];
+	size_t len;
 	int value;
 	u32 hci_result;
 
-	if (sscanf(buffer, " force_on : %i", &value) == 1 &&
+	len = min(count, sizeof(cmd) - 1);
+	if (copy_from_user(cmd, buf, len))
+		return -EFAULT;
+	cmd[len] = '\0';
+
+	if (sscanf(cmd, " force_on : %i", &value) == 1 &&
 	    value >= 0 && value <= 1) {
 		hci_write1(HCI_FAN, value, &hci_result);
 		if (hci_result != HCI_SUCCESS)
@@ -578,7 +586,16 @@ static unsigned long write_fan(const char *buffer, unsigned long count)
 	return count;
 }
 
-static char *read_keys(char *p)
+static const struct file_operations fan_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fan_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= fan_proc_write,
+};
+
+static int keys_proc_show(struct seq_file *m, void *v)
 {
 	u32 hci_result;
 	u32 value;
@@ -602,18 +619,30 @@ static char *read_keys(char *p)
 		}
 	}
 
-	p += sprintf(p, "hotkey_ready:            %d\n", key_event_valid);
-	p += sprintf(p, "hotkey:                  0x%04x\n", last_key_event);
+	seq_printf(m, "hotkey_ready:            %d\n", key_event_valid);
+	seq_printf(m, "hotkey:                  0x%04x\n", last_key_event);
+end:
+	return 0;
+}
 
-      end:
-	return p;
+static int keys_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, keys_proc_show, NULL);
 }
 
-static unsigned long write_keys(const char *buffer, unsigned long count)
+static ssize_t keys_proc_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *pos)
 {
+	char cmd[42];
+	size_t len;
 	int value;
 
-	if (sscanf(buffer, " hotkey_ready : %i", &value) == 1 && value == 0) {
+	len = min(count, sizeof(cmd) - 1);
+	if (copy_from_user(cmd, buf, len))
+		return -EFAULT;
+	cmd[len] = '\0';
+
+	if (sscanf(cmd, " hotkey_ready : %i", &value) == 1 && value == 0) {
 		key_event_valid = 0;
 	} else {
 		return -EINVAL;
@@ -622,52 +651,58 @@ static unsigned long write_keys(const char *buffer, unsigned long count)
 	return count;
 }
 
-static char *read_version(char *p)
+static const struct file_operations keys_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= keys_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= keys_proc_write,
+};
+
+static int version_proc_show(struct seq_file *m, void *v)
 {
-	p += sprintf(p, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
-	p += sprintf(p, "proc_interface:          %d\n",
-		     PROC_INTERFACE_VERSION);
-	return p;
+	seq_printf(m, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
+	seq_printf(m, "proc_interface:          %d\n", PROC_INTERFACE_VERSION);
+	return 0;
 }
 
+static int version_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, version_proc_show, PDE(inode)->data);
+}
+
+static const struct file_operations version_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= version_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* proc and module init
  */
 
 #define PROC_TOSHIBA		"toshiba"
 
-static ProcItem proc_items[] = {
-	{"lcd", read_lcd, write_lcd},
-	{"video", read_video, write_video},
-	{"fan", read_fan, write_fan},
-	{"keys", read_keys, write_keys},
-	{"version", read_version, NULL},
-	{NULL}
-};
-
 static acpi_status __init add_device(void)
 {
-	struct proc_dir_entry *proc;
-	ProcItem *item;
-
-	for (item = proc_items; item->name; ++item) {
-		proc = create_proc_read_entry(item->name,
-					      S_IFREG | S_IRUGO | S_IWUSR,
-					      toshiba_proc_dir,
-					      (read_proc_t *) dispatch_read,
-					      item);
-		if (proc && item->write_func)
-			proc->write_proc = (write_proc_t *) dispatch_write;
-	}
+	proc_create("lcd", S_IRUGO | S_IWUSR, toshiba_proc_dir, &lcd_proc_fops);
+	proc_create("video", S_IRUGO | S_IWUSR, toshiba_proc_dir, &video_proc_fops);
+	proc_create("fan", S_IRUGO | S_IWUSR, toshiba_proc_dir, &fan_proc_fops);
+	proc_create("keys", S_IRUGO | S_IWUSR, toshiba_proc_dir, &keys_proc_fops);
+	proc_create("version", S_IRUGO, toshiba_proc_dir, &version_proc_fops);
 
 	return AE_OK;
 }
 
 static acpi_status remove_device(void)
 {
-	ProcItem *item;
-
-	for (item = proc_items; item->name; ++item)
-		remove_proc_entry(item->name, toshiba_proc_dir);
+	remove_proc_entry("lcd", toshiba_proc_dir);
+	remove_proc_entry("video", toshiba_proc_dir);
+	remove_proc_entry("fan", toshiba_proc_dir);
+	remove_proc_entry("keys", toshiba_proc_dir);
+	remove_proc_entry("version", toshiba_proc_dir);
 	return AE_OK;
 }
 
-- 
1.6.0.6

