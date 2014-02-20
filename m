From: Federico Leoni <effelle@gmail.com>
Subject: 8086:2a02 [Dell Vostro 1310] no brightness control on (x)ubuntu
Date: Thu, 20 Feb 2014 10:58:57 -0300
Message-ID: <CAFe6bgXjYa_qbzWpYSt-se+76goFZv6+JTif-Dynqa-U7ddrFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51969 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbaBTN72 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Feb 2014 08:59:28 -0500
Received: by mail-ie0-f174.google.com with SMTP id as1so1255278iec.33
        for <linux-acpi@vger.kernel.org>; Thu, 20 Feb 2014 05:59:27 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

When I press the appropriate keys on my notebook keyboard (Fn+up/Fn+down) the
slider appears on the upper right corner of the screen but the
brightness doesn't change.

On /sys/class/backlight folder I have just
acpi_video0 or dell_backlight (if I set acpi_backlight=vendor on
grub). Since I don't have intel_backlight folder I can't apply many of
the workaround found here and there.

$ for i in /sys/class/backlight/*; do echo -e "\n $i"; cat
$i/{brightness,max_brightness,actual_brightness}; done

/sys/class/backlight/acpi_video0
1
7
1

If I increase/decrease the backlight, both from command line or Fn
keys, the files are correctly updated:

$ echo 7 | sudo tee /sys/class/backlight/acpi_video0/brightness

/sys/class/backlight/acpi_video0
7
7
7

$ acpi_listen (Fn+up/Fn-Down)
video/brightnessup BRTUP 00000086 00000000 K
video/brightnessdown BRTDN 00000087 00000000 K

$ cat /proc/version
Linux version 3.13.0-11.31-031400rc3-generic (apw@gomeisa) (gcc
version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201402200531 SMP Thu
Feb 20 10:33:05 UTC 2014

$ lsb_release -rd
Description:    Ubuntu Trusty Tahr (development branch)
Release:    14.04

$ sh ver_linux

Linux Vostro1310TT 3.13.0-11.31-031400rc3-generic #201402200531 SMP
Thu Feb 20 10:33:05 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.18
Dynamic linker (ldd)   2.18
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         ctr ccm parport_pc ppdev rfcomm bnep bluetooth
6lowpan_iphc snd_hda_codec_realtek snd_hda_codec_generic joydev
uvcvideo snd_hda_intel snd_hda_codec videobuf2_vmalloc
videobuf2_memops videobuf2_core arc4 coretemp videodev snd_hwdep
snd_pcm i915 snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq b43
snd_seq_device microcode snd_timer snd bcma dell_wmi soundcore
sparse_keymap mac80211 drm_kms_helper psmouse dell_laptop lp serio_raw
dcdbas cfg80211 drm parport lpc_ich i2c_algo_bit tpm_infineon video
mac_hid wmi r8169 mii ahci firewire_ohci libahci firewire_core
sdhci_pci sdhci crc_itu_t ssb

$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Core(TM)2 Duo CPU     T5670  @ 1.80GHz
stepping    : 13
microcode    : 0xa1
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm
lahf_lm ida dtherm
bogomips    : 3591.26
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 15
model name    : Intel(R) Core(TM)2 Duo CPU     T5670  @ 1.80GHz
stepping    : 13
microcode    : 0xa1
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm
lahf_lm ida dtherm
bogomips    : 3591.26
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

$ cat /proc/modules
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
rfcomm 74734 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
bluetooth 426845 10 rfcomm,bnep, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
snd_hda_codec_realtek 62466 1 - Live 0x0000000000000000
snd_hda_codec_generic 69424 1 snd_hda_codec_realtek, Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
snd_hda_intel 57222 3 - Live 0x0000000000000000
snd_hda_codec 142651 3
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, Live
0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 45465 1 uvcvideo, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
coretemp 17768 0 - Live 0x0000000000000000
videodev 149340 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 108860 2 snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
i915 826455 3 - Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
b43 397438 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 73979 17 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
bcma 52681 1 b43, Live 0x0000000000000000
dell_wmi 12681 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
sparse_keymap 13890 1 dell_wmi, Live 0x0000000000000000
mac80211 676851 1 b43, Live 0x0000000000000000
drm_kms_helper 53224 1 i915, Live 0x0000000000000000
psmouse 108621 0 - Live 0x0000000000000000
dell_laptop 18315 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
dcdbas 15017 1 dell_laptop, Live 0x0000000000000000
cfg80211 531467 2 b43,mac80211, Live 0x0000000000000000
drm 308197 4 i915,drm_kms_helper, Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
tpm_infineon 17152 0 - Live 0x0000000000000000
video 19859 1 i915, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
wmi 19363 1 dell_wmi, Live 0x0000000000000000
r8169 73299 0 - Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
ahci 30066 2 - Live 0x0000000000000000
firewire_ohci 45289 0 - Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
firewire_core 69362 1 firewire_ohci, Live 0x0000000000000000
sdhci_pci 23263 0 - Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
ssb 63194 1 b43, Live 0x0000000000000000

$  cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0170-0177 : 0000:00:1f.1
    0170-0177 : ata_piix
  01f0-01f7 : 0000:00:1f.1
    01f0-01f7 : ata_piix
  0376-0376 : 0000:00:1f.1
    0376-0376 : ata_piix
  03c0-03df : vesafb
  03f6-03f6 : 0000:00:1f.1
    03f6-03f6 : ata_piix
  0680-069f : pnp 00:05
  0800-080f : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1003 : ACPI PM1a_EVT_BLK
  1004-1005 : ACPI PM1a_CNT_BLK
  1008-100b : ACPI PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-1020 : ACPI PM2_CNT_BLK
  1028-102f : ACPI GPE0_BLK
  1030-1033 : iTCO_wdt
  1060-107f : iTCO_wdt
  1180-11bf : 0000:00:1f.0
    1180-11bf : pnp 00:05
  1800-1807 : 0000:00:02.0
  1810-181f : 0000:00:1f.1
    1810-181f : ata_piix
  1820-183f : 0000:00:1a.0
    1820-183f : uhci_hcd
  1840-185f : 0000:00:1a.1
    1840-185f : uhci_hcd
  1860-187f : 0000:00:1d.0
    1860-187f : uhci_hcd
  1880-189f : 0000:00:1d.1
    1880-189f : uhci_hcd
  18a0-18bf : 0000:00:1d.2
    18a0-18bf : uhci_hcd
  18d0-18d3 : 0000:00:1f.2
    18d0-18d3 : ahci
  18d4-18d7 : 0000:00:1f.2
    18d4-18d7 : ahci
  18d8-18df : 0000:00:1f.2
    18d8-18df : ahci
  18e0-18ff : 0000:00:1f.2
    18e0-18ff : ahci
  1c00-1c07 : 0000:00:1f.2
    1c00-1c07 : ahci
  1c20-1c3f : 0000:00:1f.3
  2000-2fff : PCI Bus 0000:02
  3000-3fff : PCI Bus 0000:03
  4000-4fff : PCI Bus 0000:06
  5000-5fff : PCI Bus 0000:07
    5000-50ff : 0000:07:00.0
      5000-50ff : r8169
  fe00-fe00 : pnp 00:05
  ff00-ff7f : pnp 00:05

$  cat /proc/iomem
00000000-00000fff : reserved
00001000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-bf6cffff : System RAM
  01000000-01774145 : Kernel code
  01774146-01d157ff : Kernel data
  01e73000-01fd8fff : Kernel bss
bf6d0000-bf6e2fff : ACPI Non-volatile Storage
bf6e3000-bfffffff : reserved
  bf800000-bfffffff : Graphics Stolen Memory
c0000000-dfffffff : PCI Bus 0000:00
  c0000000-c04fffff : PCI Bus 0000:07
  c0500000-c05000ff : 0000:00:1f.3
  c0501000-c0501fff : Intel Flush Page
  c4000000-c7ffffff : PCI Bus 0000:02
  cc000000-cdffffff : PCI Bus 0000:02
  d0000000-dfffffff : 0000:00:02.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : reserved
    e0000000-efffffff : pnp 00:00
f0000000-febfffff : PCI Bus 0000:00
  f0000000-f3ffffff : PCI Bus 0000:03
  f4000000-f7ffffff : PCI Bus 0000:06
    f4000000-f4003fff : 0000:06:00.0
      f4000000-f4003fff : b43-pci-bridge
  f8000000-f80fffff : 0000:00:02.0
  f8100000-f81fffff : 0000:00:02.1
  f8200000-f82fffff : PCI Bus 0000:08
    f8200000-f8200fff : 0000:08:05.0
      f8200000-f8200fff : firewire_ohci
    f8201000-f8201fff : 0000:08:05.3
    f8202000-f82027ff : 0000:08:05.0
    f8202800-f82028ff : 0000:08:05.2
      f8202800-f82028ff : mmc0
  f8500000-f8503fff : 0000:00:1b.0
    f8500000-f8503fff : ICH HD audio
  f8504000-f85047ff : 0000:00:1f.2
    f8504000-f85047ff : ahci
  f8504800-f8504bff : 0000:00:1a.7
    f8504800-f8504bff : ehci_hcd
  f8504c00-f8504fff : 0000:00:1d.7
    f8504c00-f8504fff : ehci_hcd
  f8600000-f86fffff : PCI Bus 0000:07
    f8600000-f860ffff : 0000:07:00.0
      f8600000-f860ffff : r8169
    f8610000-f8610fff : 0000:07:00.0
      f8610000-f8610fff : r8169
    f8620000-f862ffff : 0000:07:00.0
  fa000000-fbffffff : PCI Bus 0000:03
  fc000000-fdffffff : PCI Bus 0000:06
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : reserved
    fed00000-fed003ff : pnp 00:03
fed14000-fed19fff : reserved
  fed14000-fed17fff : pnp 00:00
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed8ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
  fed20000-fed3ffff : pnp 00:00
  fed40000-fed44fff : pnp 00:00
  fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
100000000-13fffffff : System RAM

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory
Controller Hub (rev 0c)
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0a <?>
    Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile
GM965/GL960 Integrated Graphics Controller (primary) (rev 0c) (prog-if
00 [VGA controller])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 45
    Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=1M]
    Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 1800 [size=8]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 4142
    Capabilities: [d0] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+
    Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960
Integrated Graphics Controller (secondary) (rev 0c)
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at f8100000 (64-bit, non-prefetchable) [size=1M]
    Capabilities: [d0] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+

00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 4: I/O ports at 1820 [size=32]
    Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 21
    Region 4: I/O ports at 1840 [size=32]
    Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2
EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Region 0: Memory at f8504800 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 03)
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at f8500000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 4172
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 1 (rev 03) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: c4000000-c7ffffff
    Prefetchable memory behind bridge: 00000000cc000000-00000000cdffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41a1
    Capabilities: [90] Subsystem: Dell Device 026f
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [180 v1] Root Complex Link
        Desc:    PortNumber=01 ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c001
    Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 2 (rev 03) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f0000000-f3ffffff
    Prefetchable memory behind bridge: 00000000fa000000-00000000fbffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41b1
    Capabilities: [90] Subsystem: Dell Device 026f
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [180 v1] Root Complex Link
        Desc:    PortNumber=02 ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c001
    Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 4 (rev 03) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: f4000000-f7ffffff
    Prefetchable memory behind bridge: 00000000fc000000-00000000fdffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #5, PowerLimit 6.500W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41c1
    Capabilities: [90] Subsystem: Dell Device 026f
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [180 v1] Root Complex Link
        Desc:    PortNumber=04 ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c001
    Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 5 (rev 03) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
    I/O behind bridge: 00005000-00005fff
    Memory behind bridge: c0000000-c04fffff
    Prefetchable memory behind bridge: 00000000f8600000-00000000f86fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L0s Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41d1
    Capabilities: [90] Subsystem: Dell Device 026f
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [180 v1] Root Complex Link
        Desc:    PortNumber=05 ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c001
    Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 4: I/O ports at 1860 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 19
    Region 4: I/O ports at 1880 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Region 4: I/O ports at 18a0 [size=32]
    Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2
EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at f8504c00 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3)
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=08, subordinate=08, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f8200000-f82fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR+
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Dell Device 026f

00:1f.0 ISA bridge: Intel Corporation 82801HM (ICH8M) LPC Interface
Controller (rev 03)
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.1 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E)
IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at 01f0 [size=8]
    Region 1: I/O ports at 03f4
    Region 2: I/O ports at 0170 [size=8]
    Region 3: I/O ports at 0374
    Region 4: I/O ports at 1810 [size=16]
    Kernel driver in use: ata_piix

00:1f.2 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E)
SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 18
    Region 0: I/O ports at 1c00 [size=8]
    Region 1: I/O ports at 18d4 [size=4]
    Region 2: I/O ports at 18d8 [size=8]
    Region 3: I/O ports at 18d0 [size=4]
    Region 4: I/O ports at 18e0 [size=32]
    Region 5: Memory at f8504000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable- Count=1/4 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 10
    Region 0: Memory at c0500000 (32-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 1c20 [size=32]

06:00.0 Network controller: Broadcom Corporation BCM4312 802.11b/g
LP-PHY (rev 01)
    Subsystem: Dell Wireless 1395 WLAN Mini-Card
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at f4000000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
    Capabilities: [58] Vendor Specific Information: Len=78 <?>
    Capabilities: [e8] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [d0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [13c v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 21-5a-4e-ff-ff-cf-00-23
    Capabilities: [16c v1] Power Budgeting <?>
    Kernel driver in use: b43-pci-bridge

07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 02)
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 44
    Region 0: I/O ports at 5000 [size=256]
    Region 2: Memory at f8610000 (64-bit, prefetchable) [size=4K]
    Region 4: Memory at f8600000 (64-bit, prefetchable) [size=64K]
    [virtual] Expansion ROM at f8620000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 4122
    Capabilities: [70] Express (v1) Endpoint, MSI 01
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <8us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [d0] Vital Product Data
        Unknown small resource type 00, will not decode more.
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Kernel driver in use: r8169

08:05.0 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev
02) (prog-if 10 [OHCI])
    Subsystem: Dell Device 026f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 22
    Region 0: Memory at f8200000 (32-bit, non-prefetchable) [size=4K]
    Region 1: Memory at f8202000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
    Kernel driver in use: firewire_ohci

08:05.2 SD Host controller: O2 Micro, Inc. Integrated MMC/SD
Controller (rev 02) (prog-if 01)
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 22
    Region 0: Memory at f8202800 (32-bit, non-prefetchable) [size=256]
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: sdhci-pci

08:05.3 Mass storage controller: O2 Micro, Inc. Integrated MS/xD
Controller (rev 01)
    Subsystem: Dell Device 026f
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at f8201000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

$  cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: DVD+-RW DVW28SLC Rev: A.06
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1600BEVT-7 Rev: 11.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

$  ls /proc
1     1207  139   1799  27    488  828        driver         sched_debug
10    1209  14    1800  270   5    83         execdomains    schedstat
1002  1213  1412  1813  276   539  831        fb             scsi
1070  1221  1436  1842  28    54   859        filesystems    self
1073  1222  149   1849  286   545  878        fs             slabinfo
1081  1225  15    1855  29    548  890        interrupts     softirqs
1087  1227  150   1868  3     566  892        iomem          stat
1096  1229  1519  1876  30    571  896        ioports        swaps
1097  1231  1521  19    31    58   9          irq            sys
1099  1234  1523  1939  32    59   908        kallsyms       sysrq-trigger
11    1235  1524  1983  33    60   962        kcore          sysvipc
1101  1246  1536  1994  3405  61   969        key-users      timer_list
1118  1248  1538  2     3406  661  981        kmsg           timer_stats
1120  1259  1540  20    356   689  987        kpagecount     tty
1121  1264  1550  2036  37    698  988        kpageflags     uptime
1125  13    1581  2051  3701  7    acpi       latency_stats  version
1126  1303  1589  2052  3716  739  asound     loadavg        vmallocinfo
1131  131   1591  21    38    759  buddyinfo  locks          vmstat
1135  1313  1595  2126  3865  765  bus        mdstat         zoneinfo
1140  132   16    22    39    771  cgroups    meminfo
1142  1337  1636  2243  3905  782  cmdline    misc
1143  134   1644  2244  3909  8    consoles   modules
1145  1346  1648  23    3921  81   cpuinfo    mounts
1158  135   1652  24    3927  817  crypto     mtrr
1163  136   17    25    40    82   devices    net
1191  137   1792  2536  401   821  diskstats  pagetypeinfo
12    138   1793  26    41    827  dma        partitions

Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1281176


Thanks.

Federico Leoni
