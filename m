From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Possible mistake in DSDT pages on acpi.sf.net
Date: Tue, 10 Feb 2004 11:32:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040210103231.GA19342@fuchi>
References: <LAW11-OE22OdHFSux6V0002b246@hotmail.com> <20040126132320.GB30527@fuchi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040126132320.GB30527-5sK/Rx+du8M@public.gmane.org>
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello again...

FYI:
since nobody has answered to the issue below, i took a look into the
specs (2.0c) and decided that dino is right.
so the DSDT pages and the database have been changed to reflect this.
hm, nobody has used these fields anyway. >:)

cheers,
 sebastian

* Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org> [2004-01-26 15:54 +0100]:
>=20
> * Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> [2004-01-26 14:12 +0100]:
> > I think there might be a mistake on the acpi.sf.net site, where the DSD=
Ts are displayed.
> > There are two entries that say "S2 Latency", and "S3 Latency"; however,=
 I think that it is supposed to be C2 and C3 latencies.
> > Please correct me if I'm wrong.
>=20
> dino and i already had a little discussion about this where he wrote:=20
>=20
> -----------
>=20
> In the ACPI 1.0b specs, section "5.2.5 Fixed ACPI Description Table", on
> page 115 you will find P_LVL2_LAT & P_LVL3_LAT. I read most of the ACPI
> 1.0b specs, and a bit of 2.0, and didn't see anytying about the Sx latenc=
y.
> The Duty Width parameter also comes from that table, so that's why I'm=20
> inclined to think that the other params came from there as well.
>=20
> -----------
>=20
>=20
> before changing this, i wanted to read the opinions of people who _really_
> know what this is about. :)

--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAKLM/reHfL3pi+bQRAlq9AJ9W9AVqL70Rs1PuGllwuuDGRg46cQCfZsbt
t9BHllyAhqglARultcbELPY=
=2ocr
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
