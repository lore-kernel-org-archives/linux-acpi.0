From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Fix panic-at-boot
Date: Wed, 5 Nov 2003 15:53:30 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031105155330.GB29259@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This patch fixes a panic-at-boot when ACPI Hotplug PCI is compiled in,
but ACPI is disabled.

Index: drivers/acpi/pci_root.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/acpi/pci_root.c,v
retrieving revision 1.1
diff -u -p -r1.1 pci_root.c
--- a/drivers/acpi/pci_root.c	29 Jul 2003 17:01:00 -0000	1.1
+++ b/drivers/acpi/pci_root.c	5 Nov 2003 15:48:28 -0000
@@ -66,7 +66,7 @@ struct acpi_pci_root {
 	u64			io_tra;
 };
 
-struct list_head		acpi_pci_roots;
+static LIST_HEAD(acpi_pci_roots);
 
 static struct acpi_pci_driver *sub_driver;
 
@@ -374,8 +374,6 @@ static int __init acpi_pci_root_init (vo
 	acpi_dbg_layer = ACPI_PCI_COMPONENT;
 	acpi_dbg_level = 0xFFFFFFFF;
 	 */
-
- 	INIT_LIST_HEAD(&acpi_pci_roots);
 
 	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
 		return_VALUE(-ENODEV);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
