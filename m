From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Intel ACPI-CA compiler: 'make' error
Date: Mon, 7 Jun 2004 15:09:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040607130901.GC11893@fuchi>
References: <40C2CCCC.4050409@pca.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40C2CCCC.4050409-wlebWZzHoyE@public.gmane.org>
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


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello luca...

* Luca Capello <luca-wlebWZzHoyE@public.gmane.org> [2004-06-07 10:31 +0200]:
> -----BEGIN PGP SIGNED MESSAGE-----
>=20
> as I'd like to disassemble the latest ASUS M6N DSDT (version 0208A,
> which lacks S1, while in the ancient 0205A S1 was present), I downloaded
> the ACPI-CA Unix source package from
> 	http://developer.intel.com/technology/iapc/acpi/downloads.htm
>=20
> Trying to compile the compiler, I got an error:
> =3D=3D=3D=3D=3D
> gismo:/usr/src/kernel/dsdt/acpica-unix-20040527/compiler# make
> bison -v -d -y -pAslCompiler aslcompiler.y
> conflicts: 33 shift/reduce, 47 reduce/reduce
> aslcompiler.y:882.7-81: warning: rule never reduced because of
> conflicts: TermArg: Type2IntegerOpcode
> aslcompiler.y:883.7-81: warning: rule never reduced because of
> conflicts: TermArg: Type2StringOpcode
> aslcompiler.y:884.7-81: warning: rule never reduced because of
> conflicts: TermArg: Type2BufferOpcode
> aslcompiler.y:885.7-81: warning: rule never reduced because of
> conflicts: TermArg: Type2BufferOrStringOpcode
> aslcompiler.y:1473.7-38: warning: rule never reduced because of
> conflicts: CaseTermList: CaseTerm
> aslcompiler.y:1482.7-38: warning: rule never reduced because of
> conflicts: DefaultTermList: CaseTerm
> cp y.tab.c aslcompilerparse.c
> cp y.tab.h aslcompiler.y.h
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
> - -I../include    -c -o aslcompilerparse.o aslcompilerparse.c
> flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
> - -I../include    -c -o aslcompilerlex.o aslcompilerlex.c
> aslcompiler.l: In function `comment':
> aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
> function)
> aslcompiler.l:837: error: (Each undeclared identifier is reported only on=
ce
> aslcompiler.l:837: error: for each function it appears in.)
> make: *** [aslcompilerlex.o] Error 1
>=20
> gismo:/usr/src/kernel/dsdt/acpica-unix-20040527# gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.3/specs
> Configured with: ../src/configure -v
> - --enable-languages=3Dc,c++,java,f77,pascal,objc,ada,treelang --prefix=
=3D/usr
> - --mandir=3D/usr/share/man --infodir=3D/usr/share/info
> - --with-gxx-include-dir=3D/usr/include/c++/3.3 --enable-shared
> - --with-system-zlib --enable-nls --without-included-gettext
> - --enable-__cxa_atexit --enable-clocale=3Dgnu --enable-debug
> - --enable-java-gc=3Dboehm --enable-java-awt=3Dxlib --enable-objc-gc i486=
-linux
> Thread model: posix
> gcc version 3.3.3 (Debian 20040422)
> =3D=3D=3D=3D=3D
>=20
> Can someone at Intel correct this, please?

apart from the guys at intel fixing this, debian users should be able to
compile the iasl with the packages "flex-old" and "bison-1.35" if i
recall correctly.

hth,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxGjtreHfL3pi+bQRAj0gAKCHtAysoP+Eqohq4ciMtU8k9BnnzwCfVaMe
rCjpr1AnMbbprSo3/V2FdPo=
=7cd1
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
