From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [patch] 2.6.7-rc2-mm1: let SERIAL_8250_ACPI depend on ACPI_PCI
Date: Wed, 2 Jun 2004 10:51:59 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406021051.59314.bjorn.helgaas@hp.com>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602003938.GJ25681@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040602003938.GJ25681-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 01 June 2004 6:39 pm, Adrian Bunk wrote:
> The=A0 PCI IRQ update in the ACPI tree causes the following compile err=
or with CONFIG_PCI=3Dn:
> ...
> drivers/built-in.o(.text+0xfc1c7): In function `acpi_serial_ext_irq':
> : undefined reference to `acpi_register_gsi'
> drivers/built-in.o(.text+0xfc1f6): In function `acpi_serial_irq':
> : undefined reference to `acpi_register_gsi'

As Matthew noted, there's no reason a machine ACPI needs to have
PCI, so I propose the following patch instead.  This just makes
acpi_register_gsi()and acpi_gsi_to_irq() available independent
of CONFIG_PCI.

diff -u -Nur linux-2.6.6/arch/i386/kernel/acpi/boot.c linux-2.6.6-pci-irq=
/arch/i386/kernel/acpi/boot.c
--- linux-2.6.6/arch/i386/kernel/acpi/boot.c	2004-06-02 10:43:15.00000000=
0 -0600
+++ linux-2.6.6-pci-irq/arch/i386/kernel/acpi/boot.c	2004-06-02 10:41:07.=
000000000 -0600
@@ -438,23 +438,25 @@
 	return 0;
 }
=20
-#ifdef CONFIG_ACPI_PCI
 unsigned int acpi_register_gsi(u32 gsi, int edge_level, int active_high_=
low)
 {
-	static u16 irq_mask;
 	unsigned int irq;
-	extern void eisa_set_level_irq(unsigned int irq);
=20
+#ifdef CONFIG_PCI
 	/*
 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
 	 */
 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_PIC) {
+		static u16 irq_mask;
+		extern void eisa_set_level_irq(unsigned int irq);
+
 		if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
 			Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi)=
;
 			irq_mask |=3D (1 << gsi);
 			eisa_set_level_irq(gsi);
 		}
 	}
+#endif
=20
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOAPIC) {
@@ -464,7 +466,6 @@
 	acpi_gsi_to_irq(gsi, &irq);
 	return irq;
 }
-#endif	/* CONFIG_ACPI_PCI */
=20
 static unsigned long __init
 acpi_scan_rsdp (
diff -u -Nur linux-2.6.6/include/linux/acpi.h linux-2.6.6-pci-irq/include=
/linux/acpi.h
--- linux-2.6.6/include/linux/acpi.h	2004-06-02 10:43:15.000000000 -0600
+++ linux-2.6.6-pci-irq/include/linux/acpi.h	2004-06-02 10:33:57.00000000=
0 -0600
@@ -413,6 +413,8 @@
=20
 #endif 	/*!CONFIG_ACPI_BOOT*/
=20
+unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high=
_low);
+int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
=20
 #ifdef CONFIG_ACPI_PCI
=20
@@ -437,8 +439,6 @@
 struct pci_dev;
=20
 int acpi_pci_irq_enable (struct pci_dev *dev);
-unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high=
_low);
-int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
=20
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
