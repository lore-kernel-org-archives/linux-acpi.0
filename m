From: =?ISO-8859-1?Q?Lu=EDs_Neves?= <lneves-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
Subject: Error compiling iasl
Date: Mon, 13 Sep 2004 17:29:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4145CAE7.90709@estg.ipleiria.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi everybody,

I downloaded acpica-unix-20040715.tar.gz in order to compile iasl but I=20
got an error compiling:

pln:/usr/src/acpica-unix-20040715/compiler# make
yacc -v -d -y -pAslCompiler aslcompiler.y
conflicts: 33 shift/reduce, 47 reduce/reduce
aslcompiler.y:882.7-81: warning: rule never reduced because of=20
conflicts: TermArg: Type2IntegerOpcode
aslcompiler.y:883.7-81: warning: rule never reduced because of=20
conflicts: TermArg: Type2StringOpcode
aslcompiler.y:884.7-81: warning: rule never reduced because of=20
conflicts: TermArg: Type2BufferOpcode
aslcompiler.y:885.7-81: warning: rule never reduced because of=20
conflicts: TermArg: Type2BufferOrStringOpcode
aslcompiler.y:1473.7-38: warning: rule never reduced because of=20
conflicts: CaseTermList: CaseTerm
aslcompiler.y:1482.7-38: warning: rule never reduced because of=20
conflicts: DefaultTermList: CaseTerm
cp y.tab.c aslcompilerparse.c
cp y.tab.h aslcompiler.y.h
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
-I../include    -c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
-I../include    -c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this=20
function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only on=
c
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1

Can anyone help me? I have a Debian Sarge (testing), gcc 3.3.4, flex=20
2.5.31, bison 1.875a. I need iasl to decompile my HP pavilion zt3240=20
DSDT as I currently have no thermal_zone contents in /proc.

Best regards,

Lu=EDs Neves


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
