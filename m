From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Intel ACPI-CA compiler: 'make' error
Date: Sun, 06 Jun 2004 09:50:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C2CCCC.4050409@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

as I'd like to disassemble the latest ASUS M6N DSDT (version 0208A,
which lacks S1, while in the ancient 0205A S1 was present), I downloaded
the ACPI-CA Unix source package from
	http://developer.intel.com/technology/iapc/acpi/downloads.htm

Trying to compile the compiler, I got an error:
=====
gismo:/usr/src/kernel/dsdt/acpica-unix-20040527/compiler# make
bison -v -d -y -pAslCompiler aslcompiler.y
conflicts: 33 shift/reduce, 47 reduce/reduce
aslcompiler.y:882.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2IntegerOpcode
aslcompiler.y:883.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2StringOpcode
aslcompiler.y:884.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2BufferOpcode
aslcompiler.y:885.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2BufferOrStringOpcode
aslcompiler.y:1473.7-38: warning: rule never reduced because of
conflicts: CaseTermList: CaseTerm
aslcompiler.y:1482.7-38: warning: rule never reduced because of
conflicts: DefaultTermList: CaseTerm
cp y.tab.c aslcompilerparse.c
cp y.tab.h aslcompiler.y.h
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
- -I../include    -c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
- -I../include    -c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only once
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1

gismo:/usr/src/kernel/dsdt/acpica-unix-20040527# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.3/specs
Configured with: ../src/configure -v
- --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
- --mandir=/usr/share/man --infodir=/usr/share/info
- --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
- --with-system-zlib --enable-nls --without-included-gettext
- --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
- --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.3 (Debian 20040422)
=====

Can someone at Intel correct this, please?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAwszLVAp7Xm10JmkRApGJAJ0Zu8KXrKKgsGempnpfVBWLHszPJgCeNYTC
EdTeIeJijjbfmMVSV6isFZE=
=gSwl
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
