From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/13] ACPI: Convert ACPI PCI .bind/.unbind to use PCI bridge driver
Date: Fri, 24 Nov 2006 00:17:39 -0500
Message-ID: <11643454741258-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com> <11643454642611-git-send-email-len.brown@intel.com> <11643454652241-git-send-email-len.brown@intel.com> <11643454662740-git-send-email-len.brown@intel.com> <1164345468324-git-send-email-len.brown@intel.com> <11643454703489-git-send-email-len.brown@intel.com> <11643454711040-git-send-email-len.brown@intel.com> <11643454722679-git-send-email-len.brown@intel.com> <11643454732506-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14415 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934292AbWKXFOE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:14:04 -0500
In-Reply-To: <11643454732506-git-send-email-len.brown@intel.com>
Message-Id: <e3eb7f2f2601e00fd34cf1e0b1f0c7cd324e0b6b.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Li Shaohua <shaohua.li@intel.com>

acpi_device had a .bind/.unbind methods, but Linux driver model does not.
Cut ACPI PCI code over to use the Linux driver model methods.

Convert bind/unbind to use a new pci bridge driver.
The driver will add/remove _PRT, so we can eventually
remove .bind/.unbind methods.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_bind.c |   56 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/acpi/pci_root.c |    5 ----
 drivers/acpi/scan.c     |   17 ++-----------
 3 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 1e2ae6e..d833274 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
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
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0984a1e..9cfc741 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
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
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 06b86fa..b5fab54 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
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
-- 
1.4.4.g59427
