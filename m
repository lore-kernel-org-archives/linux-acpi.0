From: John Relph <John.Relph@alumni.usc.edu>
Subject: [Dell Dimension E521] System goes to sleep at GDM window and never wakes up
Date: Wed, 1 Oct 2014 06:52:22 -0400
Message-ID: <21547.56550.447498.680375@seedbed.idiot-dog.com>
Reply-To: John.Relph@alumni.usc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:48327 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAKw0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 06:52:26 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so40208qcv.24
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2014 03:52:25 -0700 (PDT)
Received: from seedbed.idiot-dog.com (pool-96-231-137-204.washdc.fios.verizon.net. [96.231.137.204])
        by mx.google.com with ESMTPSA id i1sm330978qaz.28.2014.10.01.03.52.24
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2014 03:52:24 -0700 (PDT)
Received: from seedbed.idiot-dog.com. (localhost.localdomain [127.0.0.1])
	by seedbed.idiot-dog.com (Postfix) with ESMTP id D93AE10039
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2014 06:52:22 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:

[Dell Dimension E521] System goes to sleep at GDM window and never wakes up

[2.] Full description of the problem/report:

I booted into the latest mainline kernel. The system came up to the GDM prompt. After less than one minute, the system went to sleep. One it was fully asleep, I attempted to wake it up by pushing the power button. The system spun up and then gradually the CPU fans went to maximum, but the system never woke up. The keyboard was nonresponsive and nothing was displayed on the monitor.

End of story. I had to push and hold the power button to power off.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):

$ cat /proc/version
Linux version 3.17.0-031700rc6-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409211935 SMP Sun Sep 21 23:37:11 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information resolved

[6.] A small shell script or example program which triggers the problem (if possible)

[7.] Environment

$ lsb_release -rd
Description:    Ubuntu 14.04.1 LTS
Release:        14.04

[7.1.] Software (add the output of the ver_linux script here)

/usr/src/linux-headers-3.17.0-031700rc6-generic/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux seedbed 3.17.0-031700rc6-generic #201409211935 SMP Sun Sep 21 23:37:11 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
reiserfsprogs          3.6.24
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         cuse bnep rfcomm bluetooth dm_crypt binfmt_misc ipheth snd_hda_codec_idt snd_hda_codec_generic dcdbas snd_hda_codec_hdmi snd_hda_intel kvm_amd snd_hda_controller kvm snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event serio_raw snd_rawmidi nls_iso8859_1 snd_seq snd_seq_device snd_timer snd edac_core k8temp edac_mce_amd soundcore nv_tco i2c_nforce2 mac_hid parport_pc ppdev lp parport raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid0 multipath linear raid1 hid_generic usbhid hid uas usb_storage pata_acpi radeon i2c_algo_bit ttm drm_kms_helper b44 ssb psmouse drm mii sata_nv

[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping        : 1
cpu MHz         : 1800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch lbrv
bugs            : apic_c1e fxsave_leak
bogomips        : 3607.52
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping        : 1
cpu MHz         : 1800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch lbrv
bugs            : apic_c1e fxsave_leak
bogomips        : 3607.52
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

[7.3.] Module information (from /proc/modules):

$ cat /proc/modules
cuse 13566 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 0 - Live 0x0000000000000000
bluetooth 477455 10 bnep,rfcomm, Live 0x0000000000000000
dm_crypt 23456 0 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
ipheth 13547 0 - Live 0x0000000000000000
snd_hda_codec_idt 60147 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_idt, Live 0x0000000000000000
dcdbas 15017 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
snd_hda_intel 30783 4 - Live 0x0000000000000000
kvm_amd 60904 0 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
kvm 468567 1 kvm_amd, Live 0x0000000000000000
snd_hda_codec 145035 5 snd_hda_codec_idt,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller, Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 105052 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
nls_iso8859_1 12713 2 - Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 84025 19 snd_hda_codec_idt,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
edac_core 52405 0 - Live 0x0000000000000000
k8temp 13076 0 - Live 0x0000000000000000
edac_mce_amd 22800 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
nv_tco 13700 0 - Live 0x0000000000000000
i2c_nforce2 13317 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
raid10 48666 0 - Live 0x0000000000000000
raid456 92008 0 - Live 0x0000000000000000
async_raid6_recov 17389 1 raid456, Live 0x0000000000000000
async_memcpy 12689 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_pq 13456 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_xor 13233 3 raid456,async_raid6_recov,async_pq, Live 0x0000000000000000
async_tx 13509 5 raid456,async_raid6_recov,async_memcpy,async_pq,async_xor, Live 0x0000000000000000
xor 21411 1 async_xor, Live 0x0000000000000000
raid6_pq 97812 2 async_raid6_recov,async_pq, Live 0x0000000000000000
raid0 17969 0 - Live 0x0000000000000000
multipath 13145 0 - Live 0x0000000000000000
linear 12894 0 - Live 0x0000000000000000
raid1 40017 6 - Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53122 0 - Live 0x0000000000000000
hid 110572 2 hid_generic,usbhid, Live 0x0000000000000000
uas 27623 0 - Live 0x0000000000000000
usb_storage 67010 1 uas, Live 0x0000000000000000
pata_acpi 13053 0 - Live 0x0000000000000000
radeon 1519343 3 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
ttm 90376 1 radeon, Live 0x0000000000000000
drm_kms_helper 99872 1 radeon, Live 0x0000000000000000
b44 40715 0 - Live 0x0000000000000000
ssb 67356 1 b44, Live 0x0000000000000000
psmouse 118039 0 - Live 0x0000000000000000
drm 318542 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
mii 13981 1 b44, Live 0x0000000000000000
sata_nv 32309 15 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
0000-ffff : PCI Bus #00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0064-0064 : keyboard
  0070-0073 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  03c0-03df : vesafb
  04d0-04d1 : pnp 00:01
  0800-087f : pnp 00:01
  0960-0967 : 0000:00:0f.0
    0960-0967 : sata_nv
  0970-0977 : 0000:00:0e.0
    0970-0977 : sata_nv
  09e0-09e7 : 0000:00:0f.0
    09e0-09e7 : sata_nv
  09f0-09f7 : 0000:00:0e.0
    09f0-09f7 : sata_nv
  0b60-0b63 : 0000:00:0f.0
    0b60-0b63 : sata_nv
  0b70-0b73 : 0000:00:0e.0
    0b70-0b73 : sata_nv
  0be0-0be3 : 0000:00:0f.0
    0be0-0be3 : sata_nv
  0bf0-0bf3 : 0000:00:0e.0
    0bf0-0bf3 : sata_nv
  0cf8-0cff : PCI conf1
  1000-107f : pnp 00:00
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    101c-101c : ACPI PM2_CNT_BLK
    1020-1027 : ACPI GPE0_BLK
  1080-10ff : pnp 00:00
  1400-147f : pnp 00:00
    1440-144f : NV TCO
  1480-14ff : pnp 00:00
    14a0-14af : ACPI GPE1_BLK
  1800-187f : pnp 00:00
  1880-18ff : pnp 00:00
  1c00-1c3f : 0000:00:0a.1
    1c00-1c3f : nForce2_smbus
  1c40-1c7f : 0000:00:0a.1
    1c40-1c7f : nForce2_smbus
  2000-207f : pnp 00:00
  2080-20ff : pnp 00:00
  8000-8fff : PCI Bus 0000:02
  9000-9fff : PCI Bus 0000:04
  a000-afff : PCI Bus 0000:01
  b000-bfff : PCI Bus 0000:03
    bc00-bcff : 0000:03:00.0
  cc00-cc0f : 0000:00:0f.0
    cc00-cc0f : sata_nv
  e000-e00f : 0000:00:0e.0
    e000-e00f : sata_nv

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus #00
000c0000-000cf3ff : Video ROM
000cf400-000cffff : pnp 00:04
000f0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-cfedffff : System RAM
  01000000-017a9977 : Kernel code
  017a9978-01d1e4ff : Kernel data
  01e80000-01fc6fff : Kernel bss
cfee0000-cfee2fff : ACPI Non-volatile Storage
cfee3000-cfeeffff : ACPI Tables
cfef0000-cfefffff : reserved
cff00000-cfffffff : RAM buffer
d0000000-f3ffffff : PCI Bus #00
  d0000000-dfffffff : PCI Bus 0000:03
    d0000000-dfffffff : 0000:03:00.0
  f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f0000000-f3ffffff : reserved
      f0000000-f3ffffff : pnp 00:03
f4000000-ffffffff : PCI Bus #00
  fd800000-fd8fffff : PCI Bus 0000:02
  fd900000-fd9fffff : PCI Bus 0000:01
  fda00000-fdafffff : PCI Bus 0000:01
  fdb00000-fdbfffff : PCI Bus 0000:04
  fdc00000-fdcfffff : PCI Bus 0000:04
    fdcfe000-fdcfffff : 0000:04:07.0
      fdcfe000-fdcfffff : b44
  fdd00000-fddfffff : PCI Bus 0000:03
    fdd00000-fdd1ffff : 0000:03:00.0
    fdde0000-fddeffff : 0000:03:00.0
    fddfc000-fddfffff : 0000:03:00.1
      fddfc000-fddfffff : ICH HD audio
  fde00000-fdefffff : PCI Bus 0000:02
  fe024000-fe027fff : 0000:00:10.1
    fe024000-fe027fff : ICH HD audio
  fe02c000-fe02cfff : 0000:00:0f.0
    fe02c000-fe02cfff : sata_nv
  fe02d000-fe02dfff : 0000:00:0e.0
    fe02d000-fe02dfff : sata_nv
  fe02e000-fe02e0ff : 0000:00:0b.1
    fe02e000-fe02e0ff : ehci_hcd
  fe02f000-fe02ffff : 0000:00:0b.0
    fe02f000-fe02ffff : ohci_hcd
  fec00000-ffffffff : reserved
    fec00000-fec003ff : IOAPIC 0
    fec80000-fecbffff : pnp 00:00
    fee00000-feefffff : pnp 00:04
      fee00000-fee00fff : Local APIC
    fefe0000-fefe01ff : pnp 00:00
    feff0000-feff03ff : HPET 0
    fefff000-feffffff : pnp 00:04
    fff80000-fff80fff : pnp 00:04
    fff90000-fffbffff : pnp 00:04
    fffed000-fffeffff : pnp 00:04
    ffff0000-ffffffff : pnp 00:04
100000000-12fffffff : System RAM
130000000-fcffffffff : PCI Bus #00

[7.5.] PCI information ('lspci -vvv' as root)

$ sudo lspci -vvv
00:00.0 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
        Subsystem: NVIDIA Corporation C51 Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 1: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 1.0GHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 800MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000

00:00.1 RAM memory: NVIDIA Corporation C51 Memory Controller 0 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.2 RAM memory: NVIDIA Corporation C51 Memory Controller 1 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 1
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.3 RAM memory: NVIDIA Corporation C51 Memory Controller 5 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 5
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.4 RAM memory: NVIDIA Corporation C51 Memory Controller 4 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 4
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:00.5 RAM memory: NVIDIA Corporation C51 Host Bridge (rev a2)
        Subsystem: NVIDIA Corporation C51 Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] #00 [00fe]
        Capabilities: [fc] #00 [0000]

00:00.6 RAM memory: NVIDIA Corporation C51 Memory Controller 3 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 3
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.7 RAM memory: NVIDIA Corporation C51 Memory Controller 2 (rev a2)
        Subsystem: NVIDIA Corporation C51 Memory Controller 2
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fda00000-fdafffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fd9fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4161
        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=WRR32
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: pcieport

00:03.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fd800000-fd8fffff
        Prefetchable memory behind bridge: 00000000fde00000-00000000fdefffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4171
        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=WRR32
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: pcieport

00:04.0 PCI bridge: NVIDIA Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fdd00000-fddfffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4181
        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=WRR32
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: pcieport

00:09.0 RAM memory: NVIDIA Corporation MCP51 Host Bridge (rev a2)
        Subsystem: NVIDIA Corporation Device cb84
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=9 UnitCnt=15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping Enable- Fixed-
                Mapping Address Base: 00000000fee00000

00:0a.0 ISA bridge: NVIDIA Corporation MCP51 LPC Bridge (rev a3)
        Subsystem: Dell Device 01ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:0a.1 SMBus: NVIDIA Corporation MCP51 SMBus (rev a3)
        Subsystem: Dell Device 01ed
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 7
        Region 4: I/O ports at 1c00 [size=64]
        Region 5: I/O ports at 1c40 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: nForce2_smbus

00:0a.2 RAM memory: NVIDIA Corporation MCP51 Memory Controller 0 (rev a3)
        Subsystem: Dell Device 01ed
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:0b.0 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: Dell Device 01ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci-pci

00:0b.1 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3) (prog-if 20 [EHCI])
        Subsystem: Dell Device 01ed
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 22
        Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port: BAR=1 offset=0098
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ehci-pci

00:0e.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: Dell Device 01ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 09f0 [size=8]
        Region 1: I/O ports at 0bf0 [size=4]
        Region 2: I/O ports at 0970 [size=8]
        Region 3: I/O ports at 0b70 [size=4]
        Region 4: I/O ports at e000 [size=16]
        Region 5: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: sata_nv

00:0f.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: Dell Device 01ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 09e0 [size=8]
        Region 1: I/O ports at 0be0 [size=4]
        Region 2: I/O ports at 0960 [size=8]
        Region 3: I/O ports at 0b60 [size=4]
        Region 4: I/O ports at cc00 [size=16]
        Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: sata_nv

00:10.0 PCI bridge: NVIDIA Corporation MCP51 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fdc00000-fdcfffff
        Prefetchable memory behind bridge: fdb00000-fdbfffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
        Capabilities: [b8] Subsystem: Device 0000:0000
        Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000

00:10.1 Audio device: NVIDIA Corporation MCP51 High Definition Audio (rev a2)
        Subsystem: Dell Device 01ed
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin B routed to IRQ 23
        Region 0: Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: snd_hda_intel

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Revision ID: 1.02
                Link Frequency: 1.0GHz
                Link Error: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Capabilities: [f0] Secure device <?>
        Kernel driver in use: k8temp

03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] RV710 [Radeon HD 4350/4550] (prog-if 00 [VGA controller])
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1613
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Region 2: Memory at fdde0000 (64-bit, non-prefetchable) [size=64K]
        Region 4: I/O ports at bc00 [size=256]
        [virtual] Expansion ROM at fdd00000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4122
        Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Kernel driver in use: radeon

03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] RV710/730 HDMI Audio [Radeon HD 4000 series]
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device aa38
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 28
        Region 0: Memory at fddfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4142
        Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Kernel driver in use: snd_hda_intel

04:07.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
        Subsystem: Dell Device 01ed
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fdcfe000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Kernel driver in use: b44

[7.6.] SCSI information (from /proc/scsi/scsi)

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3250620AS      Rev: K
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ASUS     Model: BW-12B1ST   a    Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD160JJ/ Rev: 0-34
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: USB   HS-CF Card Rev: 4.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi4 Channel: 00 Id: 00 Lun: 01
  Vendor: TEAC     Model: USB   HS-xD/SM   Rev: 4.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi4 Channel: 00 Id: 00 Lun: 02
  Vendor: TEAC     Model: USB   HS-MS Card Rev: 4.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi4 Channel: 00 Id: 00 Lun: 03
  Vendor: TEAC     Model: USB   HS-SD Card Rev: 4.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3250620AS      Rev: K
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: Ultra HS-SD/MMC  Rev: 1.82
  Type:   Direct-Access                    ANSI  SCSI revision: 00


[7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant):

$ ls /proc
1     12    1279  1325  1371  1535  1684  181   194   203   2282  27    29    2985  31    3242  3341  3427  3486  3531  3540  3549  3592  3742  3823  3950  4023  4781  54   73   acpi       devices      iomem       kpageflags  net           stat           uptime
10    120   1283  133   139   1537  1690  182   1945  2063  23    275   2905  2989  3126  3244  3351  3429  3496  3532  3541  3550  3596  3770  3828  3958  4034  4782  554  730  asound     diskstats    ioports     loadavg     pagetypeinfo  swaps          version
1009  121   1295  1330  14    1596  17    184   195   2082  2350  276   2944  3     3170  3248  3354  3430  35    3533  3542  3552  3597  3784  3839  3969  413   4786  576  74   buddyinfo  dma          irq         locks       partitions    sys            vmallocinfo
1010  1213  1296  134   142   16    171   1847  1969  2083  24    2782  2952  30    3194  3256  3367  3440  3503  3534  3543  3553  3599  3787  3848  3978  4130  4792  580  787  bus        driver       kallsyms    mdstat      sched_debug   sysrq-trigger  vmstat
11    122   1299  1347  1421  1601  172   187   1972  2096  2409  2787  2961  3008  32    3259  3375  3442  3505  3535  3544  3554  36    3790  3886  3982  4132  4795  590  788  cgroups    execdomains  kcore       meminfo     schedstat     sysvipc        zoneinfo
1131  123   13    136   143   1605  174   1873  2     21    2415  28    2962  3028  3209  33    3382  3450  3509  3536  3545  3581  3613  3791  39    3996  4184  493   6    8    cmdline    fb           keys        misc        scsi          thread-self
117   125   130   1364  1499  1607  176   188   20    22    245   2887  2966  3030  3211  3329  3384  3460  3528  3537  3546  3588  37    38    3910  40    4185  5     621  866  consoles   filesystems  key-users   modules     self          timer_list
118   126   132   137   15    164   177   19    201   2241  25    2891  2975  3035  3212  3330  3387  3473  3529  3538  3547  3589  3705  3801  3932  4004  419   52    623  867  cpuinfo    fs           kmsg        mounts      slabinfo      timer_stats
119   127   1322  1370  1502  165   178   190   202   2254  26    2899  2980  3038  3213  3335  34    3475  3530  3539  3548  3591  3733  3805  3940  4013  4193  53    7    9    crypto     interrupts   kpagecount  mtrr        softirqs      tty

[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1326757

