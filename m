From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: DSDT Change (Compaq Presario 2100)
Date: Fri, 28 May 2004 06:21:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405280621.29874.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ZzztAPv+gXkgILB";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--Boundary-02=_ZzztAPv+gXkgILB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey!

Sorry for semi spamming the list tonight - but I'm finally getting places :)

As previously mentioned, my Compaq as well as many other HP model notebooks=
=20
slow down considerably when running on battery. Short off "ACPI=3Doff" ther=
e=20
seemed to be no workaround.

Well, tonight, while recompiling the DSDT a few times to remove warnings an=
d=20
errors, I stumbled across this (in method SMSL

If (0x01)
{
	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
	Store (TRDC, Debug)
	Store (0x01, TREN)
}

I am assuming that the "If (0x01)" was put there by a developer to disable=
=20
this throttle duty cycle mechanism easily for testing, or maybe for differe=
nt=20
OEMs.

In any case, I changed "If (0x01)" to "If (0x00)" and voila, I am typing th=
is=20
email from KDE with the power cord unplugged - no slowdown at all.

Now my questions:

1) Does this sound sane?
2) Should I submit the updated DSDT to acpi.sf.net?

Cheers,
   Andr=E9

--Boundary-02=_ZzztAPv+gXkgILB
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtzzZ5DBE808V5icRAim6AJwPylAISTzSgkro2eewaXAdg1d/yACgn9I2
1R0Ju3FM0Y5JqlpYnN+E7HU=
=G7jg
-----END PGP SIGNATURE-----

--Boundary-02=_ZzztAPv+gXkgILB--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
