From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: have I correct my irq routing ?
Date: 08 Oct 2002 02:52:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034059951.1479.19.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xxIz1GwvgLyj6tjUbHL5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-xxIz1GwvgLyj6tjUbHL5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi(gh)!

I don't know how to explain this , but the fact is that put my computer
works with xine in xv video mode with tv-out in pal mode for dvd like
gladiator or starwars and a great sound.

so I can making a big confusion ( this is not my area ) and I don't know
how prove my theory.
I have 3 kernels installed in my computer 2.14.19, redhat 2.4.18-10 and
2.4.20-pre8 so by lucky i had turn off this part of the code and realize
that my computer works better.
so I tested comment pci_bios_irq_init() and pcibios_fixup_peer_bridges
after just pci_bios_irq_init
=20
        if (!pci_using_acpi_prt) {
                pci_root_bus =3D pcibios_scan_root(0);
-               pcibios_irq_init();
+/*             pcibios_irq_init(); */
                pcibios_fixup_peer_bridges();
                pcibios_fixup_irqs();
        }


and xine never stops again say that have gaps in timer.
so perhaps when arrive here irq is already init, and init again give two
parallels irq tables !

thanks
S=E9rgio Basto


--=-xxIz1GwvgLyj6tjUbHL5
Content-Disposition: attachment; filename=test12
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=test12; charset=ISO-8859-1

--- linux-2.4.19orig/arch/i386/kernel/pci-pc.c	Sun Oct  6 21:39:55 2002
+++ linux-2.4.19acpi/arch/i386/kernel/pci-pc.c	Tue Oct  8 02:22:52 2002
@@ -1351,7 +1351,7 @@
 #endif
 	if (!pci_using_acpi_prt) {
 		pci_root_bus =3D pcibios_scan_root(0);
-		pcibios_irq_init();
+/* 		pcibios_irq_init(); */
 		pcibios_fixup_peer_bridges();
 		pcibios_fixup_irqs();
 	}

--=-xxIz1GwvgLyj6tjUbHL5--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
