From: Ben Harris <bjh21@bjh21.me.uk>
Subject: PROBLEM: [Dell Latitude 2110] Duplicate events from brightness
 keys
Date: Tue, 2 Dec 2014 18:02:29 +0000 (GMT)
Message-ID: <alpine.DEB.2.10.1412021702110.24511@snap.ds.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59436 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbaLBSCb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Dec 2014 13:02:31 -0500
Received: from snap.ds.cam.ac.uk ([131.111.8.76]:38703)
	by ppsw-50.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
	with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
	id 1XvrmP-0007ZA-rn (Exim 4.82_3-c0e5623) for linux-acpi@vger.kernel.org
	(return-path <bjh21@cam.ac.uk>); Tue, 02 Dec 2014 18:02:29 +0000
Received: from bjh21 (helo=localhost)
	by snap.ds.cam.ac.uk with local-esmtp (Exim 4.82)
	(envelope-from <bjh21@cam.ac.uk>)
	id 1XvrmP-0003Pv-KY
	for linux-acpi@vger.kernel.org; Tue, 02 Dec 2014 18:02:29 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:

[Dell Latitude 2110] Clicking brightness key once increments brightness as 
if pressed multiple times

[2.] Full description of the problem/report:

When I press the brightness-up and brightness-down keys (Fn+Up and 
Fn+Down) on my Dell Latitude 2110 under Ubuntu, the screen brightness 
changes by multiple steps.  In part this seems to be because two different 
input devices generate key events for these keys.  One of them is the main 
keyboard ("AT Translated Set 2 keyboard") and one is the ACPI video device 
("Video Bus").  According to 
<https://wiki.ubuntu.com/Hotkeys/Troubleshooting>, such behaviour is a bug 
in the kernel.

The problem persists (but with each keypress now producing a brightness 
change of precisely two steps) if I run
"sudo sh -c 'echo N > /sys/module/video/parameters/brightness_switch_enabled'"

To reproduce, on a Dell Latitude 2110, and assuming your input devices 
have the same names as mine, run "sudo evtest /dev/input/event3" and press 
Fn+Up and Fn+Down.  Note that these produce events:

Event: time 1417540372.173498, type 4 (EV_MSC), code 4 (MSC_SCAN), value 86
Event: time 1417540372.173498, type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 1
Event: time 1417540372.173498, -------------- SYN_REPORT ------------
Event: time 1417540372.173565, type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 0

Then run "sudo evtest /dev/input/event4" and press the same keys:

Event: time 1417540434.737144, type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 1
Event: time 1417540434.737144, -------------- SYN_REPORT ------------
Event: time 1417540434.737195, type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 0

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):

Linux version 3.18.0-031800rc7-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411302035 SMP Mon Dec 1 01:58:20 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
      problem (if possible)
[7.] Environment

Description:	Ubuntu 14.04.1 LTS
Release:	14.04

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux sole 3.18.0-031800rc7-generic #201411302035 SMP Mon Dec 1 01:58:20 
UTC 2014 i686 i686 i686 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         nls_iso8859_1 cuse dm_crypt arc4 joydev iwlmvm mac80211 dell_wmi gpio_ich sparse_keymap snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller dell_laptop dcdbas snd_hda_codec snd_hwdep snd_pcm coretemp snd_seq_midi psmouse snd_seq_midi_event serio_raw snd_rawmidi cdc_ether usbnet broadcom cdc_wdm mii btusb tg3 cdc_acm ptp iwlwifi snd_seq rfcomm bnep bluetooth snd_seq_device pps_core snd_timer lpc_ich rts5208 cfg80211 snd soundcore binfmt_misc dell_smo8800 mac_hid parport_pc ppdev lp parport i915 ahci libahci i2c_algo_bit drm_kms_helper wmi drm video

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N470   @ 1.83GHz
stepping	: 10
microcode	: 0x107
cpu MHz		: 1334.000
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl 
est tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm
bugs		:
bogomips	: 3657.64
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N470   @ 1.83GHz
stepping	: 10
microcode	: 0x107
cpu MHz		: 1000.000
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl 
est tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm
bugs		:
bogomips	: 3657.64
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

nls_iso8859_1 12617 1 - Live 0x00000000
cuse 13310 3 - Live 0x00000000
dm_crypt 22836 1 - Live 0x00000000
arc4 12509 2 - Live 0x00000000
joydev 17311 0 - Live 0x00000000
iwlmvm 235837 0 - Live 0x00000000
mac80211 593840 1 iwlmvm, Live 0x00000000
dell_wmi 12601 0 - Live 0x00000000
gpio_ich 13364 0 - Live 0x00000000
sparse_keymap 13658 1 dell_wmi, Live 0x00000000
snd_hda_codec_realtek 68787 1 - Live 0x00000000
snd_hda_codec_generic 63667 1 snd_hda_codec_realtek, Live 0x00000000
snd_hda_intel 29576 3 - Live 0x00000000
snd_hda_controller 30930 1 snd_hda_intel, Live 0x00000000
dell_laptop 13779 0 - Live 0x00000000
dcdbas 14521 1 dell_laptop, Live 0x00000000
snd_hda_codec 121018 4 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x00000000
snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
snd_pcm 89138 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 0x00000000
coretemp 13358 0 - Live 0x00000000
snd_seq_midi 13324 0 - Live 0x00000000
psmouse 106559 0 - Live 0x00000000
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
serio_raw 13251 0 - Live 0x00000000
snd_rawmidi 25786 1 snd_seq_midi, Live 0x00000000
cdc_ether 14059 0 - Live 0x00000000
usbnet 37935 1 cdc_ether, Live 0x00000000
broadcom 13065 0 - Live 0x00000000
cdc_wdm 18561 0 - Live 0x00000000
mii 13693 1 usbnet, Live 0x00000000
btusb 31907 0 - Live 0x00000000
tg3 159838 0 - Live 0x00000000
cdc_acm 32218 0 - Live 0x00000000
ptp 18938 1 tg3, Live 0x00000000
iwlwifi 171238 1 iwlmvm, Live 0x00000000
snd_seq 56978 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
rfcomm 59288 8 - Live 0x00000000
bnep 19107 2 - Live 0x00000000
bluetooth 421512 22 btusb,rfcomm,bnep, Live 0x00000000
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
pps_core 18768 1 ptp, Live 0x00000000
snd_timer 29036 2 snd_pcm,snd_seq, Live 0x00000000
lpc_ich 17000 0 - Live 0x00000000
rts5208 520443 1 - Live 0x00000000 (C)
cfg80211 440091 3 iwlmvm,mac80211,iwlwifi, Live 0x00000000
snd 67102 16 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x00000000
soundcore 14635 2 snd_hda_codec,snd, Live 0x00000000
binfmt_misc 13165 1 - Live 0x00000000
dell_smo8800 12986 0 - Live 0x00000000
mac_hid 13099 0 - Live 0x00000000
parport_pc 32154 0 - Live 0x00000000
ppdev 17423 0 - Live 0x00000000
lp 13359 0 - Live 0x00000000
parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
i915 905336 3 - Live 0x00000000
ahci 25756 2 - Live 0x00000000
libahci 31003 1 ahci, Live 0x00000000
i2c_algo_bit 13316 1 i915, Live 0x00000000
drm_kms_helper 87512 1 i915, Live 0x00000000
wmi 18843 1 dell_wmi, Live 0x00000000
drm 263568 5 i915,drm_kms_helper, Live 0x00000000
video 19969 1 i915, Live 0x00000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0061-0061 : PNP0800:00
   0063-0063 : PNP0800:00
   0064-0064 : keyboard
   0065-0065 : PNP0800:00
   0067-0067 : PNP0800:00
   0070-0071 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : PNP0C04:00
     00f0-00ff : fpu
   03c0-03df : vesafb
   04d0-04d1 : pnp 00:05
   0809-0809 : pnp 00:06
   0900-092f : pnp 00:05
   0930-0930 : PNP0C09:00
     0930-0930 : EC data
   0931-0933 : pnp 00:05
   0934-0934 : PNP0C09:00
     0934-0934 : EC cmd
   0935-097f : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-1005 : pnp 00:05
     1000-1003 : ACPI PM1a_EVT_BLK
     1004-1005 : ACPI PM1a_CNT_BLK
   1006-1007 : pnp 00:06
   1008-100f : pnp 00:05
     1008-100b : ACPI PM_TMR
   1010-1015 : ACPI CPU throttle
   1020-1020 : ACPI PM2_CNT_BLK
   1028-102f : gpio_ich
     1028-102f : ACPI GPE0_BLK
   1030-1033 : iTCO_wdt
   1060-107f : iTCO_wdt
     1060-107f : pnp 00:06
   1080-10bf : gpio_ich
     1080-10bf : pnp 00:06
       1080-10af : gpio_ich
       10b0-10bf : gpio_ich
   10c0-10df : 0000:00:1f.3
     10c0-10df : pnp 00:06
   2000-2fff : PCI Bus 0000:0b
   3000-3fff : PCI Bus 0000:0c
   4000-4fff : PCI Bus 0000:0d
   5000-5fff : PCI Bus 0000:09
   6e70-6e77 : 0000:00:1f.2
     6e70-6e77 : ahci
   6e78-6e7b : 0000:00:1f.2
     6e78-6e7b : ahci
   6e80-6e87 : 0000:00:1f.2
     6e80-6e87 : ahci
   6e88-6e8b : 0000:00:1f.2
     6e88-6e8b : ahci
   6ea0-6ebf : 0000:00:1f.2
     6ea0-6ebf : ahci
   bf20-bf3f : 0000:00:1d.3
     bf20-bf3f : uhci_hcd
   bf40-bf5f : 0000:00:1d.2
     bf40-bf5f : uhci_hcd
   bf60-bf7f : 0000:00:1d.1
     bf60-bf7f : uhci_hcd
   bf80-bf9f : 0000:00:1d.0
     bf80-bf9f : uhci_hcd
   eff8-efff : 0000:00:02.0
   f400-f4fe : pnp 00:06

00000000-00000fff : reserved
00001000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
   000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce000-000cffff : Adapter ROM
000d0000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-7f5bf3ff : System RAM
   01000000-016d1ae2 : Kernel code
   016d1ae3-01a718ff : Kernel data
   01b61000-01c27fff : Kernel bss
   18000000-1fffffff : Crash kernel
7f5bf400-7f5c13ff : ACPI Non-volatile Storage
7f5c1400-7fffffff : reserved
   7f600000-7f6fffff : pnp 00:07
   7f800000-7fffffff : Graphics Stolen Memory
80000000-f7ffffff : PCI Bus 0000:00
   80000000-801fffff : PCI Bus 0000:0b
   80200000-803fffff : PCI Bus 0000:0b
   80400000-805fffff : PCI Bus 0000:0c
   80600000-807fffff : PCI Bus 0000:0d
   80800000-809fffff : PCI Bus 0000:09
   80a00000-80a00fff : Intel Flush Page
   80a04000-80a07fff : i915 MCHBAR
   e0000000-efffffff : 0000:00:02.0
   f6a00000-f6afffff : PCI Bus 0000:09
     f6af0000-f6afffff : 0000:09:00.0
       f6af0000-f6afffff : tg3
   f6b00000-f6bfffff : PCI Bus 0000:0d
     f6bf0000-f6bfffff : 0000:0d:00.0
       f6bf0000-f6bfffff : rts5208
   f6c00000-f6cfffff : PCI Bus 0000:0c
     f6cfe000-f6cfffff : 0000:0c:00.0
       f6cfe000-f6cfffff : iwlwifi
   f6dfc000-f6dfffff : 0000:00:1b.0
     f6dfc000-f6dfffff : ICH HD audio
   f6e00000-f6e7ffff : 0000:00:02.0
   f6e80000-f6efffff : 0000:00:02.1
   f6f00000-f6ffffff : 0000:00:02.0
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
   f8000000-fbffffff : reserved
     f8000000-fbffffff : pnp 00:07
fc000000-febfffff : PCI Bus 0000:00
fec00000-fec0ffff : reserved
   fec00000-fec003ff : IOAPIC 0
fec10000-fecfffff : PCI Bus 0000:00
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : pnp 00:04
fed18000-fed1bfff : reserved
   fed18000-fed1bfff : pnp 00:07
     fed1b410-fed1b414 : iTCO_wdt
fed1c000-fed1ffff : PCI Bus 0000:00
   fed1c000-fed1c3ff : 0000:00:1d.7
     fed1c000-fed1c3ff : ehci_hcd
   fed1c800-fed1cbff : 0000:00:1f.2
     fed1c800-fed1cbff : ahci
fed20000-fed8ffff : reserved
   fed20000-fed8ffff : pnp 00:07
fed90000-fed9ffff : PCI Bus 0000:00
feda0000-feda6fff : reserved
   feda0000-feda3fff : pnp 00:07
   feda4000-feda4fff : pnp 00:07
   feda5000-feda5fff : pnp 00:07
   feda6000-feda6fff : pnp 00:07
feda7000-fedfffff : PCI Bus 0000:00
fee00000-fee0ffff : reserved
   fee00000-fee0ffff : pnp 00:07
     fee00000-fee00fff : Local APIC
fee10000-ff9fffff : PCI Bus 0000:00
ffa00000-ffbfffff : pnp 00:07
ffc00000-ffdfffff : PCI Bus 0000:00
ffe00000-ffffffff : reserved
   ffe00000-ffffffff : pnp 00:07

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx DMI Bridge
 	Subsystem: Dell Device 0461
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
 	Latency: 0
 	Capabilities: [e0] Vendor Specific Information: Len=08 <?>
 	Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller (prog-if 00 [VGA controller])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin A routed to IRQ 29
 	Region 0: Memory at f6e00000 (32-bit, non-prefetchable) [size=512K]
 	Region 1: I/O ports at eff8 [size=8]
 	Region 2: Memory at e0000000 (32-bit, prefetchable) [size=256M]
 	Region 3: Memory at f6f00000 (32-bit, non-prefetchable) [size=1M]
 	Expansion ROM at <unassigned> [disabled]
 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 41a2
 	Capabilities: [d0] Power Management version 2
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Region 0: Memory at f6e80000 (32-bit, non-prefetchable) [size=512K]
 	Capabilities: [d0] Power Management version 2
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High Definition Audio Controller (rev 01)
 	Subsystem: Dell Device 0461
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 32
 	Region 0: Memory at f6dfc000 (64-bit, non-prefetchable) [size=16K]
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee0300c  Data: 41d2
 	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag- RBE-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
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
 			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=80
 			Status:	NegoPending- InProgress-
 	Capabilities: [130 v1] Root Complex Link
 		Desc:	PortNumber=0f ComponentID=02 EltType=Config
 		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
 			Addr:	00000000fed18000
 	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
 	I/O behind bridge: 00002000-00002fff
 	Memory behind bridge: 80000000-801fffff
 	Prefetchable memory behind bridge: 0000000080200000-00000000803fffff
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag- RBE-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
 			ClockPM- Surprise- LLActRep+ BwNot-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
 			Changed: MRL- PresDet- LinkState-
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
 		RootCap: CRSVisible-
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 41b1
 	Capabilities: [90] Subsystem: Dell Device 0461
 	Capabilities: [a0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [100 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed+ WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending- InProgress-
 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
 			Status:	NegoPending- InProgress-
 	Capabilities: [180 v1] Root Complex Link
 		Desc:	PortNumber=01 ComponentID=02 EltType=Config
 		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
 			Addr:	00000000fed18001
 	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 2 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
 	I/O behind bridge: 00003000-00003fff
 	Memory behind bridge: f6c00000-f6cfffff
 	Prefetchable memory behind bridge: 0000000080400000-00000000805fffff
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag- RBE-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
 			ClockPM- Surprise- LLActRep+ BwNot-
 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet- LinkState-
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
 		RootCap: CRSVisible-
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 41d1
 	Capabilities: [90] Subsystem: Dell Device 0461
 	Capabilities: [a0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [100 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed+ WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
 			Status:	NegoPending- InProgress-
 	Capabilities: [180 v1] Root Complex Link
 		Desc:	PortNumber=02 ComponentID=02 EltType=Config
 		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
 			Addr:	00000000fed18001
 	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 3 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=0
 	I/O behind bridge: 00004000-00004fff
 	Memory behind bridge: f6b00000-f6bfffff
 	Prefetchable memory behind bridge: 0000000080600000-00000000807fffff
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag- RBE-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
 			ClockPM- Surprise- LLActRep+ BwNot-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #4, PowerLimit 6.500W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet- LinkState-
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
 		RootCap: CRSVisible-
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 4122
 	Capabilities: [90] Subsystem: Dell Device 0461
 	Capabilities: [a0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [100 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed+ WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
 			Status:	NegoPending- InProgress-
 	Capabilities: [180 v1] Root Complex Link
 		Desc:	PortNumber=03 ComponentID=02 EltType=Config
 		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
 			Addr:	00000000fed18001
 	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 4 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
 	I/O behind bridge: 00005000-00005fff
 	Memory behind bridge: f6a00000-f6afffff
 	Prefetchable memory behind bridge: 0000000080800000-00000000809fffff
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag- RBE-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
 			ClockPM- Surprise- LLActRep+ BwNot-
 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #5, PowerLimit 6.500W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet- LinkState-
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
 		RootCap: CRSVisible-
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 4152
 	Capabilities: [90] Subsystem: Dell Device 0461
 	Capabilities: [a0] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [100 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed+ WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
 			Status:	NegoPending- InProgress-
 	Capabilities: [180 v1] Root Complex Link
 		Desc:	PortNumber=04 ComponentID=02 EltType=Config
 		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
 			Addr:	00000000fed18001
 	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin A routed to IRQ 22
 	Region 4: I/O ports at bf80 [size=32]
 	Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin B routed to IRQ 21
 	Region 4: I/O ports at bf60 [size=32]
 	Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin C routed to IRQ 22
 	Region 4: I/O ports at bf40 [size=32]
 	Kernel driver in use: uhci_hcd

00:1d.3 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Controller #4 (rev 01) (prog-if 00 [UHCI])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin D routed to IRQ 23
 	Region 4: I/O ports at bf20 [size=32]
 	Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
 	Subsystem: Dell Device 0461
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin A routed to IRQ 22
 	Region 0: Memory at fed1c000 (32-bit, non-prefetchable) [size=1K]
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [58] Debug port: BAR=1 offset=00a0
 	Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
 	I/O behind bridge: 0000f000-00000fff
 	Memory behind bridge: fff00000-000fffff
 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [50] Subsystem: Dell Device 0461

00:1f.0 ISA bridge: Intel Corporation NM10 Family LPC Controller (rev 01)
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
 	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation NM10/ICH7 Family SATA Controller [AHCI mode] (rev 01) (prog-if 01 [AHCI 1.0])
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin D routed to IRQ 28
 	Region 0: I/O ports at 6e70 [size=8]
 	Region 1: I/O ports at 6e78 [size=4]
 	Region 2: I/O ports at 6e80 [size=8]
 	Region 3: I/O ports at 6e88 [size=4]
 	Region 4: I/O ports at 6ea0 [size=32]
 	Region 5: Memory at fed1c800 (32-bit, non-prefetchable) [size=1K]
 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
 		Address: fee0300c  Data: 4192
 	Capabilities: [70] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
 	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation NM10/ICH7 Family SMBus Controller (rev 01)
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Interrupt: pin B routed to IRQ 4
 	Region 4: I/O ports at 10c0 [size=32]

09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57760 Gigabit Ethernet PCIe (rev 01)
 	Subsystem: Dell Device 0461
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 33
 	Region 0: Memory at f6af0000 (64-bit, non-prefetchable) [size=64K]
 	Capabilities: [48] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [60] Vendor Specific Information: Len=6c <?>
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee0300c  Data: 41e2
 	Capabilities: [cc] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <32us
 			ClockPM+ Surprise- LLActRep- BwNot-
 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
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
 		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
 	Capabilities: [13c v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [160 v1] Device Serial Number b8-ac-6f-ff-fe-6f-de-39
 	Capabilities: [16c v1] Power Budgeting <?>
 	Kernel driver in use: tg3

0c:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
 	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 31
 	Region 0: Memory at f6cfe000 (64-bit, non-prefetchable) [size=8K]
 	Capabilities: [c8] Power Management version 3
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee0300c  Data: 41c2
 	Capabilities: [40] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <32us
 			ClockPM+ Surprise- LLActRep- BwNot-
 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
 		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr+ BadTLP+ BadDLLP- Rollover- Timeout+ NonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
 		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
 	Capabilities: [140 v1] Device Serial Number 80-19-34-ff-ff-cf-03-50
 	Capabilities: [14c v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
 	Kernel driver in use: iwlwifi

0d:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5208 (rev 01)
 	Subsystem: Dell Device 0461
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 30
 	Region 0: Memory at f6bf0000 (32-bit, non-prefetchable) [size=64K]
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee0300c  Data: 41b2
 	Capabilities: [70] Express (v1) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <2us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
 			ClockPM+ Surprise- LLActRep- BwNot-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
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
 	Capabilities: [160 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
 	Kernel driver in use: rts5208

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: INTEL SSDSC2CT06 Rev: 300i
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: Generic- Model: xD/SD/M.S.       Rev: 1.00
   Type:   Direct-Access                    ANSI  SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

bjh21@sole:~/rockall-linux/linux$ ls /proc
1     1319  2286  2593  2876  48    6736       consoles     net
10    1459  2293  2595  29    481   6742       cpuinfo      pagetypeinfo
1066  1461  23    2599  2904  482   6821       crypto       partitions
1071  1492  231   26    2921  49    684        devices      sched_debug
1080  15    2310  2610  2929  490   6882       diskstats    schedstat
1081  1555  2316  2612  2945  499   69         dma          scsi
1084  1582  232   2613  2959  5     6910       driver       self
11    16    2324  2614  2964  50    7          execdomains  slabinfo
1133  1607  2325  2618  2972  503   70         fb           softirqs
1137  17    2329  2621  2982  516   7139       filesystems  stat
1141  1782  2332  2622  3     518   7142       fs           swaps
1150  18    2334  2640  30    520   7278       interrupts   sys
116   180   2337  2647  3005  528   7310       iomem        sysrq-trigger
1165  181   2343  2671  3064  532   7333       ioports      sysvipc
117   1823  2350  2684  3095  534   744        irq          thread-self
118   19    2355  2690  3143  537   766        kallsyms     timer_list
119   2     2357  2697  3150  540   779        kcore        timer_stats
12    20    2360  27    3151  541   8          keys         tty
120   2042  2366  2704  337   545   894        key-users    uptime
1208  2056  2374  2711  3386  551   9          kmsg         version
121   2063  24    2716  34    560   914        kpagecount   vmallocinfo
1216  21    2466  2783  342   599   916        kpageflags   vmstat
122   2177  25    28    3457  6014  920        loadavg      zoneinfo
123   22    2523  2803  35    6021  924        locks
1239  2201  2524  2807  36    6170  acpi       mdstat
1244  2256  2525  2827  3927  6181  asound     meminfo
1247  2259  2545  2831  4039  6255  buddyinfo  misc
1260  2271  2547  2835  4199  6275  bus        modules
1272  2280  2562  2851  422   6502  cgroups    mounts
13    2285  2577  2859  464   665   cmdline    mtrr

Relevant entries from the output of "lsinput":

/dev/input/event3
    bustype : BUS_I8042
    vendor  : 0x1
    product : 0x1
    version : 43841
    name    : "AT Translated Set 2 keyboard"
    phys    : "isa0060/serio0/input0"
    bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP

/dev/input/event4
    bustype : BUS_HOST
    vendor  : 0x0
    product : 0x6
    version : 0
    name    : "Video Bus"
    phys    : "LNXVIDEO/video/input0"
    bits ev : EV_SYN EV_KEY

[X.] Other notes, patches, fixes, workarounds:

I initially reported this bug to Ubuntu here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1397699

They asked me to send it upstream.

-- 
Ben Harris
