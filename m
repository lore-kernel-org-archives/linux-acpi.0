From: Adam <adamdd55@gmail.com>
Subject: Problem: [Samsung NP530U4E-K02PL] Cannot change backlight
Date: Sun, 6 Dec 2015 13:37:48 +0000
Message-ID: <CAHb7-Qo4Zzv4P97U20_yXAS3W2nR1ANcvUQEjoRNDMZupHCwfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34987 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbLFNhv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2015 08:37:51 -0500
Received: by lblw10 with SMTP id w10so4628672lbl.2
        for <linux-acpi@vger.kernel.org>; Sun, 06 Dec 2015 05:37:49 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:

[Samsung NP530U4E-K02PL] Cannot change backlight

[2.] Full description of the problem/report:

It is not possible to change screen backlight. A workaround is to add
a flag acpi_osi=

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):

Linux version 4.4.0-040400rc3-generic (kernel@gloin) (gcc version
5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201511300321 SMP Mon Nov 30
03:23:36 UTC 2015

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment

Description:    Ubuntu 15.10

Release:        15.10

[7.1.] Software (add the output of the ver_linux script here)

Linux ab-530U4E-540U4E 4.4.0-040400rc3-generic #201511300321 SMP Mon
Nov 30 03:23:36 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


GNU C                   5.2.1

GNU Make                4.0

Binutils                2.25.1

Util-linux              2.26.2

Mount                   2.26.2

Module-init-tools       21

E2fsprogs               1.42.12

Jfsutils                1.1.15

Reiserfsprogs           3.6.24

Xfsprogs                3.2.1

Pcmciautils             018

PPP                     2.4.6

Linux C Library         2.21

Dynamic linker (ldd)    2.21

Linux C++ Library       6.0.21

Procps                  3.3.9

Net-tools               1.60

Kbd                     1.15.5

Console-tools           1.15.5

Sh-utils                8.23

Udev                    225

Wireless-tools          30

Modules Loaded          ablk_helper acpi_als aesni_intel aes_x86_64
ahci ansi_cprng arc4 autofs4 bluetooth bnep btbcm btintel btrtl btusb
ccm cfg80211 coretemp crc32_pc
lmul crct10dif_pclmul cryptd ctr cuse drbg drm drm_kms_helper
fb_sys_fops fjes gf128mul glue_helper hid hid_logitech_dj
hid_logitech_hidpp i2c_algo_bit i915 industriali
o input_leds intel_powerclamp intel_rapl iosf_mbi irqbypass iwldvm
iwlwifi joydev kfifo_buf kvm kvm_intel libahci lp lpc_ich lrw mac80211
mac_hid media mei mei_me memst
ick mii nls_iso8859_1 parport parport_pc ppdev psmouse r8169 rfcomm
rtsx_usb rtsx_usb_ms rtsx_usb_sdmmc serio_raw shpchp snd snd_hda_codec
snd_hda_codec_generic snd_hda
_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep
snd_pcm snd_rawmidi snd_seq snd_seq_device snd_seq_midi
snd_seq_midi_event snd_timer soundcore sy
scopyarea sysfillrect sysimgblt tpm_infineon usbhid uvcvideo
v4l2_common video videobuf2_core videobuf2_memops videobuf2_v4l2
videobuf2_vmalloc videodev wmi x86_pkg_tem
p_thermal

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0

vendor_id       : GenuineIntel

cpu family      : 6

model           : 58

model name      : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz

stepping        : 9

microcode       : 0x1b

cpu MHz         : 973.617

cache size      : 3072 KB

physical id     : 0

siblings        : 4

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
syscall nx rdtscp lm constant_
tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_
2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms xsaveopt

bugs            :

bogomips        : 3591.94

clflush size    : 64

cache_alignment : 64

address sizes   : 36 bits physical, 48 bits virtual

power management:



processor       : 1

vendor_id       : GenuineIntel

cpu family      : 6

model           : 58

model name      : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz

stepping        : 9

microcode       : 0x1b

cpu MHz         : 799.945

cache size      : 3072 KB

physical id     : 0

siblings        : 4

core id         : 1

cpu cores       : 2

apicid          : 2

initial apicid  : 2

fpu             : yes

fpu_exception   : yes

cpuid level     : 13

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_
tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_
2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms xsaveopt

bugs            :

bogomips        : 3591.94

clflush size    : 64

cache_alignment : 64

address sizes   : 36 bits physical, 48 bits virtual

power management:



processor       : 2

vendor_id       : GenuineIntel

cpu family      : 6

model           : 58

model name      : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz

stepping        : 9

microcode       : 0x1b

cpu MHz         : 806.132

cache size      : 3072 KB

physical id     : 0

siblings        : 4

core id         : 0

cpu cores       : 2

apicid          : 1

initial apicid  : 1

fpu             : yes

fpu_exception   : yes

cpuid level     : 13

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_
tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_
2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms xsaveopt

bugs            :

bogomips        : 3591.94

clflush size    : 64

cache_alignment : 64

address sizes   : 36 bits physical, 48 bits virtual

power management:



processor       : 3

vendor_id       : GenuineIntel

cpu family      : 6

model           : 58

model name      : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz

stepping        : 9

microcode       : 0x1b

cpu MHz         : 800.226

cache size      : 3072 KB

physical id     : 0

siblings        : 4

core id         : 1

cpu cores       : 2

apicid          : 3

initial apicid  : 3

fpu             : yes

fpu_exception   : yes

cpuid level     : 13

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_
tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_
2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms xsaveopt

bugs            :

bogomips        : 3591.94

clflush size    : 64

cache_alignment : 64

address sizes   : 36 bits physical, 48 bits virtual

power management:


[7.3.] Module information (from /proc/modules):

ctr 16384 1 - Live 0x0000000000000000

ccm 20480 1 - Live 0x0000000000000000

rfcomm 69632 2 - Live 0x0000000000000000

drbg 32768 1 - Live 0x0000000000000000

ansi_cprng 16384 0 - Live 0x0000000000000000

bnep 20480 2 - Live 0x0000000000000000

rtsx_usb_ms 20480 0 - Live 0x0000000000000000

memstick 20480 1 rtsx_usb_ms, Live 0x0000000000000000

nls_iso8859_1 16384 1 - Live 0x0000000000000000

intel_rapl 20480 0 - Live 0x0000000000000000

iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000

x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000

intel_powerclamp 16384 0 - Live 0x0000000000000000

coretemp 16384 0 - Live 0x0000000000000000

kvm_intel 167936 0 - Live 0x0000000000000000

snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000

kvm 532480 1 kvm_intel, Live 0x0000000000000000

irqbypass 16384 1 kvm, Live 0x0000000000000000

snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000

snd_hda_codec_generic 77824 1 snd_hda_codec_realtek, Live 0x0000000000000000

crct10dif_pclmul 16384 0 - Live 0x0000000000000000

crc32_pclmul 16384 0 - Live 0x0000000000000000

aesni_intel 167936 1663 - Live 0x0000000000000000

snd_hda_intel 36864 3 - Live 0x0000000000000000

snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000

aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000

snd_hda_core 65536 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000

snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000

lrw 16384 1 aesni_intel, Live 0x0000000000000000

gf128mul 16384 1 lrw, Live 0x0000000000000000

arc4 16384 2 - Live 0x0000000000000000

glue_helper 16384 1 aesni_intel, Live 0x0000000000000000

ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000

cryptd 20480 832 aesni_intel,ablk_helper, Live 0x0000000000000000

snd_pcm 102400 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000

uvcvideo 90112 0 - Live 0x0000000000000000

btusb 45056 0 - Live 0x0000000000000000

btrtl 16384 1 btusb, Live 0x0000000000000000

videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000

btbcm 16384 1 btusb, Live 0x0000000000000000

iwldvm 229376 0 - Live 0x0000000000000000

videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000

btintel 16384 1 btusb, Live 0x0000000000000000

videobuf2_v4l2 28672 1 uvcvideo, Live 0x0000000000000000

videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000

snd_seq_midi 16384 0 - Live 0x0000000000000000

v4l2_common 16384 1 videobuf2_v4l2, Live 0x0000000000000000

joydev 20480 0 - Live 0x0000000000000000

bluetooth 520192 29 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000

mac80211 724992 1 iwldvm, Live 0x0000000000000000

input_leds 16384 0 - Live 0x0000000000000000

videodev 176128 4 uvcvideo,videobuf2_v4l2,videobuf2_core,v4l2_common,
Live 0x0000000000000000

serio_raw 16384 0 - Live 0x0000000000000000

snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000

snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000

snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000

media 24576 2 uvcvideo,videodev, Live 0x0000000000000000

iwlwifi 196608 1 iwldvm, Live 0x0000000000000000

snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000

snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000

cfg80211 557056 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000

snd 81920 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000

mei_me 32768 0 - Live 0x0000000000000000

mei 98304 1 mei_me, Live 0x0000000000000000

shpchp 36864 0 - Live 0x0000000000000000

soundcore 16384 1 snd, Live 0x0000000000000000

lpc_ich 24576 0 - Live 0x0000000000000000

acpi_als 16384 0 - Live 0x0000000000000000

kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000

industrialio 57344 2 acpi_als,kfifo_buf, Live 0x0000000000000000

mac_hid 16384 0 - Live 0x0000000000000000

tpm_infineon 20480 0 - Live 0x0000000000000000

cuse 16384 3 - Live 0x0000000000000000

parport_pc 32768 0 - Live 0x0000000000000000

ppdev 20480 0 - Live 0x0000000000000000

lp 20480 0 - Live 0x0000000000000000

parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000

autofs4 40960 2 - Live 0x0000000000000000

hid_logitech_hidpp 20480 0 - Live 0x0000000000000000

hid_logitech_dj 20480 0 - Live 0x0000000000000000

rtsx_usb_sdmmc 28672 0 - Live 0x0000000000000000

usbhid 49152 0 - Live 0x0000000000000000

rtsx_usb 24576 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000

hid 118784 4 hid_logitech_hidpp,hid_logitech_dj,usbhid, Live 0x0000000000000000

i915 1204224 8 - Live 0x0000000000000000

i2c_algo_bit 16384 1 i915, Live 0x0000000000000000

drm_kms_helper 135168 1 i915, Live 0x0000000000000000

syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000

sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000

sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000

fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000

ahci 36864 8 - Live 0x0000000000000000

psmouse 126976 0 - Live 0x0000000000000000

libahci 32768 1 ahci, Live 0x0000000000000000

r8169 81920 0 - Live 0x0000000000000000

drm 360448 10 i915,drm_kms_helper, Live 0x0000000000000000

mii 16384 1 r8169, Live 0x0000000000000000

fjes 28672 0 - Live 0x0000000000000000

wmi 20480 0 - Live 0x0000000000000000

video 40960 1 i915, Live 0x0000000000000000



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
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

  00f0-00ff : PNP0C04:00

    00f0-00ff : fpu

  0400-0403 : ACPI PM1a_EVT_BLK

  0404-0405 : ACPI PM1a_CNT_BLK

  0408-040b : ACPI PM_TMR

  0410-0415 : ACPI CPU throttle

  0420-042f : ACPI GPE0_BLK

  0430-0433 : iTCO_wdt.2.auto

  0450-0450 : ACPI PM2_CNT_BLK

  0454-0457 : pnp 00:02

  0458-047f : pnp 00:00

    0460-047f : iTCO_wdt.2.auto

  04d0-04d1 : pnp 00:05

  0500-057f : pnp 00:00

  0680-069f : pnp 00:00

  0a00-0a07 : pnp 00:00

0cf8-0cff : PCI conf1

0d00-ffff : PCI Bus 0000:00

  1000-100f : pnp 00:00

  164e-164f : pnp 00:00

  e000-efff : PCI Bus 0000:02

    e000-e0ff : 0000:02:00.0

      e000-e0ff : r8169

  f000-f03f : 0000:00:02.0

  f040-f05f : 0000:00:1f.3

  f060-f07f : 0000:00:1f.2

    f060-f07f : ahci

  f080-f083 : 0000:00:1f.2

    f080-f083 : ahci

  f090-f097 : 0000:00:1f.2

    f090-f097 : ahci

  f0a0-f0a3 : 0000:00:1f.2

    f0a0-f0a3 : ahci

  f0b0-f0b7 : 0000:00:1f.2

    f0b0-f0b7 : ahci

  ffff-ffff : pnp 00:00

    ffff-ffff : pnp 00:00


cat /proc/iomem
00000000-00000fff : reserved

00001000-0009dfff : System RAM

0009e000-0009ffff : reserved

000a0000-000bffff : PCI Bus 0000:00

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

00100000-1fffffff : System RAM

  01000000-018006bf : Kernel code

  018006c0-01f3b9ff : Kernel data

  020b2000-021f4fff : Kernel bss

20000000-201fffff : reserved

  20000000-201fffff : pnp 00:07

20200000-40003fff : System RAM

40004000-40004fff : reserved

  40004000-40004fff : pnp 00:07

40005000-d91defff : System RAM

d91df000-d9923fff : reserved

d9924000-d9933fff : ACPI Tables

d9934000-d9f67fff : ACPI Non-volatile Storage

d9f68000-da84afff : reserved

da84b000-da84bfff : System RAM

da84c000-da88efff : ACPI Non-volatile Storage

da88f000-dacb5fff : System RAM

dacb6000-daff3fff : reserved

daff4000-daffffff : System RAM

db000000-df9fffff : reserved

  dba00000-df9fffff : Graphics Stolen Memory

dfa00000-feafffff : PCI Bus 0000:00

  dfa00000-dfa00fff : pnp 00:06

  e0000000-efffffff : 0000:00:02.0

  f0000000-f00fffff : PCI Bus 0000:02

    f0000000-f0003fff : 0000:02:00.0

      f0000000-f0003fff : r8169

  f7800000-f7bfffff : 0000:00:02.0

  f7c00000-f7cfffff : PCI Bus 0000:02

    f7c00000-f7c00fff : 0000:02:00.0

      f7c00000-f7c00fff : r8169

  f7d00000-f7dfffff : PCI Bus 0000:01

    f7d00000-f7d01fff : 0000:01:00.0

      f7d00000-f7d01fff : iwlwifi

  f7e00000-f7e0ffff : 0000:00:14.0

    f7e00000-f7e0ffff : xhci-hcd

  f7e10000-f7e13fff : 0000:00:1b.0

    f7e10000-f7e13fff : ICH HD audio

  f7e15000-f7e150ff : 0000:00:1f.3

  f7e16000-f7e167ff : 0000:00:1f.2

    f7e16000-f7e167ff : ahci

  f7e17000-f7e173ff : 0000:00:1d.0

    f7e17000-f7e173ff : ehci_hcd

  f7e18000-f7e183ff : 0000:00:1a.0

    f7e18000-f7e183ff : ehci_hcd

  f7e1a000-f7e1a00f : 0000:00:16.0

    f7e1a000-f7e1a00f : mei_me

  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]

    f8000000-fbffffff : reserved

      f8000000-fbffffff : pnp 00:06

fec00000-fec00fff : reserved

  fec00000-fec003ff : IOAPIC 0

fed00000-fed03fff : reserved

  fed00000-fed003ff : HPET 0

    fed00000-fed003ff : PNP0103:00

fed10000-fed17fff : pnp 00:06

fed18000-fed18fff : pnp 00:06

fed19000-fed19fff : pnp 00:06

fed1c000-fed1ffff : reserved

  fed1c000-fed1ffff : pnp 00:06

    fed1f410-fed1f414 : iTCO_wdt.2.auto

fed20000-fed3ffff : pnp 00:06

fed45000-fed8ffff : pnp 00:06

fed90000-fed90fff : dmar0

fed91000-fed91fff : dmar1

fee00000-fee00fff : Local APIC

  fee00000-fee00fff : reserved

ff000000-ffffffff : reserved

  ff000000-ffffffff : INT0800:00

    ff000000-ffffffff : pnp 00:06

100000000-21f5fffff : System RAM

21f600000-21fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-

        Latency: 0

        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

        Kernel driver in use: ivb_uncore



00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])

        DeviceName:  Onboard IGD

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin A routed to IRQ 29

        Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]

        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]

        Region 4: I/O ports at f000 [size=64]

        Expansion ROM at <unassigned> [disabled]

        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-

                Address: fee00018  Data: 0000

        Capabilities: [d0] Power Management version 2

                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)

                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [a4] PCI Advanced Features

                AFCap: TP+ FLR+

                AFCtrl: FLR-

                AFStatus: TP-

        Kernel driver in use: i915



00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin A routed to IRQ 26

        Region 0: Memory at f7e00000 (64-bit, non-prefetchable) [size=64K]

        Capabilities: [70] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+

                Address: 00000000fee00258  Data: 0000

        Kernel driver in use: xhci_hcd



00:16.0 Communication controller: Intel Corporation 7 Series/C210
Series Chipset Family MEI Controller #1 (rev 04)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin A routed to IRQ 30

        Region 0: Memory at f7e1a000 (64-bit, non-prefetchable) [size=16]

        Capabilities: [50] Power Management version 3

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+

                Address: 00000000fee002b8  Data: 0000

        Kernel driver in use: mei_me



00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin A routed to IRQ 16

        Region 0: Memory at f7e18000 (32-bit, non-prefetchable) [size=1K]

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



00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0, Cache Line Size: 64 bytes

        Interrupt: pin A routed to IRQ 32

        Region 0: Memory at f7e10000 (64-bit, non-prefetchable) [size=16K]

        Capabilities: [50] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+

                Address: 00000000fee00318  Data: 0000

        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00

                DevCap: MaxPayload 128 bytes, PhantFunc 0

                        ExtTag- RBE-

                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

                        MaxPayload 128 bytes, MaxReadReq 128 bytes

                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-

        Capabilities: [100 v1] Virtual Channel

                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1

                Arb:    Fixed- WRR32- WRR64- WRR128-

                Ctrl:   ArbSelect=Fixed

                Status: InProgress-

                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01

                        Status: NegoPending- InProgress-

                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=22

                        Status: NegoPending- InProgress-

        Capabilities: [130 v1] Root Complex Link

                Desc:   PortNumber=0f ComponentID=00 EltType=Config

                Link0:  Desc:   TargetPort=00 TargetComponent=00
AssocRCRB- LinkType=MemMapped LinkValid+

                        Addr:   00000000fed1c000

        Kernel driver in use: snd_hda_intel



00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0, Cache Line Size: 64 bytes

        Interrupt: pin A routed to IRQ 16

        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

        I/O behind bridge: 0000f000-00000fff

        Memory behind bridge: f7d00000-f7dfffff

        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-

        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

                DevCap: MaxPayload 128 bytes, PhantFunc 0

                        ExtTag- RBE+

                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

                        MaxPayload 128 bytes, MaxReadReq 128 bytes

                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-

                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <16us

                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-

                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-

                        Slot #0, PowerLimit 10.000W; Interlock- NoCompl+

                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-

                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-

                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-

                        Changed: MRL- PresDet- LinkState-

                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-

                RootCap: CRSVisible-

                RootSta: PME ReqID 0000, PMEStatus- PMEPending-

                DevCap2: Completion Timeout: Range BC, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd-

                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-

                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-

                         Compliance De-emphasis: -6dB

                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-

                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-

        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-

                Address: 00000000  Data: 0000

        Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0e8

        Capabilities: [a0] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Kernel driver in use: pcieport



00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 4 (rev c4) (prog-if 00 [Normal decode])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0, Cache Line Size: 64 bytes

        Interrupt: pin D routed to IRQ 19

        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0

        I/O behind bridge: 0000e000-0000efff

        Memory behind bridge: f7c00000-f7cfffff

        Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff

        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-

        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

                DevCap: MaxPayload 128 bytes, PhantFunc 0

                        ExtTag- RBE+

                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

                        MaxPayload 128 bytes, MaxReadReq 128 bytes

                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-

                LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <16us

                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-

                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-

                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl+

                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-

                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-

                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-

                        Changed: MRL- PresDet- LinkState-

                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-

                RootCap: CRSVisible-

                RootSta: PME ReqID 0000, PMEStatus- PMEPending-

                DevCap2: Completion Timeout: Range BC, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd-

                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-

                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-

                         Compliance De-emphasis: -6dB

                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-

                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-

        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-

                Address: 00000000  Data: 0000

        Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0e8

        Capabilities: [a0] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Kernel driver in use: pcieport



00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin A routed to IRQ 23

        Region 0: Memory at f7e17000 (32-bit, non-prefetchable) [size=1K]

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



00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC
Controller (rev 04)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

        Kernel driver in use: lpc_ich



00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0

        Interrupt: pin B routed to IRQ 28

        Region 0: I/O ports at f0b0 [size=8]

        Region 1: I/O ports at f0a0 [size=4]

        Region 2: I/O ports at f090 [size=8]

        Region 3: I/O ports at f080 [size=4]

        Region 4: I/O ports at f060 [size=32]

        Region 5: Memory at f7e16000 (32-bit, non-prefetchable) [size=2K]

        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

                Address: fee00298  Data: 0000

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



00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
SMBus Controller (rev 04)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-

        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

        Interrupt: pin C routed to IRQ 255

        Region 0: Memory at f7e15000 (64-bit, non-prefetchable) [size=256]

        Region 4: I/O ports at f040 [size=32]



01:00.0 Network controller: Intel Corporation Centrino Advanced-N 6235 (rev 24)

        Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0, Cache Line Size: 64 bytes

        Interrupt: pin A routed to IRQ 31

        Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=8K]

        Capabilities: [c8] Power Management version 3

                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+

                Address: 00000000fee002d8  Data: 0000

        Capabilities: [e0] Express (v1) Endpoint, MSI 00

                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited

                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+

                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-

                        MaxPayload 128 bytes, MaxReadReq 128 bytes

                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-

                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <4us, L1 <32us

                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-

                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+

                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-

        Capabilities: [100 v1] Advanced Error Reporting

                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-

                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-

                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-

                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

        Capabilities: [140 v1] Device Serial Number b4-b6-76-ff-ff-18-26-e4

        Kernel driver in use: iwlwifi



02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)

        Subsystem: Samsung Electronics Co Ltd Device c0e8

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

        Latency: 0, Cache Line Size: 64 bytes

        Interrupt: pin A routed to IRQ 27

        Region 0: I/O ports at e000 [size=256]

        Region 2: Memory at f7c00000 (64-bit, non-prefetchable) [size=4K]

        Region 4: Memory at f0000000 (64-bit, prefetchable) [size=16K]

        Capabilities: [40] Power Management version 3

                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)

                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+

                Address: 00000000fee00278  Data: 0000

        Capabilities: [70] Express (v2) Endpoint, MSI 01

                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us

                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

                        MaxPayload 128 bytes, MaxReadReq 4096 bytes

                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-

                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 <64us

                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-

                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+

                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-

                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR-, OBFF Not Supported

                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled

                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-

                         Compliance De-emphasis: -6dB

                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-

                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-

        Capabilities: [b0] MSI-X: Enable- Count=4 Masked-

                Vector table: BAR=4 offset=00000000

                PBA: BAR=4 offset=00000800

        Capabilities: [d0] Vital Product Data

                No end tag found

        Capabilities: [100 v1] Advanced Error Reporting

                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-

                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-

                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-

                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

        Capabilities: [140 v1] Virtual Channel

                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1

                Arb:    Fixed- WRR32- WRR64- WRR128-

                Ctrl:   ArbSelect=Fixed

                Status: InProgress-

                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff

                        Status: NegoPending- InProgress-

        Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00

        Kernel driver in use: r8169



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:

Host: scsi0 Channel: 00 Id: 00 Lun: 00

  Vendor: ATA      Model: Samsung SSD 840  Rev: 8B0Q

  Type:   Direct-Access                    ANSI  SCSI revision: 05

Host: scsi1 Channel: 00 Id: 00 Lun: 00

  Vendor: ATA      Model: SanDisk SSD i100 Rev: 6.04

  Type:   Direct-Access                    ANSI  SCSI revision: 05



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

ls /proc/
1     12    1628  167   176   1943  2     21    2252  2514  2974  324
 372   463   64   74   86   988        driver       kpagecgroup
sched_debug    tty
10    13    163   1670  178   1944  20    2100  23    26    3     33
 38    464   65   741  87   992        execdomains  kpagecount
schedstat      uptime
1001  15    1635  1677  18    1946  2005  2101  2457  264   30    3322
 39    466   66   75   9    acpi       fb           kpageflags    scsi
          version
1002  1518  1636  168   1817  1967  2016  2102  2459  265   3006  34
 4030  467   668  76   91   asound     filesystems  loadavg       self
          vmallocinfo
1005  156   1638  169   1818  1968  2030  2103  2461  267   3009  3434
 4039  4914  67   77   912  buddyinfo  fs           locks
slabinfo       vmstat
1014  157   164   17    1819  1969  2031  2104  2470  268   3016  3466
 4044  4915  677  78   915  bus        interrupts   mdstat
softirqs       zoneinfo
1039  1579  1648  1706  1890  1971  2035  2105  2473  27    3039  3468
 41    4917  678  79   926  cgroups    iomem        meminfo       stat
1084  158   165   1709  1893  1974  2041  2107  2482  28    3074  35
 429   5     68   8    931  cmdline    ioports      misc
swaps
109   159   1650  1718  1894  1981  2057  2109  2486  29    31    3545
 43    5339  69   80   940  consoles   irq          modules       sys
11    16    1654  1726  19    1984  2059  2111  2490  2959  312   358
 434   562   7    81   972  cpuinfo    kallsyms     mounts
sysrq-trigger
110   160   1657  1727  191   1987  2061  2114  2492  2966  3133  36
 44    60    70   82   975  crypto     kcore        mtrr
sysvipc
1111  161   166   1729  192   1989  2097  2116  2496  2967  3189  3612
 442   608   71   83   978  devices    keys         net
thread-self
1120  1610  1668  174   1935  1990  2098  22    25    2970  32    369
 45    609   72   84   983  diskstats  key-users    pagetypeinfo
timer_list
1128  162   1669  175   1942  1999  2099  2212  2505  2971  3230  37
 462   61    73   85   987  dma        kmsg         partitions
timer_stats



[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1516320
