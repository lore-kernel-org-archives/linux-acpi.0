From: Steven Michalske <michalsc-Kx4bGX/NEpX2fBVCVOL8/A@public.gmane.org>
Subject: [oops] Unplugging ac adaptor from IBM thinkpad a21p
Date: Mon, 17 Nov 2003 21:43:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311172143.14186.michalsc@email.uc.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7cYu/v+NOo8hsRg"
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


--Boundary-00=_7cYu/v+NOo8hsRg
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I unplug my ac adaptor my system oopses

Keywords: ACPI

cat /proc/version
Linux version 2.6.0-test9 (root-7rVE/Fg9U4Y@public.gmane.org) (gcc version 3.2.3) #3 Mon Nov 17=
=20
18:45:45 EST 2003

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 847.081
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat=20
pse36 mmx fxsr sse
bogomips        : 1675.26

no modules

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
01f0-01f7 : ide0
03bc-03be : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
1040-105f : 0000:00:07.3
1800-183f : 0000:00:03.0
  1800-183f : e100
1840-1847 : 0000:00:03.1
1850-185f : 0000:00:07.1
  1850-1857 : ide0
  1858-185f : ide1
1860-187f : 0000:00:07.2
  1860-187f : uhci_hcd
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06

cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d17ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0041add7 : Kernel code
  0041add8-0052cebf : Kernel data
0fff0000-0fffebff : ACPI Tables
0fffec00-0fffffff : ACPI Non-volatile Storage
10000000-103fffff : PCI CardBus #02
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #06
10c00000-10ffffff : PCI CardBus #06
50000000-50000fff : 0000:00:02.0
  50000000-50000fff : yenta_socket
50100000-50100fff : 0000:00:02.1
  50100000-50100fff : yenta_socket
a0000000-a0000fff : card services
f0000000-f00fffff : 0000:00:05.0
  f0000000-f0002fff : CS46xx_BA1_data0
  f0010000-f00137ff : CS46xx_BA1_data1
  f0020000-f0026fff : CS46xx_BA1_pmem
  f0030000-f00300ff : CS46xx_BA1_reg
f0100000-f011ffff : 0000:00:03.0
  f0100000-f011ffff : e100
f0120000-f0120fff : 0000:00:03.0
  f0120000-f0120fff : e100
f0121000-f0121fff : 0000:00:03.1
f0122000-f0122fff : 0000:00:05.0
  f0122000-f0122fff : CS46xx_BA0
f0200000-f02fffff : PCI Bus #01
  f0200000-f0203fff : 0000:01:00.0
f4000000-f7ffffff : 0000:00:00.0
f8000000-fbffffff : PCI Bus #01
  f8000000-fbffffff : 0000:01:00.0
    f8000000-f8ffffff : vesafb
fff80000-ffffffff : reserved

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uYc9JhwOdxS4dYERAiywAJsGDd3+Lodk0wDoaboDH3qVNmnF/ACgqKii
K3PfalvX3a3mGhNBawI2T40=3D
=3DyAcc
=2D----END PGP SIGNATURE-----

--Boundary-00=_7cYu/v+NOo8hsRg
Content-Type: text/plain;
  charset="us-ascii";
  name="oops.ksym"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops.ksym"

ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9/ (default)
     -m /usr/src/linux-2.6.0-test9/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011a7fe>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: 00000001   ebx: c0494ee0   ecx: c0494f00   edx: 2707ac56
esi: 00000000   edi: c12e5ca8   ebp: c052fb64   esp: c052fb20
ds: 007b   es: 007b   ss: 0068
Stack: c0438ee0 c0454eeb cffeede0 00000001 c028905c 0000039c c052fb40 00000000
       00000000 c052fb78 00000246 062aae2e 2d325a84 00000008 fffc1aa7 c052fb78
       c12e5ca8 c12e58e8 c0126a13 c052fb78 fffc1aa7 00200000 c0498738 c1367fc0
Call Trace:
 [<c028905c>] acpi_os_signal_semaphore+0xa3/0xa7
 [<c0126a13>] schedule_timeout+0x63/0xc0
 [<c01269a0>] process_timeout+0x0/0x10
 [<c02980e9>] acpi_ex_system_do_suspend+0x24/0x2d
 [<c02967fd>] acpi_ex_opcode_1A_0T_0R+0x95/0xe0
 [<c028c052>] acpi_ds_exec_end_op+0x3b5/0x423
 [<c02a3705>] acpi_ps_parse_loop+0x41e/0xa9a
 [<c028905c>] acpi_os_signal_semaphore+0xa3/0xa7
 [<c02ad846>] acpi_ut_release_mutex+0x100/0x167
 [<c02ac2fb>] acpi_ut_exit+0x1d/0x27
 [<c028f168>] acpi_ds_delete_walk_state+0x98/0x11e
 [<c02a3fd3>] acpi_ps_parse_aml+0x252/0x277
 [<c02a4b31>] acpi_psx_execute+0x1b5/0x2d0
 [<c029fe8e>] acpi_ns_execute_control_method+0xbb/0x105
 [<c029fd77>] acpi_ns_evaluate_by_handle+0xd4/0x130
 [<c029fb10>] acpi_ns_evaluate_relative+0x154/0x1a0
 [<c029d070>] acpi_hw_low_level_read+0xf0/0x122
 [<c02ac338>] acpi_ut_status_exit+0x33/0x55
 [<c029eec7>] acpi_evaluate_object+0x9e/0x29e
 [<c02b3542>] acpi_ec_gpe_query+0x132/0x141
 [<c029275c>] acpi_ev_gpe_dispatch+0x19c/0x1e0
 [<c029248d>] acpi_ev_gpe_detect+0x164/0x16c
 [<c028fff7>] acpi_ev_sci_xrupt_handler+0x37/0x4d
 [<c0288536>] acpi_irq+0xc/0x16
 [<c010cac9>] handle_IRQ_event+0x49/0x80
 [<c028852a>] acpi_irq+0x0/0x16
 [<c010ce47>] do_IRQ+0x97/0x140
 [<c010b1b8>] common_interrupt+0x18/0x20
 [<c02b74a6>] acpi_processor_idle+0xef/0x1c7
 [<c0108ba0>] default_idle+0x0/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0108ba0>] default_idle+0x0/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0108c50>] cpu_idle+0x30/0x40
 [<c053074a>] start_kernel+0x17a/0x1b0
 [<c0530470>] unknown_bootoption+0x0/0x120
Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00


>>EIP; c011a7fe <schedule+ee/590>   <=====

>>ebx; c0494ee0 <init_task+0/620>
>>ecx; c0494f00 <init_task+20/620>
>>edi; c12e5ca8 <_end+d6ec64/3fa86fbc>
>>ebp; c052fb64 <init_thread_union+1b64/2000>
>>esp; c052fb20 <init_thread_union+1b20/2000>

Trace; c028905c <acpi_os_signal_semaphore+a3/a7>
Trace; c0126a13 <schedule_timeout+63/c0>
Trace; c01269a0 <process_timeout+0/10>
Trace; c02980e9 <acpi_ex_system_do_suspend+24/2d>
Trace; c02967fd <acpi_ex_opcode_1A_0T_0R+95/e0>
Trace; c028c052 <acpi_ds_exec_end_op+3b5/423>
Trace; c02a3705 <acpi_ps_parse_loop+41e/a9a>
Trace; c028905c <acpi_os_signal_semaphore+a3/a7>
Trace; c02ad846 <acpi_ut_release_mutex+100/167>
Trace; c02ac2fb <acpi_ut_exit+1d/27>
Trace; c028f168 <acpi_ds_delete_walk_state+98/11e>
Trace; c02a3fd3 <acpi_ps_parse_aml+252/277>
Trace; c02a4b31 <acpi_psx_execute+1b5/2d0>
Trace; c029fe8e <acpi_ns_execute_control_method+bb/105>
Trace; c029fd77 <acpi_ns_evaluate_by_handle+d4/130>
Trace; c029fb10 <acpi_ns_evaluate_relative+154/1a0>
Trace; c029d070 <acpi_hw_low_level_read+f0/122>
Trace; c02ac338 <acpi_ut_status_exit+33/55>
Trace; c029eec7 <acpi_evaluate_object+9e/29e>
Trace; c02b3542 <acpi_ec_gpe_query+132/141>
Trace; c029275c <acpi_ev_gpe_dispatch+19c/1e0>
Trace; c029248d <acpi_ev_gpe_detect+164/16c>
Trace; c028fff7 <acpi_ev_sci_xrupt_handler+37/4d>
Trace; c0288536 <acpi_irq+c/16>
Trace; c010cac9 <handle_IRQ_event+49/80>
Trace; c028852a <acpi_irq+0/16>
Trace; c010ce47 <do_IRQ+97/140>
Trace; c010b1b8 <common_interrupt+18/20>
Trace; c02b74a6 <acpi_processor_idle+ef/1c7>
Trace; c0108ba0 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0108ba0 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0108c50 <cpu_idle+30/40>
Trace; c053074a <start_kernel+17a/1b0>
Trace; c0530470 <unknown_bootoption+0/120>

Code;  c011a7fe <schedule+ee/590>
00000000 <_EIP>:
Code;  c011a7fe <schedule+ee/590>   <=====
   0:   ff 0e                     decl   (%esi)   <=====
Code;  c011a800 <schedule+f0/590>
   2:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c011a803 <schedule+f3/590>
   5:   8b 43 20                  mov    0x20(%ebx),%eax
Code;  c011a806 <schedule+f6/590>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c011a809 <schedule+f9/590>
   b:   89 02                     mov    %eax,(%edx)
Code;  c011a80b <schedule+fb/590>
   d:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)

 <0>Kernel panic: Fatal exception in interrupt

1 warning issued.  Results may not be reliable.

--Boundary-00=_7cYu/v+NOo8hsRg
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci_vvv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci_vvv"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f0200000-f02fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corp. EtherExpress PRO/100+ MiniPCI
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0120000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at f0100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.1 Serial controller: Xircom Mini-PCI V.90 56k Modem (prog-if 02 [16550])
	Subsystem: Intel Corp.: Unknown device 2408
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1840 [size=8]
	Region 1: Memory at f0121000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1850 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1860 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0155
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f0200000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_7cYu/v+NOo8hsRg--



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
