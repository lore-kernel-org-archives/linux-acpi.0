From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [RFC] __devinit
Date: Fri, 27 Jun 2003 15:41:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030627144147.GA31618@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Seems to me there are a few places that could use a sprinkling of
__devinit.  For PCI drivers, probe methods are supposed to be __devinit
and remove are supposed to be __devexit.  I think the same is true
for ACPI -- add methods should only be called at bootup, under hotplug
operations or at module load, and remove methods should only be called
in hotplug situations or module unload.

If that's not true, then we have a bug as pci_root.c calls
pcibios_scan_root which is marked as __devinit and will therefore
have been freed.

If it is true, then something like the following uncompiled patch would
be worth adding since it should save a few bytes from the kernel text
(if hotplug is not enabled):

Index: drivers/acpi/pci_root.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/pci_root.c,v
retrieving revision 1.8
diff -u -p -r1.8 pci_root.c
--- drivers/acpi/pci_root.c	23 Jun 2003 03:30:15 -0000	1.8
+++ drivers/acpi/pci_root.c	27 Jun 2003 11:52:37 -0000
@@ -140,7 +140,7 @@ acpi_pci_get_translations (
 }
 
 
-static u64
+static u64 __devinit
 acpi_pci_root_bus_tra (
        struct acpi_resource	*resource,
        int			type)
@@ -183,7 +183,7 @@ acpi_pci_root_bus_tra (
 }
 
 
-static int
+static int __devinit
 acpi_pci_evaluate_crs (
 	struct acpi_pci_root	*root)
 {
@@ -206,7 +206,7 @@ acpi_pci_evaluate_crs (
 }
 
 
-static int
+static int __devinit
 acpi_pci_root_add (
 	struct acpi_device	*device)
 {
@@ -345,7 +342,7 @@ end:
 }
 
 
-static int
+static int __devexit
 acpi_pci_root_remove (
 	struct acpi_device	*device,
 	int			type)
Index: arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/pci/pci.c,v
retrieving revision 1.9
diff -u -p -r1.9 pci.c
--- arch/ia64/pci/pci.c	23 Jun 2003 03:30:02 -0000	1.9
+++ arch/ia64/pci/pci.c	27 Jun 2003 11:52:37 -0000
@@ -124,7 +124,7 @@ subsys_initcall(pci_acpi_init);
 
 /* Called by ACPI when it finds a new root bus.  */
 
-static struct pci_controller *
+static struct pci_controller * __devinit
 alloc_pci_controller (int seg)
 {
 	struct pci_controller *controller;
@@ -138,7 +138,7 @@ alloc_pci_controller (int seg)
 	return controller;
 }
 
-static struct pci_bus *
+static struct pci_bus * __devinit
 scan_root_bus (int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b;
@@ -169,7 +169,7 @@ scan_root_bus (int bus, struct pci_ops *
 	return b;
 }
 
-static int
+static int __devinit
 alloc_resource (char *name, struct resource *root, unsigned long start, unsigned long end, unsigned long flags)
 {
 	struct resource *res;
@@ -190,7 +190,7 @@ alloc_resource (char *name, struct resou
 	return 0;
 }
 
-static u64
+static u64 __devinit
 add_io_space (struct acpi_resource_address64 *addr)
 {
 	u64 offset;
@@ -221,7 +221,7 @@ add_io_space (struct acpi_resource_addre
 	return IO_SPACE_BASE(i);
 }
 
-static acpi_status
+static acpi_status __devinit
 count_window (struct acpi_resource *resource, void *data)
 {
 	unsigned int *windows = (unsigned int *) data;
@@ -242,7 +242,7 @@ struct pci_root_info {
 	char *name;
 };
 
-static acpi_status
+static acpi_status __devinit
 add_window (struct acpi_resource *res, void *data)
 {
 	struct pci_root_info *info = (struct pci_root_info *) data;
@@ -283,7 +283,7 @@ add_window (struct acpi_resource *res, v
 	return AE_OK;
 }
 
-struct pci_bus *
+struct pci_bus * __devinit
 pci_acpi_scan_root (struct acpi_device *device, int domain, int bus)
 {
 	struct pci_root_info info;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
