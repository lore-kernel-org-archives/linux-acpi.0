From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Fix PCI ACS enablement
Date: Tue, 19 Sep 2017 18:05:39 +0100
Message-ID: <20170919170539.6265-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdISRDL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Sep 2017 13:03:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Zhou Wang <wangzhou1@hisilicon.com>, Alex Williamson <alex.williamson@redhat.com>

commit f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
workarounds") removed kernel code that was allowing to initialize
and probe the SMMU devices early (ie earlier than PCI devices through
linker script callback entries) in the boot process because it was not
needed any longer in that the SMMU devices/drivers now support deferred
probing.

Since the SMMUs probe routines are also in charge of requesting global
PCI ACS kernel enablement, commit f6810c15cf97 ("iommu/arm-smmu: Clean
up early-probing workarounds") also postponed PCI ACS enablement to
SMMUs devices probe time, which may be too late given that PCI devices
needs to detect if PCI ACS is enabled to init the respective capability
through the following call path:

pci_device_add()
 -> pci_init_capabilities()
  -> pci_enable_acs()

Add code in the ACPI IORT SMMU platform devices initialization path
(that is called before ACPI PCI enumeration) to detect if an SMMU is
present in HW and enable PCI ACS if it actually is, restoring the
correct PCI ACS enablement sequencing.

Fixes: f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
Signed-workarounds")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/acpi/arm64/iort.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9565d57..71a7694 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1184,6 +1184,7 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
+	bool smmu_detected = false;
 
 	/*
 	 * iort_table and iort both point to the start of IORT table, but
@@ -1218,11 +1219,21 @@ static void __init iort_init_platform_devices(void)
 				acpi_free_fwnode_static(fwnode);
 				return;
 			}
+
+			smmu_detected = true;
 		}
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
 	}
+
+	/*
+	 * If IORT reports an SMMU component make sure PCI ACS is
+	 * requested so that PCI devices can enable it in their
+	 * capabilities.
+	 */
+	if (smmu_detected)
+		pci_request_acs();
 }
 
 void __init acpi_iort_init(void)
-- 
2.10.0

