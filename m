From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: vaio 505 (again)
Date: 15 Jul 2003 12:56:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058266578.1077.16.camel@lana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TIFKH5KpJwhUMqD3nKxC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-TIFKH5KpJwhUMqD3nKxC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi,

just for fun i tried kernel 2.5.74 + acpi 20030619 and now everything
works. the problem with the glidepad sending random button clicks is
gone and is correctly shows as interrupt 12.

the only remaining problem is that the transition to S5 on shutdown does
not power off the computer but just locks it. everything else works.

btw, what does that means? my ide interface works perfectly well, i am
just curious:

 pci_irq-0294 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device =
0000:00:1f.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 2=
55

0000:00:1f.1 is:

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)

great work, thank you very much :)
federico
=20
--=20
Federico Di Gregorio
Debian GNU/Linux Developer                                fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
   Abandon the search for Truth; settle for a good fantasy. -- Anonymous

--=-TIFKH5KpJwhUMqD3nKxC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/E93SvcCgrgZGjesRApXlAKDLG2+4+lI5d8C61CLVSc2QqXTGTQCgpXyz
snE5ueuAdumK3M8PKd3bne0=
=eFxz
-----END PGP SIGNATURE-----

--=-TIFKH5KpJwhUMqD3nKxC--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
