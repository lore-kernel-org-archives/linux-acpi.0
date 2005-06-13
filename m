From: "ajh" <ajhindle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RC440BX won't poweroff/shutdown
Date: Mon, 13 Jun 2005 19:03:50 +1000
Message-ID: <BAY102-DAV182CA3CDB4BB1520A553A9C6F00@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004E_01C5704A.A248D4A0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

------=_NextPart_000_004E_01C5704A.A248D4A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I have installed FC3 on a PC bought in 1999. It has an Intel RC440BX =
chipset. When I use the commands "shutdown now -h" or "poweroff", the PC =
reboots rather than shutting down. I am forcing ACPI use because it is a =
pre 2001 chipset - see dmesg below.=20

I see that the Seattle 440BX chipset is on the ACPI4Linux "blacklist" =
but my machine (which is probably similar) doesn't show any error =
messages when closing or booting - it just reboots when asked to =
shutdown. I hope someone can help. Cheers

"dmesg | grep ACPI" shows this:


 BIOS-e820: 0000000013fe0000 - 0000000013ff8000 (ACPI data)
 BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa7a0
ACPI: RSDT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff0000
ACPI: FADT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff1000
ACPI: DSDT (v001 INTEL  RC440BXA 0x00001000 MSFT 0x0100000a) @ =
0x00000000
ACPI: BIOS age (1999) fails cutoff (2001), acpi=3Dforce is required to =
enable ACPI
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
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: Power Resource [GFAN] (off)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
apm: overridden by ACPI.
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
ACPI: (supports S0 S1 S5)
ACPI wakeup devices:=20
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
------=_NextPart_000_004E_01C5704A.A248D4A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have installed FC3 on a PC bought in =
1999. It has=20
an Intel RC440BX chipset. When I use the commands "shutdown now -h" or=20
"poweroff", the PC reboots rather than shutting down. I am forcing ACPI =
use=20
because it is a pre 2001 chipset - see dmesg below. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I see that the Seattle 440BX chipset is =
on the=20
ACPI4Linux "blacklist" but my machine (which is probably similar) =
doesn't show=20
any error messages when closing or booting&nbsp;- it just reboots when =
asked to=20
shutdown. I hope someone can help. Cheers</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>"dmesg | grep ACPI" shows =
this:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;BIOS-e820: 0000000013fe0000 -=20
0000000013ff8000 (ACPI data)<BR>&nbsp;BIOS-e820: 0000000013ff8000 -=20
0000000014000000 (ACPI NVS)<BR>ACPI: RSDP (v000=20
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
) @ 0x000fa7a0<BR>ACPI: RSDT (v001 INTEL&nbsp; RC440BXA 0x19990305 =
AMI&nbsp;=20
0x00000097) @ 0x13ff0000<BR>ACPI: FADT (v001 INTEL&nbsp; RC440BXA =
0x19990305=20
AMI&nbsp; 0x00000097) @ 0x13ff1000<BR>ACPI: DSDT (v001 INTEL&nbsp; =
RC440BXA=20
0x00001000 MSFT 0x0100000a) @ 0x00000000<BR>ACPI: BIOS age (1999) fails =
cutoff=20
(2001), acpi=3Dforce is required to enable ACPI<BR>ACPI: acpi=3Dforce=20
override<BR>ACPI: PM-Timer IO Port: 0x408<BR>ACPI: IRQ9 SCI: Level=20
Trigger.<BR>ACPI: Subsystem revision 20040816<BR>ACPI: Interpreter=20
enabled<BR>ACPI: Using PIC for interrupt routing<BR>ACPI: PCI Root =
Bridge [PCI0]=20
(00:00)<BR>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]<BR>ACPI: =
Power=20
Resource [URP1] (off)<BR>ACPI: Power Resource [URP2] (off)<BR>ACPI: =
Power=20
Resource [FDDP] (off)<BR>ACPI: Power Resource [LPTP] (off)<BR>ACPI: PCI=20
Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)<BR>ACPI: PCI =
Interrupt=20
Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)<BR>ACPI: PCI Interrupt =
Link=20
[LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.<BR>ACPI: PCI =
Interrupt=20
Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)<BR>ACPI: Power Resource =
[GFAN]=20
(off)<BR>PCI: Using ACPI for IRQ routing<BR>ACPI: PCI Interrupt Link =
[LNKD]=20
enabled at IRQ 10<BR>ACPI: PCI interrupt 0000:00:07.2[D] -&gt; GSI 10 =
(level,=20
low) -&gt; IRQ 10<BR>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ =
9<BR>ACPI:=20
PCI interrupt 0000:00:0c.0[A] -&gt; GSI 9 (level, low) -&gt; IRQ =
9<BR>ACPI: PCI=20
Interrupt Link [LNKA] enabled at IRQ 11<BR>ACPI: PCI interrupt =
0000:00:0d.0[A]=20
-&gt; GSI 11 (level, low) -&gt; IRQ 11<BR>ACPI: PCI interrupt =
0000:00:10.0[A]=20
-&gt; GSI 10 (level, low) -&gt; IRQ 10<BR>ACPI: PCI interrupt =
0000:01:00.0[A]=20
-&gt; GSI 11 (level, low) -&gt; IRQ 11<BR>apm: overridden by =
ACPI.<BR>ACPI:=20
Processor [CPU1] (supports C1 C2, 8 throttling states)<BR>ACPI: =
(supports S0 S1=20
S5)<BR>ACPI wakeup devices: <BR>ACPI: PCI interrupt 0000:00:10.0[A] =
-&gt; GSI 10=20
(level, low) -&gt; IRQ 10<BR>ACPI: PCI interrupt 0000:00:0d.0[A] -&gt; =
GSI 11=20
(level, low) -&gt; IRQ 11<BR>ACPI: PCI interrupt 0000:00:0c.0[A] -&gt; =
GSI 9=20
(level, low) -&gt; IRQ 9<BR>ACPI: PCI interrupt 0000:00:07.2[D] -&gt; =
GSI 10=20
(level, low) -&gt; IRQ 10<BR>ACPI: Power Button (FF) [PWRF]<BR>ACPI: =
Sleep=20
Button (CM) [SLPB]</FONT></DIV></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_004E_01C5704A.A248D4A0--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
