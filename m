From: Michael Yaroslavtsev <MichaelY-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: "Bridge swizzle"
Date: Mon, 4 Aug 2003 18:49:21 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7998152F80A79647BAEB131894F19FB1035BFB5F@mail-sc-1.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C35AF3.CA4D6B50"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C35AF3.CA4D6B50
Content-Type: text/plain

Hi,
I am looking at acpi_pci_irq_derive()
(linux-2.4.21/drivers/acpi/pci_irq.c:273-) and I think I have an issue with
this "bridge swizzle" thing.

Here's my configuration:
I have an IOAPIC-hosted bus number 0xe with the base IRQ of 28.
In the slot 1 of the bus 0xe I have a PCI-PCI bridge. The secondary bus of
this bridge receives the number 0x0f.
In the "slot" 0 of the bus 0x0f I have a video controller, willing to
interrupt on its PIRQA# (pin 0).
Hence, the pin 0 of 0e:0:0 is wired to the system IRQ 29.

Here's what I see during the system startup:
I observe a progression of entries going through acpi_pci_irq_add_entry().
The bridge itself gets its pins 0-3 mapped respectively to system IRQ's
29-31,28. Naturally, my video device, which is behind the bridge, is not
among those _PRT entries.
Later, though, it appears at acpi_pci_irq_derive(), which in turn calls
acpi_pci_irq_lookup() with the following arguments:
segment = 0
bus = 0xe
device = 1
pin = 1,
which is wrong. Pin needs to be zero here.
I believe the line
	pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
in acpi_pci_irq_derive() is to blame. Possibly, I do not see the full
picture, but I think, at least on the first pass of the embracing while()
loop, "pin" needs to be left alone.
As a result, my video controller becomes mapped to the system IRQ 30, i.e.
off by 1. If, on the other hand, I stop in the debugger and at the entry to
acpi_pci_irq_lookup() manually change "pin" to be zero, everything comes up
beautifully.

Since I don't have a "full-time" ACPI interest, I thought, I didn't need to
subscribe to "acpi-devel" list, so, if anyone would like to respond, please
Cc: michaely-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org

Thank you for your attention,
-- Michael

------_=_NextPart_001_01C35AF3.CA4D6B50
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>&quot;Bridge swizzle&quot;</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I am looking at acpi_pci_irq_derive() =
(linux-2.4.21/drivers/acpi/pci_irq.c:273-) and I think I have an issue =
with this &quot;bridge swizzle&quot; thing.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's my configuration:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I have an IOAPIC-hosted bus number =
0xe with the base IRQ of 28.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">In the slot 1 of the bus 0xe I have a =
PCI-PCI bridge. The secondary bus of this bridge receives the number =
0x0f.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">In the &quot;slot&quot; 0 of the bus =
0x0f I have a video controller, willing to interrupt on its PIRQA# (pin =
0).</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Hence, the pin 0 of 0e:0:0 is wired =
to the system IRQ 29.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's what I see during the system =
startup:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I observe a progression of entries =
going through acpi_pci_irq_add_entry(). The bridge itself gets its pins =
0-3 mapped respectively to system IRQ's 29-31,28. Naturally, my video =
device, which is behind the bridge, is not among those _PRT =
entries.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Later, though, it appears at =
acpi_pci_irq_derive(), which in turn calls acpi_pci_irq_lookup() with =
the following arguments:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">segment =3D 0</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">bus =3D 0xe</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">device =3D 1</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">pin =3D 1,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">which is wrong. Pin needs to be zero =
here.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I believe the line</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">pin =3D (pin + PCI_SLOT(bridge-&gt;devfn)) % 4;</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">in acpi_pci_irq_derive() is to blame. =
Possibly, I do not see the full picture, but I think, at least on the =
first pass of the embracing while() loop, &quot;pin&quot; needs to be =
left alone.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">As a result, my video controller =
becomes mapped to the system IRQ 30, i.e. off by 1. If, on the other =
hand, I stop in the debugger and at the entry to acpi_pci_irq_lookup() =
manually change &quot;pin&quot; to be zero, everything comes up =
beautifully.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Since I don't have a =
&quot;full-time&quot; ACPI interest, I thought, I didn't need to =
subscribe to &quot;acpi-devel&quot; list, so, if anyone would like to =
respond, please Cc: michaely-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thank you for your attention,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">-- Michael</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C35AF3.CA4D6B50--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
