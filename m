From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ia64 part of ACPI IRQ cleanup
Date: Tue, 6 Apr 2004 15:11:26 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404061511.26991.bjorn.helgaas@hp.com>
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
To: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Here's the ia64 part of the ACPI IRQ cleanup I proposed here:

	http://www.gelato.unsw.edu.au/linux-ia64/0403/8979.html

After the arch bits are in, I'll post the corresponding ACPI changes.
I removed the "Found IRQ" printk now because when the ACPI
change goes in, dev->irq won't be initialized until *after*
acpi_pci_irq_enable().

===== arch/ia64/kernel/acpi.c 1.65 vs edited =====
--- 1.65/arch/ia64/kernel/acpi.c	Sat Mar 20 22:28:40 2004
+++ edited/arch/ia64/kernel/acpi.c	Mon Apr  5 11:23:32 2004
@@ -527,7 +527,7 @@
 	if (fadt->iapc_boot_arch & BAF_LEGACY_DEVICES)
 		acpi_legacy_devices = 1;
 
-	acpi_register_irq(fadt->sci_int, ACPI_ACTIVE_LOW, ACPI_LEVEL_SENSITIVE);
+	acpi_register_gsi(fadt->sci_int, ACPI_ACTIVE_LOW, ACPI_LEVEL_SENSITIVE);
 	return 0;
 }
 
@@ -662,5 +662,12 @@
 			(trigger == ACPI_EDGE_SENSITIVE) ? IOSAPIC_EDGE : IOSAPIC_LEVEL);
 }
 EXPORT_SYMBOL(acpi_register_irq);
+
+unsigned int
+acpi_register_gsi (u32 gsi, int polarity, int trigger)
+{
+	return acpi_register_irq(gsi, polarity, trigger);
+}
+EXPORT_SYMBOL(acpi_register_gsi);
 
 #endif /* CONFIG_ACPI_BOOT */
===== arch/ia64/pci/pci.c 1.45 vs edited =====
--- 1.45/arch/ia64/pci/pci.c	Tue Mar 23 18:55:32 2004
+++ edited/arch/ia64/pci/pci.c	Mon Apr  5 15:21:56 2004
@@ -441,7 +441,6 @@
 	if (ret < 0)
 		return ret;
 
-	printk(KERN_INFO "PCI: Found IRQ %d for device %s\n", dev->irq, pci_name(dev));
 	return acpi_pci_irq_enable(dev);
 }
 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
