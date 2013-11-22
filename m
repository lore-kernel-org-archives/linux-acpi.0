From: al.stone@linaro.org
Subject: [PATCH v2 3/6] ACPI: HW reduced mode does not allow use of the FADT sci_interrupt field
Date: Thu, 21 Nov 2013 17:41:52 -0700
Message-ID: <1385080915-23430-4-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:59500 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3KVAmN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:13 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so538459pab.20
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:12 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

In HW reduced mode, the use of the SCI interrupt is not allowed.  In
all those places that use the FADT sci_interrupt field, remove that
usage when in HW reduced mode.

In the case of acpi_os_install_interrupt_handler() in osl.c, this allows
us to open up the routine to installing interrupt handlers other than
acpi_gbl_FADT.sci_interrupt regardless of whether we are in ACPI legacy
mode or reduced HW mode; acpi_os_remove_interrupt_handler() changes to
maintain symmetry.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/bus.c      |  3 ++-
 drivers/acpi/osl.c      | 16 ++++------------
 drivers/acpi/pci_link.c |  2 ++
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bba9b72..de3a259 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -541,7 +541,8 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-#ifdef CONFIG_X86
+#ifndef CONFIG_ACPI_REDUCED_HARDWARE
+	/* NOTE: in HW reduced mode, FADT sci_interrupt has no meaning */
 	if (!acpi_ioapic) {
 		/* compatible (0) means level (3) */
 		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 54a20ff..34cd2c5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
+static u32 acpi_irq_number;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
@@ -795,13 +796,6 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 
 	acpi_irq_stats_init();
 
-	/*
-	 * ACPI interrupts different from the SCI in our copy of the FADT are
-	 * not supported.
-	 */
-	if (gsi != acpi_gbl_FADT.sci_interrupt)
-		return AE_BAD_PARAMETER;
-
 	if (acpi_irq_handler)
 		return AE_ALREADY_ACQUIRED;
 
@@ -818,15 +812,13 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_irq_number = irq;
 
 	return AE_OK;
 }
 
 acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 {
-	if (irq != acpi_gbl_FADT.sci_interrupt)
-		return AE_BAD_PARAMETER;
-
 	free_irq(irq, acpi_irq);
 	acpi_irq_handler = NULL;
 
@@ -1806,7 +1798,7 @@ acpi_status __init acpi_os_initialize1(void)
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
+		acpi_os_remove_interrupt_handler(acpi_irq_number,
 						 acpi_irq_handler);
 	}
 
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 064cd5b..9ae105b 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -505,6 +505,8 @@ int __init acpi_irq_penalty_init(void)
 		}
 	}
 	/* Add a penalty for the SCI */
+	if (acpi_gbl_reduced_hardware)
+		return 0;
 	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
 	return 0;
 }
-- 
1.8.3.1

