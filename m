From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: important [PATCH] for kernels 2.4.20-pre5 and 2.4.19
Date: 04 Sep 2002 23:34:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031196882.1388.11.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XKRhEGgThjLhDA8B9M8c"
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
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-XKRhEGgThjLhDA8B9M8c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


if (!acpi_pci_irq_init()) and  if (acpi_pci_irq_init() > 0)

looks the same but it is the inverse,
in patch from acpi-20020611-2.4.18.diff.gz 
we have: acpi_pci_irq_init() > 0 
since then we have: !acpi_pci_irq_init()
so if it is one error this error exist since
acpi-20020709-2.4.18.diff.gz
so Andrew what do you think ?


--=-XKRhEGgThjLhDA8B9M8c
Content-Disposition: attachment; filename=patchacpi_2.4.20-pre5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patchacpi_2.4.20-pre5; charset=ISO-8859-1

--- linux-2.4.20-pre5/arch/i386/kernel/pci-pc.c.orig	Sun Sep  1 20:36:50 20=
02
+++ linux-2.4.20-pre5/arch/i386/kernel/pci-pc.c	Wed Sep  4 22:10:00 2002
@@ -1409,7 +1409,7 @@
=20
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 #ifdef CONFIG_ACPI_PCI
-	if (!acpi_pci_irq_init())
+	if (acpi_pci_irq_init() > 0)
 		pci_using_acpi_prt =3D 1;
 #endif
 	if (!pci_using_acpi_prt) {

--=-XKRhEGgThjLhDA8B9M8c--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
