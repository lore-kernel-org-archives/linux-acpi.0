From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Sun, 18 Jan 2004 18:10:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040118171017.GF2375@inferi.kami.home>
References: <1074382993.674.24.camel@dragon> <1074424728.1914.24.camel@firefly> <400A8381.2050607@pca.it>
Reply-To: dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <400A8381.2050607-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2004 at 02:00:49PM +0100, Luca Capello wrote:
> Hello,
[...]
> 'cpufreqd'. If I've correctly understood, 'cpufreqd' need the
> 'userspace' option/module to work, right? So, why even without the

no, it doesn't. Other cpufreq related daemons need it, not cpufreqd.

> 'userspace' module loaded, is 'cpufreqd' working? I can see it via
> /proc/cpuinfo plugging in/out the AC-Adapter.
>=20
> - what does loading 'cpufreq_' modules cause? I can see no differences
> when I load 'cpufreq_[powersave|userspace]'...

you only load the code into the kernel, you can then use procfs to select
frequencies ang governor.

ciao
--=20
mattia
:wq!

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFACr35gpRPaOotLEERApheAKCYTLhoETE0Jo8rYO+khjLX+PCDDwCfXvxD
mE+FsEA5V70U3hbiqbulhbY=
=pFMQ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
