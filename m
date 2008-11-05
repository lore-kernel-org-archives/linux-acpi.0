From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/11] ACPI: remove ACPI dependency on PCI
Date: Wed, 05 Nov 2008 16:18:13 -0700
Message-ID: <20081105231813.26131.16551.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:32616 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbYKEXSO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:18:14 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Allow ACPI to build without CONFIG_PCI.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Kconfig           |    1 -
 drivers/acpi/osl.c             |    8 ++++++++
 drivers/acpi/reboot.c          |    7 +++++--
 drivers/pnp/pnpacpi/rsparser.c |    6 ++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7962bfc..2e6f757 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,6 @@ menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
-	depends on PCI
 	depends on PM
 	select PNP
 	default y
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4be2521..e162be5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -546,6 +546,7 @@ acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u32 *value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	if (!value)
@@ -570,12 +571,16 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return AE_ERROR;
+#endif
 }
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				acpi_integer value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -597,6 +602,9 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return AE_ERROR;
+#endif
 }
 
 /* TODO: Change code to take advantage of driver model more */
diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 755baf2..a5af8b7 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -6,9 +6,11 @@
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
-	struct pci_bus *bus0;
 	u8 reset_value;
+#ifdef CONFIG_PCI
+	struct pci_bus *bus0;
 	unsigned int devfn;
+#endif
 
 	if (acpi_disabled)
 		return;
@@ -44,6 +46,7 @@ void acpi_reboot(void)
 	/* The reset register can only exist in I/O, Memory or PCI config space
 	 * on a device on bus 0. */
 	switch (rr->space_id) {
+#ifdef CONFIG_PCI
 	case ACPI_ADR_SPACE_PCI_CONFIG:
 		/* The reset register can only live on bus 0. */
 		bus0 = pci_find_bus(0, 0);
@@ -57,7 +60,7 @@ void acpi_reboot(void)
 		pci_bus_write_config_byte(bus0, devfn,
 				(rr->address & 0xffff), reset_value);
 		break;
-
+#endif
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index adf1785..96992db 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -124,9 +124,11 @@ static void pnpacpi_parse_allocated_irqresource(struct pnp_dev *dev,
 
 	flags = irq_flags(triggering, polarity, shareable);
 	irq = acpi_register_gsi(gsi, triggering, polarity);
-	if (irq >= 0)
+	if (irq >= 0) {
+#ifdef CONFIG_PCI
 		pcibios_penalize_isa_irq(irq, 1);
-	else
+#endif
+	} else
 		flags |= IORESOURCE_DISABLED;
 
 	pnp_add_irq_resource(dev, irq, flags);

