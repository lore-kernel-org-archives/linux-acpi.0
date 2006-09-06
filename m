From: danny@mailmij.org
Subject: Re: double proc entries
Date: Wed, 6 Sep 2006 09:27:31 +0200
Message-ID: <20060906092731.A16651@luna.ellen.dexterslabs.com>
References: <20060821044915.B18790@luna.ellen.dexterslabs.com> <200608211649.13421.luming.yu@intel.com> <20060821105042.C22067@luna.ellen.dexterslabs.com> <200608211802.30792.len.brown@intel.com> <20060824034621.A32220@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.mailmij.org ([82.93.140.149]:28640 "EHLO mail.mailmij.org")
	by vger.kernel.org with ESMTP id S1751568AbWIFH1d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 03:27:33 -0400
Content-Disposition: inline
In-Reply-To: <20060824034621.A32220@luna.ellen.dexterslabs.com>; from danny@mailmij.org on Thu, Aug 24, 2006 at 03:46:21AM +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: danny@mailmij.org
Cc: Len Brown <lenb@kernel.org>, Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org

On Thu, Aug 24, 2006 at 03:46:21AM +0200, danny@mailmij.org wrote:
> Ok. I made an updated version. I leave it to you to decide to remove the proc entries or to push 
> something like this upstream for the time being. On my laptop this patch seems to resolve the problems.
> 
<snip>

Please ignore that version. It was severly broken (oops) the moment the name of video bus was not 3 but
4 bytes long (the string would not be nulterminated by strcpy, leading to overflows if we use strcat
afterthat). Thanks to Arnaud Patard for pointing this out to me, and also for the fix: just initialize
all elements to 0.

Updated version follows.

    Acpi bus ids are not necessarily unique. For example, the VID entry can appear on both
    the PCI and on the AGP bus. The proc entries for the acpi video devices were not aware 
    of this. Therefore, a double VID entry could occur in /proc/acpi/video/. This also lead
    to a warning on remove_proc_entry because the wrong directory was removed first.

    This patch renames the VID entries to include their parent bus (ie VID_PCI0 and VID_AGP).

    Signed-off-by: Danny Tholen <obiwan@mailmij.org>
 
--- linux-2.6.17.1/drivers/acpi/video.c.orig	2006-09-06 08:27:13.000000000 +0200
+++ linux-2.6.17.1/drivers/acpi/video.c	2006-09-06 09:17:14.000000000 +0200
@@ -1183,13 +1183,19 @@
 {
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_video_bus *video;
+	char proc_dir_name[ACPI_NAME_SIZE*2+2];
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_add_fs");
 
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
 
 	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
+		memset(proc_dir_name, 0x00, ACPI_NAME_SIZE*2+2);
+		strncpy(proc_dir_name, acpi_device_bid(device), ACPI_NAME_SIZE);
+		strcat(proc_dir_name, "_");
+		strncat(proc_dir_name, acpi_device_bid(device->parent), ACPI_NAME_SIZE);
+
+		acpi_device_dir(device) = proc_mkdir(proc_dir_name,
 						     acpi_video_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
@@ -1265,6 +1271,7 @@
 static int acpi_video_bus_remove_fs(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
+	char proc_dir_name[ACPI_NAME_SIZE*2+2];
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_remove_fs");
 
@@ -1276,7 +1283,12 @@
 		remove_proc_entry("POST_info", acpi_device_dir(device));
 		remove_proc_entry("POST", acpi_device_dir(device));
 		remove_proc_entry("DOS", acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
+
+		memset(proc_dir_name, 0x00, ACPI_NAME_SIZE*2+2);
+		strncpy(proc_dir_name, acpi_device_bid(device), ACPI_NAME_SIZE);
+		strcat(proc_dir_name, "_");
+		strncat(proc_dir_name, acpi_device_bid(device->parent), ACPI_NAME_SIZE);
+		remove_proc_entry(proc_dir_name, acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
@@ -1796,8 +1808,9 @@
 		goto end;
 	}
 
-	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
+	printk(KERN_INFO PREFIX "%s [%s_%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+	       acpi_device_bid(device->parent),
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
