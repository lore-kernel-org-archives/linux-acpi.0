From: Markus Raab <markus.raab-Tswl7xcH0yE@public.gmane.org>
Subject: crash acpi
Date: Sun, 20 Oct 2002 16:20:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210201620.47338.markus.raab@aon.at>
Reply-To: markus.raab-Tswl7xcH0yE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

[1] When i use acpi on Mainboard EP-8K5A2 from EPoX, there is an Kernel P=
anik,=20
if i deaktivate it, there is no problem. At [5] you see the logreport of =
the=20
crash!

Markus (markus.raab-Tswl7xcH0yE@public.gmane.org)

[4 Linux version 2.4.18-4GB (root-MOF6036VFP+XcDkGTvBoYw@public.gmane.org) (gcc version 2.95.3=20
20010315 (SuSE)) #1 Wed Mar 27 13:57:05 UTC 200
[5] Oct 13 01:29:55 linux kernel: usb-uhci.c: Detected 2 ports
Oct 13 01:29:55 linux last message repeated 2 times
Oct 13 01:30:18 linux modprobe: modprobe: Can't locate module block-major=
-80
Oct 13 01:30:19 linux last message repeated 15 times
Oct 13 01:30:19 linux modprobe: modprobe: Can't locate module block-major=
-104
Oct 13 01:30:20 linux last message repeated 15 times
Oct 13 01:30:20 linux modprobe: modprobe: Can't locate module block-major=
-105
Oct 13 01:30:20 linux last message repeated 15 times
Oct 13 01:30:20 linux modprobe: modprobe: Can't locate module block-major=
-106
Oct 13 01:30:21 linux last message repeated 15 times
Oct 13 01:30:21 linux modprobe: modprobe: Can't locate module block-major=
-107
Oct 13 01:30:22 linux last message repeated 15 times
Oct 13 02:36:06 linux kernel: CPU 0: Machine Check Exception: 00000000000=
00004
Oct 13 02:36:06 linux kernel: Bank 2: f60020000000017a at 0000000005ea810=
0
Oct 13 02:36:06 linux kernel: Kernel panic: CPU context corrupt
Oct 13 02:39:45 linux kernel: usb-uhci.c: Detected 2 ports
Oct 13 02:39:45 linux last message repeated 2 times
Oct 13 02:44:33 linux kernel: eth0: Winbond 89C940 found at 0xd000, IRQ 1=
0,=20
48:54:E8:2B:AC:CC.
Oct 13 02:46:59 linux kernel: CPU 0: Machine Check Exception: 00000000000=
00004
Oct 13 02:46:59 linux kernel: Bank 2: f60020000000017a at 0000000009f6e34=
0
Oct 13 02:46:59 linux kernel: Kernel panic: CPU context corrupt
Oct 13 02:48:51 linux kernel: eth0: Winbond 89C940 found at 0xd000, IRQ 1=
0,=20
48:54:E8:2B:AC:CC.
Oct 13 02:48:51 linux kernel: usb-uhci.c: Detected 2 ports
Oct 13 02:48:51 linux last message repeated 2 times
Oct 12 19:46:39 linux kernel: CPU 0: Machine Check Exception: 00000000000=
00004
Oct 12 19:46:39 linux kernel: Bank 2: f60020000000017a at 00000000063319c=
0
Oct 12 19:46:39 linux kernel: Kernel panic: CPU context corrupt
Oct 13 17:04:53 linux kernel: eth0: Winbond 89C940 found at 0xd000, IRQ 1=
0,=20
48:54:E8:2B:AC:CC.
[7.1] Linux linux 2.4.18-4GB #1 Wed Mar 27 13:57:05 UTC 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.26
PPP                    2.4.1
isdn4k-utils           3.1
Linux C Library        x    1 root     root      1394302 Aug 10 19:55=20
/lib/libc$
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-mixer-oss agpgart NVdriver parport=
_pc=20
lp$

[7.2] processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 706.982
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmo=
v pat=20
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1409.02
[7.3] snd-pcm-oss            45152   1 (autoclean)
snd-mixer-oss          11136   1 (autoclean)
agpgart                29664   3 (autoclean)
NVdriver             1066464   7 (autoclean)
parport_pc             25448   1 (autoclean)
lp                      5824   0 (autoclean)
parport                21856   1 (autoclean) [parport_pc lp]
snd-seq-midi            4480   0 (autoclean) (unused)
snd-emu10k1-synth       5504   0 (autoclean)
snd-emux-synth         28480   0 (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4560   0 (autoclean) [snd-emux-synth]
snd-seq-virmidi         3720   0 (autoclean) [snd-emux-synth]
snd-seq-oss            24128   0 (autoclean)
snd-seq-midi-event      2664   0 (autoclean) [snd-seq-midi snd-seq-virmid=
i=20
snd-seq-oss]
snd-seq                39596   2 (autoclean) [snd-seq-midi snd-emux-synth=
=20
snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event]
snd-emu10k1            62820   2 [snd-emu10k1-synth]
snd-pcm                58528   0 [snd-pcm-oss snd-emu10k1]
snd-timer              11456   0 [snd-seq snd-pcm]
snd-hwdep               4736   0 [snd-emu10k1]
snd-util-mem            1472   0 [snd-emux-synth snd-emu10k1]
snd-rawmidi            13536   0 [snd-seq-midi snd-seq-virmidi snd-emu10k=
1]
snd-seq-device          4336   0 [snd-seq-midi snd-emu10k1-synth=20
snd-emux-synth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         24196   0 [snd-emu10k1]
snd                    31720   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi=20
snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul snd-seq-virmidi=20
snd-seq-oss snd-seq-midi-event snd-seq snd-emu10k1 snd-pcm snd-timer=20
snd-hwdep snd-util-mem snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3268  10 [snd]
mousedev                3872   1
hid                    17824   0 (unused)
joydev                  5728   0 (unused)
evdev                   3904   0 (unused)
input                   3072   0 [mousedev hid joydev evdev]
usb-ohci               18880   0 (unused)
usbcore                55136   1 [hid usb-ohci]
ne                      6496   1
8390                    5856   0 [ne]
ipt_REJECT              2752   1 (autoclean)
ipt_LOG                 3168   1 (autoclean)
ipt_MASQUERADE          1216   1 (autoclean)
iptable_nat            12756   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           12652   1 (autoclean) [ipt_MASQUERADE iptable_nat]
iptable_filter          1728   1 (autoclean)
ip_tables              10400   7 [ipt_REJECT ipt_LOG ipt_MASQUERADE=20
iptable_nat iptable_filter]
hisax                 500452   6
isdn                  119104   8 [hisax]
slhc                    4432   2 [isdn]
isa-pnp                27816   0 [ne hisax]
lvm-mod                58016   0 (autoclean)
reiserfs              158816   2
[7.4] 0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-023f : eth0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
d800-d803 : PCI device 1022:7006
da00-da1f : PCI device 1244:0a00
  da00-da1f : avm PCI
dc00-dc1f : PCI device 1102:0002
  dc00-dc1f : EMU10K1
de00-de07 : PCI device 1102:7002
f000-f00f : PCI device 1022:7409
  f000-f007 : ide0
  f008-f00f : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0025b584 : Kernel code
  0025b585-002c0eab : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
d5c00000-e5cfffff : PCI Bus #01
  d8000000-dfffffff : PCI device 10de:0110
    d8000000-d9ffffff : vesafb
e8000000-ebffffff : PCI device 1022:7006
eddff000-eddfffff : PCI device 1022:7006
ede00000-efefffff : PCI Bus #01
  ee000000-eeffffff : PCI device 10de:0110
efffa000-efffafff : PCI device 1022:740c
  efffa000-efffafff : usb-ohci
efffffe0-efffffff : PCI device 1244:0a00
ffff0000-ffffffff : reserved
[7.5] 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate=
]=20
System Controller (rev 25)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 120
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D64M]
        Region 1: Memory at eddff000 (32-bit, prefetchable) [size=3D4K]
        Region 2: I/O ports at d800 [disabled] [size=3D4]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=3D15 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA- AGP+ 64bit- FW- Rate=3Dx1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP B=
ridge=20
(rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: ede00000-efefffff
        Prefetchable memory behind bridge: d5c00000-e5cfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev=
 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (=
rev=20
07) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=3D16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03=
)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB =
(rev=20
06) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 0: Memory at efffa000 (32-bit, non-prefetchable) [size=3D4=
K]

00:08.0 Network controller: AVM Audiovisuelles MKTG & Computer System Gmb=
H A1=20
ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!C=
ard=20
ISDN Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at efffffe0 (32-bit, non-prefetchable) [size=3D3=
2]
        Region 1: I/O ports at da00 [size=3D32]

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
07)
        Subsystem: Creative Labs CT4830 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=3D32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at de00 [size=3D8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) =
(rev=20
a1) (prog-if 00 [VGA])
        Subsystem: Guillemot Corporation: Unknown device 7102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=3D1=
6M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
        Expansion ROM at efef0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2
                Command: RQ=3D15 SBA- AGP+ 64bit- FW- Rate=3Dx1
[7.6] Attached devices: none



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
