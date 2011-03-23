From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/42] ACPI: Avoid calling request_irq() many times for the
 same interrupt
Date: Wed, 23 Mar 2011 02:42:29 -0400
Message-ID: <23fe36306ea489eef7dd88506bdcefdc8da39c91.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36986 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab1CWHHc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:32 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

In principle acpi_os_install_interrupt_handler() may be called
multiple times for different interrupts, either from
acpi_ev_get_gpe_xrupt_block(), or from acpi_ev_install_sci_handler().
However, it always attempts to request the same interrupt,
acpi_gbl_FADT.sci_interrupt and it doesn't check whether or not this
interrupt has already been requested.

Modify this function so that it refuses to request interrupts other
than acpi_gbl_FADT.sci_interrupt and change
acpi_os_remove_interrupt_handler() so that it refuses to free such
interrupts.  Use the observation that the only supported ACPI
interrupt must be equal to acpi_gbl_FADT.sci_interrupt and drop an
unnecessary variable acpi_irq_irq.

This change has been tested on Toshiba Portege R500 and HP nx6325
without introducing any visible problems.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c90c76a..187dff9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -76,7 +76,6 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
 
-static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
@@ -516,11 +515,15 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 	acpi_irq_stats_init();
 
 	/*
-	 * Ignore the GSI from the core, and use the value in our copy of the
-	 * FADT. It may not be the same if an interrupt source override exists
-	 * for the SCI.
+	 * ACPI interrupts different from the SCI in our copy of the FADT are
+	 * not supported.
 	 */
-	gsi = acpi_gbl_FADT.sci_interrupt;
+	if (gsi != acpi_gbl_FADT.sci_interrupt)
+		return AE_BAD_PARAMETER;
+
+	if (acpi_irq_handler)
+		return AE_ALREADY_ACQUIRED;
+
 	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
 		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
 		       gsi);
@@ -531,20 +534,20 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
+		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
-	acpi_irq_irq = irq;
 
 	return AE_OK;
 }
 
 acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 {
-	if (irq) {
-		free_irq(irq, acpi_irq);
-		acpi_irq_handler = NULL;
-		acpi_irq_irq = 0;
-	}
+	if (irq != acpi_gbl_FADT.sci_interrupt)
+		return AE_BAD_PARAMETER;
+
+	free_irq(irq, acpi_irq);
+	acpi_irq_handler = NULL;
 
 	return AE_OK;
 }
@@ -1603,7 +1606,7 @@ acpi_status __init acpi_os_initialize1(void)
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_irq_irq,
+		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
 						 acpi_irq_handler);
 	}
 
-- 
1.7.4.1.343.ga91df

