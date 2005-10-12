From: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest acpica
Date: Wed, 12 Oct 2005 10:37:59 -0700
Message-ID: <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f@mail.gmail.com>
References: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15428_11354890.1129138679552"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E02AA4005-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

------=_Part_15428_11354890.1129138679552
Content-Type: multipart/alternative;
	boundary="----=_Part_15429_17596240.1129138679552"

------=_Part_15429_17596240.1129138679552
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am using GNU flex 2.5.31. I was able to get it to build (on x86_64 even)
with the attached patch. I have also attached the warnings, in case those
are of interest.

(Any Debian people want to package iasl?)

Regards -- Andy

On 9/8/05, Moore, Robert <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> And this seems like a fairly relevant quote as well:
>
> >Flex no longer conforms to the POSIX lex behaviour
>
>
>
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Wilcox
> > Sent: Thursday, September 08, 2005 12:31 PM
> > To: Moore, Robert
> > Cc: Frank; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: Re: [ACPI] Latest acpica
> >
> > On Thu, Sep 08, 2005 at 12:23:50PM -0700, Moore, Robert wrote:
> > > Tell me what needs to change in order to make it compatible.
> >
> > I've never looked into it in any detail. From the Debian description:
> >
> > The behaviour of Flex has undergone a major change since version
> > 2.5.4a; Flex scanners are now reenterant, you may have multiple
> > scanners in the same program with differing sets of defaults, and
> > they play nicer with modern C and C++ compilers. The Flip side is
> > that Flex no longer conforms to the POSIX lex behaviour, and the
> > scanners require conforming implementations when flex is used in ANSI
> > C mode. The package flex-old provides the older behaviour.
> >
> > The GNU web page has some more detail:
> >
> >
> http://www.gnu.org/software/flex/manual/html_chapter/flex_20.html#SEC20
> >
> > and there's a bug showing exactly this problem being encountered here:
> >
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D191942
> >
> > The important bit is probably the quote:
> >
> > The relevant change in the new flex is that it's no longer valid
> > to call unput() from the section after %%, only in actions or
> > in the %{ ... %} section.
> >
> > HTH.
> >
> >
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO
> > September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> > Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing
> & QA
> > Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>

------=_Part_15429_17596240.1129138679552
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am using GNU flex 2.5.31. I was able to get it to build (on x86_64
even) with the attached patch. I have also attached the warnings, in
case those are of interest.<br>
<br>
(Any Debian people want to package iasl?)<br>
<br>
Regards -- Andy<br><br><div><span class=3D"gmail_quote">On 9/8/05, <b class=
=3D"gmail_sendername">Moore, Robert</b> &lt;<a href=3D"mailto:robert.moore@=
intel.com">robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</span><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">
And this seems like a fairly relevant quote as well:<br><br>&gt;Flex no lon=
ger conforms to the POSIX lex behaviour<br><br><br><br>&gt; -----Original M=
essage-----<br>&gt; From: <a href=3D"mailto:acpi-devel-admin-5NWGOfrQmnetEtDZOKyKiw@public.gmane.org=
rge.net">
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a> [mailto:<a href=3D"mailto:acpi-d=
evel-">acpi-devel-</a><br>&gt; <a href=3D"mailto:admin-5NWGOfrQmneRv+LV9MX5uv+2+P5yyue3@public.gmane.org=
t">admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>] On Behalf Of Matthew Wilcox<br>&gt; Sen=
t: Thursday, September 08, 2005 12:31 PM
<br>&gt; To: Moore, Robert<br>&gt; Cc: Frank; <a href=3D"mailto:acpi-devel@=
lists.sourceforge.net">acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>&gt; Subject=
: Re: [ACPI] Latest acpica<br>&gt;<br>&gt; On Thu, Sep 08, 2005 at 12:23:50=
PM -0700, Moore, Robert wrote:
<br>&gt; &gt; Tell me what needs to change in order to make it compatible.<=
br>&gt;<br>&gt; I've never looked into it in any detail.&nbsp;&nbsp;From th=
e Debian description:<br>&gt;<br>&gt;&nbsp;&nbsp;The behaviour of Flex has =
undergone a major change since version
<br>&gt;&nbsp;&nbsp;2.5.4a; Flex scanners are now reenterant, you may have =
multiple<br>&gt;&nbsp;&nbsp;scanners in the same program with differing set=
s of defaults, and<br>&gt;&nbsp;&nbsp;they play nicer with modern C and C++=
 compilers. The Flip side is
<br>&gt;&nbsp;&nbsp;that Flex no longer conforms to the POSIX lex behaviour=
, and the<br>&gt;&nbsp;&nbsp;scanners require conforming implementations wh=
en flex is used in ANSI<br>&gt;&nbsp;&nbsp;C mode. The package flex-old pro=
vides the older behaviour.
<br>&gt;<br>&gt; The GNU web page has some more detail:<br>&gt;<br>&gt;<br>=
<a href=3D"http://www.gnu.org/software/flex/manual/html_chapter/flex_20.htm=
l#SEC20">http://www.gnu.org/software/flex/manual/html_chapter/flex_20.html#=
SEC20
</a><br>&gt;<br>&gt; and there's a bug showing exactly this problem being e=
ncountered here:<br>&gt;<br>&gt; <a href=3D"http://bugs.debian.org/cgi-bin/=
bugreport.cgi?bug=3D191942">http://bugs.debian.org/cgi-bin/bugreport.cgi?bu=
g=3D191942
</a><br>&gt;<br>&gt; The important bit is probably the quote:<br>&gt;<br>&g=
t;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The relevant change in the new flex =
is that it's no longer valid<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to=
 call unput() from the section after %%, only in actions or
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in the %{ ... %} section.<br>&=
gt;<br>&gt; HTH.<br>&gt;<br>&gt;<br>&gt; ----------------------------------=
---------------------<br>&gt; SF.Net email is Sponsored by the Better Softw=
are Conference &amp; EXPO<br>
&gt; September 19-22, 2005 * San Francisco, CA * Development Lifecycle<br>&=
gt; Practices<br>&gt; Agile &amp; Plan-Driven Development * Managing Projec=
ts &amp; Teams * Testing<br>&amp; QA<br>&gt; Security * Process Improvement=
 &amp; Measurement *
<br><a href=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><b=
r>&gt; _______________________________________________<br>&gt; Acpi-devel m=
ailing list<br>&gt; <a href=3D"mailto:Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">Acp=
i-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
</a><br>&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/acpi-d=
evel">https://lists.sourceforge.net/lists/listinfo/acpi-devel</a><br><br><b=
r>-------------------------------------------------------<br>SF.Net email i=
s Sponsored by the Better Software Conference &amp; EXPO
<br>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Pract=
ices<br>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams=
 * Testing &amp; QA<br>Security * Process Improvement &amp; Measurement *=
=20
<a href=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><br>__=
_____________________________________________<br>Acpi-devel mailing list<br=
><a href=3D"mailto:Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">Acpi-devel-5NWGOfrQmnfLDRD5uJR0wg@public.gmane.org=
eforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel"=
>https://lists.sourceforge.net/lists/listinfo/acpi-devel</a><br></blockquot=
e></div><br>

------=_Part_15429_17596240.1129138679552--

------=_Part_15428_11354890.1129138679552
Content-Type: text/x-patch; name=iasl.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="iasl.diff"

diff -Naur acpica-unix-20050930-orig/compiler/aslglobal.h acpica-unix-20050930/compiler/aslglobal.h
--- acpica-unix-20050930-orig/compiler/aslglobal.h	2005-09-30 15:50:18.000000000 -0700
+++ acpica-unix-20050930/compiler/aslglobal.h	2005-10-12 10:26:33.000000000 -0700
@@ -143,7 +143,6 @@
 extern FILE                         *AslCompilerin;
 extern int                          AslCompilerdebug;
 extern const ASL_MAPPING_ENTRY      AslKeywordMapping[];
-extern char                         *AslCompilertext;
 extern char                         hex[];
 
 #define ASL_LINE_BUFFER_SIZE        512
diff -Naur acpica-unix-20050930-orig/compiler/Makefile acpica-unix-20050930/compiler/Makefile
--- acpica-unix-20050930-orig/compiler/Makefile	2005-09-30 15:50:19.000000000 -0700
+++ acpica-unix-20050930/compiler/Makefile	2005-10-12 10:09:39.000000000 -0700
@@ -85,7 +85,7 @@
 #YACC=	yacc
 YACC=	bison
 YFLAGS+= -v -d
-LEX=	flex
+LEX=	flex -l
 LFLAGS+= -i
 
 #.if $(YACC) == "bison"





------=_Part_15428_11354890.1129138679552
Content-Type: text/x-log; name=err.log; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="err.log"

conflicts: 61 shift/reduce, 18 reduce/reduce
aslcompiler.y:915.7-81: warning: rule never reduced because of conflicts: TermArg: Type2IntegerOpcode
aslcompiler.y:916.7-81: warning: rule never reduced because of conflicts: TermArg: Type2StringOpcode
aslcompiler.y:917.7-81: warning: rule never reduced because of conflicts: TermArg: Type2BufferOpcode
aslcompiler.y:918.7-81: warning: rule never reduced because of conflicts: TermArg: Type2BufferOrStringOpcode
aslcompiler.y:964.7-82: warning: rule never reduced because of conflicts: OptionalParameterTypePackage: ','
aslcompiler.y:983.37-48: warning: rule never reduced because of conflicts: ParameterTypesPackageList: /* empty */
aslcompiler.y:984.7-46: warning: rule never reduced because of conflicts: ParameterTypesPackageList: ObjectTypeKeyword
aslcompiler.y:988.7-989.69: warning: rule never reduced because of conflicts: ParameterTypesPackageList: ParameterTypesPackage ',' ParameterTypesPackage
aslcompiler.y:994.7-82: warning: rule never reduced because of conflicts: OptionalParameterTypesPackage: ','
aslcompiler.y:1585.7-38: warning: rule never reduced because of conflicts: CaseTermList: CaseTerm
aslcompiler.y:1594.7-38: warning: rule never reduced because of conflicts: DefaultTermList: CaseTerm
aslcompiler.y:3077.37-48: warning: rule never reduced because of conflicts: OptionalResourceType: /* empty */
aslcompilerlex.c: In function `AslCompilerlex':
aslcompilerlex.c:2125: warning: label `find_rule' defined but not used
aslcompiler.l: At top level:
aslcompilerlex.c:4395: warning: 'yy_flex_strlen' defined but not used
asllisting.c: In function `LsAmlListingWalk':
asllisting.c:322: warning: cast from pointer to integer of different size
aslopt.c: In function `OptBuildShortestPath':
aslopt.c:439: warning: int format, different type arg (arg 7)
aslopt.c:439: warning: int format, different type arg (arg 8)
aslopt.c: In function `OptOptimizeNamePath':
aslopt.c:755: warning: int format, different type arg (arg 8)
aslopt.c:755: warning: int format, different type arg (arg 10)
aslopt.c:815: warning: int format, different type arg (arg 7)
../osunixxf.c: In function `AcpiOsGetRootPointer':
../osunixxf.c:188: warning: implicit declaration of function `AeLocalGetRootPointer'





------=_Part_15428_11354890.1129138679552--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
