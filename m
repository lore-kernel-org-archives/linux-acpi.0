From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Error compiling iasl
Date: Wed, 15 Sep 2004 14:21:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040915122149.GB30389@fuchi>
References: <4145CAE7.90709@estg.ipleiria.pt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4145CAE7.90709-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
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


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello luis..

* Lu=EDs Neves <lneves-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org> [2004-09-14 09:23 +0200]:
>=20
> I downloaded acpica-unix-20040715.tar.gz in order to compile iasl but I=
=20
> got an error compiling:
>=20
> pln:/usr/src/acpica-unix-20040715/compiler# make
> yacc -v -d -y -pAslCompiler aslcompiler.y
> conflicts: 33 shift/reduce, 47 reduce/reduce
> aslcompiler.y:882.7-81: warning: rule never reduced because of=20
> conflicts: TermArg: Type2IntegerOpcode
> aslcompiler.y:883.7-81: warning: rule never reduced because of=20
> conflicts: TermArg: Type2StringOpcode
> aslcompiler.y:884.7-81: warning: rule never reduced because of=20
> conflicts: TermArg: Type2BufferOpcode
> aslcompiler.y:885.7-81: warning: rule never reduced because of=20
> conflicts: TermArg: Type2BufferOrStringOpcode
> aslcompiler.y:1473.7-38: warning: rule never reduced because of=20
> conflicts: CaseTermList: CaseTerm
> aslcompiler.y:1482.7-38: warning: rule never reduced because of=20
> conflicts: DefaultTermList: CaseTerm
> cp y.tab.c aslcompilerparse.c
> cp y.tab.h aslcompiler.y.h
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
> -I../include    -c -o aslcompilerparse.o aslcompilerparse.c
> flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
> -I../include    -c -o aslcompilerlex.o aslcompilerlex.c
> aslcompiler.l: In function `comment':
> aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this=20
> function)
> aslcompiler.l:837: error: (Each undeclared identifier is reported only onc
> aslcompiler.l:837: error: for each function it appears in.)
> make: *** [aslcompilerlex.o] Error 1
>=20
> Can anyone help me? I have a Debian Sarge (testing), gcc 3.3.4, flex=20
> 2.5.31, bison 1.875a. I need iasl to decompile my HP pavilion zt3240=20
> DSDT as I currently have no thermal_zone contents in /proc.

if i remember correctly, you need older versions of bison and/or flex to
compile iasl successfully on Debian testing.
try the packages flex-old and bison-1.35.

hth,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBSDPdreHfL3pi+bQRArMXAJ9Sffz/BbjZzfg4IUMc3ce8zz0FaACeKHW7
q3izPf/PwsT7dcCMMKl9YjM=
=njZi
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
