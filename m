From: "Zi Zhou" <Zi.Zhou-IrU4XInhIXM@public.gmane.org>
Subject: ACPI / PME problem
Date: Wed, 11 May 2005 19:01:57 -0700
Message-ID: <77E1AF913E974E478B1B2396A869A8354191B8@fcexmb03.efi.internal>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55696.938A24F7"
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

------_=_NextPart_001_01C55696.938A24F7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I have an in-house designed ASIC which requires PCI PowerManager =
Capability
bits PME_Status and PME_En to be reset before ACPI does Interrupt =
routing(We
use PIC due to BIOS limitation), otherwise system will hang after kernel
message "ACPI: Using PIC for interrupt routing". It actually loop =
forever
complaining "acpi_bus-0077 [04] acpi_bus_get_device   : No context for =
object
[xxxxxxxx]  " The objects belong to some PCI IRQ table=20

=20

My BIOS is not smart enough to reset these bits at this moment. I prefer =
to
do it in linux kernel. But I found that I hit the problem point so early =
in
the kernel boot stage that pci_devices are not scanned and gathered =
together
yet(basically pci_devices is still empty), which makes it very difficult =
to
access pci configure space if it's possible at all.=20

=20

My question is: Should this be done in BIOS or there is way to do it in =
the
kernel?

=20

Thanks very much for your advice !

=20

Zi


------_=_NextPart_001_01C55696.938A24F7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";}
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
	{color:navy;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dnavy>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I have an in-house designed ASIC which requires PCI =
PowerManager
Capability bits PME_Status and PME_En to be reset before ACPI does =
Interrupt
routing(We use PIC due to BIOS limitation), otherwise system will hang =
after
kernel message &quot;ACPI: Using PIC for interrupt routing&quot;. It =
actually
loop forever complaining &quot;acpi_bus-0077 [04] =
acpi_bus_get_device=A0=A0 : No
context for object [xxxxxxxx]=A0 &quot; The objects belong to some PCI =
IRQ table </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>My BIOS is not smart enough to reset these bits at =
this
moment. I prefer to do it in linux kernel. But I found that I hit the =
problem
point so early in the kernel boot stage that pci_devices are not scanned =
and
gathered together yet(basically pci_devices is still empty), which makes =
it
very difficult to access pci configure space if it's possible at all. =
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>My question is: Should this be done in BIOS or there =
is way
to do it in the kernel?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Thanks very much for your advice !</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Zi</span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C55696.938A24F7--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
