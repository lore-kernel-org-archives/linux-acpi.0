From: al.stone@linaro.org
Subject: [PATCH 04/12] ACPI: HW reduced mode does not allow use of the FADT sci_interrupt field
Date: Sat,  9 Nov 2013 18:36:14 -0700
Message-ID: <1384047382-20623-5-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46637 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611Ab3KJBgg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:36 -0500
Received: by mail-ie0-f178.google.com with SMTP id aq17so492288iec.23
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:36 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/bus.c      |  3 ++-
 drivers/acpi/osl.c      | 10 ++++++----
 drivers/acpi/pci_link.c | 14 ++++++++------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b587ec8..6a54dd5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -540,7 +540,8 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-#ifdef CONFIG_X86
+#if (!CONFIG_ACPI_REDUCED_HARDWARE)
+	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
 	if (!acpi_ioapic) {
 		/* compatible (0) means level (3) */
 		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 54a20ff..017b85c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
+static u32 acpi_irq_number;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
@@ -797,9 +798,9 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 
 	/*
 	 * ACPI interrupts different from the SCI in our copy of the FADT are
-	 * not supported.
+	 * not supported, except in HW reduced mode.
 	 */
-	if (gsi != acpi_gbl_FADT.sci_interrupt)
+	if (!acpi_gbl_reduced_hardware && (gsi != acpi_gbl_FADT.sci_interrupt))
 		return AE_BAD_PARAMETER;
 
 	if (acpi_irq_handler)
@@ -818,13 +819,14 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_irq_number = irq;
 
 	return AE_OK;
 }
 
 acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 {
-	if (irq != acpi_gbl_FADT.sci_interrupt)
+	if (!acpi_gbl_reduced_hardware && (irq != acpi_gbl_FADT.sci_interrupt))
 		return AE_BAD_PARAMETER;
 
 	free_irq(irq, acpi_irq);
@@ -1806,7 +1808,7 @@ acpi_status __init acpi_os_initialize1(void)
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
+		acpi_os_remove_interrupt_handler(acpi_irq_number,
 						 acpi_irq_handler);
 	}
 
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 2652a61..c0ab28a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -23,7 +23,7 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
- * TBD: 
+ * TBD:
  *      1. Support more than one IRQ resource entry per link device (index).
  *	2. Implement start/stop mechanism and use ACPI Bus Driver facilities
  *	   for IRQ management (e.g. start()->_SRS).
@@ -268,8 +268,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 		}
 	}
 
-	/* 
-	 * Query and parse _CRS to get the current IRQ assignment. 
+	/*
+	 * Query and parse _CRS to get the current IRQ assignment.
 	 */
 
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
@@ -415,7 +415,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 /*
  * "acpi_irq_balance" (default in APIC mode) enables ACPI to use PIC Interrupt
  * Link Devices to move the PIRQs around to minimize sharing.
- * 
+ *
  * "acpi_irq_nobalance" (default in PIC mode) tells ACPI not to move any PIC IRQs
  * that the BIOS has already set to active.  This is necessary because
  * ACPI has no automatic means of knowing what ISA IRQs are used.  Note that
@@ -433,7 +433,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  *
  * Note that PCI IRQ routers have a list of possible IRQs,
  * which may not include the IRQs this table says are available.
- * 
+ *
  * Since this heuristic can't tell the difference between a link
  * that no device will attach to, vs. a link which may be shared
  * by multiple active devices -- it is not optimal.
@@ -505,7 +505,9 @@ int __init acpi_irq_penalty_init(void)
 		}
 	}
 	/* Add a penalty for the SCI */
-	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
+	if (!acpi_gbl_reduced_hardware)
+		acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] +=
+			PIRQ_PENALTY_PCI_USING;
 	return 0;
 }
 
-- 
1.8.3.1

