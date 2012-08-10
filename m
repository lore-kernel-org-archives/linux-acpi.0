From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: [PATCH 3/7][RESEND] ACPI, PCI: Use normal list for struct
 acpi_pci_driver
Date: Fri, 10 Aug 2012 15:12:58 +0900
Message-ID: <20120810151258.63828afb.izumi.taku@jp.fujitsu.com>
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

    ACPI, PCI: Use normal list for struct acpi_pci_driver
    
    Use normal list for struct acpi_pci_driver to simplify code.
    
    Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c |   16 +++-------------
 include/linux/acpi.h    |    2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)

Index: Bjorn-next-0808/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0808.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0808/drivers/acpi/pci_root.c
@@ -72,8 +72,8 @@ static struct acpi_driver acpi_pci_root_
 };
 
 static LIST_HEAD(acpi_pci_roots);
+static LIST_HEAD(acpi_pci_drivers);
 
-static struct acpi_pci_driver *sub_driver;
 static DEFINE_MUTEX(osc_lock);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
@@ -81,10 +81,7 @@ int acpi_pci_register_driver(struct acpi
 	int n = 0;
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr)
-		pptr = &(*pptr)->next;
-	*pptr = driver;
+	list_add_tail(&driver->node, &acpi_pci_drivers);
 
 	if (!driver->add)
 		return 0;
@@ -103,14 +100,7 @@ void acpi_pci_unregister_driver(struct a
 {
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr) {
-		if (*pptr == driver)
-			break;
-		pptr = &(*pptr)->next;
-	}
-	BUG_ON(!*pptr);
-	*pptr = (*pptr)->next;
+	list_del(&driver->node);
 
 	if (!driver->remove)
 		return;
Index: Bjorn-next-0808/include/linux/acpi.h
===================================================================
--- Bjorn-next-0808.orig/include/linux/acpi.h
+++ Bjorn-next-0808/include/linux/acpi.h
@@ -138,7 +138,7 @@ void acpi_penalize_isa_irq(int irq, int 
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head node;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };
