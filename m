From: Ronald Hitz <Ronald.Hitz-1NtEGJHV5g0@public.gmane.org>
Subject: iasl-compile failure
Date: Mon, 13 Sep 2004 22:49:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1C6xlP-0005uX-00@mail1.isc.de>
Reply-To: Ronald.Hitz-1NtEGJHV5g0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Luis N. and other readers,

No great help to You Luis,
just let You that You are not the only with that problem:

 I downloaded acpica-unix-20040715.tar.gz in order to compile iasl but I=20
  got an error compiling:

dude@sandpiper:/usr/local/src/acpica-unix-20040715/compiler$ make
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
-I../include    -c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In Funktion =BBcomment=AB:
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only
once
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Fehler 1

Can anyone help me? I have a Debian Sarge (testing), gcc 3.3.4, flex=20
 2.5.31, bison 1.875a. I need iasl to decompile my IBM R40=20
  DSDT as I currently have no correct sleep modus with acpi, but with
  apm.
  =20
    kind regards,
    =20
      Ronald Hitz

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBRgfWIZtySvzDl4oRAktyAKCqjeTnB6so0SvBfGdroB6IOFN0BwCeMnwo
0VyeZis12b5tQxu96JFztdw=
=0MAI
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
