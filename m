From: Allen_Lee-uiv9WLrdKoDQT0dZR+AlfA@public.gmane.org
Subject: RE: System poweroff
Date: Tue, 1 Jul 2003 16:46:41 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CD08F83C0FFD554CBE4D42ABADAC140904A2C5@tpeex03>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: yarick-343whMTK1pU@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--------------InterScan_NT_MIME_Boundary
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C33FAD.4AAF4B40"

------_=_NextPart_001_01C33FAD.4AAF4B40
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I also want to study how to make =E2=80=9Cshutdown=E2=80=9D in kernel =
mode.
Before, I try to trace =E2=80=9Cshutdown=E2=80=9D source code but it =
seems not a good
method after spending some time on it. Does everyone have better idea?
Allen
=20
-----Original Message-----
From: SIVAKUMAR SUBRAMANI [mailto:sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org]=20
Sent: Monday, June 30, 2003 10:05 PM
To: David Woodhouse
Cc: Yaroslav Rastrigin; ACPI-Devel mailing list
Subject: RE: [ACPI] System poweroff
=20
Yes, Your right. I need exactly the same thing, just a kernel module =
that
helps me to shutdown my PC. Since I am not using laptop, I am not much
worried about the power saving. I just want to do a complete poweroff, =
while
I issue a poweroff command.=20
=20
Let me try out the Reverse engineering policy to write a kernel module =
that
just helps me to power-off the system with out having the support of =
apm in
the kernel.
=20
Any help with regard to this are welcomed.
=20
Thanks,
Siva
=20
-----Original Message-----=20
From: David Woodhouse [mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org]=20
Sent: Mon 6/30/2003 6:08 PM=20
To: SIVAKUMAR SUBRAMANI=20
Cc: Yaroslav Rastrigin; ACPI-Devel mailing list=20
Subject: Re: [ACPI] System poweroff
On Mon, 2003-06-30 at 13:21, siva wrote:
> Hi.
>
> Thanks for the reply.
>
> I do not want to use all the features of the APM (such suspend =
states)
...I
> just want to use the feature of powering off the system completely =
while
run
> the "poweroff / halt -p" commands.
> So it is possible to do this without enabling the APM /ACPI, just by
adding
> some lines of code in the Kernel.

Yes, you can do this if you really want to, but you need sufficient
documentation for your motherboard and chipset. You need to work out =
how
to make it tell the PSU to turn itself off.

You may be able to work this out by reverse-engineering the APM BIOS or
ACPI bytecode. There's nothing _special_ about them that makes them =
able
to turn the machine off -- they're only software, it's just that =
they're
binary-only software to which we don't have the source.

There's no fundamental reason why you shouldn't be able to write a
proper Linux driver; it's just that like so many other things with only
binary-only driver code, we don't seem to be able to get sufficient
documentation for it.

--
dwmw2
N=18HS^=E9=9A=8A[){([Zzn=E8=A5=B4=044D=D7=ACw%=D8=A76i=17l=11&x+ljwEjzz0=
=0E'Z=C9=A9z{^0v\=13bJ=DB=9DDN=1Bm=DA=B2=DE=B5brK&
?=C6=B4]4N=DD=8AZ:m7_=07)=D7=AFzYXX=07)=D7=AFzYb,y+=DE=B6=1Bm+-.=C7=9F=1E=
=7F+-b=D8=A7~rz

------_=_NextPart_001_01C33FAD.4AAF4B40
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dutf-8">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml-SKr1aSsd+kgHK/+4xoi7zTRmByFHzeGd@public.gmane.org">
<title>Re: [ACPI] System poweroff</title>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"date"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DontDisplayPageBoundaries/>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;
	panose-1:2 2 3 0 0 0 0 0 0 0;
	mso-font-alt:PMingLiU;
	mso-font-charset:136;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:3 137232384 22 0 1048577 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
@font-face
	{font-family:"\@=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94";
	panose-1:2 2 3 0 0 0 0 0 0 0;
	mso-font-charset:136;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:3 137232384 22 0 1048577 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;
	mso-bidi-font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;
	mso-bidi-font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:9.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-fareast-font-family:=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:=E8=A1=A8=E6=A0=BC=E5=85=A7=E6=96=87;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:24.0pt'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;col=
or:navy'>I
also want to study how to make =E2=80=9Cshutdown=E2=80=9D in kernel =
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;col=
or:navy'>Before,
I try to trace =E2=80=9Cshutdown=E2=80=9D source code but it seems not =
a good<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D1 color=3Dnavy =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;
color:navy'>method</span></font></span><font size=3D1 color=3Dnavy =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;
color:navy'> after spending some time on it. Does everyone have better =
idea?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;col=
or:navy'>Allen<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial;col=
or:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>-----Original
Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b> SIVAKUMAR =
SUBRAMANI
[mailto:sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org<span class=3DGramE>] <br>
<b><span style=3D'font-weight:bold'>Sent</span></b></span><b><span
style=3D'font-weight:bold'>:</span></b> </span></font><st1:date =
Month=3D"6" Day=3D"30"
Year=3D"2003"><font size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;
 font-family:Tahoma'>Monday, June 30, =
2003</span></font></st1:date><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>
</span></font><st1:time Hour=3D"22" Minute=3D"5"><font size=3D2 =
face=3DTahoma><span
 lang=3DEN-US style=3D'font-size:10.0pt;font-family:Tahoma'>10:05 =
PM</span></font></st1:time><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'><br>
<b><span style=3D'font-weight:bold'>To:</span></b> David Woodhouse<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> Yaroslav Rastrigin; =
ACPI-Devel
mailing list<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: [ACPI] =
System
poweroff</span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Yes, Your right. I
need exactly the same thing, just a kernel module that helps me to =
shutdown my
PC. Since I am not using laptop, I am not much worried about the power =
saving.
I just want to do a complete poweroff, while I issue a poweroff =
command. <o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Let me&nbsp;try out
the Reverse engineering policy to&nbsp;write a kernel module that just =
helps me
to power-off the system with out having the support of apm in the =
kernel.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:24.0pt;mso-para-margin-left:2.=
0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Any help with regard
to this are welcomed.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Thanks,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Siva<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;mso-para-margin-left:2.0gd'><font
size=3D3 face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<blockquote =
style=3D'margin-top:5.0pt;margin-right:0cm;margin-bottom:5.0pt'>

<div>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0cm;margin-right:0cm;margin-bottom:
12.0pt;margin-left:24.0pt;mso-margin-top-alt:0cm;mso-para-margin-right:0=
cm;
mso-para-margin-bottom:12.0pt;mso-para-margin-left:2.0gd'><font =
size=3D2
face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:10.0pt'>-----Original Message----- <br>
<b><span style=3D'font-weight:bold'>From:</span></b> David Woodhouse
[mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Mon 6/30/2003 6:08 =
PM <br>
<b><span style=3D'font-weight:bold'>To:</span></b> SIVAKUMAR SUBRAMANI =
<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> Yaroslav Rastrigin; =
ACPI-Devel
mailing list <br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: [ACPI] =
System
poweroff</span></font><span lang=3DEN-US><o:p></o:p></span></p>

</div>

<p =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0cm;margin-bottom:12.0pt;=

margin-left:24.0pt;mso-margin-top-alt:5.0pt;mso-para-margin-right:0cm;
mso-para-margin-bottom:12.0pt;mso-para-margin-left:2.0gd'><font =
size=3D2
face=3D=E6=96=B0=E7=B4=B0=E6=98=8E=E9=AB=94><span lang=3DEN-US =
style=3D'font-size:10.0pt'>On Mon, 2003-06-30 at
13:21, siva wrote:<br>
&gt; Hi.<br>
&gt;<br>
&gt; Thanks for the reply.<br>
&gt;<br>
&gt; I do not want to use all the features of the APM (such suspend =
states)
...I<br>
&gt; just want to use the feature of powering off the system completely =
while
run<br>
&gt; the &quot;poweroff / halt -p&quot; commands.<br>
&gt; So it is possible to do this without enabling the APM /ACPI, just =
by
adding<br>
&gt; some lines of code in the Kernel.<br>
<br>
Yes, you can do this if you really want to, but you need sufficient<br>
documentation for your motherboard and chipset. You need to work out =
how<br>
to make it tell the PSU to turn itself off.<br>
<br>
You may be able to work this out by reverse-engineering the APM BIOS =
or<br>
ACPI bytecode. There's nothing _special_ about them that makes them =
able<br>
to turn the machine off -- they're only software, it's just that =
they're<br>
binary-only software to which we don't have the source.<br>
<br>
There's no fundamental reason why you shouldn't be able to write a<br>
proper Linux driver; it's just that like so many other things with =
only<br>
binary-only driver code, we don't seem to be able to get sufficient<br>
documentation for it.<br>
<br>
--<br>
dwmw2</span></font><span lang=3DEN-US><o:p></o:p></span></p>

</blockquote>

</div>

</body>

</html>
N=18HS^=E9=9A=8A[){([Zzn=E8=A5=B4=044D=D7=ACw%=D8=A76i=17l=11&x+ljwEjzz0=
=0E'Z=C9=A9z{^0v\=13bJ=DB=9DDN=1Bm=DA=B2=DE=B5brK&
?=C6=B4]4N=DD=8AZ:m7_=07)=D7=AFzYXX=07)=D7=AFzYb,y+=DE=B6=1Bm+-.=C7=9F=1E=
=7F+-b=D8=A7~rz
------_=_NextPart_001_01C33FAD.4AAF4B40--

--------------InterScan_NT_MIME_Boundary--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
