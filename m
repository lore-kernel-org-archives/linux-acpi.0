From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: bad dsdt?
Date: Mon, 26 Jan 2004 11:53:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040126105355.GB11640@fuchi>
References: <200401211345.58192.vherried@insight.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200401211345.58192.vherried-rEckef8uG3NTGrOy2lmfZw@public.gmane.org>
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


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi vince...

* Vince Herried <vherried-rEckef8uG3NTGrOy2lmfZw@public.gmane.org> [2004-01-25 10:10 +0100]:
> I'm runnin a vanilla 2.6.1 kernel on a Dell Latitude C810
> and have a bunch of issues.
>=20
> The Fn keys don't work (eg Fn <suspend>,   Fn <setup>,  Fn .....>
> yes I enabled the acpi fn key option.
>=20
>=20
> /proc/acpi  has no information about my battery, or temperature, or....

but /proc/acpi/info exists? what does it say?

>=20
> I'm thinking I should make multiple problem records with bugzilla (and wh=
ere=20
> is that?)

http://bugzilla.kernel.org/buglist.cgi?short_desc_type=3Dallwordssubstr&sho=
rt_desc=3D&component=3DACPI.

> and what kind of doc do I supply besides  dsdt and .config file?

please see the front page of http://acpi.sf.net

cheers,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFPHDreHfL3pi+bQRAvbCAJ4v9cWHVcYSABet8cAKvc7BQYwDTwCeMsew
c/RFGEYo7Jcz5wrbFSh0WjM=
=TjcJ
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
