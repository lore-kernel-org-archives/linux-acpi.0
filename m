From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH -mm] ACPI video: only one ACPI bus video device is allowed
	for one VGA controller
Date: Wed, 15 Jul 2009 17:18:08 +0800
Message-ID: <1247649488.26272.106.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63498 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbZGOJRT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 05:17:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, hector@marcansoft.com


Only one ACPI video bus device for a VGA controller.

Some buggy BIOS exports multiple ACPI video bus devices for the same
VGA controller, and multiple backlight control methods as well.
This messes up the ACPI video backlight control.
http://bugzilla.kernel.org/show_bug.cgi?id=13577

With this patch applied, only the first ACPI video bus device
under a PCI device node is bind to ACPI video driver.

The questions is that, we never notice this kind of devices before,
thus I'm not sure this won't break any laptops.

I suggest we put this patch in ACPI test tree first.

Tested-by: Hector Martin <hector@marcansoft.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -2195,11 +2195,43 @@ static int acpi_video_resume(struct acpi
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
+	/* only one ACPI bus video device under a PCI device */
+	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
+		return AE_ALREADY_EXISTS;
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
+				acpi_video_bus_match, device, NULL);
+	if (status == AE_ALREADY_EXISTS) {
+		printk(KERN_WARNING PREFIX, "Duplicate ACPI video bus "
+				"devices for the same VGA controller\n");
+		return -ENODEV;
+	}
 
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)


