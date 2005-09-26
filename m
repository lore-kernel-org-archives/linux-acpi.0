From: =?ISO-8859-15?Q?Stephan_Austerm=FChle?= <au-dKYa5QjKvtY@public.gmane.org>
Subject: PROBLEM: Kernel 2.6.13 up to 2.6.13.2 hangs while booting when ACPI
 is enabled
Date: Mon, 26 Sep 2005 18:34:22 +0200
Message-ID: <4338230E.40309@hcsd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

[1.] One line summary of the problem:
Kernel 2.6.13 up to 2.6.13.2 hangs while booting when ACPI is enabled

[2.] Full description of the problem/report:
Last messages:

PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1

Kernel up to 2.6.12.5 work without problems. Disabling ACPI in 2.6.13,
2.6.13.1., 2.6.13.2 makes the kernel boot again.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, ACPI

[5.] Most recent kernel version which did not have the bug:
2.6.12.5

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux hopper 2.6.13.2 #1 SMP Sat Sep 24 11:42:36 CEST 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1

[8.2.] Processor information (from /proc/cpuinfo):
Pentium-M in a HP Compaq nc8230

[8.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]
00: 86 80 90 25 06 00 90 20 03 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Intel Corp. Mobile Memory Controller Hub PCI
Express Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8800000-c8bfffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40b9
	Capabilities: [a0] #10 [0041]
00: 86 80 91 25 07 04 10 00 03 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 20 20 00 20
20: 80 c8 b0 c8 00 c0 f0 c7 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0a 01 0c 00

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=10, subordinate=10, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: c8000000-c83fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40c1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 60 26 07 04 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 10 10 00 f0 00 00 20
20: 00 c8 30 c8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 04 00

0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=20, subordinate=20, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40d1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 62 26 04 04 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 20 20 00 00 00 00 20
20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 04 00

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 217
	Region 4: I/O ports at 3000 [size=32]
00: 86 80 58 26 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 30 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at 3020 [size=32]
00: 86 80 59 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 30 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 225
	Region 4: I/O ports at 3040 [size=32]
00: 86 80 5a 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 30 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at c8c00000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]
00: 86 80 5c 26 06 00 90 02 03 20 03 0c 00 00 00 00
10: 00 00 c0 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3) (prog-if
01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: c8400000-c87fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]
00: 86 80 48 24 07 01 10 00 d3 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 03 20 f0 00 80 22
20: 40 c8 70 c8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 06 00

0000:00:1e.2 Multimedia audio controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 233
	Region 0: I/O ports at 3100 [size=256]
	Region 1: I/O ports at 3200 [size=64]
	Region 2: Memory at c8c01000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c8c02000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 6e 26 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 31 00 00 01 32 00 00 00 10 c0 c8 00 20 c0 c8
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 50
	Region 0: I/O ports at 3400 [size=256]
	Region 1: I/O ports at 3500 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 6d 26 05 00 90 02 03 00 03 07 00 00 00 00
10: 01 34 00 00 01 35 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface
Bridge (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 41 26 07 00 00 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 3580 [size=16]
00: 86 80 6f 26 05 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 81 35 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 3150 (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at c8800000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
00: 02 10 50 31 03 00 10 00 00 00 00 03 10 00 00 00
10: 08 00 00 c0 01 20 00 00 00 00 80 c8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

0000:02:04.0 Network controller: Intel Corp.: Unknown device 4223 (rev 05)
	Subsystem: Hewlett-Packard Company: Unknown device 1352
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c8400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 23 42 06 00 90 02 05 00 80 02 10 40 00 00
10: 00 00 40 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 52 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 03 18

0000:02:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at c8401000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 40000000-403ff000 (prefetchable)
	Memory window 1: 40400000-407ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 31 80 07 00 10 02 00 00 07 06 10 a8 82 00
10: 00 10 40 c8 a0 00 00 02 02 03 06 b0 00 00 00 40
20: 00 f0 3f 40 00 00 40 40 00 f0 7f 40 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 3c 10 34 09 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device
8032 (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 50
	Region 0: Memory at c8402000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at c8404000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: 4c 10 32 80 06 00 10 02 00 10 00 0c 10 40 80 00
10: 00 20 40 c8 00 40 40 c8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 03 02 04

0000:02:06.3 Unknown mass storage controller: Texas Instruments: Unknown
device 8033
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at c8408000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 33 80 06 00 10 02 00 00 80 01 10 40 80 00
10: 00 80 40 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 02 07 04

0000:02:06.4 0805: Texas Instruments: Unknown device 8034
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at c840a000 (32-bit, non-prefetchable) [size=256]
	Region 1: Memory at c840b000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at c840c000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 34 80 06 00 10 02 00 00 05 08 10 40 80 00
10: 00 a0 40 c8 00 b0 40 c8 00 c0 40 c8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 03 07 04

0000:02:06.5 Communication controller: Texas Instruments: Unknown device
8035
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c840d000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at c840e000 (32-bit, non-prefetchable) [size=4K]
	Region 2: Memory at c840f000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at c8410000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 35 80 02 00 10 02 00 00 80 07 00 00 80 00
10: 00 d0 40 c8 00 e0 40 c8 00 f0 40 c8 00 00 41 c8
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 34 09
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 00 00

0000:10:00.0 Ethernet controller: Broadcom Corporation: Unknown device
167d (rev 11)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at c8000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: abd4e7e80ae3417c  Data: d76b
	Capabilities: [d0] #10 [0001]
00: e4 14 7d 16 06 00 10 00 11 00 00 02 10 00 00 00
10: 04 00 00 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 3c 10 34 09
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 00 00



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
