From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IBM Thinkpad T23
Date: Mon, 12 May 2003 16:46:49 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722F7@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C31863.06D36A0A"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jayan Krishnaswami <jkrishna-PjAqaU27lzQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C31863.06D36A0A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I hope you file this issue on bugzilla.kernel.org.
Also you should tell us how to reproduce the problem.
=20
Thanks,
Luming
=20
=20
-----Original Message-----
From: Jayan Krishnaswami [mailto:jkrishna-PjAqaU27lzQ@public.gmane.org]
Sent: 2003?4?15? 4:52
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] IBM Thinkpad T23


Hi,
I have been trying to get ACPI working on the IBM Thinkpad T23.  I am =
using linux kernel 2.4.20 patched to 2.4.21-pre5 and also the =
corresponding acpi patch.  I have applied the ECDT patch so that the OS =
now replaces the ECDT during bootup.=20
Also, I commented out the        "if (ec_ecdt && ec_ecdt->uid =3D=3D =
uid) {...}"   block in acpi_ec_add() of ec.c.
All this has got me to a stage where I get all the directories in =
/proc/acpi.  However, the fan subdirectory is empty and the processor =
performance gives out:
=20
*P0 :  0 MHz  0mW, 500uS
P1  :  0 MHz, 0mW, 500uS
=20
although the processor supports speedstep.  Any ideas what might have =
gone wrong??
=20
Any help appreciated,
Jayan.=20
=20

------_=_NextPart_001_01C31863.06D36A0A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 6.00.2722.900" name=3DGENERATOR>
<META content=3D"Microsoft Word 10" name=3DOriginator><LINK=20
href=3D"cid:filelist.xml-RK/soAyvZNfFXfFrclmPhjRmByFHzeGd@public.gmane.org" rel=3DFile-List><!--[if gte =
mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<STYLE>@font-face {
	font-family: Courier;
}
@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in 1.25in; =
mso-header-margin: .5in; mso-footer-margin: .5in; mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
P {
	FONT-SIZE: 12pt; MARGIN-LEFT: 0in; MARGIN-RIGHT: 0in; FONT-FAMILY: =
"Times New Roman"; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"; mso-margin-top-alt: auto; =
mso-margin-bottom-alt: auto
}
PRE {
	FONT-SIZE: 10pt; MARGIN: 0in 0in 0pt; COLOR: black; FONT-FAMILY: =
Courier; mso-pagination: widow-orphan; mso-fareast-font-family: "Times =
New Roman"; tab-stops: 45.8pt 91.6pt 137.4pt 183.2pt 229.0pt 274.8pt =
320.6pt 366.4pt 412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2pt 687.0pt =
732.8pt; mso-bidi-font-family: "Courier New"
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-bidi-font-family: Arial; =
mso-style-type: personal-compose; mso-style-noshow: yes; =
mso-ansi-font-size: 10.0pt; mso-bidi-font-size: 10.0pt; =
mso-ascii-font-family: Arial; mso-hansi-font-family: Arial
}
SPAN.SpellE {
	mso-style-name: ""; mso-spl-e: yes
}
SPAN.GramE {
	mso-style-name: ""; mso-gram-e: yes
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US style=3D"tab-interval: .5in" vLink=3Dpurple =
link=3Dblue>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN =
class=3D757563808-12052003>I hope=20
you file this issue on bugzilla.kernel.org.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN =
class=3D757563808-12052003>Also you=20
should tell us how to reproduce the problem.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN=20
class=3D757563808-12052003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN=20
class=3D757563808-12052003>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN=20
class=3D757563808-12052003>Luming</SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN=20
class=3D757563808-12052003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#0000ff size=3D2><SPAN=20
class=3D757563808-12052003></SPAN></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Jayan Krishnaswami =

  [mailto:jkrishna-PjAqaU27lzQ@public.gmane.org]<BR><B>Sent:</B> =
2003&#24180;4&#26376;15&#26085; 4:52<BR><B>To:</B>=20
  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> [ACPI] IBM =
Thinkpad=20
  T23<BR><BR></FONT></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Hi,<o:p></o:p></SPAN></FONT></P><PRE><FONT face=3DArial =
color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">I have been trying to get ACPI working on the IBM <SPAN =
class=3DSpellE>Thinkpad</SPAN> T23.<SPAN style=3D"mso-spacerun: =
yes">&nbsp; </SPAN>I am using <SPAN class=3DSpellE>linux</SPAN> kernel =
2.4.20 patched to 2.4.21-pre5 and also the corresponding acpi =
patch.<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>I have applied the =
ECDT patch so that the OS now replaces the ECDT during <SPAN =
class=3DSpellE>bootup</SPAN>. <o:p></o:p></SPAN></FONT></PRE><PRE><FONT =
face=3DArial color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; =
FONT-FAMILY: Arial">Also, I commented out the<SPAN =
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></FONT>"if (<SPAN class=3DSpellE>ec_ecdt</SPAN> &amp;&amp; =
<SPAN class=3DSpellE>ec_ecdt</SPAN>-&gt;<SPAN class=3DSpellE>uid</SPAN> =
=3D=3D <SPAN class=3DSpellE>uid</SPAN>) {...}"<SPAN =
style=3D"mso-spacerun: yes">&nbsp; </SPAN><SPAN style=3D"mso-spacerun: =
yes">&nbsp;</SPAN><FONT face=3DArial><SPAN style=3D"FONT-FAMILY: =
Arial">block</SPAN></FONT> <FONT face=3DArial><SPAN =
style=3D"FONT-FAMILY: Arial">in <SPAN class=3DSpellE>acpi_ec_<SPAN =
class=3DGramE>add</SPAN></SPAN><SPAN class=3DGramE>(</SPAN>) of <SPAN =
class=3DSpellE>ec.c</SPAN></SPAN></FONT>.<o:p></o:p></PRE><PRE><FONT =
face=3DArial color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; =
FONT-FAMILY: Arial">All this has got me to a stage where I get all the =
directories in /proc/acpi.<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>However, the fan subdirectory is empty and the processor =
performance gives out:<o:p></o:p></SPAN></FONT></PRE><PRE><FONT =
face=3DArial color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; =
FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></FONT></PRE><PRE><FONT =
face=3DArial color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; =
FONT-FAMILY: Arial">*<SPAN class=3DGramE>P0 :</SPAN><SPAN =
style=3D"mso-spacerun: yes">&nbsp; </SPAN>0 MHz<SPAN =
style=3D"mso-spacerun: yes">&nbsp; </SPAN>0mW, =
500uS<o:p></o:p></SPAN></FONT></PRE><PRE><SPAN class=3DGramE><FONT =
face=3DArial color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; =
FONT-FAMILY: Arial">P1<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>:</SPAN></FONT></SPAN><FONT face=3DArial><SPAN =
style=3D"FONT-FAMILY: Arial"> <SPAN style=3D"mso-spacerun: =
yes">&nbsp;</SPAN>0 MHz, 0mW, =
500uS<o:p></o:p></SPAN></FONT></PRE><PRE><FONT face=3DArial =
color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></PRE><PRE><SPAN =
class=3DGramE><FONT face=3DArial color=3Dblack size=3D2><SPAN =
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">although</SPAN></FONT></SPAN><FONT face=3DArial><SPAN =
style=3D"FONT-FAMILY: Arial"> the processor supports <SPAN =
class=3DSpellE>speedstep</SPAN>.<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>Any ideas what might have gone =
wrong??<o:p></o:p></SPAN></FONT></PRE><PRE><FONT face=3DArial =
color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></PRE><PRE><FONT face=3DArial =
color=3Dblack size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Any help appreciated,<o:p></o:p></SPAN></FONT></PRE><PRE><SPAN =
class=3DGramE><FONT face=3DArial color=3Dblack size=3D2><SPAN =
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Jayan.</SPAN></FONT></SPAN><FONT face=3DArial><SPAN =
style=3D"FONT-FAMILY: Arial; mso-no-proof: yes"> </SPAN></FONT><FONT =
face=3DArial><SPAN style=3D"FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></PRE>
  <P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=20
  style=3D"FONT-SIZE: =
12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML=
>

------_=_NextPart_001_01C31863.06D36A0A--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
