From: "Nils Spengler" <nils.spengler-Mmb7MZpHnFY@public.gmane.org>
Subject: problems with acpi (sleep states) on vaio notebook z1sp
Date: Mon, 22 Dec 2003 03:17:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1AYFdZ-0001a3-38@sc8-sf-mx1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C3C83A.1AC3E510"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

------=_NextPart_000_0000_01C3C83A.1AC3E510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi there,

 

i've read now ~5 hours the posts of vaio problems in this mailing list. All
have (nearly) the same problems but i never could find a solution.

I also have the problem that when i echo 3 > /proc/acpi/sleep it suspends
but will never wake up again. The (normally green) power led flashes red but
when i re-press a button on the keyboard or the power button, the power led
turns back into green, the battery led turns on but thats it. The hdd and
the screen keeps off. I have to remove ac adaptor and battery before i can
bring it to live again. Pressing the power button a few seconds does not
work.

 

I put dsdt and dmesg output on some crappy webspace so maybe this does help
anyone to help me.

 

http://de.geocities.com/nils_z1sp/dmesg.gz and
http://de.geocities.com/nils_z1sp/dsdt.gz

 

i also played a little bit around with dsdt and iasl but i think, i'm not
enough into that matter to do the necessary changes.

 

 

Thanks in advance and greets,

nils


------=_NextPart_000_0000_01C3C83A.1AC3E510
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
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
span.E-MailFormatvorlage17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi there,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>i&#8217;ve read now ~5 hours the posts of vaio =
problems in
this mailing list. All have (nearly) the same problems but i never could =
find a
solution.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I also have the problem that when i echo 3 &gt;
/proc/acpi/sleep it suspends but will never wake up again. The (normally =
green)
power led flashes red but when i re-press a button on the keyboard or =
the power
button, the power led turns back into green, the battery led turns on =
but thats
it. The hdd and the screen keeps off. I have to remove ac adaptor and =
battery
before i can bring it to live again. Pressing the power button a few =
seconds
does not work.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I put dsdt and dmesg output on some crappy webspace =
so maybe
this does help anyone to help me.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"http://de.geocities.com/nils_z1sp/dmesg.gz">http://de.geocities.c=
om/nils_z1sp/dmesg.gz</a>
and <a =
href=3D"http://de.geocities.com/nils_z1sp/dsdt.gz">http://de.geocities.co=
m/nils_z1sp/dsdt.gz</a></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>i also played a little bit around with dsdt and iasl =
but i
think, i&#8217;m not enough into that matter to do the necessary =
changes.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance and greets,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>nils</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C3C83A.1AC3E510--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
