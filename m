From: James Bromberger <james-Q/PxBS77Xz0@public.gmane.org>
Subject: SYM53c8xx 2.6.0-test1-ac3 ACPI IRQ mismatch?
Date: Sat, 26 Jul 2003 04:39:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030725203921.GA13042@phobe.internal.pelicanmanufacturing.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

I've been trying to get the SMB53C5XX scsi driver to detect my=20
LSI 1010-66 scsi adapter, and found that it fails to detect it completely
under 2.6.0-test1-ac3 with the SMB53C8XX driver and ACPI turned on,
however, it appears to work with ACPI disabled. Would anyone like any
specific information from the card/logs? The controller has my root
filesystem on an attached disk, so when it fails, I get an obvious
kernel panic with root FS not found.

Regards,

  James
  (PS: I am not on acpi-devel, please email me directly)
--=20
 James Bromberger <james_AT_rcpt.to> www.james.rcpt.to
 Remainder moved to http://www.james.rcpt.to/james/sig.html

I am in London on UK mobile +44 7952 042920.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZV5pfJwKAkXqeQRAnEaAKCmIBg/FCXQZ1EI+YNjEsj6whdZSQCgmcGy
LtCmL1H/Wc3caGWvt3ku9c0=
=UeiE
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
