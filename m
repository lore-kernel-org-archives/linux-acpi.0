From: "Jerome Werner" <jerome-werrner-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI-CA does not compile
Date: Sun, 27 Jun 2004 21:48:15 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040628014815.C590AB6B6@xprdmailfe18.nwk.excite.com>
Reply-To: jerome-werrner-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


M. Basto wrote:



Hi

 try this before compile ...

 mv NAMESPACE namespace

 mv ../INTERPRETER/ ../interpreter

 mv ../interpreter/PARSER/ ../interpreter/parser

 mv ../interpreter/DISPATCHER/ ../interpreter/DISPATCHER/

 mv ../interpreter/DISPATCHER/ ../interpreter/dispatcher

 mv ../interpreter/EXECUTER/ ../interpreter/executer

 mv ../TABLES/ ../tables

 

 regards,

 

 On Mon, 2004-06-07 at 02:46, Z F wrote:

 

 > Hello everybody,

 > 

 > I am trying to install dsdt table into kernel. For that I need to

 > compile

 > it with iasl. Intel distributes source code for ACPI-CA and this has

 > iasl as its part. According to Intel"s instructions everthing 

 > should compile. But I get the following error after executing make.

 > 

 > Any help is appreciated.

 > 

 > Lazar

 > 

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

 > -I../include    -c -o aslcompilerparse.o aslcompilerparse.c

 > flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l

 > cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER

 > -I../include    -c -o aslcompilerlex.o aslcompilerlex.c

 > aslcompiler.l: In function `comment":

 > aslcompiler.l:837: error: `yytext_ptr" undeclared (first use in this

 > function)

 > aslcompiler.l:837: error: (Each undeclared identifier is reported only

 > once

 > aslcompiler.l:837: error: for each function it appears in.)

 > make: *** [aslcompilerlex.o] Error 1

 > 

 > 



I am also having this compilation problem. I gathered that I needed flex and bison from prior errors. I installed them. Now I'm getting the same error as above even with the rename suggestions. Could there be other dependencies? Or is this something else? (I'm using debian unstable)

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
