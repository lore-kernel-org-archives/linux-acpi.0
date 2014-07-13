From: Michael P <pancoma@gmail.com>
Subject: PROBLEM
Date: Sat, 12 Jul 2014 22:39:55 -0400
Message-ID: <CAGyEvacvhpyu6Qr-h87CbjPCKKpDBVc5PNjX_1a-qcFdm65XDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41786 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbaGMCj4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jul 2014 22:39:56 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so79402pad.27
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jul 2014 19:39:55 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
[Satellite L350D PSLE8C-03G019] Cooling fans not responding to
temperature increase on first startup causing overheating. Works after
suspend & resume though.

[2.]Full description of the problem/report:
Booting up things appear as normal. I can work for a given amount of
time even, however cooling fans will not change speed with cpu usage
increase or decrease. If the computer is booted up cool then the fans
will remain on a low setting untill a critical cpu overheating point
when the computer crashes or is forced to shtdown by some safety
feature I Imagine, but the since installing a temperature monitor, I
see the temp has reached above 100C at points.. Not good I imagine. If
the computer is booted up when it is still hot (for example if its
been shutdown then rebooted immediately) It will be blowing harder.
The fan setting seems to be determined somewhere around when the grub
menu appears and then is locked into that fan speed, given whatever
temperature the hardware is at during the first part of the bootup.
Once I suspend either manually through the settings menu or by closing
the laptop lid, and wake up the computer again, the fans will work as
they should and respond to the hardware temperatures, increasing and
decreasing with heavy or lighter usage and heat generation. After that
any number of suspends and resumes will not change the behavior of the
fans, they continue to function properly, until of course I actually
shutdown the computer and boot up again without suspending
immediately.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from/proc/version): Linux version
3.16.0-031600rc4-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201407061635 SMP Sun Jul 6 20:36:26
UTC 2014

[5.] Output of Oops: (not applicable)

[6.] Shell script to reproduce problem: (sorry this is beyond me. Im
just barley making it by figuring out this bug report... Im still not
sure if Im doing it right...

[7.] Environment:Description:
Ubuntu 12.04.4 LTS
Release: 12.04

[7.1.] Software: Im sorry, Im still an amateur user here, Im trying to
understand how to get this output using the terminal but Im just not
familiar enough with using the teminal. I can copy and paste commands,
but ask me to do this and Im lost. this is the best I could do. I
navigated to the usr/src folders in the file system and found a number
of folders named as: (linux-headers-3.8.0-29) and next:
(linux-headers-3.8.0-29-generic) and like this for every pair of
folders all with the same version name simply differing in the last
digits numbering from -29 to -42, I hope this helps or makes sense.

[7.2] Processor info (from /proc/cpuinfo):
michael@Michael-Sat-L350D:~$ cat /proc/cpuinfo
processor : 0
vendor_id : AuthenticAMD
cpu family : 17
model : 3
model name : AMD Athlon(tm) X2 Dual-Core QL-65
stepping : 1
microcode : 0x2000057
cpu MHz : 1050.000
cache size : 512 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc
extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
3dnowprefetch osvw skinit hw_pstate lbrv svm_lock nrip_save
bogomips : 4200.37
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

processor : 1
vendor_id : AuthenticAMD
cpu family : 17
model : 3
model name : AMD Athlon(tm) X2 Dual-Core QL-65
stepping : 1
microcode : 0x2000057
cpu MHz : 2100.000
cache size : 512 KB
physical id : 0
siblings : 2
core id : 1
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc
extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
3dnowprefetch osvw skinit hw_pstate lbrv svm_lock nrip_save
bogomips : 4200.37
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

[7.3] Module information (from /proc/modules):
michael@Michael-Sat-L350D:~$ cat /proc/modules
nls_iso8859_1 12713 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 0 - Live 0x0000000000000000
bluetooth 467228 10 bnep,rfcomm, Live 0x0000000000000000
snd_hda_codec_hdmi 52339 1 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
uvcvideo 82301 0 - Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
snd_hda_codec_realtek 73695 1 - Live 0x0000000000000000
rtl8187 65286 0 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
mac80211 687067 1 rtl8187, Live 0x0000000000000000
videobuf2_core 59635 1 uvcvideo, Live 0x0000000000000000
snd_hda_intel 30683 3 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
cfg80211 521225 2 rtl8187,mac80211, Live 0x0000000000000000
radeon 1607226 4 - Live 0x0000000000000000
videodev 150178 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
snd_hda_codec 144889 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
eeprom_93cx6 13344 1 rtl8187, Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
snd_pcm 113863 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 67636 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
ttm 90341 1 radeon, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
drm_kms_helper 62042 1 radeon, Live 0x0000000000000000
psmouse 113097 0 - Live 0x0000000000000000
drm 316819 7 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
toshiba_acpi 28375 0 - Live 0x0000000000000000
snd 74235 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x0000000000000000
sparse_keymap 13890 1 toshiba_acpi, Live 0x0000000000000000
sp5100_tco 14134 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
i2c_piix4 22311 0 - Live 0x0000000000000000
shpchp 37216 0 - Live 0x0000000000000000
k10temp 13191 0 - Live 0x0000000000000000
wmi 19379 1 toshiba_acpi, Live 0x0000000000000000
soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
video 20311 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
pata_acpi 13053 0 - Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53122 0 - Live 0x0000000000000000
hid 110572 2 hid_generic,usbhid, Live 0x0000000000000000
ums_realtek 18352 0 - Live 0x0000000000000000
uas 27672 0 - Live 0x0000000000000000
r8169 73316 0 - Live 0x0000000000000000
pata_atiixp 13279 0 - Live 0x0000000000000000
ahci 30167 5 - Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
michael@Michael-Sat-L350D:~$ cat /proc/ioports
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
  00f0-00ff : fpu
    00f0-00fe : PNP0C04:00
  0170-0177 : 0000:00:14.1
    0170-0177 : pata_atiixp
  01f0-01f7 : 0000:00:14.1
    01f0-01f7 : pata_atiixp
  0376-0376 : 0000:00:14.1
    0376-0376 : pata_atiixp
  03c0-03df : vesafb
  03f6-03f6 : 0000:00:14.1
    03f6-03f6 : pata_atiixp
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-0427 : ACPI GPE0_BLK
  04d0-04d1 : pnp 00:04
  04d6-04d6 : pnp 00:04
  0680-06ff : pnp 00:04
  077a-077a : pnp 00:04
  0800-0804 : pnp 00:04
    0800-0800 : ACPI PM2_CNT_BLK
  0b00-0b3f : pnp 00:04
    0b00-0b07 : piix4_smbus
    0b20-0b27 : piix4_smbus
  0c00-0c01 : pnp 00:04
  0c14-0c14 : pnp 00:04
  0c50-0c52 : pnp 00:04
  0c6c-0c6c : pnp 00:04
  0c6f-0c6f : pnp 00:04
  0cd0-0cdb : pnp 00:04
  0cdc-0cdf : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:80
  2000-2fff : PCI Bus 0000:05
  3000-4fff : PCI Bus 0000:04
    3000-30ff : 0000:04:00.0
      3000-30ff : r8169
  5000-5fff : PCI Bus 0000:02
  6000-6fff : PCI Bus 0000:01
    6000-60ff : 0000:01:05.0
  7000-700f : 0000:00:14.1
    7000-700f : pata_atiixp
  7010-701f : 0000:00:11.0
    7010-701f : ahci
  7030-7037 : 0000:00:11.0
    7030-7037 : ahci
  7038-703f : 0000:00:11.0
    7038-703f : ahci
  7048-704b : 0000:00:11.0
    7048-704b : ahci
  704c-704f : 0000:00:11.0
    704c-704f : ahci

michael@Michael-Sat-L350D:~$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
  000c0000-000c3fff : PCI Bus 0000:00
  000c4000-000c7fff : PCI Bus 0000:00
  000c8000-000cbfff : PCI Bus 0000:00
000cf000-000cffff : Adapter ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-afdd6fff : System RAM
  01000000-017a6798 : Kernel code
  017a6799-01d273bf : Kernel data
  01e87000-01fcffff : Kernel bss
afdd7000-afe3efff : ACPI Non-volatile Storage
afe3f000-afe6ffff : System RAM
afe70000-afebefff : reserved
afebf000-afeecfff : System RAM
afeed000-afefefff : ACPI Tables
afeff000-afefffff : System RAM
aff00000-afffffff : RAM buffer
c0000000-f6ffffff : PCI Bus 0000:00
  c0000000-cfffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:05.0
  d0000000-d0ffffff : PCI Bus 0000:02
  d1000000-d20fffff : PCI Bus 0000:04
    d1000000-d100ffff : 0000:04:00.0
      d1000000-d100ffff : r8169
    d1010000-d1010fff : 0000:04:00.0
      d1010000-d1010fff : r8169
  d2100000-d30fffff : PCI Bus 0000:05
  d3100000-d40fffff : PCI Bus 0000:05
  d4100000-d50fffff : PCI Bus 0000:04
    d4100000-d411ffff : 0000:04:00.0
  d5100000-d60fffff : PCI Bus 0000:02
  d6100000-d62fffff : PCI Bus 0000:01
    d6100000-d61fffff : 0000:01:05.0
    d6200000-d620ffff : 0000:01:05.0
  d6300000-d6303fff : 0000:00:14.2
    d6300000-d6303fff : ICH HD audio
  d6304000-d6304fff : 0000:00:13.1
    d6304000-d6304fff : ohci_hcd
  d6305000-d6305fff : 0000:00:13.0
    d6305000-d6305fff : ohci_hcd
  d6306000-d6306fff : 0000:00:12.1
    d6306000-d6306fff : ohci_hcd
  d6307000-d6307fff : 0000:00:12.0
    d6307000-d6307fff : ohci_hcd
  d6308000-d63083ff : 0000:00:11.0
    d6308000-d63083ff : ahci
  d6308400-d63084ff : 0000:00:13.2
    d6308400-d63084ff : ehci_hcd
  d6308500-d63085ff : 0000:00:12.2
    d6308500-d63085ff : ehci_hcd
f7000000-f7ffffff : PCI MMCONFIG 0000 [bus 00-0f]
  f7000000-f7ffffff : reserved
f8000000-ffffffff : PCI Bus 0000:00
  feb00000-feb00fff : reserved
    feb00000-feb00fff : pnp 00:05
  fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
      fee00000-fee00fff : pnp 00:00
  ff800000-ff80ffff : pnp 00:05
  fff00000-ffffffff : reserved
    fff00000-ffffffff : pnp 00:05
[7.5.] PCI info ('lspci -vvv' as root)
e- BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0300c  Data: 4181
Capabilities: [b0] Subsystem: Toshiba America Info Systems Device ff6a
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [110 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Kernel driver in use: pcieport

00:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI
to PCI bridge (PCIE port 1) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: 00003000-00004fff
Memory behind bridge: d4100000-d50fffff
Prefetchable memory behind bridge: 00000000d1000000-00000000d20fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag+ RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #5, PowerLimit 25.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0300c  Data: 4191
Capabilities: [b0] Subsystem: Toshiba America Info Systems Device ff6a
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [110 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Kernel driver in use: pcieport

00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780 PCI to
PCI bridge (PCIE port 2) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: d3100000-d40fffff
Prefetchable memory behind bridge: 00000000d2100000-00000000d30fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag+ RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #247, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed unknown, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #6, PowerLimit 25.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0300c  Data: 41a1
Capabilities: [b0] Subsystem: Toshiba America Info Systems Device ff6a
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [110 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Kernel driver in use: pcieport

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 22
Region 0: I/O ports at 7038 [size=8]
Region 1: I/O ports at 704c [size=4]
Region 2: I/O ports at 7030 [size=8]
Region 3: I/O ports at 7048 [size=4]
Region 4: I/O ports at 7010 [size=16]
Region 5: Memory at d6308000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [60] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [70] SATA HBA v1.0 InCfgSpace
Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d6307000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:12.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0
USB OHCI1 Controller (prog-if 10 [OHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d6306000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at d6308500 (32-bit, non-prefetchable) [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Bridge: PM- B3+
Capabilities: [e4] Debug port: BAR=1 offset=00e0
Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 18
Region 0: Memory at d6305000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0
USB OHCI1 Controller (prog-if 10 [OHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 18
Region 0: Memory at d6304000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 19
Region 0: Memory at d6308400 (32-bit, non-prefetchable) [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Bridge: PM- B3+
Capabilities: [e4] Debug port: BAR=1 offset=00e0
Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus
Controller (rev 3a)
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
Kernel driver in use: piix4_smbus

00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 IDE Controller (prog-if 8a [Master SecP PriP])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 16
Region 0: I/O ports at 01f0 [size=8]
Region 1: I/O ports at 03f4 [size=1]
Region 2: I/O ports at 0170 [size=8]
Region 3: I/O ports at 0374 [size=1]
Region 4: I/O ports at 7000 [size=16]
Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Kernel driver in use: pata_atiixp

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
Azalia (Intel HDA)
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d6300000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 LPC host controller
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI
to PCI Bridge (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Bus: primary=00, secondary=80, subordinate=8f, sec-latency=64
I/O behind bridge: 00001000-00001fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: fff00000-000fffff
Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 11h
Processor HyperTransport Configuration (rev 40)
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: [80] HyperTransport: Host or Secondary Interface
Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
IsocEn- LSEn+ ExtCTL- 64b-
Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit
DwFcInEn- LWO=16bit DwFcOutEn-
Revision ID: 3.00
Link Frequency: [b]
Link Error: <Prot- <Ovfl- <EOC- CTLTm-
Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+
800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 11h
Processor Address Map
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 11h
Processor DRAM Controller
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 11h
Processor Miscellaneous Control
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: [f0] Secure device <?>
Kernel driver in use: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 11h
Processor Link Control
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:05.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] RS780MC [Mobility Radeon HD 3100] (prog-if 00 [VGA
controller])
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 18
Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
Region 1: I/O ports at 6000 [size=256]
Region 2: Memory at d6200000 (32-bit, non-prefetchable) [size=64K]
Region 5: Memory at d6100000 (32-bit, non-prefetchable) [size=1M]
Expansion ROM at <unassigned> [disabled]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: radeon

04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 02)
Subsystem: Toshiba America Info Systems Device ff6a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 43
Region 0: I/O ports at 3000 [size=256]
Region 2: Memory at d1010000 (64-bit, prefetchable) [size=4K]
Region 4: Memory at d1000000 (64-bit, prefetchable) [size=64K]
Expansion ROM at d4100000 [disabled] [size=128K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0300c  Data: 41c1
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
<512ns, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [ac] MSI-X: Enable- Count=2 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [cc] Vital Product Data
Unknown small resource type 00, will not decode more.
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-ff-ff-00-00
Kernel driver in use: r8169


[7.6.] SCSI information (from /proc/scsi/scsi)
michael@Michael-Sat-L350D:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9750420AS      Rev: SDM5
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: DVD-RAM UJ880AS  Rev: 1.50
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem:
michael@Michael-Sat-L350D:~$ ls /proc
1     1366  1970  2120  247   5     8756       cmdline        mounts
10    14    1973  2129  25    5116  887        consoles       mtrr
1014  1403  1974  2136  251   56    8954       cpuinfo        net
1023  1414  1982  214   253   57    9          crypto         pagetypeinfo
1024  15    1983  2141  254   60    934        devices        partitions
1026  1574  1986  2145  26    6086  9353       diskstats      sched_debug
1027  1576  1988  2146  27    647   9354       dma            schedstat
1042  16    1993  2154  28    6568  9374       driver         scsi
1064  1621  1996  2160  29    7     9386       execdomains    self
1076  1624  2     2168  294   79    9410       fb             slabinfo
1092  1625  20    2175  3     8     9481       filesystems    softirqs
11    1637  200   2197  30    80    9503       fs             stat
1112  1640  2005  220   31    824   9514       interrupts     swaps
1118  1653  2007  222   32    8299  957        iomem          sys
1152  17    2022  2226  321   8306  959        ioports        sysrq-trigger
1165  1797  203   223   322   8307  964        ipmi           sysvipc
1168  18    2044  2230  33    8308  9664       irq            timer_list
1190  1817  2045  2242  34    8312  967        kallsyms       timer_stats
1193  1824  2047  2254  35    8313  9673       kcore          tty
1194  1831  2050  2257  36    8333  9676       key-users      uptime
1198  19    2052  2259  37    8358  9682       kmsg           version
12    1944  2072  226   3784  852   9683       kpagecount     vmallocinfo
1201  1948  2074  2260  38    8524  969        kpageflags     vmstat
1203  1954  2075  23    39    8545  9746       latency_stats  zoneinfo
1213  1959  2076  232   410   8557  998        loadavg
1296  1961  2078  2322  42    8563  acpi       locks
13    1965  2080  2324  425   8582  asound     mdstat
1300  1968  21    2360  43    8697  buddyinfo  meminfo
1354  1969  211   238   44    8716  bus        misc
1357  197   2118  241   4755  8749  cgroups    modules

[X.] Other notes, patches, fixes, workarounds:
link to your Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1225270

workaround suggested but not tried yet:
https://help.ubuntu.com/community/PowerManagement/ReducedPower


Thanks for your efforts in this whole project.!
Michael Pancoe
www.dhamma.org
