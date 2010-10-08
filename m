From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 4/6] ACPI video: remove deprecated procfs I/F
Date: Fri, 08 Oct 2010 13:55:11 +0800
Message-ID: <1286517311.2111.3799.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7238 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0JHF5X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 01:57:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Remove the deprecated ACPI video driver procfs I/F,
as stated in the changelog of commit 6e37c658aefa57c472b2dbf1de88dbd3c67cdb52

New sysfs I/F is available at /sys/class/backlight/

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |  771 ---------------------------------------------------
 1 file changed, 1 insertion(+), 770 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -30,8 +30,6 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/thermal.h>
@@ -152,9 +150,6 @@ struct acpi_video_bus {
 	struct acpi_video_bus_flags flags;
 	struct list_head video_device_list;
 	struct mutex device_list_lock;	/* protects video_device_list */
-#ifdef CONFIG_ACPI_PROCFS
-	struct proc_dir_entry *dir;
-#endif
 	struct input_dev *input;
 	char phys[32];	/* for input device */
 	struct notifier_block pm_nb;
@@ -210,108 +205,6 @@ struct acpi_video_device {
 	struct output_device *output_dev;
 };
 
-#ifdef CONFIG_ACPI_PROCFS
-/* bus */
-static int acpi_video_bus_info_open_fs(struct inode *inode, struct file *file);
-static const struct file_operations acpi_video_bus_info_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_bus_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file);
-static const struct file_operations acpi_video_bus_ROM_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_bus_ROM_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_bus_POST_info_open_fs(struct inode *inode,
-					    struct file *file);
-static const struct file_operations acpi_video_bus_POST_info_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_bus_POST_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_bus_POST_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_video_bus_write_POST(struct file *file,
-	const char __user *buffer, size_t count, loff_t *data);
-static const struct file_operations acpi_video_bus_POST_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_bus_POST_open_fs,
-	.read = seq_read,
-	.write = acpi_video_bus_write_POST,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_bus_DOS_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_video_bus_write_DOS(struct file *file,
-	const char __user *buffer, size_t count, loff_t *data);
-static const struct file_operations acpi_video_bus_DOS_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_bus_DOS_open_fs,
-	.read = seq_read,
-	.write = acpi_video_bus_write_DOS,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-/* device */
-static int acpi_video_device_info_open_fs(struct inode *inode,
-					  struct file *file);
-static const struct file_operations acpi_video_device_info_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_device_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_device_state_open_fs(struct inode *inode,
-					   struct file *file);
-static ssize_t acpi_video_device_write_state(struct file *file,
-	const char __user *buffer, size_t count, loff_t *data);
-static const struct file_operations acpi_video_device_state_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_device_state_open_fs,
-	.read = seq_read,
-	.write = acpi_video_device_write_state,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_device_brightness_open_fs(struct inode *inode,
-						struct file *file);
-static ssize_t acpi_video_device_write_brightness(struct file *file,
-	const char __user *buffer, size_t count, loff_t *data);
-static const struct file_operations acpi_video_device_brightness_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_device_brightness_open_fs,
-	.read = seq_read,
-	.write = acpi_video_device_write_brightness,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_video_device_EDID_open_fs(struct inode *inode,
-					  struct file *file);
-static const struct file_operations acpi_video_device_EDID_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_video_device_EDID_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif /* CONFIG_ACPI_PROCFS */
-
 static const char device_decode[][30] = {
 	"motherboard VGA device",
 	"PCI VGA device",
@@ -1111,646 +1004,6 @@ static int acpi_video_bus_check(struct a
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-
-static struct proc_dir_entry *acpi_video_dir;
-
-/* video devices */
-
-static int acpi_video_device_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_device *dev = seq->private;
-
-
-	if (!dev)
-		goto end;
-
-	seq_printf(seq, "device_id:    0x%04x\n", (u32) dev->device_id);
-	seq_printf(seq, "type:         ");
-	if (dev->flags.crt)
-		seq_printf(seq, "CRT\n");
-	else if (dev->flags.lcd)
-		seq_printf(seq, "LCD\n");
-	else if (dev->flags.tvout)
-		seq_printf(seq, "TVOUT\n");
-	else if (dev->flags.dvi)
-		seq_printf(seq, "DVI\n");
-	else
-		seq_printf(seq, "UNKNOWN\n");
-
-	seq_printf(seq, "known by bios: %s\n", dev->flags.bios ? "yes" : "no");
-
-      end:
-	return 0;
-}
-
-static int
-acpi_video_device_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_device_info_seq_show,
-			   PDE(inode)->data);
-}
-
-static int
-acpi_video_device_query(struct acpi_video_device *device,
-			unsigned long long *state)
-{
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DGS",
-				       NULL, state);
-
-	return status;
-}
-
-static int acpi_video_device_state_seq_show(struct seq_file *seq, void *offset)
-{
-	int status;
-	struct acpi_video_device *dev = seq->private;
-	unsigned long long state;
-
-
-	if (!dev)
-		goto end;
-
-	status = acpi_video_device_get_state(dev, &state);
-	seq_printf(seq, "state:     ");
-	if (ACPI_SUCCESS(status))
-		seq_printf(seq, "0x%02llx\n", state);
-	else
-		seq_printf(seq, "<not supported>\n");
-
-	status = acpi_video_device_query(dev, &state);
-	seq_printf(seq, "query:     ");
-	if (ACPI_SUCCESS(status))
-		seq_printf(seq, "0x%02llx\n", state);
-	else
-		seq_printf(seq, "<not supported>\n");
-
-      end:
-	return 0;
-}
-
-static int
-acpi_video_device_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_device_state_seq_show,
-			   PDE(inode)->data);
-}
-
-static ssize_t
-acpi_video_device_write_state(struct file *file,
-			      const char __user * buffer,
-			      size_t count, loff_t * data)
-{
-	int status;
-	struct seq_file *m = file->private_data;
-	struct acpi_video_device *dev = m->private;
-	char str[12] = { 0 };
-	u32 state = 0;
-
-
-	if (!dev || count >= sizeof(str))
-		return -EINVAL;
-
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	str[count] = 0;
-	state = simple_strtoul(str, NULL, 0);
-	state &= ((1ul << 31) | (1ul << 30) | (1ul << 0));
-
-	status = acpi_video_device_set_state(dev, state);
-
-	if (status)
-		return -EFAULT;
-
-	return count;
-}
-
-static int
-acpi_video_device_brightness_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_device *dev = seq->private;
-	int i;
-
-
-	if (!dev || !dev->brightness) {
-		seq_printf(seq, "<not supported>\n");
-		return 0;
-	}
-
-	seq_printf(seq, "levels: ");
-	for (i = 2; i < dev->brightness->count; i++)
-		seq_printf(seq, " %d", dev->brightness->levels[i]);
-	seq_printf(seq, "\ncurrent: %d\n", dev->brightness->curr);
-
-	return 0;
-}
-
-static int
-acpi_video_device_brightness_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_device_brightness_seq_show,
-			   PDE(inode)->data);
-}
-
-static ssize_t
-acpi_video_device_write_brightness(struct file *file,
-				   const char __user * buffer,
-				   size_t count, loff_t * data)
-{
-	struct seq_file *m = file->private_data;
-	struct acpi_video_device *dev = m->private;
-	char str[5] = { 0 };
-	unsigned int level = 0;
-	int i;
-
-
-	if (!dev || !dev->brightness || count >= sizeof(str))
-		return -EINVAL;
-
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	str[count] = 0;
-	level = simple_strtoul(str, NULL, 0);
-
-	if (level > 100)
-		return -EFAULT;
-
-	/* validate through the list of available levels */
-	for (i = 2; i < dev->brightness->count; i++)
-		if (level == dev->brightness->levels[i]) {
-			if (!acpi_video_device_lcd_set_level(dev, level))
-				return count;
-			break;
-		}
-
-	return -EINVAL;
-}
-
-static int acpi_video_device_EDID_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_device *dev = seq->private;
-	int status;
-	int i;
-	union acpi_object *edid = NULL;
-
-
-	if (!dev)
-		goto out;
-
-	status = acpi_video_device_EDID(dev, &edid, 128);
-	if (ACPI_FAILURE(status)) {
-		status = acpi_video_device_EDID(dev, &edid, 256);
-	}
-
-	if (ACPI_FAILURE(status)) {
-		goto out;
-	}
-
-	if (edid && edid->type == ACPI_TYPE_BUFFER) {
-		for (i = 0; i < edid->buffer.length; i++)
-			seq_putc(seq, edid->buffer.pointer[i]);
-	}
-
-      out:
-	if (!edid)
-		seq_printf(seq, "<not supported>\n");
-	else
-		kfree(edid);
-
-	return 0;
-}
-
-static int
-acpi_video_device_EDID_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_device_EDID_seq_show,
-			   PDE(inode)->data);
-}
-
-static int acpi_video_device_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry, *device_dir;
-	struct acpi_video_device *vid_dev;
-
-	vid_dev = acpi_driver_data(device);
-	if (!vid_dev)
-		return -ENODEV;
-
-	device_dir = proc_mkdir(acpi_device_bid(device),
-				vid_dev->video->dir);
-	if (!device_dir)
-		return -ENOMEM;
-
-	/* 'info' [R] */
-	entry = proc_create_data("info", S_IRUGO, device_dir,
-			&acpi_video_device_info_fops, acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_dir;
-
-	/* 'state' [R/W] */
-	entry = proc_create_data("state", S_IFREG | S_IRUGO | S_IWUSR,
-				 device_dir,
-				 &acpi_video_device_state_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_info;
-
-	/* 'brightness' [R/W] */
-	entry = proc_create_data("brightness", S_IFREG | S_IRUGO | S_IWUSR,
-				 device_dir,
-				 &acpi_video_device_brightness_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_state;
-
-	/* 'EDID' [R] */
-	entry = proc_create_data("EDID", S_IRUGO, device_dir,
-				 &acpi_video_device_EDID_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_brightness;
-
-	acpi_device_dir(device) = device_dir;
-
-	return 0;
-
- err_remove_brightness:
-	remove_proc_entry("brightness", device_dir);
- err_remove_state:
-	remove_proc_entry("state", device_dir);
- err_remove_info:
-	remove_proc_entry("info", device_dir);
- err_remove_dir:
-	remove_proc_entry(acpi_device_bid(device), vid_dev->video->dir);
-	return -ENOMEM;
-}
-
-static int acpi_video_device_remove_fs(struct acpi_device *device)
-{
-	struct acpi_video_device *vid_dev;
-	struct proc_dir_entry *device_dir;
-
-	vid_dev = acpi_driver_data(device);
-	if (!vid_dev || !vid_dev->video || !vid_dev->video->dir)
-		return -ENODEV;
-
-	device_dir = acpi_device_dir(device);
-	if (device_dir) {
-		remove_proc_entry("info", device_dir);
-		remove_proc_entry("state", device_dir);
-		remove_proc_entry("brightness", device_dir);
-		remove_proc_entry("EDID", device_dir);
-		remove_proc_entry(acpi_device_bid(device), vid_dev->video->dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-
-/* video bus */
-static int acpi_video_bus_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_bus *video = seq->private;
-
-
-	if (!video)
-		goto end;
-
-	seq_printf(seq, "Switching heads:              %s\n",
-		   video->flags.multihead ? "yes" : "no");
-	seq_printf(seq, "Video ROM:                    %s\n",
-		   video->flags.rom ? "yes" : "no");
-	seq_printf(seq, "Device to be POSTed on boot:  %s\n",
-		   video->flags.post ? "yes" : "no");
-
-      end:
-	return 0;
-}
-
-static int acpi_video_bus_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_bus_info_seq_show,
-			   PDE(inode)->data);
-}
-
-static int acpi_video_bus_ROM_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_bus *video = seq->private;
-
-
-	if (!video)
-		goto end;
-
-	printk(KERN_INFO PREFIX "Please implement %s\n", __func__);
-	seq_printf(seq, "<TODO>\n");
-
-      end:
-	return 0;
-}
-
-static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_bus_ROM_seq_show, PDE(inode)->data);
-}
-
-static int
-acpi_video_bus_POST_options(struct acpi_video_bus *video,
-			    unsigned long long *options)
-{
-	int status;
-
-	status = acpi_evaluate_integer(video->device->handle, "_VPO",
-				       NULL, options);
-	*options &= 3;
-
-	return status;
-}
-
-static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_bus *video = seq->private;
-	unsigned long long options;
-	int status;
-
-
-	if (!video)
-		goto end;
-
-	status = acpi_video_bus_POST_options(video, &options);
-	if (ACPI_SUCCESS(status)) {
-		if (!(options & 1)) {
-			printk(KERN_WARNING PREFIX
-			       "The motherboard VGA device is not listed as a possible POST device.\n");
-			printk(KERN_WARNING PREFIX
-			       "This indicates a BIOS bug. Please contact the manufacturer.\n");
-		}
-		printk(KERN_WARNING "%llx\n", options);
-		seq_printf(seq, "can POST: <integrated video>");
-		if (options & 2)
-			seq_printf(seq, " <PCI video>");
-		if (options & 4)
-			seq_printf(seq, " <AGP video>");
-		seq_putc(seq, '\n');
-	} else
-		seq_printf(seq, "<not supported>\n");
-      end:
-	return 0;
-}
-
-static int
-acpi_video_bus_POST_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_bus_POST_info_seq_show,
-			   PDE(inode)->data);
-}
-
-static int
-acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long long *id)
-{
-	int status;
-
-	status = acpi_evaluate_integer(video->device->handle, "_GPD", NULL, id);
-
-	return status;
-}
-
-static int acpi_video_bus_POST_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_bus *video = seq->private;
-	int status;
-	unsigned long long id;
-
-
-	if (!video)
-		goto end;
-
-	status = acpi_video_bus_get_POST(video, &id);
-	if (!ACPI_SUCCESS(status)) {
-		seq_printf(seq, "<not supported>\n");
-		goto end;
-	}
-	seq_printf(seq, "device POSTed is <%s>\n", device_decode[id & 3]);
-
-      end:
-	return 0;
-}
-
-static int acpi_video_bus_DOS_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_video_bus *video = seq->private;
-
-
-	seq_printf(seq, "DOS setting: <%d>\n", video->dos_setting);
-
-	return 0;
-}
-
-static int acpi_video_bus_POST_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_bus_POST_seq_show,
-			   PDE(inode)->data);
-}
-
-static int acpi_video_bus_DOS_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_video_bus_DOS_seq_show, PDE(inode)->data);
-}
-
-static int
-acpi_video_bus_set_POST(struct acpi_video_bus *video, unsigned long option)
-{
-	int status;
-	unsigned long long tmp;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-
-
-	arg0.integer.value = option;
-
-	status = acpi_evaluate_integer(video->device->handle, "_SPD",
-				       &args, &tmp);
-	if (ACPI_SUCCESS(status))
-		status = tmp ? (-EINVAL) : (AE_OK);
-
-	return status;
-}
-
-static ssize_t
-acpi_video_bus_write_POST(struct file *file,
-			  const char __user * buffer,
-			  size_t count, loff_t * data)
-{
-	int status;
-	struct seq_file *m = file->private_data;
-	struct acpi_video_bus *video = m->private;
-	char str[12] = { 0 };
-	unsigned long long opt, options;
-
-
-	if (!video || count >= sizeof(str))
-		return -EINVAL;
-
-	status = acpi_video_bus_POST_options(video, &options);
-	if (!ACPI_SUCCESS(status))
-		return -EINVAL;
-
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	str[count] = 0;
-	opt = strtoul(str, NULL, 0);
-	if (opt > 3)
-		return -EFAULT;
-
-	/* just in case an OEM 'forgot' the motherboard... */
-	options |= 1;
-
-	if (options & (1ul << opt)) {
-		status = acpi_video_bus_set_POST(video, opt);
-		if (!ACPI_SUCCESS(status))
-			return -EFAULT;
-
-	}
-
-	return count;
-}
-
-static ssize_t
-acpi_video_bus_write_DOS(struct file *file,
-			 const char __user * buffer,
-			 size_t count, loff_t * data)
-{
-	int status;
-	struct seq_file *m = file->private_data;
-	struct acpi_video_bus *video = m->private;
-	char str[12] = { 0 };
-	unsigned long opt;
-
-
-	if (!video || count >= sizeof(str))
-		return -EINVAL;
-
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	str[count] = 0;
-	opt = strtoul(str, NULL, 0);
-	if (opt > 7)
-		return -EFAULT;
-
-	status = acpi_video_bus_DOS(video, opt & 0x3, (opt & 0x4) >> 2);
-
-	if (!ACPI_SUCCESS(status))
-		return -EFAULT;
-
-	return count;
-}
-
-static int acpi_video_bus_add_fs(struct acpi_device *device)
-{
-	struct acpi_video_bus *video = acpi_driver_data(device);
-	struct proc_dir_entry *device_dir;
-	struct proc_dir_entry *entry;
-
-	device_dir = proc_mkdir(acpi_device_bid(device), acpi_video_dir);
-	if (!device_dir)
-		return -ENOMEM;
-
-	/* 'info' [R] */
-	entry = proc_create_data("info", S_IRUGO, device_dir,
-				 &acpi_video_bus_info_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_dir;
-
-	/* 'ROM' [R] */
-	entry = proc_create_data("ROM", S_IRUGO, device_dir,
-				 &acpi_video_bus_ROM_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_info;
-
-	/* 'POST_info' [R] */
-	entry = proc_create_data("POST_info", S_IRUGO, device_dir,
-				 &acpi_video_bus_POST_info_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_rom;
-
-	/* 'POST' [R/W] */
-	entry = proc_create_data("POST", S_IFREG | S_IRUGO | S_IWUSR,
-				 device_dir,
-				 &acpi_video_bus_POST_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_post_info;
-
-	/* 'DOS' [R/W] */
-	entry = proc_create_data("DOS", S_IFREG | S_IRUGO | S_IWUSR,
-				 device_dir,
-				 &acpi_video_bus_DOS_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		goto err_remove_post;
-
-	video->dir = acpi_device_dir(device) = device_dir;
-	return 0;
-
- err_remove_post:
-	remove_proc_entry("POST", device_dir);
- err_remove_post_info:
-	remove_proc_entry("POST_info", device_dir);
- err_remove_rom:
-	remove_proc_entry("ROM", device_dir);
- err_remove_info:
-	remove_proc_entry("info", device_dir);
- err_remove_dir:
-	remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
-	return -ENOMEM;
-}
-
-static int acpi_video_bus_remove_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *device_dir = acpi_device_dir(device);
-
-	if (device_dir) {
-		remove_proc_entry("info", device_dir);
-		remove_proc_entry("ROM", device_dir);
-		remove_proc_entry("POST_info", device_dir);
-		remove_proc_entry("POST", device_dir);
-		remove_proc_entry("DOS", device_dir);
-		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-#else
-static inline int acpi_video_device_add_fs(struct acpi_device *device)
-{
-	return 0;
-}
-static inline int acpi_video_device_remove_fs(struct acpi_device *device)
-{
-	return 0;
-}
-static inline int acpi_video_bus_add_fs(struct acpi_device *device)
-{
-	return 0;
-}
-static inline int acpi_video_bus_remove_fs(struct acpi_device *device)
-{
-	return 0;
-}
-#endif /* CONFIG_ACPI_PROCFS */
-
-/* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
@@ -1877,8 +1130,6 @@ acpi_video_bus_get_one_device(struct acp
 		list_add_tail(&data->entry, &video->video_device_list);
 		mutex_unlock(&video->device_list_lock);
 
-		acpi_video_device_add_fs(device);
-
 		return 0;
 	}
 
@@ -2181,8 +1432,6 @@ static int acpi_video_bus_put_one_device
 	if (!device || !device->video)
 		return -ENOENT;
 
-	acpi_video_device_remove_fs(device->dev);
-
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
@@ -2466,10 +1715,6 @@ static int acpi_video_bus_add(struct acp
 	if (error)
 		goto err_free_video;
 
-	error = acpi_video_bus_add_fs(device);
-	if (error)
-		goto err_free_video;
-
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
@@ -2522,7 +1767,6 @@ static int acpi_video_bus_add(struct acp
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
-	acpi_video_bus_remove_fs(device);
  err_free_video:
 	kfree(video);
 	device->driver_data = NULL;
@@ -2544,7 +1788,6 @@ static int acpi_video_bus_remove(struct 
 
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
-	acpi_video_bus_remove_fs(device);
 
 	input_unregister_device(video->input);
 	kfree(video->attached_array);
@@ -2584,17 +1827,9 @@ int acpi_video_register(void)
 		return 0;
 	}
 
-#ifdef CONFIG_ACPI_PROCFS
-	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
-	if (!acpi_video_dir)
-		return -ENODEV;
-#endif
-
 	result = acpi_bus_register_driver(&acpi_video_bus);
-	if (result < 0) {
-		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+	if (result < 0)
 		return -ENODEV;
-	}
 
 	/*
 	 * When the acpi_video_bus is loaded successfully, increase
@@ -2617,10 +1852,6 @@ void acpi_video_unregister(void)
 	}
 	acpi_bus_unregister_driver(&acpi_video_bus);
 
-#ifdef CONFIG_ACPI_PROCFS
-	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-#endif
-
 	register_count = 0;
 
 	return;


