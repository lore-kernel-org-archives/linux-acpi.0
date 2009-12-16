From: Len Brown <lenb@kernel.org>
Subject: [PATCH 080/103] ipmi: add PNP discovery (ACPI namespace via PNPACPI)
Date: Wed, 16 Dec 2009 03:36:31 -0500
Message-ID: <9e368fa011d4e0aa050db348d69514900520e40b.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761998AbZLPLGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:11 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This allows ipmi_si_intf.c to claim IPMI devices described in the ACPI
namespace.  Using PNP makes it simpler to parse the IRQ/IO/memory resources
of the device.

We look at any SPMI tables before looking for devices in the namespace.

This is based on ipmi_pci_probe().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |  104 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index b58e587..679cd08 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -64,6 +64,7 @@
 #include <linux/dmi.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/pnp.h>
 
 #ifdef CONFIG_PPC_OF
 #include <linux/of_device.h>
@@ -2023,6 +2024,103 @@ static __devinit void spmi_find_bmc(void)
 		try_init_spmi(spmi);
 	}
 }
+
+static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
+				    const struct pnp_device_id *dev_id)
+{
+	struct acpi_device *acpi_dev;
+	struct smi_info *info;
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long tmp;
+
+	acpi_dev = pnp_acpi_device(dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->addr_source = "ACPI";
+
+	handle = acpi_dev->handle;
+
+	/* _IFT tells us the interface type: KCS, BT, etc */
+	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		goto err_free;
+
+	switch (tmp) {
+	case 1:
+		info->si_type = SI_KCS;
+		break;
+	case 2:
+		info->si_type = SI_SMIC;
+		break;
+	case 3:
+		info->si_type = SI_BT;
+		break;
+	default:
+		dev_info(&dev->dev, "unknown interface type %lld\n", tmp);
+		goto err_free;
+	}
+
+	if (pnp_port_valid(dev, 0)) {
+		info->io_setup = port_setup;
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
+		info->io.addr_data = pnp_port_start(dev, 0);
+	} else if (pnp_mem_valid(dev, 0)) {
+		info->io_setup = mem_setup;
+		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
+		info->io.addr_data = pnp_mem_start(dev, 0);
+	} else {
+		dev_err(&dev->dev, "no I/O or memory address\n");
+		goto err_free;
+	}
+
+	info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regsize = DEFAULT_REGSPACING;
+	info->io.regshift = 0;
+
+	/* If _GPE exists, use it; otherwise use standard interrupts */
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
+	if (ACPI_SUCCESS(status)) {
+		info->irq = tmp;
+		info->irq_setup = acpi_gpe_irq_setup;
+	} else if (pnp_irq_valid(dev, 0)) {
+		info->irq = pnp_irq(dev, 0);
+		info->irq_setup = std_irq_setup;
+	}
+
+	info->dev = &acpi_dev->dev;
+	pnp_set_drvdata(dev, info);
+
+	return try_smi_init(info);
+
+err_free:
+	kfree(info);
+	return -EINVAL;
+}
+
+static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
+{
+	struct smi_info *info = pnp_get_drvdata(dev);
+
+	cleanup_one_si(info);
+}
+
+static const struct pnp_device_id pnp_dev_table[] = {
+	{"IPI0001", 0},
+	{"", 0},
+};
+
+static struct pnp_driver ipmi_pnp_driver = {
+	.name		= DEVICE_NAME,
+	.probe		= ipmi_pnp_probe,
+	.remove		= __devexit_p(ipmi_pnp_remove),
+	.id_table	= pnp_dev_table,
+};
 #endif
 
 #ifdef CONFIG_DMI
@@ -3106,6 +3204,9 @@ static __devinit int init_ipmi_si(void)
 #ifdef CONFIG_ACPI
 	spmi_find_bmc();
 #endif
+#ifdef CONFIG_PNP
+	pnp_register_driver(&ipmi_pnp_driver);
+#endif
 
 #ifdef CONFIG_PCI
 	rv = pci_register_driver(&ipmi_pci_driver);
@@ -3229,6 +3330,9 @@ static __exit void cleanup_ipmi_si(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
+#ifdef CONFIG_PNP
+	pnp_unregister_driver(&ipmi_pnp_driver);
+#endif
 
 #ifdef CONFIG_PPC_OF
 	of_unregister_platform_driver(&ipmi_of_platform_driver);
-- 
1.6.0.6

