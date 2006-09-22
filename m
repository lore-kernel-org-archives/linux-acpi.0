From: Zhang Rui <rui.zhang@intel.com>
Subject: [11/12] acpi: acpi pci bridge driver
Date: Fri, 22 Sep 2006 17:51:29 +0800
Message-ID: <1158918689.11985.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11285 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751142AbWIVJt4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:49:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Li Shaohua <shaohua.li@intel.com>

acpi_device had a .bind/.unbind methods, but Linux driver model does not.
Cut ACPI PCI code over to use the Linux driver model methods.

Convert bin/unbind to use a new pci bridge driver.
The driver will add/remove _PRT, so we can eventually
remove .bind/.unbind methods.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/pci_bind.c |   56 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/acpi/pci_root.c |    5 ----
 drivers/acpi/scan.c     |   17 ++------------
 3 files changed, 55 insertions(+), 23 deletions(-)

Index: linux-2.6.18-rc7/drivers/acpi/pci_bind.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/pci_bind.c	2006-09-14 13:26:47.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/pci_bind.c	2006-09-19 19:55:52.000000000 +0800
@@ -223,8 +223,6 @@ int acpi_pci_bind(struct acpi_device *de
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
-		device->ops.bind = acpi_pci_bind;
-		device->ops.unbind = acpi_pci_unbind;
 	}
 
 	/*
@@ -354,8 +352,6 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	data->id = *id;
 	data->bus = bus;
-	device->ops.bind = acpi_pci_bind;
-	device->ops.unbind = acpi_pci_unbind;
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -378,3 +374,55 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	return result;
 }
+
+#define ACPI_PCI_BRIDGE_DRIVER_NAME "ACPI PCI Bridge Driver"
+
+static int acpi_pci_bridge_add(struct acpi_device *device);
+static int acpi_pci_bridge_remove(struct acpi_device *device, int type);
+static int acpi_pci_bridge_match(struct acpi_device *device,
+       struct acpi_driver *driver);
+static struct acpi_driver acpi_pci_bridge_driver = {
+       .name = ACPI_PCI_BRIDGE_DRIVER_NAME,
+       .ops = {
+               .add = acpi_pci_bridge_add,
+               .remove = acpi_pci_bridge_remove,
+               .match = acpi_pci_bridge_match,
+       },
+};
+
+static int acpi_pci_bridge_match(struct acpi_device *device,
+       struct acpi_driver *driver)
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
+static int acpi_pci_bridge_add(struct acpi_device *device)
+{
+       return acpi_pci_bind(device);
+}
+
+static int acpi_pci_bridge_remove(struct acpi_device *device, int type)
+{
+       return acpi_pci_unbind(device);
+}
+
+static int __init acpi_pci_bridge_init(void)
+{
+       if (acpi_pci_disabled)
+               return 0;
+       if (acpi_bus_register_driver(&acpi_pci_bridge_driver) < 0)
+               return -ENODEV;
+       return 0;
+}
+
+/* Should be called after ACPI pci root driver */
+subsys_initcall(acpi_pci_bridge_init);
Index: linux-2.6.18-rc7/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/pci_root.c	2006-09-14 13:26:47.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/pci_root.c	2006-09-19 19:55:52.000000000 +0800
@@ -175,11 +175,6 @@ static int acpi_pci_root_add(struct acpi
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	acpi_driver_data(device) = root;
 
-	/*
-	 * TBD: Doesn't the bus driver automatically set this?
-	 */
-	device->ops.bind = acpi_pci_bind;
-
 	/* 
 	 * Segment
 	 * -------
Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-19 19:55:25.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-19 19:55:52.000000000 +0800
@@ -865,12 +865,13 @@ static int acpi_bus_remove(struct acpi_d
 
 	if (!rmdevice)
 		return 0;
-
+	/* FIXME: device_release_driver will automically call unbind, is this ok */
+#if 0
 	if (dev->flags.bus_address) {
 		if ((dev->parent) && (dev->parent->ops.unbind))
 			dev->parent->ops.unbind(dev);
 	}
-
+#endif
 	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
 
 	return 0;
@@ -987,18 +988,6 @@ acpi_add_single_object(struct acpi_devic
 
 	acpi_device_register(device, parent);
 
-	/*
-	 * Bind _ADR-Based Devices
-	 * -----------------------
-	 * If there's a a bus address (_ADR) then we utilize the parent's 
-	 * 'bind' function (if exists) to bind the ACPI- and natively-
-	 * enumerated device representations.
-	 */
-	if (device->flags.bus_address) {
-		if (device->parent && device->parent->ops.bind)
-			device->parent->ops.bind(device);
-	}
-
       end:
 	if (!result)
 		*child = device;
