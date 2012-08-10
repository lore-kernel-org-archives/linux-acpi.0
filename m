From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: [PATCH 4/7][RESEND] ACPI, PCI: Notify acpi_pci_drivers when
 hot-plugging PCI root bridges
Date: Fri, 10 Aug 2012 15:13:44 +0900
Message-ID: <20120810151344.23304526.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org, jiang.liu@huawei.com
List-Id: linux-acpi@vger.kernel.org

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
