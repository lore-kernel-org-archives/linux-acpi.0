From: "Christopher Cowart" <astroguy_86-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Kernel Hangs During Boot
Date: Fri, 02 Jan 2004 03:03:22 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BAY2-F829fhzgAfiwHE0000294b@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_4a5c_5973_7a0c"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_4a5c_5973_7a0c
Content-Type: text/plain; format=flowed

Note: All of the information below (such as current modules) is a result of 
my working 2.4.22 kernel. This bug report is for kernel 2.6.0.

[1.] One line summary of the problem:
Kernel freezes during boot.
[2.] Full description of the problem/report:
I have recently compiled a new kernel. It freezes during the boot process. 
The screen displays at the time of the crash relate to ACPI support.
[3.] Keywords (i.e., modules, networking, kernel):
Kernel, ACPI
[4.] Kernel version (from /proc/version):
2.6.0
[6.] A small shell script or example program which triggers the
     problem (if possible)
On every boot.
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux laptop.cowarts.local 2.4.22 #1 Sat Oct 18 21:31:35 PDT 2003 i686 
athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      writing
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         maestro3 ac97_codec soundcore omnibook parport_pc lp 
parport ds yenta_socket pcmcia_core tulip crc32 ide-scsi usbmouse floppy 
ati_remote usb-storage printer scsi_mod ext2 nls_iso8859-1 nls_cp437 vfat 
fat mousedev keybdev hid input usb-ohci usbcore

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : mobile AMD Athlon(tm) 4 Processor
stepping        : 1
cpu MHz         : 950.037
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 1893.99

[7.3.] Module information (from /proc/modules):
maestro3               30544   2 (autoclean)
ac97_codec             17064   0 (autoclean) [maestro3]
soundcore               6500   2 (autoclean) [maestro3]
omnibook               36072   0 (unused)
parport_pc             18724   1 (autoclean)
lp                      8804   0 (autoclean)
parport                36576   1 (autoclean) [parport_pc lp]
ds                      8616   2
yenta_socket           13728   2
pcmcia_core            53600   0 [ds yenta_socket]
tulip                  44320   1
crc32                   3680   0 [tulip]
ide-scsi               12048   0
usbmouse                3192   0 (unused)
floppy                 56924   0 (autoclean)
ati_remote              6424   0 (unused)
usb-storage           129488   0
printer                 8928   0
scsi_mod               69044   2 [ide-scsi usb-storage]
ext2                   38560   1 (autoclean)
nls_iso8859-1           3548   1 (autoclean)
nls_cp437               5148   1 (autoclean)
vfat                   12908   1 (autoclean)
fat                    38840   0 (autoclean) [vfat]
mousedev                5460   1
keybdev                 2912   0 (unused)
hid                    24548   0 (unused)
input                   5696   0 [usbmouse ati_remote mousedev keybdev hid]
usb-ohci               21192   0 (unused)
usbcore                77408   1 [usbmouse ati_remote usb-storage printer 
hid usb-ohci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-100f : ALi Corporation M5229 IDE
  1000-1007 : ide0
  1008-100f : ide1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
8000-803f : ALi Corporation M7101 PMU
8040-805f : ALi Corporation M7101 PMU
8400-84ff : ESS Technology ES1988 Allegro-1
  8400-84ff : maestro3
8800-88ff : ESS Technology ESS Modem
8c00-8cff : Accton Technology Corporation EN-1216 Ethernet Adapter
  8c00-8cff : tulip
==============
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-00248981 : Kernel code
  00248982-002ca15f : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0fffffff : System RAM
10000000-10000fff : Texas Instruments PCI1420
10001000-10001fff : Texas Instruments PCI1420 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
e8001000-e80013ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  e8001000-e80013ff : tulip
e8100000-edffffff : PCI Bus #01
  e8100000-e8107fff : Trident Microsystems CyberBlade/XP
  e8400000-e87fffff : Trident Microsystems CyberBlade/XP
  ea000000-ebffffff : Trident Microsystems CyberBlade/XP
  ec000000-edffffff : Trident Microsystems CyberBlade/XP
    ec000000-ec2fffff : vesafb
f0000000-f3ffffff : ALi Corporation M1647 Northbridge [MAGiK 1 / MobileMAGiK 
1]
fff70000-fff70fff : ALi Corporation USB 1.1 Controller
  fff70000-fff70fff : usb-ohci
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1647 Northbridge [MAGiK 1 
/ MobileMAGiK 1] (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [b0] AGP version 2.0
                Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e8100000-edffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 
03) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fff70000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Hewlett-Packard Company: Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Hewlett-Packard Company: Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management 
Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA 
Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 
12)
        Subsystem: Hewlett-Packard Company: Unknown device 0018
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
        Subsystem: Hewlett-Packard Company: Unknown device 0018
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet 
Adapter (rev 11)
        Subsystem: Accton Technology Corporation: Unknown device 2242
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8c00 [size=256]
        Region 1: Memory at e8001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP (rev 
63) (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e8400000 (32-bit, non-prefetchable) [size=4M]
        Region 2: Memory at ea000000 (32-bit, non-prefetchable) [size=32M]
        Region 3: Memory at e8100000 (32-bit, non-prefetchable) [size=32K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] AGP version 2.0
                Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 1.25
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-R2102 Rev: 1016
  Type:   CD-ROM                           ANSI SCSI revision: 02

(Only used for scsi emulation for CD Burner)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Running a Pavilion XH545 Notebook. I currently run a 2.4.22 kernel, almost 
without problems. In the 2.4.22 kernel, I have ACPI enabled. There is about 
a fifty-fifty chance that it will boot. When kernel is compiled w/o ACPI, it 
boots 100%. With the 2.6 kernel, it is booting 100%, it just stops at a 
certain point. This is the on-screen kernel output relating to ACPI at the 
time of the freeze:

ACPI: Subsystem revision 20031002
  tbxface-0117 (03) acpi_load_tables   :  ACPI Tables successfully acquired
Parsing all control methods: ........................................
Table [DSDT](id F005) - 488 objects with 44 devices 140 methods 13 regions
Parsing all control methods:
Table [SSDT](id F003) - 3objects with 0 devices 0 methods 0 regions
ACPI Namespace successfully loaded at root c039867c
evxfevnt-0093 [04] acpi_enable   :   Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   :   GPE 00 to 63 [_GPE] 8 regs at 
0000000000008018   on int 9
spurious 8259A interrupt: IRQ7.
Completeing Region/Field/Buffer/Package 
initializations:.........................
Initialized 13/13 regions 0/0 Fields 22/22 Buffers 27/27 packages (499 
nodes)
Executing all Device _STA and_INI methods:........

The output stops here. The computer no longer responds to anything except 
the power button.

/proc/acpi/info:
version:                 20031002
states:                  S0 S1 S3 S4 S5

/proc/acpi/embedded_controller/EC0/info:
gpe bit:                 0x19
ports:                   0x66, 0x62
use global lock:         no


I am attaching the configuration file for the 2.6.0 kernel and my dmesg 
output for 2.4.22 (I have acpi debugging enabled and there is a lot of ACPI 
output in there). It works in 2.4.22 (Power button/etc register as events). 
Let me know if there is any other information that I can send you. Please 
keep me apprised of the situation.

Thank you for your help,
Chris

_________________________________________________________________
Check your PC for viruses with the FREE McAfee online computer scan.  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

------=_NextPart_000_4a5c_5973_7a0c
Content-Type: application/octet-stream; name="dmesg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg"

TGludXggdmVyc2lvbiAyLjQuMjIgKG1lQGxhcHRvcC5jb3dhcnRzLmxvY2Fs
KSAoZ2NjIHZlcnNpb24gMy4yIDIwMDIwOTAzIChSZWQgSGF0IExpbnV4IDgu
MCAzLjItNykpICMxIFNhdCBPY3QgMTggMjE6MzE6MzUgUERUIDIwMDMKQklP
Uy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgogQklPUy1lODIwOiAwMDAw
MDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZjAwMCAodXNhYmxlKQogQklP
Uy1lODIwOiAwMDAwMDAwMDAwMDlmMDAwIC0gMDAwMDAwMDAwMDBhMDAwMCAo
cmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwYzAwMDAgLSAwMDAw
MDAwMDAwMGNjMDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDAw
MDBkYzAwMCAtIDAwMDAwMDAwMDAwZTAwMDAgKHJlc2VydmVkKQogQklPUy1l
ODIwOiAwMDAwMDAwMDAwMGU4MDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVz
ZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAxMDAwMDAgLSAwMDAwMDAw
MDBmZWYwMDAwICh1c2FibGUpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMGZlZjAw
MDAgLSAwMDAwMDAwMDBmZWZmMDAwIChBQ1BJIGRhdGEpCiBCSU9TLWU4MjA6
IDAwMDAwMDAwMGZlZmYwMDAgLSAwMDAwMDAwMDBmZjAwMDAwIChBQ1BJIE5W
UykKIEJJT1MtZTgyMDogMDAwMDAwMDAwZmYwMDAwMCAtIDAwMDAwMDAwMTAw
MDAwMDAgKHVzYWJsZSkKIEJJT1MtZTgyMDogMDAwMDAwMDBmZmY4MDAwMCAt
IDAwMDAwMDAxMDAwMDAwMDAgKHJlc2VydmVkKQoyNTZNQiBMT1dNRU0gYXZh
aWxhYmxlLgpBQ1BJOiBoYXZlIHdha2V1cCBhZGRyZXNzIDB4YzAwMDEwMDAK
T24gbm9kZSAwIHRvdGFscGFnZXM6IDY1NTM2CnpvbmUoMCk6IDQwOTYgcGFn
ZXMuCnpvbmUoMSk6IDYxNDQwIHBhZ2VzLgp6b25lKDIpOiAwIHBhZ2VzLgpB
Q1BJOiBSU0RQICh2MDAwIFBUTFREICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICkgQCAweDAwMGY3ZWQwCkFDUEk6IFJTRFQgKHYwMDEg
UFRMVEQgICAgUlNEVCAgIDB4MDYwNDAwMDAgIExUUCAweDAwMDAwMDAwKSBA
IDB4MGZlZmIwMjMKQUNQSTogRkFEVCAodjAwMSBBTEkgICAgTTE1MzMgICAg
MHgwNjA0MDAwMCBQVEwgIDB4MDAwZjQyNDApIEAgMHgwZmVmZWU0YwpBQ1BJ
OiBCT09UICh2MDAxIFBUTFREICAkU0JGVEJMJCAweDA2MDQwMDAwICBMVFAg
MHgwMDAwMDAwMSkgQCAweDBmZWZlZWMwCkFDUEk6IFNTRFQgKHYwMDEgUFRM
VEQgIFBPV0VSTk9XIDB4MDYwNDAwMDAgIExUUCAweDAwMDAwMDAxKSBAIDB4
MGZlZmVlZTgKQUNQSTogRFNEVCAodjAwMSBDT01QQUwgICAgICA3MzYgMHgw
NjA0MDAwMCBNU0ZUIDB4MDEwMDAwMGQpIEAgMHgwMDAwMDAwMApLZXJuZWwg
Y29tbWFuZCBsaW5lOiBybyBoZGM9aWRlLXNjc2kgaWRlMD1kbWEgaWRlMT1k
bWEgaWRlMj1kbWEgdmdhPTc5MSBjcHVmcmVxPTM1MDAwMC05NTAwMDAgaWRl
YnVzPTY2CmlkZV9zZXR1cDogaGRjPWlkZS1zY3NpCmlkZV9zZXR1cDogaWRl
MD1kbWEKaWRlX3NldHVwOiBpZGUxPWRtYQppZGVfc2V0dXA6IGlkZTI9ZG1h
CmlkZV9zZXR1cDogaWRlYnVzPTY2CkxvY2FsIEFQSUMgZGlzYWJsZWQgYnkg
QklPUyAtLSByZWVuYWJsaW5nLgpGb3VuZCBhbmQgZW5hYmxlZCBsb2NhbCBB
UElDIQpJbml0aWFsaXppbmcgQ1BVIzAKRGV0ZWN0ZWQgOTUwLjAzNyBNSHog
cHJvY2Vzc29yLgpDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1
CkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4gMTg5My45OSBCb2dvTUlQUwpN
ZW1vcnk6IDI1NjcwMGsvMjYyMTQ0ayBhdmFpbGFibGUgKDEzMTRrIGtlcm5l
bCBjb2RlLCA0OTkyayByZXNlcnZlZCwgNTE3ayBkYXRhLCAxMDRrIGluaXQs
IDBrIGhpZ2htZW0pCkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6
IDMyNzY4IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpJbm9kZSBjYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNSwgMTMxMDcyIGJ5
dGVzKQpNb3VudCBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3Jk
ZXI6IDAsIDQwOTYgYnl0ZXMpCkJ1ZmZlciBjYWNoZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDE2Mzg0IChvcmRlcjogNCwgNjU1MzYgYnl0ZXMpClBhZ2UtY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0
NCBieXRlcykKRW5hYmxpbmcgRGlzYWJsZWQgSzcvU1NFIFN1cHBvcnQuLi4K
Q1BVOiBMMSBJIENhY2hlOiA2NEsgKDY0IGJ5dGVzL2xpbmUpLCBEIGNhY2hl
IDY0SyAoNjQgYnl0ZXMvbGluZSkKQ1BVOiBMMiBDYWNoZTogMjU2SyAoNjQg
Ynl0ZXMvbGluZSkKSW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUg
c3VwcG9ydGVkLgpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFi
bGVkIG9uIENQVSMwLgpDUFU6ICAgICBBZnRlciBnZW5lcmljLCBjYXBzOiAw
MzgzZmJmZiBjMWM3ZmJmZiAwMDAwMDAwMCAwMDAwMDAwMApDUFU6ICAgICAg
ICAgICAgIENvbW1vbiBjYXBzOiAwMzgzZmJmZiBjMWM3ZmJmZiAwMDAwMDAw
MCAwMDAwMDAwMApDUFU6IEFNRCBtb2JpbGUgQU1EIEF0aGxvbih0bSkgNCBQ
cm9jZXNzb3Igc3RlcHBpbmcgMDEKRW5hYmxpbmcgZmFzdCBGUFUgc2F2ZSBh
bmQgcmVzdG9yZS4uLiBkb25lLgpFbmFibGluZyB1bm1hc2tlZCBTSU1EIEZQ
VSBleGNlcHRpb24gc3VwcG9ydC4uLiBkb25lLgpDaGVja2luZyAnaGx0JyBp
bnN0cnVjdGlvbi4uLiBPSy4KUE9TSVggY29uZm9ybWFuY2UgdGVzdGluZyBi
eSBVTklGSVgKZW5hYmxlZCBFeHRJTlQgb24gQ1BVIzAKRVNSIHZhbHVlIGJl
Zm9yZSBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwCkVTUiB2YWx1ZSBhZnRl
ciBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwClVzaW5nIGxvY2FsIEFQSUMg
dGltZXIgaW50ZXJydXB0cy4KY2FsaWJyYXRpbmcgQVBJQyB0aW1lciAuLi4K
Li4uLi4gQ1BVIGNsb2NrIHNwZWVkIGlzIDk1MC4wNzIyIE1Iei4KLi4uLi4g
aG9zdCBidXMgY2xvY2sgc3BlZWQgaXMgMjAwLjAxNTIgTUh6LgpjcHU6IDAs
IGNsb2NrczogMjAwMDE1Miwgc2xpY2U6IDEwMDAwNzYKQ1BVMDxUMDoyMDAw
MTQ0LFQxOjEwMDAwNjQsRDo0LFM6MTAwMDA3NixDOjIwMDAxNTI+CkFDUEk6
IFN1YnN5c3RlbSByZXZpc2lvbiAyMDAzMTAwMgpQQ0k6IFBDSSBCSU9TIHJl
dmlzaW9uIDIuMTAgZW50cnkgYXQgMHhmZDhiMCwgbGFzdCBidXM9MQpQQ0k6
IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxCiB0YnhmYWNlLTAxMTcgWzAz
XSBhY3BpX2xvYWRfdGFibGVzICAgICAgOiBBQ1BJIFRhYmxlcyBzdWNjZXNz
ZnVsbHkgYWNxdWlyZWQKUGFyc2luZyBhbGwgQ29udHJvbCBNZXRob2RzOi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uClRhYmxlIFtEU0RUXShpZCBGMDA1KSAtIDQ4OCBPYmplY3RzIHdpdGgg
NDQgRGV2aWNlcyAxNDAgTWV0aG9kcyAxMyBSZWdpb25zClBhcnNpbmcgYWxs
IENvbnRyb2wgTWV0aG9kczoKVGFibGUgW1NTRFRdKGlkIEYwMDMpIC0gMyBP
YmplY3RzIHdpdGggMCBEZXZpY2VzIDAgTWV0aG9kcyAwIFJlZ2lvbnMKQUNQ
SSBOYW1lc3BhY2Ugc3VjY2Vzc2Z1bGx5IGxvYWRlZCBhdCByb290IGMwMmY1
YzdjCmV2eGZldm50LTAwOTMgWzA0XSBhY3BpX2VuYWJsZSAgICAgICAgICAg
OiBUcmFuc2l0aW9uIHRvIEFDUEkgbW9kZSBzdWNjZXNzZnVsCmV2Z3BlYmxr
LTA3NDggWzA2XSBldl9jcmVhdGVfZ3BlX2Jsb2NrICAgOiBHUEUgMDAgdG8g
NjMgW19HUEVdIDggcmVncyBhdCAwMDAwMDAwMDAwMDA4MDE4IG9uIGludCA5
CkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxkL0J1ZmZlci9QYWNrYWdlIGluaXRp
YWxpemF0aW9uOi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCkluaXRpYWxpemVkIDEzLzEz
IFJlZ2lvbnMgMC8wIEZpZWxkcyAyMi8yMiBCdWZmZXJzIDI3LzI3IFBhY2th
Z2VzICg0OTkgbm9kZXMpCkV4ZWN1dGluZyBhbGwgRGV2aWNlIF9TVEEgYW5k
X0lOSSBtZXRob2RzOi4uLi48Mz5zY2hlZHVsZV90YXNrKCk6IGtldmVudGQg
aGFzIG5vdCBzdGFydGVkCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uCjQ1IERldmljZXMgZm91bmQgY29udGFpbmluZzogNDUg
X1NUQSwgMSBfSU5JIG1ldGhvZHMKQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxl
ZApBQ1BJOiBVc2luZyBQSUMgZm9yIGludGVycnVwdCByb3V0aW5nCkFDUEk6
IFN5c3RlbSBbQUNQSV0gKHN1cHBvcnRzIFMwIFMxIFMzIFM0IFM1KQpBQ1BJ
OiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdICgwMDowMCkKUENJOiBQcm9iaW5n
IFBDSSBoYXJkd2FyZSAoYnVzIDAwKQpBQ1BJOiBQQ0kgSW50ZXJydXB0IFJv
dXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuX1BSVF0KQUNQSTogUENJIEludGVy
cnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLkFHUF8uX1BSVF0KQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtMTktBXSAoSVJRcyA1IDcgMTAgKjEx
KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0JdIChJUlFzICoxMSkK
QUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktDXSAoSVJRcyAqNSA3KQpB
Q1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0RdIChJUlFzIDUpCkFDUEk6
IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LVV0gKElSUXMgKjkpCkFDUEk6IEVt
YmVkZGVkIENvbnRyb2xsZXIgW0VDMF0gKGdwZSAyNSkKQUNQSTogUG93ZXIg
UmVzb3VyY2UgW1BGQU5dIChvZmYpClBDSTogUHJvYmluZyBQQ0kgaGFyZHdh
cmUKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktVXSBlbmFibGVkIGF0
IElSUSA5CkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0gZW5hYmxl
ZCBhdCBJUlEgMTEKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktDXSBl
bmFibGVkIGF0IElSUSA1CiBwY2lfaXJxLTAzMDUgWzI4XSBhY3BpX3BjaV9p
cnFfZGVyaXZlICAgOiBVbmFibGUgdG8gZGVyaXZlIElSUSBmb3IgZGV2aWNl
IDAwOjBmLjAKUENJOiBObyBJUlEga25vd24gZm9yIGludGVycnVwdCBwaW4g
QSBvZiBkZXZpY2UgMDA6MGYuMCAtIHVzaW5nIElSUSAyNTUKQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtMTktCXSBlbmFibGVkIGF0IElSUSAxMQpQQ0k6
IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nClBDSTogaWYgeW91IGV4cGVy
aWVuY2UgcHJvYmxlbXMsIHRyeSB1c2luZyBvcHRpb24gJ3BjaT1ub2FjcGkn
IG9yIGV2ZW4gJ2FjcGk9b2ZmJwpMaW1pdGluZyBkaXJlY3QgUENJL1BDSSB0
cmFuc2ZlcnMuCkxpbnV4IE5FVDQuMCBmb3IgTGludXggMi40CkJhc2VkIHVw
b24gU3dhbnNlYSBVbml2ZXJzaXR5IENvbXB1dGVyIFNvY2lldHkgTkVUMy4w
MzkKSW5pdGlhbGl6aW5nIFJUIG5ldGxpbmsgc29ja2V0ClN0YXJ0aW5nIGtz
d2FwZApKb3VybmFsbGVkIEJsb2NrIERldmljZSBkcml2ZXIgbG9hZGVkCkFD
UEk6IEFDIEFkYXB0ZXIgW0FDXSAob24tbGluZSkKQUNQSTogQmF0dGVyeSBT
bG90IFtCQVQwXSAoYmF0dGVyeSBwcmVzZW50KQpBQ1BJOiBQb3dlciBCdXR0
b24gKEZGKSBbUFdSRl0KQUNQSTogTGlkIFN3aXRjaCBbTElEXQpBQ1BJOiBT
bGVlcCBCdXR0b24gKENNKSBbU0JUTl0KYWNwaV9wcm9jZXNzb3ItMDg5OSBb
MzVdIGFjcGlfcHJvY2Vzc29yX2dldF9wZXI6IFVuc3VwcG9ydGVkIGFkZHJl
c3Mgc3BhY2UgWzEyN10gKGNvbnRyb2xfcmVnaXN0ZXIpCkFDUEk6IFByb2Nl
c3NvciBbQ1BVMF0gKHN1cHBvcnRzIEMxIEMyLCA4IHRocm90dGxpbmcgc3Rh
dGVzKQpbQUNQSSBEZWJ1Z10gU3RyaW5nOiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCltBQ1BJIERlYnVnXSBTdHJpbmc6IApbQUNQSSBE
ZWJ1Z10gU3RyaW5nOiBfU0NQCltBQ1BJIERlYnVnXSBTdHJpbmc6IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQUNQSTogVGhlcm1hbCBa
b25lIFtUSFJNXSAoNzUgQykKdmVzYWZiOiBmcmFtZWJ1ZmZlciBhdCAweGVj
MDAwMDAwLCBtYXBwZWQgdG8gMHhkMDgwYjAwMCwgc2l6ZSAzMDcyawp2ZXNh
ZmI6IG1vZGUgaXMgMTAyNHg3Njh4MTYsIGxpbmVsZW5ndGg9MjA0OCwgcGFn
ZXM9OQp2ZXNhZmI6IHByb3RlY3RlZCBtb2RlIGludGVyZmFjZSBpbmZvIGF0
IGMwMDA6NzY3MAp2ZXNhZmI6IHNjcm9sbGluZzogcmVkcmF3CnZlc2FmYjog
ZGlyZWN0Y29sb3I6IHNpemU9MDo1OjY6NSwgc2hpZnQ9MDoxMTo1OjAKQ29u
c29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNl
IDEyOHg0OApmYjA6IFZFU0EgVkdBIGZyYW1lIGJ1ZmZlciBkZXZpY2UKcHR5
OiAyNTYgVW5peDk4IHB0eXMgY29uZmlndXJlZApVbmlmb3JtIE11bHRpLVBs
YXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGJldGE0LTIuNApp
ZGU6IEFzc3VtaW5nIDY2TUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBt
b2RlcwpBTEkxNVgzOiBJREUgY29udHJvbGxlciBhdCBQQ0kgc2xvdCAwMDow
Zi4wCiBwY2lfaXJxLTAzMDUgWzI5XSBhY3BpX3BjaV9pcnFfZGVyaXZlICAg
OiBVbmFibGUgdG8gZGVyaXZlIElSUSBmb3IgZGV2aWNlIDAwOjBmLjAKUENJ
OiBObyBJUlEga25vd24gZm9yIGludGVycnVwdCBwaW4gQSBvZiBkZXZpY2Ug
MDA6MGYuMCAtIHVzaW5nIElSUSAyNTUKQUxJMTVYMzogY2hpcHNldCByZXZp
c2lvbiAxOTYKQUxJMTVYMzogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwg
cHJvYmUgaXJxcyBsYXRlcgogICAgaWRlMDogQk0tRE1BIGF0IDB4MTAwMC0w
eDEwMDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpETUEsIGhkYjpwaW8KICAgIGlk
ZTE6IEJNLURNQSBhdCAweDEwMDgtMHgxMDBmLCBCSU9TIHNldHRpbmdzOiBo
ZGM6RE1BLCBoZGQ6cGlvCmhkYTogVE9TSElCQSBNSzIwMThHQVAsIEFUQSBE
SVNLIGRyaXZlCmJsazogcXVldWUgYzAzMGJiMjAsIEkvTyBsaW1pdCA0MDk1
TWIgKG1hc2sgMHhmZmZmZmZmZikKaGRjOiBUT1NISUJBIERWRC1ST00gU0Qt
UjIxMDIsIEFUQVBJIENEL0RWRC1ST00gZHJpdmUKaWRlMCBhdCAweDFmMC0w
eDFmNywweDNmNiBvbiBpcnEgMTQKaWRlMSBhdCAweDE3MC0weDE3NywweDM3
NiBvbiBpcnEgMTUKaGRhOiBhdHRhY2hlZCBpZGUtZGlzayBkcml2ZXIuCmhk
YTogaG9zdCBwcm90ZWN0ZWQgYXJlYSA9PiAxCmhkYTogMzkwNzAwODAgc2Vj
dG9ycyAoMjAwMDQgTUIpLCBDSFM9MjQzMi8yNTUvNjMsIFVETUEoMzMpClBh
cnRpdGlvbiBjaGVjazoKIGhkYTogaGRhMSBoZGEyIGhkYTMgaGRhNCA8IGhk
YTUgaGRhNiBoZGE3IGhkYTggPgpORVQ0OiBMaW51eCBUQ1AvSVAgMS4wIGZv
ciBORVQ0LjAKSVAgUHJvdG9jb2xzOiBJQ01QLCBVRFAsIFRDUCwgSUdNUApJ
UDogcm91dGluZyBjYWNoZSBoYXNoIHRhYmxlIG9mIDIwNDggYnVja2V0cywg
MTZLYnl0ZXMKVENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxp
c2hlZCAxNjM4NCBiaW5kIDMyNzY4KQpORVQ0OiBVbml4IGRvbWFpbiBzb2Nr
ZXRzIDEuMC9TTVAgZm9yIExpbnV4IE5FVDQuMC4Ka2pvdXJuYWxkIHN0YXJ0
aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcwpFWFQzLWZzOiBtb3Vu
dGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZS4KVkZTOiBN
b3VudGVkIHJvb3QgKGV4dDMgZmlsZXN5c3RlbSkgcmVhZG9ubHkuCkZyZWVp
bmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDEwNGsgZnJlZWQKc3B1cmlvdXMg
ODI1OUEgaW50ZXJydXB0OiBJUlE3Lgp1c2IuYzogcmVnaXN0ZXJlZCBuZXcg
ZHJpdmVyIHVzYmRldmZzCnVzYi5jOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIg
aHViCnVzYi1vaGNpLmM6IFVTQiBPSENJIGF0IG1lbWJhc2UgMHhkMGIyOTAw
MCwgSVJRIDkKdXNiLW9oY2kuYzogdXNiLTAwOjAyLjAsIEFMaSBDb3Jwb3Jh
dGlvbiBVU0IgMS4xIENvbnRyb2xsZXIKdXNiLmM6IG5ldyBVU0IgYnVzIHJl
Z2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMQpodWIuYzogVVNCIGh1
YiBmb3VuZApodWIuYzogMiBwb3J0cyBkZXRlY3RlZAp1c2IuYzogcmVnaXN0
ZXJlZCBuZXcgZHJpdmVyIGhpZGRldgp1c2IuYzogcmVnaXN0ZXJlZCBuZXcg
ZHJpdmVyIGhpZApoaWQtY29yZS5jOiB2MS44LjEgQW5kcmVhcyBHYWwsIFZv
anRlY2ggUGF2bGlrIDx2b2p0ZWNoQHN1c2UuY3o+CmhpZC1jb3JlLmM6IFVT
QiBISUQgc3VwcG9ydCBkcml2ZXJzCm1pY2U6IFBTLzIgbW91c2UgZGV2aWNl
IGNvbW1vbiBmb3IgYWxsIG1pY2UKaHViLmM6IG5ldyBVU0IgZGV2aWNlIDAw
OjAyLjAtMiwgYXNzaWduZWQgYWRkcmVzcyAyCmh1Yi5jOiBVU0IgaHViIGZv
dW5kCmh1Yi5jOiA0IHBvcnRzIGRldGVjdGVkCkVYVDMgRlMgMi40LTAuOS4x
OSwgMTkgQXVndXN0IDIwMDIgb24gaWRlMCgzLDUpLCBpbnRlcm5hbCBqb3Vy
bmFsCkFkZGluZyBTd2FwOiA1MzAxMDRrIHN3YXAtc3BhY2UgKHByaW9yaXR5
IC0xKQpBZGRpbmcgU3dhcDogMzA1MTkyayBzd2FwLXNwYWNlIChwcmlvcml0
eSAtMikKaHViLmM6IG5ldyBVU0IgZGV2aWNlIDAwOjAyLjAtMi4xLCBhc3Np
Z25lZCBhZGRyZXNzIDMKdXNiLmM6IFVTQiBkZXZpY2UgMyAodmVuZC9wcm9k
IDB4NzgxLzB4ODE4NSkgaXMgbm90IGNsYWltZWQgYnkgYW55IGFjdGl2ZSBk
cml2ZXIuCmh1Yi5jOiBuZXcgVVNCIGRldmljZSAwMDowMi4wLTIuMiwgYXNz
aWduZWQgYWRkcmVzcyA0CnVzYi5jOiBVU0IgZGV2aWNlIDQgKHZlbmQvcHJv
ZCAweDRiOC8weDUpIGlzIG5vdCBjbGFpbWVkIGJ5IGFueSBhY3RpdmUgZHJp
dmVyLgpodWIuYzogbmV3IFVTQiBkZXZpY2UgMDA6MDIuMC0yLjMsIGFzc2ln
bmVkIGFkZHJlc3MgNQp1c2IuYzogVVNCIGRldmljZSA1ICh2ZW5kL3Byb2Qg
MHhiYzcvMHg0KSBpcyBub3QgY2xhaW1lZCBieSBhbnkgYWN0aXZlIGRyaXZl
ci4KaHViLmM6IG5ldyBVU0IgZGV2aWNlIDAwOjAyLjAtMi40LCBhc3NpZ25l
ZCBhZGRyZXNzIDYKaW5wdXQ6IFVTQiBISUQgdjEuMTAgTW91c2UgW01pY3Jv
c29mdCBNaWNyb3NvZnQgNS1CdXR0b24gTW91c2Ugd2l0aCBJbnRlbGxpRXll
KFRNKV0gb24gdXNiMTo2LjAKa2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0
IGludGVydmFsIDUgc2Vjb25kcwpFWFQzIEZTIDIuNC0wLjkuMTksIDE5IEF1
Z3VzdCAyMDAyIG9uIGlkZTAoMyw3KSwgaW50ZXJuYWwgam91cm5hbApFWFQz
LWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9k
ZS4KRVhUMi1mcyB3YXJuaW5nOiBtb3VudGluZyB1bmNoZWNrZWQgZnMsIHJ1
bm5pbmcgZTJmc2NrIGlzIHJlY29tbWVuZGVkClNDU0kgc3Vic3lzdGVtIGRy
aXZlciBSZXZpc2lvbjogMS4wMAp1c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJp
dmVyIHVzYmxwCnByaW50ZXIuYzogdXNibHAwOiBVU0IgQmlkaXJlY3Rpb25h
bCBwcmludGVyIGRldiA0IGlmIDAgYWx0IDAgcHJvdG8gMiB2aWQgMHgwNEI4
IHBpZCAweDAwMDUKcHJpbnRlci5jOiB2MC4xMTogVVNCIFByaW50ZXIgRGV2
aWNlIENsYXNzIGRyaXZlcgpJbml0aWFsaXppbmcgVVNCIE1hc3MgU3RvcmFn
ZSBkcml2ZXIuLi4KdXNiLmM6IHJlZ2lzdGVyZWQgbmV3IGRyaXZlciB1c2It
c3RvcmFnZQp1c2Itc3RvcmFnZTogYWN0X2FsdHNldHR0aW5nIGlzIDAKdXNi
LXN0b3JhZ2U6IGlkX2luZGV4IGNhbGN1bGF0ZWQgdG8gYmU6IDk4CnVzYi1z
dG9yYWdlOiBBcnJheSBsZW5ndGggYXBwZWFycyB0byBiZTogMTAwCnVzYi1z
dG9yYWdlOiBVU0IgTWFzcyBTdG9yYWdlIGRldmljZSBkZXRlY3RlZAp1c2It
c3RvcmFnZTogRW5kcG9pbnRzOiBJbjogMHhjZmZiOGQ4MCBPdXQ6IDB4Y2Zm
YjhkOTQgSW50OiAweDAwMDAwMDAwIChQZXJpb2QgMCkKdXNiLXN0b3JhZ2U6
IE5ldyBHVUlEIDA3ODE4MTg1MDAwMDAwMDAwMDIyNTM0NQp1c2Itc3RvcmFn
ZTogR2V0TWF4TFVOIGNvbW1hbmQgcmVzdWx0IGlzIDEsIGRhdGEgaXMgMAp1
c2Itc3RvcmFnZTogVHJhbnNwb3J0OiBCdWxrCnVzYi1zdG9yYWdlOiBQcm90
b2NvbDogVHJhbnNwYXJlbnQgU0NTSQp1c2Itc3RvcmFnZTogKioqIHRocmVh
ZCBzbGVlcGluZy4Kc2NzaTAgOiBTQ1NJIGVtdWxhdGlvbiBmb3IgVVNCIE1h
c3MgU3RvcmFnZSBkZXZpY2VzCnVzYi1zdG9yYWdlOiBxdWV1ZWNvbW1hbmQo
KSBjYWxsZWQKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQgYXdha2VuZWQuCnVz
Yi1zdG9yYWdlOiBDb21tYW5kIElOUVVJUlkgKDYgYnl0ZXMpCnVzYi1zdG9y
YWdlOiAxMiAwMCAwMCAwMCBmZiAwMCA5NiBjZiBhYyBjMCA4NCBjZgp1c2It
c3RvcmFnZTogQnVsayBjb21tYW5kIFMgMHg0MzQyNTM1NSBUIDB4MSBUcmcg
MCBMVU4gMCBMIDI1NSBGIDEyOCBDTCA2CnVzYi1zdG9yYWdlOiBCdWxrIGNv
bW1hbmQgdHJhbnNmZXIgcmVzdWx0PTAKdXNiLXN0b3JhZ2U6IHVzYl9zdG9y
X3RyYW5zZmVyX3BhcnRpYWwoKTogeGZlciAyNTUgYnl0ZXMKdXNiLXN0b3Jh
Z2U6IHVzYl9zdG9yX2J1bGtfbXNnKCkgcmV0dXJuZWQgMCB4ZmVycmVkIDM2
LzI1NQp1c2Itc3RvcmFnZTogQnVsayBkYXRhIHRyYW5zZmVyIHJlc3VsdCAw
eDEKdXNiLXN0b3JhZ2U6IEF0dGVtcHRpbmcgdG8gZ2V0IENTVy4uLgp1c2It
c3RvcmFnZTogY2xlYXJpbmcgZW5kcG9pbnQgaGFsdCBmb3IgcGlwZSAweGMw
MDA4MzgwCnVzYi1zdG9yYWdlOiB1c2Jfc3Rvcl9jbGVhcl9oYWx0OiByZXN1
bHQ9MAp1c2Itc3RvcmFnZTogQXR0ZW1wdGluZyB0byBnZXQgQ1NXICgybmQg
dHJ5KS4uLgp1c2Itc3RvcmFnZTogQnVsayBzdGF0dXMgcmVzdWx0ID0gMAp1
c2Itc3RvcmFnZTogQnVsayBzdGF0dXMgU2lnIDB4NTM0MjUzNTUgVCAweDEg
UiAyMTkgU3RhdCAweDAKdXNiLXN0b3JhZ2U6IEZpeGluZyBJTlFVSVJZIGRh
dGEgdG8gc2hvdyBTQ1NJIHJldiAyIC0gd2FzIDAKdXNiLXN0b3JhZ2U6IHNj
c2kgY21kIGRvbmUsIHJlc3VsdD0weDAKdXNiLXN0b3JhZ2U6ICoqKiB0aHJl
YWQgc2xlZXBpbmcuCiAgVmVuZG9yOiBHZW5lcmljICAgTW9kZWw6IFNUT1JB
R0UgREVWSUNFICAgIFJldjogMS4yNQogIFR5cGU6ICAgRGlyZWN0LUFjY2Vz
cyAgICAgICAgICAgICAgICAgICAgICBBTlNJIFNDU0kgcmV2aXNpb246IDAy
CnVzYi1zdG9yYWdlOiBxdWV1ZWNvbW1hbmQoKSBjYWxsZWQKdXNiLXN0b3Jh
Z2U6ICoqKiB0aHJlYWQgYXdha2VuZWQuCnVzYi1zdG9yYWdlOiBCYWQgdGFy
Z2V0IG51bWJlciAoMS8wKQp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBzbGVl
cGluZy4KdXNiLXN0b3JhZ2U6IHF1ZXVlY29tbWFuZCgpIGNhbGxlZAp1c2It
c3RvcmFnZTogKioqIHRocmVhZCBhd2FrZW5lZC4KdXNiLXN0b3JhZ2U6IEJh
ZCB0YXJnZXQgbnVtYmVyICgyLzApCnVzYi1zdG9yYWdlOiAqKiogdGhyZWFk
IHNsZWVwaW5nLgp1c2Itc3RvcmFnZTogcXVldWVjb21tYW5kKCkgY2FsbGVk
CnVzYi1zdG9yYWdlOiAqKiogdGhyZWFkIGF3YWtlbmVkLgp1c2Itc3RvcmFn
ZTogQmFkIHRhcmdldCBudW1iZXIgKDMvMCkKdXNiLXN0b3JhZ2U6ICoqKiB0
aHJlYWQgc2xlZXBpbmcuCnVzYi1zdG9yYWdlOiBxdWV1ZWNvbW1hbmQoKSBj
YWxsZWQKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQgYXdha2VuZWQuCnVzYi1z
dG9yYWdlOiBCYWQgdGFyZ2V0IG51bWJlciAoNC8wKQp1c2Itc3RvcmFnZTog
KioqIHRocmVhZCBzbGVlcGluZy4KdXNiLXN0b3JhZ2U6IHF1ZXVlY29tbWFu
ZCgpIGNhbGxlZAp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBhd2FrZW5lZC4K
dXNiLXN0b3JhZ2U6IEJhZCB0YXJnZXQgbnVtYmVyICg1LzApCnVzYi1zdG9y
YWdlOiAqKiogdGhyZWFkIHNsZWVwaW5nLgp1c2Itc3RvcmFnZTogcXVldWVj
b21tYW5kKCkgY2FsbGVkCnVzYi1zdG9yYWdlOiAqKiogdGhyZWFkIGF3YWtl
bmVkLgp1c2Itc3RvcmFnZTogQmFkIHRhcmdldCBudW1iZXIgKDYvMCkKdXNi
LXN0b3JhZ2U6ICoqKiB0aHJlYWQgc2xlZXBpbmcuCnVzYi1zdG9yYWdlOiBx
dWV1ZWNvbW1hbmQoKSBjYWxsZWQKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQg
YXdha2VuZWQuCnVzYi1zdG9yYWdlOiBCYWQgdGFyZ2V0IG51bWJlciAoNy8w
KQp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBzbGVlcGluZy4KV0FSTklORzog
VVNCIE1hc3MgU3RvcmFnZSBkYXRhIGludGVncml0eSBub3QgYXNzdXJlZApV
U0IgTWFzcyBTdG9yYWdlIGRldmljZSBmb3VuZCBhdCAzClVTQiBNYXNzIFN0
b3JhZ2Ugc3VwcG9ydCByZWdpc3RlcmVkLgp1c2IuYzogcmVnaXN0ZXJlZCBu
ZXcgZHJpdmVyIGF0aV9yZW1vdGUKbWF4cD04IGVuZHBvaW50PTB4ODEKYklu
dGVydmFsPTEwClgxMCBXaXJlbGVzcyBUZWNobm9sb2d5IEluYyBVU0IgUmVj
ZWl2ZXIgb24gdXNiMTo1LjAKCXJlbW90ZSBjb250cm9sIGNoYW5uZWwgMSBj
b3JyZXNwb25kcyB0byBpbnB1dDEKCXJlbW90ZSBjb250cm9sIGNoYW5uZWwg
MiBjb3JyZXNwb25kcyB0byBpbnB1dDIKCXJlbW90ZSBjb250cm9sIGNoYW5u
ZWwgMyBjb3JyZXNwb25kcyB0byBpbnB1dDMKCXJlbW90ZSBjb250cm9sIGNo
YW5uZWwgNCBjb3JyZXNwb25kcyB0byBpbnB1dDQKCXJlbW90ZSBjb250cm9s
IGNoYW5uZWwgNSBjb3JyZXNwb25kcyB0byBpbnB1dDUKCXJlbW90ZSBjb250
cm9sIGNoYW5uZWwgNiBjb3JyZXNwb25kcyB0byBpbnB1dDYKCXJlbW90ZSBj
b250cm9sIGNoYW5uZWwgNyBjb3JyZXNwb25kcyB0byBpbnB1dDcKCXJlbW90
ZSBjb250cm9sIGNoYW5uZWwgOCBjb3JyZXNwb25kcyB0byBpbnB1dDgKCXJl
bW90ZSBjb250cm9sIGNoYW5uZWwgOSBjb3JyZXNwb25kcyB0byBpbnB1dDkK
CXJlbW90ZSBjb250cm9sIGNoYW5uZWwgMTAgY29ycmVzcG9uZHMgdG8gaW5w
dXQxMAoJcmVtb3RlIGNvbnRyb2wgY2hhbm5lbCAxMSBjb3JyZXNwb25kcyB0
byBpbnB1dDExCglyZW1vdGUgY29udHJvbCBjaGFubmVsIDEyIGNvcnJlc3Bv
bmRzIHRvIGlucHV0MTIKCXJlbW90ZSBjb250cm9sIGNoYW5uZWwgMTMgY29y
cmVzcG9uZHMgdG8gaW5wdXQxMwoJcmVtb3RlIGNvbnRyb2wgY2hhbm5lbCAx
NCBjb3JyZXNwb25kcyB0byBpbnB1dDE0CglyZW1vdGUgY29udHJvbCBjaGFu
bmVsIDE1IGNvcnJlc3BvbmRzIHRvIGlucHV0MTUKCXJlbW90ZSBjb250cm9s
IGNoYW5uZWwgMTYgY29ycmVzcG9uZHMgdG8gaW5wdXQxNgphdGlfcmVtb3Rl
LmM6IDIuMS4wOlVTQiBBVEkgUmVtb3RlIGRyaXZlcgppbnNlcnRpbmcgZmxv
cHB5IGRyaXZlciBmb3IgMi40LjIyCkZsb3BweSBkcml2ZShzKTogZmQwIGlz
IDEuNDRNCkZEQyAwIGlzIGEgcG9zdC0xOTkxIDgyMDc3CnVzYi5jOiByZWdp
c3RlcmVkIG5ldyBkcml2ZXIgdXNibW91c2UKdXNibW91c2UuYzogdjEuNjpV
U0IgSElEIEJvb3QgUHJvdG9jb2wgbW91c2UgZHJpdmVyCmhkYzogYXR0YWNo
ZWQgaWRlLXNjc2kgZHJpdmVyLgpzY3NpMSA6IFNDU0kgaG9zdCBhZGFwdGVy
IGVtdWxhdGlvbiBmb3IgSURFIEFUQVBJIGRldmljZXMKICBWZW5kb3I6IFRP
U0hJQkEgICBNb2RlbDogRFZELVJPTSBTRC1SMjEwMiAgUmV2OiAxMDE2CiAg
VHlwZTogICBDRC1ST00gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFO
U0kgU0NTSSByZXZpc2lvbjogMDIKTGludXggVHVsaXAgZHJpdmVyIHZlcnNp
b24gMC45LjE1LXByZTEyIChBdWcgOSwgMjAwMikKZXRoMDogQURNdGVrIENv
bWV0IHJldiAxNyBhdCAweDhjMDAsIDAwOkQwOjU5OkExOkFGOjJCLCBJUlEg
MTEuCkxpbnV4IEtlcm5lbCBDYXJkIFNlcnZpY2VzIDMuMS4yMgogIG9wdGlv
bnM6ICBbcGNpXSBbY2FyZGJ1c10gW3BtXQpZZW50YSBJUlEgbGlzdCAwNGI4
LCBQQ0kgaXJxMTEKU29ja2V0IHN0YXR1czogMzAwMDAwMDYKWWVudGEgSVJR
IGxpc3QgMDRiOCwgUENJIGlycTExClNvY2tldCBzdGF0dXM6IDMwMDAwMDA2
CmFwbTogQklPUyB2ZXJzaW9uIDEuMiBGbGFncyAweDAzIChEcml2ZXIgdmVy
c2lvbiAxLjE2KQphcG06IG92ZXJyaWRkZW4gYnkgQUNQSS4KcGFycG9ydDA6
IFBDLXN0eWxlIGF0IDB4Mzc4ICgweDc3OCkgW1BDU1BQLFRSSVNUQVRFXQpw
YXJwb3J0MDogaXJxIDcgZGV0ZWN0ZWQKbHAwOiB1c2luZyBwYXJwb3J0MCAo
cG9sbGluZykuCmxwMDogY29uc29sZSByZWFkeQpvbW5pYm9vazogbW9kdWxl
IHZlcnNpb24gMjAwMy0wOC0yOC4Kb21uaWJvb2s6IEZvcmNlZCBsb2FkIHdp
dGggRUMgZmlybXdhcmUgdHlwZSAyLgpvbW5pYm9vazogQUMgYWRhcHRlciBz
dGF0dXMgbW9uaXRvcmluZyBpcyBlbmFibGVkLgpvbW5pYm9vazogQmF0dGVy
eSBzdGF0dXMgbW9uaXRvcmluZyBpcyBlbmFibGVkLgpvbW5pYm9vazogL3By
b2MvYXBtIGVtdWxhdGlvbiBlbmFibGVkLgpvbW5pYm9vazogTENEIGRpc3Bs
YXkgdHVybiBvZmYgYXQgY29uc29sZSBibGFua2luZyBlbmFibGVkLgpvbW5p
Ym9vazogRXh0ZXJuYWwgZGlzcGxheSBzdGF0dXMgbW9uaXRvcmluZyBpcyBl
bmFibGVkLgpvbW5pYm9vazogRmFuIHN0YXR1cyBtb25pdG9yIGFuZCBjb250
cm9sIGlzIHVuc3VwcG9ydGVkIG9uIHRoaXMgbWFjaGluZS4Kb21uaWJvb2s6
IEZhbiBwb2xpY3kgaXMgdW5zdXBwb3J0ZWQgb24gdGhpcyBtYWNoaW5lLgpv
bW5pYm9vazogS2V5IHBvbGxpbmcgaXMgZW5hYmxlZC4Kb21uaWJvb2s6IExD
RCBicmlnaHRuZXNzIGhhbmRsaW5nIGlzIGVuYWJsZWQuCm9tbmlib29rOiBP
bmVUb3VjaCBidXR0b25zIGFyZSBlbmFibGVkLgpvbW5pYm9vazogVGVtcGVy
YXR1cmUgbW9uaXRvcmluZyBpcyBlbmFibGVkLgptYWVzdHJvMzogdmVyc2lv
biAxLjIzIGJ1aWx0IGF0IDIxOjI1OjA4IE9jdCAxOCAyMDAzCm1hZXN0cm8z
OiBDb25maWd1cmluZyBFU1MgQWxsZWdybyBmb3VuZCBhdCBJTyAweDg0MDAg
SVJRIDUKbWFlc3RybzM6ICBzdWJ2ZW5kb3IgaWQ6IDB4MDAxODEwM2MKYWM5
N19jb2RlYzogQUM5NyBBdWRpbyBjb2RlYywgaWQ6IDB4NDU4MzoweDgzMDgg
KEVTUyBBbGxlZ3JvIEVTMTk4OCkKaTgyNTMgY291bnQgdG9vIGhpZ2ghIHJl
c2V0dGluZy4uCg==


------=_NextPart_000_4a5c_5973_7a0c
Content-Type: application/octet-stream; name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24n
dCBlZGl0CiMKQ09ORklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfVUlE
MTY9eQpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKCiMKIyBDb2RlIG1hdHVy
aXR5IGxldmVsIG9wdGlvbnMKIwpDT05GSUdfRVhQRVJJTUVOVEFMPXkKQ09O
RklHX0NMRUFOX0NPTVBJTEU9eQpDT05GSUdfU1RBTkRBTE9ORT15CkNPTkZJ
R19CUk9LRU5fT05fU01QPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklH
X1NXQVA9eQpDT05GSUdfU1lTVklQQz15CiMgQ09ORklHX0JTRF9QUk9DRVNT
X0FDQ1QgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0xPR19C
VUZfU0hJRlQ9MTQKIyBDT05GSUdfSUtDT05GSUcgaXMgbm90IHNldAojIENP
TkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19LQUxMU1lNUz15CkNP
TkZJR19GVVRFWD15CkNPTkZJR19FUE9MTD15CkNPTkZJR19JT1NDSEVEX05P
T1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RFQURM
SU5FPXkKCiMKIyBMb2FkYWJsZSBtb2R1bGUgc3VwcG9ydAojCkNPTkZJR19N
T0RVTEVTPXkKQ09ORklHX01PRFVMRV9VTkxPQUQ9eQpDT05GSUdfTU9EVUxF
X0ZPUkNFX1VOTE9BRD15CkNPTkZJR19PQlNPTEVURV9NT0RQQVJNPXkKQ09O
RklHX01PRFZFUlNJT05TPXkKQ09ORklHX0tNT0Q9eQoKIwojIFByb2Nlc3Nv
ciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19YODZfUEM9eQojIENPTkZJ
R19YODZfVk9ZQUdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9OVU1BUSBp
cyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TVU1NSVQgaXMgbm90IHNldAojIENP
TkZJR19YODZfQklHU01QIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1ZJU1dT
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dFTkVSSUNBUkNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWDg2X0VTNzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX00z
ODYgaXMgbm90IHNldAojIENPTkZJR19NNDg2IGlzIG5vdCBzZXQKIyBDT05G
SUdfTTU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZUU0MgaXMgbm90IHNl
dAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKIyBDT05GSUdfTTY4NiBp
cyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUkgaXMgbm90IHNldAojIENP
TkZJR19NUEVOVElVTUlJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVN
NCBpcyBub3Qgc2V0CiMgQ09ORklHX01LNiBpcyBub3Qgc2V0CkNPTkZJR19N
Szc9eQojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NRUxBTiBp
cyBub3Qgc2V0CiMgQ09ORklHX01DUlVTT0UgaXMgbm90IHNldAojIENPTkZJ
R19NV0lOQ0hJUEM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVAyIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVAzRCBpcyBub3Qgc2V0CiMgQ09O
RklHX01DWVJJWElJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01WSUFDM18yIGlz
IG5vdCBzZXQKIyBDT05GSUdfWDg2X0dFTkVSSUMgaXMgbm90IHNldApDT05G
SUdfWDg2X0NNUFhDSEc9eQpDT05GSUdfWDg2X1hBREQ9eQpDT05GSUdfWDg2
X0wxX0NBQ0hFX1NISUZUPTYKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxHT1JJ
VEhNPXkKQ09ORklHX1g4Nl9XUF9XT1JLU19PSz15CkNPTkZJR19YODZfSU5W
TFBHPXkKQ09ORklHX1g4Nl9CU1dBUD15CkNPTkZJR19YODZfUE9QQURfT0s9
eQpDT05GSUdfWDg2X0dPT0RfQVBJQz15CkNPTkZJR19YODZfSU5URUxfVVNF
UkNPUFk9eQpDT05GSUdfWDg2X1VTRV9QUFJPX0NIRUNLU1VNPXkKQ09ORklH
X1g4Nl9VU0VfM0ROT1c9eQojIENPTkZJR19IUEVUX1RJTUVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFBFVF9FTVVMQVRFX1JUQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNl
dApDT05GSUdfWDg2X1VQX0FQSUM9eQpDT05GSUdfWDg2X1VQX0lPQVBJQz15
CkNPTkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfSU9fQVBJQz15
CkNPTkZJR19YODZfVFNDPXkKQ09ORklHX1g4Nl9NQ0U9eQpDT05GSUdfWDg2
X01DRV9OT05GQVRBTD15CiMgQ09ORklHX1g4Nl9NQ0VfUDRUSEVSTUFMIGlz
IG5vdCBzZXQKQ09ORklHX1RPU0hJQkE9bQpDT05GSUdfSThLPW0KQ09ORklH
X01JQ1JPQ09ERT1tCkNPTkZJR19YODZfTVNSPW0KQ09ORklHX1g4Nl9DUFVJ
RD1tCiMgQ09ORklHX0VERCBpcyBub3Qgc2V0CkNPTkZJR19OT0hJR0hNRU09
eQojIENPTkZJR19ISUdITUVNNEcgaXMgbm90IHNldAojIENPTkZJR19ISUdI
TUVNNjRHIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJT04gaXMg
bm90IHNldAojIENPTkZJR19NVFJSIGlzIG5vdCBzZXQKCiMKIyBQb3dlciBt
YW5hZ2VtZW50IG9wdGlvbnMgKEFDUEksIEFQTSkKIwpDT05GSUdfUE09eQpD
T05GSUdfU09GVFdBUkVfU1VTUEVORD15CkNPTkZJR19QTV9ESVNLPXkKQ09O
RklHX1BNX0RJU0tfUEFSVElUSU9OPSIvZGV2L2hkYTEiCgojCiMgQUNQSSAo
QWR2YW5jZWQgQ29uZmlndXJhdGlvbiBhbmQgUG93ZXIgSW50ZXJmYWNlKSBT
dXBwb3J0CiMKQ09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9CT09UPXkKQ09O
RklHX0FDUElfSU5URVJQUkVURVI9eQpDT05GSUdfQUNQSV9TTEVFUD15CkNP
TkZJR19BQ1BJX1NMRUVQX1BST0NfRlM9eQpDT05GSUdfQUNQSV9BQz15CkNP
TkZJR19BQ1BJX0JBVFRFUlk9eQpDT05GSUdfQUNQSV9CVVRUT049eQpDT05G
SUdfQUNQSV9GQU49eQpDT05GSUdfQUNQSV9QUk9DRVNTT1I9eQpDT05GSUdf
QUNQSV9USEVSTUFMPXkKQ09ORklHX0FDUElfQVNVUz15CkNPTkZJR19BQ1BJ
X1RPU0hJQkE9bQpDT05GSUdfQUNQSV9ERUJVRz15CkNPTkZJR19BQ1BJX0JV
Uz15CkNPTkZJR19BQ1BJX0VDPXkKQ09ORklHX0FDUElfUE9XRVI9eQpDT05G
SUdfQUNQSV9QQ0k9eQpDT05GSUdfQUNQSV9TWVNURU09eQojIENPTkZJR19B
Q1BJX1JFTEFYRURfQU1MIGlzIG5vdCBzZXQKCiMKIyBBUE0gKEFkdmFuY2Vk
IFBvd2VyIE1hbmFnZW1lbnQpIEJJT1MgU3VwcG9ydAojCkNPTkZJR19BUE09
bQpDT05GSUdfQVBNX0lHTk9SRV9VU0VSX1NVU1BFTkQ9eQpDT05GSUdfQVBN
X0RPX0VOQUJMRT15CkNPTkZJR19BUE1fQ1BVX0lETEU9eQpDT05GSUdfQVBN
X0RJU1BMQVlfQkxBTks9eQpDT05GSUdfQVBNX1JUQ19JU19HTVQ9eQpDT05G
SUdfQVBNX0FMTE9XX0lOVFM9eQpDT05GSUdfQVBNX1JFQUxfTU9ERV9QT1dF
Ul9PRkY9eQoKIwojIENQVSBGcmVxdWVuY3kgc2NhbGluZwojCkNPTkZJR19D
UFVfRlJFUT15CkNPTkZJR19DUFVfRlJFUV9QUk9DX0lOVEY9eQojIENPTkZJ
R19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0
CkNPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9VU0VSU1BBQ0U9eQpDT05G
SUdfQ1BVX0ZSRVFfR09WX1BFUkZPUk1BTkNFPXkKQ09ORklHX0NQVV9GUkVR
X0dPVl9QT1dFUlNBVkU9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX1VTRVJTUEFD
RT15CkNPTkZJR19DUFVfRlJFUV8yNF9BUEk9eQpDT05GSUdfQ1BVX0ZSRVFf
VEFCTEU9eQoKIwojIENQVUZyZXEgcHJvY2Vzc29yIGRyaXZlcnMKIwpDT05G
SUdfWDg2X0FDUElfQ1BVRlJFUT1tCkNPTkZJR19YODZfQUNQSV9DUFVGUkVR
X1BST0NfSU5URj15CiMgQ09ORklHX1g4Nl9QT1dFUk5PV19LNiBpcyBub3Qg
c2V0CkNPTkZJR19YODZfUE9XRVJOT1dfSzc9eQojIENPTkZJR19YODZfUE9X
RVJOT1dfSzggaXMgbm90IHNldAojIENPTkZJR19YODZfR1hfU1VTUE1PRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TUEVFRFNURVBfQ0VOVFJJTk8gaXMg
bm90IHNldAojIENPTkZJR19YODZfU1BFRURTVEVQX0lDSCBpcyBub3Qgc2V0
CiMgQ09ORklHX1g4Nl9TUEVFRFNURVBfU01JIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDg2X1A0X0NMT0NLTU9EIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0xP
TkdSVU4gaXMgbm90IHNldAojIENPTkZJR19YODZfTE9OR0hBVUwgaXMgbm90
IHNldAoKIwojIEJ1cyBvcHRpb25zIChQQ0ksIFBDTUNJQSwgRUlTQSwgTUNB
LCBJU0EpCiMKQ09ORklHX1BDST15CiMgQ09ORklHX1BDSV9HT0JJT1MgaXMg
bm90IHNldAojIENPTkZJR19QQ0lfR09ESVJFQ1QgaXMgbm90IHNldApDT05G
SUdfUENJX0dPQU5ZPXkKQ09ORklHX1BDSV9CSU9TPXkKQ09ORklHX1BDSV9E
SVJFQ1Q9eQpDT05GSUdfUENJX0xFR0FDWV9QUk9DPXkKQ09ORklHX1BDSV9O
QU1FUz15CiMgQ09ORklHX0lTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDeDIwMCBpcyBub3Qgc2V0CkNPTkZJR19I
T1RQTFVHPXkKCiMKIyBQQ01DSUEvQ2FyZEJ1cyBzdXBwb3J0CiMKQ09ORklH
X1BDTUNJQT15CiMgQ09ORklHX1lFTlRBIGlzIG5vdCBzZXQKIyBDT05GSUdf
STgyMDkyIGlzIG5vdCBzZXQKIyBDT05GSUdfVENJQyBpcyBub3Qgc2V0Cgoj
CiMgUENJIEhvdHBsdWcgU3VwcG9ydAojCiMgQ09ORklHX0hPVFBMVUdfUENJ
IGlzIG5vdCBzZXQKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNP
TkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9BT1VUPXkKQ09ORklH
X0JJTkZNVF9NSVNDPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2Vu
ZXJpYyBEcml2ZXIgT3B0aW9ucwojCiMgQ09ORklHX0ZXX0xPQURFUiBpcyBu
b3Qgc2V0CgojCiMgTWVtb3J5IFRlY2hub2xvZ3kgRGV2aWNlcyAoTVREKQoj
CkNPTkZJR19NVEQ9bQojIENPTkZJR19NVERfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19NVERfUEFSVElUSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX01U
RF9DT05DQVQgaXMgbm90IHNldAoKIwojIFVzZXIgTW9kdWxlcyBBbmQgVHJh
bnNsYXRpb24gTGF5ZXJzCiMKQ09ORklHX01URF9DSEFSPW0KIyBDT05GSUdf
TVREX0JMT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0JMT0NLX1JPIGlz
IG5vdCBzZXQKIyBDT05GSUdfRlRMIGlzIG5vdCBzZXQKQ09ORklHX05GVEw9
bQpDT05GSUdfTkZUTF9SVz15CkNPTkZJR19JTkZUTD1tCgojCiMgUkFNL1JP
TS9GbGFzaCBjaGlwIGRyaXZlcnMKIwpDT05GSUdfTVREX0NGST1tCkNPTkZJ
R19NVERfSkVERUNQUk9CRT1tCkNPTkZJR19NVERfR0VOX1BST0JFPW0KIyBD
T05GSUdfTVREX0NGSV9BRFZfT1BUSU9OUyBpcyBub3Qgc2V0CkNPTkZJR19N
VERfQ0ZJX0lOVEVMRVhUPW0KQ09ORklHX01URF9DRklfQU1EU1REPW0KQ09O
RklHX01URF9DRklfU1RBQT1tCkNPTkZJR19NVERfUkFNPW0KQ09ORklHX01U
RF9ST009bQpDT05GSUdfTVREX0FCU0VOVD1tCkNPTkZJR19NVERfT0JTT0xF
VEVfQ0hJUFM9eQpDT05GSUdfTVREX0FNRFNURD1tCkNPTkZJR19NVERfU0hB
UlA9bQpDT05GSUdfTVREX0pFREVDPW0KCiMKIyBNYXBwaW5nIGRyaXZlcnMg
Zm9yIGNoaXAgYWNjZXNzCiMKQ09ORklHX01URF9DT01QTEVYX01BUFBJTkdT
PXkKQ09ORklHX01URF9QSFlTTUFQPW0KQ09ORklHX01URF9QSFlTTUFQX1NU
QVJUPTB4ODAwMDAwMApDT05GSUdfTVREX1BIWVNNQVBfTEVOPTB4NDAwMDAw
MApDT05GSUdfTVREX1BIWVNNQVBfQlVTV0lEVEg9MgpDT05GSUdfTVREX1ND
NTIwQ0RQPW0KQ09ORklHX01URF9PQ1RBR09OPW0KQ09ORklHX01URF9WTUFY
PW0KQ09ORklHX01URF9TQ3gyMDBfRE9DRkxBU0g9bQpDT05GSUdfTVREX0FN
RDc2WFJPTT1tCkNPTkZJR19NVERfSUNIMlJPTT1tCkNPTkZJR19NVERfU0NC
Ml9GTEFTSD1tCkNPTkZJR19NVERfTDQ0MEdYPW0KQ09ORklHX01URF9QQ0k9
bQoKIwojIFNlbGYtY29udGFpbmVkIE1URCBkZXZpY2UgZHJpdmVycwojCkNP
TkZJR19NVERfUE1DNTUxPW0KQ09ORklHX01URF9QTUM1NTFfQlVHRklYPXkK
Q09ORklHX01URF9QTUM1NTFfREVCVUc9eQpDT05GSUdfTVREX1NMUkFNPW0K
Q09ORklHX01URF9NVERSQU09bQpDT05GSUdfTVREUkFNX1RPVEFMX1NJWkU9
NDA5NgpDT05GSUdfTVREUkFNX0VSQVNFX1NJWkU9MTI4CkNPTkZJR19NVERf
QkxLTVREPW0KCiMKIyBEaXNrLU9uLUNoaXAgRGV2aWNlIERyaXZlcnMKIwpD
T05GSUdfTVREX0RPQzIwMDA9bQpDT05GSUdfTVREX0RPQzIwMDE9bQpDT05G
SUdfTVREX0RPQzIwMDFQTFVTPW0KQ09ORklHX01URF9ET0NQUk9CRT1tCiMg
Q09ORklHX01URF9ET0NQUk9CRV9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJ
R19NVERfRE9DUFJPQkVfQUREUkVTUz0wCgojCiMgTkFORCBGbGFzaCBEZXZp
Y2UgRHJpdmVycwojCkNPTkZJR19NVERfTkFORD1tCkNPTkZJR19NVERfTkFO
RF9WRVJJRllfV1JJVEU9eQpDT05GSUdfTVREX05BTkRfSURTPW0KCiMKIyBQ
YXJhbGxlbCBwb3J0IHN1cHBvcnQKIwpDT05GSUdfUEFSUE9SVD1tCkNPTkZJ
R19QQVJQT1JUX1BDPW0KIyBDT05GSUdfUEFSUE9SVF9QQ19GSUZPIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19TVVBFUklPIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFSUE9SVF9QQ19QQ01DSUEgaXMgbm90IHNldAojIENPTkZJ
R19QQVJQT1JUX09USEVSIGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlRfMTI4
ND15CgojCiMgUGx1ZyBhbmQgUGxheSBzdXBwb3J0CiMKQ09ORklHX1BOUD15
CiMgQ09ORklHX1BOUF9ERUJVRyBpcyBub3Qgc2V0CgojCiMgUHJvdG9jb2xz
CiMKIyBDT05GSUdfSVNBUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfUE5QQklP
UyBpcyBub3Qgc2V0CgojCiMgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtf
REVWX0ZEPW0KQ09ORklHX1BBUklERT1tCkNPTkZJR19QQVJJREVfUEFSUE9S
VD1tCgojCiMgUGFyYWxsZWwgSURFIGhpZ2gtbGV2ZWwgZHJpdmVycwojCkNP
TkZJR19QQVJJREVfUEQ9bQpDT05GSUdfUEFSSURFX1BDRD1tCkNPTkZJR19Q
QVJJREVfUEY9bQpDT05GSUdfUEFSSURFX1BUPW0KQ09ORklHX1BBUklERV9Q
Rz1tCgojCiMgUGFyYWxsZWwgSURFIHByb3RvY29sIG1vZHVsZXMKIwojIENP
TkZJR19QQVJJREVfQVRFTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERV9C
UENLIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0JQQ0s2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFSSURFX0NPTU0gaXMgbm90IHNldAojIENPTkZJR19Q
QVJJREVfRFNUUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERV9GSVQyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0ZJVDMgaXMgbm90IHNldAojIENP
TkZJR19QQVJJREVfRVBBVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERV9F
UElBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0ZSSVEgaXMgbm90IHNl
dAojIENPTkZJR19QQVJJREVfRlJQVyBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
UklERV9LQklDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0tUVEkgaXMg
bm90IHNldAojIENPTkZJR19QQVJJREVfT04yMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBUklERV9PTjI2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9E
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfREFDOTYwIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9VTUVNIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTE9P
UD1tCkNPTkZJR19CTEtfREVWX0NSWVBUT0xPT1A9bQpDT05GSUdfQkxLX0RF
Vl9OQkQ9bQpDT05GSUdfQkxLX0RFVl9SQU09bQpDT05GSUdfQkxLX0RFVl9S
QU1fU0laRT00MDk2CiMgQ09ORklHX0JMS19ERVZfSU5JVFJEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEJEIGlzIG5vdCBzZXQKCiMKIyBBVEEvQVRBUEkvTUZN
L1JMTCBzdXBwb3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19CTEtfREVWX0lE
RT15CgojCiMgUGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uL2lkZS50eHQgZm9y
IGhlbHAvaW5mbyBvbiBJREUgZHJpdmVzCiMKIyBDT05GSUdfQkxLX0RFVl9I
RF9JREUgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVESVNLPXkKQ09O
RklHX0lERURJU0tfTVVMVElfTU9ERT15CiMgQ09ORklHX0lERURJU0tfU1RS
T0tFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVDUyBpcyBub3Qg
c2V0CkNPTkZJR19CTEtfREVWX0lERUNEPXkKIyBDT05GSUdfQkxLX0RFVl9J
REVUQVBFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRkxPUFBZPW0K
Q09ORklHX0JMS19ERVZfSURFU0NTST1tCiMgQ09ORklHX0lERV9UQVNLX0lP
Q1RMIGlzIG5vdCBzZXQKIyBDT05GSUdfSURFX1RBU0tGSUxFX0lPIGlzIG5v
dCBzZXQKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKQ09O
RklHX0JMS19ERVZfQ01ENjQwPXkKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDBf
RU5IQU5DRUQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERVBOUCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERVBDST15CkNPTkZJR19JREVQ
Q0lfU0hBUkVfSVJRPXkKIyBDT05GSUdfQkxLX0RFVl9PRkZCT0FSRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfR0VORVJJQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfT1BUSTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JM
S19ERVZfUloxMDAwIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRE1B
X1BDST15CiMgQ09ORklHX0JMS19ERVZfSURFRE1BX0ZPUkNFRCBpcyBub3Qg
c2V0CkNPTkZJR19JREVETUFfUENJX0FVVE89eQojIENPTkZJR19JREVETUFf
T05MWURJU0sgaXMgbm90IHNldAojIENPTkZJR19JREVETUFfUENJX1dJUCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0FETUE9eQojIENPTkZJR19CTEtf
REVWX0FFQzYyWFggaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9BTEkxNVgz
PXkKIyBDT05GSUdfV0RDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX0FNRDc0WFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NN
RDY0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJJRkxFWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1k4MkM2OTMgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0NTNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0JM
S19ERVZfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQz
NFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hQVDM2NiBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfU0MxMjAwIGlzIG5vdCBzZXQKQ09ORklH
X0JMS19ERVZfUElJWD15CiMgQ09ORklHX0JMS19ERVZfTlM4NzQxNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUERDMjAyWFhfT0xEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9ORVcgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX1NWV0tTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9TSUlNQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSVM1
NTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TTEM5MEU2NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJNMjkwIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9WSUE4MkNYWFggaXMgbm90IHNldApDT05GSUdfQkxL
X0RFVl9JREVETUE9eQojIENPTkZJR19JREVETUFfSVZCIGlzIG5vdCBzZXQK
Q09ORklHX0lERURNQV9BVVRPPXkKIyBDT05GSUdfRE1BX05PTlBDSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSEQgaXMgbm90IHNldAoKIwojIFND
U0kgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfU0NTST1tCkNPTkZJR19TQ1NJ
X1BST0NfRlM9eQoKIwojIFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBl
LCBDRC1ST00pCiMKQ09ORklHX0JMS19ERVZfU0Q9bQpDT05GSUdfQ0hSX0RF
Vl9TVD1tCiMgQ09ORklHX0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CkNPTkZJ
R19CTEtfREVWX1NSPW0KQ09ORklHX0JMS19ERVZfU1JfVkVORE9SPXkKQ09O
RklHX0NIUl9ERVZfU0c9bQoKIwojIFNvbWUgU0NTSSBkZXZpY2VzIChlLmcu
IENEIGp1a2Vib3gpIHN1cHBvcnQgbXVsdGlwbGUgTFVOcwojCiMgQ09ORklH
X1NDU0lfTVVMVElfTFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9SRVBP
UlRfTFVOUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ09OU1RBTlRTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9MT0dHSU5HIGlzIG5vdCBzZXQKCiMK
IyBTQ1NJIGxvdy1sZXZlbCBkcml2ZXJzCiMKIyBDT05GSUdfQkxLX0RFVl8z
V19YWFhYX1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9B
SUM3WFhYX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDNzlYWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQURWQU5TWVMgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX01FR0FSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9CVVNMT0dJQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1BRRkNUUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfRE1YMzE5MUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0VB
VEEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0VBVEFfUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9GVVRVUkVfRE9NQUlOIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9HRFRIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1BQQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU1N
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TWU01M0M4WFhfMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDX0lTUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfUUxPR0lDX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9R
TE9HSUNfMTI4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREMzOTV4IGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9OU1AzMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfREVCVUcgaXMgbm90IHNldAoKIwojIFBDTUNJQSBTQ1NJIGFk
YXB0ZXIgc3VwcG9ydAojCiMgQ09ORklHX1BDTUNJQV9BSEExNTJYIGlzIG5v
dCBzZXQKIyBDT05GSUdfUENNQ0lBX0ZET01BSU4gaXMgbm90IHNldAojIENP
TkZJR19QQ01DSUFfTklOSkFfU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BD
TUNJQV9RTE9HSUMgaXMgbm90IHNldAoKIwojIE11bHRpLWRldmljZSBzdXBw
b3J0IChSQUlEIGFuZCBMVk0pCiMKIyBDT05GSUdfTUQgaXMgbm90IHNldAoK
IwojIEZ1c2lvbiBNUFQgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19GVVNJ
T04gaXMgbm90IHNldAoKIwojIElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBv
cnQgKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19JRUVFMTM5NCBpcyBub3Qg
c2V0CgojCiMgSTJPIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfSTJPIGlz
IG5vdCBzZXQKCiMKIyBOZXR3b3JraW5nIHN1cHBvcnQKIwpDT05GSUdfTkVU
PXkKCiMKIyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPXkK
IyBDT05GSUdfUEFDS0VUX01NQVAgaXMgbm90IHNldAojIENPTkZJR19ORVRM
SU5LX0RFViBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVU
X0tFWSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJ
Q0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lORVRfRUNOIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1lOX0NPT0tJRVMgaXMgbm90IHNldAojIENPTkZJR19JTkVUX0FIIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5FVF9FU1AgaXMgbm90IHNldAojIENPTkZJR19J
TkVUX0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjYgaXMgbm90IHNl
dAojIENPTkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19CUklER0Ug
aXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVIgaXMgbm90IHNldAoKIwoj
IFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCkNPTkZJR19J
UFY2X1NDVFBfXz15CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENP
TkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5v
dCBzZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQWCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdf
WDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9ESVZFUlQgaXMgbm90IHNldAojIENPTkZJR19FQ09ORVQgaXMg
bm90IHNldAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0ZBU1RST1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9IV19G
TE9XQ09OVFJPTCBpcyBub3Qgc2V0CgojCiMgUW9TIGFuZC9vciBmYWlyIHF1
ZXVlaW5nCiMKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKCiMKIyBO
ZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBz
ZXQKQ09ORklHX05FVERFVklDRVM9eQoKIwojIEFSQ25ldCBkZXZpY2VzCiMK
IyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZPW0KQ09O
RklHX0JPTkRJTkc9bQojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAoj
IENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0IxMDAwIGlz
IG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwpDT05G
SUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST1tCiMgQ09ORklHX0hBUFBZ
TUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfM0NPTSBpcyBub3Qgc2V0CgojCiMgVHVsaXAg
ZmFtaWx5IG5ldHdvcmsgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfTkVUX1RV
TElQPXkKIyBDT05GSUdfREUyMTA0WCBpcyBub3Qgc2V0CkNPTkZJR19UVUxJ
UD1tCiMgQ09ORklHX1RVTElQX01XSSBpcyBub3Qgc2V0CiMgQ09ORklHX1RV
TElQX01NSU8gaXMgbm90IHNldApDT05GSUdfREU0WDU9bQojIENPTkZJR19X
SU5CT05EXzg0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNOTEwMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0hQMTAwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9QQ0k9
eQojIENPTkZJR19QQ05FVDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EODEx
MV9FVEggaXMgbm90IHNldAojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQjQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfREdS
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPMTAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfRTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZFQUxOWCBpcyBub3Qg
c2V0CiMgQ09ORklHX05BVFNFTUkgaXMgbm90IHNldAojIENPTkZJR19ORTJL
X1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHXzgxMzlDUCBpcyBub3Qgc2V0CiMg
Q09ORklHXzgxMzlUT08gaXMgbm90IHNldAojIENPTkZJR19TSVM5MDAgaXMg
bm90IHNldAojIENPTkZJR19FUElDMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1VOREFOQ0UgaXMgbm90IHNldAojIENPTkZJR19UTEFOIGlzIG5vdCBzZXQK
IyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAo
MTAwMCBNYml0KQojCiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RMMksgaXMgbm90IHNldAojIENPTkZJR19FMTAwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX05TODM4MjAgaXMgbm90IHNldAojIENPTkZJR19IQU1BQ0hJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfWUVMTE9XRklOIGlzIG5vdCBzZXQKIyBD
T05GSUdfUjgxNjkgaXMgbm90IHNldAojIENPTkZJR19TSVMxOTAgaXMgbm90
IHNldAojIENPTkZJR19TSzk4TElOIGlzIG5vdCBzZXQKIyBDT05GSUdfVElH
T04zIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAwMDAgTWJpdCkKIwoj
IENPTkZJR19JWEdCIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUExJUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BQUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NM
SVAgaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIExBTiAobm9uLWhhbXJhZGlv
KQojCkNPTkZJR19ORVRfUkFESU89eQoKIwojIE9ic29sZXRlIFdpcmVsZXNz
IGNhcmRzIHN1cHBvcnQgKHByZS04MDIuMTEpCiMKQ09ORklHX1NUUklQPW0K
Q09ORklHX1BDTUNJQV9XQVZFTEFOPW0KQ09ORklHX1BDTUNJQV9ORVRXQVZF
PW0KCiMKIyBXaXJlbGVzcyA4MDIuMTEgRnJlcXVlbmN5IEhvcHBpbmcgY2Fy
ZHMgc3VwcG9ydAojCkNPTkZJR19QQ01DSUFfUkFZQ1M9bQoKIwojIFdpcmVs
ZXNzIDgwMi4xMWIgSVNBL1BDSSBjYXJkcyBzdXBwb3J0CiMKQ09ORklHX0FJ
Uk89bQpDT05GSUdfSEVSTUVTPW0KQ09ORklHX1BMWF9IRVJNRVM9bQojIENP
TkZJR19UTURfSEVSTUVTIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9IRVJNRVM9
bQoKIwojIFdpcmVsZXNzIDgwMi4xMWIgUGNtY2lhL0NhcmRidXMgY2FyZHMg
c3VwcG9ydAojCkNPTkZJR19QQ01DSUFfSEVSTUVTPW0KQ09ORklHX0FJUk9f
Q1M9bQojIENPTkZJR19QQ01DSUFfQVRNRUwgaXMgbm90IHNldAojIENPTkZJ
R19QQ01DSUFfV0wzNTAxIGlzIG5vdCBzZXQKQ09ORklHX05FVF9XSVJFTEVT
Uz15CgojCiMgVG9rZW4gUmluZyBkZXZpY2VzCiMKIyBDT05GSUdfVFIgaXMg
bm90IHNldAojIENPTkZJR19ORVRfRkMgaXMgbm90IHNldAojIENPTkZJR19S
Q1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NIQVBFUiBpcyBub3Qgc2V0Cgoj
CiMgV2FuIGludGVyZmFjZXMKIwojIENPTkZJR19XQU4gaXMgbm90IHNldAoK
IwojIFBDTUNJQSBuZXR3b3JrIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX05F
VF9QQ01DSUE9eQojIENPTkZJR19QQ01DSUFfM0M1ODkgaXMgbm90IHNldAoj
IENPTkZJR19QQ01DSUFfM0M1NzQgaXMgbm90IHNldAojIENPTkZJR19QQ01D
SUFfRk1WSjE4WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9QQ05FVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9OTUNMQU4gaXMgbm90IHNldAoj
IENPTkZJR19QQ01DSUFfU01DOTFDOTIgaXMgbm90IHNldAojIENPTkZJR19Q
Q01DSUFfWElSQzJQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9BWE5F
VCBpcyBub3Qgc2V0CgojCiMgQW1hdGV1ciBSYWRpbyBzdXBwb3J0CiMKIyBD
T05GSUdfSEFNUkFESU8gaXMgbm90IHNldAoKIwojIElyREEgKGluZnJhcmVk
KSBzdXBwb3J0CiMKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CgojCiMgQmx1
ZXRvb3RoIHN1cHBvcnQKIwojIENPTkZJR19CVCBpcyBub3Qgc2V0CgojCiMg
SVNETiBzdWJzeXN0ZW0KIwojIENPTkZJR19JU0ROX0JPT0wgaXMgbm90IHNl
dAoKIwojIFRlbGVwaG9ueSBTdXBwb3J0CiMKIyBDT05GSUdfUEhPTkUgaXMg
bm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX0lO
UFVUPXkKCiMKIyBVc2VybGFuZCBpbnRlcmZhY2VzCiMKQ09ORklHX0lOUFVU
X01PVVNFREVWPXkKQ09ORklHX0lOUFVUX01PVVNFREVWX1BTQVVYPXkKQ09O
RklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVU
X01PVVNFREVWX1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBVVF9KT1lERVYg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9UU0RFViBpcyBub3Qgc2V0CkNP
TkZJR19JTlBVVF9FVkRFVj1tCiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5v
dCBzZXQKCiMKIyBJbnB1dCBJL08gZHJpdmVycwojCiMgQ09ORklHX0dBTUVQ
T1JUIGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EX0dBTUVQT1JUPXkKQ09ORklH
X1NFUklPPXkKQ09ORklHX1NFUklPX0k4MDQyPXkKQ09ORklHX1NFUklPX1NF
UlBPUlQ9eQojIENPTkZJR19TRVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFUklPX1BBUktCRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklP
X1BDSVBTMiBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMK
IwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRL
QkQ9eQojIENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9YVEtCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJP
QVJEX05FV1RPTiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15CkNP
TkZJR19NT1VTRV9QUzI9eQpDT05GSUdfTU9VU0VfUFMyX1NZTkFQVElDUz15
CiMgQ09ORklHX01PVVNFX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVE9VQ0hT
Q1JFRU4gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVNDIGlzIG5vdCBz
ZXQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNPTkZJR19WVD15CkNPTkZJ
R19WVF9DT05TT0xFPXkKQ09ORklHX0hXX0NPTlNPTEU9eQojIENPTkZJR19T
RVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAoKIwojIFNlcmlhbCBkcml2
ZXJzCiMKIyBDT05GSUdfU0VSSUFMXzgyNTAgaXMgbm90IHNldAoKIwojIE5v
bi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwpDT05GSUdfVU5JWDk4X1BU
WVM9eQpDT05GSUdfVU5JWDk4X1BUWV9DT1VOVD0yNTYKQ09ORklHX1BSSU5U
RVI9bQojIENPTkZJR19MUF9DT05TT0xFIGlzIG5vdCBzZXQKQ09ORklHX1BQ
REVWPW0KIyBDT05GSUdfVElQQVIgaXMgbm90IHNldAoKIwojIEkyQyBzdXBw
b3J0CiMKIyBDT05GSUdfSTJDIGlzIG5vdCBzZXQKCiMKIyBJMkMgQWxnb3Jp
dGhtcwojCgojCiMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMKIyBJ
MkMgSGFyZHdhcmUgU2Vuc29ycyBDaGlwIHN1cHBvcnQKIwojIENPTkZJR19J
MkNfU0VOU09SIGlzIG5vdCBzZXQKCiMKIyBNaWNlCiMKIyBDT05GSUdfQlVT
TU9VU0UgaXMgbm90IHNldAojIENPTkZJR19RSUMwMl9UQVBFIGlzIG5vdCBz
ZXQKCiMKIyBJUE1JCiMKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBz
ZXQKCiMKIyBXYXRjaGRvZyBDYXJkcwojCiMgQ09ORklHX1dBVENIRE9HIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlZSQU0gaXMgbm90IHNldAojIENPTkZJR19SVEMgaXMgbm90IHNldAoj
IENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFRMSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQ
TElDT00gaXMgbm90IHNldAojIENPTkZJR19TT05ZUEkgaXMgbm90IHNldAoK
IwojIEZ0YXBlLCB0aGUgZmxvcHB5IHRhcGUgZGV2aWNlIGRyaXZlcgojCiMg
Q09ORklHX0ZUQVBFIGlzIG5vdCBzZXQKQ09ORklHX0FHUD1tCkNPTkZJR19B
R1BfQUxJPW0KIyBDT05GSUdfQUdQX0FUSSBpcyBub3Qgc2V0CkNPTkZJR19B
R1BfQU1EPW0KIyBDT05GSUdfQUdQX0FNRDY0IGlzIG5vdCBzZXQKQ09ORklH
X0FHUF9JTlRFTD1tCiMgQ09ORklHX0FHUF9OVklESUEgaXMgbm90IHNldApD
T05GSUdfQUdQX1NJUz1tCiMgQ09ORklHX0FHUF9TV09SS1MgaXMgbm90IHNl
dApDT05GSUdfQUdQX1ZJQT1tCkNPTkZJR19EUk09eQojIENPTkZJR19EUk1f
VERGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9HQU1NQSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9SMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1JB
REVPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JODEwIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX0k4MzAgaXMgbm90IHNldAojIENPTkZJR19EUk1fTUdB
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJUyBpcyBub3Qgc2V0CgojCiMg
UENNQ0lBIGNoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1NZTkNMSU5LX0NT
PW0KIyBDT05GSUdfTVdBVkUgaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJ
VkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFOR0NIRUNLX1RJTUVSIGlzIG5v
dCBzZXQKCiMKIyBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19WSURF
T19ERVYgaXMgbm90IHNldAoKIwojIERpZ2l0YWwgVmlkZW8gQnJvYWRjYXN0
aW5nIERldmljZXMKIwojIENPTkZJR19EVkIgaXMgbm90IHNldAoKIwojIEdy
YXBoaWNzIHN1cHBvcnQKIwpDT05GSUdfRkI9eQojIENPTkZJR19GQl9DWUJF
UjIwMDAgaXMgbm90IHNldAojIENPTkZJR19GQl9JTVNUVCBpcyBub3Qgc2V0
CkNPTkZJR19GQl9WR0ExNj1tCkNPTkZJR19GQl9WRVNBPXkKQ09ORklHX1ZJ
REVPX1NFTEVDVD15CiMgQ09ORklHX0ZCX0hHQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1JJVkEgaXMgbm90IHNldAojIENPTkZJR19GQl9JODEwIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfTUFUUk9YIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVRZMTI4IGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfQVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
U0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTkVPTUFHSUMgaXMgbm90IHNl
dAojIENPTkZJR19GQl8zREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVk9P
RE9PMSBpcyBub3Qgc2V0CkNPTkZJR19GQl9UUklERU5UPW0KIyBDT05GSUdf
RkJfVklSVFVBTCBpcyBub3Qgc2V0CgojCiMgQ29uc29sZSBkaXNwbGF5IGRy
aXZlciBzdXBwb3J0CiMKQ09ORklHX1ZHQV9DT05TT0xFPXkKIyBDT05GSUdf
TURBX0NPTlNPTEUgaXMgbm90IHNldApDT05GSUdfRFVNTVlfQ09OU09MRT15
CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFPW0KQ09ORklHX1BDSV9DT05T
T0xFPXkKIyBDT05GSUdfRk9OVFMgaXMgbm90IHNldApDT05GSUdfRk9OVF84
eDg9eQpDT05GSUdfRk9OVF84eDE2PXkKCiMKIyBMb2dvIGNvbmZpZ3VyYXRp
b24KIwpDT05GSUdfTE9HTz15CkNPTkZJR19MT0dPX0xJTlVYX01PTk89eQpD
T05GSUdfTE9HT19MSU5VWF9WR0ExNj15CkNPTkZJR19MT0dPX0xJTlVYX0NM
VVQyMjQ9eQoKIwojIFNvdW5kCiMKQ09ORklHX1NPVU5EPW0KCiMKIyBBZHZh
bmNlZCBMaW51eCBTb3VuZCBBcmNoaXRlY3R1cmUKIwpDT05GSUdfU05EPW0K
Q09ORklHX1NORF9TRVFVRU5DRVI9bQpDT05GSUdfU05EX1NFUV9EVU1NWT1t
CkNPTkZJR19TTkRfT1NTRU1VTD15CkNPTkZJR19TTkRfTUlYRVJfT1NTPW0K
Q09ORklHX1NORF9QQ01fT1NTPW0KQ09ORklHX1NORF9TRVFVRU5DRVJfT1NT
PXkKQ09ORklHX1NORF9WRVJCT1NFX1BSSU5USz15CiMgQ09ORklHX1NORF9E
RUJVRyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBkZXZpY2VzCiMKIyBDT05G
SUdfU05EX0RVTU1ZIGlzIG5vdCBzZXQKQ09ORklHX1NORF9WSVJNSURJPW0K
IyBDT05GSUdfU05EX01UUEFWIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NF
UklBTF9VMTY1NTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfTVBVNDAxIGlz
IG5vdCBzZXQKCiMKIyBQQ0kgZGV2aWNlcwojCiMgQ09ORklHX1NORF9BTEk1
NDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FaVDMzMjggaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQ1M0NlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0NTNDI4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTVUxMEsxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0tPUkcxMjEyIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX05NMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1JNRTk2NTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERTUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9UUklERU5UIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTFM0
MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NNSVBDSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9FTlMxMzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0VOUzEzNzEgaXMgbm90IHNldAojIENPTkZJR19TTkRfRVMxOTM4IGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0VTMTk2OCBpcyBub3Qgc2V0CkNPTkZJR19T
TkRfTUFFU1RSTzM9bQojIENPTkZJR19TTkRfRk04MDEgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSUNFMTcxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9J
Q0UxNzI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lOVEVMOFgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1NPTklDVklCRVMgaXMgbm90IHNldAojIENP
TkZJR19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WWDIy
MiBpcyBub3Qgc2V0CgojCiMgQUxTQSBVU0IgZGV2aWNlcwojCiMgQ09ORklH
X1NORF9VU0JfQVVESU8gaXMgbm90IHNldAoKIwojIFBDTUNJQSBkZXZpY2Vz
CiMKIyBDT05GSUdfU05EX1ZYUE9DS0VUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1ZYUDQ0MCBpcyBub3Qgc2V0CgojCiMgT3BlbiBTb3VuZCBTeXN0ZW0K
IwpDT05GSUdfU09VTkRfUFJJTUU9bQojIENPTkZJR19TT1VORF9CVDg3OCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0NNUENJIGlzIG5vdCBzZXQKIyBD
T05GSUdfU09VTkRfRU1VMTBLMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5E
X0ZVU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0NTNDI4MSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NPVU5EX0VTMTM3MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NPVU5EX0VTMTM3MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0VT
U1NPTE8xIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTUFFU1RSTyBpcyBu
b3Qgc2V0CkNPTkZJR19TT1VORF9NQUVTVFJPMz1tCiMgQ09ORklHX1NPVU5E
X0lDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX1NPTklDVklCRVMgaXMg
bm90IHNldAojIENPTkZJR19TT1VORF9UUklERU5UIGlzIG5vdCBzZXQKIyBD
T05GSUdfU09VTkRfTVNORENMQVMgaXMgbm90IHNldAojIENPTkZJR19TT1VO
RF9NU05EUElOIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfVklBODJDWFhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfT1NTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU09VTkRfQUxJNTQ1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5E
X0ZPUlRFIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfUk1FOTZYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NPVU5EX0FEMTk4MCBpcyBub3Qgc2V0CgojCiMg
VVNCIHN1cHBvcnQKIwpDT05GSUdfVVNCPW0KIyBDT05GSUdfVVNCX0RFQlVH
IGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMK
Q09ORklHX1VTQl9ERVZJQ0VGUz15CiMgQ09ORklHX1VTQl9CQU5EV0lEVEgg
aXMgbm90IHNldAojIENPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90
IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCiMgQ09O
RklHX1VTQl9FSENJX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9I
Q0Q9bQojIENPTkZJR19VU0JfVUhDSV9IQ0QgaXMgbm90IHNldAoKIwojIFVT
QiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCkNPTkZJR19VU0JfQVVESU89bQoj
IENPTkZJR19VU0JfQkxVRVRPT1RIX1RUWSBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfTUlEST1tCiMgQ09ORklHX1VTQl9BQ00gaXMgbm90IHNldApDT05GSUdf
VVNCX1BSSU5URVI9bQpDT05GSUdfVVNCX1NUT1JBR0U9bQpDT05GSUdfVVNC
X1NUT1JBR0VfREVCVUc9eQpDT05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQj15
CkNPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NPXkKQ09ORklHX1VTQl9TVE9S
QUdFX0lTRDIwMD15CkNPTkZJR19VU0JfU1RPUkFHRV9EUENNPXkKQ09ORklH
X1VTQl9TVE9SQUdFX0hQODIwMGU9eQpDT05GSUdfVVNCX1NUT1JBR0VfU0RE
UjA5PXkKQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NT15CkNPTkZJR19VU0Jf
U1RPUkFHRV9KVU1QU0hPVD15CgojCiMgVVNCIEh1bWFuIEludGVyZmFjZSBE
ZXZpY2VzIChISUQpCiMKQ09ORklHX1VTQl9ISUQ9bQpDT05GSUdfVVNCX0hJ
RElOUFVUPXkKIyBDT05GSUdfSElEX0ZGIGlzIG5vdCBzZXQKQ09ORklHX1VT
Ql9ISURERVY9eQoKIwojIFVTQiBISUQgQm9vdCBQcm90b2NvbCBkcml2ZXJz
CiMKQ09ORklHX1VTQl9LQkQ9bQpDT05GSUdfVVNCX01PVVNFPW0KIyBDT05G
SUdfVVNCX0FJUFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9XQUNPTSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQlRBQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9QT1dFUk1BVEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfWFBB
RCBpcyBub3Qgc2V0CgojCiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCkNPTkZJ
R19VU0JfTURDODAwPW0KQ09ORklHX1VTQl9TQ0FOTkVSPW0KQ09ORklHX1VT
Ql9NSUNST1RFSz1tCkNPTkZJR19VU0JfSFBVU0JTQ1NJPW0KCiMKIyBVU0Ig
TXVsdGltZWRpYSBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX0RBQlVTQiBpcyBu
b3Qgc2V0CgojCiMgVmlkZW80TGludXggc3VwcG9ydCBpcyBuZWVkZWQgZm9y
IFVTQiBNdWx0aW1lZGlhIGRldmljZSBzdXBwb3J0CiMKCiMKIyBVU0IgTmV0
d29yayBhZGFwdG9ycwojCiMgQ09ORklHX1VTQl9DQVRDIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9Q
RUdBU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90
IHNldAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
cG9ydCBkcml2ZXJzCiMKQ09ORklHX1VTQl9VU1M3MjA9bQoKIwojIFVTQiBT
ZXJpYWwgQ29udmVydGVyIHN1cHBvcnQKIwpDT05GSUdfVVNCX1NFUklBTD1t
CkNPTkZJR19VU0JfU0VSSUFMX0dFTkVSSUM9eQojIENPTkZJR19VU0JfU0VS
SUFMX0JFTEtJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJ
VEVIRUFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ESUdJX0FD
Q0VMRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VNUEVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9GVERJX1NJTyBpcyBu
b3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX1ZJU09SPW0KIyBDT05GSUdfVVNC
X1NFUklBTF9JUEFRIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9J
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRURHRVBPUlQgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1BEQSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TRVJJQUxfS0xTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfS09CSUxfU0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9NQ1RfVTIzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
UEwyMzAzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TQUZFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWUJFUkpBQ0sgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1hJUkNPTSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TRVJJQUxfT01OSU5FVCBpcyBub3Qgc2V0CgojCiMgVVNC
IE1pc2NlbGxhbmVvdXMgZHJpdmVycwojCkNPTkZJR19VU0JfRU1JMjY9bQoj
IENPTkZJR19VU0JfVElHTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVUVS
U1dBTEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0JSTFZHRVIgaXMgbm90IHNldAojIENPTkZJR19V
U0JfTENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfR0FER0VUIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5
c3RlbXMKIwpDT05GSUdfRVhUMl9GUz1tCkNPTkZJR19FWFQyX0ZTX1hBVFRS
PXkKQ09ORklHX0VYVDJfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYVDJfRlNf
U0VDVVJJVFk9eQpDT05GSUdfRVhUM19GUz15CkNPTkZJR19FWFQzX0ZTX1hB
VFRSPXkKQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYVDNf
RlNfU0VDVVJJVFk9eQpDT05GSUdfSkJEPXkKQ09ORklHX0pCRF9ERUJVRz15
CkNPTkZJR19GU19NQkNBQ0hFPXkKIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMg
bm90IHNldAojIENPTkZJR19KRlNfRlMgaXMgbm90IHNldApDT05GSUdfRlNf
UE9TSVhfQUNMPXkKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUlOSVhfRlMgaXMgbm90IHNldApDT05GSUdfUk9NRlNfRlM9bQojIENP
TkZJR19RVU9UQSBpcyBub3Qgc2V0CkNPTkZJR19BVVRPRlNfRlM9bQpDT05G
SUdfQVVUT0ZTNF9GUz15CgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwoj
CkNPTkZJR19JU085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CkNPTkZJR19a
SVNPRlM9eQpDT05GSUdfWklTT0ZTX0ZTPXkKQ09ORklHX1VERl9GUz1tCgoj
CiMgRE9TL0ZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9bQpD
T05GSUdfTVNET1NfRlM9bQpDT05GSUdfVkZBVF9GUz1tCkNPTkZJR19OVEZT
X0ZTPW0KIyBDT05GSUdfTlRGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X05URlNfUlcgaXMgbm90IHNldAoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwoj
CkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0NfS0NPUkU9eQpDT05GSUdf
REVWRlNfRlM9eQpDT05GSUdfREVWRlNfTU9VTlQ9eQojIENPTkZJR19ERVZG
U19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19ERVZQVFNfRlM9eQojIENPTkZJ
R19ERVZQVFNfRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdfVE1QRlM9eQoj
IENPTkZJR19IVUdFVExCRlMgaXMgbm90IHNldAojIENPTkZJR19IVUdFVExC
X1BBR0UgaXMgbm90IHNldApDT05GSUdfUkFNRlM9eQoKIwojIE1pc2NlbGxh
bmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19CRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19KRkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZG
UzJfRlMgaXMgbm90IHNldApDT05GSUdfQ1JBTUZTPW0KIyBDT05GSUdfVlhG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBO
ZXR3b3JrIEZpbGUgU3lzdGVtcwojCkNPTkZJR19ORlNfRlM9bQpDT05GSUdf
TkZTX1YzPXkKIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkZTX0RJUkVDVElPIGlzIG5vdCBzZXQKQ09ORklHX05GU0Q9bQpDT05GSUdf
TkZTRF9WMz15CiMgQ09ORklHX05GU0RfVjQgaXMgbm90IHNldAojIENPTkZJ
R19ORlNEX1RDUCBpcyBub3Qgc2V0CkNPTkZJR19MT0NLRD1tCkNPTkZJR19M
T0NLRF9WND15CkNPTkZJR19FWFBPUlRGUz1tCkNPTkZJR19TVU5SUEM9bQoj
IENPTkZJR19TVU5SUENfR1NTIGlzIG5vdCBzZXQKQ09ORklHX1NNQl9GUz1t
CiMgQ09ORklHX1NNQl9OTFNfREVGQVVMVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NJRlMgaXMgbm90IHNldAojIENPTkZJR19OQ1BfRlMgaXMgbm90IHNldAoj
IENPTkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJNRVpa
T19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGU19GUyBpcyBub3Qgc2V0Cgoj
CiMgUGFydGl0aW9uIFR5cGVzCiMKIyBDT05GSUdfUEFSVElUSU9OX0FEVkFO
Q0VEIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CkNPTkZJ
R19TTUJfTkxTPXkKQ09ORklHX05MUz15CgojCiMgTmF0aXZlIExhbmd1YWdl
IFN1cHBvcnQKIwpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKQ09O
RklHX05MU19DT0RFUEFHRV80Mzc9bQpDT05GSUdfTkxTX0NPREVQQUdFXzcz
Nz1tCkNPTkZJR19OTFNfQ09ERVBBR0VfNzc1PW0KQ09ORklHX05MU19DT0RF
UEFHRV84NTA9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg1Mj1tCkNPTkZJR19O
TFNfQ09ERVBBR0VfODU1PW0KQ09ORklHX05MU19DT0RFUEFHRV84NTc9bQpD
T05GSUdfTkxTX0NPREVQQUdFXzg2MD1tCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODYxPW0KQ09ORklHX05MU19DT0RFUEFHRV84NjI9bQpDT05GSUdfTkxTX0NP
REVQQUdFXzg2Mz1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODY0PW0KQ09ORklH
X05MU19DT0RFUEFHRV84NjU9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2Nj1t
CkNPTkZJR19OTFNfQ09ERVBBR0VfODY5PW0KQ09ORklHX05MU19DT0RFUEFH
RV85MzY9bQpDT05GSUdfTkxTX0NPREVQQUdFXzk1MD1tCkNPTkZJR19OTFNf
Q09ERVBBR0VfOTMyPW0KQ09ORklHX05MU19DT0RFUEFHRV85NDk9bQpDT05G
SUdfTkxTX0NPREVQQUdFXzg3ND1tCkNPTkZJR19OTFNfSVNPODg1OV84PW0K
Q09ORklHX05MU19DT0RFUEFHRV8xMjUwPW0KQ09ORklHX05MU19DT0RFUEFH
RV8xMjUxPW0KQ09ORklHX05MU19JU084ODU5XzE9bQpDT05GSUdfTkxTX0lT
Tzg4NTlfMj1tCkNPTkZJR19OTFNfSVNPODg1OV8zPW0KQ09ORklHX05MU19J
U084ODU5XzQ9bQpDT05GSUdfTkxTX0lTTzg4NTlfNT1tCkNPTkZJR19OTFNf
SVNPODg1OV82PW0KQ09ORklHX05MU19JU084ODU5Xzc9bQpDT05GSUdfTkxT
X0lTTzg4NTlfOT1tCkNPTkZJR19OTFNfSVNPODg1OV8xMz1tCkNPTkZJR19O
TFNfSVNPODg1OV8xND1tCkNPTkZJR19OTFNfSVNPODg1OV8xNT1tCkNPTkZJ
R19OTFNfS09JOF9SPW0KQ09ORklHX05MU19LT0k4X1U9bQpDT05GSUdfTkxT
X1VURjg9bQoKIwojIFByb2ZpbGluZyBzdXBwb3J0CiMKIyBDT05GSUdfUFJP
RklMSU5HIGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgaGFja2luZwojCiMgQ09O
RklHX0RFQlVHX0tFUk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQ
SU5MT0NLX1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfRlJBTUVfUE9JTlRF
UiBpcyBub3Qgc2V0CkNPTkZJR19YODZfRVhUUkFfSVJRUz15CkNPTkZJR19Y
ODZfRklORF9TTVBfQ09ORklHPXkKQ09ORklHX1g4Nl9NUFBBUlNFPXkKCiMK
IyBTZWN1cml0eSBvcHRpb25zCiMKIyBDT05GSUdfU0VDVVJJVFkgaXMgbm90
IHNldAoKIwojIENyeXB0b2dyYXBoaWMgb3B0aW9ucwojCkNPTkZJR19DUllQ
VE89eQpDT05GSUdfQ1JZUFRPX0hNQUM9eQpDT05GSUdfQ1JZUFRPX05VTEw9
bQpDT05GSUdfQ1JZUFRPX01END1tCkNPTkZJR19DUllQVE9fTUQ1PW0KQ09O
RklHX0NSWVBUT19TSEExPW0KQ09ORklHX0NSWVBUT19TSEEyNTY9bQpDT05G
SUdfQ1JZUFRPX1NIQTUxMj1tCkNPTkZJR19DUllQVE9fREVTPW0KQ09ORklH
X0NSWVBUT19CTE9XRklTSD1tCkNPTkZJR19DUllQVE9fVFdPRklTSD1tCkNP
TkZJR19DUllQVE9fU0VSUEVOVD1tCkNPTkZJR19DUllQVE9fQUVTPW0KQ09O
RklHX0NSWVBUT19DQVNUNT1tCkNPTkZJR19DUllQVE9fQ0FTVDY9bQpDT05G
SUdfQ1JZUFRPX0RFRkxBVEU9bQpDT05GSUdfQ1JZUFRPX1RFU1Q9bQoKIwoj
IExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQ1JDMzI9bQpDT05GSUdfWkxJ
Ql9JTkZMQVRFPXkKQ09ORklHX1pMSUJfREVGTEFURT1tCkNPTkZJR19YODZf
QklPU19SRUJPT1Q9eQpDT05GSUdfUEM9eQo=


------=_NextPart_000_4a5c_5973_7a0c--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
