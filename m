From: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Subject: Handler for [EmbeddedControl] returned AE_TIME in 2.6.1/20040116
Date: Tue, 3 Feb 2004 12:24:13 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203172413.GA1299@joehill.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm using 2.6.1 with the latest ACPI patch (20040116). When I switch from
AC to battery or vice-versa, I get the following:

ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_TIME
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_.SMWR] (Node d7f24f80), AE_TIME
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.BAT1.CHBP] (Node d7f238e0), AE_TIME
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_.SMSL] (Node d7f24f40), AE_TIME
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_._Q09] (Node d7f24ea0), AE_TIME

After that, ACPI no longer gives accurate information about the battery
status (e.g., it will say "discharging" and a fixed amount of battery
life left regardless of how much it has charged since the switch).

Sometimes I get this error on boot up.

I haven't found much discussion of this error in google or on this list.

In case it is useful, I've attached ACPI boot up messages below.[0] Also
the results of lspci -vv. [1]

I'm also using force=acpi because the BIOS on my system (HP OmniBook 500)
is too old for ACPI to be recognized automatically.  HP has not released
any new BIOS for this system.

A couple of other problems perhaps worth mentioning: I can't resume from
suspend, either using the swsusp in 2.6.1 or the independent sourceforge
software suspend ("software suspend")--it hangs at "restoring pageset1."
Also, the kernel doesn't see the event of me pressing the sleep button,
although it does properly detected lid open and closed.

Any tips?
-- 
Adam Kessel
http://bostoncoop.net/adam

[0] 

BIOS-e820: 0000000017ff0000 - 0000000017fffc00 (ACPI data)
BIOS-e820: 0000000017fffc00 - 0000000018000000 (ACPI NVS)
ACPI: RSDP (v000 HP-MCD                                    ) @ 0x000f6c50
ACPI: RSDT (v001 HP-MCD FA RSDT  0x02700000  LTP 0x00000000) @ 0x17ff4e60
ACPI: FADT (v001 HP-MCD FA FACP  0x02700000 HP   0x01000000) @ 0x17ff4e8c
ACPI: BOOT (v001 PTLTD  FABFTBL$ 0x02700000  LTP 0x00000001) @ 0x17fffbd8
ACPI: DSDT (v001 HP-MCD FA DSDT  0x02700000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: root=/dev/hda2 ro acpi=force resume2=swap:/dev/hda3
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 0)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PFAN] (off)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 15
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Battery Slot [BAT3] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLP]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (33 C)
ACPI: (supports S0 S1 S3 S4 S5)

[1]

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1040 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 18400000-187ff000 (prefetchable)
	Memory window 1: 18800000-18bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus (rev 10)
	Subsystem: 3Com Corporation: Unknown device 6256
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 1250ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1080 [size=128]
	Region 1: Memory at f4000400 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0b.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 10)
	Subsystem: 3Com Corporation: Unknown device 6158
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1400 [disabled] [size=256]
	Region 1: Memory at f4000c00 (32-bit, non-prefetchable) [disabled] [size=256]
	Region 2: Memory at f4000800 (32-bit, non-prefetchable) [disabled] [size=128]
	Capabilities: <available only to root>

00:0d.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
	Subsystem: Hewlett-Packard Company: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at f4002000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: <available only to root>

00:11.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Hewlett-Packard Company: Unknown device 0011
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 1128 [size=8]
	Region 1: I/O ports at 1120 [size=4]
	Region 2: I/O ports at 1148 [size=8]
	Region 3: I/O ports at 1140 [size=4]
	Region 4: I/O ports at 1010 [size=16]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
