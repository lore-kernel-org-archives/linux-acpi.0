From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Can set all but active[2] temperature via trip_points
Date: Mon, 26 Apr 2004 13:25:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040426112550.GB23616@fuchi>
References: <20040425055737.GA7358@home.larve.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040425055737.GA7358-OcF6MH9IheHrhBy7cqgyXA@public.gmane.org>
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


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello hugo...

* Hugo Haas <hugo-rQR7RsZM/uVeoWH0uzbU5w@public.gmane.org> [2004-04-26 09:25 +0200]:
>=20
> I have found a weird problem: using
> /proc/acpi/thermal_zone/TZ1/trip_points, I can set all but the
> active[2] temperature.

i had a little discussion with pavel machek about that a couple of weeks
ago. as written in 12.3.1, the acpi spec defines 10 active states.
the current implementation in linux is implemented for only 2 active
states, because pavel had not seen more than that before. he also told
me that it should not be too hard to expand this to more active states.
so you could either nag him to do that or do it yourself and send the
patch to this list. :)

hth,
 sebastian

--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjPG+reHfL3pi+bQRAhfTAJ9rY4OzoCjdi6UlEtUPP+IMMJ4UlwCePbRG
PTy46yPCry1DgKTftr152VM=
=T5ok
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
