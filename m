From: Z F <mail4me9999-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI-CA does not compile
Date: Sun, 6 Jun 2004 18:46:07 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040607014607.49459.qmail@web20421.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello everybody,

I am trying to install dsdt table into kernel. For that I need to
compile
it with iasl. Intel distributes source code for ACPI-CA and this has
iasl as its part. According to Intel's instructions everthing 
should compile. But I get the following error after executing make.

Any help is appreciated.

Lazar

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
-I../include    -c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER
-I../include    -c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only
once
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
