From: =?ISO-8859-1?Q?S=E9rgio?= "M. Basto" <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: ACPI-CA does not compile
Date: Mon, 07 Jun 2004 11:23:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1086603818.31211.2.camel@rh10.fe.up.pt>
References: <20040607014607.49459.qmail@web20421.mail.yahoo.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-Xysj0G9m5OdnxfkazULW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040607014607.49459.qmail-TTEngqVsTT6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Z F <mail4me9999-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Xysj0G9m5OdnxfkazULW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

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
> iasl as its part. According to Intel's instructions everthing 
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
> aslcompiler.l: In function `comment':
> aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
> function)
> aslcompiler.l:837: error: (Each undeclared identifier is reported only
> once
> aslcompiler.l:837: error: for each function it appears in.)
> make: *** [aslcompilerlex.o] Error 1
> 
> 
> 
> 	
> 		
> __________________________________
> Do you Yahoo!?
> Friends.  Fun.  Try the all-new Yahoo! Messenger.
> http://messenger.yahoo.com/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> >From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

Sergio M. B.

--=-Xysj0G9m5OdnxfkazULW
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
Hi<BR>
try this before compile ...<BR>
mv NAMESPACE namespace<BR>
mv ../INTERPRETER/ ../interpreter<BR>
mv ../interpreter/PARSER/ ../interpreter/parser<BR>
mv ../interpreter/DISPATCHER/ ../interpreter/DISPATCHER/<BR>
mv ../interpreter/DISPATCHER/ ../interpreter/dispatcher<BR>
mv ../interpreter/EXECUTER/ ../interpreter/executer<BR>
mv ../TABLES/ ../tables<BR>
<BR>
regards,<BR>
<BR>
On Mon, 2004-06-07 at 02:46, Z F wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hello everybody,

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
Friends.  Fun.  Try the all-new Yahoo! Messenger.</FONT>
<A HREF="http://messenger.yahoo.com/"><U>http://messenger.yahoo.com/</U></A>
<FONT COLOR="#737373">

-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
&gt;From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! </FONT><A HREF="http://www.installshield.com/Dev2Dev/0504"><U>http://www.installshield.com/Dev2Dev/0504</U></A>
<FONT COLOR="#737373">_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<A HREF="https://lists.sourceforge.net/lists/listinfo/acpi-devel"><U>https://lists.sourceforge.net/lists/listinfo/acpi-devel</U></I></A></PRE>
</BLOCKQUOTE>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
Sergio M. B.
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--=-Xysj0G9m5OdnxfkazULW--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
