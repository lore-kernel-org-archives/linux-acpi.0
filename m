From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/140] ACPI: fix Supermicro X7DB8+ Boot regression
Date: Wed,  7 Feb 2007 13:50:31 -0500
Message-ID: <11708743972593-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7926 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422724AbXBGSxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:20 -0500
In-Reply-To: <11708743962377-git-send-email-lenb@kernel.org>
Message-Id: <2786f6e388e9dfe9e7b1c3c6bd7fcfba9cfb9831.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rui Zhang <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Rui Zhang <rui.zhang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7695

Originally we converted bind/unbind to use a new pci bridge driver.
The driver will add/remove _PRT, so we can eventually remove
.bind/.unbind methods.

But we found that some of the _ADR-Based devices don't have _PRT,
i.e. they are not managed by the new ACPI PCI bridge driver.
So that .bind method is not called for some _ADR-Based devices,
which leads to a failure.

Now we make ACPI PCI Root Bridge Driver scan and binds all _ADR-Based devices
once the driver is loaded, in the .add method of ACPI PCI Root Bridge driver.

Extra code path for calling .bind/.unbind when _ADR-Based devices
are hot added/removed is also added.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_bind.c     |   40 ++++------------------------------------
 drivers/acpi/pci_root.c     |   24 ++++++++++++++++++++++++
 drivers/acpi/scan.c         |   33 +++++++++++++++------------------
 include/acpi/acpi_drivers.h |    1 -
 4 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index aa05e92..1e2ae6e 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -223,6 +223,8 @@ int acpi_pci_bind(struct acpi_device *device)
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
+		device->ops.bind = acpi_pci_bind;
+		device->ops.unbind = acpi_pci_unbind;
 	}
 
 	/*
@@ -352,6 +354,8 @@ acpi_pci_bind_root(struct acpi_device *device,
 
 	data->id = *id;
 	data->bus = bus;
+	device->ops.bind = acpi_pci_bind;
+	device->ops.unbind = acpi_pci_unbind;
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -374,39 +378,3 @@ acpi_pci_bind_root(struct acpi_device *device,
 
 	return result;
 }
-
-#define ACPI_PCI_BRIDGE_DRIVER_NAME "ACPI PCI Bridge Driver"
-
-static int acpi_pci_bridge_add(struct acpi_device *device);
-static int acpi_pci_bridge_remove(struct acpi_device *device, int type);
-
-static struct acpi_driver acpi_pci_bridge_driver = {
-       .name = ACPI_PCI_BRIDGE_DRIVER_NAME,
-	.ids = ACPI_PCI_BRIDGE_HID,
-       .ops = {
-               .add = acpi_pci_bridge_add,
-               .remove = acpi_pci_bridge_remove,
-       },
-};
-
-static int acpi_pci_bridge_add(struct acpi_device *device)
-{
-       return acpi_pci_bind(device);
-}
-
-static int acpi_pci_bridge_remove(struct acpi_device *device, int type)
-{
-       return acpi_pci_unbind(device);
-}
-
-static int __init acpi_pci_bridge_init(void)
-{
-       if (acpi_pci_disabled)
-               return 0;
-       if (acpi_bus_register_driver(&acpi_pci_bridge_driver) < 0)
-               return -ENODEV;
-       return 0;
-}
-
-/* Should be called after ACPI pci root driver */
-subsys_initcall(acpi_pci_bridge_init);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9cfc741..2e1a74a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -151,6 +151,21 @@ static acpi_status try_get_root_bridge_busnr(acpi_handle handle, int *busnum)
 	return AE_OK;
 }
 
+static void acpi_pci_bridge_scan(struct acpi_device *device)
+{
+	int status;
+	struct acpi_device *child = NULL;
+
+	if (device->flags.bus_address)
+		if (device->parent && device->parent->ops.bind) {
+			status = device->parent->ops.bind(device);
+			if (!status) {
+				list_for_each_entry(child, &device->children, node)
+					acpi_pci_bridge_scan(child);
+			}
+		}
+}
+
 static int acpi_pci_root_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -159,6 +174,7 @@ static int acpi_pci_root_add(struct acpi_device *device)
 	acpi_status status = AE_OK;
 	unsigned long value = 0;
 	acpi_handle handle = NULL;
+	struct acpi_device *child;
 
 
 	if (!device)
@@ -175,6 +191,8 @@ static int acpi_pci_root_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	acpi_driver_data(device) = root;
 
+	device->ops.bind = acpi_pci_bind;
+
 	/* 
 	 * Segment
 	 * -------
@@ -294,6 +312,12 @@ static int acpi_pci_root_add(struct acpi_device *device)
 		result = acpi_pci_irq_add_prt(device->handle, root->id.segment,
 					      root->id.bus);
 
+	/*
+	 * Scan and bind all _ADR-Based Devices
+	 */
+	list_for_each_entry(child, &device->children, node)
+		acpi_pci_bridge_scan(child);
+
       end:
 	if (result) {
 		if (!list_empty(&root->node))
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 769e54b..30a39ba 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -837,20 +837,6 @@ acpi_video_bus_match(struct acpi_device *device)
 	return -ENODEV;
 }
 
-static int acpi_pci_bridge_match(struct acpi_device *device)
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
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
@@ -886,10 +872,6 @@ static void acpi_device_set_id(struct acpi_device *device,
 			status = acpi_video_bus_match(device);
 			if(ACPI_SUCCESS(status))
 				hid = ACPI_VIDEO_HID;
-
-			status = acpi_pci_bridge_match(device);
-			if(ACPI_SUCCESS(status))
-				hid = ACPI_PCI_BRIDGE_HID;
 		}
 		break;
 	case ACPI_BUS_TYPE_POWER:
@@ -1021,6 +1003,13 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 	if (!rmdevice)
 		return 0;
 
+	/*
+	 * unbind _ADR-Based Devices when hot removal
+	 */
+	if (dev->flags.bus_address) {
+		if ((dev->parent) && (dev->parent->ops.unbind))
+			dev->parent->ops.unbind(dev);
+	}
 	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
 
 	return 0;
@@ -1137,6 +1126,14 @@ acpi_add_single_object(struct acpi_device **child,
 
 	result = acpi_device_register(device, parent);
 
+	/*
+	 * Bind _ADR-Based Devices when hot add
+	 */
+	if (device->flags.bus_address) {
+		if (device->parent && device->parent->ops.bind)
+			device->parent->ops.bind(device);
+	}
+
       end:
 	if (!result)
 		*child = device;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index be67750..2781e66 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -44,7 +44,6 @@
 #define ACPI_BUTTON_HID_SLEEPF		"ACPI_FSB"
 
 #define ACPI_VIDEO_HID			"ACPI_VID"
-#define ACPI_PCI_BRIDGE_HID		"ACPI_PCI"
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
-- 
1.5.0.rc3.39.gec804
