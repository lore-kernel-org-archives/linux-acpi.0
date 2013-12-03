From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI on ARM64
Date: Wed,  4 Dec 2013 00:36:45 +0800
Message-ID: <1386088611-2801-2-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38834 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab3LCQhf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 11:37:35 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so21086325pbb.8
        for <linux-acpi@vger.kernel.org>; Tue, 03 Dec 2013 08:37:35 -0800 (PST)
In-Reply-To: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>

Not all the ARM64 targets that are using ACPI have PCI, so introduce
some stub functions to make ACPI core run without CONFIG_PCI on ARM64.

Since ACPI on X86 and IA64 depends on PCI, it will not break X86 and
IA64 with this patch.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Makefile          |    2 +-
 drivers/acpi/internal.h        |    5 +++++
 drivers/acpi/osl.c             |   16 ++++++++++++++
 drivers/acpi/reboot.c          |   47 +++++++++++++++++++++++++++++-----------
 drivers/pnp/pnpacpi/rsparser.c |    2 ++
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0331f91..d8cebe3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -38,7 +38,7 @@ acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
-acpi-y				+= pci_root.o pci_link.o pci_irq.o
+acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 acpi-$(CONFIG_X86_INTEL_LPSS)	+= acpi_lpss.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= power.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index b125fdb..b1ef8fa 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -26,8 +26,13 @@
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
+#ifdef CONFIG_PCI
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
+#else
+static inline void acpi_pci_root_init(void) {}
+static inline void acpi_pci_link_init(void) {}
+#endif /* CONFIG_PCI */
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 int acpi_sysfs_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c543626..6434045 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1016,6 +1016,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 	return AE_OK;
 }
 
+#ifdef CONFIG_PCI
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
@@ -1074,6 +1075,21 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 	return (result ? AE_ERROR : AE_OK);
 }
+#else
+acpi_status
+acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
+				u64 *value, u32 width)
+{
+	return AE_ERROR;
+}
+
+acpi_status
+acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
+				u64 value, u32 width)
+{
+	return AE_ERROR;
+}
+#endif /* CONFIG_PCI */
 
 static void acpi_os_execute_deferred(struct work_struct *work)
 {
diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index a6c77e8b..89a181f 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -3,12 +3,43 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+/*
+ * There are some rare cases in the ARM world with PCI is not one
+ * of the buses available to us, even though we use ACPI.
+ */
+#ifdef CONFIG_PCI
+static void acpi_reset_with_writing_pci_config(u64 address, u8 reset_value)
+{
+	struct pci_bus *bus0;
+	unsigned int devfn;
+
+	/* The reset register can only live on bus 0. */
+	bus0 = pci_find_bus(0, 0);
+	if (!bus0)
+		return;
+
+	/* Form PCI device/function pair. */
+	devfn = PCI_DEVFN((address >> 32) & 0xffff,
+			(address >> 16) & 0xffff);
+	pr_debug("Resetting with ACPI PCI RESET_REG.\n");
+	/* Write the value that resets us. */
+	pci_bus_write_config_byte(bus0, devfn,
+			(address & 0xffff), reset_value);
+
+	return;
+}
+#else
+static void acpi_reset_with_writing_pci_config(u64 address, u8 reset_value)
+{
+	pr_warn("Resetting with ACPI PCI RESET_REG failed, PCI is disabled\n");
+	return;
+}
+#endif
+
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
-	struct pci_bus *bus0;
 	u8 reset_value;
-	unsigned int devfn;
 
 	if (acpi_disabled)
 		return;
@@ -32,17 +63,7 @@ void acpi_reboot(void)
 	 * on a device on bus 0. */
 	switch (rr->space_id) {
 	case ACPI_ADR_SPACE_PCI_CONFIG:
-		/* The reset register can only live on bus 0. */
-		bus0 = pci_find_bus(0, 0);
-		if (!bus0)
-			return;
-		/* Form PCI device/function pair. */
-		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
-				  (rr->address >> 16) & 0xffff);
-		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.");
-		/* Write the value that resets us. */
-		pci_bus_write_config_byte(bus0, devfn,
-				(rr->address & 0xffff), reset_value);
+		acpi_reset_with_writing_pci_config(rr->address, reset_value);
 		break;
 
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 167f3d0..5804e77 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -113,8 +113,10 @@ static int dma_flags(struct pnp_dev *dev, int type, int bus_master,
 
 static void pnpacpi_add_irqresource(struct pnp_dev *dev, struct resource *r)
 {
+#ifdef CONFIG_PCI
 	if (!(r->flags & IORESOURCE_DISABLED))
 		pcibios_penalize_isa_irq(r->start, 1);
+#endif
 
 	pnp_add_resource(dev, r);
 }
-- 
1.7.9.5

