From: Guillaume Millet <gmillet@crans.org>
Subject: 8086:2a42 [Asus UL80VT] Backlight control does not work with Intel
 integrated card, but there are entries in /sys/class/backlight
Date: Mon, 02 Dec 2013 17:53:41 +0100
Message-ID: <529CBB15.7000904@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from redisdead.crans.org ([138.231.136.39]:45272 "EHLO
	redisdead.crans.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3LBRAO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2013 12:00:14 -0500
Received: from [10.0.1.7] (unknown [134.157.18.24])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by redisdead.crans.org (Postfix) with ESMTPSA id 9B5FD213A
	for <linux-acpi@vger.kernel.org>; Mon,  2 Dec 2013 17:53:43 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello, I report an issue, in attempting to follow the instructions at
https://wiki.ubuntu.com/Bugs/Upstream/kernel#KernelTeam.2BAC8-KernelTeamBugPolicies.Overview_on_Reporting_Bugs_Upstream

[1.] 8086:2a42 [Asus UL80VT] Backlight control does not work with Intel 
integrated card, but there are entries in /sys/class/backlight

[2.] The screen brightness control has apparently never worked 
off-the-shelf on this laptop, Asus UL80VT-A1, which is an NVIDIA Optimus 
laptop (2 graphic cards). The use of the discrete Nvidia card is managed 
by Bumblebee (https://wiki.ubuntu.com/Bumblebee). It used to work with 
the workaround suggested at 
http://wiki.daviddarts.com/Ubuntu_Maverick_on_the_Asus_UL30VT#Screen_Brightness 
which modifies asus-brn-down.sh to use the "setpci" method.
Hotkeys are detected, showkey -s returns 0xe0 0x4c 0xe0 0xcc for Fn+F5 
and 0xe0 0x54 0xe0 0xd4 for Fn+F6.
When the hotkeys are triggered, there is no brightness change but the 
KDE notification pops up with 3 or 4 levels.

[4.] $ cat /proc/version
Linux version 3.13.0-031300rc2-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201311291635 SMP Fri Nov 29 21:36:49 
UTC 2013

[7.] $ lsb_release -rd
Description:    Ubuntu 13.10
Release:        13.10

$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux UL80VT-Guillaume 3.13.0-031300rc2-generic #201311291635 SMP Fri 
Nov 29 21:36:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         btrfs raid6_pq xor ufs qnx4 hfsplus hfs minix 
ntfs msdos jfs xfs libcrc32c reiserfs ext2 ctr ccm snd_hrtimer 
ip6table_filter ip6_tables iptable_filter ip_tables x_tables bnep 
parport_pc rfcomm ppdev bluetooth cuse binfmt_misc dm_crypt kvm_intel 
kvm mxm_wmi arc4 uvcvideo ath9k ath9k_common ath9k_hw videobuf2_vmalloc 
videobuf2_memops videobuf2_core videodev snd_hda_codec_hdmi joydev ath 
mac80211 cfg80211 snd_hda_codec_realtek snd_hda_intel snd_hda_codec 
snd_hwdep snd_pcm microcode snd_page_alloc snd_seq_midi 
snd_seq_midi_event psmouse snd_rawmidi serio_raw snd_seq snd_seq_device 
snd_timer snd soundcore lpc_ich asus_laptop wmi sparse_keymap 
input_polldev mac_hid coretemp lp parport hid_generic usbhid hid 
usb_storage i915 ahci libahci atl1c i2c_algo_bit drm_kms_helper video drm

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Genuine Intel(R) CPU           U7300  @ 1.30GHz
stepping        : 10
microcode       : 0xa07
cpu MHz         : 800.000
cache size      : 3072 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl 
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm 
sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips        : 3466.77
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Genuine Intel(R) CPU           U7300  @ 1.30GHz
stepping        : 10
microcode       : 0xa07
cpu MHz         : 800.000
cache size      : 3072 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl 
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm 
sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips        : 3466.77
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

$ cat /proc/modules
btrfs 867840 0 - Live 0x0000000000000000
raid6_pq 97812 1 btrfs, Live 0x0000000000000000
xor 21411 1 btrfs, Live 0x0000000000000000
ufs 75385 0 - Live 0x0000000000000000
qnx4 13396 0 - Live 0x0000000000000000
hfsplus 108445 0 - Live 0x0000000000000000
hfs 54819 0 - Live 0x0000000000000000
minix 36454 0 - Live 0x0000000000000000
ntfs 97805 0 - Live 0x0000000000000000
msdos 17332 0 - Live 0x0000000000000000
jfs 186939 0 - Live 0x0000000000000000
xfs 934063 0 - Live 0x0000000000000000
libcrc32c 12644 2 btrfs,xfs, Live 0x0000000000000000
reiserfs 248975 0 - Live 0x0000000000000000
ext2 73828 0 - Live 0x0000000000000000
ctr 13193 3 - Live 0x0000000000000000
ccm 17856 3 - Live 0x0000000000000000
snd_hrtimer 12744 1 - Live 0x0000000000000000
ip6table_filter 12815 0 - Live 0x0000000000000000
ip6_tables 27502 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 12810 0 - Live 0x0000000000000000
ip_tables 27716 1 iptable_filter, Live 0x0000000000000000
x_tables 34194 4 ip6table_filter,ip6_tables,iptable_filter,ip_tables, 
Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
parport_pc 36962 0 - Live 0x0000000000000000
rfcomm 74748 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
bluetooth 411140 10 bnep,rfcomm, Live 0x0000000000000000
cuse 13566 3 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
dm_crypt 23417 0 - Live 0x0000000000000000
kvm_intel 144426 0 - Live 0x0000000000000000
kvm 468147 1 kvm_intel, Live 0x0000000000000000
mxm_wmi 13021 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
ath9k 166504 0 - Live 0x0000000000000000
ath9k_common 13551 1 ath9k, Live 0x0000000000000000
ath9k_hw 462889 2 ath9k,ath9k_common, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 40972 1 uvcvideo, Live 0x0000000000000000
videodev 139761 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
snd_hda_codec_hdmi 46905 4 - Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
ath 29145 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
mac80211 654078 1 ath9k, Live 0x0000000000000000
cfg80211 509407 3 ath9k,ath,mac80211, Live 0x0000000000000000
snd_hda_codec_realtek 61701 1 - Live 0x0000000000000000
snd_hda_intel 57222 4 - Live 0x0000000000000000
snd_hda_codec 195017 3 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live 
0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
microcode 23788 0 - Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
psmouse 104142 0 - Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
snd_seq 66061 3 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
snd_timer 30038 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
snd 73850 21 
snd_hrtimer,snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
asus_laptop 28954 0 - Live 0x0000000000000000
wmi 19363 1 mxm_wmi, Live 0x0000000000000000
sparse_keymap 13890 1 asus_laptop, Live 0x0000000000000000
input_polldev 13896 1 asus_laptop, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
usb_storage 66714 0 - Live 0x0000000000000000
i915 816671 6 - Live 0x0000000000000000
ahci 30063 3 - Live 0x0000000000000000
libahci 32277 1 ahci, Live 0x0000000000000000
atl1c 47001 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 53224 1 i915, Live 0x0000000000000000
video 19859 1 i915, Live 0x0000000000000000
drm 308397 7 i915,drm_kms_helper, Live 0x0000000000000000

$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0062-0062 : EC data
   0064-0064 : keyboard
   0066-0066 : EC cmd
   0070-0071 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0250-0253 : pnp 00:0b
   0256-025f : pnp 00:0b
   0400-041f : pnp 00:07
   04c0-04cf : pnp 00:07
   04d0-04d1 : pnp 00:07
   04d2-04ff : pnp 00:07
   0500-057f : pnp 00:07
   0800-0803 : ACPI PM1a_EVT_BLK
   0804-0805 : ACPI PM1a_CNT_BLK
   0808-080b : ACPI PM_TMR
   0810-0815 : ACPI CPU throttle
   0820-082f : ACPI GPE0_BLK
   0830-0833 : iTCO_wdt
   0850-0850 : ACPI PM2_CNT_BLK
   0860-087f : iTCO_wdt
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   b400-b41f : 0000:00:1f.2
     b400-b41f : ahci
   b480-b483 : 0000:00:1f.2
     b480-b483 : ahci
   b800-b807 : 0000:00:1f.2
     b800-b807 : ahci
   b880-b883 : 0000:00:1f.2
     b880-b883 : ahci
   bc00-bc07 : 0000:00:1f.2
     bc00-bc07 : ahci
   c000-c01f : 0000:00:1d.2
     c000-c01f : uhci_hcd
   c080-c09f : 0000:00:1d.1
     c080-c09f : uhci_hcd
   c400-c41f : 0000:00:1d.0
     c400-c41f : uhci_hcd
   c480-c49f : 0000:00:1a.2
     c480-c49f : uhci_hcd
   c800-c81f : 0000:00:1a.1
     c800-c81f : uhci_hcd
   c880-c89f : 0000:00:1a.0
     c880-c89f : uhci_hcd
   cc00-cc07 : 0000:00:02.0
   d000-dfff : PCI Bus 0000:01
     dc00-dc7f : 0000:01:00.0
   e000-efff : PCI Bus 0000:04
     ec00-ec7f : 0000:04:00.0
       ec00-ec7f : atl1c

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-00097bff : System RAM
00097c00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
000e1000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-bdd6ffff : System RAM
   01000000-0177105d : Kernel code
   0177105e-01d1bc3f : Kernel data
   01e78000-01fdcfff : Kernel bss
bdd70000-bdd81fff : ACPI Tables
bdd82000-bdddffff : ACPI Non-volatile Storage
bdde0000-bddfffff : reserved
bde00000-ffffffff : PCI Bus 0000:00
   bde00000-bde00fff : Intel Flush Page
   be000000-bfffffff : reserved
     be000000-bfffffff : Graphics Stolen Memory
   c0000000-cfffffff : PCI MMCONFIG 0000 [bus 00-ff]
     c0000000-cfffffff : pnp 00:0c
   d0000000-dfffffff : 0000:00:02.0
     d0000000-d02fffff : BOOTFB
   e0000000-fbffffff : PCI Bus 0000:01
     e0000000-efffffff : 0000:01:00.0
     fa000000-fbffffff : 0000:01:00.0
   fcbf4000-fcbf7fff : 0000:00:1b.0
     fcbf4000-fcbf7fff : ICH HD audio
   fcbfac00-fcbfacff : pnp 00:07
   fcbfb000-fcbfb7ff : 0000:00:1f.2
     fcbfb000-fcbfb7ff : ahci
   fcbfb800-fcbfbbff : 0000:00:1d.7
     fcbfb800-fcbfbbff : ehci_hcd
   fcbfbc00-fcbfbfff : 0000:00:1a.7
     fcbfbc00-fcbfbfff : ehci_hcd
   fcc00000-fcffffff : 0000:00:02.0
   fd000000-fe9fffff : PCI Bus 0000:01
     fd000000-fdffffff : 0000:01:00.0
     fe97c000-fe97ffff : 0000:01:00.1
       fe97c000-fe97ffff : ICH HD audio
     fe980000-fe9fffff : 0000:01:00.0
   fea00000-feafffff : PCI Bus 0000:03
     feaf0000-feafffff : 0000:03:00.0
       feaf0000-feafffff : ath9k
   feb00000-febfffff : PCI Bus 0000:04
     febc0000-febfffff : 0000:04:00.0
       febc0000-febfffff : atl1c
   fec00000-fec003ff : IOAPIC 0
   fec18000-fec1ffff : pnp 00:0b
   fec38000-fec3ffff : pnp 00:0b
   fed00000-fed003ff : HPET 0
   fed10000-fed19fff : pnp 00:00
   fed1c000-fed1ffff : pnp 00:07
     fed1f410-fed1f414 : iTCO_wdt
   fed20000-fed3ffff : pnp 00:07
   fed45000-fed89fff : pnp 00:07
   fed90000-fed90fff : dmar0
   fed91000-fed91fff : dmar1
   fed92000-fed92fff : pnp 00:07
   fed93000-fed93fff : dmar2
   fee00000-fee00fff : Local APIC
     fee00000-fee00fff : reserved
       fee00000-fee00fff : pnp 00:0b
   ffb00000-ffffffff : reserved
     ffb00000-ffbfffff : pnp 00:07
     ffc00000-ffdfffff : pnp 00:0a
     fff00000-ffffffff : pnp 00:07
100000000-13fffffff : System RAM

$ sudo lspci -vvv
[sudo] password for guillaume:
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory 
Controller Hub (rev 07)
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information: Len=0a <?>
         Kernel driver in use: agpgart-intel

00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI 
Express Graphics Port (rev 07) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fd000000-fe9fffff
         Prefetchable memory behind bridge: 
00000000e0000000-00000000fbffffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 1e77
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4191
         Capabilities: [a0] Express (v1) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #2, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <256ns, L1 <4us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- 
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- 
HotPlug+ Surprise-
                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
                         Control: AttnInd Off, PwrInd On, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- 
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed+ WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
         Capabilities: [140 v1] Root Complex Link
                 Desc:   PortNumber=02 ComponentID=01 EltType=Config
                 Link0:  Desc:   TargetPort=00 TargetComponent=01 
AssocRCRB- LinkType=MemMapped LinkValid+
                         Addr:   00000000fed19000
         Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series 
Chipset Integrated Graphics Controller (rev 07) (prog-if 00 [VGA 
controller])
         Subsystem: ASUSTeK Computer Inc. Device 1bc2
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 45
         Region 0: Memory at fcc00000 (64-bit, non-prefetchable) [size=4M]
         Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
         Region 4: I/O ports at cc00 [size=8]
         Expansion ROM at <unassigned> [disabled]
         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0300c  Data: 4122
         Capabilities: [d0] Power Management version 3
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: i915

00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #4 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 4: I/O ports at c880 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #5 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at c800 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #6 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin D routed to IRQ 19
         Region 4: I/O ports at c480 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #2 (rev 03) (prog-if 20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin C routed to IRQ 18
         Region 0: Memory at fcbfbc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port: BAR=1 offset=00a0
         Capabilities: [98] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio 
Controller (rev 03)
         Subsystem: ASUSTeK Computer Inc. Device 1483
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 46
         Region 0: Memory at fcbf4000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee0300c  Data: 4153
         Capabilities: [70] Express (v1) Root Complex Integrated 
Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- RBE- FLReset+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, 
Latency L0 <64ns, L1 <1us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=80
                         Status: NegoPending- InProgress-
         Capabilities: [130 v1] Root Complex Link
                 Desc:   PortNumber=0f ComponentID=00 EltType=Config
                 Link0:  Desc:   TargetPort=00 TargetComponent=00 
AssocRCRB- LinkType=MemMapped LinkValid+
                         Addr:   00000000fed1c000
         Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 1 (rev 03) (prog-if 00 [Normal decode])
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <256ns, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled+ Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 41a1
         Capabilities: [90] Subsystem: Intel Corporation Optiplex 755
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed+ WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
         Capabilities: [180 v1] Root Complex Link
                 Desc:   PortNumber=01 ComponentID=00 EltType=Config
                 Link0:  Desc:   TargetPort=00 TargetComponent=00 
AssocRCRB- LinkType=MemMapped LinkValid+
                         Addr:   00000000fed1c000
         Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 2 (rev 03) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fea00000-feafffff
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <256ns, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 41c1
         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1e77
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed+ WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
         Capabilities: [180 v1] Root Complex Link
                 Desc:   PortNumber=02 ComponentID=00 EltType=Config
                 Link0:  Desc:   TargetPort=00 TargetComponent=00 
AssocRCRB- LinkType=MemMapped LinkValid+
                         Addr:   00000000fed1c000
         Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 6 (rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
         I/O behind bridge: 0000e000-0000efff
         Memory behind bridge: feb00000-febfffff
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <256ns, L1 <4us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 41d1
         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1e77
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed+ WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
         Capabilities: [180 v1] Root Complex Link
                 Desc:   PortNumber=06 ComponentID=00 EltType=Config
                 Link0:  Desc:   TargetPort=00 TargetComponent=00 
AssocRCRB- LinkType=MemMapped LinkValid+
                         Addr:   00000000fed1c000
         Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #1 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 23
         Region 4: I/O ports at c400 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #2 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin B routed to IRQ 19
         Region 4: I/O ports at c080 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #3 (rev 03) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin C routed to IRQ 18
         Region 4: I/O ports at c000 [size=32]
         Capabilities: [50] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #1 (rev 03) (prog-if 20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 23
         Region 0: Memory at fcbfb800 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port: BAR=1 offset=00a0
         Capabilities: [98] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93) 
(prog-if 01 [Subtractive decode])
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [50] Subsystem: ASUSTeK Computer Inc. Device 1e77

00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller 
(rev 03)
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
         Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM (ICH9M/ICH9M-E) 
4 port SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
         Subsystem: ASUSTeK Computer Inc. Device 1e77
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin B routed to IRQ 44
         Region 0: I/O ports at bc00 [size=8]
         Region 1: I/O ports at b880 [size=4]
         Region 2: I/O ports at b800 [size=8]
         Region 3: I/O ports at b480 [size=4]
         Region 4: I/O ports at b400 [size=32]
         Region 5: Memory at fcbfb000 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
                 Address: fee0100c  Data: 41e1
         Capabilities: [70] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
         Capabilities: [b0] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ahci

01:00.0 VGA compatible controller: NVIDIA Corporation GT218M [GeForce 
G210M] (rev a2) (prog-if 00 [VGA controller])
         Subsystem: ASUSTeK Computer Inc. Device 1bc2
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) 
[disabled] [size=16M]
         Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] 
[size=256M]
         Region 3: Memory at fa000000 (64-bit, prefetchable) [disabled] 
[size=32M]
         Region 5: I/O ports at dc00 [disabled] [size=128]
         Expansion ROM at fe980000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<4us, L1 <64us
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <256ns, L1 <1us
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- 
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [b4] Vendor Specific Information: Len=14 <?>
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
         Capabilities: [128 v1] Power Budgeting <?>
         Capabilities: [600 v1] Vendor Specific Information: ID=0001 
Rev=1 Len=024 <?>

01:00.1 Audio device: NVIDIA Corporation High Definition Audio 
Controller (rev a1)
         Subsystem: ASUSTeK Computer Inc. Device 1bc2
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at fe97c000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [60] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<4us, L1 <64us
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <256ns, L1 <1us
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- 
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Kernel driver in use: snd_hda_intel

03:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network 
Adapter (PCI-Express) (rev 01)
         Subsystem: AzureWave AW-NE785 / AW-NE785H 802.11bgn Wireless 
Full or Half-size Mini PCIe Card
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at feaf0000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                 Address: 00000000  Data: 0000
         Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <512ns, L1 <64us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- 
ChkCap+ ChkEn-
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
         Capabilities: [170 v1] Power Budgeting <?>
         Kernel driver in use: ath9k

04:00.0 Ethernet controller: Qualcomm Atheros AR8131 Gigabit Ethernet 
(rev c0)
         Subsystem: ASUSTeK Computer Inc. Device 1820
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 47
         Region 0: Memory at febc0000 (64-bit, non-prefetchable) [size=256K]
         Region 2: I/O ports at ec00 [size=128]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee0300c  Data: 4163
         Capabilities: [58] Express (v1) Endpoint, MSI 00
                 DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s 
<4us, L1 unlimited
                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 unlimited, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
                 Not readable
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                 AERCap: First Error Pointer: 0f, GenCap+ CGenEn- 
ChkCap+ ChkEn-
         Capabilities: [180 v1] Device Serial Number ff-12-2f-cc-20-cf-30-ff
         Kernel driver in use: atl1c

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST9320325AS      Rev: 0002
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: MATSHITA Model: DVD-RAM UJ892AS  Rev: 1.00
   Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: Multiple Model: Card  Reader     Rev: 1.00
   Type:   Direct-Access                    ANSI  SCSI revision: 00

$ ls /proc
1      118    13167  177   2185  2294  2575  28    40    5885 935        
crypto       kpagecount     self
10     119    13498  1772  2187  2297  26    2816  424   642 937        
devices      kpageflags     slabinfo
1025   12     13521  178   22    23    2625  2845  436   6692 940        
diskstats    latency_stats  softirqs
1034   120    13642  19    2239  2324  2626  29    440   7 941        
dma          loadavg        stat
1041   1207   13658  1952  2240  2325  2627  298   443   73 964        
driver       locks          swaps
1047   1209   13663  2     2241  2330  2628  3     4781  74 9717       
execdomains  mdstat         sys
1062   121    13681  20    2243  2331  2629  30    4782  7812 9740       
fb           meminfo        sysrq-trigger
1064   1247   14     2001  2247  2335  2630  304   4783  797 9874       
filesystems  misc           sysvipc
1069   1260   1436   2068  2257  2342  2631  31    4786  8 993        
fs           modules        timer_list
1081   1274   1437   2099  2260  2350  2632  3305  4787  801 acpi       
interrupts   mounts         timer_stats
1092   13     1494   21    2261  24    2633  34    4788  872 asound     
iomem        mtrr           tty
11     130    15     2158  2271  2403  2634  35    4789  8908 buddyinfo  
ioports      net            uptime
1111   13048  1550   2161  2274  2411  2635  36    4809  9 bus        
irq          pagetypeinfo   version
11510  1308   1563   2165  2281  2412  2636  361   5     9017 cgroups    
kallsyms     partitions     vmallocinfo
1166   131    16     2170  2285  2420  2637  37    52    909 cmdline    
kcore        sched_debug    vmstat
1168   13101  17     2181  2289  25    27    38    540   916 consoles   
key-users    schedstat      zoneinfo
1169   13164  176    2183  2292  2561  2796  39    549   920 cpuinfo    
kmsg         scsi

[X.] Other notes
$ ls /sys/class/backlight/
acpi_video0  acpi_video1  intel_backlight

$ cat /sys/class/backlight/intel_backlight/max_brightness
2583660

$ cat /sys/class/backlight/intel_backlight/brightness
121584

Launchpad downstream bug report on 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1178796

