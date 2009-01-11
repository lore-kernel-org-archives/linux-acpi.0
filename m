From: Jan Engelhardt <jengelh@medozas.de>
Subject: acpi: constify VFTs (2/2)
Date: Mon, 12 Jan 2009 00:08:19 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901120007570.20643@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901120007250.20643@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:52680 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZAKXIU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jan 2009 18:08:20 -0500
In-Reply-To: <alpine.LSU.2.00.0901120007250.20643@fbirervta.pbzchgretzou.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

parent a0fab196edee967a0ad7369c4dce37f162ce8369 (v2.6.29-rc1-10-ga0fab19)
commit 1cefe819cd790b90890f8a6735689343f986ed5c
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 12 00:07:32 2009 +0100

acpi: constify VFTs (2/2)

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 drivers/acpi/video.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index c3722cd..b78b08c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -217,19 +217,25 @@ static const struct file_operations acpi_video_bus_POST_info_fops = {
 };
 
 static int acpi_video_bus_POST_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_POST_fops = {
+static int acpi_video_bus_write_POST(struct file *file,
+	const char __user *buffer, size_t count, loff_t *data);
+static const struct file_operations acpi_video_bus_POST_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_bus_POST_open_fs,
 	.read = seq_read,
+	.write = acpi_video_bus_write_POST,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
 static int acpi_video_bus_DOS_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_DOS_fops = {
+static int acpi_video_bus_write_DOS(struct file *file,
+	const char __user *buffer, size_t count, loff_t *data);
+static const struct file_operations acpi_video_bus_DOS_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_bus_DOS_open_fs,
 	.read = seq_read,
+	.write = acpi_video_bus_write_DOS,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -247,20 +253,26 @@ static const struct file_operations acpi_video_device_info_fops = {
 
 static int acpi_video_device_state_open_fs(struct inode *inode,
 					   struct file *file);
-static struct file_operations acpi_video_device_state_fops = {
+static int acpi_video_device_write_state(struct file *file,
+	const char __user *buffer, size_t count, loff_t *data);
+static const struct file_operations acpi_video_device_state_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_device_state_open_fs,
 	.read = seq_read,
+	.write = acpi_video_device_write_state,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
 static int acpi_video_device_brightness_open_fs(struct inode *inode,
 						struct file *file);
+static int acpi_video_device_write_brightness(struct file *file,
+	const char __user *buffer, size_t count, loff_t *data);
 static struct file_operations acpi_video_device_brightness_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_device_brightness_open_fs,
 	.read = seq_read,
+	.write = acpi_video_device_write_brightness,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -275,7 +287,7 @@ static const struct file_operations acpi_video_device_EDID_fops = {
 	.release = single_release,
 };
 
-static char device_decode[][30] = {
+static const char device_decode[][30] = {
 	"motherboard VGA device",
 	"PCI VGA device",
 	"AGP VGA device",
@@ -1134,7 +1146,6 @@ static int acpi_video_device_add_fs(struct acpi_device *device)
 		goto err_remove_dir;
 
 	/* 'state' [R/W] */
-	acpi_video_device_state_fops.write = acpi_video_device_write_state;
 	entry = proc_create_data("state", S_IFREG | S_IRUGO | S_IWUSR,
 				 device_dir,
 				 &acpi_video_device_state_fops,
@@ -1143,8 +1154,6 @@ static int acpi_video_device_add_fs(struct acpi_device *device)
 		goto err_remove_info;
 
 	/* 'brightness' [R/W] */
-	acpi_video_device_brightness_fops.write =
-		acpi_video_device_write_brightness;
 	entry = proc_create_data("brightness", S_IFREG | S_IRUGO | S_IWUSR,
 				 device_dir,
 				 &acpi_video_device_brightness_fops,
@@ -1427,7 +1436,6 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 		goto err_remove_rom;
 
 	/* 'POST' [R/W] */
-	acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
 	entry = proc_create_data("POST", S_IFREG | S_IRUGO | S_IWUSR,
 				 device_dir,
 				 &acpi_video_bus_POST_fops,
@@ -1436,7 +1444,6 @@ static int acpi_video_bus_add_fs(struct acpi_device *device)
 		goto err_remove_post_info;
 
 	/* 'DOS' [R/W] */
-	acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
 	entry = proc_create_data("DOS", S_IFREG | S_IRUGO | S_IWUSR,
 				 device_dir,
 				 &acpi_video_bus_DOS_fops,
-- 
# Created with git-export-patch
