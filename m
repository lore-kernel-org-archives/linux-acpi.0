From: anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org
Subject: Re: ACPI and APM
Date: Sat, 24 Aug 2002 22:53:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824205341.GA4124@delight>
References: <20020824192026.0e4811bf.valvoline@tiscalinet.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020824192026.0e4811bf.valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org> [2002-08-24 22:45:40]:
> [...]
>=20
> i've hacked the acpi.c and apm.c drivers files under the arch/i386/kernel,
> and i've bypassed some controls, to load both apm and acpi. Next, i've
> disabled the Battery, AC-Adapter and Button flags, from ACPI config.
> Under APM config, i've enabled the 'PM at boot time' and 'Enable console
> Blanking using APM'.=20
>=20
> the system seems to work properly (fans works fine, and are triggered wel=
ls),
> the thermal zone works fine, and....apmd suspend/standby WORKS!
>=20
> there're some problems, that i don't know, doing something like above ?
> suggests ?, comments ?...any will be welcome!
>=20

As far as I know if you enable both acpi and apm it just uses apm, it will
even tell you during boot (dmesg please). I don't know what you hacked
(since you didn't include a patch) but it just seems as if suspend works
with apm and not acpi, like it does with my toshiba.


> thanx in advance.

--
Anders Rune Jensen
anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org
--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Z/JVlCgXCwKO+H0RAo0lAJ47dQy2FnWTZhrfS8xBIIGRRuJuEQCfbKKN
oT51bgIMbI4TZNesthjkUuQ=
=hXGn
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
