From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: [ACPI-sppt] active cooling, amount of trippoints, specification
Date: Wed, 11 Feb 2004 13:43:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211124354.GB8581@fuchi>
References: <402A18DC.701@renninger.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <402A18DC.701-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello thomas..

* Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org> [2004-02-11 13:34 +0100]:
>=20
> please correct me if I am wrong:
>=20
> At least the /proc interface only allows to modify two active cooling=20
> trippoints.
> e.g. echo critical:hot:passive:active1:active2=20
> >/proc/acpi/thermal_zone/*/trip_points
>=20
> The ACPI specification (2.0b) specifies up to ten different trippoints=20
> for active cooling(p.284).
>=20
> Is everything inside the kernel designed for only supporting two active=
=20
> cooling trippoints?
> Is it going to change(specially the /proc/.../trip_points interface) to=
=20
> control the amount of active cooling
> devices as mentioned in the specs?

coincidently, i had a brief discussion with pavel machek about this last
week and he told me:

---------------=20

> did you also take into account that there may be more than 2 active
> levels? according to the spec, there should be 10 possible levels
> (12.3.1). is that implemented?

No, it is not implemented. I've seen machines with active[1], but not
ones with more active zones.

                                                                           =
     Feel free to do that...  Code should really accept 4-13 parameters...

-----------------

bye,
 sebastian

p.s.: diverted from acpi-support to acpi-devel intentionally.

--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAKiOKreHfL3pi+bQRAluHAJkB9HD16kAXVWGiSGdp6mAzievpJQCgkp+I
3ZZIPCaN8assMXI0O+0P4W4=
=PO7m
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
