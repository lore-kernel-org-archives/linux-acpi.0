From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: boot option pci=noacpi for kernel 2.4.x
Date: 11 Sep 2002 00:59:45 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031720375.1661.13.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-jn+LZJNt1m1DgAUP/E+h"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-jn+LZJNt1m1DgAUP/E+h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-07-19 at 03:35, Dominik Brodowski wrote:there is a kernel
boot option "pci=3Dnoacpi", which disables ACPI-based IRQ
routing=20

this option exist for kernel 2.5.x I believe, but for kernel 2.4.x don't.

look for this part of the kernel code :
linux-2.4.20-pre5/arch/i386/kernel/pci-pc.c Wed Sep  4 22:10:00 2002
@@ -1409,7 +1409,7 @@
=20
 printk(KERN_INFO "PCI: Probing PCI hardware\n");

 #ifdef CONFIG_ACPI_PCI
       if (!acpi_pci_irq_init())
                pci_using_acpi_prt =3D 1;
 #endif

After testing the kernel with acpi_pci_irq_init()> 0, I realize that pci
irq routing works different, because the function acpi_pci_irq_init
returns 0 and pci_using_acpi_prt is passed with zero (=3D 0) .=20
so I ask for your opinion, if with one boot parameter (for example
acpi=3Dnopci), we don't call acpi_pci_irq_init and assign pci_using_acpi=3D=
0
, kernel will work like having boot option pci=3Dnoacpi?
conclusion it is possible acpi work without calling acpi_pci_irq_init
etc.. ?

This is for trying resolve the problem of the people whose computer
hangs on boot with pci-irq problems.

thanks=20
S=E9rgiomb

PS I send right now the patch for this propose if you think that can be pos=
sible and correct.
I just test in my compaq pressario 706EA Laptop.=20
new boot param :
acpi=3Dnopci.


--=-jn+LZJNt1m1DgAUP/E+h
Content-Disposition: attachment; filename=patchacpiintegration2.4.19_nopci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patchacpiintegration2.4.19_nopci; charset=ISO-8859-1

diff -Nura linux-2.4.19orig/arch/i386/kernel/pci-pc.c linux-2.4.19acpi/arch=
/i386/kernel/pci-pc.c
--- linux-2.4.19orig/arch/i386/kernel/pci-pc.c	Wed Sep 11 00:42:59 2002
+++ linux-2.4.19acpi/arch/i386/kernel/pci-pc.c	Wed Sep 11 00:10:57 2002
@@ -29,6 +29,7 @@
 int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int le=
n, u32 value) =3D NULL;
=20
 static int pci_using_acpi_prt =3D 0;
+extern int enabled_acpi_pci_irq;=20
=20
 #ifdef CONFIG_MULTIQUAD
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])
@@ -1341,8 +1342,10 @@
=20
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 #ifdef CONFIG_ACPI_PCI
-	if (!acpi_pci_irq_init())
-		pci_using_acpi_prt =3D 1;
+	if (enabled_acpi_pci_irq) {
+		if (!acpi_pci_irq_init())
+			pci_using_acpi_prt =3D 1;
+	}
 #endif
 	if (!pci_using_acpi_prt) {
 		pci_root_bus =3D pcibios_scan_root(0);
diff -Nura linux-2.4.19orig/arch/i386/kernel/setup.c linux-2.4.19acpi/arch/=
i386/kernel/setup.c
--- linux-2.4.19orig/arch/i386/kernel/setup.c	Wed Sep 11 00:42:59 2002
+++ linux-2.4.19acpi/arch/i386/kernel/setup.c	Wed Sep 11 00:47:13 2002
@@ -177,6 +177,7 @@
 static int disable_x86_ht __initdata =3D 0;
=20
 int acpi_disabled __initdata =3D 0;
+int enabled_acpi_pci_irq __initdata =3D 1;
=20
 #if defined(CONFIG_AGP) || defined(CONFIG_AGP_MODULE)
 int disable_adv_spec_cache __initdata =3D 1;
@@ -834,6 +835,9 @@
 		/* "acpi=3Doff" disables both ACPI table parsing and interpreter init */
 		else if (!memcmp(from, "acpi=3Doff", 8))
 			acpi_disabled =3D 1;
+		/* "acpi=3Dnopci" doesn't call function acpi_pci_irq_init(); */
+		else if (!memcmp(from, "acpi=3Dnopci", 10))
+			enabled_acpi_pci_irq =3D 0;
=20
 		/*
 		 * highmem=3Dsize forces highmem to be exactly 'size' bytes.

--=-jn+LZJNt1m1DgAUP/E+h--




-------------------------------------------------------
In remembrance
www.osdn.com/911/
