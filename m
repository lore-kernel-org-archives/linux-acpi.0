From: Allen_Lee-uiv9WLrdKoDQT0dZR+AlfA@public.gmane.org
Subject: USB ehci suspend and resume
Date: Fri, 13 Jun 2003 17:50:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CD08F83C0FFD554CBE4D42ABADAC140904A2A8@tpeex03>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--------------InterScan_NT_MIME_Boundary
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C33191.4746B120"

------_=_NextPart_001_01C33191.4746B120
Content-Type: text/plain

Dear all:
       My kernel is linux-2.4.20 and I want to make USB EHCI suspend from D0
to D3
and resume from D3 to D0. I follow the procedure of Intel data sheet
"29865602.pdf".
My test is as follow:
   My test hardware is a "USB hard disk"(USB 2.0 device)
TEST1
1.      mount /dev/sda1 /mnt/usb
2.      ehci D3
3.      ehci D0
4.      cp /mnt/usb/XXX /tmp/.
    After a few seconds, machine will hang
TEST2
1.      ehci D3
2.      ehci D0
3.      mount /dev/sda1 /mnt/usb
    it never mounts successfully.......
Does It seem that resume will have problem or not?
Does anyone have experience in this and can share something?
Best Regards,
Allen
 

------_=_NextPart_001_01C33191.4746B120
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml-SahjmwS9SCcyPJfAInSDEjRmByFHzeGd@public.gmane.org">
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
  <w:PunctuationKerning/>
  =
<w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEv=
ery>
  =
<w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>=

  <w:Compatibility>
   <w:SpaceForUL/>
   <w:BalanceSingleByteDoubleByteWidth/>
   <w:DoNotLeaveBackslashAlone/>
   <w:ULTrailSpace/>
   <w:DoNotExpandShiftReturn/>
   <w:AdjustLineHeightInTable/>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#26032;&#32048;&#26126;&#39636;;
	panose-1:2 2 3 0 0 0 0 0 0 0;
	mso-font-alt:PMingLiU;
	mso-font-charset:136;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:3 137232384 22 0 1048577 0;}
@font-face
	{font-family:"\@&#26032;&#32048;&#26126;&#39636;";
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
	mso-pagination:none;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:&#26032;&#32048;&#26126;&#39636;;
	mso-font-kerning:1.0pt;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:9.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-fareast-font-family:&#26032;&#32048;&#26126;&#39636;;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
 /* Page Definitions */
 @page
	{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:861864582;
	mso-list-type:hybrid;
	mso-list-template-ids:-1188033598 -86375298 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:18.0pt;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1
	{mso-list-id:1153714813;
	mso-list-type:hybrid;
	mso-list-template-ids:809908376 -1509362742 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:18.0pt;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:&#34920;&#26684;&#20839;&#25991;;
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
style=3D'tab-interval:24.0pt;text-justify-trim:
punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>Dear all:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>My kernel
is linux-2.4.20 and I want to make USB EHCI suspend from D0 to =
D3<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><span
class=3DGramE><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;
mso-bidi-font-size:10.0pt;font-family:Arial'>and</span></font></span><fo=
nt
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'> resume from D3 to D0. I follow the procedure =
of
Intel data sheet "29865602.pdf".<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>My test is as =
follow:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>My
test hardware is a "USB hard disk<span class=3DGramE>"(</span>USB 2.0 =
device)<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>TEST1<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l1 level1 =
lfo1;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>1.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>mo=
unt
/dev/sda1 /<span =
class=3DSpellE>mnt/usb</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l1 level1 =
lfo1;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>2.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span class=3DSpellE><font =
size=3D1
face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;
font-family:Arial'>ehci</span></font></span><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>
D3<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l1 level1 =
lfo1;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>3.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span class=3DSpellE><font =
size=3D1
face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;
font-family:Arial'>ehci</span></font></span><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>
D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l1 level1 =
lfo1;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>4.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span class=3DGramE><font =
size=3D1
face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;
font-family:Arial'>cp</span></font></span><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>
/<span class=3DSpellE>mnt/usb/XXX</span> /<span =
class=3DSpellE>tmp</span>/.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span>After a few seconds, machine will =
hang<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>TEST2<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo2;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>1.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span class=3DSpellE><font =
size=3D1
face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;
font-family:Arial'>ehci</span></font></span><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>
D3<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo2;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>2.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span class=3DSpellE><font =
size=3D1
face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;
font-family:Arial'>ehci</span></font></span><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>
D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:18.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo2;
tab-stops:list 18.0pt left 270.0pt;layout-grid-mode:char'><![if =
!supportLists]><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial;mso-fareast-font-family:Arial'><span =
style=3D'mso-list:
Ignore'>3.<font size=3D1 face=3D"Times New Roman"><span =
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'>mo=
unt
/dev/sda1 /<span =
class=3DSpellE>mnt/usb</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DGramE>it</span> never mounts =
successfully.......<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>Does It seem that resume will have problem or =
not?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>Does anyone have experience in this and can =
share
something?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>Best Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'tab-stops:270.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;mso-bidi-font-size:
10.0pt;font-family:Arial'>Allen<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;mso-bidi-font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></sp=
an></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C33191.4746B120--

--------------InterScan_NT_MIME_Boundary--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
