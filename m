From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 2/3] PCI: parallel resume for pci devices on bus 0
Date: Fri, 19 Dec 2008 14:34:13 +0800
Message-ID: <1229668453.562.92.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

device parallel resume support for PCI devices

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/pci/bus.c    |    4 ++++
 drivers/pci/remove.c |    2 ++
 2 files changed, 6 insertions(+)

Index: linux-2.6/drivers/pci/bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/bus.c
+++ linux-2.6/drivers/pci/bus.c
@@ -85,6 +85,10 @@ int pci_bus_add_device(struct pci_dev *d
 		return retval;
 
 	dev->is_added = 1;
+
+	/* parallel resume for pci devices on bus 0 */
+	if (dev->bus->number == 0)
+		device_parallel_resume_register(&dev->dev, 1);
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
 	return 0;
Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -92,6 +92,8 @@ EXPORT_SYMBOL(pci_remove_bus);
  */
 void pci_remove_bus_device(struct pci_dev *dev)
 {
+	if (dev->bus->number == 0 && dev->dev.resumed)
+		device_parallel_resume_unregister(&dev->dev);
 	if (dev->subordinate) {
 		struct pci_bus *b = dev->subordinate;
 
