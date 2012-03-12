From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 4/4] usb: Set device removable state based on ACPI USB data
Date: Mon, 12 Mar 2012 19:58:55 -0400
Message-ID: <1331596735-3690-4-git-send-email-mjg@redhat.com>
References: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756951Ab2CLT6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2012 15:58:54 -0400
In-Reply-To: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org, Matthew Garrett <mjg@redhat.com>

ACPI offers two methods that allow us to infer whether or not a USB port
is removable. The _PLD method gives us information on whether the port is
"user visible" or not. If that's not present then we can fall back to the
_UPC method which tells us whether or not a port is connectable.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/usb/core/usb-acpi.c |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 1224c50..18bc4e7 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,6 +19,53 @@
 
 #include "usb.h"
 
+static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *upc;
+	int ret = 0;
+
+	status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	upc = buffer.pointer;
+
+	if (!upc || (upc->type != ACPI_TYPE_PACKAGE) || upc->package.count != 4) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (upc->package.elements[0].integer.value)
+		udev->removable = USB_DEVICE_REMOVABLE;
+	else
+		udev->removable = USB_DEVICE_FIXED;
+
+out:
+	kfree(upc);
+	return ret;
+}
+
+static int usb_acpi_check_pld(struct usb_device *udev, acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_pld pld;
+
+	status = acpi_get_physical_device_location(handle, &pld);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (pld.user_visible)
+		udev->removable = USB_DEVICE_REMOVABLE;
+	else
+		udev->removable = USB_DEVICE_FIXED;
+
+	return 0;
+}
+
 static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct usb_device *udev = to_usb_device(dev);
@@ -33,6 +80,15 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 	if (!*handle)
 		return -ENODEV;
 
+	/*
+	 * PLD will tell us whether a port is removable to the user or
+	 * not. If we don't get an answer from PLD (it's not present
+	 * or it's malformed) then try to infer it from UPC. If a
+	 * device isn't connectable then it's probably not removable.
+	 */
+	if (usb_acpi_check_pld(udev, *handle) != 0)
+		usb_acpi_check_upc(udev, *handle);
+
 	return 0;
 }
 
-- 
1.7.9.3

