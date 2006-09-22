From: Zhang Rui <rui.zhang@intel.com>
Subject: [12/12] acpi: set fake hid
Date: Fri, 22 Sep 2006 17:54:40 +0800
Message-ID: <1158918880.11985.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28689 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750869AbWIVJyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:54:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

Set fake hid for non-PNPID ACPI devices.

We do this mainly because:
1.	hid is used to match ACPI devices and drivers.
	.match method which is incompatible to driver model 
	can be deleted from acpi_driver.ops then.
2.	As the .uevent method mark ACPI drivers by PNPID,
	fake hid is set to non-PNPID devices so that udev script 
	can load the right ACPI driver by looking for 
	"HWID = " or "COMPTID = ". 

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/pci_bind.c     |   20 +-------------
 drivers/acpi/scan.c         |   59 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/video.c        |   37 ---------------------------
 include/acpi/acpi_bus.h     |    6 ----
 include/acpi/acpi_drivers.h |    2 +
 5 files changed, 63 insertions(+), 61 deletions(-)

Index: linux-2.6.18/drivers/acpi/pci_bind.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/pci_bind.c	2006-09-21 16:14:53.000000000 +0800
+++ linux-2.6.18/drivers/acpi/pci_bind.c	2006-09-21 16:15:01.000000000 +0800
@@ -379,32 +379,16 @@ acpi_pci_bind_root(struct acpi_device *d
 
 static int acpi_pci_bridge_add(struct acpi_device *device);
 static int acpi_pci_bridge_remove(struct acpi_device *device, int type);
-static int acpi_pci_bridge_match(struct acpi_device *device,
-       struct acpi_driver *driver);
+
 static struct acpi_driver acpi_pci_bridge_driver = {
        .name = ACPI_PCI_BRIDGE_DRIVER_NAME,
+	.ids = ACPI_PCI_BRIDGE_HID,
        .ops = {
                .add = acpi_pci_bridge_add,
                .remove = acpi_pci_bridge_remove,
-               .match = acpi_pci_bridge_match,
        },
 };
 
-static int acpi_pci_bridge_match(struct acpi_device *device,
-       struct acpi_driver *driver)
-{
-       acpi_status status;
-       acpi_handle handle;
-
-       /* pci bridge has _PRT but isn't PNP0A03 */
-       status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
-       if (ACPI_FAILURE(status))
-               return -ENODEV;
-       if (!acpi_match_ids(device, "PNP0A03"))
-               return -ENODEV;
-       return 0;
-}
-
 static int acpi_pci_bridge_add(struct acpi_device *device)
 {
        return acpi_pci_bind(device);
Index: linux-2.6.18/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/scan.c	2006-09-21 16:14:53.000000000 +0800
+++ linux-2.6.18/drivers/acpi/scan.c	2006-09-21 16:15:01.000000000 +0800
@@ -166,8 +166,6 @@ static int acpi_bus_match(struct device 
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
 
-	if (acpi_drv->ops.match)
-		return !acpi_drv->ops.match(acpi_dev, acpi_drv);
 	return !acpi_match_ids(acpi_dev, acpi_drv->ids);
 }
 
@@ -706,6 +704,53 @@ static void acpi_device_get_busid(struct
 	}
 }
 
+static int
+acpi_video_bus_match(struct acpi_device *device)
+{
+	acpi_handle h_dummy1;
+	acpi_handle h_dummy2;
+	acpi_handle h_dummy3;
+
+
+	if (!device)
+		return -EINVAL;
+
+	/* Since there is no HID, CID for ACPI Video drivers, we have
+	 * to check well known required nodes for each feature we support.
+	 */
+
+	/* Does this device able to support video switching ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2)))
+		return 0;
+
+	/* Does this device able to retrieve a video ROM ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1)))
+		return 0;
+
+	/* Does this device able to configure which video head to be POSTed ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy2)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3)))
+		return 0;
+
+	return -ENODEV;
+}
+
+static int acpi_pci_bridge_match(struct acpi_device *device)
+{
+       acpi_status status;
+       acpi_handle handle;
+
+       /* pci bridge has _PRT but isn't PNP0A03 */
+       status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
+       if (ACPI_FAILURE(status))
+               return -ENODEV;
+       if (!acpi_match_ids(device, "PNP0A03"))
+               return -ENODEV;
+       return 0;
+}
+
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
@@ -736,6 +781,16 @@ static void acpi_device_set_id(struct ac
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
 		}
+
+		if(!(info->valid & (ACPI_VALID_HID | ACPI_VALID_CID))){
+			status = acpi_video_bus_match(device);
+			if(ACPI_SUCCESS(status))
+				hid = ACPI_VIDEO_HID;
+
+			status = acpi_pci_bridge_match(device);
+			if(ACPI_SUCCESS(status))
+				hid = ACPI_PCI_BRIDGE_HID;
+		}
 		break;
 	case ACPI_BUS_TYPE_POWER:
 		hid = ACPI_POWER_HID;
Index: linux-2.6.18/drivers/acpi/video.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/video.c	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.18/drivers/acpi/video.c	2006-09-21 16:15:01.000000000 +0800
@@ -65,16 +65,14 @@ MODULE_LICENSE("GPL");
 
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
-static int acpi_video_bus_match(struct acpi_device *device,
-				struct acpi_driver *driver);
 
 static struct acpi_driver acpi_video_bus = {
 	.name = ACPI_VIDEO_DRIVER_NAME,
 	.class = ACPI_VIDEO_CLASS,
+	.ids = ACPI_VIDEO_HID,
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
-		.match = acpi_video_bus_match,
 		},
 };
 
@@ -1774,39 +1772,6 @@ static int acpi_video_bus_remove(struct 
 	return 0;
 }
 
-static int
-acpi_video_bus_match(struct acpi_device *device, struct acpi_driver *driver)
-{
-	acpi_handle h_dummy1;
-	acpi_handle h_dummy2;
-	acpi_handle h_dummy3;
-
-
-	if (!device || !driver)
-		return -EINVAL;
-
-	/* Since there is no HID, CID for ACPI Video drivers, we have
-	 * to check well known required nodes for each feature we support.
-	 */
-
-	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy2)))
-		return 0;
-
-	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy1)))
-		return 0;
-
-	/* Does this device able to configure which video head to be POSTed ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy2)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy3)))
-		return 0;
-
-	return -ENODEV;
-}
-
 static int __init acpi_video_init(void)
 {
 	int result = 0;
Index: linux-2.6.18/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.18.orig/include/acpi/acpi_drivers.h	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.18/include/acpi/acpi_drivers.h	2006-09-21 16:15:01.000000000 +0800
@@ -43,6 +43,8 @@
 #define ACPI_BUTTON_HID_POWERF		"ACPI_FPB"
 #define ACPI_BUTTON_HID_SLEEPF		"ACPI_FSB"
 
+#define ACPI_VIDEO_HID			"ACPI_VID"
+#define ACPI_PCI_BRIDGE_HID		"ACPI_PCI"
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
Index: linux-2.6.18/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18.orig/include/acpi/acpi_bus.h	2006-09-21 16:14:05.000000000 +0800
+++ linux-2.6.18/include/acpi/acpi_bus.h	2006-09-21 16:15:01.000000000 +0800
@@ -97,8 +97,6 @@ typedef int (*acpi_op_resume) (struct ac
 typedef int (*acpi_op_scan) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
-typedef int (*acpi_op_match) (struct acpi_device * device,
-			      struct acpi_driver * driver);
 typedef int (*acpi_op_shutdown) (struct acpi_device * device);
 
 struct acpi_bus_ops {
@@ -112,9 +110,8 @@ struct acpi_bus_ops {
 	u32 acpi_op_scan:1;
 	u32 acpi_op_bind:1;
 	u32 acpi_op_unbind:1;
-	u32 acpi_op_match:1;
 	u32 acpi_op_shutdown:1;
-	u32 reserved:20;
+	u32 reserved:21;
 };
 
 struct acpi_device_ops {
@@ -128,7 +125,6 @@ struct acpi_device_ops {
 	acpi_op_scan scan;
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
-	acpi_op_match match;
 	acpi_op_shutdown shutdown;
 };
 
