From: "Zhang, Kexin" <kexin.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: dock's dependent device
Date: Tue, 8 Nov 2005 21:00:42 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD50301AC20@pdsmsx404>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E464.6D5ACE9F"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5E464.6D5ACE9F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

My IBM T42's dsdt table includes 4 _EJD objects:

=20

Scope (\_SB.PCI0.USB0.URTH.UPDK)

    {   Name (_EJD, "_SB.PCI0.PCI1.DOCK")

    }

Scope (\_SB.PCI0.USB7.URTH.UPDK)

    {   Name (_EJD, "_SB.PCI0.PCI1.DOCK")

    }

Scope (\_SB.PCI0.LPC.FDC.FDD0)

    {   Name (_EJD, "_SB.PCI0.PCI1.DOCK")

    }

Scope (\_SB.PCI0.LPC.UART)

    {   Name (_EJD, "_SB.PCI0.PCI1.DOCK")

}

=20

I wonder what all these devices are? e.g. what device does \
_SB.PCI0.USB7.URTH.UPDK present, although I guess it's USB-like device,
but what specific meaning does URTH.UPDK have?

Secondly why are these devices dependent on Docking station?=20

=20

Thanks a lot.


------_=_NextPart_001_01C5E464.6D5ACE9F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>My IBM T42&#8217;s dsdt table includes 4 _EJD =
objects:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Scope
(\_SB.PCI0.USB0.URTH.UPDK)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
{&nbsp;&nbsp; Name (_EJD, =
&quot;_SB.PCI0.PCI1.DOCK&quot;)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Scope
(\_SB.PCI0.USB7.URTH.UPDK)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
{&nbsp;&nbsp; Name (_EJD, =
&quot;_SB.PCI0.PCI1.DOCK&quot;)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Scope
(\_SB.PCI0.LPC.FDC.FDD0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
{&nbsp;&nbsp; Name (_EJD, =
&quot;_SB.PCI0.PCI1.DOCK&quot;)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Scope
(\_SB.PCI0.LPC.UART)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;layout-grid-mode:char'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
{&nbsp;&nbsp; Name (_EJD, =
&quot;_SB.PCI0.PCI1.DOCK&quot;)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:18.0pt;
layout-grid-mode:char'><font size=3D2 face=3DArial><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial'>}<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><font
size=3D2 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:SimSun'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><font
size=3D2 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:SimSun'>I wonder what all these devices are? e.g. what =
device does \</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'> _SB.PCI0.USB7.URTH.UPDK
present, although I guess it&#8217;s USB-like device, but what specific =
meaning
does URTH.UPDK have?<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><font
size=3D2 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:SimSun'>Secondly why are these devices dependent on Docking
station? <o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><font
size=3D2 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:SimSun'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><font
size=3D2 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:SimSun'>Thanks a lot.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5E464.6D5ACE9F--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
