From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/11] ACPI: pci_link: remove acpi_irq_balance_set() interface
Date: Wed, 05 Nov 2008 16:17:52 -0700
Message-ID: <20081105231752.26131.78523.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:14815 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYKEXRx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:17:53 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

This removes the acpi_irq_balance_set() interface from the PCI
interrupt link driver.

x86 used acpi_irq_balance_set() to tell the PCI interrupt link
driver to configure links to minimize IRQ sharing.  But the link
driver can easily figure out whether to turn on IRQ balancing
based on the IRQ model (PIC/IOAPIC/etc), so we can get rid of
that external interface.

It's better for the driver to figure this out at init-time.  If
we set it externally via the x86 code, the interface reduces
modularity, and we depend on the fact that acpi_process_madt()
happens before we process the kernel command line.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/include/asm/acpi.h |    1 -
 arch/x86/kernel/acpi/boot.c |    1 -
 drivers/acpi/pci_link.c     |   11 +++++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8d676d8..9830681 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -113,7 +113,6 @@ static inline void acpi_disable_pci(void)
 	acpi_pci_disabled = 1;
 	acpi_noirq_set();
 }
-extern int acpi_irq_balance_set(char *str);
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8c1f76a..4c51a2f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1343,7 +1343,6 @@ static void __init acpi_process_madt(void)
 			error = acpi_parse_madt_ioapic_entries();
 			if (!error) {
 				acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
-				acpi_irq_balance_set(NULL);
 				acpi_ioapic = 1;
 
 				smp_found_config = 1;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index fcfdef7..e52ad91 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -531,7 +531,7 @@ int __init acpi_irq_penalty_init(void)
 	return 0;
 }
 
-static int acpi_irq_balance;	/* 0: static, 1: balance */
+static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
 
 static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 {
@@ -950,10 +950,17 @@ device_initcall(irqrouter_init_sysfs);
 
 static int __init acpi_pci_link_init(void)
 {
-
 	if (acpi_noirq)
 		return 0;
 
+	if (acpi_irq_balance == -1) {
+		/* no command line switch: enable balancing in IOAPIC mode */
+		if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
+			acpi_irq_balance = 1;
+		else
+			acpi_irq_balance = 0;
+	}
+
 	acpi_link.count = 0;
 	INIT_LIST_HEAD(&acpi_link.entries);
 

