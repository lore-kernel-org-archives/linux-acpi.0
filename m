From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [Patch] ACPI IO-APIC IRQ parameter configuration#1
Date: 14 Jul 2003 00:04:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058137496.4509.9.camel@darkstar.portugal>
References: <200307132239.06760.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vu5Gd4DXxf/Hc/xqz/8T"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307132239.06760.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-vu5Gd4DXxf/Hc/xqz/8T
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi
In attachment  this patch for kernel 2.4.21,=20
I don't have acknowledgments to know if it is good code, but can be
applied to kernel 2.4.x

On Sun, 2003-07-13 at 22:39, Andrew de Quincey wrote:
> Hi, the attached experimental patch adds IO-APIC IRQ parameter configurat=
ion.=20
> The patch is against 2.5.74, but also works against 2.5.75
>=20
> Jurriaan, I don't know if this will fix your issue, but if you could give=
 it a=20
> go to see, and I'll keep going if not.
> ----
>=20


--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-vu5Gd4DXxf/Hc/xqz/8T
Content-Disposition: attachment; filename=acpi_irq_params1-2.4.21.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=acpi_irq_params1-2.4.21.patch; charset=ISO-8859-1

diff -Nur linux-2.4.21acpi/arch/i386/kernel/io_apic.c linux-2.4.21.new/arch=
/i386/kernel/io_apic.c
--- linux-2.4.21acpi/arch/i386/kernel/io_apic.c	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/arch/i386/kernel/io_apic.c	Sun Jul 13 23:43:34 2003
@@ -1778,7 +1778,7 @@
 }
=20
=20
-int io_apic_set_pci_routing (int ioapic, int pin, int irq)
+int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level,=
 int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -1801,18 +1801,22 @@
 	entry.dest_mode =3D INT_DELIVERY_MODE;
 	entry.dest.logical.logical_dest =3D target_cpus();
 	entry.mask =3D 1;					 /* Disabled (masked) */
-	entry.trigger =3D 1;				   /* Level sensitive */
-	entry.polarity =3D 1;					/* Low active */
+	entry.trigger =3D edge_level;
+	entry.polarity =3D active_high_low;
=20
 	add_pin_to_irq(irq, ioapic, pin);
=20
 	entry.vector =3D assign_irq_vector(irq);
=20
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic,=20
-		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
+		"IRQ %d Mode:%i Active:%i)\n", ioapic,=20
+		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, activ=
e_high_low);
=20
+        if (edge_level) {
 	irq_desc[irq].handler =3D &ioapic_level_irq_type;
+	} else {
+	        irq_desc[irq].handler =3D &ioapic_edge_irq_type;
+	}
=20
 	set_intr_gate(entry.vector, interrupt[irq]);
=20
diff -Nur linux-2.4.21acpi/arch/i386/kernel/mpparse.c linux-2.4.21.new/arch=
/i386/kernel/mpparse.c
--- linux-2.4.21acpi/arch/i386/kernel/mpparse.c	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/arch/i386/kernel/mpparse.c	Sun Jul 13 23:43:34 2003
@@ -1249,7 +1249,7 @@
=20
 	ioapic_pin =3D irq - mp_ioapic_routing[ioapic].irq_start;
=20
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, le=
vel triggered
 }
=20
 #ifdef CONFIG_ACPI_PCI
@@ -1262,6 +1262,8 @@
 	int			ioapic_pin =3D 0;
 	int			irq =3D 0;
 	int			idx, bit =3D 0;
+        int                     edge_level =3D 0;
+        int                     active_high_low =3D 0;
=20
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
@@ -1272,7 +1274,7 @@
=20
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &e=
dge_level, &active_high_low);
 			if (!irq)
 				continue;
 		}
@@ -1310,7 +1312,7 @@
=20
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |=3D (1<<bit);
=20
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active=
_high_low))
 			entry->irq =3D irq;
=20
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
diff -Nur linux-2.4.21acpi/drivers/acpi/pci_irq.c linux-2.4.21.new/drivers/=
acpi/pci_irq.c
--- linux-2.4.21acpi/drivers/acpi/pci_irq.c	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/drivers/acpi/pci_irq.c	Sun Jul 13 23:43:34 2003
@@ -253,7 +253,7 @@
 	}
=20
 	if (!entry->irq && entry->link.handle) {
-		entry->irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.ind=
ex);
+		entry->irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.ind=
ex, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
diff -Nur linux-2.4.21acpi/drivers/acpi/pci_link.c linux-2.4.21.new/drivers=
/acpi/pci_link.c
--- linux-2.4.21acpi/drivers/acpi/pci_link.c	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/drivers/acpi/pci_link.c	Sun Jul 13 23:43:34 2003
@@ -65,6 +65,8 @@
=20
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+   	u8			edge_level;		/* All IRQs */
+   	u8			active_high_low;	/* All IRQs */
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -114,6 +116,8 @@
 			link->irq.possible[i] =3D p->interrupts[i];
 			link->irq.possible_count++;
 		}
+	        link->irq.edge_level =3D p->edge_level;
+   	        link->irq.active_high_low =3D p->active_high_low;
 		break;
 	}
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -132,6 +136,8 @@
 			link->irq.possible[i] =3D p->interrupts[i];
 			link->irq.possible_count++;
 		}
+	        link->irq.edge_level =3D p->edge_level;
+   	        link->irq.active_high_low =3D p->active_high_low;
 		break;
 	}
 	default:
@@ -468,7 +474,9 @@
 int
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
-	int			index)
+	int			index,
+	int*                    edge_level,
+       	int*                    active_high_low)
 {
 	int                     result =3D 0;
 	struct acpi_device	*device =3D NULL;
@@ -499,6 +507,8 @@
 		return_VALUE(0);
 	}
=20
+        if (edge_level) *edge_level =3D link->irq.edge_level;
+        if (active_high_low) *active_high_low =3D link->irq.active_high_lo=
w;
 	return_VALUE(link->irq.active);
 }
=20
diff -Nur linux-2.4.21acpi/include/acpi/acpi_drivers.h linux-2.4.21.new/inc=
lude/acpi/acpi_drivers.h
--- linux-2.4.21acpi/include/acpi/acpi_drivers.h	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/include/acpi/acpi_drivers.h	Sun Jul 13 23:44:53 2003
@@ -174,7 +174,8 @@
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
=20
 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level,=
 int* active_high_low);
+
 int acpi_pci_link_init (void);
 void acpi_pci_link_exit (void);
=20
diff -Nur linux-2.4.21acpi/include/asm-i386/io_apic.h linux-2.4.21.new/incl=
ude/asm-i386/io_apic.h
--- linux-2.4.21acpi/include/asm-i386/io_apic.h	Sun Jul 13 23:35:04 2003
+++ linux-2.4.21.new/include/asm-i386/io_apic.h	Sun Jul 13 23:45:23 2003
@@ -148,7 +148,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge=
_level, int active_high_low);
 #endif
=20
 #else  /* !CONFIG_X86_IO_APIC */

--=-vu5Gd4DXxf/Hc/xqz/8T--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
