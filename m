From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: [PATCH][2.6.8]  Incorrect  PCI interrupt assignment on ES7000
Date: Sun, 12 Sep 2004 19:47:53 -0500
Sender: lse-tech-admin@lists.sourceforge.net
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04220260@USRV-EXCH2.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <lse-tech-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: lse-tech-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lse-tech>,
	<mailto:lse-tech-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:lse-tech@lists.sourceforge.net>
List-Help: <mailto:lse-tech-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lse-tech>,
	<mailto:lse-tech-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=lse-tech>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, akpm@osdl.org
List-Id: linux-acpi@vger.kernel.org

Hello,
We are experiencing failures on ES7000 that are interrupt initialization
related, when PCI cards on first PCI module won't work. It turned out
that there are two distinct problems with setting up PCI interrupts on
the first IO-APIC when a platform implements IRQ overrides. This is the
case on ES7000, which has PCI range 0-11 on the first IO-APIC, and ISA
range is shifted and starts at 12.

First problem is that in arch/i386/kernel/acpi/boot.c, platform GSI does
not propagate back from mp_register_gsi() to a calling routine which
results in IRQ to be set for wrong GSI. This causes most of the PCI
slots of the first PCI module to fail. More detail on it is in
http://bugme.osdl.org/show_bug.cgi?id=3D3349.
Below is the code change that fixes the problem:


------------------------------------------------------------------------
---------------
diff -Naur linux-2.6.8/include/asm-i386/mpspec.h
linux8/include/asm-i386/mpspec.h
--- linux-2.6.8/include/asm-i386/mpspec.h	2004-08-14
01:36:10.000000000 -0400
+++ linux8/include/asm-i386/mpspec.h	2004-08-15 06:16:27.000000000
-0400
@@ -33,7 +33,7 @@
 extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8
trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_register_gsi (u32 gsi, int edge_level, int
active_high_low);
+extern int mp_register_gsi (u32 gsi, int edge_level, int
active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
=20
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
diff -Naur linux-2.6.8/arch/i386/kernel/acpi/boot.c
linux8/arch/i386/kernel/acpi/boot.c
--- linux-2.6.8/arch/i386/kernel/acpi/boot.c	2004-08-14
01:37:40.000000000 -0400
+++ linux8/arch/i386/kernel/acpi/boot.c	2004-08-15 06:15:24.000000000
-0400
@@ -442,6 +442,7 @@
 unsigned int acpi_register_gsi(u32 gsi, int edge_level, int
active_high_low)
 {
 	unsigned int irq;
+	unsigned int plat_gsi;
=20
 #ifdef CONFIG_PCI
 	/*
@@ -463,10 +464,10 @@
=20
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOAPIC) {
-		mp_register_gsi(gsi, edge_level, active_high_low);
+		plat_gsi =3D mp_register_gsi(gsi, edge_level,
active_high_low);
 	}
 #endif
-	acpi_gsi_to_irq(gsi, &irq);
+	acpi_gsi_to_irq(plat_gsi, &irq);
 	return irq;
 }
 EXPORT_SYMBOL(acpi_register_gsi);
diff -Naur linux-2.6.8/arch/i386/kernel/mpparse.c
linux8/arch/i386/kernel/mpparse.c
--- linux-2.6.8/arch/i386/kernel/mpparse.c	2004-08-14
01:36:44.000000000 -0400
+++ linux8/arch/i386/kernel/mpparse.c	2004-08-15 06:16:18.000000000
-0400
@@ -1051,7 +1051,7 @@
=20
 int (*platform_rename_gsi)(int ioapic, int gsi);
=20
-void mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
+int mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
 {
 	int			ioapic =3D -1;
 	int			ioapic_pin =3D 0;
@@ -1066,7 +1066,7 @@
 	ioapic =3D mp_find_ioapic(gsi);
 	if (ioapic < 0) {
 		printk(KERN_WARNING "No IOAPIC for GSI %u\n", gsi);
-		return;
+		return gsi;
 	}
=20
 	ioapic_pin =3D gsi - mp_ioapic_routing[ioapic].gsi_base;
@@ -1085,12 +1085,12 @@
 		printk(KERN_ERR "Invalid reference to IOAPIC pin "
 			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id,=20
 			ioapic_pin);
-		return;
+		return gsi;
 	}
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return;
+		return gsi;
 	}
=20
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |=3D (1<<bit);
@@ -1098,6 +1098,7 @@
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		    edge_level =3D=3D ACPI_EDGE_SENSITIVE ? 0 : 1,
 		    active_high_low =3D=3D ACPI_ACTIVE_HIGH ? 0 : 1);
+	return gsi;
 }
=20
 #endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER ||
CONFIG_ACPI_BOOT)*/
------------------------------------------------------------------------
-------------

Second issue is that the ACPI driver uses zero as an error return while
parsing _PRT. On ES7000, pin 0 is used for a PCI device. While zero is a
legitimate GSI, it gets discarded as invalid by the parser. This results
in any device with an interrupt line wired to IRQ 0 will not be assigned
an IRQ for that interrupt line. This causes failure of the slot that
contains device wired to pin 0. More detail on it is in
http://bugme.osdl.org/show_bug.cgi?id=3D3351. How about using "-1" as an
error return? Below is proposed code change:


------------------------------------------------------------------------
---------------------
diff -Naur linux-2.6.8/drivers/acpi/pci_irq.c
linux8/drivers/acpi/pci_irq.c
--- linux-2.6.8/drivers/acpi/pci_irq.c	2004-08-14 01:36:57.000000000
-0400
+++ linux8/drivers/acpi/pci_irq.c	2004-08-14 13:56:50.000000000
-0400
@@ -249,14 +249,14 @@
 	entry =3D acpi_pci_irq_find_prt_entry(segment, bus_nr, device,
pin);=20
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not
found\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 =09
 	if (entry->link.handle) {
 		irq =3D acpi_pci_link_get_irq(entry->link.handle,
entry->link.index, edge_level, active_high_low);
-		if (!irq) {
+		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ
link routing entry\n"));
-			return_VALUE(0);
+			return_VALUE(-1);
 		}
 	} else {
 		irq =3D entry->link.index;
@@ -277,7 +277,7 @@
 	int			*active_high_low)
 {
 	struct pci_dev		*bridge =3D dev;
-	int			irq =3D 0;
+	int			irq =3D -1;
 	u8			bridge_pin =3D 0;
=20
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
@@ -289,7 +289,7 @@
 	 * Attempt to derive an IRQ for this device from a parent
bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card
bridge).
 	 */
-	while (!irq && bridge->bus->self) {
+	while (irq < 0 && bridge->bus->self) {
 		pin =3D (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge =3D bridge->bus->self;
=20
@@ -299,7 +299,7 @@
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
 					"No interrupt pin configured for
device %s\n", pci_name(bridge)));
-				return_VALUE(0);
+				return_VALUE(-EINVAL);
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin --;
@@ -310,9 +310,9 @@
 			pin, edge_level, active_high_low);
 	}
=20
-	if (!irq) {
+	if (irq < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to derive IRQ
for device %s\n", pci_name(dev)));
-		return_VALUE(0);
+		return_VALUE(-EINVAL);
 	}
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s
from %s\n",
@@ -358,18 +358,18 @@
 	 * If no PRT entry was found, we'll try to derive an IRQ from
the
 	 * device's parent bridge.
 	 */
-	if (!irq)
+	if (irq < 0)
  		irq =3D acpi_pci_irq_derive(dev, pin, &edge_level,
&active_high_low);
 =20
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS /=20
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (!irq) {
+	if (irq < 0) {
 		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no
GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq && (dev->irq <=3D 0xF)) {
+		if (dev->irq >=3D 0  && (dev->irq <=3D 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			return_VALUE(dev->irq);
 		}
diff -Naur linux-2.6.8/drivers/acpi/pci_link.c
linux8/drivers/acpi/pci_link.c
--- linux-2.6.8/drivers/acpi/pci_link.c	2004-08-14 01:36:16.000000000
-0400
+++ linux8/drivers/acpi/pci_link.c	2004-08-14 13:56:50.000000000
-0400
@@ -593,27 +593,27 @@
 	result =3D acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link
device\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
=20
 	link =3D (struct acpi_pci_link *) acpi_driver_data(device);
 	if (!link) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link
context\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
=20
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n",
index));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
=20
 	if (acpi_pci_link_allocate(link))
-		return_VALUE(0);
+		return_VALUE(-1);
 	  =20
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is
0!\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
=20
 	if (edge_level) *edge_level =3D link->irq.edge_level;
------------------------------------------------------------------------
--------

The patches above were tested on ES7000 and also on generic Intel system
and worked OK.
I will appreciate any thoughts and feedback on the above issues and
patches.

Thanks,
--Natalie


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
