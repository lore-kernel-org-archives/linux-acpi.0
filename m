From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2] PCI hotplug: move IOAPIC support from acpiphp to ioapic
	driver
Date: Mon, 26 Oct 2009 11:20:47 -0600
Message-ID: <20091026172047.22955.33883.stgit@bob.kio>
References: <20091026172015.22955.77484.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091026172015.22955.77484.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch moves PCI I/O APIC support from acpiphp to a separate driver.

Like pciehp and shpchp, acpiphp handles PCI hotplug, i.e., addition and
removal of PCI adapters.  But in addition, acpiphp handles some ACPI
hotplug, such as the addition of new host bridges, and the I/O APIC
support was tangled up with that.

I don't think the I/O APIC support needs to be in acpiphp; PCI I/O APICs
usually appear as a function on a PCI host bridge, and we'll enumerate the
APIC before any of the devices behind the bridge that use it.

As far as I know, nobody actually uses I/O APIC hotplug.  It depends on
acpi_register_ioapic(), which is only implemented for ia64, and I don't
think any vendors have supported I/O chassis hotplug yet.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
CC: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
---
 drivers/pci/Kconfig                |    7 +
 drivers/pci/Makefile               |    2 
 drivers/pci/hotplug/acpiphp.h      |    6 -
 drivers/pci/hotplug/acpiphp_glue.c |  190 ------------------------------------
 drivers/pci/ioapic.c               |  127 ++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 196 deletions(-)
 create mode 100644 drivers/pci/ioapic.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index fdc864f..d7d28ae 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -69,3 +69,10 @@ config PCI_IOV
 	  physical resources.
 
 	  If unsure, say N.
+
+config PCI_IOAPIC
+	bool
+	depends on PCI
+	depends on ACPI
+	depends on HOTPLUG
+	default y
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 4a7f11d..4df48d5 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,8 @@ CFLAGS_legacy.o += -Wno-deprecated-declarations
 # Build PCI Express stuff if needed
 obj-$(CONFIG_PCIEPORTBUS) += pcie/
 
+obj-$(CONFIG_PCI_IOAPIC) += ioapic.o
+
 obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 7d938df..bab5204 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -146,12 +146,6 @@ struct acpiphp_attention_info
 	struct module *owner;
 };
 
-struct acpiphp_ioapic {
-	struct pci_dev *dev;
-	u32 gsi_base;
-	struct list_head list;
-};
-
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 58d25a1..392e4b3 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -52,8 +52,6 @@
 #include "acpiphp.h"
 
 static LIST_HEAD(bridge_list);
-static LIST_HEAD(ioapic_list);
-static DEFINE_SPINLOCK(ioapic_list_lock);
 
 #define MY_NAME "acpiphp_glue"
 
@@ -606,190 +604,6 @@ static void remove_bridge(acpi_handle handle)
 					   handle_hotplug_event_bridge);
 }
 
-static struct pci_dev * get_apic_pci_info(acpi_handle handle)
-{
-	struct pci_dev *dev;
-
-	dev = acpi_get_pci_dev(handle);
-	if (!dev)
-		return NULL;
-
-	if ((dev->class != PCI_CLASS_SYSTEM_PIC_IOAPIC) &&
-	    (dev->class != PCI_CLASS_SYSTEM_PIC_IOXAPIC))
-	{
-		pci_dev_put(dev);
-		return NULL;
-	}
-
-	return dev;
-}
-
-static int get_gsi_base(acpi_handle handle, u32 *gsi_base)
-{
-	acpi_status status;
-	int result = -1;
-	unsigned long long gsb;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *obj;
-	void *table;
-
-	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gsb);
-	if (ACPI_SUCCESS(status)) {
-		*gsi_base = (u32)gsb;
-		return 0;
-	}
-
-	status = acpi_evaluate_object(handle, "_MAT", NULL, &buffer);
-	if (ACPI_FAILURE(status) || !buffer.length || !buffer.pointer)
-		return -1;
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_BUFFER)
-		goto out;
-
-	table = obj->buffer.pointer;
-	switch (((struct acpi_subtable_header *)table)->type) {
-	case ACPI_MADT_TYPE_IO_SAPIC:
-		*gsi_base = ((struct acpi_madt_io_sapic *)table)->global_irq_base;
-		result = 0;
-		break;
-	case ACPI_MADT_TYPE_IO_APIC:
-		*gsi_base = ((struct acpi_madt_io_apic *)table)->global_irq_base;
-		result = 0;
-		break;
-	default:
-		break;
-	}
- out:
-	kfree(buffer.pointer);
-	return result;
-}
-
-static acpi_status
-ioapic_add(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	acpi_status status;
-	unsigned long long sta;
-	acpi_handle tmp;
-	struct pci_dev *pdev;
-	u32 gsi_base;
-	u64 phys_addr;
-	struct acpiphp_ioapic *ioapic;
-
-	/* Evaluate _STA if present */
-	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_SUCCESS(status) && sta != ACPI_STA_ALL)
-		return AE_CTRL_DEPTH;
-
-	/* Scan only PCI bus scope */
-	status = acpi_get_handle(handle, "_HID", &tmp);
-	if (ACPI_SUCCESS(status))
-		return AE_CTRL_DEPTH;
-
-	if (get_gsi_base(handle, &gsi_base))
-		return AE_OK;
-
-	ioapic = kmalloc(sizeof(*ioapic), GFP_KERNEL);
-	if (!ioapic)
-		return AE_NO_MEMORY;
-
-	pdev = get_apic_pci_info(handle);
-	if (!pdev)
-		goto exit_kfree;
-
-	if (pci_enable_device(pdev))
-		goto exit_pci_dev_put;
-
-	pci_set_master(pdev);
-
-	if (pci_request_region(pdev, 0, "I/O APIC(acpiphp)"))
-		goto exit_pci_disable_device;
-
-	phys_addr = pci_resource_start(pdev, 0);
-	if (acpi_register_ioapic(handle, phys_addr, gsi_base))
-		goto exit_pci_release_region;
-
-	ioapic->gsi_base = gsi_base;
-	ioapic->dev = pdev;
-	spin_lock(&ioapic_list_lock);
-	list_add_tail(&ioapic->list, &ioapic_list);
-	spin_unlock(&ioapic_list_lock);
-
-	return AE_OK;
-
- exit_pci_release_region:
-	pci_release_region(pdev, 0);
- exit_pci_disable_device:
-	pci_disable_device(pdev);
- exit_pci_dev_put:
-	pci_dev_put(pdev);
- exit_kfree:
-	kfree(ioapic);
-
-	return AE_OK;
-}
-
-static acpi_status
-ioapic_remove(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	acpi_status status;
-	unsigned long long sta;
-	acpi_handle tmp;
-	u32 gsi_base;
-	struct acpiphp_ioapic *pos, *n, *ioapic = NULL;
-
-	/* Evaluate _STA if present */
-	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_SUCCESS(status) && sta != ACPI_STA_ALL)
-		return AE_CTRL_DEPTH;
-
-	/* Scan only PCI bus scope */
-	status = acpi_get_handle(handle, "_HID", &tmp);
-	if (ACPI_SUCCESS(status))
-		return AE_CTRL_DEPTH;
-
-	if (get_gsi_base(handle, &gsi_base))
-		return AE_OK;
-
-	acpi_unregister_ioapic(handle, gsi_base);
-
-	spin_lock(&ioapic_list_lock);
-	list_for_each_entry_safe(pos, n, &ioapic_list, list) {
-		if (pos->gsi_base != gsi_base)
-			continue;
-		ioapic = pos;
-		list_del(&ioapic->list);
-		break;
-	}
-	spin_unlock(&ioapic_list_lock);
-
-	if (!ioapic)
-		return AE_OK;
-
-	pci_release_region(ioapic->dev, 0);
-	pci_disable_device(ioapic->dev);
-	pci_dev_put(ioapic->dev);
-	kfree(ioapic);
-
-	return AE_OK;
-}
-
-static int acpiphp_configure_ioapics(acpi_handle handle)
-{
-	ioapic_add(handle, 0, NULL, NULL);
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL);
-	return 0;
-}
-
-static int acpiphp_unconfigure_ioapics(acpi_handle handle)
-{
-	ioapic_remove(handle, 0, NULL, NULL);
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_remove, NULL, NULL);
-	return 0;
-}
-
 static int power_on_slot(struct acpiphp_slot *slot)
 {
 	acpi_status status;
@@ -1014,8 +828,6 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 	pci_bus_assign_resources(bus);
 	acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
-	list_for_each_entry(func, &slot->funcs, sibling)
-		acpiphp_configure_ioapics(func->handle);
 	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
 
@@ -1091,7 +903,6 @@ static int disable_device(struct acpiphp_slot *slot)
 	}
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
-		acpiphp_unconfigure_ioapics(func->handle);
 		acpiphp_bus_trim(func->handle);
 	}
 
@@ -1275,7 +1086,6 @@ static int acpiphp_configure_bridge (acpi_handle handle)
 	acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
 	pci_enable_bridges(bus);
-	acpiphp_configure_ioapics(handle);
 	return 0;
 }
 
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
new file mode 100644
index 0000000..3e0d7b5
--- /dev/null
+++ b/drivers/pci/ioapic.c
@@ -0,0 +1,127 @@
+/*
+ * IOAPIC/IOxAPIC/IOSAPIC driver
+ *
+ * Copyright (C) 2009 Fujitsu Limited.
+ * (c) Copyright 2009 Hewlett-Packard Development Company, L.P.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * This driver manages PCI I/O APICs added by hotplug after boot.  We try to
+ * claim all I/O APIC PCI devices, but those present at boot were registered
+ * when we parsed the ACPI MADT, so we'll fail when we try to re-register
+ * them.
+ */
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+struct ioapic {
+	acpi_handle	handle;
+	u32		gsi_base;
+};
+
+static int ioapic_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+{
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long gsb;
+	struct ioapic *ioapic;
+	u64 addr;
+	int ret;
+	char *type;
+
+	handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	if (!handle)
+		return -EINVAL;
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gsb);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	/*
+	 * The previous code in acpiphp evaluated _MAT if _GSB failed, but
+	 * ACPI spec 4.0 sec 6.2.2 requires _GSB for hot-pluggable I/O APICs.
+	 */
+
+	ioapic = kzalloc(sizeof(*ioapic), GFP_KERNEL);
+	if (!ioapic)
+		return -ENOMEM;
+
+	ioapic->handle = handle;
+	ioapic->gsi_base = (u32) gsb;
+
+	if (dev->class == PCI_CLASS_SYSTEM_PIC_IOAPIC)
+		type = "IOAPIC";
+	else
+		type = "IOxAPIC";
+
+	ret = pci_enable_device(dev);
+	if (ret < 0)
+		goto exit_free;
+
+	pci_set_master(dev);
+
+	if (pci_request_region(dev, 0, type))
+		goto exit_disable;
+
+	addr = pci_resource_start(dev, 0);
+	if (acpi_register_ioapic(ioapic->handle, addr, ioapic->gsi_base))
+		goto exit_release;
+
+	pci_set_drvdata(dev, ioapic);
+	dev_info(&dev->dev, "%s at %#llx, GSI %u\n", type, addr,
+		 ioapic->gsi_base);
+	return 0;
+
+exit_release:
+	pci_release_region(dev, 0);
+exit_disable:
+	pci_disable_device(dev);
+exit_free:
+	kfree(ioapic);
+	return -ENODEV;
+}
+
+static void ioapic_remove(struct pci_dev *dev)
+{
+	struct ioapic *ioapic = pci_get_drvdata(dev);
+
+	acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base);
+	pci_release_region(dev, 0);
+	pci_disable_device(dev);
+	kfree(ioapic);
+}
+
+
+static struct pci_device_id ioapic_devices[] = {
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_SYSTEM_PIC_IOAPIC << 8, 0xffff00, },
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_SYSTEM_PIC_IOXAPIC << 8, 0xffff00, },
+	{ }
+};
+
+static struct pci_driver ioapic_driver = {
+	.name		= "ioapic",
+	.id_table	= ioapic_devices,
+	.probe		= ioapic_probe,
+	.remove		= __devexit_p(ioapic_remove),
+};
+
+static int __init ioapic_init(void)
+{
+	return pci_register_driver(&ioapic_driver);
+}
+
+static void __exit ioapic_exit(void)
+{
+	pci_unregister_driver(&ioapic_driver);
+}
+
+module_init(ioapic_init);
+module_exit(ioapic_exit);
