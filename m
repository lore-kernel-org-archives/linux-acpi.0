From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging
 PCI root bridges
Date: Mon, 3 Sep 2012 17:04:42 +0900
Message-ID: <20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44756 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab2ICIER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2012 04:04:17 -0400
In-Reply-To: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org, jiang.liu@huawei.com

From: Jiang Liu <jiang.liu@huawei.com>

  ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
    
  When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
  methods should be invoked to notify registered drivers.
    
  -v2: Move add calling to acpi_pci_root_start by Yinghai
    
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: Bjorn-next-0808/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0808.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0808/drivers/acpi/pci_root.c
@@ -626,14 +626,25 @@ end:
 static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct acpi_pci_driver *driver;
+
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->add)
+			driver->add(device->handle);
 
 	pci_bus_add_devices(root->bus);
+
 	return 0;
 }
 
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct acpi_pci_driver *driver;
+
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->remove)
+			driver->remove(root->device->handle);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);

