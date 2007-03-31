From: Dominique Michel <dominique.michel@citycable.ch>
Subject: system freeze with acpi
Date: Sat, 31 Mar 2007 12:15:51 +0200
Message-ID: <20070331121551.2b9c5dce@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.110]:40656 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750735AbXCaMVx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2007 08:21:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Hi,

My whole system freeze from time to time when using acpi. I don't get this
problem without acpi. My motherboard is an asus P4S8X

 # cat /proc/version
Linux version 2.6.20-rt8 (root@localhost) (gcc version 4.1.1 (Gentoo 4.1.1-r3))
#1 SMP PREEMPT Fri Mar 30 23:15:59 CEST 2007

lspci -vvv:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 645xx (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8086
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64-
64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge
(AGP) (prog-if 00 [Normal decode]) Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF-
FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
64 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e7000000-e7ffffff
        Prefetchable memory behind bridge: ef700000-febfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR- BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset-
FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media IO]
(rev 04) Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 0

00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Interrupt: pin B routed
to IRQ 0 Region 4: I/O ports at e600 [size=32]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80
[Master]) Subsystem: ASUSTeK Computer Inc. Unknown device 8087
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 128
        Interrupt: pin ? routed to IRQ 16
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
[disabled] [size=8] Region 1: [virtual] Memory at 000003f0 (type 3,
non-prefetchable) [disabled] [size=1] Region 2: [virtual] Memory at 00000170
(32-bit, non-prefetchable) [disabled] [size=8] Region 3: [virtual] Memory at
00000370 (type 3, non-prefetchable) [disabled] [size=1] Region 4: I/O ports at
b400 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97
Sound Controller (rev a0) Subsystem: ASUSTeK Computer Inc. Unknown device 8096
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (13000ns
min, 2750ns max) Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at a400 [size=256]
        Region 1: I/O ports at a000 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
(rev 0f) (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device
8087 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (20000ns
max), Cache Line Size: 32 bytes Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
(rev 0f) (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device
8087 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (20000ns
max), Cache Line Size: 32 bytes Interrupt: pin B routed to IRQ 17
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
(rev 0f) (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device
8087 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (20000ns
max), Cache Line Size: 32 bytes Interrupt: pin C routed to IRQ 18
        Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
(prog-if 20 [EHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device 8087
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast
Ethernet (rev 91) Subsystem: ASUSTeK Computer Inc. Unknown device 80a7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (13000ns
min, 2750ns max) Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at ef6e0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs SB0240 Audigy 2 Platinum 6.1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (500ns min,
5000ns max) Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 9400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Audigy Game Port (rev 04)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32
        Region 0: I/O ports at 9000 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
(prog-if 10 [OHCI]) Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (500ns min,
1000ns max), Cache Line Size: 32 bytes Interrupt: pin B routed to IRQ 19
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e3800000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev 11) Subsystem: Scion Corporation Unknown device 0012
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (4000ns min,
10000ns max) Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ee800000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
11) Subsystem: Scion Corporation Unknown device 0012
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (1000ns min,
63750ns max) Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ee000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200]
(rev a3) (prog-if 00 [VGA]) Subsystem: Micro-Star International Co., Ltd.
Unknown device 8700 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64 (1250ns min,
250ns max) Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at ef7e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64-
64bit- FW- Rate=<none>

# cat /proc/interrupts
           CPU0       
  0:        283   IO-APIC-edge      timer
  1:        691   IO-APIC-edge      i8042
  6:          5   IO-APIC-edge      floppy
  7:          0   IO-APIC-edge      parport0
  8:          2   IO-APIC-edge      rtc
 12:          4   IO-APIC-edge      i8042
 14:      20344   IO-APIC-edge      ide0
 15:      24156   IO-APIC-edge      ide1
 17:        108   IO-APIC-fasteoi   ohci_hcd:usb2
 18:          1   IO-APIC-fasteoi   ohci_hcd:usb3
 19:       1043   IO-APIC-fasteoi   ohci1394, eth0
 20:      23230   IO-APIC-fasteoi   acpi, ohci_hcd:usb1
 21:        781   IO-APIC-fasteoi   ehci_hcd:usb4
 22:          4   IO-APIC-fasteoi   bttv0
 23:    1943588   IO-APIC-fasteoi   EMU10K1
NMI:          0 
LOC:     548999 
ERR:          0
MIS:          0

Is it normal at acpi use the same IRQ as ohci_hcd:usb1? I don't think so, but I
can be wrong.

# cat .config|grep ACPI
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
CONFIG_PNPACPI=y

# dmesg|grep ACPI
 BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5810
ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc000
ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc0c0
ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc030
ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc058
ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Core revision 20060707
ACPI: bus type pci registered
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:0a.2[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 23

It is with the last bios revison, 1005.

With a 2.6.19.1-rt15 that have antother configuration and work fine, I get
when running it with pci=noacpi:
# cat /proc/interrupts
           CPU0       
  0:     228789    XT-PIC-XT        timer
  1:        229    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:     148178    XT-PIC-XT        EMU10K1
  6:          5    XT-PIC-XT        floppy
  7:          1    XT-PIC-XT        parport0
  8:          2    XT-PIC-XT        rtc
  9:       4641    XT-PIC-XT        acpi, ohci_hcd:usb1, ehci_hcd:usb2,
ohci1394, ohci_hcd:usb3, ohci_hcd:usb4, eth0 
 10:          4    XT-PIC-XT        bttv0
 11:      10019    XT-PIC-XT        nvidia
 12:          4    XT-PIC-XT        i8042
 14:      19935    XT-PIC-XT        ide0
 15:       3605    XT-PIC-XT        ide1
NMI:     729962 
LOC:     228630 
ERR:          0
MIS:          0

My problem is at I really want to use CONFIG_X86_PM_TIMER in the ACPI config.

Cheers,
Dominique
