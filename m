From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH] Replace acpi_gbl_FADT.sci_interrupt with two functions in
 some places.
Date: Tue, 03 May 2011 14:10:41 +0800
Message-ID: <1304403041.3179.29.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50747 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab1ECGK4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 May 2011 02:10:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, ming.m.lin@intel.com, rui.zhang@intel.com

     Some places use the acpi_gbl_FADT.sci_interrupt directly to get the ACPI SCI.ACPI SCI will not only be stored in the FADT. 
So this patch replaces acpi_gbl_FADT.sci_interrupt with two functions for getting and setting.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 arch/x86/kernel/acpi/boot.c                  |    8 ++---
 drivers/acpi/acpica/evgpeinit.c              |    5 +--
 drivers/acpi/acpica/evgpeutil.c              |    4 +-
 drivers/acpi/acpica/evsci.c                  |    4 +-
 drivers/acpi/acpica/evxface.c                |   38 +++++++++++++++++++++++++++
 drivers/acpi/bus.c                           |    4 +-
 drivers/acpi/osl.c                           |    6 ++--
 drivers/acpi/pci_link.c                      |    2 -
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c |    2 -
 include/acpi/acpixf.h                        |    4 ++
 10 files changed, 59 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c	2011-05-03 10:19:00.163029998 +0800
+++ linux-2.6/arch/x86/kernel/acpi/boot.c	2011-05-03 10:20:50.833030004 +0800
@@ -408,7 +408,7 @@
 
 	acpi_table_print_madt_entry(header);
 
-	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
+	if (intsrc->source_irq == acpi_get_sci_interrupt()) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
 				      (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
@@ -1100,7 +1100,7 @@
 		return gsi;
 
 	/* Don't set up the ACPI SCI because it's already set up */
-	if (acpi_gbl_FADT.sci_interrupt == gsi)
+	if (acpi_get_sci_interrupt() == gsi)
 		return gsi;
 
 	ioapic = mp_find_ioapic(gsi);
@@ -1184,8 +1184,8 @@
 	 * pretend we got one so we can set the SCI flags.
 	 */
 	if (!acpi_sci_override_gsi)
-		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0,
-				      acpi_gbl_FADT.sci_interrupt);
+		acpi_sci_ioapic_setup(acpi_get_sci_interrupt(), 0, 0,
+				      acpi_get_sci_interrupt());
 
 	/* Fill in identity legacy mappings where no override */
 	mp_config_acpi_legacy_irqs();
Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c	2011-05-03 10:19:00.243029997 +0800
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c	2011-05-03 10:20:50.833030004 +0800
@@ -131,7 +131,7 @@
 		status = acpi_ev_create_gpe_block(acpi_gbl_fadt_gpe_device,
 						  &acpi_gbl_FADT.xgpe0_block,
 						  register_count0, 0,
-						  acpi_gbl_FADT.sci_interrupt,
+						  acpi_get_sci_interrupt(),
 						  &acpi_gbl_gpe_fadt_blocks[0]);
 
 		if (ACPI_FAILURE(status)) {
@@ -170,8 +170,7 @@
 						     &acpi_gbl_FADT.xgpe1_block,
 						     register_count1,
 						     acpi_gbl_FADT.gpe1_base,
-						     acpi_gbl_FADT.
-						     sci_interrupt,
+	   					     acpi_get_sci_interrupt(),
 						     &acpi_gbl_gpe_fadt_blocks
 						     [1]);
 
Index: linux-2.6/drivers/acpi/acpica/evgpeutil.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeutil.c	2011-05-03 10:19:00.213030003 +0800
+++ linux-2.6/drivers/acpi/acpica/evgpeutil.c	2011-05-03 10:20:50.833030004 +0800
@@ -253,7 +253,7 @@
 
 	/* Install new interrupt handler if not SCI_INT */
 
-	if (interrupt_number != acpi_gbl_FADT.sci_interrupt) {
+	if (interrupt_number != acpi_get_sci_interrupt()) {
 		status = acpi_os_install_interrupt_handler(interrupt_number,
 							   acpi_ev_gpe_xrupt_handler,
 							   gpe_xrupt);
@@ -290,7 +290,7 @@
 
 	/* We never want to remove the SCI interrupt handler */
 
-	if (gpe_xrupt->interrupt_number == acpi_gbl_FADT.sci_interrupt) {
+	if (gpe_xrupt->interrupt_number == acpi_get_sci_interrupt()) {
 		gpe_xrupt->gpe_block_list_head = NULL;
 		return_ACPI_STATUS(AE_OK);
 	}
Index: linux-2.6/drivers/acpi/acpica/evsci.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evsci.c	2011-05-03 10:19:00.223030004 +0800
+++ linux-2.6/drivers/acpi/acpica/evsci.c	2011-05-03 10:20:50.833030004 +0800
@@ -142,7 +142,7 @@
 	ACPI_FUNCTION_TRACE(ev_install_sci_handler);
 
 	status =
-	    acpi_os_install_interrupt_handler((u32) acpi_gbl_FADT.sci_interrupt,
+	    acpi_os_install_interrupt_handler((u32) acpi_get_sci_interrupt(),
 					      acpi_ev_sci_xrupt_handler,
 					      acpi_gbl_gpe_xrupt_list_head);
 	return_ACPI_STATUS(status);
@@ -176,7 +176,7 @@
 	/* Just let the OS remove the handler and disable the level */
 
 	status =
-	    acpi_os_remove_interrupt_handler((u32) acpi_gbl_FADT.sci_interrupt,
+	    acpi_os_remove_interrupt_handler((u32) acpi_get_sci_interrupt(),
 					     acpi_ev_sci_xrupt_handler);
 
 	return_ACPI_STATUS(status);
Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c	2011-05-03 10:19:00.213030003 +0800
+++ linux-2.6/drivers/acpi/acpica/evxface.c	2011-05-03 10:20:50.833030004 +0800
@@ -983,3 +983,41 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_release_global_lock)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_get_sci_interrupt
+ *
+ * PARAMETERS:  none
+ *
+ * RETURN:      SCI Interrupt
+ *
+ * DESCRIPTION: Return the ACPI SCI interrupt
+ *
+ ******************************************************************************/
+u16 acpi_get_sci_interrupt(void)
+{
+	return acpi_gbl_FADT.sci_interrupt;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_get_sci_interrupt)
+				
+/*******************************************************************************
+		*
+		* FUNCTION:    acpi_set_sci_interrupt
+		*
+		* PARAMETERS:  override sci irq
+		*
+		* RETURN:      status
+		*
+		* DESCRIPTION: Set the ACPI SCI interrupt
+		*
+ ******************************************************************************/
+acpi_status acpi_set_sci_interrupt(u16 irq)
+{
+	acpi_gbl_FADT.sci_interrupt = irq;
+	return AE_OK;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_set_sci_interrupt)		
+
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c	2011-05-03 10:19:00.203030002 +0800
+++ linux-2.6/drivers/acpi/bus.c	2011-05-03 10:20:50.833030004 +0800
@@ -890,14 +890,14 @@
 			acpi_sci_flags |= ACPI_MADT_TRIGGER_LEVEL;
 		}
 		/* Set PIC-mode SCI trigger type */
-		acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt,
+		acpi_pic_sci_set_trigger(acpi_get_sci_interrupt(),
 					 (acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
 	} else {
 		/*
 		 * now that acpi_gbl_FADT is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_gbl_FADT.sci_interrupt = acpi_sci_override_gsi;
+		acpi_set_sci_interrupt(acpi_sci_override_gsi);
 	}
 #endif
 
Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c	2011-05-03 10:19:48.993030009 +0800
+++ linux-2.6/drivers/acpi/osl.c	2011-05-03 10:20:50.833030004 +0800
@@ -534,7 +534,7 @@
 	 * ACPI interrupts different from the SCI in our copy of the FADT are
 	 * not supported.
 	 */
-	if (gsi != acpi_gbl_FADT.sci_interrupt)
+	if (gsi != acpi_get_sci_interrupt())
 		return AE_BAD_PARAMETER;
 
 	if (acpi_irq_handler)
@@ -559,7 +559,7 @@
 
 acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 {
-	if (irq != acpi_gbl_FADT.sci_interrupt)
+	if (irq != acpi_get_sci_interrupt())
 		return AE_BAD_PARAMETER;
 
 	free_irq(irq, acpi_irq);
@@ -1622,7 +1622,7 @@
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
+		acpi_os_remove_interrupt_handler(acpi_get_sci_interrupt(),
 						 acpi_irq_handler);
 	}
 
Index: linux-2.6/drivers/acpi/pci_link.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_link.c	2011-05-03 10:19:00.203030002 +0800
+++ linux-2.6/drivers/acpi/pci_link.c	2011-05-03 10:20:50.833030004 +0800
@@ -508,7 +508,7 @@
 		}
 	}
 	/* Add a penalty for the SCI */
-	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
+	acpi_irq_penalty[acpi_get_sci_interrupt()] += PIRQ_PENALTY_PCI_USING;
 	return 0;
 }
 
Index: linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
===================================================================
--- linux-2.6.orig/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c	2011-05-03 10:19:00.193030001 +0800
+++ linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c	2011-05-03 10:20:50.833030004 +0800
@@ -104,7 +104,7 @@
 	pci_dev_put(pdev);
 
 	/* we're sharing the IRQ with ACPI */
-	irq = acpi_gbl_FADT.sci_interrupt;
+	irq = acpi_get_sci_interrupt();
 	if (request_irq(irq, &dcon_interrupt, IRQF_SHARED, "DCON", dcon)) {
 		printk(KERN_ERR PREFIX "DCON (IRQ%d) allocation failed\n", irq);
 		return 1;
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h	2011-05-03 10:19:00.253029998 +0800
+++ linux-2.6/include/acpi/acpixf.h	2011-05-03 10:20:50.833030004 +0800
@@ -411,6 +411,10 @@
 acpi_info(const char *module_name,
 	  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
+u16 acpi_get_sci_interrupt(void);
+
+acpi_status acpi_set_sci_interrupt(u16 irq);
+
 /*
  * Debug output
  */

---

