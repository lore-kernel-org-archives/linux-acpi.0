From: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Subject: Compaq presario 2556EU
Date: Mon, 23 Aug 2004 08:52:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408230852.48290.hp@syntomax.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/QZKBx7FByTJw1v"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--Boundary-00=_/QZKBx7FByTJw1v
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hey all!

I've been playing around trying to get S1/S3 state to work on my laptop, but 
so far I've been unsuccesful.

Well first of all: the hardware :) attached is the output of lspci -vv, I've 
got the latest BIOS rev for the machine. Beware: this thing has an ATI 
IGP340M video card, I know that's a whole problem all by himself :)

well, S1 state:
if I echo -n standby > /sys/power/state I get a message in syslog:
PM: Preparing system for suspend
Stopping tasks: 
=============================================================================|
Restarting tasks... done

which is OK I guess, but it never actually goes to standby (or only for half a 
second, depending on your point of view I guess :)) I haven't been able to 
change this behaviour, booting in single-user mode, or anything doesn't 
change this??

S3 state:
I've tried to do everything I could find on the mailing lists, in 
Documentation/power/tricks.txt and Documentation/power/video.txt.
I've tried this with kernel versions 2.6.7 and 2.6.8.1 with and without the 
acpi patches from acpi.sf.net, doesn't make a lick of difference.
I've also tried with acpi=noirc pci=noacpi acpi_sleep=s3_mode 
acpi_sleep=s3_bios (and all possible combinations of those) tried various 
apic settings off,on and whatever I could find in kernel-parameters.txt
with or without device drivers loaded, with a kernel whith no hardware support 
other than what's needed to get the thing booting (+acpi) in single user mode 
and with init=/bin/bash 

Well, suspending seems to go fine, but the resuming is where things start to 
go wrong :) the system enters the state in a normal way, stopping tasks, 
entering state etc. and the power led starts to glow (or blink what you want 
to call it)

As soon as I press the power button again, the power led lights up again, and 
the led behind my power button lights up again to, my keyboard leds flash, 
and I get a second or something of HDD activity. After that, nothing. My 
keyboard leds (IE capslock) won't work anymore, and I can't get any hdd 
activity (I tried typing in hdparm -t /dev/hda to get some) 
I've got no networking (if I enable that, which doesn't seem to matter for the 
overall effect) 

The thing's a brick basically :)

I've also tried the following advanced script :)
#!/bin/bash
echo mem > /sys/power/state
touch isitworking

well, no "isitworking"

One other weird thing I noticed is that as soon as I press the power button 
and keep hitting the capslock key frantically it keeps responding for about 5 
seconds until it's stuck in the state that it's in (ie if it crashes with the 
caps lock led on, it stays on, and vice versa)

well, that's all the information I can give you at the moment, because I don't 
have a serial port on this thing :( so I can't have a serial console to debug 
the thing.

if there's more info I can give you do tell :)

thanks in advance!

-Hein-Pieter van Braam

--Boundary-00=_/QZKBx7FByTJw1v
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device cbb2 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d0009000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1400 [size=256]
	Capabilities: <available only to root>

0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: d0200000-d02ff000 (prefetchable)
	Memory window 1: d0100000-d01ff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 2000 [size=32]
	Capabilities: <available only to root>

0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 2020 [size=32]
	Capabilities: <available only to root>

0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d0003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0003800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 2040 [size=16]
	Capabilities: <available only to root>

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at d0008000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


--Boundary-00=_/QZKBx7FByTJw1v--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
