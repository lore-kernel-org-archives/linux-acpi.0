From: =?iso-8859-1?Q?Emilio_Mej=EDa_Fern=E1ndez_de_Velasco?= <emejia-XnAhQTnVLytMqUckJh7upg@public.gmane.org>
Subject: RE: ACPI freezes laptop
Date: Tue, 27 Apr 2004 21:45:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000601c42c90$3c42cca0$0301a8c0@portatil>
References: <1083093340.4855.31.camel@darkstar>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C42CA0.FFCB9CA0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1083093340.4855.31.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Cc: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C42CA0.FFCB9CA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Sergio,

I have also tried to compile the kernel without the thermal zone, but as
you say, it gets very hot, because the cpu fan doesn't start, in fact as
you recommended, I opened a ticket at bugzilla:

http://bugme.osdl.org/show_bug.cgi?id=3D2565

But so far I still have no solution. It's a little frustrating, isn't
it?

Hopefully some day I see some light.

=20

-----Mensaje original-----
De: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]=20
Enviado el: martes, 27 de abril de 2004 9:16 pm
Para: emejia-EkmVulN54Sk@public.gmane.org
Asunto: Re: ACPI freezes laptop

=20

I remember some guy do this but is a little risky, if your laptop be

very hot shutdownn, you have to be careful, but you can contribute with

your experience.

if you compile without thermal module ?=20

=20

regards, =20

=20

On Wed, 2004-04-21 at 15:39, Emilio Mejia Fernandez de Velasco wrote:

> Hello,

> I have compiled kernel 2.4.26, and also 2.6.5 with acpi, with the
.config file=20

> that you sent me, that is, taking care not to use APIC or SMP options,
but=20

> there was no luck.

> The computer freezes after some time. Here I send you one copy of the=20

> file /var/log/messages after the following proceedings:

>=20

> At 15:12:11, after booting with the new kernel 2.4.26, I unplug and
plug back=20

> the AC adapter, and so the computer is blocked. It doesn't respond to
the=20

> keyboard, so I have to reboot.

> At 15:29:28 the system reboots after fsck caused for the former hard
reboot.

> This time I try kernel 2.6.5 in order to check the behaivour when
plugging and=20

> unplugging the AC adapter:

> >From 15:29:37 to 15:41:17 I unplug and plug again several times -more
than 20=20

> times- the AC adapter to see if it blocks, but everything keeps alive,
until=20

> 15:41:17, then is the last time I'm able to check the file
/var/log/messages

> After this the system is again frozen, completely blocked.

>=20

> Can you please check the copy of /var/log/messages that I send
attached?

> So you can check the events around the refered times and see if it
tells you=20

> why it gets blocked.

> Thank you

>=20

>=20

> Emilio

--=20

S=E9rgio M. B.


------=_NextPart_000_0007_01C42CA0.FFCB9CA0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:12.0pt;
	font-family:"Times New Roman";}
h1
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:21.6pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:-21.6pt;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 69.6pt 70.85pt 69.6pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Hi Sergio,</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>I have also tried to compile the kernel =
without the
thermal zone, but as you say, it gets very hot, because the cpu fan =
doesn't
start, in fact as you recommended, I opened a ticket at =
bugzilla:</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><a =
href=3D"http://bugme.osdl.org/show_bug.cgi?id=3D2565">http://bugme.osdl.o=
rg/show_bug.cgi?id=3D2565</a></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>But so far I still have no solution. It's a =
little
frustrating, isn't it?</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Hopefully some day I see some =
light.</span></font></p>

<p class=3DMsoPlainText align=3Dleft style=3D'text-align:left'><font =
size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoPlainText align=3Dleft style=3D'text-align:left'><font =
size=3D2
face=3D"Courier New"><span style=3D'font-size:10.0pt'>-----Mensaje =
original-----<br>
De: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org] <br>
Enviado el: martes, 27 de abril de 2004 9:16 pm<br>
Para: emejia-EkmVulN54Sk@public.gmane.org<br>
Asunto: Re: ACPI freezes laptop</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I remember some guy do this but is a little risky, if your =
laptop be</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>very hot shutdownn, you have to be careful, but you can =
contribute with</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>your experience.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>if you compile without thermal module ? </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>regards,=A0 </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>On Wed, 2004-04-21 at 15:39, Emilio Mejia Fernandez de Velasco =
wrote:</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Hello,</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; I have compiled kernel 2.4.26, and also 2.6.5 with acpi, =
with the
.config file </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; that you sent me, that is, taking care not to use APIC or =
SMP
options, but </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; there was no luck.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; The computer freezes after some time. Here I send you one =
copy of
the </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; file /var/log/messages after the following =
proceedings:</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; At 15:12:11, after booting with the new kernel 2.4.26, I =
unplug
and plug back </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; the AC adapter, and so the computer is blocked. It doesn't =
respond
to the </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; keyboard, so I have to reboot.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; At 15:29:28 the system reboots after fsck caused for the =
former
hard reboot.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; This time I try kernel 2.6.5 in order to check the =
behaivour when
plugging and </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; unplugging the AC adapter:</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; &gt;From 15:29:37 to 15:41:17 I unplug and plug again =
several
times -more than 20 </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; times- the AC adapter to see if it blocks, but everything =
keeps
alive, until </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; 15:41:17, then is the last time I'm able to check the file
/var/log/messages</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; After this the system is again frozen, completely =
blocked.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Can you please check the copy of /var/log/messages that I =
send
attached?</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; So you can check the events around the refered times and =
see if it
tells you </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; why it gets blocked.</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Thank you</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Emilio</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-- </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>S=E9rgio M. B.</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0007_01C42CA0.FFCB9CA0--



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
