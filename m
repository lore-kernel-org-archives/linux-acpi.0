From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bugme-new] [Bug 4904] New: P4 + acpi + rtc : hang at boot on
 dell poweredge 1800
Date: Sun, 17 Jul 2005 06:21:34 -0700
Message-ID: <20050717062134.171d9d62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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



Begin forwarded message:

Date: Sun, 17 Jul 2005 03:11:32 -0700
From: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To: bugme-new-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Subject: [Bugme-new] [Bug 4904] New: P4 + acpi + rtc : hang at boot on dell=
 poweredge 1800


http://bugzilla.kernel.org/show_bug.cgi?id=3D4904

           Summary: P4 + acpi + rtc : hang at boot on dell poweredge 1800
    Kernel Version: 2.6.11
            Status: NEW
          Severity: normal
             Owner: timers_realtime-clock-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: bugs-z6yWQMz/Q0+sTnJN9+BGXg@public.gmane.org


Distribution: debian sarge
Hardware Environment: dell poweredge 1800
Software Environment:
Problem Description: when acpi is enabled, /dev/rtc hangs for ever

hwclock       S C1A1A000     0  1515   1514                     (NOTLB)
c1a1bf14 00000086 f7528bd8 c1a1a000 f77ced00 00000005 00000000 dffa2a80=20
       c1810020 00000000 c177d280 000f421d f7528bd8 c1a1a000 fffffe00 c1a1a=
000=20
       f7743b80 f887b188 c0125719 00000005 00000000 f7528a80 c0117358 00000=
000=20
Call Trace:
 [<f887b188>] rtc_read+0xb8/0x168 [rtc]
 [<c0125719>] ptrace_notify+0x81/0x94
 [<c0117358>] default_wake_function+0x0/0x14
 [<c0117358>] default_wake_function+0x0/0x14
 [<c0152c11>] vfs_read+0x9d/0xfc
 [<c0152e7f>] sys_read+0x3b/0x68
 [<c010342b>] syscall_call+0x7/0xb




lspci:

0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
	Subsystem: Dell: Unknown device 0183
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [4105]

0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 A0
(rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D00, secondary=3D01, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: df900000-dfefffff
	Secondary status: SERR
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=3D0/1 Enable-
		Address: fee00000  Data: 0000
	Capabilities: [64] #10 [0041]

0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 B0
(rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=3D0/1 Enable-
		Address: fee00000  Data: 0000
	Capabilities: [64] #10 [0141]

0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 C0
(rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=3D0/1 Enable-
		Address: fee00000  Data: 0000
	Capabilities: [64] #10 [0141]

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at bce0 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at bcc0 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at bca0 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Dell: Unknown device 0183
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at dff00000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: df700000-df8fffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (re=
v 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 1=
00
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=3D16]
	Region 5: Memory at 3ffff000 (32-bit, non-prefetchable) [size=3D1K]

0000:01:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D01, secondary=3D02, subordinate=3D02, sec-latency=3D64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dfd00000-dfefffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d8]=20
0000:01:00.1 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller A
(rev 09) (prog-if 20 [IO(X)-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at df9ff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D01, secondary=3D03, subordinate=3D03, sec-latency=3D32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dfb00000-dfcfffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d8]=20
0000:01:00.3 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller B
(rev 09) (prog-if 20 [IO(X)-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at df9fe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI=
-X
Fusion-MPT Dual Ultra320 SCSI (rev 08)
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=3D256]
	Region 1: Memory at dfdf0000 (64-bit, non-prefetchable) [size=3D64K]
	Region 3: Memory at dfde0000 (64-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at dfe00000 [disabled] [size=3D1M]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3D0 OST=3D4
		Status: Bus=3D2 Dev=3D4 Func=3D0 64bit+ 133MHz+ SCD- USC-, DC=3Dsimple, D=
MMRBC=3D2,
DMOST=3D4, DMCRS=3D1, RSCEM-

0000:03:07.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
Controller (rev 05)
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 69
	Region 0: Memory at dfbe0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at dcc0 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=3D0 OST=3D0
		Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, D=
MMRBC=3D2,
DMOST=3D0, DMCRS=3D0, RSCEM-

0000:06:05.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: Dell: Unknown device 0183
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Steppi=
ng+
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at cc00 [size=3D256]
	Region 2: Memory at df7f0000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-



dmesg:

Linux version 2.6.11-1-686-smp (dannf@firetheft) (gcc version 3.3.6 (Debian
1:3.3.6-6)) #1 SMP Mon Jun 20 20:18:45 MDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
 BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32704 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fd6a0
ACPI: RSDT (v001 DELL   PE1800   0x00000001 MSFT 0x0100000a) @ 0x000fd6b4
ACPI: FADT (v001 DELL   PE1800   0x00000001 MSFT 0x0100000a) @ 0x000fd6e8
ACPI: MADT (v001 DELL   PE1800   0x00000001 MSFT 0x0100000a) @ 0x000fd75c
ACPI: SPCR (v001 DELL   PE1800   0x00000001 MSFT 0x0100000a) @ 0x000fd7f8
ACPI: HPET (v001 DELL   PE1800   0x00000001 MSFT 0x0100000a) @ 0x000fd848
ACPI: DSDT (v001 DELL   PE1800   0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3ffff000:a0001000)
Built 1 zonelists
Kernel command line: root=3D/dev/sda2 vga=3D0x305
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80800)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030636k/1048320k available (1720k kernel code, 16956k reserved, 71=
9k
data, 204k init, 130816k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 0ns tick, 3 64-bit timers
Using HPET for base-timer
Using HPET for gettimeofday
Detected 2793.251 MHz processor.
Using hpet for high-res timesource
Calibrating delay loop... 5537.79 BogoMIPS (lpj=3D2768896)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
641d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
41d
00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
per-CPU timeslice cutoff: 2925.13 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=3D2793472)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
641d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
41d
00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Booting processor 2/6 eip 3000
Initializing CPU#2
Calibrating delay loop... 5586.94 BogoMIPS (lpj=3D2793472)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
641d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
41d
00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Booting processor 3/7 eip 3000
Initializing CPU#3
Calibrating delay loop... 5570.56 BogoMIPS (lpj=3D2785280)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
641d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
41d
00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000641d
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
Total of 4 processors activated (22282.24 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
CPU0 attaching sched-domain:
 domain 0: span 03
  groups: 01 02
  domain 1: span 0f
   groups: 03 0c
CPU1 attaching sched-domain:
 domain 0: span 03
  groups: 02 01
  domain 1: span 0f
   groups: 03 0c
CPU2 attaching sched-domain:
 domain 0: span 0c
  groups: 04 08
  domain 1: span 0f
   groups: 0c 03
CPU3 attaching sched-domain:
 domain 0: span 0c
  groups: 08 04
  domain 1: span 0f
   groups: 0c 03
checking if image is initramfs...it isn't (bad gzip magic numbers); looks l=
ike
an initrd
Freeing initrd memory: 4756k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc12e, last bus=3D6
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBLO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCLO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PICH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: 00:08: ioport range 0x800-0x87f could not be reserved
pnp: 00:08: ioport range 0x880-0x8bf has been reserved
pnp: 00:08: ioport range 0x8c0-0x8df has been reserved
pnp: 00:08: ioport range 0xc00-0xc0f has been reserved
pnp: 00:08: ioport range 0xc10-0xc1f has been reserved
pnp: 00:08: ioport range 0xca0-0xcaf has been reserved
pnp: 00:08: ioport range 0xc20-0xc3f has been reserved
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
Intel E7520/7320/7525 detected.<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GS=
I 16
(level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[pcie00]
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[pcie00]
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:06.0 to 64
Allocate Port Service[pcie00]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hpet_acpi_add: no address or irqs in _CRS
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:=20
PCI0 PALO PBLO PCLO=20
ACPI: (supports S0 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4756KiB [1 disk] into ram disk... |=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Fusion MPT base driver 3.01.18
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 42 (level, low) -> IRQ 177
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities=3D{Initiator,Target}
SCSI subsystem initialized
Fusion MPT SCSI Host driver 3.01.18
scsi0 : ioc0: LSI53C1030, FwRev=3D01032300h, Ports=3D1, MaxQ=3D255, IRQ=3D1=
77
  Vendor: SEAGATE   Model: ST336607LC        Rev: DS09
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST336607LC        Rev: DS09
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SDR       Model: GEM318P           Rev: 1  =20
  Type:   Processor                          ANSI SCSI revision: 02
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 1536k, total=
 16384k
vesafb: mode is 1024x768x8, linelength=3D1024, pages=3D20
vesafb: protected mode interface info at c000:5214
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=3D8:8:8:8, shift=3D0:0:0:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
NET: Registered protocol family 1
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 3
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
 /dev/scsi/host0/bus0/target1/lun0: p1 p2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Real Time Clock Driver v1.12
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:03:07.0[A] -> GSI 69 (level, low) -> IRQ 185
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 995988k swap on /dev/sda1.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
Capability LSM initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block=
 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
