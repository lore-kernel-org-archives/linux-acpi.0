From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: ACPI-Patch against 2.4.20-pre10-ac1
Date: Fri, 11 Oct 2002 18:57:02 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021011225702.GA17690@tarnation.dyndns.org>
References: <20021011183427.20a55d1c.hanno@gmx.de> <1034372783.12355.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1034372783.12355.4.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I use acpi and cpufreq on my Vaio r505 laptop. ACPI does not
seem to be able to do cpu throttling on the system (it's a Pentium
III-M if anyone's interested), but the modules for cpufreq handles
it well (except when it first loads during boot it seems to be
getting odd numbers in the proc files).

These statements are based on an earlier pre-patch than pre10 though.

Behold, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> hath decreed:
> On Fri, 2002-10-11 at 17:34, Hanno B=F6ck wrote:
> > I tried to apply the acpi-patch against 2.4.20-pre10-ac1.
> >=20
> > It is not perfect, there are some problems with cpufreq i couldn't fix.=
 If you disable cpufreq, it should compile and run.
> >=20
> > If anyone fixes the cpufreq-issue, please inform me.
>=20
> You don't want to mix the two. If you do need native power management on
> your ACPI system the ACPI layer eventually has to be the one making the
> cpufreq requests
>=20
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20

                              Aaron Gaudio
                   prothontar at tarnation.dyndns.org
                    http://prothonotarium.dyndns.org

   "From fullness, aspect. From aspect, being. From being, emptiness."
 =20

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2nVz4ACgkQwXDG7ZQN91dC5QCg2Vt96C9mj6QszEnXP5PrZE01
vTEAoK59pt7K6RcY0aPqNeCqhRpIi7pJ
=qnYf
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
