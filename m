From: Pierre Machard <pmachard-zrkhep3+ec/R7s880joybQ@public.gmane.org>
Subject: Problem with 2.5.72 kernel
Date: Tue, 17 Jun 2003 17:11:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030617151132.GB1075@twinette.migus.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

While booting my new 2.5.72 kernel I noticed the following error :
(I was previously using 2.5.69 and it was ruinning correctly)

Real Time Clock Driver v1.11
irq 9: nobody cared!
Call Trace:
[<c010cbaa>] __report_bad_irq+0x2a/0x90
[<c010cc9c>] note_interrupt+0x6c/0xb0
[<c010cf40>] do_IRQ+0x120/0x130
[<c010b394>] common_interrupt+0x18/0x20
[<c01236c0>] do_softirq+0x40/0xa0
[<c010cf1c>] do_IRQ+0xfc/0x130
[<c010b394>] common_interrupt+0x18/0x20
[<c011bfc0>] schedule+0x0/0x3a0
[<c010b171>] need_resched+0x27/0x32
[<c020bb6e>] acpi_processor_idle+0xd5/0x1c7
[<c020ba99>] acpi_processor_idle+0x0/0x1c7
[<c020ba99>] acpi_processor_idle+0x0/0x1c7
[<c020ba99>] acpi_processor_idle+0x0/0x1c7
[<c01090bf>] cpu_idle+0x2f/0x40
[<c0105000>] rest_init+0x0/0x60
[<c0390732>] start_kernel+0x172/0x1a0
[<c0390480>] unknown_bootoption+0x0/0x100

handlers:
[<c01f17f3>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
		=20

Cheers,
--=20
                                Pierre Machard
<pmachard-BoOA+NLF7L6xbKUeIHjxjQ@public.gmane.org>                                  TuxFamily.org
<pmachard-zrkhep3+ec/R7s880joybQ@public.gmane.org>                                     techmag.info
+33(0)668 178 365                    http://migus.tuxfamily.org/gpg.txt
GPG: 1024D/23706F87 : B906 A53F 84E0 49B6 6CF7 82C2 B3A0 2D66 2370 6F87

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7y+ks6AtZiNwb4cRAhdMAKDBv3lrOKpHTRDgtQILAGacOf0hkACfWkuG
yZ76Ua3sAq9QqISqVhPitvk=
=qQZ0
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
