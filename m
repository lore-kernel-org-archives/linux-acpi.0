From: "Jayan Krishnaswami" <jkrishna-PjAqaU27lzQ@public.gmane.org>
Subject: IBM Thinkpad T23
Date: Mon, 14 Apr 2003 16:51:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001201c302c7$b01af510$0e02a8c0@WCLVTJ>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0013_01C302A6.29095510"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C302A6.29095510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
I have been trying to get ACPI working on the IBM Thinkpad T23.  I am
using linux kernel 2.4.20 patched to 2.4.21-pre5 and also the
corresponding acpi patch.  I have applied the ECDT patch so that the OS
now replaces the ECDT during bootup. 
Also, I commented out the        "if (ec_ecdt && ec_ecdt->uid == uid)
{...}"   block in acpi_ec_add() of ec.c.
All this has got me to a stage where I get all the directories in
/proc/acpi.  However, the fan subdirectory is empty and the processor
performance gives out:
 
*P0 :  0 MHz  0mW, 500uS
P1  :  0 MHz, 0mW, 500uS
 
although the processor supports speedstep.  Any ideas what might have
gone wrong??
 
Any help appreciated,
Jayan. 
 

------=_NextPart_000_0013_01C302A6.29095510
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml-RK/soAyvZNfFXfFrclmPhjRmByFHzeGd@public.gmane.org">
<!--[if gte mso 9]><xml>
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
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Courier;
	panose-1:2 7 4 9 2 2 5 2 4 4;
	mso-font-charset:0;
	mso-generic-font-family:modern;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:3 0 0 0 1 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
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
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:45.8pt 91.6pt 137.4pt 183.2pt 229.0pt 274.8pt 320.6pt 366.4pt =
412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2pt 687.0pt 732.8pt;
	font-size:10.0pt;
	font-family:Courier;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Courier New";
	color:black;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
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
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have been trying to get ACPI working on the IBM =
<span
class=3DSpellE>Thinkpad</span> T23.<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>I am using <span
class=3DSpellE>linux</span> kernel 2.4.20 patched to 2.4.21-pre5 and =
also the corresponding acpi patch.<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>I have applied the ECDT patch =
so that the OS now replaces the ECDT during <span
class=3DSpellE>bootup</span>. <o:p></o:p></span></font></pre><pre><font =
size=3D2
color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Also, I commented out =
the<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></font>&quot;if (<span
class=3DSpellE>ec_ecdt</span> &amp;&amp; <span =
class=3DSpellE>ec_ecdt</span>-&gt;<span
class=3DSpellE>uid</span> =3D=3D <span class=3DSpellE>uid</span>) =
{...}&quot;<span style=3D'mso-spacerun:yes'>&nbsp; </span><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><font
face=3DArial><span style=3D'font-family:Arial'>block</span></font> <font
face=3DArial><span style=3D'font-family:Arial'>in <span =
class=3DSpellE>acpi_ec_<span
class=3DGramE>add</span></span><span class=3DGramE>(</span>) of <span =
class=3DSpellE>ec.c</span></span></font>.<o:p></o:p></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>All this has got me to a =
stage where I get all the directories in /proc/acpi.<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>However, the fan subdirectory =
is empty and the processor performance gives =
out:<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>*<span
class=3DGramE>P0 :</span><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>0 MHz<span style=3D'mso-spacerun:yes'>&nbsp; </span>0mW, =
500uS<o:p></o:p></span></font></pre><pre><span
class=3DGramE><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>P1<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>:</span></font></span><font
face=3DArial><span style=3D'font-family:Arial'> <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>0 MHz, 0mW, =
500uS<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></pre><pre><span
class=3DGramE><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>although</span></font></span><font face=3DArial><span
style=3D'font-family:Arial'> the processor supports <span =
class=3DSpellE>speedstep</span>.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>Any ideas what might have gone =
wrong??<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></pre><pre><font
size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Any help =
appreciated,<o:p></o:p></span></font></pre><pre><span
class=3DGramE><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jayan.</span></font></span><font face=3DArial><span
style=3D'font-family:Arial;mso-no-proof:yes'> </span></font><font =
face=3DArial><span
style=3D'font-family:Arial'><o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0013_01C302A6.29095510--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
