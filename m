From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: [PATCH] resend Andrew de Quincey patch, that resolve hangs problems
Date: 10 Nov 2003 23:15:47 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068506148.1703.52.camel@darkstar.portugal>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84DC4@pdsmsx403.ccr.corp.intel.com>
	<1068179499.3555.26.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nYVw1rNm1anujn4N5UhV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068179499.3555.26.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-nYVw1rNm1anujn4N5UhV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi=20
After the last experience with kernel 2.4.23-pre9, I test this patch and
resolves the problem above.
And I believe that resolve various problems with irqs.
My tests confirm that I need this patch for my machine works well.
Yesterday my ISP had many problems and my cable modem has gone down
several times and my laptop never hangs.
_Note: This patch is already applied.in kernel 2.4.22-ac4.
thanks

On Fri, 2003-11-07 at 04:31, S=C3=A9rgio Monteiro Basto wrote:
> Hi=20
> Sorry to say this, but laptop hangs again with this patch in pre-9.
> when usb CDCEthernet, was gone down.
> The facts are:
> With 22-ac4 never hangs, I use this kernel, for my normally work, since
> this release (2003-09-21) and I never had this kind of problems.
> I just began use usb CDCEthernet with kernel 4.22, so I don't know if it
> hangs or not before.
> so I know the problem is began in 23-preX, (I think after pre7) or is
> not been corrected like it does in ac4.
> If the first choice, what I can test more?
> If the second choice, could be one Andrew de Quincey patch's, that is
> not applied.
> Well I just don't resend the patch because I don't want make more
> confusions , and I don't understand if you try (force) to not use the
> patch.  If Alan had applied it , I think that can be trustable. Not more
> than that.
>=20
> thanks
>=20
> On Thu, 2003-11-06 at 02:40, Li, Shaohua wrote:
> >=20
> > Many thanks you let me know the result.
> >=20
> > Thanks,
> > Shaohua
> >=20
> >=20
> > > -----Original Message-----
> > > From: S=C3=A9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > > Sent: 2003=E5=B9=B411=E6=9C=886=E6=97=A5 11:20
> > > To: Li, Shaohua
> > > Cc: acpi-devel
> > > Subject: RE: [ACPI] [Patch]fix EC GPE context error
> > >=20
> > > Hi,
> > > The first tests seems ok, in 2.4.23-pre9, I had problems without this
> > > patch, my laptop had hang again, when my usb cable modem has gone dow=
n
> > > and I turn it off.
> > > Now, with this patch, don't had hang anymore.
> > > I will test it more time, if I have a problems, I will tell you.
> > >=20
> > > thanks
> > >=20
> > > On Mon, 2003-11-03 at 13:29, Li, Shaohua wrote:
> > > >
> > > > Hi,
> > > >    I have attached a patch against 2.4 in bugzilla 1171, please hel=
p
> > > test. Many thanks.
> > > >
> > > > Thanks,
> > > > Shaohua
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: S=C3=A9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > > > > Sent: 2003=E5=B9=B411=E6=9C=883=E6=97=A5 3:30
> > > > > To: Li, Shaohua
> > > > > Cc: ACPI Developers
> > > > > Subject: Re: [ACPI] [Patch]fix EC GPE context error
> > > > >
> > > > > Hi
> > > > > I can't apply this patch to 2.23-pre9 neither pre8 or pre7 .
> > > > > I got one big rejected file (on osl.c I think)
> > > > >
> > > > > thanks
> > > > >
> > > > > On Fri, 2003-10-31 at 08:42, Li, Shaohua wrote:
> > > > > > Hi,
> > > > > >
> > > > > >      2.6-test9 has a regression. Specifically, the EC GPE conte=
xt
> > > fix
> > > > > > has error. This new patch is to replace the old one. The patch =
is
> > > > > > against 2.6-test7, and has passed under T40 and ASUS M2400. You=
 can
> > > find
> > > > > > detail info in osdl bugzilla 1171. Please help test.
> > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Shaohua
> > > > > >
> > > > > >
> > > > > >
> > > > > --
> > > > > S=C3=A9rgioMB
> > > > > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> > > > >
> > > > > Who gives me one shell, give me everything.
> > > >
> > > --
> > > S=C3=A9rgioMB
> > > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> > >=20
> > > Who gives me one shell, give me everything.
> >=20
> --=20
> S=C3=A9rgioMB
> email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
>=20
> Who gives me one shell, give me everything.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=C3=A9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-nYVw1rNm1anujn4N5UhV
Content-Disposition: attachment; filename=acpi-picmode-6.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=acpi-picmode-6.patch; charset=ISO-8859-1

diff -Nur linux-2.4.23-pre6.orig/arch/i386/kernel/Makefile linux-2.4.23-pre=
6/arch/i386/kernel/Makefile
--- linux-2.4.23-pre6.orig/arch/i386/kernel/Makefile	Wed Oct  8 00:51:23 20=
03
+++ linux-2.4.23-pre6/arch/i386/kernel/Makefile	Wed Oct  8 03:56:42 2003
@@ -36,7 +36,7 @@
 obj-$(CONFIG_X86_CPUID)		+=3D cpuid.o
 obj-$(CONFIG_MICROCODE)		+=3D microcode.o
 obj-$(CONFIG_APM)		+=3D apm.o
-obj-$(CONFIG_ACPI_BOOT)		+=3D acpi.o
+obj-$(CONFIG_ACPI_BOOT)		+=3D acpi.o pic.o
 obj-$(CONFIG_ACPI_SLEEP)	+=3D acpi_wakeup.o
 obj-$(CONFIG_SMP)		+=3D smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+=3D mpparse.o apic.o nmi.o
diff -Nur linux-2.4.23-pre6.orig/arch/i386/kernel/mpparse.c linux-2.4.23-pr=
e6/arch/i386/kernel/mpparse.c
--- linux-2.4.23-pre6.orig/arch/i386/kernel/mpparse.c	Wed Oct  8 00:51:23 2=
003
+++ linux-2.4.23-pre6/arch/i386/kernel/mpparse.c	Wed Oct  8 03:56:42 2003
@@ -1291,10 +1291,11 @@
=20
 #ifdef CONFIG_ACPI_PCI
=20
-void __init mp_parse_prt (void)
+int __init mp_parse_prt (void)
 {
 	struct list_head	*node =3D NULL;
 	struct acpi_prt_entry	*entry =3D NULL;
+ 	struct acpi_prt_list	*prt_list =3D NULL;
 	int			ioapic =3D -1;
 	int			ioapic_pin =3D 0;
 	int			irq =3D 0;
@@ -1302,16 +1303,31 @@
 	int			edge_level =3D 0;
 	int			active_high_low =3D 0;
=20
+ 	/* Get the current PRT */
+ 	prt_list =3D acpi_pci_get_prt_list();
+  =20
+ 	if (!prt_list->count) {
+ 		acpi_pci_destroy_prt_list(prt_list);
+ 		printk(KERN_WARNING "ACPI tables contain no IO-APIC PCI IRQ "
+ 			"routing entries\n");
+ 		return_VALUE(-ENODEV);
+ 	}
+  =20
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
 	 * routing for all entries.
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &prt_list->entries) {
 		entry =3D list_entry(node, struct acpi_prt_entry, node);
=20
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
 			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &e=
dge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+		  =20
 			if (!irq)
 				continue;
 		}
@@ -1364,8 +1380,11 @@
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin,=20
 			entry->irq);
 	}
-=09
-	return;
+  =20
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
+
+	return 0;
 }
=20
 #endif /*CONFIG_ACPI_PCI*/
diff -Nur linux-2.4.23-pre6.orig/arch/i386/kernel/pic.c linux-2.4.23-pre6/a=
rch/i386/kernel/pic.c
--- linux-2.4.23-pre6.orig/arch/i386/kernel/pic.c	Thu Jan  1 00:00:00 1970
+++ linux-2.4.23-pre6/arch/i386/kernel/pic.c	Wed Oct  8 03:56:42 2003
@@ -0,0 +1,102 @@
+/* -----------------------------------------------------------------------=
 *
+ *  =20
+ *   Copyright 2003 Andrew de Quincey - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * -----------------------------------------------------------------------=
 */
+
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI_PCI
+
+extern void eisa_set_level_irq(unsigned int irq);
+
+int __init pic_parse_prt (void)
+{
+	struct list_head	*node =3D NULL;
+	struct acpi_prt_entry	*entry =3D NULL;
+	struct acpi_prt_list	*prt_list =3D NULL;
+	int			edge_level =3D 0;
+	int			active_high_low =3D 0;
+	int			irq =3D 0;
+	int			programmed[16];
+
+	/* Get the current PRT */
+	prt_list =3D acpi_pci_get_prt_list();
+  =20
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING "ACPI tables contain no PIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+
+	/* mark all IRQs as unprogrammed */
+	memset(programmed, 0, sizeof(programmed));
+  =20
+	/*
+	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
+	 * IRQs if necessary.
+	 */
+	list_for_each(node, &prt_list->entries) {
+		entry =3D list_entry(node, struct acpi_prt_entry, node);
+
+		/* Need to get irq for dynamic entry */
+		if (entry->link.handle) {
+			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &e=
dge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+ 			if (!irq)=20
+				continue;
+		}
+	  =20
+		/* sanity check + update entry */
+		if ((irq < 0) || (irq > 15)) {
+			printk(KERN_ERR "Invalid IRQ (%i) passed to PIC programming code\n", ir=
q);
+			entry->irq =3D 0;
+			continue;
+		}
+		entry->irq =3D irq;
+
+		/* check if it has already been dealt with */
+		if (programmed[irq]) {
+			printk(KERN_DEBUG "PIC: IRQ (%i) already programmed\n", irq);
+			continue;
+		}
+		programmed[irq] =3D 1;
+
+		/* program it */
+		if (edge_level) {
+			eisa_set_level_irq(irq);
+		}
+	  =20
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d Mode %d Trigger %d\n",
+			entry->id.segment, entry->id.bus,=20
+			entry->id.device, ('A' + entry->pin),=20
+			entry->irq, edge_level, active_high_low);
+	}
+=09
+	/* if we get here, the PRT was fine. commit it */
+	acpi_pci_commit_prt_list(prt_list);
+  =20
+	return 0;
+}
+
+#endif /*CONFIG_ACPI_PCI*/
diff -Nur linux-2.4.23-pre6.orig/arch/x86_64/kernel/Makefile linux-2.4.23-p=
re6/arch/x86_64/kernel/Makefile
--- linux-2.4.23-pre6.orig/arch/x86_64/kernel/Makefile	Mon Aug 25 12:44:40 =
2003
+++ linux-2.4.23-pre6/arch/x86_64/kernel/Makefile	Wed Oct  8 03:56:42 2003
@@ -37,7 +37,7 @@
 obj-$(CONFIG_GART_IOMMU) +=3D pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU) +=3D pci-nommu.o
 obj-$(CONFIG_MCE) +=3D bluesmoke.o
-obj-$(CONFIG_ACPI)		+=3D acpi.o
+obj-$(CONFIG_ACPI)		+=3D acpi.o pic.o
 obj-$(CONFIG_ACPI_SLEEP)	+=3D acpi_wakeup.o suspend.o
 =20
=20
diff -Nur linux-2.4.23-pre6.orig/arch/x86_64/kernel/mpparse.c linux-2.4.23-=
pre6/arch/x86_64/kernel/mpparse.c
--- linux-2.4.23-pre6.orig/arch/x86_64/kernel/mpparse.c	Wed Oct  8 00:51:23=
 2003
+++ linux-2.4.23-pre6/arch/x86_64/kernel/mpparse.c	Wed Oct  8 03:56:42 2003
@@ -955,6 +955,7 @@
 {
 	struct list_head	*node =3D NULL;
 	struct acpi_prt_entry	*entry =3D NULL;
+	struct acpi_prt_list    *prt_list =3D NULL;  =20
 	int			vector =3D 0;
 	int			ioapic =3D -1;
 	int			ioapic_pin =3D 0;
@@ -963,16 +964,29 @@
 	int			edge_level =3D 0;
 	int			active_high_low =3D 0;
=20
+	/* Get the current PRT */
+	prt_list =3D acpi_pci_get_prt_list();
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING "ACPI tables contain no IO-APIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+  =20
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
 	 * routing for all static (IOAPIC-direct) entries.
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &prt_list->entries)=20
 		entry =3D list_entry(node, struct acpi_prt_entry, node);
=20
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
 			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &e=
dge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
 			if (!irq)
 				continue;
 		} else {
@@ -1026,8 +1040,11 @@
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, vector,=20
 			entry->irq);
 	}
-=09
-	return;
+  =20
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
+  =20
+	return 0;
 }
=20
 #endif /*CONFIG_ACPI_PCI*/
diff -Nur linux-2.4.23-pre6.orig/arch/x86_64/kernel/pic.c linux-2.4.23-pre6=
/arch/x86_64/kernel/pic.c
--- linux-2.4.23-pre6.orig/arch/x86_64/kernel/pic.c	Thu Jan  1 00:00:00 197=
0
+++ linux-2.4.23-pre6/arch/x86_64/kernel/pic.c	Wed Oct  8 03:56:42 2003
@@ -0,0 +1,102 @@
+/* -----------------------------------------------------------------------=
 *
+ *  =20
+ *   Copyright 2003 Andrew de Quincey - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * -----------------------------------------------------------------------=
 */
+
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI_PCI
+
+extern void eisa_set_level_irq(unsigned int irq);
+
+int __init pic_parse_prt (void)
+{
+	struct list_head	*node =3D NULL;
+	struct acpi_prt_entry	*entry =3D NULL;
+	struct acpi_prt_list	*prt_list =3D NULL;
+	int			edge_level =3D 0;
+	int			active_high_low =3D 0;
+	int			irq =3D 0;
+	int			programmed[16];
+
+	/* Get the current PRT */
+	prt_list =3D acpi_pci_get_prt_list();
+  =20
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING "ACPI tables contain no PIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+
+	/* mark all IRQs as unprogrammed */
+	memset(programmed, 0, sizeof(programmed));
+  =20
+	/*
+	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
+	 * IRQs if necessary.
+	 */
+	list_for_each(node, &prt_list->entries) {
+		entry =3D list_entry(node, struct acpi_prt_entry, node);
+
+		/* Need to get irq for dynamic entry */
+		if (entry->link.handle) {
+			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &e=
dge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+ 			if (!irq)=20
+				continue;
+		}
+	  =20
+		/* sanity check + update entry */
+		if ((irq < 0) || (irq > 15)) {
+			printk(KERN_ERR "Invalid IRQ (%i) passed to PIC programming code\n", ir=
q);
+			entry->irq =3D 0;
+			continue;
+		}
+		entry->irq =3D irq;
+
+		/* check if it has already been dealt with */
+		if (programmed[irq]) {
+			printk(KERN_DEBUG "PIC: IRQ (%i) already programmed\n", irq);
+			continue;
+		}
+		programmed[irq] =3D 1;
+
+		/* program it */
+		if (edge_level) {
+			eisa_set_level_irq(irq);
+		}
+	  =20
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d Mode %d Trigger %d\n",
+			entry->id.segment, entry->id.bus,=20
+			entry->id.device, ('A' + entry->pin),=20
+			entry->irq, edge_level, active_high_low);
+	}
+=09
+	/* if we get here, the PRT was fine. commit it */
+	acpi_pci_commit_prt_list(prt_list);
+  =20
+	return 0;
+}
+
+#endif /*CONFIG_ACPI_PCI*/
diff -Nur linux-2.4.23-pre6.orig/drivers/acpi/bus.c linux-2.4.23-pre6/drive=
rs/acpi/bus.c
--- linux-2.4.23-pre6.orig/drivers/acpi/bus.c	Wed Oct  8 00:51:23 2003
+++ linux-2.4.23-pre6/drivers/acpi/bus.c	Wed Oct  8 03:56:42 2003
@@ -1802,7 +1802,7 @@
                              Initialization/Cleanup
    -----------------------------------------------------------------------=
--- */
=20
-static int __init
+int
 acpi_bus_init_irq (void)
 {
 	acpi_status		status =3D AE_OK;
diff -Nur linux-2.4.23-pre6.orig/drivers/acpi/pci_irq.c linux-2.4.23-pre6/d=
rivers/acpi/pci_irq.c
--- linux-2.4.23-pre6.orig/drivers/acpi/pci_irq.c	Wed Oct  8 00:51:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/pci_irq.c	Wed Oct  8 03:56:42 2003
@@ -50,7 +50,22 @@
=20
 #define PREFIX			"PCI: "
=20
-struct acpi_prt_list		acpi_prt;
+struct acpi_prt_list*		acpi_prt =3D NULL;
+
+struct acpi_prt_ref {
+	struct list_head	node;
+	struct acpi_device	*device;
+	acpi_handle		handle;
+	int segment;
+	int bus;
+};
+
+struct acpi_prt_ref_list {
+	int			count;
+	struct list_head	entries;
+};			=09
+
+struct acpi_prt_ref_list acpi_prt_ref_list;
=20
 #ifdef CONFIG_X86
 extern void eisa_set_level_irq(unsigned int irq);
@@ -73,16 +88,22 @@
=20
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
=20
-	if (!acpi_prt.count)
+	if (!acpi_prt->count)
 		return_PTR(NULL);
=20
+	/* ensure we're not called before the routing table has been determined *=
/
+	if (acpi_prt =3D=3D NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Called before acpi_prt determined"));
+		return_PTR(NULL);
+ 	}
+  =20
 	/*
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
 	 *
 	 * TBD: Acquire/release lock
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &acpi_prt->entries) {
 		entry =3D list_entry(node, struct acpi_prt_entry, node);
 		if ((segment =3D=3D entry->id.segment)=20
 			&& (bus =3D=3D entry->id.bus)=20
@@ -98,6 +119,7 @@
=20
 static int
 acpi_pci_irq_add_entry (
+	struct acpi_prt_list*		prt_list,
 	acpi_handle			handle,
 	int				segment,
 	int				bus,
@@ -154,12 +176,115 @@
 		('A' + entry->pin), prt->source, entry->link.index));
=20
 	/* TBD: Acquire/release lock */
-	list_add_tail(&entry->node, &acpi_prt.entries);
-	acpi_prt.count++;
+	list_add_tail(&entry->node, &prt_list->entries);
+	prt_list->count++;
=20
 	return_VALUE(0);
 }
=20
+struct acpi_prt_list*
+acpi_pci_get_prt_list (void)
+{
+	acpi_status			status =3D AE_OK;
+	struct acpi_buffer		buffer =3D {0, NULL};
+	struct acpi_pci_routing_table	*prt =3D NULL;
+	struct acpi_pci_routing_table	*entry =3D NULL;
+	struct acpi_prt_list		*prt_list =3D NULL;
+	struct acpi_prt_ref		*prt_ref_entry =3D NULL;
+	struct list_head		*node =3D NULL;
+  =20
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_get_prt_list");
+  =20
+	/* Create a brand new acpi_prt_list */
+	prt_list =3D kmalloc(sizeof(struct acpi_prt_list), GFP_KERNEL);
+	if (!prt_list)
+		return_PTR(NULL);
+	memset(prt_list, 0, sizeof(struct acpi_prt_list));
+  =20
+	prt_list->count =3D 0;
+	INIT_LIST_HEAD(&prt_list->entries);
+  =20
+	/* iterate over all entries in acpi_prt_ref_list, extracting the current =
_PRT entries */
+	list_for_each(node, &acpi_prt_ref_list.entries) {
+		prt_ref_entry =3D list_entry(node, struct acpi_prt_ref, node);
+  =20
+		/*=20
+		 * Evaluate this _PRT and add its entries to our local list (prt_list).
+		 */
+
+		buffer.length =3D 0;
+		buffer.pointer =3D NULL;
+		status =3D acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (status !=3D AE_BUFFER_OVERFLOW) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		prt =3D kmalloc(buffer.length, GFP_KERNEL);
+		if (!prt) {
+			kfree(prt_list);
+			return_VALUE(NULL);
+		}
+		memset(prt, 0, buffer.length);
+		buffer.pointer =3D prt;
+
+		status =3D acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(buffer.pointer);
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		entry =3D prt;
+
+		while (entry && (entry->length > 0)) {
+			acpi_pci_irq_add_entry(prt_list, prt_ref_entry->handle, prt_ref_entry->=
segment,=20
+				prt_ref_entry->bus, entry);
+			entry =3D (struct acpi_pci_routing_table *)
+				((unsigned long) entry + entry->length);
+		}
+
+		kfree(prt);
+	}
+
+	return_PTR(prt_list);
+}
+
+int=20
+acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list) {
+	struct list_head	*node =3D NULL;
+	struct list_head	*tmp =3D NULL;
+	struct acpi_prt_entry	*entry =3D NULL;
+  =20
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_destroy_prt_list");
+
+	list_for_each_safe(node, tmp, &prt_list->entries) {
+		entry =3D list_entry(node, struct acpi_prt_entry, node);
+		list_del(node);
+		kfree(entry);
+	}
+	kfree(prt_list);
+  =20
+	return_VALUE(0);
+}	 =20
+ =20
+int
+acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list) {
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_commit_prt_list");
+  =20
+	if (acpi_prt !=3D NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Attempt to commit acpi_prt twice\n"));
+		return_VALUE(-ENODEV);
+	}
+
+	acpi_prt =3D prt_list;
+	return_VALUE(0);
+}
=20
 int
 acpi_pci_irq_add_prt (
@@ -167,21 +292,20 @@
 	int			segment,
 	int			bus)
 {
-	acpi_status			status =3D AE_OK;
-	char				pathname[ACPI_PATHNAME_MAX] =3D {0};
-	struct acpi_buffer		buffer =3D {0, NULL};
-	struct acpi_pci_routing_table	*prt =3D NULL;
-	struct acpi_pci_routing_table	*entry =3D NULL;
-	static int			first_time =3D 1;
+	static int		first_time =3D 1;
+	struct acpi_prt_ref	*entry =3D NULL;
+	struct acpi_buffer	buffer =3D {0, NULL};
+	char			pathname[ACPI_PATHNAME_MAX] =3D {0};
=20
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
=20
 	if (first_time) {
-		acpi_prt.count =3D 0;
-		INIT_LIST_HEAD(&acpi_prt.entries);
+		acpi_prt_ref_list.count =3D 0;
+		INIT_LIST_HEAD(&acpi_prt_ref_list.entries);
 		first_time =3D 0;
 	}
=20
+  =20
 	/*=20
 	 * NOTE: We're given a 'handle' to the _PRT object's parent device
 	 *       (either a PCI root bridge or PCI-PCI bridge).
@@ -194,42 +318,19 @@
 	printk(KERN_DEBUG "ACPI: PCI Interrupt Routing Table [%s._PRT]\n",
 		pathname);
=20
-	/*=20
-	 * Evaluate this _PRT and add its entries to our global list (acpi_prt).
-	 */
-
-	buffer.length =3D 0;
-	buffer.pointer =3D NULL;
-	status =3D acpi_get_irq_routing_table(handle, &buffer);
-	if (status !=3D AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		return_VALUE(-ENODEV);
-	}
-
-	prt =3D kmalloc(buffer.length, GFP_KERNEL);
-	if (!prt)
+  =20
+  =20
+	entry =3D kmalloc(sizeof(struct acpi_prt_ref), GFP_KERNEL);
+	if (!entry)
 		return_VALUE(-ENOMEM);
-	memset(prt, 0, buffer.length);
-	buffer.pointer =3D prt;
-
-	status =3D acpi_get_irq_routing_table(handle, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		kfree(buffer.pointer);
-		return_VALUE(-ENODEV);
-	}
+	memset(entry, 0, sizeof(struct acpi_prt_ref));
+  =20
+	entry->handle =3D handle;
+	entry->segment =3D segment;
+	entry->bus =3D bus;
=20
-	entry =3D prt;
-
-	while (entry && (entry->length > 0)) {
-		acpi_pci_irq_add_entry(handle, segment, bus, entry);
-		entry =3D (struct acpi_pci_routing_table *)
-			((unsigned long) entry + entry->length);
-	}
-
-	kfree(prt);
+	list_add_tail(&entry->node, &acpi_prt_ref_list.entries);
+	acpi_prt_ref_list.count++;
=20
 	return_VALUE(0);
 }
@@ -390,6 +491,15 @@
 }
=20
=20
+static void __init acpi_irq_pic_mode(void)
+{
+	acpi_irq_model =3D ACPI_IRQ_MODEL_PIC;
+	acpi_bus_init_irq();
+  =20
+        /* recalculate penalties */
+ 	acpi_pci_link_calc_penalties();
+}
+
 int __init
 acpi_pci_irq_init (void)
 {
@@ -397,26 +507,25 @@
=20
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_init");
=20
-	if (!acpi_prt.count) {
-		printk(KERN_WARNING PREFIX "ACPI tables contain no PCI IRQ "
-			"routing entries\n");
-		return_VALUE(-ENODEV);
-	}
-
-	/* Make sure all link devices have a valid IRQ. */
-	if (acpi_pci_link_check()) {
-		return_VALUE(-ENODEV);
-	}
+ 	/* Calculate IRQ penalties for each link device */
+ 	acpi_pci_link_calc_penalties();
=20
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOAPIC)
-		mp_parse_prt();
+ 		if (mp_parse_prt())=20
+ 			acpi_irq_pic_mode();
 #endif
 #ifdef CONFIG_IOSAPIC
 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_parse_prt();
+ 		if (iosapic_parse_prt())
+       			return_VALUE(-ENODEV);
 #endif
+  =20
+ 	/* This one is last, as a catchall */
+ 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_PIC)
+ 		if (pic_parse_prt())=20
+ 			return_VALUE(-ENODEV);
=20
 	pci_for_each_dev(dev)
 		acpi_pci_irq_enable(dev);
diff -Nur linux-2.4.23-pre6.orig/drivers/acpi/pci_link.c linux-2.4.23-pre6/=
drivers/acpi/pci_link.c
--- linux-2.4.23-pre6.orig/drivers/acpi/pci_link.c	Wed Oct  8 00:51:24 2003
+++ linux-2.4.23-pre6/drivers/acpi/pci_link.c	Wed Oct  8 03:56:42 2003
@@ -444,22 +444,25 @@
  * as 'best bets' for PCI use.
  */
=20
-static int acpi_irq_penalty[ACPI_MAX_IRQS] =3D {
+static int acpi_irq_default_penalty[ACPI_MAX_IRQS] =3D {
 	1000000,  1000000,  1000000,    10000,=20
 	  10000,        0,    10000,    10000,
 	  10000,        0,        0,        0,=20
 	  10000,   100000,   100000,   100000,
 };
=20
+static int acpi_irq_penalty[ACPI_MAX_IRQS] =3D { 0 };
=20
 int
-acpi_pci_link_check (void)
+acpi_pci_link_calc_penalties (void)
 {
 	struct list_head	*node =3D NULL;
 	struct acpi_pci_link    *link =3D NULL;
 	int			i =3D 0;
=20
-	ACPI_FUNCTION_TRACE("acpi_pci_link_check");
+	ACPI_FUNCTION_TRACE("acpi_pci_calc_penalties");
+
+	memcpy(&acpi_irq_penalty, &acpi_irq_default_penalty, sizeof(acpi_irq_defa=
ult_penalty));
=20
 	/*
 	 * Update penalties to facilitate IRQ balancing.
@@ -471,6 +474,7 @@
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
 			continue;
 		}
+		link->irq.setonboot =3D 0;
=20
 		if (link->irq.active)
 			acpi_irq_penalty[link->irq.active] +=3D 100;
@@ -512,7 +516,7 @@
=20
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {
-		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). A=
borting ACPI-based IRQ routing. Try pci=3Dnoacpi or acpi=3Doff\n",
+		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS, pl=
ease report to acpi-devel!)\n",
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device));
 		return_VALUE(-ENODEV);
diff -Nur linux-2.4.23-pre6.orig/include/acpi/acpi_bus.h linux-2.4.23-pre6/=
include/acpi/acpi_bus.h
--- linux-2.4.23-pre6.orig/include/acpi/acpi_bus.h	Mon Aug 25 12:44:43 2003
+++ linux-2.4.23-pre6/include/acpi/acpi_bus.h	Wed Oct  8 03:56:42 2003
@@ -309,6 +309,7 @@
 int acpi_init (void);
 void acpi_exit (void);
=20
+int acpi_bus_init_irq (void);
=20
 #endif /*CONFIG_ACPI_BUS*/
=20
diff -Nur linux-2.4.23-pre6.orig/include/acpi/acpi_drivers.h linux-2.4.23-p=
re6/include/acpi/acpi_drivers.h
--- linux-2.4.23-pre6.orig/include/acpi/acpi_drivers.h	Mon Aug 25 12:44:43 =
2003
+++ linux-2.4.23-pre6/include/acpi/acpi_drivers.h	Wed Oct  8 03:56:42 2003
@@ -26,6 +26,9 @@
 #ifndef __ACPI_DRIVERS_H__
 #define __ACPI_DRIVERS_H__
=20
+/* forward definitions */
+struct acpi_prt_list;
+
 #include <linux/acpi.h>
 #include "acpi_bus.h"
=20
@@ -173,7 +176,7 @@
 #define ACPI_PCI_LINK_FILE_INFO		"info"
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
=20
-int acpi_pci_link_check (void);
+int acpi_pci_link_calc_penalties (void);
 int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level,=
 int* active_high_low);
 int acpi_pci_link_init (void);
 void acpi_pci_link_exit (void);
@@ -181,6 +184,9 @@
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
=20
 int acpi_pci_irq_add_prt (acpi_handle handle, int segment, int bus);
+int acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list);
+int acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list);
+struct acpi_prt_list* acpi_pci_get_prt_list (void);
=20
 /* ACPI PCI Device Binding (pci_bind.c) */
=20
diff -Nur linux-2.4.23-pre6.orig/include/asm-i386/acpi.h linux-2.4.23-pre6/=
include/asm-i386/acpi.h
--- linux-2.4.23-pre6.orig/include/asm-i386/acpi.h	Wed Oct  8 00:51:35 2003
+++ linux-2.4.23-pre6/include/asm-i386/acpi.h	Wed Oct  8 03:56:42 2003
@@ -173,6 +173,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
=20
+/* ACPI-based PIC initialisation */
+extern int pic_parse_prt (void);
+
 #endif /*CONFIG_ACPI_SLEEP*/
=20
=20
diff -Nur linux-2.4.23-pre6.orig/include/asm-i386/mpspec.h linux-2.4.23-pre=
6/include/asm-i386/mpspec.h
--- linux-2.4.23-pre6.orig/include/asm-i386/mpspec.h	Mon Aug 25 12:44:43 20=
03
+++ linux-2.4.23-pre6/include/asm-i386/mpspec.h	Wed Oct  8 03:56:42 2003
@@ -228,7 +228,7 @@
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u=
32 global_irq);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_config_ioapic_for_sci(int irq);
-extern void mp_parse_prt (void);
+extern int mp_parse_prt (void);
 #else /*!CONFIG_X86_IO_APIC*/
 static inline void mp_config_ioapic_for_sci(int irq) { }
 #endif /*!CONFIG_X86_IO_APIC*/
diff -Nur linux-2.4.23-pre6.orig/include/asm-ia64/acpi.h linux-2.4.23-pre6/=
include/asm-ia64/acpi.h
--- linux-2.4.23-pre6.orig/include/asm-ia64/acpi.h	Wed Oct  8 00:51:35 2003
+++ linux-2.4.23-pre6/include/asm-ia64/acpi.h	Wed Oct  8 03:56:42 2003
@@ -110,6 +110,9 @@
 extern int __initdata nid_to_pxm_map[NR_NODES];
 #endif
=20
+/* ia64 machines don't have PIC controllers */
+static inline int pic_parse_prt(void) { return -1; }
+
 #endif /*__KERNEL__*/
=20
 #endif /*_ASM_ACPI_H*/
diff -Nur linux-2.4.23-pre6.orig/include/asm-x86_64/acpi.h linux-2.4.23-pre=
6/include/asm-x86_64/acpi.h
--- linux-2.4.23-pre6.orig/include/asm-x86_64/acpi.h	Wed Oct  8 00:51:39 20=
03
+++ linux-2.4.23-pre6/include/asm-x86_64/acpi.h	Wed Oct  8 03:56:42 2003
@@ -159,6 +159,9 @@
=20
 extern int use_acpi_pci;
=20
+/* ACPI-based PIC initialisation */
+extern int pic_parse_prt (void);
+
 #endif /*__KERNEL__*/
=20
 #endif /*_ASM_ACPI_H*/
diff -Nur linux-2.4.23-pre6.orig/include/linux/acpi.h linux-2.4.23-pre6/inc=
lude/linux/acpi.h
--- linux-2.4.23-pre6.orig/include/linux/acpi.h	Wed Oct  8 00:51:39 2003
+++ linux-2.4.23-pre6/include/linux/acpi.h	Wed Oct  8 03:56:42 2003
@@ -395,7 +395,7 @@
 	struct list_head	entries;
 };
=20
-extern struct acpi_prt_list	acpi_prt;
+extern struct acpi_prt_list*	acpi_prt;
=20
 struct pci_dev;
=20

--=-nYVw1rNm1anujn4N5UhV--



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
