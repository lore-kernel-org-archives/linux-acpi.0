From: Srihari Vijayaraghavan <harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>
Subject: PROBLEM: Executing /sbin/hwclock hangs 2.4.21-rc[12] with ACPI snapshot patches
Date: Mon, 19 May 2003 14:17:32 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305251014.23474.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Date: Sun, 25 May 2003 10:14:23 +1000
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
Executing /sbin/hwclock hangs 2.4.21-rc[12] with ACPI snapshot patches 
(acpi-20030424-2.4.21-rc1.diff.gz and acpi-20030512-2.4.21-rc2.diff.gz)

[2.] Full description of the problem/report:
/sbin/hwclock is invoked by /etc/rc.sysinit script, which means you can't even 
boot to single user mode. Commenting it out in rc.sysinit fixes the problem 
of course. Kernel doesn't respond to Sysrq commands when it hangs. And yes, 
vanilla 2.4.21-rc[12] (without the classic ACPI present in the official tree) 
works fine. 

[3.] Keywords (i.e., modules, networking, kernel):
acpi, 2.4.21-rc1, 2.4.21-rc2

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-rc2-acpi (hari@laptop) (gcc version 3.2.2 20030222 (Red 
Hat Linux 3.2.2-5)) #3 Mon May 19 02:46:42 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
Just execute /sbin/hwclock

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux laptop 2.4.21-rc2-acpi #3 Mon May 19 02:46:42 EST 2003 i686 athlon i386 
GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : Mobile AMD Athlon(tm) XP 1800+
stepping        : 0
cpu MHz         : 1523.872
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3040.87

[7.3.] Module information (from /proc/modules):
unix                   18056 102 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03b0-03bb : RadeonIGP
03c0-03df : vga+
  03d3-03d3 : RadeonIGP
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
8000-803f : ALi Corporation. [ALi] M7101 PMU
8040-805f : ALi Corporation. [ALi] M7101 PMU
8080-808f : ALi Corporation. [ALi] M5229 IDE
  8080-8087 : ide0
  8088-808f : ide1
8090-8093 : PCI device 1002:cab0 (ATI Technologies Inc)
8098-809f : Conexant HSF 56k HSFi Modem
8400-84ff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio Device
8800-88ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
9000-9fff : PCI Bus #01
  9000-90ff : PCI device 1002:4336 (ATI Technologies Inc)

/proc/iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1eeeffff : System RAM
  00100000-002012ca : Kernel code
  002012cb-0023b45f : Kernel data
1eef0000-1eefefff : ACPI Tables
1eeff000-1eefffff : ACPI Non-volatile Storage
1ef00000-1effffff : System RAM
f4000000-f400ffff : Conexant HSF 56k HSFi Modem
f4010000-f4010fff : ALi Corporation. [ALi] USB 1.1 Controller
f4011000-f4011fff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio 
Device
f4012000-f4012fff : ALi Corporation. [ALi] USB 1.1 Controller (#2)
f4013000-f40130ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
f4100000-f41fffff : PCI Bus #01
  f4100000-f410ffff : PCI device 1002:4336 (ATI Technologies Inc)
f4400000-f4400fff : PCI device 1002:cab0 (ATI Technologies Inc)
f6000000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : PCI device 1002:4336 (ATI Technologies Inc)
f8000000-fbffffff : PCI device 1002:cab0 (ATI Technologies Inc)
ffbfe000-ffbfefff : Texas Instruments PCI1410 PC card Cardbus Controller
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f4400000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 8090 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M] (rev 01) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f4100000-f41fffff
        Prefetchable memory behind bridge: f6000000-f7ffffff
        Secondary status: SERR
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
        Memory window 0: ffbfd000-ffbfd000 (prefetchable)
        Memory window 1: fbbfd000-ffbfc000 (prefetchable)
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
        16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 20)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at f4013000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 8d89
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at 8098 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4012000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Subsystem: ALi Corporation M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 8080 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: ALi Corporation ALI M7101 Power Management Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 
(prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This computer worked just fine during 2.4.21-pre[456] and earlier ACPI 
snapshots. It stopped working from 2.4.21-rc1 ACPI snapshot. It doesn't work 
under 2.4.21-rc2-ac2 either. I have disabled the line executing /sbin/hwclock 
to be able to boot 2.4.21-rc2-acpi (maybe I should add "yes" or "no" type of 
question in rc.sysinit for executing /sbin/hwclock).

It works great under 2.5.latest (that's with ACPI).

The version of /sbin/hwclock is: hwclock from util-linux-2.11y

These are the final few lines dispayed while executing "/usr/bin/strace 
/sbin/hwclock":
2.4.21-rc[12]-acpi:
--------------------------
open("/dev/rtc", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, RTC_UIE_ON, 0) = 0
read(3, 

OTOH 2.5.69:
--------------------
open("/dev/rtc", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, RTC_UIE_ON, 0) = 0
read(3, "\320\1\0\0", 4) = 4
ioctl(3, RTC_UIE_OFF, 0) = 0
close(3) = 0
gettimeofday({1053784293, 758955}, NULL) = 0
...

Here is my .config:
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_RTC=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

Please feel free to ask for more information.
-- 
Thank you

Hari
harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
