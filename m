From: Necati DEMiR <ndemir-8b7qcxwNidXiQSDH/tmc6Q@public.gmane.org>
Subject: ACPI gives error at boot
Date: Wed, 05 Jan 2005 20:06:56 +0200
Message-ID: <41DC2CC0.4070800@demir.web.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

hi,
i have problem with ACPI.
it gives error at boot.
i am sending some information.

#dmesg
.
.
.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i850 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.MDET] 
(Node cfb56400), AE_AML_REGION_LIMIT
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0._CRS] 
(Node cfb56500), AE_AML_REGION_LIMIT
    ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0._CRS] 
(Node cfb56500), AE_AML_REGION_LIMIT
shpchp: acpi_shpchprm:\_SB_.PCI0 _CRS fail=0x300b
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _CRS fail=0x300b
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.MDET] 
(Node cfb56400), AE_AML_REGION_LIMIT
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0._CRS] 
(Node cfb56500), AE_AML_REGION_LIMIT
    ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0._CRS] 
(Node cfb56500), AE_AML_REGION_LIMIT
pciehp: acpi_pciehprm:\_SB_.PCI0 _CRS fail=0x300b
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _CRS fail=0x300b
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
.
.
.


# cat /proc/interrupts
           CPU0
  0:    4954673    IO-APIC-edge  timer
  1:       1829    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     136866    IO-APIC-edge  i8042
 14:      66145    IO-APIC-edge  ide0
169:          0   IO-APIC-level  uhci_hcd
177:       4553   IO-APIC-level  Intel 82801BA-ICH2, saa7130[0]
185:         24   IO-APIC-level  uhci_hcd
201:      52515   IO-APIC-level  eth0
NMI:          0
LOC:    4954694
ERR:          0
MIS:          0


#lspci -vv
0000:00:00.0 Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host 
Bridge (MCH) (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP 
Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: e4600000-f46fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 04) (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: f4700000-f47fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) 
(prog-if 80 [Master])
        Subsystem: Intel Corp.: Unknown device 4d44
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 
04) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4d44
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 169
        Region 4: I/O ports at ef40 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
        Subsystem: Intel Corp.: Unknown device 4d44
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 177
        Region 4: I/O ports at efa0 [size=16]

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 
04) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4d44
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 185
        Region 4: I/O ports at ef80 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 
Audio (rev 04)
        Subsystem: Intel Corp.: Unknown device 4d44
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 177
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ef00 [size=64]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV11DDR 
[GeForce2 MX 100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fe9f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

0000:02:0a.0 Ethernet controller: Davicom Semiconductor, Inc. 21x4x 
DEC-Tulip compatible 10/100 Ethernet (rev 40)
        Subsystem: Unknown device 3030:5032
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at feaffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fea80000 [disabled] [size=256K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=220mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0c.0 Multimedia controller: Philips Semiconductors SAA7130 Video 
Broadcast Decoder (rev 01)
        Subsystem: Philips Semiconductors: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-




-- 
------------------------------------------------
Necati DEMiR
ndemir-8b7qcxwNidXiQSDH/tmc6Q@public.gmane.org
http://demir.web.tr
My Public Key => http://demir.web.tr/ndemir.asc
-------------------------------------------------



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
