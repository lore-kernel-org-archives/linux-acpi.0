From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: patch for yenta + ACPI
Date: Thu, 4 Dec 2003 11:53:51 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FE18@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3BA1A.3AB30A4C"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3BA1A.3AB30A4C
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C3BA1A.3AB30A4C"


------_=_NextPart_002_01C3BA1A.3AB30A4C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

If you are suffering ACPI+yenta problem, please try this patch. In my
T40, one PCMCIA card slot can't work. It reported a call trace if I
enable it. This patch fixed my problem.

=20

Thanks,

Shaohua

=20


------_=_NextPart_002_01C3BA1A.3AB30A4C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If you are suffering ACPI+yenta problem, please try =
this
patch. In my T40, one PCMCIA card slot can&#8217;t work. It reported a =
call
trace if I enable it. This patch fixed my problem.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<div>

<div>

<div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Shaohua</span></font></p>

</div>

</div>

</div>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_002_01C3BA1A.3AB30A4C--

------_=_NextPart_001_01C3BA1A.3AB30A4C
Content-Type: application/octet-stream;
	name="pci_irq.patch"
Content-Transfer-Encoding: base64
Content-Description: pci_irq.patch
Content-Disposition: attachment;
	filename="pci_irq.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxMC9kcml2ZXJzL2FjcGkvcGNpX2lycS5jCTIwMDMtMTEtMjQg
MDk6MzE6NTIuMDAwMDAwMDAwICswODAwCisrKyBiL2RyaXZlcnMvYWNwaS9wY2lfaXJxLmMJMjAw
My0xMi0wNCAxMDo1OTozNi4yNzg0MTkxMjAgKzA4MDAKQEAgLTI4MSw2ICsyODEsNyBAQAogewog
CXN0cnVjdCBwY2lfZGV2CQkqYnJpZGdlID0gZGV2OwogCWludAkJCWlycSA9IDA7CisJdTgJCQli
cmlkZ2VfcGluID0gMDsKIAogCUFDUElfRlVOQ1RJT05fVFJBQ0UoImFjcGlfcGNpX2lycV9kZXJp
dmUiKTsKIApAQCAtMjk0LDYgKzI5NSwyMCBAQAogCXdoaWxlICghaXJxICYmIGJyaWRnZS0+YnVz
LT5zZWxmKSB7CiAJCXBpbiA9IChwaW4gKyBQQ0lfU0xPVChicmlkZ2UtPmRldmZuKSkgJSA0Owog
CQlicmlkZ2UgPSBicmlkZ2UtPmJ1cy0+c2VsZjsKKworCQlpZiAoKGJyaWRnZS0+Y2xhc3MgPj4g
OCkgPT0gUENJX0NMQVNTX0JSSURHRV9DQVJEQlVTKSB7CisJCQkvKiBQQyBjYXJkIGhhcyB0aGUg
c2FtZSBJUlEgYXMgaXRzIGNhcmRicmlkZ2UgKi8KKwkJCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGJy
aWRnZSwgUENJX0lOVEVSUlVQVF9QSU4sICZicmlkZ2VfcGluKTsKKwkJCWlmICghYnJpZGdlX3Bp
bikgeworCQkJCUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfSU5GTywgCisJCQkJCSJObyBpbnRl
cnJ1cHQgcGluIGNvbmZpZ3VyZWQgZm9yIGRldmljZSAlc1xuIiwgcGNpX25hbWUoYnJpZGdlKSkp
OworCQkJCXJldHVybl9WQUxVRSgwKTsKKwkJCX0KKwkJCS8qIFBpbiBpcyBmcm9tIDAgdG8gMyAq
LworCQkJYnJpZGdlX3Bpbi0tOworCQkJcGluID0gYnJpZGdlX3BpbjsKKwkJfQorCiAJCWlycSA9
IGFjcGlfcGNpX2lycV9sb29rdXAoYnJpZGdlLT5idXMsCiAJCQkJUENJX1NMT1QoYnJpZGdlLT5k
ZXZmbiksIHBpbik7CiAJfQo=

------_=_NextPart_001_01C3BA1A.3AB30A4C--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
