From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante-UIqTAjE4tzc5WgrkcBd8vg@public.gmane.org>
Subject: [PATCH] fix for 2.4.21-pre2 and acpi-20021212
Date: Fri, 3 Jan 2003 20:48:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301032048.53199.joergprante@netcologne.de>
Reply-To: joergprante-UIqTAjE4tzc5WgrkcBd8vg@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_HPL56SOCMGWPFZURLWW0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Margit Schubert-While <margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_HPL56SOCMGWPFZURLWW0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

this patch is needed for acpi-20021212 with 2.4.21-pre2 on a Pentium 4 wi=
th=20
ACPI IO-APIC. The dynamic MP busses and IRQ_SOURCES in 2.4.21-pre2 introd=
uced=20
a conflict that will rise NULL pointer dereferences when combined with th=
e=20
ACPI patch. I don't have the hardware to test it, but Margit Schubert-Whi=
le=20
reported a successful boot.

http://infolinux.de/jp/087_acpi-mpparse-fix

Cheers,=20

J=F6rg

--------------Boundary-00=_HPL56SOCMGWPFZURLWW0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="087_acpi-mpparse-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="087_acpi-mpparse-fix"

--- linux-2.4.21-pre2-jp15/arch/i386/kernel/mpparse.c.orig	2003-01-02 21:13:16.000000000 +0100
+++ linux-2.4.21-pre2-jp15/arch/i386/kernel/mpparse.c	2003-01-03 18:14:10.000000000 +0100
@@ -1132,10 +1132,28 @@
 
 void __init mp_config_acpi_legacy_irqs (void)
 {
-	struct mpc_config_intsrc intsrc;
 	int			i = 0;
 	int			ioapic = -1;
 
+	/*
+	 * Initialize mp_irqs for IRQ configuration.
+	 */
+	unsigned char *bus_data;
+	int count;
+
+	count = (MAX_MP_BUSSES * sizeof(int)) * 4;
+	count += (MAX_IRQ_SOURCES * sizeof(int)) * 4;
+	bus_data = alloc_bootmem(count);
+	if (!bus_data) {
+		panic("Fatal: can't allocate bus memory for ACPI legacy IRQ!");
+	}
+	mp_bus_id_to_type = (int *)&bus_data[0];
+	mp_bus_id_to_node = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int))];
+	mp_bus_id_to_local = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 2];
+	mp_bus_id_to_pci_bus = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 3];
+	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 4];
+	memset(mp_bus_id_to_pci_bus, -1, MAX_MP_BUSSES);
+
 	/* 
 	 * Fabricate the legacy ISA bus (bus #31).
 	 */
@@ -1149,11 +1167,6 @@
 	if (ioapic < 0)
 		return;
 
-	intsrc.mpc_type = MP_INTSRC;
-	intsrc.mpc_irqflag = 0;					/* Conforming */
-	intsrc.mpc_srcbus = MP_ISA_BUS;
-	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;
-
 	/* 
 	 * Use the default configuration for the IRQs 0-15.  These may be
 	 * overriden by (MADT) interrupt source override entries.
@@ -1162,17 +1175,24 @@
 
 		if (i == 2) continue;			/* Don't connect IRQ2 */
 
-		intsrc.mpc_irqtype = i ? mp_INT : mp_ExtINT;   /* 8259A to #0 */
-		intsrc.mpc_srcbusirq = i;		   /* Identity mapped */
-		intsrc.mpc_dstirq = i;
+		mp_irqs[mp_irq_entries].mpc_type = MP_INTSRC;
+		mp_irqs[mp_irq_entries].mpc_irqflag = 0;	/* Conforming */
+		mp_irqs[mp_irq_entries].mpc_srcbus = MP_ISA_BUS;
+		mp_irqs[mp_irq_entries].mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;
+		mp_irqs[mp_irq_entries].mpc_irqtype = i ? mp_INT : mp_ExtINT;   /* 8259A to #0 */
+		mp_irqs[mp_irq_entries].mpc_srcbusirq = i;	   /* Identity mapped */
+		mp_irqs[mp_irq_entries].mpc_dstirq = i;
 
 		Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
-			"%d-%d\n", intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
-			(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
-			intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, 
-			intsrc.mpc_dstirq);
+			"%d-%d\n", 
+			mp_irqs[mp_irq_entries].mpc_irqtype, 
+			mp_irqs[mp_irq_entries].mpc_irqflag & 3, 
+			(mp_irqs[mp_irq_entries].mpc_irqflag >> 2) & 3, 
+			mp_irqs[mp_irq_entries].mpc_srcbus, 
+			mp_irqs[mp_irq_entries].mpc_srcbusirq, 
+			mp_irqs[mp_irq_entries].mpc_dstapic, 
+			mp_irqs[mp_irq_entries].mpc_dstirq);
 
-		mp_irqs[mp_irq_entries] = intsrc;
 		if (++mp_irq_entries == MAX_IRQ_SOURCES)
 			panic("Max # of irq sources exceeded!\n");
 	}

--------------Boundary-00=_HPL56SOCMGWPFZURLWW0--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
