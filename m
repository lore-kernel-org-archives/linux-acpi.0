From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW:  PROBLEM: kernel BUG in sched.c:564
Date: Mon, 27 Oct 2003 07:51:31 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84702C930BF@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

=20

-----Original Message-----
From: Rupert Mazzucco [mailto:mazzucco-DHJ6qyTucS0@public.gmane.org]=20
Sent: Monday, October 27, 2003 6:15 AM
To: Grover, Andrew
Cc: mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: PROBLEM: kernel BUG in sched.c:564

I can't get most of the info suggested in REPORTING-BUGS because
the buggy kernel crashes nearly immediately.  Anyway, here's what
happens:

-  System crashes with message "kernel BUG in sched.c:564", complaining
   about an "invalid operand: 00000" (all zeros) and register
information
   etc.  I don't see an "oops", though, but nothing goes anymore.

   This happens in the simplest case directly after booting into text
mode
   if I wait some minutes (without login).  I can login and issue a few
   commands if I'm quick enough, but didn't manage to do more than a
"cd"
   and a "ls".

- System in question is 2.4.22 + acpi-20031002 patch.  Build system is
  gcc 3.3 + assorted tools.  Hardware is a Acer TM 521 notebook w/ PIII.
  (I could build and run a 2.4.21 + ACPI kernel without problems.)

- The offending function in sched.c looks like there was something wrong
  with the interrupts.  I notice that the buggy kernel writes a message
 "ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd" [sic!],
which
  didn't appear in earlier kernels.  This is why I think it may be
really
  an ACPI problem.

- output of scripts/ver_linux:

Linux darkstar 2.4.21 #1 Mon Jun 30 17:49:45 CEST 2003 i686 unknown
[this is *not* the kernel that crashes, see above]
=20
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
pcmcia-cs              3.2.4
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         mach64 af_packet e100
[crashes without those modules, see above]

- boot messages from the buggy kernel from syslog:

Oct 27 13:49:49 darkstar kernel: Linux version 2.4.22+acpi-20031002
(root@darkst
ar) (gcc version 3.3) #1 Mon Oct 27 12:43:00 CET 2003
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00
 (usable)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000
 (reserved)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000
 (reserved)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 0000000000100000 -
0000000007ff0000
 (usable)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 0000000007ff0000 -
0000000007ff8000
 (ACPI data)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 0000000007ff8000 -
0000000008000000
 (ACPI NVS)
Oct 27 13:49:49 darkstar kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000
 (reserved)
Oct 27 13:49:49 darkstar kernel: On node 0 totalpages: 32752
Oct 27 13:49:49 darkstar kernel: zone(0): 4096 pages.
Oct 27 13:49:49 darkstar kernel: zone(1): 28656 pages.
Oct 27 13:49:49 darkstar kernel: zone(2): 0 pages.
Oct 27 13:49:49 darkstar kernel: Kernel command line: auto
BOOT_IMAGE=3DNewest ro=20
root=3D302
Oct 27 13:49:49 darkstar kernel: Detected 596.922 MHz processor.
Oct 27 13:49:49 darkstar kernel: Console: colour VGA+ 80x25
Oct 27 13:49:49 darkstar kernel: Calibrating delay loop... 1189.47
BogoMIPS
Oct 27 13:49:49 darkstar kernel: Page-cache hash table entries: 32768
(order: 5,
 131072 bytes)
Oct 27 13:49:49 darkstar kernel: CPU: Intel Pentium III (Coppermine)
stepping 03
Oct 27 13:49:49 darkstar kernel: POSIX conformance testing by UNIFIX
Oct 27 13:49:49 darkstar kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@at
nf.csiro.au)
Oct 27 13:49:49 darkstar kernel: mtrr: detected mtrr type: Intel
Oct 27 13:49:49 darkstar kernel: ACPI: IRQ 9 was Edge Triggered, setting
to Leve
l Triggerd
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILA] (IRQs 1
3 4 5 6
 7 9 10 *11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILB] (IRQs 1
3 4 5 6
 7 9 10 *11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILC] (IRQs 1
3 4 5 6
 7 9 10 *11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILD] (IRQs 1
3 4 5 6
 7 9 *10 11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILE] (IRQs 1
3 4 5 6
 7 9 10 11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILF] (IRQs 1
3 4 5 6
 7 9 10 11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILG] (IRQs 1
3 4 5 6
 7 9 *10 11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILH] (IRQs 1
3 4 5 6
 7 9 *10 11 12 14 15)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILI] (IRQs 1
3 4 5 6
 7 9 10 *11 12 14 15)
Oct 27 13:49:49 darkstar kernel: PCI: Probing PCI hardware (bus 00)
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILH] enabled
at IRQ=20
10
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILD] enabled
at IRQ=20
10
Oct 27 13:49:49 darkstar kernel: PCI: No IRQ known for interrupt pin A
of device
 00:10.0 - using IRQ 15
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILB] enabled
at IRQ=20
11
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILI] enabled
at IRQ=20
11
Oct 27 13:49:49 darkstar kernel: ACPI: PCI Interrupt Link [PILA] enabled
at IRQ=20
11
Oct 27 13:49:49 darkstar kernel: Initializing RT netlink socket
Oct 27 13:49:49 darkstar kernel: Starting kswapd
Oct 27 13:49:49 darkstar kernel: pty: 256 Unix98 ptys configured
Oct 27 13:49:49 darkstar kernel: PCI: No IRQ known for interrupt pin A
of device
 00:10.0 - using IRQ 15
Oct 27 13:49:49 darkstar kernel: hda: IBM-DARA-206000, ATA DISK drive
Oct 27 13:49:49 darkstar kernel: blk: queue c02af840, I/O limit 4095Mb
(mask 0xf
fffffff)
Oct 27 13:49:49 darkstar kernel: hdc: CD-224E, ATAPI CD/DVD-ROM drive
Oct 27 13:49:49 darkstar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 27 13:49:49 darkstar kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 27 13:49:49 darkstar kernel: hda: attached ide-disk driver.
Oct 27 13:49:49 darkstar kernel: hda: host protected area =3D> 1
Oct 27 13:49:49 darkstar kernel: VFS: Mounted root (ext3 filesystem)
readonly.

- cat /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 497.435
[yes, that's 100 MHz less than above; that has happened before, but
rarely]
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 992.87

- cat /proc/interrupts:

           CPU0      =20
  0:     445032          XT-PIC  timer
  1:      17832          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          2          XT-PIC  acpi
 10:      14450          XT-PIC  ALi Audio Accelerator, eth0
 11:     262322          XT-PIC  mach64@PCI:1:0:0
 12:      36747          XT-PIC  PS/2 Mouse
 14:       4422          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0=20
ERR:          0

- lspci -vvv:

00:00.0 Host bridge: ALi Corporation M1621 (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=3D33 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D33 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit-
FW- Rate=3Dx2

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: 80600000-820fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9000 [size=3D256]
	Region 1: Memory at 82200000 (32-bit, non-prefetchable)
[size=3D4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 80100000 (32-bit, non-prefetchable)
[size=3D4K]
	Region 1: I/O ports at 7000 [size=3D64]
	Region 2: Memory at 80200000 (32-bit, non-prefetchable)
[size=3D1M]
	Expansion ROM at 80300000 [disabled] [size=3D1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if fa)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 6050 [size=3D16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:13.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable)
[size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D0
	Memory window 0: 00000000-00000000
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite-
	16-bit legacy interface ports at 0001

00:13.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
[size=3D4K]
	Bus: primary=3D00, secondary=3D06, subordinate=3D09, sec-latency=3D0
	Memory window 0: 00000000-00000000
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
PostWrite-
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 82400000 (32-bit, non-prefetchable)
[size=3D4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
[size=3D16M]
	Region 1: I/O ports at 8000 [size=3D256]
	Region 2: Memory at 80600000 (32-bit, non-prefetchable)
[size=3D4K]
	Expansion ROM at 80620000 [disabled] [size=3D128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D33 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit-
FW- Rate=3Dx2
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
--=20
Regards,
Rupert


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
