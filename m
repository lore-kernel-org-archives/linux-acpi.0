From: bruno <bruno.biagini-anva-Syd3ARw+vPY@public.gmane.org>
Subject: toshiba tecra 8100 problems with ACPI
Date: Thu, 3 Mar 2005 16:48:29 +0100
Message-ID: <200503031648.29509.bruno.biagini-anva@poste.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Dear all
I'm posting after having read different messages in such mailing list.
I know that I should try to read more but ... I promise you I'll continue to 
read.
While I continue in reading I would like to ask you for very quick answers 
(yes or no, wrong or right) to my question in order to understand if I'm 
going in the right directions to find a solution to my problem.

The problem is the following:

This are the messages I got from DMESG (regarding ACPI only):
BIOS-provided physical RAM map:
 ..........
 BIOS-e820: 00000000000e8640 - 00000000000e8840 (ACPI NVS)
 .........
 BIOS-e820: 0000000013fe0000 - 0000000013ff0000 (ACPI data)
.........

ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f4fd0
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0000
ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0054
ACPI: DSDT (v001 TOSHIB 8100     0x20000614 MSFT 0x0100000a) @ 0x00000000
Kernel command line: BOOT_IMAGE=Linux ro root=304
..........
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xfee03, last bus=21
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node 
c137d780), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node 
c137d880), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node 
c137d980), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node 
c137da80), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] 
(Node d3efef00), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] 
(Node d3efd220), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] 
(Node d3efd3a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] 
(Node d3efd480), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] 
(Node d3efd580), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKE._PRS] (Node 
c137dba0), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
PCI: No IRQ known for interrupt pin D of device 00:05.2
PCI: No IRQ known for interrupt pin A of device 00:07.0
PCI: No IRQ known for interrupt pin A of device 00:09.0
PCI: No IRQ known for interrupt pin A of device 00:0b.0 - using IRQ 255
PCI: No IRQ known for interrupt pin B of device 00:0b.1 - using IRQ 255
PCI: No IRQ known for interrupt pin A of device 00:0c.0
PCI: No IRQ known for interrupt pin A of device 01:00.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Limiting direct PCI/PCI transfers.
.............
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (57 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
.......................
PIIX4: IDE controller at PCI slot 00:05.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
.....
Intel ISA PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
PCI: Enabling device 00:0b.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 00:0b.0 - using IRQ 255
PCI: Enabling device 00:0b.1 (0000 -> 0002)
PCI: No IRQ known for interrupt pin B of device 00:0b.1 - using IRQ 255
Yenta ISA IRQ mask 0x0cb0, PCI irq 0
Socket status: 30000007
Yenta ISA IRQ mask 0x0cb0, PCI irq 0

It seems that my IRQ routing doesn't work and Linux reallocate IRQ and I/O in 
a wrong way really I have the situation:
- Or my yamaha PCI sound card works (even testing the sound alsa gave back a 
broken pipe)
- or my PCMCIA net card works (but not both together)

Using KDE In resources I do not see IRQ 3 (win 98 allocate IRQ3  to the ACPI 
IRQ handler and router), it does not exist neither in /proc/interrupts 8see 
cat /proc/interrupts) below:

 CPU0       
  0:     258211          XT-PIC  timer
  1:       7306          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:        244          XT-PIC  acpi
 11:      33655          XT-PIC  Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support, Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (#2), eth0, YMFPCI, usb-uhci
 12:      70403          XT-PIC  PS/2 Mouse
 14:      13371          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0 
ERR:          1
 
I disassembled my DSDT with iasl and recompiling it I got 38 warnings 0 errors 
0 remarks)
All the remarks were:
method CRS , 0 NotSerialized
Warning 2026 Reserved metod must return a value

same warning I got for PRS, STA and PSC
I used the workasround described in 
http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt
for a similar warning regardind WAK

">> dsdt.asl 134: Method(_WAK, 1) {
 >> Warning 2026 - ^ Reserved method must return a value (_WAK)
 
 You should probably add a "Return(Package(0x02){0x00, 0x00})" on a new 
 line just before the closing curly brace like so:
 
 Method(_WAK, 1) {
 ... ... ...
 Return(Package(0x02){0x00, 0x00})
 }"

I used such workaround for all my warnings (adding such line) then I 
recompiled the new dsdt.dsl and I got 0 errors, 0 warnings, 0 remarks but .

This is the story:
My question are:
Am I right with ACPI IRQ handler (it doesn't work because my DSDT is broken)?
the use of the workaround described for CRS, PRS, STA, PSC is correct or do I 
have to find a different solution studying the ACPI spec document?

please pardon me for the book I wrote but I was wondering if it would be 
possible to receive back a reply (also very short, it would be really 
appreciated :-) )

Many thanks to all
Bruno


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
