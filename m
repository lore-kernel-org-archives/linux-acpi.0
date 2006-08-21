From: danny@mailmij.org
Subject: double proc entries
Date: Mon, 21 Aug 2006 04:49:15 +0200
Message-ID: <20060821044915.B18790@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.mailmij.org ([82.93.140.149]:53953 "EHLO mail.mailmij.org")
	by vger.kernel.org with ESMTP id S932528AbWHUCtT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Aug 2006 22:49:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Recently I noticed that unloading video.ko causes a warning from remove_proc_entry because the subdir is not empty. This is related to the fact that I have 2 VID 
entries in /proc/acpi/video, and this messes up things a bit. The cause of this is that the VID entry appears both on the PCI and on the AGP bus, sysfs handles this 
nicely:
./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID
./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID/DVI0
./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID/CRT0
./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID/LCD0
./firmware/acpi/namespace/ACPI/_SB/PCI0/VID
./firmware/acpi/namespace/ACPI/_SB/PCI0/VID/DVI0
./firmware/acpi/namespace/ACPI/_SB/PCI0/VID/CRT0
./firmware/acpi/namespace/ACPI/_SB/PCI0/VID/LCD0


More information can be found here:
http://qa.mandriva.com/show_bug.cgi?id=22249

proc/acpi/video/ does not know about AGP or PCI. Attached patch fixes the problem but is not so beautiful.
Maybe it's better to make another subdir in video for the parent of the device, but I thought this would be more likely to break userland apps.
Perhaps someone can do better.

Regards,

Danny

(Please CC on reply).


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi_fix-double-proc-entries.patch"

--- linux/drivers/acpi/video.c.orig	2006-06-20 18:31:55.000000000 +0900
+++ linux/drivers/acpi/video.c	2006-08-21 11:23:29.000000000 +0900
@@ -1183,13 +1183,18 @@
 {
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_video_bus *video;
+	char proc_dir_name[32];
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_add_fs");
 
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
-
+
 	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
+		strcpy(proc_dir_name, acpi_device_bid(device));
+		strcat(proc_dir_name, "_");
+		strcat(proc_dir_name, acpi_device_bid(device->parent));
+
+		acpi_device_dir(device) = proc_mkdir(proc_dir_name,
 						     acpi_video_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
@@ -1265,6 +1270,7 @@
 static int acpi_video_bus_remove_fs(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
+	char proc_dir_name[32];
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_remove_fs");
 
@@ -1276,7 +1282,11 @@
 		remove_proc_entry("POST_info", acpi_device_dir(device));
 		remove_proc_entry("POST", acpi_device_dir(device));
 		remove_proc_entry("DOS", acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
+
+		strcpy(proc_dir_name, acpi_device_bid(device));
+		strcat(proc_dir_name, "_");
+		strcat(proc_dir_name, acpi_device_bid(device->parent));
+		remove_proc_entry(proc_dir_name, acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
@@ -1748,12 +1758,13 @@
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
-
+	char proc_dir_name[32];
+	
 	ACPI_FUNCTION_TRACE("acpi_video_bus_add");
 
 	if (!device)
 		return_VALUE(-EINVAL);
-
+
 	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return_VALUE(-ENOMEM);
@@ -1789,8 +1800,12 @@
 		goto end;
 	}
 
+	strcpy(proc_dir_name, acpi_device_bid(device));
+	strcat(proc_dir_name, "_");
+	strcat(proc_dir_name, acpi_device_bid(device->parent));
+
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+	       ACPI_VIDEO_DEVICE_NAME, proc_dir_name,
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");

--d6Gm4EdcadzBjdND--
