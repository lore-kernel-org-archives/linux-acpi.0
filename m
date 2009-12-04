From: firstname lastname <vajorie@gmail.com>
Subject: PROBLEM: Acer Aspire One cpu temp wrong, acerhdf & acer-wmi not
	working, acpi errors
Date: Fri, 4 Dec 2009 02:25:43 -0500
Message-ID: <a03cbe4f0912032325o42d49045x9b2e80f0c7fa83ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36447 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbZLDHZh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 02:25:37 -0500
Received: by yxe17 with SMTP id 17so1882827yxe.33
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2009 23:25:43 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, hope this is the correct place to report this...

[1.] Acer Aspire One model AOD250-1613 (comes with Android and Win XP,
up to date BIOS v1.22) reports cpu temperature wrong (too low to be
true).

[2.] The netbook reports its temperature around 26-27C, which is
impossible. The fan works correctly, working harder as heat biulds up,
but this makes applications depending on this information dangerous
for hardware. Eg if acerhdf was working on this machine, fan would
never come up because the temperature reported never goes over 27C.
Users depending on the information (eg looking at monitoring
softwae=re such as conky) are also left in risk of hardware damage.
Note, however, that acerhdf and acer-wmi do not recognize this netbook
as an Acer. Netbook also has known problems with cpufreq (max freq is
reported as 1.33GHz though it is 1.66GHz), if that is relevant.

[3.] Keywords: modules, temp, acpi, cpu, heat
[4.] Kernel version (from /proc/version):
Linux version 2.6.31-ARCH (root@architect) (gcc version 4.4.2 (GCC) )
#1 SMP PREEMPT Tue Nov 10 19:48:17 CET 2009

[5.] NA
[6.] NA

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux aod250 2.6.31-ARCH #1 SMP PREEMPT Tue Nov 10 19:48:17 CET 2009
i686 Intel(R) Atom(TM) CPU N280 @ 1.66GHz GenuineIntel GNU/Linux

Gnu C                  4.4.2
Gnu make               3.81
binutils               2.20.0.20091101
util-linux             2.16
mount                  support
module-init-tools      3.11.1
e2fsprogs              1.41.9
jfsutils               1.1.14
reiserfsprogs          3.6.21
xfsprogs               3.0.5
pcmciautils            015
PPP                    2.4.4
Linux C Library        2.11
Dynamic linker (ldd)   2.11
Linux C++ Library      6.0.13
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               7.6
wireless-tools         29
Modules Loaded         ext3 jbd hfsplus vfat fat isofs nls_utf8 udf
crc_itu_t i915 drm i2c_algo_bit aes_i586 aes_generic ipv6
cpufreq_userspace ext2 loop snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
arc4 ecb snd_hda_codec_realtek joydev ath9k snd_hda_intel
snd_hda_codec snd_hwdep snd_pcm snd_timer video mac80211 ath snd
usb_storage fan output soundcore thermal battery button snd_page_alloc
ac cfg80211 rfkill led_class i2c_i801 wmi psmouse iTCO_wdt
iTCO_vendor_support i2c_core atl1c evdev pciehp pci_hotplug
acpi_cpufreq uhci_hcd serio_raw intel_agp freq_table sg agpgart
ehci_hcd usbcore processor rtc_cmos rtc_core rtc_lib ext4 mbcache jbd2
crc16 sd_mod ahci libata scsi_mod


[7.2.] Processor information (from /proc/cpuinfo) (freq is scaled) (I
do not know why it shows 2 CPUs):


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping        : 2
cpu MHz         : 800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips        : 3326.28
clflush size    : 64
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping        : 2
cpu MHz         : 1066.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips        : 3326.54
clflush size    : 64
power management:


[7.3.] Module information (from /proc/modules):

ext3 134020 0 - Live 0xf8c0e000
jbd 49136 1 ext3, Live 0xf8569000
hfsplus 76864 0 - Live 0xf8542000
vfat 11132 0 - Live 0xf820b000
fat 53052 1 vfat, Live 0xf83e8000
isofs 33764 0 - Live 0xf819e000
nls_utf8 1664 0 - Live 0xf8060000
udf 86564 0 - Live 0xf83c9000
crc_itu_t 1724 1 udf, Live 0xf8049000
i915 233928 1 - Live 0xf8772000
drm 156160 2 i915, Live 0xf8465000
i2c_algo_bit 5888 1 i915, Live 0xf8045000
aes_i586 8124 1 - Live 0xf8a08000
aes_generic 27228 1 aes_i586, Live 0xf89f6000
ipv6 279604 12 - Live 0xf8980000
cpufreq_userspace 3008 2 - Live 0xf8924000
ext2 68964 1 - Live 0xf890a000
loop 15336 2 - Live 0xf88ea000
snd_seq_dummy 2720 0 - Live 0xf88dd000
snd_seq_oss 31232 0 - Live 0xf88c0000
snd_seq_midi_event 7036 1 snd_seq_oss, Live 0xf88a8000
snd_seq 53808 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xf887d000
snd_seq_device 6792 3 snd_seq_dummy,snd_seq_oss,snd_seq, Live 0xf8863000
snd_pcm_oss 40320 0 - Live 0xf8841000
snd_mixer_oss 17564 1 snd_pcm_oss, Live 0xf8829000
arc4 1756 2 - Live 0xf881b000
ecb 2812 2 - Live 0xf87ee000
snd_hda_codec_realtek 210048 1 - Live 0xf87b8000
joydev 10528 0 - Live 0xf8754000
ath9k 239188 0 - Live 0xf8711000
snd_hda_intel 27528 0 - Live 0xf8678000
snd_hda_codec 72700 2 snd_hda_codec_realtek,snd_hda_intel, Live 0xf8658000
snd_hwdep 7712 1 snd_hda_codec, Live 0xf8577000
snd_pcm 74496 3 snd_pcm_oss,snd_hda_intel,snd_hda_codec, Live 0xf862b000
snd_timer 21188 2 snd_seq,snd_pcm, Live 0xf84d0000
video 20116 1 i915, Live 0xf84bd000
mac80211 155788 1 ath9k, Live 0xf8602000
ath 7708 1 ath9k, Live 0xf845f000
snd 58820 11 snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer,
Live 0xf8490000
usb_storage 51904 0 - Live 0xf8442000
fan 4448 0 - Live 0xf8420000
output 2908 1 video, Live 0xf8416000
soundcore 6944 1 snd, Live 0xf840b000
thermal 13912 0 - Live 0xf83fd000
battery 10816 0 - Live 0xf83e3000
button 5612 0 - Live 0xf83c5000
snd_page_alloc 8900 2 snd_hda_intel,snd_pcm, Live 0xf83bb000
ac 4224 0 - Live 0xf8342000
cfg80211 90364 3 ath9k,mac80211,ath, Live 0xf836e000
rfkill 19696 1 cfg80211, Live 0xf8327000
led_class 4000 1 ath9k, Live 0xf830f000
i2c_i801 9616 0 - Live 0xf82ac000
wmi 6600 0 - Live 0xf829f000
psmouse 60084 0 - Live 0xf8286000
iTCO_wdt 11072 0 - Live 0xf826c000
iTCO_vendor_support 3136 1 iTCO_wdt, Live 0xf820f000
i2c_core 21808 4 i915,drm,i2c_algo_bit,i2c_i801, Live 0xf825d000
atl1c 32160 0 - Live 0xf8220000
evdev 10240 13 - Live 0xf81f7000
pciehp 37020 0 - Live 0xf81b0000
pci_hotplug 28732 1 pciehp, Live 0xf8194000
acpi_cpufreq 8648 0 - Live 0xf8062000
uhci_hcd 23692 0 - Live 0xf8052000
serio_raw 5792 0 - Live 0xf8041000
intel_agp 28604 1 - Live 0xf84da000
freq_table 3740 1 acpi_cpufreq, Live 0xf84b0000
sg 27728 0 - Live 0xf84a0000
agpgart 32660 3 drm,intel_agp, Live 0xf8455000
ehci_hcd 36620 0 - Live 0xf8437000
usbcore 154032 4 usb_storage,uhci_hcd,ehci_hcd, Live 0xf8393000
processor 36076 3 acpi_cpufreq, Live 0xf8346000
rtc_cmos 11344 0 - Live 0xf8330000
rtc_core 17976 1 rtc_cmos, Live 0xf8320000
rtc_lib 2524 1 rtc_core, Live 0xf8315000
ext4 334112 2 - Live 0xf82bb000
mbcache 7104 3 ext3,ext2,ext4, Live 0xf824f000
jbd2 82016 1 ext4, Live 0xf8230000
crc16 1660 1 ext4, Live 0xf8211000
sd_mod 28344 3 - Live 0xf8202000
ahci 35788 2 - Live 0xf8076000
libata 169548 1 ahci, Live 0xf81c8000
scsi_mod 112468 4 usb_storage,sg,sd_mod,libata, Live 0xf8176000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


iomem:

00000000-00001fff : System RAM
00002000-00005fff : reserved
00006000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-7f575fff : System RAM
  01000000-01309ddc : Kernel code
  01309ddd-01421ea7 : Kernel data
  0148d000-0156da43 : Kernel bss
7f576000-7f5befff : reserved
7f5bf000-7f66cfff : System RAM
7f66d000-7f6befff : ACPI Non-volatile Storage
7f6bf000-7f6edfff : System RAM
7f6ee000-7f6fefff : ACPI Tables
7f6ff000-7f6fffff : System RAM
7f700000-7fffffff : reserved
80000000-8fffffff : 0000:00:02.0
  80000000-807affff : vesafb
90000000-90ffffff : PCI Bus 0000:01
91000000-91ffffff : PCI Bus 0000:02
92000000-92ffffff : PCI Bus 0000:03
93000000-93ffffff : PCI Bus 0000:04
94000000-94ffffff : PCI Bus 0000:04
95000000-960fffff : PCI Bus 0000:03
  95000000-9503ffff : 0000:03:00.0
    95000000-9503ffff : atl1c
96100000-970fffff : PCI Bus 0000:02
97100000-981fffff : PCI Bus 0000:01
  97100000-9710ffff : 0000:01:00.0
    97100000-9710ffff : ath9k
98200000-9827ffff : 0000:00:02.1
98280000-982fffff : 0000:00:02.0
98300000-9833ffff : 0000:00:02.0
98340000-98343fff : 0000:00:1b.0
  98340000-98343fff : ICH HD audio
98344000-983443ff : 0000:00:1f.2
  98344000-983443ff : ahci
98344400-983447ff : 0000:00:1d.7
  98344400-983447ff : ehci_hcd
98345000-98345fff : Intel Flush Page
e0000000-efffffff : PCI MMCONFIG 0 [00-ff]
  e0000000-efffffff : reserved
    e0000000-efffffff : pnp 00:01
fec00000-fec00fff : IOAPIC 0
  fec00000-fec00fff : reserved
fed00000-fed003ff : HPET 0
fed14000-fed19fff : reserved
  fed14000-fed17fff : pnp 00:01
  fed18000-fed18fff : pnp 00:01
  fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
    fee00000-fee00fff : pnp 00:01
fff00000-ffffffff : reserved

ioports:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0077 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0200-020f : pnp 00:01
03c0-03df : vesafb
0400-047f : 0000:00:1f.0
  0400-047f : pnp 00:01
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-0420 : ACPI PM2_CNT_BLK
    0428-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
    0460-047f : iTCO_wdt
0500-053f : 0000:00:1f.0
  0500-053f : pnp 00:01
0600-060f : pnp 00:01
0610-0610 : pnp 00:01
0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
1000-1fff : PCI Bus 0000:04
2000-3fff : PCI Bus 0000:03
  2000-207f : 0000:03:00.0
    2000-207f : atl1c
4000-4fff : PCI Bus 0000:02
5000-5fff : PCI Bus 0000:01
6000-601f : 0000:00:1f.3
  6000-601f : i801_smbus
6020-602f : 0000:00:1f.2
  6020-602f : ahci
6040-605f : 0000:00:1d.3
  6040-605f : uhci_hcd
6060-607f : 0000:00:1d.2
  6060-607f : uhci_hcd
6080-609f : 0000:00:1d.1
  6080-609f : uhci_hcd
60a0-60bf : 0000:00:1d.0
  60a0-60bf : uhci_hcd
60d0-60d7 : 0000:00:1f.2
  60d0-60d7 : ahci
60d8-60df : 0000:00:1f.2
  60d8-60df : ahci
60f0-60f7 : 0000:00:02.0
60f8-60fb : 0000:00:1f.2
  60f8-60fb : ahci
60fc-60ff : 0000:00:1f.2
  60fc-60ff : ahci
ff2c-ff2f : pnp 00:01

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Mobile 945GME Express Memory
Controller Hub (rev 03)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information <?>
        Kernel driver in use: agpgart-intel
        Kernel modules: intel-agp

00:02.0 VGA compatible controller: Intel Corporation Mobile 945GME
Express Integrated Graphics Controller (rev 03) (prog-if 00 [VGA
controller])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 98280000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at 60f0 [size=8]
        Region 2: Memory at 80000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at 98300000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME,
943/940GML Express Integrated Graphics Controller (rev 03)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at 98200000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 98340000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM
unknown, Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: 97100000-981fffff
        Prefetchable memory behind bridge: 0000000090000000-0000000090ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surpise+
                        Slot #  0, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt+ HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4169
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 022f
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: 96100000-970fffff
        Prefetchable memory behind bridge: 0000000091000000-0000000091ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surpise+
                        Slot #  1, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt+ HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4171
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 022f
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00002000-00003fff
        Memory behind bridge: 95000000-960fffff
        Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surpise+
                        Slot #  2, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt+ HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4179
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 022f
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 94000000-94ffffff
        Prefetchable memory behind bridge: 0000000093000000-0000000093ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surpise+
                        Slot #  0, PowerLimit 6.500000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt+ HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4181
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 022f
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [180] Root Complex Link <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 60a0 [size=32]
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 6080 [size=32]
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 6060 [size=32]
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at 6040 [size=32]
        Kernel driver in use: uhci_hcd
        Kernel modules: uhci-hcd

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 98344400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Subsystem: Acer Incorporated [ALI] Device 022f

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information <?>
        Kernel modules: iTCO_wdt, intel-rng

00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 28
        Region 0: I/O ports at 60d8 [size=8]
        Region 1: I/O ports at 60fc [size=4]
        Region 2: I/O ports at 60d0 [size=8]
        Region 3: I/O ports at 60f8 [size=4]
        Region 4: I/O ports at 6020 [size=16]
        Region 5: Memory at 98344000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4189
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ahci
        Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 6000 [size=32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c-i801

01:00.0 Network controller: Atheros Communications Inc. AR9285
Wireless Network Adapter (PCI-Express) (rev 01)
        Subsystem: Foxconn International, Inc. Device e016
        Physical Slot: 0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 97100000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
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
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [100] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140] Virtual Channel <?>
        Capabilities: [160] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170] Power Budgeting <?>
        Kernel driver in use: ath9k
        Kernel modules: ath9k

03:00.0 Ethernet controller: Attansic Technology Corp. Atheros AR8132
/ L1c Gigabit Ethernet Adapter (rev c0)
        Subsystem: Acer Incorporated [ALI] Device 022f
        Physical Slot: 2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at 95000000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at 2000 [size=128]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4199
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency
L0s <4us, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
                Not readable
        Capabilities: [100] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [180] Device Serial Number ff-5a-b6-2c-00-26-22-ff
        Kernel driver in use: atl1c
        Kernel modules: atl1c



[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1600BEVT-2 Rev: 11.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic- Model: Multi-Card       Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

$ acpi -V
Battery 0: Full, 100%
Battery 0: design capacity 5800 mAh, last full capacity 5500 mAh = 94%
Adapter 0: on-line
Thermal 0: ok, 26.8 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 100.0 degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 85.0 degrees C
Cooling 0: LCD 0 of 9
Cooling 1: Fan 1 of 1
Cooling 2: Processor 0 of 10
Cooling 3: Processor 0 of 10

note above, in battery capacity, that this is a one-week old laptop,
in case that is relevant.

[X.] Other notes

I am getting ACPI errors (out of a lot of ACPI-related output) in my dmesg:

(...)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
ACPI Error (dsfield-0140): [CAPB] Namespace lookup failure, AE_ALREADY_EXISTS
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0._OSC] (Node f7015a80), AE_ALREADY_EXISTS
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
(...)
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:01: io resource (0x164e-0x164f) overlaps 0000:00:1c.3 BAR 13
(0x1000-0x1fff), disabling
pnp: PnP ACPI: found 9 devices
(...)
Freeing initrd memory: 741k freed
Simple Boot Flag value 0x5 read from CMOS RAM was invalid
Simple Boot Flag at 0x44 set to 0x1
apm: BIOS not found.
Scanning for low memory corruption every 60 seconds
audit: initializing netlink socket (disabled)
type=2000 audit(1259889082.540:1): initialized
(...)
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x000060a0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Error (dsfield-0140): [CAPB] Namespace lookup failure, AE_ALREADY_EXISTS
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0._OSC] (Node f7015a80), AE_ALREADY_EXISTS
ACPI Error (dsfield-0140): [CAPB] Namespace lookup failure, AE_ALREADY_EXISTS
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0._OSC] (Node f7015a80), AE_ALREADY_EXISTS
ACPI Error (dsfield-0140): [CAPB] Namespace lookup failure, AE_ALREADY_EXISTS
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0._OSC] (Node f7015a80), AE_ALREADY_EXISTS
ACPI Error (dsfield-0140): [CAPB] Namespace lookup failure, AE_ALREADY_EXISTS
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0._OSC] (Node f7015a80), AE_ALREADY_EXISTS
pciehp 0000:00:1c.0:pcie04: Bypassing BIOS check for pciehp use on 0000:00:1c.0
pciehp 0000:00:1c.0:pcie04: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
(...)
acer-wmi: Acer Laptop ACPI-WMI Extras
thermal LNXTHERM:01: registered as thermal_zone0
(...)
acer-wmi: Unable to detect available WMID devices
acerhdf: Acer Aspire One Fan driver, v.0.5.13
acerhdf: no Aspire One hardware found


Please let me know what other input might be helpful,
Thanks so much in advance,
v.
