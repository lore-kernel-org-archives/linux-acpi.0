From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ACPI: Tie ACPI backlight devices to PCI devices if possible
Date: Thu,  9 Sep 2010 13:39:45 -0400
Message-ID: <1284053985-11254-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab0IIRkC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Sep 2010 13:40:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Dual-GPU machines may provide more than one ACPI backlight interface. Tie
the backlight device to the GPU in order to allow userspace to identify
the correct interface.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index fbae6f5..8c45980 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -950,6 +950,9 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 	if (acpi_video_backlight_support()) {
 		struct backlight_properties props;
+		struct pci_dev *pdev;
+		acpi_handle acpi_parent;
+		struct device *parent = NULL;
 		int result;
 		static int count = 0;
 		char *name;
@@ -962,10 +965,20 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 			return;
 		count++;
 
+		acpi_get_parent(device->dev->handle, &acpi_parent);
+
+		pdev = acpi_get_pci_dev(acpi_parent);
+		if (pdev) {
+			parent = &pdev->dev;
+			pci_dev_put(pdev);
+		}
+
 		memset(&props, 0, sizeof(struct backlight_properties));
 		props.type = BACKLIGHT_FIRMWARE;
 		props.max_brightness = device->brightness->count - 3;
-		device->backlight = backlight_device_register(name, NULL, device,
+		device->backlight = backlight_device_register(name,
+							      parent,
+							      device,
 							      &acpi_backlight_ops,
 							      &props);
 		kfree(name);
-- 
1.7.2.1

