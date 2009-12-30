From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: introduce module parameter video.allow_duplicates
Date: Wed, 30 Dec 2009 15:59:23 +0800
Message-ID: <1262159963.12263.1402.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53189 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbZL3H6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Dec 2009 02:58:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, hector@marcansoft.com, rui.zhang@intel.com


Introduce module parameter video.allow_duplicates.

Some buggy BIOS exports multiple ACPI video bus devices for the same
VGA controller, and multiple backlight control methods as well.
This messes up the ACPI video backlight control.
http://bugzilla.kernel.org/show_bug.cgi?id=13577

With this patch applied, only the FIRST ACPI video bus device
under a PCI device node is bind to ACPI video driver by default.

If the first ACPI video bus device doesn't work well, we can use
video.allow_duplicates=1 to go back to the old behavior.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
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
@@ -2233,11 +2240,47 @@ static int acpi_video_resume(struct acpi
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


