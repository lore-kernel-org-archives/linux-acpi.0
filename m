From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: print out a warning message when duplicate
 video bus devices under the same VGA controller are detected
Date: Wed, 25 Nov 2009 17:16:48 +0800
Message-ID: <1259140608.10510.62.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43732 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbZKYJSJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 04:18:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Some buggy BIOS exports multiple ACPI video bus devices for the same
VGA controller, and multiple backlight control methods as well.
This may mess up the ACPI video backlight control.
http://bugzilla.kernel.org/show_bug.cgi?id=13577

We should at least send out a warning message in this case.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -2233,12 +2233,36 @@ static int acpi_video_resume(struct acpi
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
+		printk(KERN_WARNING FW_BUG "Duplicate ACPI video bus "
+				"devices for the same VGA controller\n");
+	return AE_OK;
+}
+
 static int acpi_video_bus_add(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
 
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, device->parent->handle,
+			    1, acpi_video_bus_match, device, NULL);
+
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;


