From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RC440BX won't poweroff/shutdown
Date: Mon, 13 Jun 2005 14:58:05 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3003816356@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57049.D4F5DC13"
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
To: ajh <ajhindle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57049.D4F5DC13
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The reset may actually be a crash.
=20
Does this happen only with FC3, or does it also happen with
the latest kernel.org kernel?  If yes, what is the latest kernel
where it did NOT happen?
=20
It would be interesting if you find some boot parameters that make the
symptom
go away, that may be a hint.  maxcpus=3D1, and "nolapic" come to mind.
=20
You can put an infinite loop in the powerdown code
to see if you can change the reset into a hang --
then move the loop later and later until you find
where the access that causes the reset.
Start with acpi_power_off() in drivers/acpi/sleep/poweroff.c
=20
cheers,
-Len
=20
ps. please always include complete dmesg, not just grepped version.


________________________________

	From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of ajh
	Sent: Monday, June 13, 2005 5:04 AM
	To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
	Subject: [ACPI] RC440BX won't poweroff/shutdown
=09
=09
=09
=09
	Hi
	=20
	I have installed FC3 on a PC bought in 1999. It has an Intel
RC440BX chipset. When I use the commands "shutdown now -h" or
"poweroff", the PC reboots rather than shutting down. I am forcing ACPI
use because it is a pre 2001 chipset - see dmesg below.=20
	=20
	I see that the Seattle 440BX chipset is on the ACPI4Linux
"blacklist" but my machine (which is probably similar) doesn't show any
error messages when closing or booting - it just reboots when asked to
shutdown. I hope someone can help. Cheers
	=20
	"dmesg | grep ACPI" shows this:
	=20
	=20
	 BIOS-e820: 0000000013fe0000 - 0000000013ff8000 (ACPI data)
	 BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
	ACPI: RSDP (v000 AMI                                   ) @
0x000fa7a0
	ACPI: RSDT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @
0x13ff0000
	ACPI: FADT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @
0x13ff1000
	ACPI: DSDT (v001 INTEL  RC440BXA 0x00001000 MSFT 0x0100000a) @
0x00000000
	ACPI: BIOS age (1999) fails cutoff (2001), acpi=3Dforce is
required to enable ACPI
	ACPI: acpi=3Dforce override
	ACPI: PM-Timer IO Port: 0x408
	ACPI: IRQ9 SCI: Level Trigger.
	ACPI: Subsystem revision 20040816
	ACPI: Interpreter enabled
	ACPI: Using PIC for interrupt routing
	ACPI: PCI Root Bridge [PCI0] (00:00)
	ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
	ACPI: Power Resource [URP1] (off)
	ACPI: Power Resource [URP2] (off)
	ACPI: Power Resource [FDDP] (off)
	ACPI: Power Resource [LPTP] (off)
	ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14
15)
	ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14
15)
	ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14
15) *0, disabled.
	ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14
15)
	ACPI: Power Resource [GFAN] (off)
	PCI: Using ACPI for IRQ routing
	ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
	ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) ->
IRQ 10
	ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
	ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ
9
	ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
	ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) ->
IRQ 11
	ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) ->
IRQ 10
	ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) ->
IRQ 11
	apm: overridden by ACPI.
	ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
	ACPI: (supports S0 S1 S5)
	ACPI wakeup devices:=20
	ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) ->
IRQ 10
	ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) ->
IRQ 11
	ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ
9
	ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) ->
IRQ 10
	ACPI: Power Button (FF) [PWRF]
	ACPI: Sleep Button (CM) [SLPB]


------_=_NextPart_001_01C57049.D4F5DC13
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1492" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The reset may actually be a =
crash.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D601403418-13062005></SPAN><SPAN=20
class=3D601403418-13062005><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Does this happen only with FC3, or does it also =
happen=20
with</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>the latest kernel.org kernel?&nbsp; If yes, =
what is the=20
latest kernel</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>where it did NOT happen?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>It would be interesting if you find some boot =
parameters=20
that make the symptom</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>go away, that may be a hint.&nbsp; maxcpus=3D1, =
and "nolapic"=20
come to mind.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>You can put an infinite loop in the powerdown=20
code</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>to see if you can change the reset into a hang=20
--</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>then move the loop later and later until you=20
find</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>where the access that causes the =
reset.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Start with acpi_power_off() in=20
drivers/acpi/sleep/poweroff.c</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>cheers,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>-Len</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>ps. please always include complete dmesg, not =
just grepped=20
version.</FONT></SPAN></DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> =
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
  [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] <B>On Behalf Of=20
  </B>ajh<BR><B>Sent:</B> Monday, June 13, 2005 5:04 AM<BR><B>To:</B>=20
  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> [ACPI] RC440BX =
won't=20
  poweroff/shutdown<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV><FONT face=3DArial size=3D2>
  <DIV><FONT face=3DArial size=3D2>
  <DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I have installed FC3 on a PC bought =
in 1999. It=20
  has an Intel RC440BX chipset. When I use the commands "shutdown now =
-h" or=20
  "poweroff", the PC reboots rather than shutting down. I am forcing =
ACPI use=20
  because it is a pre 2001 chipset - see dmesg below. </FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I see that the Seattle 440BX chipset =
is on the=20
  ACPI4Linux "blacklist" but my machine (which is probably similar) =
doesn't show=20
  any error messages when closing or booting&nbsp;- it just reboots when =
asked=20
  to shutdown. I hope someone can help. Cheers</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>"dmesg | grep ACPI" shows =
this:</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>&nbsp;BIOS-e820: 0000000013fe0000 -=20
  0000000013ff8000 (ACPI data)<BR>&nbsp;BIOS-e820: 0000000013ff8000 -=20
  0000000014000000 (ACPI NVS)<BR>ACPI: RSDP (v000=20
  =
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  ) @ 0x000fa7a0<BR>ACPI: RSDT (v001 INTEL&nbsp; RC440BXA 0x19990305 =
AMI&nbsp;=20
  0x00000097) @ 0x13ff0000<BR>ACPI: FADT (v001 INTEL&nbsp; RC440BXA =
0x19990305=20
  AMI&nbsp; 0x00000097) @ 0x13ff1000<BR>ACPI: DSDT (v001 INTEL&nbsp; =
RC440BXA=20
  0x00001000 MSFT 0x0100000a) @ 0x00000000<BR>ACPI: BIOS age (1999) =
fails cutoff=20
  (2001), acpi=3Dforce is required to enable ACPI<BR>ACPI: acpi=3Dforce=20
  override<BR>ACPI: PM-Timer IO Port: 0x408<BR>ACPI: IRQ9 SCI: Level=20
  Trigger.<BR>ACPI: Subsystem revision 20040816<BR>ACPI: Interpreter=20
  enabled<BR>ACPI: Using PIC for interrupt routing<BR>ACPI: PCI Root =
Bridge=20
  [PCI0] (00:00)<BR>ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0._PRT]<BR>ACPI:=20
  Power Resource [URP1] (off)<BR>ACPI: Power Resource [URP2] =
(off)<BR>ACPI:=20
  Power Resource [FDDP] (off)<BR>ACPI: Power Resource [LPTP] =
(off)<BR>ACPI: PCI=20
  Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)<BR>ACPI: PCI=20
  Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)<BR>ACPI: PCI=20
  Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.<BR>ACPI:=20
  PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)<BR>ACPI: =
Power=20
  Resource [GFAN] (off)<BR>PCI: Using ACPI for IRQ routing<BR>ACPI: PCI=20
  Interrupt Link [LNKD] enabled at IRQ 10<BR>ACPI: PCI interrupt =
0000:00:07.2[D]=20
  -&gt; GSI 10 (level, low) -&gt; IRQ 10<BR>ACPI: PCI Interrupt Link =
[LNKB]=20
  enabled at IRQ 9<BR>ACPI: PCI interrupt 0000:00:0c.0[A] -&gt; GSI 9 =
(level,=20
  low) -&gt; IRQ 9<BR>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ =
11<BR>ACPI:=20
  PCI interrupt 0000:00:0d.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ =
11<BR>ACPI:=20
  PCI interrupt 0000:00:10.0[A] -&gt; GSI 10 (level, low) -&gt; IRQ =
10<BR>ACPI:=20
  PCI interrupt 0000:01:00.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ =
11<BR>apm:=20
  overridden by ACPI.<BR>ACPI: Processor [CPU1] (supports C1 C2, 8 =
throttling=20
  states)<BR>ACPI: (supports S0 S1 S5)<BR>ACPI wakeup devices: <BR>ACPI: =
PCI=20
  interrupt 0000:00:10.0[A] -&gt; GSI 10 (level, low) -&gt; IRQ =
10<BR>ACPI: PCI=20
  interrupt 0000:00:0d.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ =
11<BR>ACPI: PCI=20
  interrupt 0000:00:0c.0[A] -&gt; GSI 9 (level, low) -&gt; IRQ =
9<BR>ACPI: PCI=20
  interrupt 0000:00:07.2[D] -&gt; GSI 10 (level, low) -&gt; IRQ =
10<BR>ACPI:=20
  Power Button (FF) [PWRF]<BR>ACPI: Sleep Button (CM)=20
  =
[SLPB]</FONT></DIV></FONT></DIV></FONT></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C57049.D4F5DC13--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
