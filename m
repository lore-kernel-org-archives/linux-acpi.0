From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/10] ACPI: pci_link: remove acpi_irq_balance_set() interface
Date: Thu, 06 Nov 2008 23:45:23 -0500
Message-ID: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:34820 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYKGEpe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y00JMV57X1CJ1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:45:33 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
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
 
-- 
1.5.6.5

