From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] Use new acpi_gsi_to_irq() interface
Date: Fri, 2 Apr 2004 15:44:42 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404021544.42964.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Clean up the #ifdefs in acpi_os_install_interrupt_handler(), now that
i386, x86_64, and ia64 all provide the acpi_gsi_to_irq() interface.

Note that this also fixes an old bug in acpi_os_remove_interrupt_handler():
we used to re-translate "irq", which is a Linux IRQ.  No retranslation is
necessary; we saved the Linux IRQ in acpi_os_install_interrupt_handler(),
so we simply need to free_irq() it.

Tested on ia64, compiled for i386 (defconfig, defconfig + PCI_USE_VECTOR,
defconfig - SMP (and - X86_IO_APIC)), compiled for x86_64 (defconfig).

===== drivers/acpi/osl.c 1.48 vs edited =====
--- 1.48/drivers/acpi/osl.c	Wed Mar 31 19:18:12 2004
+++ edited/drivers/acpi/osl.c	Fri Apr  2 13:56:24 2004
@@ -63,7 +63,7 @@
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
-static int acpi_irq_irq;
+static unsigned int acpi_irq_irq;
 static OSD_HANDLER acpi_irq_handler;
 static void *acpi_irq_context;
 
@@ -240,23 +240,22 @@
 }
 
 acpi_status
-acpi_os_install_interrupt_handler(u32 irq, OSD_HANDLER handler, void *context)
+acpi_os_install_interrupt_handler(u32 gsi, OSD_HANDLER handler, void *context)
 {
+	unsigned int irq;
+
 	/*
-	 * Ignore the irq from the core, and use the value in our copy of the
+	 * Ignore the GSI from the core, and use the value in our copy of the
 	 * FADT. It may not be the same if an interrupt source override exists
 	 * for the SCI.
 	 */
-	irq = acpi_fadt.sci_int;
-
-#if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
-	irq = acpi_irq_to_vector(irq);
-	if (irq < 0) {
-		printk(KERN_ERR PREFIX "SCI (ACPI interrupt %d) not registered\n",
-		       acpi_fadt.sci_int);
+	gsi = acpi_fadt.sci_int;
+	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
+		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
+		       gsi);
 		return AE_OK;
 	}
-#endif
+
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
@@ -272,9 +271,6 @@
 acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
 {
 	if (irq) {
-#if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
-		irq = acpi_irq_to_vector(irq);
-#endif
 		free_irq(irq, acpi_irq);
 		acpi_irq_handler = NULL;
 		acpi_irq_irq = 0;
===== include/acpi/acpiosxf.h 1.31 vs edited =====
--- 1.31/include/acpi/acpiosxf.h	Sat Jan 17 16:12:31 2004
+++ edited/include/acpi/acpiosxf.h	Fri Apr  2 13:52:13 2004
@@ -188,14 +188,14 @@
 
 acpi_status
 acpi_os_install_interrupt_handler (
-	u32                             interrupt_number,
-	OSD_HANDLER             service_routine,
+	u32                             gsi,
+	OSD_HANDLER                     service_routine,
 	void                            *context);
 
 acpi_status
 acpi_os_remove_interrupt_handler (
 	u32                             interrupt_number,
-	OSD_HANDLER             service_routine);
+	OSD_HANDLER                     service_routine);
 
 
 /*
===== include/linux/acpi.h 1.32 vs edited =====
--- 1.32/include/linux/acpi.h	Mon Mar  1 01:26:35 2004
+++ edited/include/linux/acpi.h	Fri Apr  2 13:48:53 2004
@@ -438,6 +438,7 @@
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
 int acpi_pci_irq_init (void);
+int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
