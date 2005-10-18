From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Latest acpica
Date: Tue, 18 Oct 2005 13:31:25 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E031CC3AC@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5D422.E94F9371"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5D422.E94F9371
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It is my understanding that only flex-old will work to build iASL,
because the new flex is not compatible with lex in some important areas.

=20

I don't know any more than this.

Bob

=20

=20

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andrew
Grover
Sent: Tuesday, October 18, 2005 1:24 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Moore, Robert
Subject: Re: [ACPI] Latest acpica

=20

Yeah I wish I knew enough flex to fix it, too. How hard can it be? :) --
Andy

On 10/18/05, Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org
<mailto:malattia-k2GhghHVRtY@public.gmane.org> > wrote:

On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:
> I am using GNU flex 2.5.31. I was able to get it to build (on x86_64
even)
> with the attached patch. I have also attached the warnings, in case
those
> are of interest.

I tried building my DSDT with a patched iasl built with the latest flex=20
available in debian (2.5.31) but it seems the -l flag is doing more bad
than good. I get a bunch of (meaningless) errors:

DSDT.dsl    34:     Scope (\_GPE)
Error    1094 -                ^ syntax error, unexpected
PARSEOP_NAMESEG, expecting ')'

DSDT.dsl    38:             Notify (\_SB.PCI0.USB1, 0x02)
Error    1094 -                        ^ syntax error, unexpected
PARSEOP_NAMESEG, expecting ','

DSDT.dsl    38:             Notify (\_SB.PCI0.USB1, 0x02)
Error    1094 -                         ^ Invalid character (0x2E),
expecting ASL keyword or name

DSDT.dsl    43:             Notify (\_SB.PCI0.USB2, 0x02)
Error    1094 -                        ^ syntax error, unexpected
PARSEOP_NAMESEG, expecting ','
...
...
ASL Input:  DSDT.dsl - 3597 lines, 124899 bytes, 20 keywords
Compilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 Optimizations

while building with flex-old I only get:=20

DSDT.dsl  1347:                     Field (ECR, AnyAcc, Lock, Preserve)
Error    1073 -                              ^ Host Operation Region
requires ByteAcc access

ASL Input:  DSDT.dsl - 3896 lines, 131852 bytes, 1959 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 388 Optimizations

So I'll probably simply build-depend on flex-old by now and I'll try to
learn=20
more of flex soon :)

--
mattia
:wq!

=20


------_=_NextPart_001_01C5D422.E94F9371
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>It is my understanding that only =
flex-old
will work to build iASL, because the new flex is not compatible with lex =
in
some important areas.</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I don&#8217;t know any more than =
this.</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Bob</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt'>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma'>-----Original Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b>
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] <b><span =
style=3D'font-weight:
bold'>On Behalf Of </span></b>Andrew Grover<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, October =
18, 2005
1:24 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b>
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Moore, Robert<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: [ACPI] =
Latest acpica</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Yeah I wish I =
knew enough
flex to fix it, too. How hard can it be? :) -- Andy</span></font></p>

<div>

<p class=3DMsoNormal><span class=3Dgmailquote><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>On 10/18/05, <b><span =
style=3D'font-weight:bold'>Mattia
Dongili</span></b> &lt;<a =
href=3D"mailto:malattia-k2GhghHVRtY@public.gmane.org">malattia-k2GhghHVRtY@public.gmane.org </a>&gt;
wrote:</span></font></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover =
wrote:<br>
&gt; I am using GNU flex 2.5.31. I was able to get it to build (on =
x86_64 even)<br>
&gt; with the attached patch. I have also attached the warnings, in case =
those<br>
&gt; are of interest.<br>
<br>
I tried building my DSDT with a patched iasl built with the latest flex =
<br>
available in debian (2.5.31) but it seems the -l flag is doing more =
bad<br>
than good. I get a bunch of (meaningless) errors:<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;34:&nbsp;&nbsp;&nbsp;&nbsp; Scope =
(\_GPE)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;^
syntax error, unexpected PARSEOP_NAMESEG, expecting ')'<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^=

syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB1, 0x02)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
^ Invalid character (0x2E), expecting ASL keyword or name<br>
<br>
DSDT.dsl&nbsp;&nbsp;&nbsp;&nbsp;43:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Notify (\_SB.PCI0.USB2, 0x02)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1094
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^=

syntax error, unexpected PARSEOP_NAMESEG, expecting ','<br>
...<br>
...<br>
ASL Input:&nbsp;&nbsp;DSDT.dsl - 3597 lines, 124899 bytes, 20 =
keywords<br>
Compilation complete. 15 Errors, 0 Warnings, 0 Remarks, 2 =
Optimizations<br>
<br>
while building with flex-old I only get: <br>
<br>
DSDT.dsl&nbsp;&nbsp;1347:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Field (ECR, AnyAcc, Lock, Preserve)<br>
Error&nbsp;&nbsp;&nbsp;&nbsp;1073
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^
Host Operation Region requires ByteAcc access<br>
<br>
ASL Input:&nbsp;&nbsp;DSDT.dsl - 3896 lines, 131852 bytes, 1959 =
keywords<br>
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 388 =
Optimizations<br>
<br>
So I'll probably simply build-depend on flex-old by now and I'll try to =
learn <br>
more of flex soon :)<br>
<br>
--<br>
mattia<br>
:wq!</span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C5D422.E94F9371--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
