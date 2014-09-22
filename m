From: =?utf-8?q?karol_zitnansky?= <karol.zitnansky@pobox.sk>
Subject: =?utf-8?q?Asus_EeePC_1101HA_wakeup_from_sleep?=
Date: Mon, 22 Sep 2014 17:40:53 +0200
Message-ID: <20140922174053.59B7A75F@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gmmr1.centrum.cz ([46.255.225.252]:44944 "EHLO gmmr1.centrum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbaIVPqD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2014 11:46:03 -0400
Received: from mail1008.cent (mail-g1.snat.cent [10.32.3.100])
	by gmmr1.centrum.cz (Postfix) with ESMTP id 5294580025D9
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2014 17:40:53 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

1. Asus EeePC 1101HA wakeup from sleep

2. On my Asus EeePC 1101HA after suspend I cannot wake up the machine (doesn't matter which way to suspend is used - via GUI or Fn+F1 (Sleep button) or executing 'pm-suspend' in a terminal). After entering the sleep mode pressing power button does nothing, LED keeps flashing. The only way is to press the power button and wait until the notebook powers off. Additionally there is no line produced while executing acpi_listen and pressing power button

3. ch@chplusjntb:~$ cat /proc/version
Linux version 3.17.0-031700rc5-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409151105 SMP Mon Sep 15 16:49:53 UTC 2014

4.

5.

6. execute pm-suspend

7. ch@chplusjntb:~$ lsb_release -rd
Description:	Ubuntu 14.04.1 LTS
Release:	14.04

7.1. ch@chplusjntb:~$ /usr/src/linux-headers-3.17.0-031700rc5/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux chplusjntb 3.17.0-031700rc5-generic #201409151105 SMP Mon Sep 15 16:49:53 UTC 2014 i686 i686 i686 GNU/Linux
 
Gnu C                  /usr/src/linux-headers-3.17.0-031700rc5/scripts/ver_linux:
/usr/src/linux-headers-3.17.0-031700rc5/scripts/ver_linux: 20: /usr/src/linux-headers-3.17.0-031700rc5/scripts/ver_linux: ld: not found
binutils               
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm snd_seq_midi i2c_isch gpio_sch eeepc_wmi asus_wmi uvcvideo snd_seq_midi_event coretemp videobuf2_vmalloc kvm_intel snd_rawmidi videobuf2_memops arc4 videobuf2_core snd_seq ath9k kvm v4l2_common ath9k_common ath9k_hw videodev rfcomm bnep ath media snd_seq_device gma500_gfx joydev snd_timer mac80211 btusb serio_raw drm_kms_helper snd bluetooth cfg80211 drm soundcore lpc_sch i2c_algo_bit parport_pc mac_hid ppdev wmi sparse_keymap video lp parport pata_acpi psmouse pata_sch atl1c

7.2 ch@chplusjntb:~$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU Z520   @ 1.33GHz
stepping	: 2
microcode	: 0x211
cpu MHz		: 1333.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 xtpr pdcm movbe lahf_lm dtherm tpr_shadow vnmi flexpriority
bugs		:
bogomips	: 2662.53
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 32 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU Z520   @ 1.33GHz
stepping	: 2
microcode	: 0x211
cpu MHz		: 1067.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 xtpr pdcm movbe lahf_lm dtherm tpr_shadow vnmi flexpriority
bugs		:
bogomips	: 2662.53
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 32 bits virtual
power management:

7.3 ch@chplusjntb:~$ cat /proc/modules
snd_hda_codec_realtek 67292 1 - Live 0x00000000
snd_hda_codec_generic 63743 1 snd_hda_codec_realtek, Live 0x00000000
snd_hda_intel 29543 1 - Live 0x00000000
snd_hda_controller 30930 1 snd_hda_intel, Live 0x00000000
snd_hda_codec 121364 4 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x00000000
snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
snd_pcm 88093 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 0x00000000
snd_seq_midi 13324 0 - Live 0x00000000
i2c_isch 13307 0 - Live 0x00000000
gpio_sch 12928 0 - Live 0x00000000
eeepc_wmi 12983 0 - Live 0x00000000
asus_wmi 23913 1 eeepc_wmi, Live 0x00000000
uvcvideo 76608 0 - Live 0x00000000
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
coretemp 13358 0 - Live 0x00000000
videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
kvm_intel 138596 0 - Live 0x00000000
snd_rawmidi 25786 1 snd_seq_midi, Live 0x00000000
videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
arc4 12509 2 - Live 0x00000000
videobuf2_core 53107 1 uvcvideo, Live 0x00000000
snd_seq 56978 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
ath9k 137329 0 - Live 0x00000000
kvm 405036 1 kvm_intel, Live 0x00000000
v4l2_common 15158 1 videobuf2_core, Live 0x00000000
ath9k_common 20782 1 ath9k, Live 0x00000000
ath9k_hw 439370 2 ath9k,ath9k_common, Live 0x00000000
videodev 140643 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x00000000
rfcomm 59328 8 - Live 0x00000000
bnep 19107 2 - Live 0x00000000
ath 24509 3 ath9k,ath9k_common,ath9k_hw, Live 0x00000000
media 21030 2 uvcvideo,videodev, Live 0x00000000
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
gma500_gfx 219856 2 - Live 0x00000000
joydev 17311 0 - Live 0x00000000
snd_timer 29036 2 snd_pcm,snd_seq, Live 0x00000000
mac80211 593625 1 ath9k, Live 0x00000000
btusb 31680 0 - Live 0x00000000
serio_raw 13251 0 - Live 0x00000000
drm_kms_helper 91692 1 gma500_gfx, Live 0x00000000
snd 67102 12 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x00000000
bluetooth 420517 22 rfcomm,bnep,btusb, Live 0x00000000
cfg80211 434807 4 ath9k,ath9k_common,ath,mac80211, Live 0x00000000
drm 262610 4 gma500_gfx,drm_kms_helper, Live 0x00000000
soundcore 14635 2 snd_hda_codec,snd, Live 0x00000000
lpc_sch 12797 0 - Live 0x00000000
i2c_algo_bit 13316 1 gma500_gfx, Live 0x00000000
parport_pc 32154 0 - Live 0x00000000
mac_hid 13099 0 - Live 0x00000000
ppdev 17423 0 - Live 0x00000000
wmi 18843 1 asus_wmi, Live 0x00000000
sparse_keymap 13658 1 asus_wmi, Live 0x00000000
video 19905 2 asus_wmi,gma500_gfx, Live 0x00000000
lp 13359 0 - Live 0x00000000
parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
pata_acpi 12901 0 - Live 0x00000000
psmouse 102225 0 - Live 0x00000000
pata_sch 12724 3 - Live 0x00000000
atl1c 41733 0 - Live 0x00000000

7.4 ch@chplusjntb:~$ cat /proc/ioports 
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  0170-0177 : 0000:00:1f.1
    0170-0177 : pata_sch
  01f0-01f7 : 0000:00:1f.1
    01f0-01f7 : pata_sch
  0374-0375 : pnp 00:03
  0376-0376 : 0000:00:1f.1
    0376-0376 : pata_sch
  0380-0387 : pnp 00:03
  03c0-03df : vesafb
  03f4-03f5 : pnp 00:03
  03f6-03f6 : 0000:00:1f.1
    03f6-03f6 : pata_sch
  0400-043f : isch_smbus.33049
    0400-043f : pnp 00:03
      0400-043f : isch_smbus
  0480-04bf : sch_gpio.33049
    0480-04bf : pnp 00:03
      0480-04bf : sch_gpio
  04d0-04d1 : pnp 00:03
  0810-0815 : ACPI CPU throttle
  0900-09f3 : pnp 00:03
    0900-0903 : ACPI PM1a_EVT_BLK
    0904-0905 : ACPI PM1a_CNT_BLK
    0908-090b : ACPI PM_TMR
    0920-0920 : ACPI PM2_CNT_BLK
    09c0-09c7 : ACPI GPE0_BLK
  09f4-09ff : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  b880-b89f : 0000:00:1d.0
    b880-b89f : uhci_hcd
  c080-c09f : 0000:00:1d.1
    c080-c09f : uhci_hcd
  c480-c49f : 0000:00:1d.2
    c480-c49f : uhci_hcd
  c880-c887 : 0000:00:02.0
  d000-dfff : PCI Bus 0000:01
  e000-efff : PCI Bus 0000:03
    e880-e8ff : 0000:03:00.0
      e880-e8ff : atl1c
  ffa0-ffaf : 0000:00:1f.1
    ffa0-ffaf : pata_sch

ch@chplusjntb:~$ cat /proc/iomem 
00000000-00000fff : reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
  000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
000e2000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-3f64ffff : System RAM
  01000000-016c3c96 : Kernel code
  016c3c97-01a5b9bf : Kernel data
  01b44000-01c08fff : Kernel bss
3f650000-3f65ffff : reserved
3f660000-3f66dfff : ACPI Tables
3f66e000-3f6affff : ACPI Non-volatile Storage
3f6b0000-3f6bffff : reserved
3f6c0000-3f6c7fff : RAM buffer
3f6c8000-3f7fffff : reserved
3f800000-dfffffff : PCI Bus 0000:00
  3f800000-3fffffff : pnp 00:00
  40000000-7fffffff : pnp 00:00
  80000000-801fffff : PCI Bus 0000:03
  cc000000-cfffffff : PCI Bus 0000:01
  d0000000-dfffffff : 0000:00:02.0
    d0000000-d0003fff : cursor
    d0004000-d0007fff : cursor
    d0008000-d0607fff : fb
    d0bc7000-d0fcefff : gem
    d0fcf000-d0fd2fff : gem
    d0fd3000-d0fd6fff : gem
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : pnp 00:07
f0000000-ffffffff : PCI Bus 0000:00
  f0000000-f0003fff : pnp 00:03
  f3f37c00-f3f37fff : 0000:00:1d.7
    f3f37c00-f3f37fff : ehci_hcd
  f3f38000-f3f3bfff : 0000:00:1b.0
    f3f38000-f3f3bfff : ICH HD audio
  f3f40000-f3f7ffff : 0000:00:02.0
  f3f80000-f3ffffff : 0000:00:02.0
  f4000000-fbefffff : PCI Bus 0000:01
    fbef0000-fbefffff : 0000:01:00.0
      fbef0000-fbefffff : ath9k
  fbf00000-fbffffff : PCI Bus 0000:03
    fbfc0000-fbffffff : 0000:03:00.0
      fbfc0000-fbffffff : atl1c
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
      fee00000-fee00fff : pnp 00:05
  ff800000-ffbfffff : INT0800:00
  ffc00000-ffffffff : INT0800:00
    fff00000-ffffffff : reserved

7.5 ch@chplusjntb:~$ sudo lspci -vvv 
00:00.0 Host bridge: Intel Corporation System Controller Hub (SCH Poulsbo) (rev 07)
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:02.0 VGA compatible controller: Intel Corporation System Controller Hub (SCH Poulsbo) Graphics Controller (rev 07) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f3f80000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at c880 [size=8]
	Region 2: Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
	Region 3: Memory at f3f40000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Vendor Specific Information: Len=07 <?>
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: gma500

00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH Poulsbo) HD Audio Controller (rev 07)
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f3f38000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000f0000000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsbo) PCI Express Port 1 (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fbf00000-fbffffff
	Prefetchable memory behind bridge: 80000000-801fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
			ClockPM+ Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 83ce
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsbo) PCI Express Port 2 (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f4000000-fbefffff
	Prefetchable memory behind bridge: cc000000-cfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
			ClockPM+ Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 83ce
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo) USB UHCI #1 (rev 07) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at b880 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo) USB UHCI #2 (rev 07) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at c080 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo) USB UHCI #3 (rev 07) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at c480 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo) USB EHCI #1 (rev 07) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f3f37c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation System Controller Hub (SCH Poulsbo) LPC Bridge (rev 07)
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: lpc_sch

00:1f.1 IDE interface: Intel Corporation System Controller Hub (SCH Poulsbo) IDE Controller (rev 07) (prog-if 80 [Master])
	Subsystem: ASUSTeK Computer Inc. Device 83ce
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
	Region 4: I/O ports at ffa0 [size=16]
	Kernel driver in use: pata_sch

01:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network Adapter (PCI-Express) (rev 01)
	Subsystem: AzureWave AW-NE785 / AW-NE785H 802.11bgn Wireless Full or Half-size Mini PCIe Card
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fbef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [170 v1] Power Budgeting <?>
	Kernel driver in use: ath9k

03:00.0 Ethernet controller: Qualcomm Atheros AR8132 Fast Ethernet (rev c0)
	Subsystem: ASUSTeK Computer Inc. Device 14e5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at fbfc0000 (64-bit, non-prefetchable) [size=256K]
	Region 2: I/O ports at e880 [size=128]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 4142
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
		Not readable
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [180 v1] Device Serial Number ff-5e-8d-ce-00-26-18-ff
	Kernel driver in use: atl1c

7.6 ch@chplusjntb:~$ cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HTS54321 Rev: C40C
  Type:   Direct-Access                    ANSI  SCSI revision: 05

7.7 ch@chplusjntb:~$ ls /proc 
1     13    16    1735  2334  438  708          filesystems  pagetypeinfo
10    1305  1606  1743  24    439  71           fs           partitions
1020  1313  1607  1749  25    446  754          interrupts   sched_debug
1066  1351  1609  1754  26    463  756          iomem        schedstat
1070  136   1619  1757  265   465  8            ioports      scsi
1075  137   1631  18    268   478  861          irq          self
1078  1406  1635  19    27    479  9            kallsyms     slabinfo
1081  1462  1643  1918  28    48   acpi         kcore        softirqs
1084  1480  1658  1984  282   49   asound       keys         stat
11    15    1659  2     29    5    buddyinfo    key-users    swaps
119   1532  1661  20    3     50   bus          kmsg         sys
1195  1534  1667  2062  30    501  cgroups      kpagecount   sysrq-trigger
1196  1546  1670  2063  31    528  cmdline      kpageflags   sysvipc
12    1548  1674  2064  32    543  consoles     loadavg      thread-self
120   1554  1678  2089  34    6    cpuinfo      locks        timer_list
1209  1570  1691  21    342   638  crypto       mdstat       timer_stats
121   1574  1699  2116  343   659  devices      meminfo      tty
122   1577  17    2122  35    662  diskstats    misc         uptime
124   1578  1707  2145  355   673  dma          modules      version
125   1592  1712  22    36    695  driver       mounts       vmallocinfo
1262  1593  1716  23    404   7    execdomains  mtrr         vmstat
1282  1599  1730  2324  437   70   fb           net          zoneinfo

X. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1370689
