From: Bernd Schubert <bernd-schubert-S0/GAf8tV78@public.gmane.org>
Subject: thinkpad R31 issues
Date: Mon, 5 Apr 2004 03:37:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404050337.18991.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
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
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

with 2.6.5 the S1 state doesn't work anymore on my R31, but until my previo=
us=20
2.6.2-rc2 it worked.
To be more specific, it doesn't wake up properly any more, but stops at=20
writing:

PCI: Setting latency timer of device 0000:00:1f.6 to 64

There's also a slight improvement, when it goes to S1 the the sleep symbol =
now=20
lights up. However, since S1 it totally useless now, this doesn't improve=20
much ;-)

Any ideas what might cause not to wake up from S1 any more?

Also interesting is the boot message:

ACPI: PCI Interrupt Link [PILC] enabled at IRQ 11
 pci_irq-0316 [28] acpi_pci_irq_derive   : Unable to derive IRQ for device=
=20
0000:00:1f.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 2=
55

I think this is there since about 2.6.0 or 2.6.1, but as I said at least un=
til=20
2.6.2-rc2 S1  still worked.

There's also the issue that in S1 the display doesn't go off and there are=
=20
several other problems with S3, but IMHO those are minor to a non working S=
1.=20
Interesting is also that S4 is working *again*, whereas it didn't work in=20
several previous versions (I only tested regularly until 2.6.2-rc2).

Are you interested in full dmesg and lspci output? Are there any debugging=
=20
methods?

Thanks,
	Bernd

PS: I disabled the preemtive mode in the kernel configuration.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcLhLC8BUnAF+ydYRAm5LAKCYi0bY7iDJSUELmP6EsV7G0tiWxQCcDCJB
6TAPlCmLSuOZa04BIJeFUdY=3D
=3DkCZZ
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
