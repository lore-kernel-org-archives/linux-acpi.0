From: Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: [PATCH] arm64: acpi: Support PCI devices numa_node property in ACPI mode
Date: Thu,  6 Apr 2017 11:47:11 +0000
Message-ID: <20170406114711.17261-1-s.temerkhanov@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36649 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbdDFLrw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2017 07:47:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id v75so5435849qkb.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Apr 2017 04:47:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This commit modifies ARM64-specific ACPI PCI support functions to
properly set the numa_node property on host bridges and thus on PCI
devices. Such support requires _PXM objects to be set in DSDT/SSDT
tables describing PCI root bridges

Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
---
 arch/arm64/kernel/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3ebfea4b..c45c7a26f984 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -81,7 +81,16 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 
 int pcibus_to_node(struct pci_bus *bus)
 {
-	return dev_to_node(&bus->dev);
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = NULL;
+	struct device *dev;
+
+	if (!acpi_disabled)
+		adev = to_acpi_device(cfg->parent);
+
+	dev = adev ? &adev->dev : &bus->dev;
+
+	return dev_to_node(dev);
 }
 EXPORT_SYMBOL(pcibus_to_node);
 
@@ -186,6 +195,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
 
+	set_dev_node(&root->device->dev, node);
+
 	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
 	if (!ri)
 		return NULL;
-- 
2.12.1

