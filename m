From: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Thu, 24 Jul 2003 16:45:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030724144535.GA629@paradigm.rfc822.org>
References: <20030723152809.GA591@paradigm.rfc822.org> <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org> <1059045536.19684.21.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1059045536.19684.21.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2003 at 01:18:56PM +0200, Knut Neumann wrote:
> I received some tips from Ole Rohne some time ago, which were:
>=20
> * Insert lcall $0xffff,$0 or machin_restart in various places in   =20
>   wakeup.S and upwards and see if your machine reboots on S3 resume

Ok - i tried this - Doesnt work - Machine seems not to execute the
wakeup code at all.

And now ?

I read a bit in the ACPI Specs - It seems there are a 32Bit and a 64Bit=20
pointer to the wakeup routine. The 32Bit pointer says "superseeded by
"X_Firmware_Waking_Vector" which seems not to be set in
drivers/acpi/hardware/hwsleep.c:acpi_set_firmware_waking_vector

Might that be one of the causes ?

Flo
--=20
Florian Lohoff                  flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org             +49-171-2280134
                        Heisenberg may have been here.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/H/EPUaz2rXW+gJcRArCQAJ4xAOKSKLwMSPDkQd00709LWhhrPgCfbW0W
5DEH/QNignLn9UTXdlqdNqI=
=C3tf
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
