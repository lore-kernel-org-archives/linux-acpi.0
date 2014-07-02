From: "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>
Subject: [PATCH 2/2] USB: Use ACPI device information
Date: Wed, 2 Jul 2014 09:01:09 +0000
Message-ID: <56D4B9BFEADA5948B14547D2A81CE2C027AC3BD8@HASMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10963 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaGBJBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2014 05:01:14 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Use ACPI device pld information instead of calling acpi_get_physical_device_location api

Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>

---
 drivers/usb/core/usb-acpi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 5ca4070..6528372 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -87,7 +87,7 @@ static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
     acpi_status status;
     struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
     union acpi_object *upc;
-    struct acpi_pld_info *pld;
+    struct acpi_device *adev;
     int ret = 0;

     /*
@@ -98,8 +98,8 @@ static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
      * a usb device is directly hard-wired to the port. If no visible and
      * no connectable, the port would be not used.
      */
-    status = acpi_get_physical_device_location(handle, &pld);
-    if (ACPI_FAILURE(status))
+    acpi_bus_get_device(handle, &adev);
+    if ((!adev) || (!adev->pld))
         return -ENODEV;

     status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
@@ -111,17 +111,16 @@ static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
     }

     if (upc->package.elements[0].integer.value)
-        if (pld->user_visible)
+        if (adev->pld->user_visible)
             usb_set_hub_port_connect_type(hdev, port1,
                 USB_PORT_CONNECT_TYPE_HOT_PLUG);
         else
             usb_set_hub_port_connect_type(hdev, port1,
                 USB_PORT_CONNECT_TYPE_HARD_WIRED);
-    else if (!pld->user_visible)
+    else if (!adev->pld->user_visible)
         usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);

 out:
-    ACPI_FREE(pld);
     kfree(upc);
     return ret;
 }
--

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

