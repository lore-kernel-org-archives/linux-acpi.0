From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: ACPI hangs at boot sometimes
Date: Fri, 14 May 2004 08:51:55 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405140852.02383.meaton@vasco.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When booting my system it sometime hangs right after giving me the message=
=20
Edge set to Level Trigger. but most times it works fine. Is this a known=20
bug ? possibly a buggy ACPI implementation ?
I have included the ACPI portion of a successful boot below. If you want/ne=
ed=20
more information just ask.

May 12 08:33:14 beldin kernel: ACPI: Subsystem revision 20040326
May 12 08:33:14 beldin kernel: spurious 8259A interrupt: IRQ7.
May 12 08:33:14 beldin kernel: ACPI: IRQ10 SCI: Edge set to Level Trigger.
May 12 08:33:14 beldin kernel: ACPI: Interpreter enabled
May 12 08:33:14 beldin kernel: ACPI: Using PIC for interrupt routing       =
    =20
May 12 08:33:14 beldin kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May 12 08:33:14 beldin kernel: PCI: Probing PCI hardware (bus 00)
May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Routing Table=20
[\_SB_.PCI0._PRT]
May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
May 12 08:33:14 beldin kernel: ACPI: Embedded Controller [EC0] (gpe 1)

=2D --=20
Mark Eaton
Senior Software Engineer
VASCO The Authentication Company
+67 3511 5404
+67 (0) 403 384 886
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo/wOKd93Pkvz/M4RAgy3AKCH0t5mQ7A5Pq31pxrsJdr5/3WHJACfWPvq
mtwiv54W64z0iZ3dNG1V3xw=3D
=3DpdRF
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
