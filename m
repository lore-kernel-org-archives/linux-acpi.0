From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V2 3/7] usb: Set device removable state based on ACPI USB data
Date: Fri,  4 May 2012 11:06:39 +0800
Message-ID: <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336100803-28353-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

ACPI offers two methods that allow us to infer whether or not a USB port
is removable. The _PLD method gives us information on whether the port is
"user visible" or not. If that's not present then we can fall back to the
_UPC method which tells us whether or not a port is connectable.

Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/usb/core/usb-acpi.c |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index cab5cb7..e49373a 100644
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
 	struct usb_device *udev;
@@ -40,6 +87,15 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
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
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
