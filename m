From: Jonathan Brier <brierjon@gmail.com>
Subject: PROBLEM: ACPI Warning: SystemIO range conflicts with OpRegion (\_SB_.PCI0.SBRG.ASOC.SMRG)
Date: Tue, 8 Apr 2014 17:47:03 -0400
Message-ID: <CAC64-sa4jcBsLaR=0Cq4e=woBTp+-jNx31rQSuXH+s=DxYbUcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:54207 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbaDHVrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 17:47:25 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so1579900wes.37
        for <linux-acpi@vger.kernel.org>; Tue, 08 Apr 2014 14:47:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

First upstreamed bug report ever, please play nice.

[1.] One line summary of the problem:
ACPI Warning: SystemIO range 0x0000000000000b00-0x0000000000000b07
conflicts with OpRegion 0x0000000000000b00-0x0000000000000b2f
(\_SB_.PCI0.SBRG.ASOC.SMRG) (20131218/utaddress-258)

[2.] Full description of the problem/report:
The ACPI Warning appears in a dmesg output as indicated above.
Expected behavior would be no ACPI Warnings.

Current dmesg warnings - see [ 18.338895]
Warnings appears in the latest mainline kernel of 3.14.0-031400 generic

in dmesg -l err I see: systemd-udevd[408]: Error calling
EVIOCSKEYCODE: Invalid argument


dmesg -l warn shown below
0.000000] ACPI: RSDP 00000000000fbed0 000024 (v02 ACPIAM)
[ 0.000000] ACPI: XSDT 000000009fe90100 00005C (v01 091412 XSDT1501
20120914 MSFT 00000097)
[ 0.000000] ACPI: FACP 000000009fe90290 0000F4 (v03 091412 FACP1501
20120914 MSFT 00000097)
[ 0.000000] ACPI: DSDT 000000009fe90460 00E5F0 (v01 A1595 A1595000
00000000 INTL 20060113)
[ 0.000000] ACPI: FACS 000000009fea8000 000040
[ 0.000000] ACPI: APIC 000000009fe90390 000088 (v01 091412 APIC1501
20120914 MSFT 00000097)
[ 0.000000] ACPI: MCFG 000000009fe90420 00003C (v01 091412 OEMMCFG
20120914 MSFT 00000097)
[ 0.000000] ACPI: OEMB 000000009fea8040 000072 (v01 091412 OEMB1501
20120914 MSFT 00000097)
[ 0.000000] ACPI: SRAT 000000009fe9f8b0 000108 (v01 AMD FAM_F_10
00000002 AMD 00000001)
[ 0.000000] ACPI: HPET 000000009fe9f9c0 000038 (v01 091412 OEMHPET
20120914 MSFT 00000097)
[ 0.000000] ACPI: SSDT 000000009fe9fa00 000DA4 (v01 A M I POWERNOW
00000001 AMD 00000001)
[ 0.000000] Zone ranges:
[ 0.000000] DMA [mem 0x00001000-0x00ffffff]
[ 0.000000] DMA32 [mem 0x01000000-0xffffffff]
[ 0.000000] Normal [mem 0x100000000-0x45fffffff]
[ 0.000000] Movable zone start for each node
[ 0.000000] Early memory node ranges
[ 0.000000] node 0: [mem 0x00001000-0x0009dfff]
[ 0.000000] node 0: [mem 0x00100000-0x9fe8ffff]
[ 0.000000] node 0: [mem 0x100000000-0x45fffffff]
[ 0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 4128285
[ 0.000000] Policy zone: Normal
[ 0.000000] Memory: 16206768K/16775348K available (7325K kernel code,
1138K rwdata, 3384K rodata, 1336K init, 1440K bss, 568580K reserved)
[ 0.010249] ACPI: All ACPI Tables successfully acquired
[ 0.335385] mtrr: your CPUs had inconsistent variable MTRR settings
[ 0.338258] ACPI: Executed 3 blocks of module-level executable AML code
[ 0.648321] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S2_] (20131115/hwxface-580)
[ 2.505743] pci 0000:00:12.2: EHCI: BIOS handoff failed (BIOS bug?) 01010001
[ 4.610272] pci 0000:00:16.2: EHCI: BIOS handoff failed (BIOS bug?) 01010001
[ 4.953285] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[ 5.502964] ata7.00: limited to UDMA/33 due to 40-wire cable
[ 5.502965] ata7.01: limited to UDMA/33 due to 40-wire cable
[ 5.826683] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw
xa/form2 cdda tray
[ 18.287741] hda-intel 0000:00:14.2: Using LPIB position fix
[ 18.300590] hda-intel 0000:00:14.2: Enable sync_write for stable communication
[ 18.317359] autoconfig: line_outs=4 (0x24/0x25/0x26/0x27/0x0) type:line
[ 18.317362] speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[ 18.317364] hp_outs=1 (0x28/0x0/0x0/0x0/0x0)
[ 18.317365] mono: mono_out=0x0
[ 18.317366] dig-out=0x2d/0x2e
[ 18.317367] inputs:
[ 18.317368] Front Mic=0x29
[ 18.317370] Rear Mic=0x2b
[ 18.317371] Line=0x2a
[ 18.338895] ACPI Warning: 0x0000000000000b00-0x0000000000000b07
SystemIO conflicts with Region \_SB_.PCI0.SBRG.ASOC.SMRG 1
(20131115/utaddress-251)
[ 18.340408] hda-intel 0000:0c:00.1: Using LPIB position fix
[ 18.342760] hda-intel 0000:0c:00.1: Enable sync_write for stable communication
[ 18.346421] hda-intel 0000:05:00.1: Using LPIB position fix
[ 18.348790] hda-intel 0000:05:00.1: Enable sync_write for stable communication
[ 18.741953] init: failsafe main process (955) killed by TERM signal
[ 18.790867] init: avahi-cups-reload main process (1048) terminated
with status 1
[ 18.848501] init: samba-ad-dc main process (1064) terminated with status 1
[ 34.480629] init: plymouth-stop pre-start process (2756) terminated
with status 1

Issue appears in mainline, but also reported to Launchpad - escallated
bug upstream as it also appears in the mainline kernel 3.14:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1301049

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):

Linux version 3.14.0-031400-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201403310035 SMP Mon Mar 31 04:36:23
UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment

Description: Ubuntu Trusty Tahr (development branch)
Release: 14.04

[7.1.] Software (add the output of the ver_linux script here)

Linux computername 3.14.0-031400-generic #201403310035 SMP Mon Mar 31
04:36:23 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         dm_crypt rfcomm bnep bluetooth 6lowpan_iphc
binfmt_misc uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core
kvm_amd videodev snd_usb_audio joydev kvm snd_usbmidi_lib xpad
snd_hda_codec_via snd_hda_codec_generic snd_hda_codec_hdmi microcode
snd_hda_intel psmouse snd_hda_codec edac_core serio_raw edac_mce_amd
snd_hwdep snd_seq_midi k10temp snd_seq_midi_event snd_pcm snd_rawmidi
sp5100_tco i2c_piix4 snd_seq snd_seq_device snd_timer snd soundcore
asus_atk0110 lp mac_hid parport hid_logitech ff_memless hid_generic
usbhid hid pata_acpi radeon pata_atiixp i2c_algo_bit sky2 ttm ahci
drm_kms_helper libahci pata_jmicron drm wmi

[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 0
cpu cores : 6
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor : 1
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 1
cpu cores : 6
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor : 2
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 2
cpu cores : 6
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor : 3
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 3
cpu cores : 6
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor : 4
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 4
cpu cores : 6
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor : 5
vendor_id : AuthenticAMD
cpu family : 16
model : 10
model name : AMD Phenom(tm) II X6 1090T Processor
stepping : 0
microcode : 0x10000dc
cpu MHz : 3200.000
cache size : 512 KB
physical id : 0
siblings : 6
core id : 5
cpu cores : 6
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 6
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips : 6421.67
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

[7.3.] Module information (from /proc/modules):

dm_crypt 23456 0 - Live 0x0000000000000000
rfcomm 74734 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
bluetooth 426845 10 rfcomm,bnep, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 45465 1 uvcvideo, Live 0x0000000000000000
kvm_amd 64722 0 - Live 0x0000000000000000
videodev 149340 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
snd_usb_audio 156384 1 - Live 0x0000000000000000
joydev 17575 1 - Live 0x0000000000000000
kvm 471679 1 kvm_amd, Live 0x0000000000000000
snd_usbmidi_lib 29576 1 snd_usb_audio, Live 0x0000000000000000
xpad 18546 0 - Live 0x0000000000000000
snd_hda_codec_via 32006 1 - Live 0x0000000000000000
snd_hda_codec_generic 69424 1 snd_hda_codec_via, Live 0x0000000000000000
snd_hda_codec_hdmi 47124 2 - Live 0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd_hda_intel 57222 7 - Live 0x0000000000000000
psmouse 108839 0 - Live 0x0000000000000000
snd_hda_codec 142651 4
snd_hda_codec_via,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,
Live 0x0000000000000000
edac_core 62944 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
edac_mce_amd 22792 0 - Live 0x0000000000000000
snd_hwdep 13613 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
k10temp 13173 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_pcm 108860 4
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_rawmidi 30465 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
sp5100_tco 14114 0 - Live 0x0000000000000000
i2c_piix4 22299 0 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 73979 30 snd_usb_audio,snd_usbmidi_lib,snd_hda_codec_via,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_seq_midi,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
asus_atk0110 19210 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
parport 42481 1 lp, Live 0x0000000000000000
hid_logitech 26802 0 - Live 0x0000000000000000
ff_memless 13704 2 xpad,hid_logitech, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 2 - Live 0x0000000000000000
hid 106254 3 hid_logitech,hid_generic,usbhid, Live 0x0000000000000000
pata_acpi 13038 0 - Live 0x0000000000000000
radeon 1576014 6 - Live 0x0000000000000000
pata_atiixp 13271 1 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
sky2 63205 0 - Live 0x0000000000000000
ttm 90127 1 radeon, Live 0x0000000000000000
ahci 30066 4 - Live 0x0000000000000000
drm_kms_helper 53224 1 radeon, Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
pata_jmicron 12758 0 - Live 0x0000000000000000
drm 308197 8 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
wmi 19363 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
  0170-0177 : 0000:00:14.1
    0170-0177 : pata_atiixp
  01f0-01f7 : 0000:00:14.1
    01f0-01f7 : pata_atiixp
  0230-023f : pnp 00:09
  0290-029f : pnp 00:09
  0376-0376 : 0000:00:14.1
    0376-0376 : pata_atiixp
  03c0-03df : vesafb
  03f6-03f6 : 0000:00:14.1
    03f6-03f6 : pata_atiixp
  040b-040b : pnp 00:08
  04d0-04d1 : pnp 00:08
  04d6-04d6 : pnp 00:08
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0820-0827 : ACPI GPE0_BLK
  08ff-08ff : ACPI PM2_CNT_BLK
  0900-090f : pnp 00:08
  0910-091f : pnp 00:08
  0a30-0a3f : pnp 00:09
  0b00-0b1f : pnp 00:08
  0b20-0b3f : pnp 00:08
  0c00-0c01 : pnp 00:08
  0c14-0c14 : pnp 00:08
  0c50-0c51 : pnp 00:08
  0c52-0c52 : pnp 00:08
  0c6c-0c6c : pnp 00:08
  0c6f-0c6f : pnp 00:08
  0cd0-0cd1 : pnp 00:08
  0cd2-0cd3 : pnp 00:08
  0cd4-0cd5 : pnp 00:08
  0cd6-0cd7 : pnp 00:08
    0cd6-0cd7 : SB800 TCO
  0cd8-0cdf : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  0f40-0f4f : pnp 00:09
  4000-400f : 0000:00:11.0
    4000-400f : ahci
  5000-5003 : 0000:00:11.0
    5000-5003 : ahci
  6000-6007 : 0000:00:11.0
    6000-6007 : ahci
  7000-7003 : 0000:00:11.0
    7000-7003 : ahci
  8000-8007 : 0000:00:11.0
    8000-8007 : ahci
  9000-afff : PCI Bus 0000:02
    9000-afff : PCI Bus 0000:03
      9000-9fff : PCI Bus 0000:04
        9000-90ff : 0000:04:00.0
      a000-afff : PCI Bus 0000:05
        a000-a0ff : 0000:05:00.0
  b000-bfff : PCI Bus 0000:07
    b800-b8ff : 0000:07:00.0
      b800-b8ff : sky2
  c000-cfff : PCI Bus 0000:08
    c400-c40f : 0000:08:00.1
      c400-c40f : pata_jmicron
    c480-c483 : 0000:08:00.1
      c480-c483 : pata_jmicron
    c800-c807 : 0000:08:00.1
      c800-c807 : pata_jmicron
    c880-c883 : 0000:08:00.1
      c880-c883 : pata_jmicron
    cc00-cc07 : 0000:08:00.1
      cc00-cc07 : pata_jmicron
  d000-efff : PCI Bus 0000:09
    d000-efff : PCI Bus 0000:0a
      d000-dfff : PCI Bus 0000:0b
        d000-d0ff : 0000:0b:00.0
      e000-efff : PCI Bus 0000:0c
        e000-e0ff : 0000:0c:00.0
  fe00-fefe : pnp 00:08
  ff00-ff0f : 0000:00:14.1
    ff00-ff0f : pata_atiixp

00000000-00000fff : reserved
00001000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
000e4000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-9fe8ffff : System RAM
  01000000-01776905 : Kernel code
  01776906-01d1577f : Kernel data
  01e72000-01fd7fff : Kernel bss
  2c000000-33ffffff : Crash kernel
9fe90000-9fea7fff : ACPI Tables
9fea8000-9fecffff : ACPI Non-volatile Storage
9fed0000-9fefffff : reserved
9ff00000-dfffffff : PCI Bus 0000:00
  9ff00000-9fffffff : pnp 00:08
  a0000000-bfffffff : PCI Bus 0000:02
    a0000000-bfffffff : PCI Bus 0000:03
      a0000000-afffffff : PCI Bus 0000:04
        a0000000-afffffff : 0000:04:00.0
      b0000000-bfffffff : PCI Bus 0000:05
        b0000000-bfffffff : 0000:05:00.0
  c0000000-dfffffff : PCI Bus 0000:09
    c0000000-dfffffff : PCI Bus 0000:0a
      c0000000-cfffffff : PCI Bus 0000:0b
        c0000000-cfffffff : 0000:0b:00.0
      d0000000-dfffffff : PCI Bus 0000:0c
        d0000000-dfffffff : 0000:0c:00.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : pnp 00:0a
f0000000-febfffff : PCI Bus 0000:00
  f6000000-f6003fff : amd_iommu
  fe0f7000-fe0f7fff : 0000:00:12.0
    fe0f7000-fe0f7fff : ohci_hcd
  fe0f8000-fe0fbfff : 0000:00:14.2
    fe0f8000-fe0fbfff : ICH HD audio
  fe0fc000-fe0fcfff : 0000:00:13.0
    fe0fc000-fe0fcfff : ohci_hcd
  fe0fd000-fe0fdfff : 0000:00:14.5
    fe0fd000-fe0fdfff : ohci_hcd
  fe0fe000-fe0fe3ff : 0000:00:11.0
    fe0fe000-fe0fe3ff : ahci
  fe0fe400-fe0fe4ff : 0000:00:12.2
    fe0fe400-fe0fe4ff : ehci_hcd
  fe0fe800-fe0fe8ff : 0000:00:13.2
    fe0fe800-fe0fe8ff : ehci_hcd
  fe0fec00-fe0fecff : 0000:00:16.2
    fe0fec00-fe0fecff : ehci_hcd
  fe0ff000-fe0fffff : 0000:00:16.0
    fe0ff000-fe0fffff : ohci_hcd
  fe100000-fe3fffff : PCI Bus 0000:02
    fe1e0000-fe1fffff : 0000:02:00.0
    fe200000-fe3fffff : PCI Bus 0000:03
      fe200000-fe2fffff : PCI Bus 0000:04
        fe2c0000-fe2dffff : 0000:04:00.0
        fe2e0000-fe2fffff : 0000:04:00.0
      fe300000-fe3fffff : PCI Bus 0000:05
        fe3bc000-fe3bffff : 0000:05:00.1
          fe3bc000-fe3bffff : ICH HD audio
        fe3c0000-fe3dffff : 0000:05:00.0
        fe3e0000-fe3fffff : 0000:05:00.0
  fe400000-fe4fffff : PCI Bus 0000:06
    fe4fe000-fe4fffff : 0000:06:00.0
      fe4fe000-fe4fffff : xhci_hcd
  fe500000-fe5fffff : PCI Bus 0000:07
    fe5c0000-fe5dffff : 0000:07:00.0
    fe5fc000-fe5fffff : 0000:07:00.0
      fe5fc000-fe5fffff : sky2
  fe600000-fe6fffff : PCI Bus 0000:08
    fe6fe000-fe6fffff : 0000:08:00.0
      fe6fe000-fe6fffff : ahci
  fe700000-fe9fffff : PCI Bus 0000:09
    fe7e0000-fe7fffff : 0000:09:00.0
    fe800000-fe9fffff : PCI Bus 0000:0a
      fe800000-fe8fffff : PCI Bus 0000:0b
        fe8c0000-fe8dffff : 0000:0b:00.0
        fe8e0000-fe8fffff : 0000:0b:00.0
      fe900000-fe9fffff : PCI Bus 0000:0c
        fe9bc000-fe9bffff : 0000:0c:00.1
          fe9bc000-fe9bffff : ICH HD audio
        fe9c0000-fe9dffff : 0000:0c:00.0
        fe9e0000-fe9fffff : 0000:0c:00.0
fec00000-fec003ff : IOAPIC 0
fec10000-fec1001f : pnp 00:08
fec20000-fec203ff : IOAPIC 1
fed00000-fed003ff : HPET 2
fed80000-fed80fff : pnp 00:08
  fed80b00-fed80b07 : SB800 TCO
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : pnp 00:07
ffb80000-ffbfffff : pnp 00:08
ffe00000-ffffffff : reserved
100000000-45fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
Northbridge only single slot PCI-e GFX Hydra part (rev 02)
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge
only single slot PCI-e GFX Hydra part
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Capabilities: [f0] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [c4] HyperTransport: Slave or Primary Interface
Command: BaseUnitID=0 UnitCnt=20 MastHost- DefDir- DUL-
Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
IsocEn- LSEn- ExtCTL- 64b-
Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit
DwFcInEn- LWO=16bit DwFcOutEn-
Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
IsocEn- LSEn- ExtCTL- 64b-
Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn-
LWO=8bit DwFcOutEn-
Revision ID: 3.00
Link Frequency 0: [b]
Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+
800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
Link Frequency 1: 200MHz
Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz-
800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF-
RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
Prefetchable memory behind bridge Upper: 00-00
Bus Number: 00
Capabilities: [40] HyperTransport: Retry Mode
Capabilities: [54] HyperTransport: UnitID Clumping
Capabilities: [9c] HyperTransport: #1a
Capabilities: [70] MSI: Enable- Count=1/4 Maskable- 64bit-
Address: 00000000  Data: 0000

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory
Management Unit (IOMMU)
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory
Management Unit (IOMMU)
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 72
Capabilities: [40] Secure device <?>
Capabilities: [54] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 4191
Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (PCI express gpp port B) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=09, subordinate=0c, sec-latency=0
I/O behind bridge: 0000d000-0000efff
Memory behind bridge: fe700000-fe9fffff
Prefetchable memory behind bridge: 00000000c0000000-00000000dfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #18, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee3f00c  Data: 41b1
Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a11
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [190 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Kernel driver in use: pcieport

00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (PCI express gpp port D) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
I/O behind bridge: 0000c000-0000cfff
Memory behind bridge: fe600000-fe6fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #20, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee3f00c  Data: 41c1
Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a11
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [190 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Kernel driver in use: pcieport

00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (PCI express gpp port F) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
I/O behind bridge: 0000b000-0000bfff
Memory behind bridge: fe500000-fe5fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #22, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee3f00c  Data: 41d1
Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a11
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [190 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Kernel driver in use: pcieport

00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (PCI express gpp port G) (prog-if 00 [Normal decode])
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fe400000-fe4fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #23, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee3f00c  Data: 41e1
Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a11
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [190 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Kernel driver in use: pcieport

00:0b.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
to PCI bridge (NB-SB link) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
I/O behind bridge: 00009000-0000afff
Memory behind bridge: fe100000-fe3fffff
Prefetchable memory behind bridge: 00000000a0000000-00000000bfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #27, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee3f00c  Data: 4142
Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a11
Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [190 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Kernel driver in use: pcieport

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode] (rev 40) (prog-if 01
[AHCI 1.0])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
SATA Controller [IDE mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 91
Region 0: I/O ports at 8000 [size=8]
Region 1: I/O ports at 7000 [size=4]
Region 2: I/O ports at 6000 [size=8]
Region 3: I/O ports at 5000 [size=4]
Region 4: I/O ports at 4000 [size=16]
Region 5: Memory at fe0fe000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
Address: 00000000fee0800c  Data: 41a3
Capabilities: [70] SATA HBA v1.0 InCfgSpace
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB OHCI0 Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at fe0f7000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB EHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at fe0fe400 (32-bit, non-prefetchable) [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Bridge: PM- B3+
Capabilities: [e4] Debug port: BAR=1 offset=00e0
Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB OHCI0 Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at fe0fc000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB EHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at fe0fe800 (32-bit, non-prefetchable) [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Bridge: PM- B3+
Capabilities: [e4] Debug port: BAR=1 offset=00e0
Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus
Controller (rev 41)
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 IDE Controller (rev 40) (prog-if 8a [Master SecP
PriP])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
IDE Controller
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin B routed to IRQ 17
Region 0: I/O ports at 01f0 [size=8]
Region 1: I/O ports at 03f4
Region 2: I/O ports at 0170 [size=8]
Region 3: I/O ports at 0374
Region 4: I/O ports at ff00 [size=16]
Kernel driver in use: pata_atiixp

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
Azalia (Intel HDA) (rev 40)
Subsystem: ASUSTeK Computer Inc. M4A89GTD PRO/USB3 Motherboard
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at fe0f8000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
LPC host controller
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI
to PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: fff00000-000fffff
Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB OHCI2 Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin C routed to IRQ 18
Region 0: Memory at fe0fd000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB OHCI0 Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at fe0ff000 (32-bit, non-prefetchable) [size=4K]
Kernel driver in use: ohci-pci

00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0
USB EHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Region 0: Memory at fe0fec00 (32-bit, non-prefetchable) [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Bridge: PM- B3+
Capabilities: [e4] Debug port: BAR=1 offset=00e0
Kernel driver in use: ehci-pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
Processor HyperTransport Configuration
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
Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
Processor Address Map
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
Processor DRAM Controller
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
Processor Miscellaneous Control
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: [f0] Secure device <?>
Kernel driver in use: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
Processor Link Control
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

02:00.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Region 0: Memory at fe1e0000 (32-bit, non-prefetchable) [size=128K]
Bus: primary=02, secondary=03, subordinate=05, sec-latency=0
I/O behind bridge: 00009000-0000afff
Memory behind bridge: fe200000-fe3fffff
Prefetchable memory behind bridge: 00000000a0000000-00000000bfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 41a2
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Upstream Port, MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [448 v1] Vendor Specific Information: ID=0099 Rev=1 Len=fff <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

03:04.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=03, secondary=05, subordinate=05, sec-latency=0
I/O behind bridge: 0000a000-0000afff
Memory behind bridge: fe300000-fe3fffff
Prefetchable memory behind bridge: 00000000b0000000-00000000bfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 41b2
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Downstream Port (Slot-), MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise+ LLActRep+ BwNot+
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt+ ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [520 v1] Vendor Specific Information: ID=0019 Rev=1 Len=001 <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

03:08.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: 00009000-00009fff
Memory behind bridge: fe200000-fe2fffff
Prefetchable memory behind bridge: 00000000a0000000-00000000afffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 41c2
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Downstream Port (Slot-), MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #8, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise+ LLActRep+ BwNot+
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt+ ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [520 v1] Vendor Specific Information: ID=0019 Rev=1 Len=001 <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

04:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Hemlock [Radeon HD 5970]
Subsystem: XFX Pine Group Inc. Device 3020
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 96
Region 0: Memory at a0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at fe2e0000 (64-bit, non-prefetchable) [size=128K]
Region 4: I/O ports at 9000 [size=256]
Expansion ROM at fe2c0000 [disabled] [size=128K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #8, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 4154
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: radeon

05:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Hemlock [Radeon HD 5970] (prog-if 00 [VGA controller])
Subsystem: XFX Pine Group Inc. Device 3020
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 95
Region 0: Memory at b0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at fe3e0000 (64-bit, non-prefetchable) [size=128K]
Region 4: I/O ports at a000 [size=256]
Expansion ROM at fe3c0000 [disabled] [size=128K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 4144
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: radeon

05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cypress
HDMI Audio [Radeon HD 5800 Series]
Subsystem: XFX Pine Group Inc. Device aa50
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 98
Region 0: Memory at fe3bc000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 41a4
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: snd_hda_intel

06:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 03) (prog-if 30 [XHCI])
Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 50
Region 0: Memory at fe4fe000 (64-bit, non-prefetchable) [size=8K]
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
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<4us, L1 unlimited
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
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

07:00.0 Ethernet controller: Marvell Technology Group Ltd. Yukon
Optima 88E8059 [PCIe Gigabit Ethernet Controller with AVB] (rev 11)
Subsystem: ASUSTeK Computer Inc. Device 8439
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 92
Region 0: Memory at fe5fc000 (64-bit, non-prefetchable) [size=16K]
Region 2: I/O ports at b800 [size=256]
Expansion ROM at fe5c0000 [disabled] [size=128K]
Capabilities: [48] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [5c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0800c  Data: 41c3
Capabilities: [c0] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <1us, L1 <32us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [130 v1] Device Serial Number a8-2d-10-ff-ff-30-cf-20
Kernel driver in use: sky2

08:00.0 SATA controller: JMicron Technology Corp. JMB363 SATA/IDE
Controller (rev 03) (prog-if 01 [AHCI 1.0])
Subsystem: ASUSTeK Computer Inc. P5B [JMB363]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 44
Region 5: Memory at fe6fe000 (32-bit, non-prefetchable) [size=8K]
Capabilities: [68] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s
unlimited, L1 unlimited
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Kernel driver in use: ahci

08:00.1 IDE interface: JMicron Technology Corp. JMB363 SATA/IDE
Controller (rev 03) (prog-if 85 [Master SecO PriO])
Subsystem: ASUSTeK Computer Inc. P5B [JMB363]
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 45
Region 0: I/O ports at cc00 [size=8]
Region 1: I/O ports at c880 [size=4]
Region 2: I/O ports at c800 [size=8]
Region 3: I/O ports at c480 [size=4]
Region 4: I/O ports at c400 [size=16]
Capabilities: [68] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pata_jmicron

09:00.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Region 0: Memory at fe7e0000 (32-bit, non-prefetchable) [size=128K]
Bus: primary=09, secondary=0a, subordinate=0c, sec-latency=0
I/O behind bridge: 0000d000-0000efff
Memory behind bridge: fe800000-fe9fffff
Prefetchable memory behind bridge: 00000000c0000000-00000000dfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 4162
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Upstream Port, MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [448 v1] Vendor Specific Information: ID=0099 Rev=1 Len=fff <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

0a:04.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=0a, secondary=0c, subordinate=0c, sec-latency=0
I/O behind bridge: 0000e000-0000efff
Memory behind bridge: fe900000-fe9fffff
Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 4172
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Downstream Port (Slot-), MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise+ LLActRep+ BwNot+
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt+ ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [520 v1] Vendor Specific Information: ID=0019 Rev=1 Len=001 <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

0a:08.0 PCI bridge: PLX Technology, Inc. PEX 8647 48-Lane, 3-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev bb) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=0a, secondary=0b, subordinate=0b, sec-latency=0
I/O behind bridge: 0000d000-0000dfff
Memory behind bridge: fe800000-fe8fffff
Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
Address: 00000000fee3f00c  Data: 4182
Masking: 0000000f  Pending: 00000000
Capabilities: [68] Express (v2) Downstream Port (Slot-), MSI 00
DevCap: MaxPayload 2048 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #8, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<1us, L1 <2us
ClockPM- Surprise+ LLActRep+ BwNot+
LnkCtl: ASPM Disabled; Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt+ ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8647 48-Lane,
3-Port PCI Express Gen 2 (5.0 GT/s) Switch
Capabilities: [100 v1] Vendor Specific Information: ID=0098 Rev=1 Len=fff <?>
Capabilities: [fb4 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [520 v1] Vendor Specific Information: ID=0019 Rev=1 Len=001 <?>
Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
Kernel driver in use: pcieport

0b:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Hemlock [Radeon HD 5970]
Subsystem: XFX Pine Group Inc. Device 3020
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 94
Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at fe8e0000 (64-bit, non-prefetchable) [size=128K]
Region 4: I/O ports at d000 [size=256]
Expansion ROM at fe8c0000 [disabled] [size=128K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #8, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 4124
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: radeon

0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Hemlock [Radeon HD 5970] (prog-if 00 [VGA controller])
Subsystem: XFX Pine Group Inc. Device 3020
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 93
Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]
Region 4: I/O ports at e000 [size=256]
Expansion ROM at fe9c0000 [disabled] [size=128K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 41e3
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: radeon

0c:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cypress
HDMI Audio [Radeon HD 5800 Series]
Subsystem: XFX Pine Group Inc. Device aa50
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 97
Region 0: Memory at fe9bc000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee3f00c  Data: 4184
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: snd_hda_intel

[7.6.] SCSI information (from /proc/scsi/scsi)

Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST32000641AS     Rev: CC13
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST33000651AS     Rev: CC45
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST32000641AS     Rev: CC13
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST32000641AS     Rev: CC13
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: C300-CTFDDAC128M Rev: 0007
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 01 Lun: 00
  Vendor: SAMSUNG  Model: DVDWBD SH-B083L  Rev: SB00
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

1     11    1310  160  178   21    245   2768  3218  33    3377  3498
3679  388   40    4195  4377  49    57   66   82   acpi         fb
        loadavg       self           vmstat
10    116   1323  161  179   2197  25    28    3223  3304  3382  35
3693  3889  4007  42    44    5     572  67   822  asound
filesystems    locks         slabinfo       zoneinfo
1006  1180  1335  162  18    22    2532  280   3231  3309  34    3503
37    39    4012  4206  4405  50    575  672  83   buddyinfo    fs
        mdstat        softirqs
1016  1182  1346  163  180   2212  2540  2800  3237  3315  3400  3551
3705  3907  4025  4218  4412  51    58   675  837  bus
interrupts     meminfo       stat
1018  12    1349  164  184   2217  2575  29    3247  3317  3415  3569
3711  3912  4035  4235  4427  52    585  68   843  cgroups      iomem
        misc          swaps
1019  1228  1373  166  185   2221  26    2983  3266  3323  3420  3573
3718  3919  4051  4247  4458  5299  59   69   849  cmdline
ioports        modules       sys
1027  1232  14    167  186   2223  2653  3     3269  3327  3432  3575
3719  3921  4064  4257  4466  53    60   7    85   consoles     irq
        mounts        sysrq-trigger
1035  1239  1420  168  187   2226  2656  30    3270  3352  3448  3579
376   3922  4088  4263  45    54    61   70   856  cpuinfo
kallsyms       mtrr          sysvipc
1039  1240  1451  169  19    2235  2657  3004  3272  3362  3467  36
3788  3926  41    4281  4597  55    626  738  857  crypto       kcore
        net           timer_list
1046  1244  15    17   190   2271  2658  3088  3277  3366  3478  3625
3789  3927  4120  4286  46    56    63   745  86   devices
key-users      pagetypeinfo  timer_stats
1047  1279  1507  170  191   23    27    31    3278  3367  3481  3642
3798  3971  4160  43    47    560   634  777  87   diskstats    kmsg
        partitions    tty
1048  1295  1552  171  2     2349  2714  3139  3286  3369  3484  3661
38    3977  4173  4305  48    5650  64   778  9    dma
kpagecount     sched_debug   uptime
106   1296  1571  172  20    24    2719  3144  3289  3370  3486  3666
3873  3987  4178  4310  4820  568   65   8    901  driver
kpageflags     schedstat     version
107   13    16    177  2030  244   2720  32    3293  3375  3494  3673
3879  3997  4188  4360  4882  569   653  802  937  execdomains
latency_stats  scsi          vmallocinfo

[X.] Other notes, patches, fixes, workarounds:
