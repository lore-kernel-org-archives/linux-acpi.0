From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/15] ACPICA: Update DMAR table definitions.
Date: Thu, 31 Oct 2013 09:30:22 +0800
Message-ID: <34724bd0731b013d05289f61cc308c25d8b7b384.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51217 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:30:57 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch does not affect the generation of the Linux binary.
This patch decreases 14 lines of divergences.

This patch updates DMAR table header definitions as such modification
already has been done in ACPICA.  This patch merges such changes into Linux
to reduce the source code differences between Linux and ACPICA upstream.

Build test is done on x86-64 machine with following configs enabled:
  CONFIG_DMAR_TABLE
  CONFIG_IRQ_REMAP
  CONFIG_INTEL_IOMMU

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/iommu/dmar.c                |    4 ++--
 drivers/iommu/intel_irq_remapping.c |    8 ++++----
 include/acpi/actbl2.h               |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 785675a..9009469 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -88,7 +88,7 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
 			pr_warn("Device scope bus [%d] not found\n", scope->bus);
 			break;
 		}
-		pdev = pci_get_slot(bus, PCI_DEVFN(path->dev, path->fn));
+		pdev = pci_get_slot(bus, PCI_DEVFN(path->device, path->function));
 		if (!pdev) {
 			/* warning will be printed below */
 			break;
@@ -99,7 +99,7 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
 	}
 	if (!pdev) {
 		pr_warn("Device scope device [%04x:%02x:%02x.%02x] not found\n",
-			segment, scope->bus, path->dev, path->fn);
+			segment, scope->bus, path->device, path->function);
 		*dev = NULL;
 		return 0;
 	}
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f71673d..ab86902 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -686,12 +686,12 @@ static void ir_parse_one_hpet_scope(struct acpi_dmar_device_scope *scope,
 		 * Access PCI directly due to the PCI
 		 * subsystem isn't initialized yet.
 		 */
-		bus = read_pci_config_byte(bus, path->dev, path->fn,
+		bus = read_pci_config_byte(bus, path->device, path->function,
 					   PCI_SECONDARY_BUS);
 		path++;
 	}
 	ir_hpet[ir_hpet_num].bus   = bus;
-	ir_hpet[ir_hpet_num].devfn = PCI_DEVFN(path->dev, path->fn);
+	ir_hpet[ir_hpet_num].devfn = PCI_DEVFN(path->device, path->function);
 	ir_hpet[ir_hpet_num].iommu = iommu;
 	ir_hpet[ir_hpet_num].id    = scope->enumeration_id;
 	ir_hpet_num++;
@@ -714,13 +714,13 @@ static void ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
 		 * Access PCI directly due to the PCI
 		 * subsystem isn't initialized yet.
 		 */
-		bus = read_pci_config_byte(bus, path->dev, path->fn,
+		bus = read_pci_config_byte(bus, path->device, path->function,
 					   PCI_SECONDARY_BUS);
 		path++;
 	}
 
 	ir_ioapic[ir_ioapic_num].bus   = bus;
-	ir_ioapic[ir_ioapic_num].devfn = PCI_DEVFN(path->dev, path->fn);
+	ir_ioapic[ir_ioapic_num].devfn = PCI_DEVFN(path->device, path->function);
 	ir_ioapic[ir_ioapic_num].iommu = iommu;
 	ir_ioapic[ir_ioapic_num].id    = scope->enumeration_id;
 	ir_ioapic_num++;
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ffaac0e..40f7ed1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -444,8 +444,8 @@ enum acpi_dmar_scope_type {
 };
 
 struct acpi_dmar_pci_path {
-	u8 dev;
-	u8 fn;
+	u8 device;
+	u8 function;
 };
 
 /*
-- 
1.7.10

