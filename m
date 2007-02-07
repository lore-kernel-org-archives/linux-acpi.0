From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/140] ACPI: Convert ACPI PCI .bind/.unbind to use PCI bridge driver
Date: Wed,  7 Feb 2007 13:50:25 -0500
Message-ID: <11708743853573-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:22847 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422714AbXBGSxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:13 -0500
In-Reply-To: <11708743821259-git-send-email-lenb@kernel.org>
Message-Id: <db3e1cc3257758d8a694d0a6ab29f109fb019853.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
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
 drivers/acpi/scan.c     |   17 --------------
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 1e2ae6e..d833274 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -223,8 +223,6 @@ int acpi_pci_bind(struct acpi_device *device)
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
-		device->ops.bind = acpi_pci_bind;
-		device->ops.unbind = acpi_pci_unbind;
 	}
 
 	/*
@@ -354,8 +352,6 @@ acpi_pci_bind_root(struct acpi_device *device,
 
 	data->id = *id;
 	data->bus = bus;
-	device->ops.bind = acpi_pci_bind;
-	device->ops.unbind = acpi_pci_unbind;
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -378,3 +374,55 @@ acpi_pci_bind_root(struct acpi_device *device,
 
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
@@ -175,11 +175,6 @@ static int acpi_pci_root_add(struct acpi_device *device)
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
index 06b86fa..c566c74 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -866,11 +866,6 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 	if (!rmdevice)
 		return 0;
 
-	if (dev->flags.bus_address) {
-		if ((dev->parent) && (dev->parent->ops.unbind))
-			dev->parent->ops.unbind(dev);
-	}
-
 	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
 
 	return 0;
@@ -987,18 +982,6 @@ acpi_add_single_object(struct acpi_device **child,
 
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
1.5.0.rc3.39.gec804
