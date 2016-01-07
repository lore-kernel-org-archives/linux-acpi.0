From: Toivo Pedaste <toivo.pedaste@uwa.edu.au>
Subject: [iMac17,1] Not booting with ACPI enabled
Date: Thu, 7 Jan 2016 11:24:21 +0800
Message-ID: <568DDA65.4030603@uwa.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ext-sout1.uwa.edu.au ([130.95.128.72]:6645 "EHLO
	mail-ext-sout1.uwa.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcAGDGb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2016 22:06:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Toivo Pedaste <toivo@ucs.uwa.edu.au>

[iMac17,1] Not booting with ACPI enabled



When booting with kernel 4.4rc8 (and anything previous I've tried) the=20
boot stops are the message:

loading initial ramdisk...

To get the kernel to boot I need acpi=3Doff, acpi=3Dht doesn't help.

This is with a 5k imac delivered last month, a non-5k imac delivered a=20
couple of weeks previous worked fine.



cat /proc/version
Linux version 4.4.0-040400rc8-generic (kernel@gloin) (gcc version 5.2.1=
=20
20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201601051225 SMP Tue Jan 5 17:27:3=
9=20
UTC 2016

sb_release -rd
Description:    Ubuntu 15.10
Release:        15.10


sh ver_linux

Linux toivo-iMac 4.4.0-040400rc8-generic #201601051225 SMP Tue Jan 5=20
17:27:39 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  5.2.1
Gnu make               4.0
binutils               2.25.1
util-linux             2.26.2
mount                  debug
module-init-tools      21
e2fsprogs              1.42.12
pcmciautils            018
PPP                    2.4.6
Linux C Library        2.21
Dynamic linker (ldd)   2.21
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.23
wireless-tools         30
Modules Loaded         rfcomm pci_stub vboxpci vboxnetadp vboxnetflt=20
vboxdrv bnep snd_hda_codec_cirrus snd_hda_codec_generic i915 intel_rapl=
=20
snd_hda_codec_hdmi video applesmc input_polldev x86_pkg_temp_thermal=20
uvcvideo intel_powerclamp coretemp btusb btrtl btbcm btintel=20
videobuf2_vmalloc kvm_intel videobuf2_memops snd_hda_intel input_leds=20
mac_hid snd_hda_codec snd_hda_core snd_hwdep videobuf2_v4l2=20
videobuf2_core bluetooth snd_pcm v4l2_common videodev media kvm=20
irqbypass crct10dif_pclmul nls_iso8859_1 crc32_pclmul snd_seq_midi=20
snd_seq_midi_event snd_rawmidi aesni_intel snd_seq aes_x86_64 lrw=20
gf128mul glue_helper ablk_helper snd_seq_device cryptd snd_timer=20
brcmfmac snd brcmutil cfg80211 thunderbolt mei_me mei soundcore shpchp=20
parport_pc ppdev lp parport autofs4 hid_generic usbhid hid i2c_algo_bit=
=20
ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops tg3 pt=
p=20
sdhci_pci sdhci pps_core drm ahci libahci



vendor_id       : GenuineIntel
cpu family      : 6
model           : 94
model name      : Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
stepping        : 3
microcode       : 0x39
cpu MHz         : 1376.000
cache size      : 6144 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe=20
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_goo=
d=20
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64=20
monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_=
1=20
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand=
=20
lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify=20
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid=20
fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed=
=20
adx smap clflushopt xsaveopt xsavec xgetbv1
bugs            :
bogomips        : 6382.32
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:


cat /proc/modules

rfcomm 69632 14 - Live 0x0000000000000000
pci_stub 16384 1 - Live 0x0000000000000000
vboxpci 24576 0 - Live 0x0000000000000000 (OE)
vboxnetadp 28672 0 - Live 0x0000000000000000 (OE)
vboxnetflt 28672 0 - Live 0x0000000000000000 (OE)
vboxdrv 454656 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000=
 (OE)
bnep 20480 2 - Live 0x0000000000000000
snd_hda_codec_cirrus 20480 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_cirrus, Live 0x000000000000=
0000
i915 1204224 0 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
video 40960 1 i915, Live 0x0000000000000000
applesmc 20480 0 - Live 0x0000000000000000
input_polldev 16384 1 applesmc, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
kvm_intel 167936 0 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
snd_hda_codec 135168 4=20
snd_hda_codec_cirrus,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_i=
ntel,=20
Live 0x0000000000000000
snd_hda_core 65536 5=20
snd_hda_codec_cirrus,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_i=
ntel,snd_hda_codec,=20
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
videobuf2_v4l2 28672 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
bluetooth 520192 39 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live=20
0x0000000000000000
snd_pcm 102400 4=20
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live=20
0x0000000000000000
v4l2_common 16384 1 videobuf2_v4l2, Live 0x0000000000000000
videodev 176128 4 uvcvideo,videobuf2_v4l2,videobuf2_core,v4l2_common,=20
Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
kvm 532480 1 kvm_intel, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live=20
0x0000000000000000
cryptd 20480 2 aesni_intel,ablk_helper, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
brcmfmac 290816 0 - Live 0x0000000000000000
snd 81920 21=20
snd_hda_codec_cirrus,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_i=
ntel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device=
,snd_timer,=20
Live 0x0000000000000000
brcmutil 16384 1 brcmfmac, Live 0x0000000000000000
cfg80211 557056 1 brcmfmac, Live 0x0000000000000000
thunderbolt 53248 0 - Live 0x0000000000000000
mei_me 32768 0 - Live 0x0000000000000000
mei 98304 1 mei_me, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 2 hid_generic,usbhid, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
ttm 94208 0 - Live 0x0000000000000000
drm_kms_helper 135168 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
tg3 163840 0 - Live 0x0000000000000000
ptp 20480 1 tg3, Live 0x0000000000000000
sdhci_pci 28672 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
drm 360448 3 i915,ttm,drm_kms_helper, Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc_cmos
   0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0300-031f : applesmc
0cf8-0cff : PCI conf1
3000-3fff : PCI Bus 0000:01
   3000-30ff : 0000:01:00.0
4040-405f : 0000:00:1f.4
4060-407f : 0000:00:17.0
   4060-407f : ahci
4080-4087 : 0000:00:17.0
   4080-4087 : ahci
4088-408b : 0000:00:17.0
   4088-408b : ahci
5000-7fff : PCI Bus 0000:05
   5000-6fff : PCI Bus 0000:06
     5000-5fff : PCI Bus 0000:0a
     6000-6fff : PCI Bus 0000:3b

cat /proc/iomem
00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009dfff : System RAM
0009e000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-820cefff : System RAM
   02000000-0280273f : Kernel code
   02802740-02f3bd3f : Kernel data
   030b2000-031f4fff : Kernel bss
820cf000-820cffff : ACPI Non-volatile Storage
820d0000-820f9fff : reserved
820fa000-8507dfff : System RAM
8507e000-8507efff : reserved
8507f000-8ac7efff : System RAM
8ac7f000-8aceefff : reserved
8acef000-8af4efff : reserved
8af4f000-8af9efff : ACPI Non-volatile Storage
8af9f000-8affefff : ACPI Tables
8afff000-8affffff : System RAM
8b000000-8fffffff : reserved
a0000000-b07fffff : PCI Bus 0000:01
   a0000000-afffffff : 0000:01:00.0
     a0010000-a1fbffff : efifb
   b0000000-b07fffff : 0000:01:00.0
d1000000-d14fffff : PCI Bus 0000:03
   d1000000-d13fffff : 0000:03:00.0
   d1400000-d1407fff : 0000:03:00.0
d1500000-d15fffff : PCI Bus 0000:04
   d1500000-d150ffff : 0000:04:00.1
   d1510000-d151ffff : 0000:04:00.0
     d1510000-d151ffff : tg3
   d1520000-d152ffff : 0000:04:00.0
     d1520000-d152ffff : tg3
d1600000-d16fffff : PCI Bus 0000:02
   d1600000-d1601fff : 0000:02:00.0
     d1600000-d1601fff : ahci
d1700000-d17fffff : PCI Bus 0000:01
   d1700000-d173ffff : 0000:01:00.0
   d1740000-d175ffff : 0000:01:00.0
   d1760000-d1763fff : 0000:01:00.1
     d1760000-d1763fff : ICH HD audio
d1800000-d180ffff : 0000:00:14.0
   d1800000-d180ffff : xhci-hcd
d1820000-d1823fff : 0000:00:1f.3
   d1820000-d1823fff : ICH HD audio
d1824000-d1827fff : 0000:00:1f.2
d1828000-d1829fff : 0000:00:17.0
   d1828000-d1829fff : ahci
d182a000-d182afff : 0000:00:16.0
   d182a000-d182afff : mei_me
d182b000-d182b0ff : 0000:00:1f.4
d182b800-d182bfff : 0000:00:17.0
   d182b800-d182bfff : ahci
d182c000-d182c0ff : 0000:00:17.0
   d182c000-d182c0ff : ahci
d1900000-dd9fffff : PCI Bus 0000:05
   d1900000-d99fffff : PCI Bus 0000:06
     d1900000-d19fffff : PCI Bus 0000:07
       d1900000-d193ffff : 0000:07:00.0
         d1900000-d193ffff : thunderbolt
       d1940000-d1940fff : 0000:07:00.0
     d1a00000-d59fffff : PCI Bus 0000:0a
     d5a00000-d99fffff : PCI Bus 0000:3b
dda00000-e99fffff : PCI Bus 0000:05
   dda00000-e59fffff : PCI Bus 0000:06
     dda00000-e19fffff : PCI Bus 0000:0a
       e00fa000-e00fafff : reserved
       e00fd000-e00fdfff : reserved
     e1a00000-e59fffff : PCI Bus 0000:3b
fe000000-fe010fff : reserved
fee00000-fee00fff : Local APIC
ff939000-ff968fff : reserved
100000000-26effffff : System RAM
26f000000-26fffffff : RAM buffer
270000000-27000ffff : 0000:00:1f.3
   270000000-27000ffff : ICH HD audio

sudo lspci -vvv

00:00.0 Host bridge: Intel Corporation Sky Lake Host Bridge/DRAM=20
Registers (rev 07)
         DeviceName: SATA
         Subsystem: Apple Inc. Device 0150
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ >SERR- <PERR- INTx-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information: Len=3D10 <?>

00:01.0 PCI bridge: Intel Corporation Sky Lake PCIe Controller (x16)=20
(rev 07) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 16
         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
         I/O behind bridge: 00003000-00003fff
         Memory behind bridge: d1700000-d17fffff
         Prefetchable memory behind bridge:=20
00000000a0000000-00000000b07fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [88] Subsystem: Apple Inc. Device 0150
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4141
         Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr- TransPend-
                 LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1,=20
Exit Latency L0s <256ns, L1 <8us
                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+=
=20
DLActive- BWMgmt+ ABWMgmt+
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
                         Slot #1, PowerLimit 75.000W; Interlock- NoComp=
l+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Via WAKE# ARIFwd-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete+, EqualizationPhase1+
                          EqualizationPhase2+, EqualizationPhase3+,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI=20
Controller (rev 31) (prog-if 30 [XHCI])
         Subsystem: Intel Corporation Device 7270
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 26
         Region 0: Memory at d1800000 (64-bit, non-prefetchable) [size=3D=
64K]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41e1
         Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Sunrise Point-H CSM=
E=20
HECI #1 (rev 31)
         Subsystem: Intel Corporation Device 7270
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 29
         Region 0: Memory at d182a000 (64-bit, non-prefetchable) [size=3D=
4K]
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4152
         Kernel driver in use: mei_me

00:17.0 SATA controller: Intel Corporation Device a102 (rev 31) (prog-i=
f=20
01 [AHCI 1.0])
         Subsystem: Intel Corporation Device 7270
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 27
         Region 0: Memory at d1828000 (32-bit, non-prefetchable) [size=3D=
8K]
         Region 1: Memory at d182c000 (32-bit, non-prefetchable) [size=3D=
256]
         Region 2: I/O ports at 4080 [size=3D8]
         Region 3: I/O ports at 4088 [size=3D4]
         Region 4: I/O ports at 4060 [size=3D32]
         Region 5: Memory at d182b800 (32-bit, non-prefetchable) [size=3D=
2K]
         Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4122
         Capabilities: [70] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
         Kernel driver in use: ahci

00:1b.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Root Port #17=
=20
(rev f1) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 17
         Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d1600000-d16fffff
         Prefetchable memory behind bridge:=20
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #17, Speed 8GT/s, Width x4, ASPM L1, Exit=
=20
Latency L0s <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+=20
DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
                         Slot #16, PowerLimit 25.000W; Interlock- NoCom=
pl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,=20
LTR+, OBFF Not Supported ARIFwd+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete+, EqualizationPhase1+
                          EqualizationPhase2+, EqualizationPhase3+,=20
LinkEqualizationRequest-
         Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4151
         Capabilities: [90] Subsystem: Intel Corporation Device 7270
         Capabilities: [a0] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Kernel driver in use: pcieport

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root=20
Port #1 (rev f1) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 18
         Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d1000000-d14fffff
         Prefetchable memory behind bridge:=20
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
=20
Exit Latency L0s <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk=
+=20
DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
                         Slot #0, PowerLimit 10.000W; Interlock- NoComp=
l+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet+ LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,=20
LTR+, OBFF Not Supported ARIFwd+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4161
         Capabilities: [90] Subsystem: Intel Corporation Device 7270
         Capabilities: [a0] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root=20
Port #2 (rev f1) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin B routed to IRQ 19
         Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge:=20
00000000d1500000-00000000d15fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
=20
Exit Latency L0s <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk=
+=20
DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
                         Slot #1, PowerLimit 10.000W; Interlock- NoComp=
l+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet+ LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,=20
LTR+, OBFF Not Supported ARIFwd+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4171
         Capabilities: [90] Subsystem: Intel Corporation Device 7270
         Capabilities: [a0] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root=20
Port #5 (rev f1) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 20
         Bus: primary=3D00, secondary=3D05, subordinate=3D6b, sec-laten=
cy=3D0
         I/O behind bridge: 00005000-00007fff
         Memory behind bridge: d1900000-dd9fffff
         Prefetchable memory behind bridge:=20
00000000dda00000-00000000e99fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #5, Speed 5GT/s, Width x4, ASPM not=20
supported, Exit Latency L0s <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+=20
DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
                         Slot #4, PowerLimit 25.000W; Interlock- NoComp=
l+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,=20
LTR+, OBFF Not Supported ARIFwd+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4181
         Capabilities: [90] Subsystem: Intel Corporation Device 7270
         Capabilities: [a0] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller=20
(rev 31)
         Subsystem: Intel Corporation Device 7270
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 3=
1)
         Subsystem: Intel Corporation Device 7270
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Region 0: Memory at d1824000 (32-bit, non-prefetchable)=20
[disabled] [size=3D16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-H HD Audio (rev 3=
1)
         Subsystem: Intel Corporation Device 7270
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 32
         Region 0: Memory at d1820000 (64-bit, non-prefetchable) [size=3D=
16K]
         Region 4: Memory at 270000000 (64-bit, non-prefetchable) [size=
=3D64K]
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4182
         Kernel driver in use: snd_hda_intel

00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
         Subsystem: Intel Corporation Device 7270
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at d182b000 (64-bit, non-prefetchable) [size=3D=
256]
         Region 4: I/O ports at 4040 [size=3D32]

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.=20
[AMD/ATI] Saturn XT [FirePro M6100] (rev 80) (prog-if 00 [VGA controlle=
r])
         Subsystem: Apple Inc. Device 014b
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at a0000000 (64-bit, prefetchable) [size=3D25=
6M]
         Region 2: Memory at b0000000 (64-bit, prefetchable) [size=3D8M=
]
         Region 4: I/O ports at 3000 [size=3D256]
         Region 5: Memory at d1700000 (32-bit, non-prefetchable) [size=3D=
256K]
         Expansion ROM at d1740000 [disabled] [size=3D128K]
         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s=
=20
<4us, L1 unlimited
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,=20
Exit Latency L0s <64ns, L1 <1us
                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+=
=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR-, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete+, EqualizationPhase1+
                          EqualizationPhase2+, EqualizationPhase3+,=20
LinkEqualizationRequest-
         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device aac=
0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin B routed to IRQ 31
         Region 0: Memory at d1760000 (64-bit, non-prefetchable) [size=3D=
16K]
         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s=
=20
<4us, L1 unlimited
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,=20
Exit Latency L0s <64ns, L1 <1us
                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+=
=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR-, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled
                 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4172
         Kernel driver in use: snd_hda_intel

02:00.0 SATA controller: Samsung Electronics Co Ltd Device a801 (rev 01=
)=20
(prog-if 01 [AHCI 1.0])
         Subsystem: Samsung Electronics Co Ltd Device a801
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 28
         Region 5: Memory at d1600000 (32-bit, non-prefetchable) [size=3D=
8K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
         Capabilities: [50] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4142
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
=20
unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+=20
=46LReset-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit=20
Latency L0s <4us, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis+, LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete+, EqualizationPhase1+
                          EqualizationPhase2+, EqualizationPhase3+,=20
LinkEqualizationRequest-
         Kernel driver in use: ahci

03:00.0 Network controller: Broadcom Corporation BCM43602 802.11ac=20
Wireless LAN SoC (rev 01)
         Subsystem: Apple Inc. Device 014a
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 34
         Region 0: Memory at d1400000 (64-bit, non-prefetchable) [size=3D=
32K]
         Region 2: Memory at d1000000 (64-bit, non-prefetchable) [size=3D=
4M]
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 =
PME-
         Capabilities: [58] MSI: Enable+ Count=3D1/16 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41a2
         Capabilities: [68] Vendor Specific Information: Len=3D44 <?>
         Capabilities: [ac] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s=
=20
<4us, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 1024 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <32us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,=20
LTR+, OBFF Via WAKE#
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: brcmfmac

04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57766=20
Gigabit Ethernet PCIe (rev 01)
         Subsystem: Broadcom Corporation NetXtreme BCM57766 Gigabit=20
Ethernet PCIe
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at d1520000 (64-bit, prefetchable) [size=3D64=
K]
         Region 2: Memory at d1510000 (64-bit, prefetchable) [size=3D64=
K]
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [50] Vital Product Data
                 Product Name: Broadcom NetXtreme Gigabit Ethernet=20
Controller
                 Read-only fields:
                         [PN] Part number: BCM957766a
                         [EC] Engineering changes: 106679-15
                         [SN] Serial number: 0123456789
                         [MN] Manufacture ID: 31 34 65 34
                         [RV] Reserved: checksum good, 26 byte(s) reser=
ved
                 Read/write fields:
                         [YA] Asset tag: XYZ01234567
                         [RW] Read-write area: 107 byte(s) free
                 End
         Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [a0] MSI-X: Enable+ Count=3D6 Masked-
                 Vector table: BAR=3D2 offset=3D00000000
                 PBA: BAR=3D2 offset=3D00000120
         Capabilities: [ac] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
=20
<4us, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 4096 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,=20
LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: tg3

04:00.1 SD Host controller: Broadcom Corporation BCM57765/57785 SDXC/MM=
C=20
Card Reader (rev 01) (prog-if 01)
         Subsystem: Broadcom Corporation Device 0000
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin B routed to IRQ 0
         Region 0: Memory at d1500000 (64-bit, prefetchable) [size=3D64=
K]
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [ac] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
=20
<4us, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 4096 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommCl=
k+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,=20
LTR-, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-

05:00.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 0
         Bus: primary=3D05, secondary=3D06, subordinate=3D6b, sec-laten=
cy=3D0
         I/O behind bridge: 00005000-00006fff
         Memory behind bridge: d1900000-d99fffff
         Prefetchable memory behind bridge:=20
00000000dda00000-00000000e59fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Upstream Port, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+=20
SlotPowerLimit 25.000W
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1,=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

06:00.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 21
         Bus: primary=3D06, secondary=3D07, subordinate=3D07, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d1900000-d19fffff
         Prefetchable memory behind bridge:=20
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4191
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 0=
0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug+ Surprise+
                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl=
+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt=
-=20
HPIrq+ LinkChg+
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

06:03.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 22
         Bus: primary=3D06, secondary=3D0a, subordinate=3D3a, sec-laten=
cy=3D0
         I/O behind bridge: 00005000-00005fff
         Memory behind bridge: d1a00000-d59fffff
         Prefetchable memory behind bridge:=20
00000000dda00000-00000000e19fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41a1
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 0=
0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #3, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug+ Surprise+
                         Slot #3, PowerLimit 0.000W; Interlock- NoCompl=
+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt=
-=20
HPIrq+ LinkChg+
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

06:04.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 23
         Bus: primary=3D06, secondary=3D08, subordinate=3D08, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge:=20
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41b1
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 0=
0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #4, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug+ Surprise+
                         Slot #4, PowerLimit 0.000W; Interlock- NoCompl=
+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt=
-=20
HPIrq+ LinkChg+
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

06:05.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 24
         Bus: primary=3D06, secondary=3D3b, subordinate=3D6b, sec-laten=
cy=3D0
         I/O behind bridge: 00006000-00006fff
         Memory behind bridge: d5a00000-d99fffff
         Prefetchable memory behind bridge:=20
00000000e1a00000-00000000e59fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41c1
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 0=
0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #5, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug+ Surprise+
                         Slot #5, PowerLimit 0.000W; Interlock- NoCompl=
+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt=
-=20
HPIrq+ LinkChg+
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

06:06.0 PCI bridge: Intel Corporation Device 156d (prog-if 00 [Normal=20
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 25
         Bus: primary=3D06, secondary=3D09, subordinate=3D09, sec-laten=
cy=3D0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge:=20
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 41d1
         Capabilities: [ac] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 0=
0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr+ TransPend-
                 LnkCap: Port #6, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug+ Surprise+
                         Slot #6, PowerLimit 0.000W; Interlock- NoCompl=
+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt=
-=20
HPIrq+ LinkChg+
                         Control: AttnInd Unknown, PwrInd Unknown,=20
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported,=20
TimeoutDis-, LTR+, OBFF Not Supported ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR-, OBFF Disabled ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Kernel driver in use: pcieport

07:00.0 System peripheral: Intel Corporation Device 156c
         Physical Slot: 0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 30
         Region 0: Memory at d1900000 (32-bit, non-prefetchable) [size=3D=
256K]
         Region 1: Memory at d1940000 (32-bit, non-prefetchable) [size=3D=
4K]
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
         Capabilities: [88] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                 Address: 00000000fee0100c  Data: 4162
         Capabilities: [c0] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
=20
<2us, L1 <4us
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+=20
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1,=
=20
Exit Latency L0s <2us, L1 <4us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptCom=
p-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk=
+=20
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range B, TimeoutDis+,=20
LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,=20
LTR+, OBFF Disabled
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-
                          Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
         Capabilities: [a0] MSI-X: Enable- Count=3D16 Masked-
                 Vector table: BAR=3D1 offset=3D00000000
                 PBA: BAR=3D1 offset=3D00000fa0
         Kernel driver in use: thunderbolt

cat /proc/scsi/scsi

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: APPLE SSD SM0256 Rev: TA0Q
   Type:   Direct-Access                    ANSI  SCSI revision: 05

ls /proc
total 0
0 1/     0 1370/  0 1448/  0 1503/  0 1583/  0 18/    0 23/    0 3/    =
=20
0 51/  0 64/   0 69/   0 731/  0 90/        0 cmdline      0=20
ioports      0 misc          0 swaps
0 10/    0 139/   0 1453/  0 1514/  0 1584/  0 1800/  0 231/   0 30/   =
=20
0 52/  0 647/  0 690/  0 732/  0 905/       0 consoles     0=20
irq/         0 modules       0 sys/
0 11/    0 14/    0 1458/  0 1516/  0 1585/  0 1811/  0 233/   0 305/  =
=20
0 53/  0 65/   0 692/  0 748/  0 911/       0 cpuinfo      0=20
kallsyms     0 mounts@       0 sysrq-trigger
0 12/    0 140/   0 146/   0 1520/  0 1587/  0 1815/  0 234/   0 31/   =
=20
0 54/  0 653/  0 693/  0 76/   0 939/       0 crypto       0=20
kcore        0 mtrr          0 sysvipc/
0 13/    0 1411/  0 1466/  0 1534/  0 1588/  0 1820/  0 24/    0 314/  =
=20
0 55/  0 66/   0 7/    0 8/    0 941/       0 devices      0=20
keys         0 net@          0 thread-self@
0 1307/  0 1418/  0 1468/  0 1538/  0 1589/  0 1839/  0 2445/  0 359/  =
=20
0 56/  0 67/   0 70/   0 839/  0 953/       0 diskstats    0=20
key-users    0 pagetypeinfo  0 timer_list
0 1308/  0 1419/  0 1469/  0 1541/  0 1591/  0 1879/  0 2549/  0 368/  =
=20
0 57/  0 671/  0 701/  0 840/  0 954/       0 dma          0=20
kmsg         0 partitions    0 timer_stats
0 1309/  0 142/   0 1473/  0 1575/  0 16/    0 1892/  0 2551/  0 4203/ =
=20
0 58/  0 679/  0 705/  0 872/  0 955/       0 driver/      0=20
kpagecgroup  0 sched_debug   0 tty/
0 1318/  0 1420/  0 1474/  0 1577/  0 17/    0 19/    0 2553/  0 4204/ =
=20
0 59/  0 68/   0 71/   0 886/  0 962/       0 execdomains  0=20
kpagecount   0 schedstat     0 uptime
0 1319/  0 1422/  0 1487/  0 1578/  0 1718/  0 1988/  0 269/   0 46/   =
=20
0 6/   0 680/  0 710/  0 888/  0 991/       0 fb           0=20
kpageflags   0 scsi/         0 version
0 1321/  0 143/   0 1493/  0 1579/  0 1743/  0 2/     0 28/    0 48/   =
=20
0 60/  0 681/  0 72/   0 89/   0 asound/    0 filesystems  0=20
loadavg      0 self@         0 vmallocinfo
0 1365/  0 1444/  0 1496/  0 1580/  0 1788/  0 20/    0 286/   0 49/   =
=20
0 61/  0 682/  0 720/  0 890/  0 buddyinfo  0 fs/          0=20
locks        0 slabinfo      0 vmstat
0 1366/  0 1445/  0 15/    0 1581/  0 1797/  0 21/    0 29/    0 5/    =
=20
0 62/  0 684/  0 721/  0 891/  0 bus/       0 interrupts   0=20
mdstat       0 softirqs      0 zoneinfo
0 1369/  0 1446/  0 1500/  0 1582/  0 1799/  0 22/    0 2966/  0 50/   =
=20
0 63/  0 685/  0 730/  0 9/    0 cgroups    0 iomem        0=20
meminfo      0 stat

--=20
*Toivo Pedaste =E2=94=82 Network Team (Infrastructure & Applications)*
Business Information & Technology Services, M463
The University of Western Australia
35 Stirling Highway, CRAWLEY WA 6009
Tel +61 8 6488 2605 l e-mailtoivo.pedaste@uwa.edu.au=20
<mailto:goran.mitrovic@uwa.edu.au>
UWA CRICOS Provider No. 00126G
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
