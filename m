From: AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: Re: ACPI + IO-APIC power off by button problems
Date: Sun, 02 Mar 2003 21:59:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E6270B8.4070805@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, thank you

I post you my cat /proc/interrupts

        CPU0       0:      18871    IO-APIC-edge  timer
 1:        689    IO-APIC-edge  keyboard
 2:          0          XT-PIC  cascade
 8:          1    IO-APIC-edge  rtc
 9:          0   IO-APIC-level  acpi
12:      16103    IO-APIC-edge  PS/2 Mouse
14:       3503    IO-APIC-edge  ide0
15:       3148    IO-APIC-edge  ide1
16:       4432   IO-APIC-level  cmpci
19:        155   IO-APIC-level  eth0
NMI:          0
LOC:      18823
ERR:          0
MIS:          0

I can't post my dmesg , or , better, it will be unuseful , because I use 
Software RAID, and Software RAID makes very much output that delete the 
first part of my dmesg (the part that you need). If this can be useful 
to you when the system starts I see a message like "No IRQ Known for 
device X.XX.X using IRQ 255 " and " try to start with option pci=noacpi" 
or something like that.
I post you my lspci output if this can be of any help:

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
   Subsystem: VIA Technologies, Inc.: Unknown device 0000
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
   Latency: 8
   Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
   Capabilities: [a0] AGP version 2.0
       Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
       Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
   Capabilities: [c0] Power Management version 2
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 89 31 06 00 30 22 00 00 00 06 00 08 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 
[Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
   Latency: 0
   Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
   I/O behind bridge: 0000f000-00000fff
   Memory behind bridge: dee00000-dfefffff
   Prefetchable memory behind bridge: dad00000-decfffff
   BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
   Capabilities: [80] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 68 b1 07 01 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: e0 de e0 df d0 da c0 de 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
   Subsystem: Realtek Semiconductor Co., Ltd. RT8139
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (8000ns min, 16000ns max)
   Interrupt: pin A routed to IRQ 19
   Region 0: I/O ports at ec00 [size=256]
   Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
   Capabilities: [50] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 ec 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)
   Subsystem: Micro-Star International Co., Ltd.: Unknown device 5900
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (500ns min, 6000ns max)
   Interrupt: pin A routed to IRQ 16
   Region 0: I/O ports at e800 [size=256]
   Capabilities: [c0] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 05 00 10 02 10 00 01 04 00 80 00 00
10: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 59
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 02 18

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin A routed to IRQ 21
   Region 4: I/O ports at dc00 [size=32]
   Capabilities: [80] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 dc 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin B routed to IRQ 21
   Region 4: I/O ports at e000 [size=32]
   Capabilities: [80] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin C routed to IRQ 21
   Region 4: I/O ports at e400 [size=32]
   Capabilities: [80] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
   Subsystem: VIA Technologies, Inc. USB 2.0
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin D routed to IRQ 21
   Region 0: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
   Capabilities: [80] Power Management version 2
       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 82 20 03 0c 08 80 00 00
10: 00 fe ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
   Subsystem: VIA Technologies, Inc.: Unknown device 0000
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 0
   Capabilities: [c0] Power Management version 2
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 77 31 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
   Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 32
   Interrupt: pin A routed to IRQ 255
   Region 4: I/O ports at fc00 [size=16]
   Capabilities: [c0] Power Management version 2
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 82) (prog-if 00 [VGA])
   Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (4000ns min, 8000ns max), cache line size 08
   Interrupt: pin A routed to IRQ 16
   Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
   Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=16K]
   Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
   Expansion ROM at dfec0000 [disabled] [size=128K]
   Capabilities: [dc] Power Management version 2
       Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [f0] AGP version 2.0
       Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
       Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
00: 2b 10 25 05 07 00 90 02 82 00 00 03 08 80 00 00
10: 08 00 00 dc 00 c0 ef df 00 00 00 df 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 41 06
30: 00 00 ec df dc 00 00 00 00 00 00 00 0b 01 10 20

Thanks again






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
