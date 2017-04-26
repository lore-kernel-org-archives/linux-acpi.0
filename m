From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC/RFT PATCH 1/3] PCI: Introduce pci_bus_find_numa_node()
Date: Wed, 26 Apr 2017 11:06:17 +0100
Message-ID: <20170426100619.31758-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034752AbdDZKFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 06:05:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sergey Temerkhanov <s.temerkhanov@gmail.com>, Sinan Kaya <okaya@codeaurora.org>

Create an empty stub, to be populated by firmware methods, to
retrieve the NUMA node for a given pci_bus. No functional change
introduced.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 6 ++++++
 include/linux/pci.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..2de9162 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/numa.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -5235,6 +5236,11 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 #endif
 #endif
 
+int pci_bus_find_numa_node(struct pci_bus *bus)
+{
+	return NUMA_NO_NODE;
+}
+
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..9e62462 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1481,6 +1481,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
+int pci_bus_find_numa_node(struct pci_bus *bus);
 
 /* some architectures require additional setup to direct VGA traffic */
 typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
-- 
2.10.0

