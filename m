From: Matthew Brooks <matthewfbrooks@gmail.com>
Subject: Brightness keys on Asus X200MA don't work.
Date: Wed, 21 Dec 2016 19:15:15 -0600
Message-ID: <CAPi-ftoYwmPK+i-JpQYdwC6t_ua_t3Py-O7RkZp9jqUEi1Ot7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35501 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbcLVBPR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2016 20:15:17 -0500
Received: by mail-io0-f195.google.com with SMTP id f73so27435808ioe.2
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2016 17:15:16 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

[1.] [Asus X200MA] Brightness keys don't work.

[2.] (Sorry for the duplicates. Gmail does *not* want to send in plain
text, apparently.)
Fn + F5 or F6 is supposed to lower or raise the brightness respectively.
By default, nothing happens when pushing the buttons. Piping a number
into /sys/class/backlight/intel_backlight/brightness works fine, and
the brightness slider in the drop-down menu on the Gnome panel also
works.
The "video.use_bios_initial_backlight=0", "acpi_osi=", and
"acpi_backlight=vendor" kernel options where all tried, and none of
them fixed the problem. More detailed info about the results is in
section "X" at the bottom of the message.

[4.]

[4.1] Linux version 4.9.0-040900-generic (kernel@tangerine) (gcc
version 6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #201612111631 SMP
Sun Dec 11 21:33:00 UTC 2016

[8.] Description:    Ubuntu 16.10
Release:    16.10

[8.1.] If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux TheDarkSlab 4.9.0-040900-generic #201612111631 SMP Sun Dec 11
21:33:00 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Binutils                2.27
Util-linux              2.28.2
Mount                   2.28.2
Module-init-tools       22
E2fsprogs               1.43.3
Pcmciautils             018
PPP                     2.4.7
Linux C Library         2.24
Dynamic linker (ldd)    2.24
Linux C++ Library       6.0.22
Procps                  3.3.12
Net-tools               2.10
Kbd                     2.0.3
Console-tools           2.0.3
Sh-utils                8.25
Udev                    231
Wireless-tools          30
Modules Loaded          8250_dw ac97_bus ahci arc4 asus_nb_wmi
asus_wireless asus_wmi ath ath9k ath9k_common ath9k_hw autofs4
bluetooth bnep btbcm btintel btqca ccm cfg80211 coretemp crc32_pclmul
crct10dif_pclmul cryptd drm drm_kms_helper dw_dmac dw_dmac_core
fb_sys_fops fjes ghash_clmulni_intel hci_uart hid hid_multitouch
i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_hid i915
input_leds intel_cstate intel_powerclamp intel_rapl intel_soc_dts_iosf
ip_tables irqbypass joydev kvm kvm_intel libahci lp lpc_ich mac80211
mac_hid media mei mei_txe memstick mii nls_iso8859_1 parport
parport_pc ppdev psmouse punit_atom_debug pwm_lpss pwm_lpss_platform
r8169 rfkill_gpio rtsx_pci rtsx_pci_ms rtsx_pci_sdmmc sdhci sdhci_acpi
serio_raw shpchp snd snd_compress snd_hda_codec snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel
snd_hwdep snd_intel_sst_acpi snd_intel_sst_core snd_pcm
snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi
snd_seq_midi_event snd_soc_core snd_soc_rl6231 snd_soc_rt5640
snd_soc_rt5645 snd_soc_sst_match snd_soc_sst_mfld_platform snd_timer
soundcore sparse_keymap spi_pxa2xx_platform syscopyarea sysfillrect
sysimgblt usbhid uvcvideo video videobuf2_core videobuf2_memops
videobuf2_v4l2 videobuf2_vmalloc videodev wmi x_tables

[8.2.] processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 55
model name    : Intel(R) Celeron(R) CPU  N2815  @ 1.86GHz
stepping    : 3
microcode    : 0x322
cpu MHz        : 533.183
cache size    : 1024 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs        :
bogomips    : 3732.40
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 55
model name    : Intel(R) Celeron(R) CPU  N2815  @ 1.86GHz
stepping    : 3
microcode    : 0x322
cpu MHz        : 533.183
cache size    : 1024 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs        :
bogomips    : 3734.75
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[8.3.] ccm 20480 2 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
intel_soc_dts_iosf 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
asus_nb_wmi 28672 0 - Live 0x0000000000000000
kvm_intel 196608 0 - Live 0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
kvm 598016 1 kvm_intel, Live 0x0000000000000000
ath9k 147456 0 - Live 0x0000000000000000
ath9k_common 36864 1 ath9k, Live 0x0000000000000000
ath9k_hw 475136 2 ath9k,ath9k_common, Live 0x0000000000000000
ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
mac80211 782336 1 ath9k, Live 0x0000000000000000
punit_atom_debug 16384 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
cryptd 24576 1 ghash_clmulni_intel, Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
snd_intel_sst_acpi 16384 0 - Live 0x0000000000000000
intel_cstate 16384 0 - Live 0x0000000000000000
cfg80211 598016 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
snd_intel_sst_core 77824 1 snd_intel_sst_acpi, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
snd_soc_rt5645 147456 0 - Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
snd_soc_sst_mfld_platform 102400 1 snd_intel_sst_core, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_soc_rt5640 118784 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_soc_sst_match 16384 1 snd_intel_sst_acpi, Live 0x0000000000000000
snd_soc_rl6231 16384 2 snd_soc_rt5645,snd_soc_rt5640, Live 0x0000000000000000
snd_hda_intel 36864 6 - Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
snd_soc_core 233472 3
snd_soc_rt5645,snd_soc_sst_mfld_platform,snd_soc_rt5640, Live
0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
snd_hda_core 86016 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
videodev 180224 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
mei_txe 20480 0 - Live 0x0000000000000000
hid_multitouch 20480 0 - Live 0x0000000000000000
mei 102400 1 mei_txe, Live 0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
snd_pcm 114688 9
snd_hda_codec_hdmi,snd_soc_rt5645,snd_soc_sst_mfld_platform,snd_soc_rt5640,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_hda_core,snd_pcm_dmaengine,
Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
hci_uart 98304 0 - Live 0x0000000000000000
btbcm 16384 1 hci_uart, Live 0x0000000000000000
btqca 16384 1 hci_uart, Live 0x0000000000000000
btintel 16384 1 hci_uart, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
bluetooth 561152 11 bnep,hci_uart,btbcm,btqca,btintel, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
asus_wireless 16384 0 - Live 0x0000000000000000
snd 86016 26 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_sst_mfld_platform,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_compress,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
rfkill_gpio 16384 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
pwm_lpss_platform 16384 0 - Live 0x0000000000000000
pwm_lpss 16384 1 pwm_lpss_platform, Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ip_tables 28672 0 - Live 0x0000000000000000
x_tables 36864 1 ip_tables, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
i915 1257472 18 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
psmouse 139264 0 - Live 0x0000000000000000
drm_kms_helper 159744 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
drm 364544 10 i915,drm_kms_helper, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
wmi 16384 1 asus_wmi, Live 0x0000000000000000
video 40960 2 asus_wmi,i915, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
hid 122880 3 hid_multitouch,usbhid,i2c_hid, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000

[8.4.] 0000-006f : PCI Bus 0000:00
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
0070-0077 : PCI Bus 0000:00
  0070-0077 : rtc0
0078-0cf7 : PCI Bus 0000:00
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03f8-03ff : serial
  0400-047f : pnp 00:01
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt.0.auto
    0450-0450 : ACPI PM2_CNT_BLK
    0460-047f : iTCO_wdt.0.auto
  0500-05fe : pnp 00:01
  0600-061f : pnp 00:01
  0680-069f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  e000-efff : PCI Bus 0000:03
    e000-e0ff : 0000:03:00.2
      e000-e0ff : r8169
  f000-f01f : 0000:00:1f.3
  f020-f03f : 0000:00:13.0
    f020-f03f : ahci
  f040-f043 : 0000:00:13.0
    f040-f043 : ahci
  f050-f057 : 0000:00:13.0
    f050-f057 : ahci
  f060-f063 : 0000:00:13.0
    f060-f063 : ahci
  f070-f077 : 0000:00:13.0
    f070-f077 : ahci
  f080-f087 : 0000:00:02.0

00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0008ffff : ACPI Non-volatile Storage
00090000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
000e0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
20000000-200fffff : reserved
20100000-b8d4ffff : System RAM
  6ca00000-6d292926 : Kernel code
  6d292927-6d9684ff : Kernel data
  6dafa000-6dc46fff : Kernel bss
b8d50000-b8d7ffff : reserved
b8d80000-b8ecbfff : System RAM
b8ecc000-b93bcfff : ACPI Non-volatile Storage
b93bd000-b9b49fff : reserved
b9b4a000-b9babfff : reserved
b9bac000-b9bacfff : System RAM
b9bad000-b9beefff : reserved
b9bef000-b9d64fff : System RAM
b9d65000-b9ff9fff : reserved
b9ffa000-b9ffffff : System RAM
ba000000-baffffff : RAM buffer
bb000000-beffffff : reserved
  bb000000-beffffff : Graphics Stolen Memory
c0000000-d0815ffe : PCI Bus 0000:00
  c0000000-cfffffff : 0000:00:02.0
  d0000000-d03fffff : 0000:00:02.0
  d0400000-d04fffff : 0000:00:1a.0
    d0400000-d04fffff : mei_txe
  d0500000-d05fffff : 0000:00:1a.0
    d0500000-d05fffff : mei_txe
  d0600000-d06fffff : PCI Bus 0000:03
    d0600000-d060ffff : 0000:03:00.0
      d0600000-d060ffff : rtsx_pci
    d0610000-d0613fff : 0000:03:00.2
      d0610000-d0613fff : r8169
    d0614000-d0614fff : 0000:03:00.2
      d0614000-d0614fff : r8169
  d0700000-d07fffff : PCI Bus 0000:02
    d0700000-d077ffff : 0000:02:00.0
      d0700000-d077ffff : ath9k
    d0780000-d078ffff : 0000:02:00.0
  d0800000-d080ffff : 0000:00:14.0
    d0800000-d080ffff : xhci-hcd
  d0810000-d0813fff : 0000:00:1b.0
    d0810000-d0813fff : ICH HD audio
  d0814000-d081401f : 0000:00:1f.3
  d0815000-d08157ff : 0000:00:13.0
    d0815000-d08157ff : ahci
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e00000d0-e00000db : INT33BD:00
  e00f8000-e00f8fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed01000-fed01fff : reserved
  fed01000-fed01fff : pnp 00:05
fed03000-fed03fff : pnp 00:05
  fed03008-fed0300c : iTCO_wdt.0.auto
fed04000-fed04fff : pnp 00:05
fed08000-fed08fff : pnp 00:05
fed0c000-fed0ffff : pnp 00:05
fed1c000-fed1cfff : pnp 00:05
fee00000-feefffff : pnp 00:05
  fee00000-fee00fff : Local APIC
fef00000-feffffff : pnp 00:05
ff000000-ffffffff : INT0800:00
  ffc00000-ffffffff : reserved
100000000-13fffffff : System RAM

[8.5.] 00:00.0 Host bridge: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series SoC Transaction Register (rev 0c)
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx
Series SoC Transaction Register
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Graphics & Display (rev 0c) (prog-if 00 [VGA
controller])
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx
Series Graphics & Display
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 91
    Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=4M]
    Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
    Region 4: I/O ports at f080 [size=8]
    [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0200c  Data: 41d1
    Capabilities: [b0] Vendor Specific Information: Len=07 <?>
    Kernel driver in use: i915
    Kernel modules: i915

00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series
SATA AHCI Controller (rev 0c) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. Atom Processor E3800 Series SATA
AHCI Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 89
    Region 0: I/O ports at f070 [size=8]
    Region 1: I/O ports at f060 [size=4]
    Region 2: I/O ports at f050 [size=8]
    Region 3: I/O ports at f040 [size=4]
    Region 4: I/O ports at f020 [size=32]
    Region 5: Memory at d0815000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0200c  Data: 41b1
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci
    Kernel modules: ahci

00:14.0 USB controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx, Celeron N2000 Series USB xHCI (rev 0c) (prog-if 30
[XHCI])
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx,
Celeron N2000 Series USB xHCI
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 87
    Region 0: Memory at d0800000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee0200c  Data: 4191
    Kernel driver in use: xhci_hcd

00:1a.0 Encryption controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0c)
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx
Series Trusted Execution Engine
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 92
    Region 0: Memory at d0500000 (32-bit, non-prefetchable) [size=1M]
    Region 1: Memory at d0400000 (32-bit, non-prefetchable) [size=1M]
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41e1
    Kernel driver in use: mei_txe
    Kernel modules: mei_txe

00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller (rev 0c)
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 93
    Region 0: Memory at d0810000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0200c  Data: 4142
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 1 (rev 0c) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 16
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Atom Processor
E3800 Series PCI Express Root Port 1
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 2 (rev 0c) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 17
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: d0700000-d07fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Atom Processor
E3800 Series PCI Express Root Port 2
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 4 (rev 0c) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin D routed to IRQ 19
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: d0600000-d06fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Atom Processor
E3800 Series PCI Express Root Port 4
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Power Control Unit (rev 0c)
    Subsystem: ASUSTeK Computer Inc. Atom Processor Z36xxx/Z37xxx
Series Power Control Unit
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich
    Kernel modules: lpc_ich

00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus
Controller (rev 0c)
    Subsystem: ASUSTeK Computer Inc. Atom Processor E3800 Series SMBus
Controller
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin B routed to IRQ 255
    Region 0: Memory at d0814000 (32-bit, non-prefetchable) [size=32]
    Region 4: I/O ports at f000 [size=32]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Kernel modules: i2c_i801

02:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network
Adapter (rev 01)
    Subsystem: Lite-On Communications Inc AR9485 Wireless Network Adapter
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at d0700000 (64-bit, non-prefetchable) [size=512K]
    Expansion ROM at d0780000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Address: 0000000000000000  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <64us
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Kernel driver in use: ath9k
    Kernel modules: ath9k

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5286 PCI Express Card Reader (rev 01)
    Subsystem: Realtek Semiconductor Co., Ltd. RTS5286 PCI Express Card Reader
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 88
    Region 0: Memory at d0600000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41a1
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
        Vector table: BAR=0 offset=00000000
        PBA: BAR=0 offset=00000000
    Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
        Not readable
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
    Capabilities: [160 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
    Kernel driver in use: rtsx_pci
    Kernel modules: rtsx_pci

03:00.2 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 06)
    Subsystem: ASUSTeK Computer Inc. RTL8101/2/6E PCI Express
Fast/Gigabit Ethernet controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 90
    Region 0: I/O ports at e000 [size=256]
    Region 2: Memory at d0614000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at d0610000 (64-bit, prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41c1
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
        Not readable
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
    Capabilities: [160 v1] Device Serial Number 92-21-38-31-68-4c-e0-00
    Kernel driver in use: r8169
    Kernel modules: r8169

[8.6.] Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SanDisk SDSSDP12 Rev: 0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[X.] Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1651629

Summary of things checked:
Booting the kernel with "video.use_bios_initial_backlight=0" doesn't
have any effect on the issue.

Booting with "acpi_osi=" results in the brightness meter poping up and
changing as it should when the brightness keys are pressed, but the
actual screen brightness doesn't change. The Gnome brightness slider
also no longer changes the brightness with this option. The
/sys/class/backlight/intel_backlight/brightness file works as normal.

Booting with "acpi_backlight=vendor" results in the brightness keys
still doing nothing, and the Gnome slider not changing the brightness
anymore. /sys/class/backlight/intel_backlight/brightness still works.
An "ls" of the backlight directory with this kernel paramter shows:
asus-nb-wmi
intel_backlight

An "ls -la" of the intel_backlight directory shows:
total 0
drwxr-xr-x 3 root root    0 Dec 21 14:34 .
drwxr-xr-x 6 root root    0 Dec 21 14:34 ..
-r--r--r-- 1 root root 4096 Dec 21 14:34 actual_brightness
-rw-r--r-- 1 root root 4096 Dec 21 14:34 bl_power
-rw-r--r-- 1 root root 4096 Dec 21 14:34 brightness
lrwxrwxrwx 1 root root    0 Dec 21 14:34 device -> ../../card0-eDP-1
-r--r--r-- 1 root root 4096 Dec 21 14:34 max_brightness
drwxr-xr-x 2 root root    0 Dec 21 14:34 power
lrwxrwxrwx 1 root root    0 Dec 21 14:34 subsystem ->
../../../../../../../class/backlight
-r--r--r-- 1 root root 4096 Dec 21 14:34 type
-rw-r--r-- 1 root root 4096 Dec 21 14:34 uevent

Booting with "atkbd.softraw=0", and running "showkey -s" from a tty
doesn't produce any output when pressing the backlight keys.
