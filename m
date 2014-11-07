From: Lorenzo <lorenzo.millucci@gmail.com>
Subject: PROBLEM: broken colors after suspend/resume
Date: Fri, 07 Nov 2014 19:07:42 +0100
Message-ID: <545D0A6E.900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:59943 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaKGSIe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2014 13:08:34 -0500
Received: by mail-wi0-f171.google.com with SMTP id r20so5348866wiv.4
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2014 10:08:32 -0800 (PST)
Received: from [192.168.1.34] (host88-185-dynamic.19-79-r.retail.telecomitalia.it. [79.19.185.88])
        by mx.google.com with ESMTPSA id fv2sm2931772wib.2.2014.11.07.10.08.29
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 10:08:31 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


[1.] broken colours after suspend/resume on iMac 8,1
[2.] After a suspend/resume cycle the graphic is broken (Here there is 
an image: 
https://onedrive.live.com/redir?resid=F360DB4014F86298!22188&authkey=!AISDvz3fV20MHKI&v=3&ithint=photo%2cjpg).
This happen if I press the suspend button on the GUI and even if the 
system is suspended for inactivity.
I don't know if is related to this problem but when I boot the system 
there is this message: radeon 0000:01:00.0: Invalid ROM contents
[3.]
[4.] Linux version 3.18.0-031800rc3-generic (apw@tangerine) (gcc version 
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411022335 SMP Sun Nov 2 
23:36:52 UTC 2014
[5.]
[6.]
[7.] Description:    Ubuntu 14.04.1 LTS
Release:    14.04
[7.1]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lorenzo-iMac 3.18.0-031800rc3-generic #201411022335 SMP Sun Nov 2 
23:36:52 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         rfcomm bnep nls_iso8859_1 radeon 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
snd_hda_controller snd_hda_codec snd_hwdep uvcvideo snd_pcm snd_seq_midi 
videobuf2_vmalloc videobuf2_memops videobuf2_core snd_seq_midi_event 
joydev v4l2_common coretemp ttm kvm_intel videodev kvm drm_kms_helper 
media snd_rawmidi applesmc input_polldev hid_appleir drm snd_seq 
snd_seq_device i2c_algo_bit parport_pc snd_timer ppdev snd btusb lpc_ich 
lp soundcore video bluetooth parport apple_bl mac_hid hid_generic 
hid_apple usbhid hid ahci libahci firewire_ohci firewire_core sky2 crc_itu_t

[7.2]
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 23
model name    : Intel(R) Core(TM)2 Duo CPU     E8235  @ 2.80GHz
stepping    : 6
microcode    : 0x60c
cpu MHz        : 800.000
cache size    : 6144 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni 
dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm 
dtherm tpr_shadow vnmi flexpriority
bugs        :
bogomips    : 5586.07
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 23
model name    : Intel(R) Core(TM)2 Duo CPU     E8235  @ 2.80GHz
stepping    : 6
microcode    : 0x60c
cpu MHz        : 800.000
cache size    : 6144 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni 
dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm 
dtherm tpr_shadow vnmi flexpriority
bugs        :
bogomips    : 5586.07
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3]
rfcomm 75066 8 - Live 0x0000000000000000
bnep 23980 2 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
radeon 1570939 3 - Live 0x0000000000000000
snd_hda_codec_realtek 76099 1 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
snd_hda_intel 30783 3 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 144641 4 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
uvcvideo 86723 0 - Live 0x0000000000000000
snd_pcm 106273 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
ttm 90228 1 radeon, Live 0x0000000000000000
kvm_intel 149984 0 - Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 
0x0000000000000000
kvm 475233 1 kvm_intel, Live 0x0000000000000000
drm_kms_helper 99802 1 radeon, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
applesmc 19564 0 - Live 0x0000000000000000
input_polldev 14607 1 applesmc, Live 0x0000000000000000
hid_appleir 13027 0 - Live 0x0000000000000000
drm 323675 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
parport_pc 32909 0 - Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
snd 84025 16 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
btusb 32691 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
video 20649 0 - Live 0x0000000000000000
bluetooth 486890 22 rfcomm,bnep,btusb, Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
apple_bl 14007 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
hid_apple 13546 0 - Live 0x0000000000000000
usbhid 53155 0 - Live 0x0000000000000000
hid 110572 4 hid_appleir,hid_generic,hid_apple,usbhid, Live 
0x0000000000000000
ahci 34220 4 - Live 0x0000000000000000
libahci 32446 1 ahci, Live 0x0000000000000000
firewire_ohci 45300 0 - Live 0x0000000000000000
firewire_core 69403 1 firewire_ohci, Live 0x0000000000000000
sky2 63220 0 - Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000

[7.4]
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0062-0062 : PNP0C09:00
     0062-0062 : EC data
   0064-0064 : keyboard
   0066-0066 : PNP0C09:00
     0066-0066 : EC cmd
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
     00f0-00f0 : PNP0C04:00
   0300-031f : APP0001:00
     0300-031f : applesmc
   0400-0403 : ACPI PM1a_EVT_BLK
   0404-0405 : ACPI PM1a_CNT_BLK
   0408-040b : ACPI PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-0420 : ACPI PM2_CNT_BLK
   0428-042f : ACPI GPE0_BLK
   0430-0433 : iTCO_wdt
   0460-047f : iTCO_wdt
   0500-053f : 0000:00:1f.0
     0500-053f : pnp 00:02
   0680-069f : pnp 00:02
   0800-080f : pnp 00:02
   0810-0817 : pnp 00:02
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1640-164f : pnp 00:02
   2000-2fff : PCI Bus 0000:02
   3000-3fff : PCI Bus 0000:03
   4000-4fff : PCI Bus 0000:04
   5000-5fff : PCI Bus 0000:05
     5000-50ff : 0000:05:00.0
       5000-50ff : sky2
   6000-6fff : PCI Bus 0000:01
     6000-60ff : 0000:01:00.0
   7020-703f : 0000:00:1f.2
     7020-703f : ahci
   7040-705f : 0000:00:1d.2
     7040-705f : uhci_hcd
   7060-707f : 0000:00:1d.1
     7060-707f : uhci_hcd
   7080-709f : 0000:00:1d.0
     7080-709f : uhci_hcd
   70a0-70bf : 0000:00:1a.1
     70a0-70bf : uhci_hcd
   70c0-70df : 0000:00:1a.0
     70c0-70df : uhci_hcd
   70e0-70ef : 0000:00:1f.1
     70e0-70ef : ata_piix
   70f0-70f7 : 0000:00:1f.2
     70f0-70f7 : ahci
   70f8-70ff : 0000:00:1f.2
     70f8-70ff : ahci
   7100-7107 : 0000:00:1f.1
     7100-7107 : ata_piix
   7108-710f : 0000:00:1f.1
     7108-710f : ata_piix
   7110-7113 : 0000:00:1f.2
     7110-7113 : ahci
   7114-7117 : 0000:00:1f.2
     7114-7117 : ahci
   7118-711b : 0000:00:1f.1
     7118-711b : ata_piix
   711c-711f : 0000:00:1f.1
     711c-711f : ata_piix
   efa0-efbf : 0000:00:1f.3

00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0008ffff : ACPI Non-volatile Storage
00090000-0009ffff : System RAM
000a0000-000bffff : PCI Bus 0000:00
   000a0000-000bffff : reserved
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-be7c2fff : System RAM
   02000000-027ae357 : Kernel code
   027ae358-02d1997f : Kernel data
   02e80000-02fc8fff : Kernel bss
be7c3000-be7c3fff : reserved
be7c4000-be833fff : System RAM
be834000-be839fff : reserved
be83a000-be846fff : System RAM
be847000-be848fff : reserved
be849000-be8adfff : System RAM
be8ae000-be8aefff : reserved
be8af000-bed16fff : System RAM
bed17000-bed17fff : reserved
bed18000-bed1dfff : reserved
bed1e000-bed1ffff : System RAM
bed20000-bed23fff : reserved
bed24000-bed26fff : System RAM
bed27000-bed27fff : reserved
bed28000-bed2cfff : System RAM
bed2d000-bed30fff : reserved
bed31000-bed3efff : System RAM
bed3f000-bed40fff : reserved
bed41000-bed43fff : System RAM
bed44000-bef44fff : ACPI Non-volatile Storage
bef45000-beffafff : System RAM
beffb000-beffcfff : ACPI Non-volatile Storage
beffd000-beffffff : System RAM
bf000000-bf001fff : reserved
bf002000-bf053fff : System RAM
bf054000-bf065fff : reserved
bf066000-bf069fff : reserved
bf06a000-bf076fff : System RAM
bf077000-bf077fff : reserved
bf078000-bf07bfff : System RAM
bf07c000-bf08cfff : reserved
bf08d000-bf08ffff : reserved
bf090000-bf0a5fff : System RAM
bf0a6000-bf0a7fff : reserved
bf0a8000-bf0a8fff : reserved
bf0a9000-bf0aafff : System RAM
bf0ab000-bf0abfff : reserved
bf0ac000-bf0affff : System RAM
bf0b0000-bf0b2fff : reserved
bf0b3000-bf0b3fff : reserved
bf0b4000-bf0b6fff : System RAM
bf0b7000-bf0b7fff : reserved
bf0b8000-bf4e4fff : System RAM
bf4e5000-bf4e6fff : reserved
bf4e7000-bf50afff : System RAM
bf50b000-bf50bfff : reserved
bf50c000-bfaa5fff : System RAM
bfaa6000-bfaa6fff : reserved
bfaa7000-bfe9dfff : System RAM
bfe9e000-bfe9efff : reserved
bfe9f000-bfec3fff : System RAM
bfec4000-bfec5fff : ACPI Non-volatile Storage
bfec6000-bfec8fff : ACPI Tables
bfec9000-bfedefff : ACPI Non-volatile Storage
bfedf000-bfeeefff : ACPI Tables
bfeef000-bfef8fff : System RAM
bfef9000-bfffffff : reserved
c0000000-febfffff : PCI Bus 0000:00
   c0000000-cfffffff : PCI Bus 0000:01
     c0000000-cfffffff : 0000:01:00.0
   d0000000-d00fffff : PCI Bus 0000:06
   d0100000-d01fffff : PCI Bus 0000:05
     d0100000-d0103fff : 0000:05:00.0
       d0100000-d0103fff : sky2
     d0120000-d013ffff : 0000:05:00.0
   d0200000-d02fffff : PCI Bus 0000:04
     d0200000-d0203fff : 0000:04:00.0
   d0300000-d03fffff : PCI Bus 0000:03
     d0300000-d0300fff : 0000:03:00.0
       d0300000-d0300fff : firewire_ohci
   d0400000-d04fffff : PCI Bus 0000:02
   d0500000-d05fffff : PCI Bus 0000:01
     d0500000-d051ffff : 0000:01:00.0
     d0520000-d052ffff : 0000:01:00.0
   d0600000-d0603fff : 0000:00:1b.0
     d0600000-d0603fff : ICH HD audio
   d0604000-d06047ff : 0000:00:1f.2
     d0604000-d06047ff : ahci
   d0604800-d0604bff : 0000:00:1d.7
     d0604800-d0604bff : ehci_hcd
   d0604c00-d0604fff : 0000:00:1a.7
     d0604c00-d0604fff : ehci_hcd
   d0605000-d06050ff : 0000:00:1f.3
   d0700000-d08fffff : PCI Bus 0000:02
   d0900000-d0afffff : PCI Bus 0000:03
   d0b00000-d0cfffff : PCI Bus 0000:04
   d0d00000-d0efffff : PCI Bus 0000:05
   f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f00f8000-f00f8fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : pnp 00:01
fed14000-fed17fff : pnp 00:00
fed18000-fed18fff : pnp 00:00
fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:00
     fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
ff000000-ffffffff : INT0800:00
   fffa0000-fffcffff : reserved
100000000-13fffffff : System RAM

[7.5]
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory 
Controller Hub (rev 03)
     Subsystem: Apple Inc. Device 00a0
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0a <?>

00:01.0 PCI bridge: Intel Corporation Mobile PM965/GM965/GL960 PCI 
Express Root Port (rev 03) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 00006000-00006fff
     Memory behind bridge: d0500000-d05fffff
     Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [88] Subsystem: Intel Corporation Device 0000
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41c1
     Capabilities: [a0] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg-
             Control: AttnInd Off, PwrInd On, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [140 v1] Root Complex Link
         Desc:    PortNumber=02 ComponentID=01 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed19000
     Kernel driver in use: pcieport

00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #4 (rev 04) (prog-if 00 [UHCI])
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 20
     Region 4: I/O ports at 70c0 [size=32]
     Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #5 (rev 04) (prog-if 00 [UHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 16
     Region 4: I/O ports at 70a0 [size=32]
     Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #2 (rev 04) (prog-if 20 [EHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 21
     Region 0: Memory at d0604c00 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 04)
     Subsystem: Apple Inc. Device 00a0
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Interrupt: pin A routed to IRQ 31
     Region 0: Memory at d0600000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 41c2
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=0 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending- InProgress-
     Capabilities: [130 v1] Root Complex Link
         Desc:    PortNumber=0f ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 04) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: d0400000-d04fffff
     Prefetchable memory behind bridge: 00000000d0700000-00000000d08fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #0, PowerLimit 6.500W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41d1
     Capabilities: [90] Subsystem: Device 0000:0000
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

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 4 (rev 04) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 00003000-00003fff
     Memory behind bridge: d0300000-d03fffff
     Prefetchable memory behind bridge: 00000000d0900000-00000000d0afffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 4122
     Capabilities: [90] Subsystem: Device 0000:0000
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
Port 5 (rev 04) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: 00004000-00004fff
     Memory behind bridge: d0200000-d02fffff
     Prefetchable memory behind bridge: 00000000d0b00000-00000000d0cfffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #4, PowerLimit 6.500W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 4142
     Capabilities: [90] Subsystem: Device 0000:0000
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

00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 6 (rev 04) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
     I/O behind bridge: 00005000-00005fff
     Memory behind bridge: d0100000-d01fffff
     Prefetchable memory behind bridge: 00000000d0d00000-00000000d0efffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #5, PowerLimit 6.500W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 4162
     Capabilities: [90] Subsystem: Device 0000:0000
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
         Desc:    PortNumber=06 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c001
     Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #1 (rev 04) (prog-if 00 [UHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 4: I/O ports at 7080 [size=32]
     Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #2 (rev 04) (prog-if 00 [UHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 18
     Region 4: I/O ports at 7060 [size=32]
     Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #3 (rev 04) (prog-if 00 [UHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 21
     Region 4: I/O ports at 7040 [size=32]
     Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #1 (rev 04) (prog-if 20 [EHCI])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin D routed to IRQ 20
     Region 0: Memory at d0604800 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f4) 
(prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: d0000000-d00fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Subsystem: Device 0000:0000

00:1f.0 ISA bridge: Intel Corporation 82801HM (ICH8M) LPC Interface 
Controller (rev 04)
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich

00:1f.1 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) IDE 
Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 21
     Region 0: I/O ports at 7108 [size=8]
     Region 1: I/O ports at 711c [size=4]
     Region 2: I/O ports at 7100 [size=8]
     Region 3: I/O ports at 7118 [size=4]
     Region 4: I/O ports at 70e0 [size=16]
     Kernel driver in use: ata_piix

00:1f.2 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) 
SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 30
     Region 0: I/O ports at 70f8 [size=8]
     Region 1: I/O ports at 7114 [size=4]
     Region 2: I/O ports at 70f0 [size=8]
     Region 3: I/O ports at 7110 [size=4]
     Region 4: I/O ports at 7020 [size=32]
     Region 5: Memory at d0604000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/4 Maskable- 64bit-
         Address: fee0300c  Data: 41b2
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 04)
     Subsystem: Apple Inc. Device 00a0
     Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 0
     Region 0: Memory at d0605000 (32-bit, non-prefetchable) [disabled] 
[size=256]
     Region 4: I/O ports at efa0 [size=32]

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] RV630/M76 [Mobility Radeon HD 2600 XT/2700] (prog-if 00 [VGA 
controller])
     Subsystem: Apple Inc. iMac 7,1
     Physical Slot: 1
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Interrupt: pin A routed to IRQ 32
     Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
     Region 2: Memory at d0520000 (64-bit, non-prefetchable) [size=64K]
     Region 4: I/O ports at 6000 [size=256]
     Expansion ROM at d0500000 [disabled] [size=128K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v1) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 41d2
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Kernel driver in use: radeon

03:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 
1394b Controller (rev 06) (prog-if 10 [OHCI])
     Subsystem: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller
     Physical Slot: 3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Interrupt: pin A routed to IRQ 19
     Region 0: Memory at d0300000 (64-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
     Capabilities: [4c] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [60] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 2048 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
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
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=0 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending- InProgress-
     Capabilities: [170 v1] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: firewire_ohci

04:00.0 Network controller: Broadcom Corporation BCM4321 802.11a/b/g/n 
(rev 05)
     Subsystem: Apple Inc. AirPort Extreme
     Physical Slot: 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 0
     Region 0: Memory at d0200000 (64-bit, non-prefetchable) [disabled] 
[size=16K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
     Capabilities: [58] Vendor Specific Information: Len=78 <?>
     Capabilities: [e8] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [d0] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
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
     Capabilities: [160 v1] Device Serial Number 71-e5-12-ff-ff-26-00-23
     Capabilities: [16c v1] Power Budgeting <?>

05:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8058 PCI-E 
Gigabit Ethernet Controller (rev 13)
     Subsystem: Marvell Technology Group Ltd. Imac 8,1 Wired Ethernet 
Adapter
     Physical Slot: 5
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 256 bytes
     Interrupt: pin A routed to IRQ 29
     Region 0: Memory at d0100000 (64-bit, non-prefetchable) [size=16K]
     Region 2: I/O ports at 5000 [size=256]
     Expansion ROM at d0120000 [disabled] [size=128K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] Vital Product Data
         Product Name: Marvell Yukon 88E8058 Gigabit Ethernet Controller
         Read-only fields:
             [PN] Part number: Yukon 88E8058
             [EC] Engineering changes: Rev. 1.3
             [MN] Manufacture ID: 4d 61 72 76 65 6c 6c
             [SN] Serial number: AbCdEfG9F657D
             [CP] Extended capability: 01 10 cc 03
             [RV] Reserved: checksum good, 9 byte(s) reserved
         Read/write fields:
             [RW] Read-write area: 121 byte(s) free
         End
     Capabilities: [5c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 41a2
     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 2048 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <256ns, L1 unlimited
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L0s L1 Enabled; RCB 128 bytes Disabled- CommClk+
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
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
     Kernel driver in use: sky2

[7.6]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: PIONEER  Model: DVD-RW  DVR-K06A Rev: Q631
   Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Hitachi HDP72503 Rev: A59A
   Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7]
1     1580  1853  2092    2612  468  812          dma        partitions
10    16    1866  21    2634  474  816          driver        sched_debug
1004  1600  1870  2101    2644  478  82          execdomains   schedstat
1016  1624  1872  2110    27    490  822          fb        scsi
1019  1691  1877  2122    279   491  823          filesystems   self
1048  17    1879  2138    28    5    826          fs        slabinfo
1094  1700  1880  2144    29    52   83          interrupts    softirqs
11    1713  1884  22    297   53   898          iomem        stat
1145  1724  1885  2245    3     531  9          ioports        swaps
1163  1726  1891  2248    30    54   900          irq        sys
12    1729  19      2249    31    55   907          kallsyms 
sysrq-trigger
13    1730  1907  2252    32    56   913          kcore        sysvipc
130   1751  1938  2260    33    560  957          keys        thread-self
131   1756  1942  2274    339   561  964          key-users     timer_list
132   1758  1953  2279    34    57   979          kmsg        timer_stats
133   1759  2      2286    340   63   989          kpagecount    tty
134   1764  20      2298    341   644  acpi       kpageflags    uptime
135   1766  2019  23    343   682  asound     loadavg        version
136   1771  2034  2327    345   686  buddyinfo  locks        vmallocinfo
137   1776  2038  2340    35    7    bus          mdstat        vmstat
138   1780  2039  24    36    717  cgroups    meminfo        zoneinfo
139   18    2040  2466    37    727  cmdline    misc
14    1800  2050  2474    38    747  consoles   modules
1442  1801  2061  2483    39    754  cpuinfo    mounts
15    1803  2065  2484    4     760  crypto     mtrr
152   1828  2082  25    40    779  devices    net
153   1840  2086  26    408   8    diskstats  pagetypeinfo

[X.]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1389703
