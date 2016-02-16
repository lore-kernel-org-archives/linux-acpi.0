From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V5 14/15] arm64, pci, acpi: Assign legacy IRQs once device is enable.
Date: Tue, 16 Feb 2016 14:53:44 +0100
Message-ID: <1455630825-27253-15-git-send-email-tn@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36842 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbcBPNyU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 08:54:20 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so108515013wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2016 05:54:20 -0800 (PST)
In-Reply-To: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>

This is the last step before enabling generic ACPI PCI host controller
for ARM64. We need to take care of legacy IRQ mapping for non-MSI(X)
PCI devices. pcibios_alloc_irq() evaluation is not sensitive to
ACPI device enumeration order, so it is the best place to assign
device's IRQs for ACPI boot method. Also, it does not hurt DT to be
initialized form the same place.

NOTE: *This is going to be temporary solution*. There is ongoing work
which aims for cleaning legacy IRQ allocation from arch specific code.
We can consider this patch as the necessary evil which will be removed
once cleanup series lands in mailnline in the near future.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 023b983..6e77e1b 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -52,11 +52,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 }
 
 /*
- * Try to assign the IRQ number from DT when adding a new device
+ * Try to assign the IRQ number when probing a new device
  */
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+	if (acpi_disabled)
+		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#ifdef CONFIG_ACPI
+	else
+		return acpi_pci_irq_enable(dev);
+#endif
 
 	return 0;
 }
-- 
1.9.1

