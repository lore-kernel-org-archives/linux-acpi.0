From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: problems compiling iasl on debian sarge
Date: Sat, 23 Jul 2005 01:04:20 +0000
Message-ID: <20050723010420.GA4368@fingerbrecher>
References: <42E18E6A.8000204@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42E18E6A.8000204-LWAfsSFWpa4@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* widolo87 <widolo87-LWAfsSFWpa4@public.gmane.org> [2005-07-23 00:47 +0000]:
>=20
> I hope that my question is right on this list...

yes.

=20
> I just downloaded acpica-unix-20050624.tar.gz from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm to fix the
> acpi implementation of my new laptop and tried to compile iasl.
>=20
>=20
> Running make in the compiler directory results in
>=20
> --snip--
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER \
> 	-I../include    -c -o aslcompilerlex.o aslcompilerlex.c
>=20
> aslcompiler.l: In function `comment':
> aslcompiler.l:847: error: `yytext_ptr' undeclared (first use in this  \
> 	function)
> aslcompiler.l:847: error: (Each undeclared identifier is reported only \
> 	once
> aslcompiler.l:847: error: for each function it appears in.)
> make: *** [aslcompilerlex.o] Error 1
> --snap--
> (gcc-3.3.5, flex 2.5.31, bison 1.875d)
>=20
> Unfortunately I have no idea of bison and of what's going on in this
> source code.
>=20
>=20
> I would be glad to receive any assistance.

try these:

http://thread.gmane.org/gmane.linux.acpi.devel/8442
http://thread.gmane.org/gmane.linux.acpi.devel/8694
http://www.mail-archive.com/debian-user-german-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org/msg126687.h=
tml

it should boil down to the installation of the package flex-old.

cheers,
 Sebastian
--=20
Oo................................................................
Angestellten ist die Nutzung der Toilette ohne Genehmigung untersagt - Das =
MGT
OpenPGP key ID: 0x7A62F9B4 Geekcode: GCSd-s:a-C++ULB+++W++M+PS+++
=2E...............................................................oO

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4ZeUreHfL3pi+bQRAmziAJ91WRucQ+FNQIG2X0FQXX+kat5WlwCdG/lF
XaEMr928WGSG2OoK5dpoh+w=
=2Ewj
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
