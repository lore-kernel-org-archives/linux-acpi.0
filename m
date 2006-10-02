From: Jon Barnett <jbarnett@pobox.com>
Subject: Problem with ACPI detection of battery and thermal on Laptop:
	2.6.18
Date: Sun, 01 Oct 2006 21:18:19 -0400
Message-ID: <1159751899.31547.15.camel@localhost>
Reply-To: jbarnett@pobox.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zlR88OSfGp4vV82rdhpb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rune.pobox.com ([208.210.124.79]:29877 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932577AbWJBBSW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Oct 2006 21:18:22 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 60B098356B
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2006 21:18:43 -0400 (EDT)
Received: from [192.168.0.100] (ottawa-hs-64-26-170-19.d-ip.magma.ca [64.26.170.19])
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E780B8309E
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2006 21:18:42 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-zlR88OSfGp4vV82rdhpb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Summary
---------------
The modules for ACPI thermal and battery reporting don't seem to work in
2.6.18.

Description
---------------
When loading these modules, the following is reported in the output of
dmesg:
Battery
ACPI Error (exmutex-0283): Cannot release Mutex [SMIX], incorrect
SyncLevel [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\SX12] (Node
dff90748), AE_AML_MUTEX_ORDER
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BIF_]
(Node dff90b08), AE_AML_MUTEX_ORDER
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.BAT0._BIF] (Node dff90a90), AE_AML_MUTEX_ORDER
ACPI Exception (acpi_battery-0146): AE_AML_MUTEX_ORDER, Evaluating _BIF
[20060707]

Thermal
ACPI Error (exmutex-0283): Cannot release Mutex [SMIX], incorrect
SyncLevel [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\SX12] (Node
dff90748), AE_AML_MUTEX_ORDER
ACPI Error (psparse-0537): Method parse/execution failed
[\_TZ_.THM_.GINF] (Node dff90c20), AE_AML_MUTEX_ORDER
ACPI Error (psparse-0537): Method parse/execution failed
[\_TZ_.THM_._TMP] (Node dff90c34), AE_AML_MUTEX_ORDER

No standard module information is produced in /proc/acpi/thermal
or /proc/acpi/battery for these devices.

Keywords
---------------
Kernel, ACPI, thermal, battery

Version
---------------
Linux version 2.6.18 (root@persephone) (gcc version 3.4.6) #2 SMP Fri
Sep 29 22:18:24 EDT 2006

Environment
---------------
Dell Inspiron 5150 - BIOS A38

Software
---------------
Linux persephone 2.6.18 #2 SMP Fri Sep 29 22:18:24 EDT 2006 i686
pentium4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.11
reiserfsprogs          3.6.19
xfsprogs               2.8.10
pcmcia-cs              3.2.8
quota-tools            3.13.
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         thermal battery container snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss ipv6
microcode i8k cpufreq_powersave cpufreq_userspace cpufreq_conservative
cpufreq_ondemand speedstep_ich speedstep_lib video button processor fan
ac nvidia snd_intel8x0 pcmcia firmware_class ohci1394 b44 uhci_hcd
ehci_hcd ieee1394 mii evdev joydev snd_ac97_codec snd_ac97_bus snd_pcm
snd_timer yenta_socket snd rsrc_nonstatic snd_page_alloc pcmcia_core

Processor information
---------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz
stepping        : 9
cpu MHz         : 1599.960
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 3191.59

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz
stepping        : 9
cpu MHz         : 1599.960
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 3191.59

Module information
---------------
thermal 11656 0 - Live 0xe0c6c000
battery 8324 0 - Live 0xe0eca000
container 3712 0 - Live 0xe0eb0000
snd_seq_oss 31744 0 - Live 0xe0ec1000
snd_seq_midi_event 6272 1 snd_seq_oss, Live 0xe0e9f000
snd_seq 49104 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0ed1000
snd_seq_device 6796 2 snd_seq_oss,snd_seq, Live 0xe0ea7000
snd_pcm_oss 44192 0 - Live 0xe0eb5000
snd_mixer_oss 16384 1 snd_pcm_oss, Live 0xe0ea2000
ipv6 239904 24 - Live 0xe0ee3000
microcode 6872 0 - Live 0xe0c90000
i8k 5656 0 - Live 0xe0c85000
cpufreq_powersave 1792 0 - Live 0xe0c8a000
cpufreq_userspace 3496 1 - Live 0xe0c88000
cpufreq_conservative 6280 0 - Live 0xe0c7d000
cpufreq_ondemand 5516 0 - Live 0xe0c5a000
speedstep_ich 4752 1 - Live 0xe0c7a000
speedstep_lib 3840 1 speedstep_ich, Live 0xe0c61000
video 14980 0 - Live 0xe0c80000
button 5392 0 - Live 0xe0c77000
processor 22968 1 thermal, Live 0xe0c70000
fan 3972 0 - Live 0xe0c5f000
ac 3972 0 - Live 0xe0c5d000
nvidia 4543700 12 - Live 0xe10f8000
snd_intel8x0 29980 1 - Live 0xe0bf6000
pcmcia 24224 0 - Live 0xe0bda000
firmware_class 8192 1 pcmcia, Live 0xe0bd7000
ohci1394 32048 0 - Live 0xe0be2000
b44 23820 0 - Live 0xe0bce000
uhci_hcd 21644 0 - Live 0xe0bc7000
ehci_hcd 31880 0 - Live 0xe0bbe000
ieee1394 87220 1 ohci1394, Live 0xe0867000
mii 5248 1 b44, Live 0xe0841000
evdev 8704 1 - Live 0xe0863000
joydev 8512 0 - Live 0xe085f000
snd_ac97_codec 92576 1 snd_intel8x0, Live 0xe0b9c000
snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xe083c000
snd_pcm 72580 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xe0b89000
snd_timer 20868 2 snd_seq,snd_pcm, Live 0xe0844000
yenta_socket 25100 1 - Live 0xe0857000
snd 44644 11
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,s=
nd_ac97_codec,snd_pcm,snd_timer, Live 0xe084b000
rsrc_nonstatic 11648 1 yenta_socket, Live 0xe0826000
snd_page_alloc 8200 2 snd_intel8x0,snd_pcm, Live 0xe082a000
pcmcia_core 34452 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe0832000

Drivers and hardware
---------------
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
04d0-04d1 : pnp 00:00
0800-080f : pnp 00:00
0900-097f : pnp 00:06
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1005 : motherboard
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
  1006-1007 : motherboard
    1006-1007 : pnp 00:01
  1008-100f : motherboard
    1008-100b : ACPI PM_TMR
  1010-105f : motherboard
    1010-1015 : ACPI CPU throttle
    1020-1020 : ACPI PM2_CNT_BLK
    1028-102f : ACPI GPE0_BLK
  1060-107f : motherboard
    1060-107f : pnp 00:01
1080-10bf : 0000:00:1f.0
  1080-10bf : motherboard
    1080-10bf : pnp 00:01
10c0-10df : motherboard
  10c0-10df : pnp 00:01
10e0-10ff : motherboard
b080-b0ff : 0000:00:1f.6
b400-b4ff : 0000:00:1f.6
b800-b8ff : 0000:00:1f.5
  b800-b8ff : Intel 82801DB-ICH4
bc40-bc7f : 0000:00:1f.5
  bc40-bc7f : Intel 82801DB-ICH4
bf20-bf3f : 0000:00:1d.2
  bf20-bf3f : uhci_hcd
bf40-bf5f : 0000:00:1d.1
  bf40-bf5f : uhci_hcd
bf80-bf9f : 0000:00:1d.0
  bf80-bf9f : uhci_hcd
bfa0-bfaf : 0000:00:1f.1
  bfa0-bfa7 : ide0
  bfa8-bfaf : ide1
c000-cfff : PCI Bus #01
d000-efff : PCI Bus #02
  d000-d0ff : PCI CardBus #03
  d400-d4ff : PCI CardBus #03
f400-f4fe : motherboard
  f400-f4fe : pnp 00:01

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffcf7ff : System RAM
  00100000-00368088 : Kernel code
  00368089-0041ff83 : Kernel data
1ffcf800-1fffffff : reserved
30000000-31ffffff : PCI Bus #02
  30000000-31ffffff : PCI CardBus #03
32000000-320003ff : 0000:00:1f.1
d0000000-dfffffff : PCI Bus #01
  d0000000-dfffffff : 0000:01:00.0
    d0000000-d3ffffff : vesafb
e0000000-e7ffffff : 0000:00:00.0
f4fff400-f4fff4ff : 0000:00:1f.5
  f4fff400-f4fff4ff : Intel 82801DB-ICH4
f4fff800-f4fff9ff : 0000:00:1f.5
  f4fff800-f4fff9ff : Intel 82801DB-ICH4
f4fffc00-f4ffffff : 0000:00:1d.7
  f4fffc00-f4ffffff : ehci_hcd
f6000000-fbffffff : PCI Bus #02
  f6000000-f7ffffff : PCI CardBus #03
  f8000000-f8000fff : 0000:02:04.0
    f8000000-f8000fff : yenta_socket
  faff8000-faffbfff : 0000:02:04.1
  faffd800-faffdfff : 0000:02:04.1
    faffd800-faffdfff : ohci1394
  faffe000-faffffff : 0000:02:01.0
    faffe000-faffffff : b44
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : 0000:01:00.0
    fc000000-fcffffff : nvidia
  fd000000-fd01ffff : 0000:01:00.0
fec00000-fec1ffff : reserved
feda0000-fee0ffff : reserved
ffb00000-ffffffff : reserved

PCI hardware
---------------
00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV34M [GeForce FX
Go5200] (rev a1)
02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
02:04.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus
Controller (rev 02)
02:04.1 FireWire (IEEE 1394): Texas Instruments PCI4510 IEEE-1394
Controller
root@persephone:/usr/src/linux# lspci -vvv
00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [40] Vendor Specific Information
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW-
Rate=3Dx4
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at bf80 [size=3D32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at bf40 [size=3D32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 20
        Region 4: I/O ports at bf20 [size=3D32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 18
        Region 0: Memory at f4fffc00 (32-bit, non-prefetchable)
[size=3D1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D06, sec-latency=3D=
32
        I/O behind bridge: 0000d000-0000efff
        Memory behind bridge: f6000000-fbffffff
        Prefetchable memory behind bridge: 30000000-31ffffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at bfa0 [size=3D16]
        Region 5: Memory at 32000000 (32-bit, non-prefetchable)
[size=3D1K]

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b800 [size=3D256]
        Region 1: I/O ports at bc40 [size=3D64]
        Region 2: Memory at f4fff800 (32-bit, non-prefetchable)
[size=3D512]
        Region 3: Memory at f4fff400 (32-bit, non-prefetchable)
[size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
        Subsystem: Broadcom Corporation Unknown device 4d64
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b400 [disabled] [size=3D256]
        Region 1: I/O ports at b080 [disabled] [size=3D128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV34M [GeForce FX
Go5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fc000000 (32-bit, non-prefetchable)
[size=3D16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
        [virtual] Expansion ROM at fd000000 [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit-
FW- Rate=3Dx4

02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at faffe000 (32-bit, non-prefetchable)
[size=3D8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:04.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus
Controller (rev 02)
        Subsystem: Dell Unknown device 015f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f8000000 (32-bit, non-prefetchable)
[size=3D4K]
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: f6000000-f7fff000
        I/O window 0: 0000d000-0000d0ff
        I/O window 1: 0000d400-0000d4ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:04.1 FireWire (IEEE 1394): Texas Instruments PCI4510 IEEE-1394
Controller (prog-if 10 [OHCI])
        Subsystem: Dell Unknown device 015f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at faffd800 (32-bit, non-prefetchable)
[size=3D2K]
        Region 1: Memory at faff8000 (32-bit, non-prefetchable)
[size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1
+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+


--=-zlR88OSfGp4vV82rdhpb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFIGjbu2cEic/xsEARAnolAJ9CWdGmBJQF+LaJ6zFLokLFr0DPMgCgyJPY
7krkdXlRS7c/b3Jy8Lzkz6k=
=ZQ9S
-----END PGP SIGNATURE-----

--=-zlR88OSfGp4vV82rdhpb--

