From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/16] ACPI video: Prune dupe video devices,
 unless "video.allow_duplicates"
Date: Sat, 16 Jan 2010 02:32:53 -0500
Message-ID: <c504f8cb68eb0d6cde53ba043daff8cb34586493.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:38841 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab0APHdO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:14 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00EMNWZA96H0@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:11 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Some buggy BIOS exports multiple ACPI video bus devices for the same
VGA controller, and multiple backlight control methods as well.
This messes up the ACPI video backlight control.

http://bugzilla.kernel.org/show_bug.cgi?id=13577

With this patch applied, only the FIRST ACPI video bus device
under a PCI device node is bind to ACPI video driver by default.

If the first ACPI video bus device doesn't work well, we can use
video.allow_duplicates=1 to go back to the old behavior.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 05dff63..45e6a29 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -78,6 +78,13 @@ MODULE_LICENSE("GPL");
 static int brightness_switch_enabled = 1;
 module_param(brightness_switch_enabled, bool, 0644);
 
+/*
+ * By default, we don't allow duplicate ACPI video bus devices
+ * under the same VGA controller
+ */
+static int allow_duplicates;
+module_param(allow_duplicates, bool, 0644);
+
 static int register_count = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
@@ -2233,11 +2240,47 @@ static int acpi_video_resume(struct acpi_device *device)
 	return AE_OK;
 }
 
+static acpi_status
+acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
+			void **return_value)
+{
+	struct acpi_device *device = context;
+	struct acpi_device *sibling;
+	int result;
+
+	if (handle == device->handle)
+		return AE_CTRL_TERMINATE;
+
+	result = acpi_bus_get_device(handle, &sibling);
+	if (result)
+		return AE_OK;
+
+	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
+			return AE_ALREADY_EXISTS;
+
+	return AE_OK;
+}
+
 static int acpi_video_bus_add(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
+	acpi_status status;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
+				device->parent->handle, 1,
+				acpi_video_bus_match, NULL,
+				device, NULL);
+	if (status == AE_ALREADY_EXISTS) {
+		printk(KERN_WARNING FW_BUG
+			"Duplicate ACPI video bus devices for the"
+			" same VGA controller, please try module "
+			"parameter \"video.allow_duplicates=1\""
+			"if the current driver doesn't work.\n");
+		if (!allow_duplicates)
+			return -ENODEV;
+	}
 
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
-- 
1.6.0.6

