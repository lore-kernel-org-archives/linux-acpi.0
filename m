From: John Marsden <john.d.marsden@gmail.com>
Subject: PROBLEM: [Toshiba Portege Z835] Brightness control lost after suspend
Date: Mon, 28 Jul 2014 21:52:27 +0100
Message-ID: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61171 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaG1Uwa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jul 2014 16:52:30 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so6310530lbd.14
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2014 13:52:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem
[Toshiba Portege Z835] Brightness control lost after suspend

[2.] Full description of the problem/report:
Using a Toshiba Portege Z835 computer I expect brightness of my LCD
screen to remain the same and be controllable after waking from
suspend. Afer suspend it doesn't remain the same and isn't
controllable.

What happens:

Brightness controls fully working after initial boot, both through
function keys and system settings applet.

After putting computer into suspend and then re-awakening the LCD
screen comes up with different brightness in actual appearance but
settings still show the brightness as set at suspend time. Controls
for brightness have become ineffective - they slide the brightness bar
along but make no difference to the actual brightness of the screen.
The brightness of the LCD on re-awakening appears to be at lowest
setting if running on battery or machine has been idle for some time.
The key problem is that it cannot be changed back to desired
brightness without a complete system re-start.

This occurs both on my Toshiba Portege Z835-ST6N03 and my wife's
Toshiba Protege Z835-ST8305

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
cat /proc/version
Linux version 3.16.0-031600rc6-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201407210035 SMP Mon Jul 21
04:36:11 UTC 2014

[5.] Output of Oops.. message
Not applicable

[6.] A small shell script or example program which triggers the problem
Not applicable

[7.] Environment
lsb_release -rd
Description: Ubuntu 14.04.1 LTS
Release: 14.04

[7.1.] Software (initiation and output of the ver_linux script below)
john@JDM-UB:/usr/src/linux-headers-3.16.0-031600rc6/scripts$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux JDM-UB 3.16.0-031600rc6-generic #201407210035 SMP Mon Jul 21
04:36:11 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         nvram cuse bnep rfcomm bluetooth 6lowpan_iphc
binfmt_misc uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core
v4l2_common snd_hda_codec_hdmi videodev media snd_hda_codec_realtek
snd_hda_codec_generic intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm arc4 crct10dif_pclmul iwldvm crc32_pclmul
ghash_clmulni_intel aesni_intel aes_x86_64 mac80211 lrw gf128mul
glue_helper ablk_helper snd_hda_intel cryptd snd_hda_controller
snd_hda_codec snd_hwdep i915 snd_pcm snd_seq_midi snd_seq_midi_event
iwlwifi snd_rawmidi snd_seq microcode snd_seq_device drm_kms_helper
snd_timer drm joydev snd i2c_algo_bit serio_raw cfg80211 toshiba_acpi
parport_pc soundcore sparse_keymap mei_me ppdev wmi video tpm_infineon
toshiba_bluetooth lpc_ich mei lp mac_hid parport e1000e psmouse ahci
sdhci_pci libahci ptp sdhci pps_core

[7.2.] Processor information (from /proc/cpuinfo):
cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2677M CPU @ 1.80GHz
stepping : 7
microcode : 0x23
cpu MHz : 1032.257
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3591.92
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2677M CPU @ 1.80GHz
stepping : 7
microcode : 0x23
cpu MHz : 2389.851
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3591.92
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2677M CPU @ 1.80GHz
stepping : 7
microcode : 0x23
cpu MHz : 2517.046
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3591.92
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2677M CPU @ 1.80GHz
stepping : 7
microcode : 0x23
cpu MHz : 2688.750
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3591.92
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
cat /proc/modules
nvram 14462 0 - Live 0x0000000000000000
cuse 13566 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 0 - Live 0x0000000000000000
bluetooth 467228 10 bnep,rfcomm, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59635 1 uvcvideo, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
snd_hda_codec_hdmi 48243 1 - Live 0x0000000000000000
videodev 154834 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
snd_hda_codec_realtek 73695 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
kvm_intel 149086 0 - Live 0x0000000000000000
kvm 464279 1 kvm_intel, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
iwldvm 243680 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 152648 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
mac80211 687067 1 iwldvm, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 30683 3 - Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 144889 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
i915 945853 4 - Live 0x0000000000000000
snd_pcm 105052 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
iwlwifi 190534 1 iwldvm, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
microcode 24525 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
drm_kms_helper 62042 1 i915, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
drm 316819 6 i915,drm_kms_helper, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
snd 84025 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
cfg80211 521225 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
toshiba_acpi 28375 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
sparse_keymap 13890 1 toshiba_acpi, Live 0x0000000000000000
mei_me 19565 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
wmi 19379 1 toshiba_acpi, Live 0x0000000000000000
video 20521 1 i915, Live 0x0000000000000000
tpm_infineon 17169 0 - Live 0x0000000000000000
toshiba_bluetooth 12867 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
mei 88632 1 mei_me, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
e1000e 229859 0 - Live 0x0000000000000000
psmouse 113097 0 - Live 0x0000000000000000
ahci 30167 1 - Live 0x0000000000000000
sdhci_pci 23352 0 - Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
ptp 19534 1 e1000e, Live 0x0000000000000000
sdhci 44159 1 sdhci_pci, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
    00f0-00f0 : PNP0C04:00
  01e0-01e7 : pnp 00:04
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-053f : pnp 00:03
  0680-06ff : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:03
  2000-203f : 0000:00:02.0
  2060-207f : 0000:00:1f.2
    2060-207f : ahci
  2080-209f : 0000:00:19.0
  20a0-20a7 : 0000:00:1f.2
    20a0-20a7 : ahci
  20a8-20af : 0000:00:1f.2
    20a8-20af : ahci
  20b8-20bb : 0000:00:1f.2
    20b8-20bb : ahci
  20bc-20bf : 0000:00:1f.2
    20bc-20bf : ahci
  ffff-ffff : pnp 00:03
    ffff-ffff : pnp 00:03

cat /proc/iomem
00000000-00000fff : reserved
00001000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce7ff : Video ROM
000ce800-000cf7ff : Adapter ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-01796498 : Kernel code
  01796499-01d1747f : Kernel data
  01e76000-01fb8fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:08
20200000-3fffffff : System RAM
40000000-401fffff : reserved
  40000000-401fffff : pnp 00:08
40200000-aa2eefff : System RAM
aa2ef000-aa2ef1ff : ACPI Non-volatile Storage
aa2ef200-aa2f1fff : reserved
aa2f2000-aa3eefff : ACPI Non-volatile Storage
aa3ef000-aa40efff : ACPI Tables
aa40f000-af9fffff : reserved
  aba00000-af9fffff : Graphics Stolen Memory
afa00000-feafffff : PCI Bus 0000:00
  afa00000-afa00fff : pnp 00:00
  b0000000-bfffffff : 0000:00:02.0
  c0000000-c03fffff : 0000:00:02.0
  c0400000-c04fffff : PCI Bus 0000:03
    c0400000-c0401fff : 0000:03:00.0
      c0400000-c0401fff : xhci_hcd
  c0500000-c05fffff : PCI Bus 0000:02
    c0500000-c0501fff : 0000:02:00.0
      c0500000-c0501fff : iwlwifi
  c0600000-c06fffff : PCI Bus 0000:01
    c0600000-c06000ff : 0000:01:00.0
      c0600000-c06000ff : mmc0
  c0700000-c071ffff : 0000:00:19.0
    c0700000-c071ffff : e1000e
  c0720000-c0723fff : 0000:00:1b.0
    c0720000-c0723fff : ICH HD audio
  c0724000-c072400f : 0000:00:16.0
    c0724000-c072400f : mei_me
  c0728000-c07287ff : 0000:00:1f.2
    c0728000-c07287ff : ahci
  c0729000-c07293ff : 0000:00:1d.0
    c0729000-c07293ff : ehci_hcd
  c072a000-c072a3ff : 0000:00:1a.0
    c072a000-c072a3ff : ehci_hcd
  c072b000-c072bfff : 0000:00:19.0
    c072b000-c072bfff : e1000e
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
feb00000-feb03fff : pnp 00:00
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:02
fed10000-fed19fff : reserved
  fed10000-fed17fff : pnp 00:00
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffc00000-ffffffff : reserved
100000000-1cfdfffff : System RAM
1cfe00000-1cfffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
 sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
Family DRAM Controller (rev 09)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09) (prog-if
00 [VGA controller])
Subsystem: Toshiba America Info Systems Device 0009
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 49
Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 2000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4162
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200
Series Chipset Family MEI Controller #1 (rev 04)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 46
Region 0: Memory at c0724000 (64-bit, non-prefetchable) [size=16]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41b2
Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network
Connection (rev 04)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 47
Region 0: Memory at c0700000 (32-bit, non-prefetchable) [size=128K]
Region 1: Memory at c072b000 (32-bit, non-prefetchable) [size=4K]
Region 2: I/O ports at 2080 [size=32]
Capabilities: [c8] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41c2
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at c072a000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 04)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 50
Region 0: Memory at c0720000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41d2
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=22
Status: NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc: PortNumber=0f ComponentID=00 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed1c000
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: c0600000-c06fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 3 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: c0500000-c05fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 5 (rev b4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: c0400000-c04fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at c0729000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC
Controller (rev 04)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series
Chipset Family 6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI
1.0])
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 45
Region 0: I/O ports at 20a8 [size=8]
Region 1: I/O ports at 20bc [size=4]
Region 2: I/O ports at 20a0 [size=8]
Region 3: I/O ports at 20b8 [size=4]
Region 4: I/O ports at 2060 [size=32]
Region 5: Memory at c0728000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0c00c  Data: 41d1
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci

01:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller
(rev 07) (prog-if 01)
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at c0600000 (32-bit, non-prefetchable) [size=256]
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [78] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
Capabilities: [80] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 unlimited
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [800 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: sdhci-pci

02:00.0 Network controller: Intel Corporation Centrino Advanced-N 6230
[Rainbow Peak] (rev 34)
Subsystem: Intel Corporation Centrino Advanced-N 6230 AGN
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 48
Region 0: Memory at c0500000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0100c  Data: 4152
Capabilities: [e0] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 <32us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number 88-53-2e-ff-ff-ae-d3-a5
Kernel driver in use: iwlwifi

03:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 04) (prog-if 30 [XHCI])
Subsystem: Toshiba America Info Systems Device 0001
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at c0400000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
Vector table: BAR=0 offset=00001000
PBA: BAR=0 offset=00001080
Capabilities: [a0] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<4us, L1 unlimited
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq+ ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
Capabilities: [150 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Kernel driver in use: xhci_hcd

[7.6.] SCSI information (from /proc/scsi/scsi)
 cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA THNSNB12 Rev: 0202
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem:
Results of
 ls /proc,
 cat /proc/acpi/wakeup
 and the output of dmesg (including suspend with pm-trace on at [   56.676675])
 ## NOTE: the dmesg output has been editted to make the total email
size to less than 100k
 ## All references to ACPI and PM have been preserved.
 ## Will supply full dmesg text on request.
follow:

 ls /proc
1     1453  1831  2026  2200  2885  41   7          cpuinfo      pagetypeinfo
10    1494  1832  2034  2204  2886  412  757        crypto       partitions
100   15    1889  2041  2213  2890  42   76         devices      sched_debug
101   1526  1894  2043  2235  2891  421  771        diskstats    schedstat
1016  1534  19    2045  2256  2893  43   78         dma          scsi
1043  154   1902  2049  2260  29    44   79         driver       self
1047  155   1906  2053  23    2912  45   8          execdomains  slabinfo
1054  156   1907  2063  2325  2919  46   80         fb           softirqs
1055  157   1916  2064  2331  2927  47   802        filesystems  stat
1058  158   1921  2065  2337  2932  48   81         fs           swaps
11    159   1923  2070  2340  3     480  813        interrupts   sys
1103  16    1931  2079  2352  3035  481  825        iomem        sysrq-trigger
1104  160   1935  2081  2358  3043  49   835        ioports      sysvipc
1111  161   1937  2099  2378  3060  5    838        irq          timer_list
1132  162   1940  21    2382  31    50   845        kallsyms     timer_stats
1136  163   1943  2100  2383  323   500  849        kcore        tty
1141  1630  1944  2113  2384  3239  51   852        key-users    uptime
1148  164   1946  2131  24    329   52   858        kmsg         version
1166  1647  1954  2138  25    33    53   9          kpagecount   vmallocinfo
1172  165   1956  2141  2632  3307  54   920        kpageflags   vmstat
1178  166   1965  2149  2633  3314  55   926        loadavg      zoneinfo
12    17    1970  2154  2636  3315  56   933        locks
1225  1777  1972  2157  2637  3338  58   acpi       mdstat
1226  1796  1982  2159  2638  3354  605  asound     meminfo
13    1798  2     2161  2639  34    62   buddyinfo  misc
1365  18    20    2176  28    36    627  bus        modules
1368  181   2010  2181  2834  38    63   cgroups    mounts
14    182   2016  2194  2877  39    64   cmdline    mtrr
1416  1827  2021  22    2884  397   664  consoles   net

 cat /proc/acpi/wakeup > wakeup
Device S-state  Status   Sysfs node
LANC  S4 *disabled  pci:0000:00:19.0
HDEF  S3 *disabled  pci:0000:00:1b.0
RP04  S4 *disabled
PXSX  S4 *disabled
USBB  S4 *disabled
EHC1  S4 *enabled   pci:0000:00:1d.0
EHC2  S4 *enabled   pci:0000:00:1a.0
PWRB  S4 *enabled   platform:PNP0C0C:00
LID  S4 *enabled   platform:PNP0C0D:00

 ## NOTE: the dmesg output has been editted to make the total email
size to less than 100k
 ## All references to ACPI and PM have been preserved.
 ## Will supply full dmesg text on request.
 dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.16.0-031600rc6-generic (apw@gomeisa)
(gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201407210035 SMP
Mon Jul 21 04:36:11 UTC 2014
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-3.16.0-031600rc6-generic
root=UUID=865f4d37-5ceb-4e4a-b59b-032fa8a2c80b ro quiet splash
elevator=noop vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000aa2eefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000aa2ef000-0x00000000aa2ef1ff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aa2ef200-0x00000000aa2f1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000aa2f2000-0x00000000aa3eefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aa3ef000-0x00000000aa40efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000aa40f000-0x00000000af9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001cfdfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: TOSHIBA PORTEGE Z835/Portable PC, BIOS Version
1.80   04/18/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x1cfe00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 uncachable
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0AC000000 mask FFC000000 uncachable
[    0.000000]   5 base 0AB800000 mask FFF800000 uncachable
[    0.000000]   6 base 100000000 mask F00000000 write-back
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 4092MB, range: 4MB, type UC
[    0.000000] reg 1, base: 0GB, range: 2GB, type WB
[    0.000000] reg 2, base: 2GB, range: 1GB, type WB
[    0.000000] reg 3, base: 2816MB, range: 256MB, type UC
[    0.000000] reg 4, base: 2752MB, range: 64MB, type UC
[    0.000000] reg 5, base: 2744MB, range: 8MB, type UC
[    0.000000] reg 6, base: 4GB, range: 4GB, type WB
[    0.000000] total RAM covered: 6840M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K chunk_size: 16M num_reg: 6   lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 512MB, type WB
[    0.000000] reg 2, base: 2560MB, range: 128MB, type WB
[    0.000000] reg 3, base: 2688MB, range: 64MB, type WB
[    0.000000] reg 4, base: 2744MB, range: 8MB, type UC
[    0.000000] reg 5, base: 4GB, range: 4GB, type WB
[    0.000000] e820: update [mem 0xab800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xaa2ef max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01fba000, 0x01fbafff] PGTABLE
[    0.000000] BRK [0x01fbb000, 0x01fbbfff] PGTABLE
[    0.000000] BRK [0x01fbc000, 0x01fbcfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x1cfc00000-0x1cfdfffff]
[    0.000000]  [mem 0x1cfc00000-0x1cfdfffff] page 2M
[    0.000000] BRK [0x01fbd000, 0x01fbdfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x1cc000000-0x1cfbfffff]
[    0.000000]  [mem 0x1cc000000-0x1cfbfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x180000000-0x1cbffffff]
[    0.000000]  [mem 0x180000000-0x1cbffffff] page 2M
[    0.000000] BRK [0x01fbe000, 0x01fbefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x40200000-0xaa2eefff]
[    0.000000]  [mem 0x40200000-0xaa1fffff] page 2M
[    0.000000]  [mem 0xaa200000-0xaa2eefff] page 4k
[    0.000000] BRK [0x01fbf000, 0x01fbffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x100000000-0x17fffffff]
[    0.000000]  [mem 0x100000000-0x17fffffff] page 2M
[    0.000000] cma: CMA: reserved 64 MiB at 1cbc00000
[    0.000000] RAMDISK: [mem 0x35c30000-0x36e0ffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0030 000014 (v00 TOSHIB)
[    0.000000] ACPI: RSDT 0x00000000AA40E038 000054 (v01 TOSHIB A0081
  00000001      01000013)
[    0.000000] ACPI: FACP 0x00000000AA40D000 000081 (v02 TOSHIB A0081
  00000001 LOHR 0000005F)
[    0.000000] ACPI: DSDT 0x00000000AA3FC000 008AEE (v02 TOSHIB A0081
  20110909 INTL 20061109)
[    0.000000] ACPI: FACS 0x00000000AA3CB000 000040
[    0.000000] ACPI: HPET 0x00000000AA40C000 000038 (v01 TOSHIB A0081
  00000001 LOHR 0000005F)
[    0.000000] ACPI: APIC 0x00000000AA40B000 0000BC (v01 TOSHIB A0081
  00000001 LOHR 0000005F)
[    0.000000] ACPI: MCFG 0x00000000AA40A000 00003C (v01 TOSHIB A0081
  00000001 LOHR 0000005F)
[    0.000000] ACPI: ASF! 0x00000000AA409000 0000A0 (v32 TOSHIB A0081
  00000001 LOHR 0000005F)
[    0.000000] ACPI: TCPA 0x00000000AA408000 000032 (v02 TOSHIB A0081
  00000000 LOHR 0000005F)
[    0.000000] ACPI: BOOT 0x00000000AA407000 000028 (v01 TOSHIB A0081
  00000000 LOHR 0000005F)
[    0.000000] ACPI: SLIC 0x00000000AA406000 000176 (v01 TOSHIB A0081
  00000000 LOHR 0000005F)
[    0.000000] ACPI: SSDT 0x00000000AA3FB000 000395 (v01 TOSHIB
SataAhci 00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA3F8000 000720 (v01 TOSHIB
PtidDevc 00001000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA3F6000 0008AB (v01 PmRef
Cpu0Ist  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000AA3F5000 000996 (v01 PmRef  CpuPm
  00003000 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000001cfdfffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x1cfdfffff]
[    0.000000]   NODE_DATA [mem 0x1cfdf7000-0x1cfdfbfff]
[    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD ->
[ffff8801c5400000-ffff8801cb3fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x1cfdfffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x3fffffff]
[    0.000000]   node   0: [mem 0x40200000-0xaa2eefff]
[    0.000000]   node   0: [mem 0x100000000-0x1cfdfffff]
[    0.000000] On node 0 totalpages: 1547404
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 157 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10812 pages used for memmap
[    0.000000]   DMA32 zone: 691951 pages, LIFO batch:31
[    0.000000]   Normal zone: 13304 pages used for memmap
[    0.000000]   Normal zone: 851456 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0xaba00000-0xaf9fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa2ef000-0xaa2effff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa2f0000-0xaa2f1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa2f2000-0xaa3eefff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa3ef000-0xaa40efff]
[    0.000000] PM: Registered nosave memory: [mem 0xaa40f000-0xaf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xafa00000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] e820: [mem 0xafa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff8801cba00000 s86336
r8192 d24256 u262144
[    0.000000] pcpu-alloc: s86336 r8192 d24256 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 1523067
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-3.16.0-031600rc6-generic
root=UUID=865f4d37-5ceb-4e4a-b59b-032fa8a2c80b ro quiet splash
elevator=noop vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 5923452K/6189616K available (7768K kernel code,
1117K rwdata, 3696K rodata, 1364K init, 1292K bss, 266164K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] Offload RCU callbacks from all CPUs
[    0.000000] Offload RCU callbacks from CPUs: 0-7.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:16640 nr_irqs:744 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 25165824 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1795.963 MHz processor
[    0.000032] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3591.92 BogoMIPS (lpj=7183852)
[    0.000034] pid_max: default: 32768 minimum: 301
[    0.000041] ACPI: Core revision 20140424
[    0.006813] ACPI: All ACPI Tables successfully acquired
[    0.007642] Security Framework initialized
[    0.007654] AppArmor: AppArmor initialized
[    0.007655] Yama: becoming mindful.
[    0.008195] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.009846] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010509] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010520] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.010835] Initializing cgroup subsys memory
[    0.010857] Initializing cgroup subsys devices
[    0.010862] Initializing cgroup subsys freezer
[    0.010865] Initializing cgroup subsys net_cls
[    0.010869] Initializing cgroup subsys blkio
[    0.010872] Initializing cgroup subsys perf_event
[    0.010874] Initializing cgroup subsys net_prio
[    0.010880] Initializing cgroup subsys hugetlb
[    0.010901] CPU: Physical Processor ID: 0
[    0.010902] CPU: Processor Core ID: 0
[    0.010906] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.010906] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.010909] mce: CPU supports 7 MCE banks
[    0.010919] CPU0: Thermal monitoring enabled (TM1)
[    0.010928] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.010928] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.010928] tlb_flushall_shift: 6
[    0.011034] Freeing SMP alternatives memory: 28K (ffffffff81e6e000
- ffffffff81e75000)
[    0.012404] ftrace: allocating 31895 entries in 125 pages
[    0.027227] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.066901] smpboot: CPU0: Intel(R) Core(TM) i7-2677M CPU @ 1.80GHz
(fam: 06, model: 2a, stepping: 07)
[    0.066909] TSC deadline timer enabled
[    0.066936] Performance Events: PEBS fmt1+, 16-deep LBR,
SandyBridge events, full-width counters, Intel PMU driver.
[    0.066942] perf_event_intel: PEBS disabled due to CPU errata,
please upgrade microcode
[    0.066944] ... version:                3
[    0.066945] ... bit width:              48
[    0.066946] ... generic registers:      4
[    0.066947] ... value mask:             0000ffffffffffff
[    0.066948] ... max period:             0000ffffffffffff
[    0.066949] ... fixed-purpose events:   3
[    0.066950] ... event mask:             000000070000000f
[    0.068527] x86: Booting SMP configuration:
[    0.068529] .... node  #0, CPUs:      #1
[    0.081641] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.081732]  #2 #3
[    0.108002] x86: Booted up 1 node, 4 CPUs
[    0.108006] smpboot: Total of 4 processors activated (14367.70 BogoMIPS)
[    0.111890] devtmpfs: initialized
[    0.115838] evm: security.selinux
[    0.115839] evm: security.SMACK64
[    0.115840] evm: security.SMACK64EXEC
[    0.115841] evm: security.SMACK64TRANSMUTE
[    0.115842] evm: security.SMACK64MMAP
[    0.115843] evm: security.ima
[    0.115844] evm: security.capability
[    0.115901] PM: Registering ACPI NVS region [mem
0xaa2ef000-0xaa2ef1ff] (512 bytes)
[    0.115902] PM: Registering ACPI NVS region [mem
0xaa2f2000-0xaa3eefff] (1036288 bytes)
[    0.116714] pinctrl core: initialized pinctrl subsystem
[    0.116781] regulator-dummy: no parameters
[    0.116988] RTC time: 17:31:07, date: 07/24/14
[    0.117039] NET: Registered protocol family 16
[    0.117196] cpuidle: using governor ladder
[    0.117200] cpuidle: using governor menu
[    0.117251] ACPI: bus type PCI registered
[    0.117252] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.117329] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.117331] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.117410] PCI: Using configuration type 1 for base access
[    0.120460] ACPI: Added _OSI(Module Device)
[    0.120462] ACPI: Added _OSI(Processor Device)
[    0.120463] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.120464] ACPI: Added _OSI(Processor Aggregator Device)
[    0.128092] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.129014] ACPI: Dynamic OEM Table Load:
[    0.129022] ACPI: SSDT 0xFFFF8801C28F9800 00071E (v01 PmRef
Cpu0Cst  00003001 INTL 20061109)
[    0.132261] ACPI: Dynamic OEM Table Load:
[    0.132267] ACPI: SSDT 0xFFFF8801C28CDC00 000303 (v01 PmRef  ApIst
  00003000 INTL 20061109)
[    0.136145] ACPI: Dynamic OEM Table Load:
[    0.136151] ACPI: SSDT 0xFFFF8801C2903000 000119 (v01 PmRef  ApCst
  00003000 INTL 20061109)
[    0.140517] ACPI: Interpreter enabled
[    0.140522] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S1_] (20140424/hwxface-580)
[    0.140526] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20140424/hwxface-580)
[    0.140538] ACPI: (supports S0 S3 S4 S5)
[    0.140540] ACPI: Using IOAPIC for interrupt routing
[    0.140561] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.145628] ACPI: Power Resource [PDOC] (off)
[    0.145693] acpi PNP0A05:00: ACPI dock station (docks/bays count: 1)
[    0.149744] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.149749] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.149753] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.150213] PCI host bridge to bus 0000:00
[    0.150215] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.150217] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.150219] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.150220] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.150222] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.150223] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.150225] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.150226] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.150228] pci_bus 0000:00: root bus resource [mem 0xafa00000-0xfeafffff]
[    0.150235] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    0.150316] pci 0000:00:02.0: [8086:0116] type 00 class 0x030000
[    0.150327] pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc03fffff 64bit]
[    0.150332] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff
64bit pref]
[    0.150336] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.150431] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.150455] pci 0000:00:16.0: reg 0x10: [mem 0xc0724000-0xc072400f 64bit]
[    0.150530] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.150608] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
[    0.150627] pci 0000:00:19.0: reg 0x10: [mem 0xc0700000-0xc071ffff]
[    0.150636] pci 0000:00:19.0: reg 0x14: [mem 0xc072b000-0xc072bfff]
[    0.150645] pci 0000:00:19.0: reg 0x18: [io  0x2080-0x209f]
[    0.150709] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.150756] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.150799] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.150821] pci 0000:00:1a.0: reg 0x10: [mem 0xc072a000-0xc072a3ff]
[    0.150912] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.150950] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.150992] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.151009] pci 0000:00:1b.0: reg 0x10: [mem 0xc0720000-0xc0723fff 64bit]
[    0.151084] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.151119] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.151161] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.151299] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.151387] pci 0000:00:1c.2: [8086:1c14] type 01 class 0x060400
[    0.151526] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.151610] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.151692] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.151771] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.151793] pci 0000:00:1d.0: reg 0x10: [mem 0xc0729000-0xc07293ff]
[    0.151885] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.151921] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.151962] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
[    0.152136] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
[    0.152154] pci 0000:00:1f.2: reg 0x10: [io  0x20a8-0x20af]
[    0.152163] pci 0000:00:1f.2: reg 0x14: [io  0x20bc-0x20bf]
[    0.152171] pci 0000:00:1f.2: reg 0x18: [io  0x20a0-0x20a7]
[    0.152179] pci 0000:00:1f.2: reg 0x1c: [io  0x20b8-0x20bb]
[    0.152187] pci 0000:00:1f.2: reg 0x20: [io  0x2060-0x207f]
[    0.152195] pci 0000:00:1f.2: reg 0x24: [mem 0xc0728000-0xc07287ff]
[    0.152241] pci 0000:00:1f.2: PME# supported from D3hot
[    0.152503] pci 0000:01:00.0: [1180:e823] type 00 class 0x088001
[    0.152525] pci 0000:01:00.0: MMC controller base frequency changed to 50Mhz.
[    0.152552] pci 0000:01:00.0: reg 0x10: [mem 0xc0600000-0xc06000ff]
[    0.152766] pci 0000:01:00.0: supports D1 D2
[    0.152767] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.160272] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.160279] pci 0000:00:1c.0:   bridge window [mem 0xc0600000-0xc06fffff]
[    0.160544] pci 0000:02:00.0: [8086:0091] type 00 class 0x028000
[    0.160720] pci 0000:02:00.0: reg 0x10: [mem 0xc0500000-0xc0501fff 64bit]
[    0.161445] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.168184] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.168193] pci 0000:00:1c.2:   bridge window [mem 0xc0500000-0xc05fffff]
[    0.168297] pci 0000:03:00.0: [1033:0194] type 00 class 0x0c0330
[    0.168327] pci 0000:03:00.0: reg 0x10: [mem 0xc0400000-0xc0401fff 64bit]
[    0.168476] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.176083] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.176099] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc04fffff]
[    0.176395] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12
14 15) *11
[    0.176440] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    0.176482] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    0.176525] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 *3 4 5 6 7 11 12 14 15)
[    0.176565] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.176606] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    0.176646] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 *6 7 10 12 14 15)
[    0.176687] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.177076] ACPI: Enabled 5 GPEs in block 00 to 3F
[    0.177178] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.177181] vgaarb: loaded
[    0.177182] vgaarb: bridge control possible 0000:00:02.0
[    0.177376] SCSI subsystem initialized
[    0.177421] libata version 3.00 loaded.
[    0.177446] ACPI: bus type USB registered
[    0.177462] usbcore: registered new interface driver usbfs
[    0.177471] usbcore: registered new interface driver hub
[    0.177492] usbcore: registered new device driver usb
[    0.177620] PCI: Using ACPI for IRQ routing
[    0.179167] PCI: pci_cache_line_size set to 64 bytes
[    0.179539] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.179540] e820: reserve RAM buffer [mem 0xaa2ef000-0xabffffff]
[    0.179542] e820: reserve RAM buffer [mem 0x1cfe00000-0x1cfffffff]
[    0.179645] NetLabel: Initializing
[    0.179646] NetLabel:  domain hash size = 128
[    0.179647] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.179659] NetLabel:  unlabeled traffic allowed by default
[    0.179727] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.179733] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.181774] Switched to clocksource hpet
[    0.186618] AppArmor: AppArmor Filesystem Enabled
[    0.186652] pnp: PnP ACPI init
[    0.186667] ACPI: bus type PNP registered
[    0.186830] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.186833] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.186834] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.186836] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.186838] system 00:00: [mem 0xafa00000-0xafa00fff] has been reserved
[    0.186839] system 00:00: [mem 0xfeb00000-0xfeb03fff] has been reserved
[    0.186841] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.186843] system 00:00: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.186845] system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
[    0.186847] system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.186850] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.187071] pnp 00:01: Plug and Play ACPI device, IDs IFX0102
PNP0c31 (active)
[    0.187154] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.187157] system 00:02: Plug and Play ACPI device, IDs PNP0103
PNP0c01 (active)
[    0.187198] system 00:03: [io  0x1000-0x100f] has been reserved
[    0.187200] system 00:03: [io  0xffff] has been reserved
[    0.187202] system 00:03: [io  0xffff] has been reserved
[    0.187204] system 00:03: [io  0x0400-0x047f] could not be reserved
[    0.187206] system 00:03: [io  0x0500-0x053f] has been reserved
[    0.187208] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.187244] system 00:04: [io  0x0680-0x06ff] has been reserved
[    0.187245] system 00:04: [io  0x01e0-0x01e7] has been reserved
[    0.187248] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.187282] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.187312] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.187340] pnp 00:07: Plug and Play ACPI device, IDs TOS0220
PNP0f13 (active)
[    0.187395] system 00:08: [mem 0x20000000-0x201fffff] has been reserved
[    0.187397] system 00:08: [mem 0x40000000-0x401fffff] has been reserved
[    0.187400] system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.187479] pnp: PnP ACPI: found 9 devices
[    0.187481] ACPI: bus type PNP unregistered
[    0.193936] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.193944] pci 0000:00:1c.0:   bridge window [mem 0xc0600000-0xc06fffff]
[    0.193956] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.193962] pci 0000:00:1c.2:   bridge window [mem 0xc0500000-0xc05fffff]
[    0.193974] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.193979] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc04fffff]
[    0.193988] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.193990] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.193991] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.193993] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.193994] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.193996] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.193998] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff]
[    0.193999] pci_bus 0000:00: resource 11 [mem 0xafa00000-0xfeafffff]
[    0.194001] pci_bus 0000:01: resource 1 [mem 0xc0600000-0xc06fffff]
[    0.194003] pci_bus 0000:02: resource 1 [mem 0xc0500000-0xc05fffff]
[    0.194004] pci_bus 0000:03: resource 1 [mem 0xc0400000-0xc04fffff]
[    0.194031] NET: Registered protocol family 2
[    0.194192] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    0.194342] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.194462] TCP: Hash tables configured (established 65536 bind 65536)
[    0.194484] TCP: reno registered
[    0.194494] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.194523] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.194585] NET: Registered protocol family 1
[    0.194599] pci 0000:00:02.0: Boot video device
[    0.195270] PCI: CLS 64 bytes, default 64
[    0.195322] Trying to unpack rootfs image as initramfs...
[    0.473760] Freeing initrd memory: 18304K (ffff880035c30000 -
ffff880036e10000)
[    0.474867] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.474870] software IO TLB [mem 0xa62ef000-0xaa2ef000] (64MB)
mapped at [ffff8800a62ef000-ffff8800aa2eefff]
[    0.474922] Simple Boot Flag at 0x7c set to 0x1
[    0.475078] RAPL PMU detected, hw unit 2^-16 Joules, API unit is
2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
[    0.475122] Scanning for low memory corruption every 60 seconds
[    0.475467] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.475491] Initialise system trusted keyring
[    0.475513] audit: initializing netlink subsys (disabled)
[    0.475525] audit: type=2000 audit(1406223067.472:1): initialized
[    0.475824] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.477291] zbud: loaded
[    0.477434] VFS: Disk quotas dquot_6.5.2
[    0.477471] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.477930] fuse init (API version 7.23)
[    0.478015] msgmni has been set to 11733
[    0.478072] Key type big_key registered
[    0.478441] Key type asymmetric registered
[    0.478444] Asymmetric key parser 'x509' registered
[    0.478480] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    0.478522] io scheduler noop registered (default)
[    0.478525] io scheduler deadline registered
[    0.478571] io scheduler cfq registered
[    0.479072] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.479087] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.479134] vesafb: mode is 800x600x32, linelength=3200, pages=0
[    0.479135] vesafb: scrolling: redraw
[    0.479137] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.479148] vesafb: framebuffer at 0xb0000000, mapped to
0xffffc90004e80000, using 1920k, total 1920k
[    0.509433] Console: switching to colour frame buffer device 100x37
[    0.539390] fb0: VESA VGA frame buffer device
[    0.539430] intel_idle: MWAIT substates: 0x21120
[    0.539432] intel_idle: v0.4 model 0x2A
[    0.539433] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.539667] ACPI: AC Adapter [ADP1] (on-line)
[    0.539762] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.539766] ACPI: Power Button [PWRB]
[    0.539801] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.539814] ACPI: Lid Switch [LID]
[    0.539849] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.539851] ACPI: Power Button [PWRF]
[    0.540234] thermal LNXTHERM:00: registered as thermal_zone0
[    0.540236] ACPI: Thermal Zone [TZ01] (16 C)
[    0.540271] GHES: HEST is not enabled!
[    0.540378] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.540528] ACPI: Battery Slot [BAT1] (battery present)
[    0.542018] hpet: probe of PNP0103:00 failed with error -22
[    0.542028] Linux agpgart interface v0.103
[    0.542266] tpm_tis 00:01: 1.2 TPM (device-id 0xB, rev-id 16)
[    0.781730] tpm_tis 00:01: TPM is disabled/deactivated (0x7)

------------->8 dmesg output CUT for Brevity 8<-------------

[    0.817802] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    0.819971] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.819975] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.820099] mousedev: PS/2 mouse device common for all mice
[    0.820270] rtc_cmos 00:05: RTC can wake from S4
[    0.820396] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    0.820424] rtc_cmos 00:05: alarms up to one year, 242 bytes nvram, hpet irqs
[    0.820490] device-mapper: uevent: version 1.0.3
[    0.820573] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30)
initialised: dm-devel@redhat.com
[    0.820589] Intel P-state driver initializing.
[    0.820631] Intel pstate controlling: cpu 0
[    0.820667] Intel pstate controlling: cpu 1
[    0.820686] Intel pstate controlling: cpu 2
[    0.820708] Intel pstate controlling: cpu 3
[    0.820732] ledtrig-cpu: registered to indicate activity on CPUs
[    0.820819] TCP: cubic registered
[    0.820918] NET: Registered protocol family 10
[    0.821129] NET: Registered protocol family 17
[    0.821140] Key type dns_resolver registered
[    0.821449] Loading compiled-in X.509 certificates
[    0.822273] Loaded X.509 cert 'Magrathea: Glacier signing key:
698c53558e81e5c9a6d351066707080070217971'
[    0.822297] registered taskstats version 1
[    0.824297] Key type trusted registered
[    0.826065] Key type encrypted registered
[    0.827705] AppArmor: AppArmor sha1 policy hashing enabled
[    0.831245] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    0.873703] tpm_tis 00:01: A TPM error (7) occurred attempting to
read a pcr value
[    0.874354] ima: No TPM chip found, activating TPM-bypass!
[    0.874387] evm: HMAC attrs: 0x1
[    0.874877]   Magic number: 6:92:543
[    0.874989] rtc_cmos 00:05: setting system clock to 2014-07-24
17:31:08 UTC (1406223068)
[    0.875075] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.875077] EDD information not available.
[    0.875155] PM: Hibernation image not present or could not be loaded.

------------->8 dmesg output CUT for Brevity 8<-------------

[    1.237568] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.237841] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[    1.237847] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8801cb437cf8), AE_NOT_FOUND
(20140424/psparse-536)
[    1.237861] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[    1.237864] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8801cb437d20), AE_NOT_FOUND
(20140424/psparse-536)
[    1.237936] ata1.00: ATA-8: TOSHIBA THNSNB128GMCJ, AJTA0202, max UDMA/100
[    1.237944] ata1.00: 250069680 sectors, multi 16: LBA48
[    1.238189] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[    1.238192] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8801cb437cf8), AE_NOT_FOUND
(20140424/psparse-536)
[    1.238202] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[    1.238205] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8801cb437d20), AE_NOT_FOUND
(20140424/psparse-536)
[    1.238236] ata1.00: configured for UDMA/100

------------->8 dmesg output CUT for Brevity 8<-------------

[    2.279139] ACPI Warning: SystemIO range
0x0000000000000428-0x000000000000042f conflicts with OpRegion
0x0000000000000400-0x000000000000047f (\PMIO) (20140424/utaddress-258)
[    2.279147] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    2.279152] ACPI Warning: SystemIO range
0x0000000000000540-0x000000000000054f conflicts with OpRegion
0x0000000000000500-0x000000000000057b (\GPIO) (20140424/utaddress-258)
[    2.279157] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    2.279158] ACPI Warning: SystemIO range
0x0000000000000530-0x000000000000053f conflicts with OpRegion
0x0000000000000500-0x000000000000057b (\GPIO) (20140424/utaddress-258)
[    2.279162] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    2.279164] ACPI Warning: SystemIO range
0x0000000000000500-0x000000000000052f conflicts with OpRegion
0x0000000000000500-0x000000000000057b (\GPIO) (20140424/utaddress-258)
[    2.279168] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    2.279170] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    2.279717] lp: driver loaded but no devices found
[    2.304763] wmi: Mapper loaded
[    2.307466] mei_me 0000:00:16.0: irq 47 for MSI/MSI-X
[    2.308720] ppdev: user-space parallel port driver
[    2.326920] toshiba_acpi: Toshiba Laptop ACPI Extras version 0.20
[    2.327001] input: Toshiba input device as /devices/virtual/input/input7
[    2.333019] toshiba_acpi: Illumination device not available
[    2.339057] cfg80211: Calling CRDA to update world regulatory domain

------------->8 dmesg output CUT for Brevity 8<-------------

[    3.804878] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[    3.852684] [drm:intel_enable_lvds] *ERROR* timed out waiting for
panel to power on
[    3.853255] Console: switching to colour frame buffer device 170x48
[    3.855124] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.855125] i915 0000:00:02.0: registered panic notifier
[    3.874012] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[    3.876074] acpi device:04: registered as cooling_device5
[    3.876191] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input8
[    3.877149] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0

------------->8 dmesg output CUT for Brevity 8<-------------

[   56.676675] PM: Enabling pm_trace changes system date and time during resume.
[   56.676675] PM: Correct system time has to be restored manually after resume.
[   56.883989] PM: Syncing filesystems ... done.
[   56.895207] PM: Preparing system for mem sleep
[   56.895518] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   56.897203] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   56.898297] PM: Entering mem sleep
[   56.898353] Suspending console(s) (use no_console_suspend to debug)
[   56.898527] wlan0: deauthenticating from 00:14:7f:bf:8e:bc by local
choice (Reason: 3=DEAUTH_LEAVING)
[   56.914035] cfg80211: Calling CRDA to update world regulatory domain
[   56.914617] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   56.914707] sd 0:0:0:0: [sda] Stopping disk
[   57.301654] PM: suspend of devices complete after 403.512 msecs
[   57.315766] PM: late suspend of devices complete after 14.120 msecs
[   57.316997] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
[   57.317135] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
[   57.331782] PM: noirq suspend of devices complete after 16.025 msecs
[   57.332054] ACPI: Preparing to enter system sleep state S3
[   57.332331] PM: Saving platform NVS memory
[   57.333030] Disabling non-boot CPUs ...
[   57.333063] intel_pstate CPU 1 exiting
[   57.334517] kvm: disabling virtualization on CPU1
[   57.435543] smpboot: CPU 1 is now offline
[   57.435810] intel_pstate CPU 2 exiting
[   57.437132] kvm: disabling virtualization on CPU2
[   57.539463] smpboot: CPU 2 is now offline
[   57.539719] intel_pstate CPU 3 exiting
[   57.539884] Broke affinity for irq 23
[   57.540001] Broke affinity for irq 45
[   57.541004] kvm: disabling virtualization on CPU3
[   57.643367] smpboot: CPU 3 is now offline
[   57.645287] ACPI: Low-level resume complete
[   57.645332] PM: Restoring platform NVS memory
[   57.645878] Enabling non-boot CPUs ...
[   57.645925] x86: Booting SMP configuration:
[   57.645926] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   57.668506] kvm: enabling virtualization on CPU1
[   57.671138] Intel pstate controlling: cpu 1
[   57.671294] CPU1 is up
[   57.671343] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   57.692504] kvm: enabling virtualization on CPU2
[   57.694734] Intel pstate controlling: cpu 2
[   57.694926] CPU2 is up
[   57.694952] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   57.918359] kvm: enabling virtualization on CPU3
[   57.920614] Intel pstate controlling: cpu 3
[   57.920686] CPU3 is up
[   57.925839] ACPI: Waking up from system sleep state S3
[   58.001307] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
[   58.033276] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI
[   58.065366] sdhci-pci 0000:01:00.0: MMC controller base frequency
changed to 50Mhz.
[   58.126019] PM: noirq resume of devices complete after 199.228 msecs
[   58.167420] PM: early resume of devices complete after 41.396 msecs
[   58.217214] [drm] Wrong MCH_SSKPD value: 0x16040307
[   58.217214] [drm] This can cause pipe underruns and display issues.
[   58.217215] [drm] Please upgrade your BIOS to fix this.
[   58.242784] mei_me 0000:00:16.0: irq 46 for MSI/MSI-X
[   58.405393] e1000e 0000:00:19.0: irq 47 for MSI/MSI-X
[   58.430951] snd_hda_intel 0000:00:1b.0: irq 50 for MSI/MSI-X
[   58.941445] iwlwifi 0000:02:00.0: RF_KILL bit toggled to enable radio.
[   59.048467] tpm_tis 00:01: TPM is disabled/deactivated (0x7)
[   59.133930] sd 0:0:0:0: [sda] Starting disk
[   59.416351] usb 1-1.1: reset full-speed USB device number 3 using ehci-pci
[   59.448111] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   59.448388] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[   59.448392] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8801cb437cf8), AE_NOT_FOUND
(20140424/psparse-536)
[   59.448403] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[   59.448406] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8801cb437d20), AE_NOT_FOUND
(20140424/psparse-536)
[   59.448788] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[   59.448792] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8801cb437cf8), AE_NOT_FOUND
(20140424/psparse-536)
[   59.448802] ACPI Error: [GTF0] Namespace lookup failure,
AE_NOT_FOUND (20140424/psargs-359)
[   59.448805] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8801cb437d20), AE_NOT_FOUND
(20140424/psparse-536)
[   59.448874] ata1.00: configured for UDMA/100
[   59.580049] usb 2-1.2: reset high-speed USB device number 3 using ehci-pci
[   59.767990] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[   60.277555] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   60.284147] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[   60.377835] PM: resume of devices complete after 2212.220 msecs
[   60.378014] PM: Finishing wakeup.
[   60.378015] Restarting tasks ... done.
[   60.379755] video LNXVIDEO:01: Restoring backlight state
[   60.392036] cfg80211: World regulatory domain updated:
[   60.392041] cfg80211:  DFS Master region: unset
[   60.392042] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   60.392046] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   60.392049] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   60.392051] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   60.392054] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   60.392057] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   63.691160] wlan0: authenticate with 00:14:7f:bf:8e:bc
[   63.693787] wlan0: send auth to 00:14:7f:bf:8e:bc (try 1/3)
[   63.696510] wlan0: authenticated
[   63.696645] iwlwifi 0000:02:00.0 wlan0: disabling HT/VHT due to WEP/TKIP use
[   63.700628] wlan0: associate with 00:14:7f:bf:8e:bc (try 1/3)
[   63.703386] wlan0: RX AssocResp from 00:14:7f:bf:8e:bc (capab=0x411
status=0 aid=1)
[   63.706661] wlan0: associated


[X.] Other notes, patches, fixes, workarounds:
Link to Ubuntu Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1338063


Thank you for your help. John Marsden
