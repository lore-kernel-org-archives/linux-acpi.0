From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [RFC] Shrink acpi_pci_id
Date: Tue, 24 Jun 2003 20:42:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030624194242.GK451@parcelfarce.linux.theplanet.co.uk>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Take struct acpi_pci_id on a diet.  Shrink bus from u16 to u8 and combine
device & function into the more natural devfn.  This patch won't apply
to any tree since it requires *and* conflicts with some changes that
are in 2.5.74.  This is just to see what people think.

 arch/i386/kernel/mpparse.c       |    3 ++-
 drivers/acpi/events/evrgnini.c   |    3 +--
 drivers/acpi/executer/exregion.c |    4 ++--
 drivers/acpi/hardware/hwregs.c   |    6 ++----
 drivers/acpi/osl.c               |    7 +++----
 drivers/acpi/pci_bind.c          |   17 ++++++++---------
 drivers/acpi/pci_irq.c           |    5 ++---
 drivers/acpi/pci_root.c          |    3 +--
 include/acpi/acmacros.h          |   12 +++++++-----
 include/acpi/actypes.h           |    7 +++----
 10 files changed, 31 insertions(+), 36 deletions(-)

Index: arch/i386/kernel/mpparse.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/kernel/mpparse.c,v
retrieving revision 1.17
diff -u -p -r1.17 mpparse.c
--- arch/i386/kernel/mpparse.c	17 Jun 2003 11:54:06 -0000	1.17
+++ arch/i386/kernel/mpparse.c	24 Jun 2003 19:35:17 -0000
@@ -15,6 +15,7 @@
 
 #include <linux/mm.h>
 #include <linux/irq.h>
+#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
@@ -1135,7 +1136,7 @@ void __init mp_parse_prt (void)
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus, 
-			entry->id.device, ('A' + entry->pin), 
+			PCI_SLOT(entry->id.devfn), ('A' + entry->pin), 
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
 			entry->irq);
 	}
Index: drivers/acpi/osl.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/osl.c,v
retrieving revision 1.18
diff -u -p -r1.18 osl.c
--- drivers/acpi/osl.c	23 Jun 2003 03:30:15 -0000	1.18
+++ drivers/acpi/osl.c	24 Jun 2003 19:35:20 -0000
@@ -466,7 +466,7 @@ acpi_os_read_pci_configuration (struct a
 	}
 
 	result = raw_pci_ops->read(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				pci_id->devfn, reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -491,7 +491,7 @@ acpi_os_write_pci_configuration (struct 
 	}
 
 	result = raw_pci_ops->write(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				pci_id->devfn, reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -522,8 +522,7 @@ acpi_os_derive_pci_id_2 (
 
 		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &temp);
 		if (ACPI_SUCCESS(status)) {
-			pci_id->device  = ACPI_HIWORD (ACPI_LODWORD (temp));
-			pci_id->function = ACPI_LOWORD (ACPI_LODWORD (temp));
+			pci_id->devfn = ACPI_PCI_DEVFN32(temp);
 
 			if (*is_bridge)
 				pci_id->bus = *bus_number;
Index: drivers/acpi/pci_bind.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/pci_bind.c,v
retrieving revision 1.6
diff -u -p -r1.6 pci_bind.c
--- drivers/acpi/pci_bind.c	15 Feb 2003 03:47:20 -0000	1.6
+++ drivers/acpi/pci_bind.c	24 Jun 2003 19:35:20 -0000
@@ -110,7 +110,7 @@ acpi_os_get_pci_id (
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Device %s has PCI address %02x:%02x:%02x.%02x\n", 
 		acpi_device_bid(device), id->segment, id->bus, 
-		id->device, id->function));
+		PCI_SLOT(id->devfn), PCI_FUNC(id->devfn)));
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -165,12 +165,11 @@ acpi_pci_bind (
 	 * These are simply obtained from the device's _ADR method.  Note
 	 * that a value of zero is valid.
 	 */
-	data->id.device = device->pnp.bus_address >> 16;
-	data->id.function = device->pnp.bus_address & 0xFFFF;
+	data->id.devfn = ACPI_PCI_DEVFN32(device->pnp.bus_address);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "...to %02x:%02x:%02x.%02x\n",
-		data->id.segment, data->id.bus, data->id.device, 
-		data->id.function));
+		data->id.segment, data->id.bus, PCI_SLOT(data->id.devfn), 
+		PCI_FUNC(data->id.devfn)));
 
 	/*
 	 * TBD: Support slot devices (e.g. function=0xFFFF).
@@ -183,12 +182,12 @@ acpi_pci_bind (
 	 * this typically means that the device isn't currently inserted
 	 * (e.g. docking station, port replicator, etc.).
 	 */
-	data->dev = pci_find_slot(data->id.bus, PCI_DEVFN(data->id.device, data->id.function));
+	data->dev = pci_find_slot(data->id.bus, data->id.devfn);
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 			"Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
 			data->id.segment, data->id.bus, 
-			data->id.device, data->id.function));
+			PCI_SLOT(data->id.devfn), PCI_FUNC(data->id.devfn)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -196,7 +195,7 @@ acpi_pci_bind (
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Device %02x:%02x:%02x.%02x has invalid 'bus' field\n",
 			data->id.segment, data->id.bus, 
-			data->id.device, data->id.function));
+			PCI_SLOT(data->id.devfn), PCI_FUNC(data->id.devfn)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -211,7 +210,7 @@ acpi_pci_bind (
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 			"Device %02x:%02x:%02x.%02x is a PCI bridge\n",
 			data->id.segment, data->id.bus, 
-			data->id.device, data->id.function));
+			PCI_SLOT(data->id.devfn), PCI_FUNC(data->id.devfn)));
 		data->bus = data->dev->subordinate;
 		device->ops.bind = acpi_pci_bind;
 	}
Index: drivers/acpi/pci_irq.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/pci_irq.c,v
retrieving revision 1.11
diff -u -p -r1.11 pci_irq.c
--- drivers/acpi/pci_irq.c	14 Jun 2003 22:15:04 -0000	1.11
+++ drivers/acpi/pci_irq.c	24 Jun 2003 19:35:20 -0000
@@ -76,7 +76,7 @@ acpi_pci_irq_find_prt_entry (
 		entry = list_entry(node, struct acpi_prt_entry, node);
 		if ((segment == entry->id.segment) 
 			&& (bus == entry->id.bus) 
-			&& (device == entry->id.device)
+			&& (device == PCI_SLOT(entry->id.devfn))
 			&& (pin == entry->pin)) {
 			return_PTR(entry);
 		}
@@ -107,8 +107,7 @@ acpi_pci_irq_add_entry (
 
 	entry->id.segment = segment;
 	entry->id.bus = bus;
-	entry->id.device = (prt->address >> 16) & 0xFFFF;
-	entry->id.function = prt->address & 0xFFFF;
+	entry->id.devfn = (prt->address >> 13) | (prt->address & 7);
 	entry->pin = prt->pin;
 
 	/*
Index: drivers/acpi/pci_root.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/pci_root.c,v
retrieving revision 1.8
diff -u -p -r1.8 pci_root.c
--- drivers/acpi/pci_root.c	23 Jun 2003 03:30:15 -0000	1.8
+++ drivers/acpi/pci_root.c	24 Jun 2003 19:35:20 -0000
@@ -286,8 +284,7 @@ acpi_pci_root_add (
 	 * -----------------
 	 * Obtained from _ADR (which has already been evaluated for us).
 	 */
-	root->id.device = device->pnp.bus_address >> 16;
-	root->id.function = device->pnp.bus_address & 0xFFFF;
+	root->id.devfn = ACPI_PCI_DEVFN32(device->pnp.bus_address);
 
 	/*
 	 * Evaluate _CRS to get root bridge resources
Index: drivers/acpi/events/evrgnini.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/events/evrgnini.c,v
retrieving revision 1.10
diff -u -p -r1.10 evrgnini.c
--- drivers/acpi/events/evrgnini.c	27 May 2003 17:22:27 -0000	1.10
+++ drivers/acpi/events/evrgnini.c	24 Jun 2003 19:35:20 -0000
@@ -286,8 +286,7 @@ acpi_ev_pci_config_region_setup (
 	 * the data, just do nothing on failure.
 	 */
 	if (ACPI_SUCCESS (status)) {
-		pci_id->device  = ACPI_HIWORD (ACPI_LODWORD (pci_value));
-		pci_id->function = ACPI_LOWORD (ACPI_LODWORD (pci_value));
+		pci_id->devfn = ACPI_PCI_DEVFN32(pci_value);
 	}
 
 	/* The PCI segment number comes from the _SEG method */
Index: drivers/acpi/executer/exregion.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/executer/exregion.c,v
retrieving revision 1.9
diff -u -p -r1.9 exregion.c
--- drivers/acpi/executer/exregion.c	5 May 2003 17:06:18 -0000	1.9
+++ drivers/acpi/executer/exregion.c	24 Jun 2003 19:35:20 -0000
@@ -368,8 +368,8 @@ acpi_ex_pci_config_space_handler (
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_INFO,
 		"pci_config %d (%d) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
-		function, bit_width, pci_id->segment, pci_id->bus, pci_id->device,
-		pci_id->function, pci_register));
+		function, bit_width, pci_id->segment, pci_id->bus,
+		PCI_SLOT(pci_id->devfn), PCI_FUNC(pci_id->devfn), pci_register));
 
 	switch (function) {
 	case ACPI_READ:
Index: drivers/acpi/hardware/hwregs.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/hardware/hwregs.c,v
retrieving revision 1.13
diff -u -p -r1.13 hwregs.c
--- drivers/acpi/hardware/hwregs.c	23 Jun 2003 03:30:16 -0000	1.13
+++ drivers/acpi/hardware/hwregs.c	24 Jun 2003 19:35:21 -0000
@@ -746,8 +746,7 @@ acpi_hw_low_level_read (
 
 		pci_id.segment = 0;
 		pci_id.bus     = 0;
-		pci_id.device  = ACPI_PCI_DEVICE (reg->address);
-		pci_id.function = ACPI_PCI_FUNCTION (reg->address);
+		pci_id.devfn   = ACPI_PCI_DEVFN64(reg->address);
 		pci_register   = (u16) ACPI_PCI_REGISTER (reg->address);
 
 		status = acpi_os_read_pci_configuration (&pci_id, pci_register,
@@ -832,8 +831,7 @@ acpi_hw_low_level_write (
 
 		pci_id.segment = 0;
 		pci_id.bus     = 0;
-		pci_id.device  = ACPI_PCI_DEVICE (reg->address);
-		pci_id.function = ACPI_PCI_FUNCTION (reg->address);
+		pci_id.devfn   = ACPI_PCI_DEVFN64(reg->address);
 		pci_register   = (u16) ACPI_PCI_REGISTER (reg->address);
 
 		status = acpi_os_write_pci_configuration (&pci_id, pci_register,
Index: include/acpi/acmacros.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/acpi/acmacros.h,v
retrieving revision 1.5
diff -u -p -r1.5 acmacros.h
--- include/acpi/acmacros.h	27 May 2003 17:27:39 -0000	1.5
+++ include/acpi/acmacros.h	24 Jun 2003 19:35:24 -0000
@@ -360,20 +360,22 @@
 
 #if ACPI_MACHINE_WIDTH != 16
 
-#define ACPI_PCI_DEVICE(a)              (u16) ((ACPI_HIDWORD ((a))) & 0x0000FFFF)
-#define ACPI_PCI_FUNCTION(a)            (u16) ((ACPI_LODWORD ((a))) >> 16)
 #define ACPI_PCI_REGISTER(a)            (u16) ((ACPI_LODWORD ((a))) & 0x0000FFFF)
 
+/* Convert an ACPI integer to a Linux devfn.  ACPI has two representations --
+ * one in 32-bits and the other in 64-bits.  So we provide two macros.
+ */
+#define ACPI_PCI_DEVFN32(a)		(u8) (((a) >> 13) | ((a) & 7))
+#define ACPI_PCI_DEVFN64(a)		ACPI_PCI_DEVFN32((a) >> 16)
+
 #else
 
 /* No support for GAS and PCI IDs in 16-bit mode  */
 
-#define ACPI_PCI_FUNCTION(a)            (u16) ((a) & 0xFFFF0000)
-#define ACPI_PCI_DEVICE(a)              (u16) ((a) & 0x0000FFFF)
 #define ACPI_PCI_REGISTER(a)            (u16) ((a) & 0x0000FFFF)
+#define ACPI_PCI_DEVFN32(a)		(u8) (((a) >> 13) | ((a) & 7))
 
 #endif
-
 
 /* Bitfields within ACPI registers */
 
Index: include/acpi/actypes.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/acpi/actypes.h,v
retrieving revision 1.7
diff -u -p -r1.7 actypes.h
--- include/acpi/actypes.h	23 Jun 2003 03:30:44 -0000	1.7
+++ include/acpi/actypes.h	24 Jun 2003 19:35:25 -0000
@@ -892,10 +892,9 @@ struct acpi_device_info
 
 struct acpi_pci_id
 {
-	u16                                 segment;
-	u16                                 bus;
-	u16                                 device;
-	u16                                 function;
+	u16	segment;
+	u8	bus;
+	u8	devfn;
 };
 
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
