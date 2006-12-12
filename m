From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 1/2] disable irq balance even in APIC mode
Date: Tue, 12 Dec 2006 09:26:30 +0800
Message-ID: <1165886790.19586.25.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41013 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbWLLB1o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Dec 2006 20:27:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Stian Jordet <stian_web@jordet.nu>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>

The two patches try to fix bug 2874, and Stian confirmed. Basically in
Stian's system, _PRT table lets some devices use link device for irq
routing even in IOAPIC mode. And in IOAPIC mode, if link device is
enabled, all devices linked to the link device in PIC mode will not
connect to IOAPIC pins, instead they will use PIC mode irq routing. I'm
not sure if the patches will break other systems, so they should be test
for a long time.
http://bugzilla.kernel.org/show_bug.cgi?id=2874


acpi_irq_balance is for PCI link device (pci interrupt router), it
hasn't any relationship with APIC/IOAPIC. Default enabling it in APIC
mode doesn't make sense to me. 

Signed-off-by: Shaohua Li<shaohua.li@intel.com>

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index c8f96cf..3497443 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -927,7 +927,6 @@ #endif
 			error = acpi_parse_madt_ioapic_entries();
 			if (!error) {
 				acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
-				acpi_irq_balance_set(NULL);
 				acpi_ioapic = 1;
 
 				smp_found_config = 1;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index d53bd98..6833ad3 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -899,7 +899,7 @@ static int __init acpi_irq_nobalance_set
 
 __setup("acpi_irq_nobalance", acpi_irq_nobalance_set);
 
-int __init acpi_irq_balance_set(char *str)
+static int __init acpi_irq_balance_set(char *str)
 {
 	acpi_irq_balance = 1;
 	return 1;
diff --git a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
index c80b3a9..2a94a1b 100644
--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -141,7 +141,6 @@ static inline void acpi_disable_pci(void
 	acpi_pci_disabled = 1; 
 	acpi_noirq_set();
 }
-extern int acpi_irq_balance_set(char *str);
 
 #else	/* !CONFIG_ACPI */
 
diff --git a/include/asm-x86_64/acpi.h b/include/asm-x86_64/acpi.h
index 9d1916e..1490554 100644
--- a/include/asm-x86_64/acpi.h
+++ b/include/asm-x86_64/acpi.h
@@ -127,7 +127,6 @@ static inline void acpi_disable_pci(void
 	acpi_pci_disabled = 1; 
 	acpi_noirq_set();
 }
-extern int acpi_irq_balance_set(char *str);
 
 #else	/* !CONFIG_ACPI */
 
