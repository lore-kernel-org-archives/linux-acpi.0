From: Alan Pater <alan.pater@gmail.com>
Subject: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Mon, 27 Oct 2014 10:15:03 -0500
Message-ID: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40839 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbaJ0PP0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2014 11:15:26 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so5823405lbv.5
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2014 08:15:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

When resuming from sleep by opening the laptop lid, backlight control
via Fn-F6 and Fn-F7 no longer works. Rebooting restores that
functionality. The laptop is a Toshiba Portege R700-PT311Q. It is
running Ubuntu 14.04, with the upstream kernel 3.17.

I had first reported this on launchpad and was asked to report the
issue to this list.

The launchpad report is here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1385453
It looks to me like there is a kernel bugzilla report as well:
https://bugzilla.kernel.org/show_bug.cgi?id=21012
A search on Google results in multiple similar reports on other
Toshiba Portege models.


Following are all the system details.

~$ /usr/src/linux-headers-3.17.1-031701/scripts/ver_linux

Linux hawk 3.17.1-031701-generic #201410150735 SMP Wed Oct 15 11:36:31
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         xt_addrtype xt_conntrack dm_thin_pool
dm_persistent_data dm_bio_prison dm_bufio libcrc32c xt_CHECKSUM
iptable_mangle ipt_MASQUERADE iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp bridge stp
llc ctr iptable_filter ip_tables ccm x_tables snd_hda_codec_hdmi arc4
snd_hda_codec_realtek rfcomm snd_hda_codec_generic intel_powerclamp
iwldvm coretemp bnep kvm_intel kvm mac80211 snd_hda_intel btusb
crct10dif_pclmul snd_hda_controller i915 crc32_pclmul snd_hda_codec
ghash_clmulni_intel aesni_intel snd_hwdep bluetooth snd_pcm
snd_seq_midi snd_seq_midi_event snd_rawmidi binfmt_misc snd_seq
iwlwifi aes_x86_64 lrw snd_seq_device gf128mul glue_helper snd_timer
ablk_helper cryptd drm_kms_helper drm snd soundcore mei_me cfg80211
mei toshiba_acpi i2c_algo_bit joydev serio_raw sparse_keymap intel_ips
wmi toshiba_haps toshiba_bluetooth lpc_ich parport_pc video ppdev
tpm_infineon lp parport mac_hid psmouse e1000e ahci sdhci_pci libahci
ptp sdhci pps_core

~$ cat /proc/version
Linux version 3.17.1-031701-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201410150735 SMP Wed Oct 15 11:36:31
UTC 2014

~$ lsb_release -rd
Description:    Ubuntu 14.04.1 LTS
Release:    14.04

 ~# cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
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
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes
lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept vpid
bugs        :
bogomips    : 4788.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1333.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes
lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept vpid
bugs        :
bogomips    : 4788.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes
lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept vpid
bugs        :
bogomips    : 4788.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes
lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept vpid
bugs        :
bogomips    : 4788.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

~# cat /proc/modules
xt_addrtype 12713 2 - Live 0xffffffffc08c9000
xt_conntrack 12760 1 - Live 0xffffffffc08a9000
dm_thin_pool 57708 1 - Live 0xffffffffc08d0000
dm_persistent_data 62569 1 dm_thin_pool, Live 0xffffffffc08b8000
dm_bio_prison 15526 1 dm_thin_pool, Live 0xffffffffc08af000
dm_bufio 28196 1 dm_persistent_data, Live 0xffffffffc08a1000
libcrc32c 12644 1 dm_persistent_data, Live 0xffffffffc089c000
xt_CHECKSUM 12549 1 - Live 0xffffffffc0897000
iptable_mangle 12734 1 - Live 0xffffffffc0892000
ipt_MASQUERADE 12880 2 - Live 0xffffffffc088d000
iptable_nat 13110 1 - Live 0xffffffffc0888000
nf_conntrack_ipv4 14857 2 - Live 0xffffffffc0883000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0xffffffffc0873000
nf_nat_ipv4 13316 1 iptable_nat, Live 0xffffffffc086e000
nf_nat 26308 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live 0xffffffffc087b000
nf_conntrack 105636 6
xt_conntrack,ipt_MASQUERADE,iptable_nat,nf_conntrack_ipv4,nf_nat_ipv4,nf_nat,
Live 0xffffffffc076e000
xt_tcpudp 12924 5 - Live 0xffffffffc0567000
bridge 122058 0 - Live 0xffffffffc084f000
stp 12976 1 bridge, Live 0xffffffffc06a7000
llc 14441 2 bridge,stp, Live 0xffffffffc0562000
ctr 13193 2 - Live 0xffffffffc055d000
iptable_filter 12810 1 - Live 0xffffffffc053f000
ip_tables 27718 3 iptable_mangle,iptable_nat,iptable_filter, Live
0xffffffffc054b000
ccm 17856 2 - Live 0xffffffffc0545000
x_tables 34102 8
xt_addrtype,xt_conntrack,xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_tcpudp,iptable_filter,ip_tables,
Live 0xffffffffc0535000
snd_hda_codec_hdmi 52620 1 - Live 0xffffffffc0527000
arc4 12573 2 - Live 0xffffffffc0522000
snd_hda_codec_realtek 78564 1 - Live 0xffffffffc083a000
rfcomm 75114 8 - Live 0xffffffffc075a000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0xffffffffc068b000
intel_powerclamp 19099 0 - Live 0xffffffffc051c000
iwldvm 243857 0 - Live 0xffffffffc07fd000
coretemp 13638 0 - Live 0xffffffffc0517000
bnep 19884 2 - Live 0xffffffffc04e2000
kvm_intel 149257 0 - Live 0xffffffffc09c5000
kvm 468567 1 kvm_intel, Live 0xffffffffc0789000
mac80211 696913 1 iwldvm, Live 0xffffffffc06ae000
snd_hda_intel 30783 3 - Live 0xffffffffc069e000
btusb 32408 0 - Live 0xffffffffc0554000
crct10dif_pclmul 14268 0 - Live 0xffffffffc050e000
snd_hda_controller 32234 1 snd_hda_intel, Live 0xffffffffc04d9000
i915 993210 9 - Live 0xffffffffc0597000
crc32_pclmul 13180 0 - Live 0xffffffffc0430000
snd_hda_codec 145035 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0xffffffffc04e9000
ghash_clmulni_intel 13230 0 - Live 0xffffffffc03de000
aesni_intel 165469 5 - Live 0xffffffffc056d000
snd_hwdep 17709 1 snd_hda_codec, Live 0xffffffffc042a000
bluetooth 477455 22 rfcomm,bnep,btusb, Live 0xffffffffc0463000
snd_pcm 105052 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0xffffffffc0448000
snd_seq_midi 13564 0 - Live 0xffffffffc0425000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffc034d000
snd_rawmidi 31197 1 snd_seq_midi, Live 0xffffffffc03e9000
binfmt_misc 17508 1 - Live 0xffffffffc03b6000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc0437000
iwlwifi 190863 1 iwldvm, Live 0xffffffffc03f5000
aes_x86_64 17131 1 aesni_intel, Live 0xffffffffc03e3000
lrw 13323 1 aesni_intel, Live 0xffffffffc03d9000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffc028c000
gf128mul 14951 1 lrw, Live 0xffffffffc03b1000
glue_helper 14095 1 aesni_intel, Live 0xffffffffc0279000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0xffffffffc03a8000
ablk_helper 13597 1 aesni_intel, Live 0xffffffffc0348000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0xffffffffc03a1000
drm_kms_helper 99872 1 i915, Live 0xffffffffc03bf000
drm 318542 6 i915,drm_kms_helper, Live 0xffffffffc0352000
snd 84025 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffc0332000
soundcore 15091 2 snd_hda_codec,snd, Live 0xffffffffc0260000
mei_me 19524 0 - Live 0xffffffffc02ab000
cfg80211 514757 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffc02b3000
mei 88810 1 mei_me, Live 0xffffffffc0294000
toshiba_acpi 28375 0 - Live 0xffffffffc0284000
i2c_algo_bit 13564 1 i915, Live 0xffffffffc0274000
joydev 17587 0 - Live 0xffffffffc027e000
serio_raw 13483 0 - Live 0xffffffffc0268000
sparse_keymap 13890 1 toshiba_acpi, Live 0xffffffffc01b1000
intel_ips 18534 0 - Live 0xffffffffc026e000
wmi 19379 1 toshiba_acpi, Live 0xffffffffc025a000
toshiba_haps 13311 0 - Live 0xffffffffc0252000
toshiba_bluetooth 12867 0 - Live 0xffffffffc01a5000
lpc_ich 21176 0 - Live 0xffffffffc023f000
parport_pc 32906 0 - Live 0xffffffffc0248000
video 20569 1 i915, Live 0xffffffffc0238000
ppdev 17711 0 - Live 0xffffffffc0232000
tpm_infineon 17169 0 - Live 0xffffffffc022c000
lp 17799 0 - Live 0xffffffffc01bf000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffc01ff000
mac_hid 13275 0 - Live 0xffffffffc018d000
psmouse 118039 0 - Live 0xffffffffc020e000
e1000e 230063 0 - Live 0xffffffffc01c5000
ahci 30167 3 - Live 0xffffffffc01b6000
sdhci_pci 23392 0 - Live 0xffffffffc01aa000
libahci 32533 1 ahci, Live 0xffffffffc019c000
ptp 19534 1 e1000e, Live 0xffffffffc0192000
sdhci 44159 1 sdhci_pci, Live 0xffffffffc0181000
pps_core 19381 1 ptp, Live 0xffffffffc0177000

~# cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
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
    00f0-00f0 : PNP0C04:00
  01e0-01e7 : pnp 00:04
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-053f : pnp 00:03
  0680-06ff : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:03
  2000-2fff : PCI Bus 0000:03
  3000-301f : 0000:00:1f.2
    3000-301f : ahci
  3020-303f : 0000:00:19.0
  3040-3047 : 0000:00:1f.2
    3040-3047 : ahci
  3048-304f : 0000:00:1f.2
    3048-304f : ahci
  3058-305f : 0000:00:02.0
  3060-3063 : 0000:00:1f.2
    3060-3063 : ahci
  3064-3067 : 0000:00:1f.2
    3064-3067 : ahci
  4000-4fff : PCI Bus 0000:01
  5000-5fff : PCI Bus 0000:02
  6000-6fff : PCI Bus 0000:05
  ffff-ffff : pnp 00:03
    ffff-ffff : pnp 00:03

~# cat /proc/iomem
00000000-00000fff : reserved
00001000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000cf800-000d07ff : Adapter ROM
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-b70cffff : System RAM
  01000000-017a9b37 : Kernel code
  017a9b38-01d1e5ff : Kernel data
  01e80000-01fc6fff : Kernel bss
b70d0000-b70d01ff : ACPI Non-volatile Storage
b70d0200-b70d1fff : reserved
b70d2000-b71cffff : ACPI Non-volatile Storage
b71d0000-b71effff : ACPI Tables
b71f0000-bfffffff : reserved
  bc000000-bfffffff : Graphics Stolen Memory
c0000000-feafffff : PCI Bus 0000:00
  c0000000-cfffffff : 0000:00:02.0
  d0000000-d03fffff : 0000:00:02.0
  d0400000-d23fffff : PCI Bus 0000:03
  d2400000-d24fffff : PCI Bus 0000:05
  d2500000-d44fffff : PCI Bus 0000:03
  d4500000-d45fffff : PCI Bus 0000:02
    d4500000-d4501fff : 0000:02:00.0
      d4500000-d4501fff : iwlwifi
  d4600000-d46fffff : PCI Bus 0000:01
    d4600000-d46000ff : 0000:01:00.0
      d4600000-d46000ff : mmc0
  d4700000-d471ffff : 0000:00:19.0
    d4700000-d471ffff : e1000e
  d4720000-d4723fff : 0000:00:1b.0
    d4720000-d4723fff : ICH HD audio
  d4724000-d472400f : 0000:00:16.0
    d4724000-d472400f : mei_me
  d4725000-d4725fff : Intel Flush Page
  d4726000-d4726fff : 0000:00:1f.6
    d4726000-d4726fff : ips thermal sensor
  d4727000-d47277ff : 0000:00:1f.2
    d4727000-d47277ff : ahci
  d4728000-d47283ff : 0000:00:1d.0
    d4728000-d47283ff : ehci_hcd
  d4729000-d47293ff : 0000:00:1a.0
    d4729000-d47293ff : ehci_hcd
  d472a000-d472afff : 0000:00:19.0
    d472a000-d472afff : e1000e
  d4800000-d4800fff : pnp 00:00
  d4900000-d4afffff : PCI Bus 0000:01
  d4b00000-d4cfffff : PCI Bus 0000:02
  d4d00000-d4efffff : PCI Bus 0000:05
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
feb00000-feb03fff : pnp 00:00
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:02
fed10000-fed13fff : reserved
  fed10000-fed13fff : pnp 00:00
fed18000-fed19fff : reserved
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffe00000-ffffffff : reserved
100000000-137ffffff : System RAM


~# lspci -vvv
00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 02)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Core Processor
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
    Subsystem: Toshiba America Info Systems Device 0007
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 28
    Region 0: Memory at d0000000 (64-bit, non-prefetchable) [size=4M]
    Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 3058 [size=8]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0100c  Data: 4142
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 5 Series/3400
Series Chipset HECI Controller (rev 06)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 25
    Region 0: Memory at d4724000 (64-bit, non-prefetchable) [size=16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4192
    Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82577LM Gigabit Network
Connection (rev 06)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 29
    Region 0: Memory at d4700000 (32-bit, non-prefetchable) [disabled]
[size=128K]
    Region 1: Memory at d472a000 (32-bit, non-prefetchable) [disabled] [size=4K]
    Region 2: I/O ports at 3020 [disabled] [size=32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41d2
    Capabilities: [e0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at d4729000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 06)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 26
    Region 0: Memory at d4720000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41a2
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
    Capabilities: [100 v1] Virtual Channel
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
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=02
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=00 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 06) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: d4600000-d46fffff
    Prefetchable memory behind bridge: 00000000d4900000-00000000d4afffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 2 (rev 06) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00005000-00005fff
    Memory behind bridge: d4500000-d45fffff
    Prefetchable memory behind bridge: 00000000d4b00000-00000000d4cfffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 3 (rev 06) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: d2500000-d44fffff
    Prefetchable memory behind bridge: 00000000d0400000-00000000d23fffff
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
        LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
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
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 4 (rev 06) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00006000-00006fff
    Memory behind bridge: d2400000-d24fffff
    Prefetchable memory behind bridge: 00000000d4d00000-00000000d4efffff
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
        LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
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
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at d4728000 (32-bit, non-prefetchable) [size=1K]
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

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a6)
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=64
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Toshiba America Info Systems Device 0001

00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 06)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=10 <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series
Chipset 6 port SATA AHCI Controller (rev 06) (prog-if 01 [AHCI 1.0])
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 24
    Region 0: I/O ports at 3048 [size=8]
    Region 1: I/O ports at 3064 [size=4]
    Region 2: I/O ports at 3040 [size=8]
    Region 3: I/O ports at 3060 [size=4]
    Region 4: I/O ports at 3000 [size=32]
    Region 5: Memory at d4727000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0c00c  Data: 41b1
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

00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
Series Chipset Thermal Subsystem (rev 06)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 18
    Region 0: Memory at d4726000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Kernel driver in use: intel ips

01:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 01)
    Subsystem: Toshiba America Info Systems Device 0001
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at d4600000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
    Capabilities: [80] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [800 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Kernel driver in use: sdhci-pci

02:00.0 Network controller: Intel Corporation Centrino Advanced-N 6200 (rev 35)
    Subsystem: Intel Corporation Centrino Advanced-N 6200 2x2 AGN
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 27
    Region 0: Memory at d4500000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0400c  Data: 4122
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <128ns, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
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
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number 00-27-10-ff-ff-58-91-78
    Kernel driver in use: iwlwifi

ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-core Registers (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0


~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA MQ01ABD1 Rev: 1U
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: DVD-RAM UJ892ES  Rev: 1.20
  Type:   CD-ROM                           ANSI  SCSI revision: 05


~# ls /proc
1      13814  1500  1723   18199  20404  2217  2657  2780  2960  3169
42   56    7     98           fs          mounts         timer_stats
10     13871  1501  1729   18454  20414  23    2658  2784  2970  32
43   57    700   99           interrupts  mtrr           tty
1014   13872  153   17328  185    20416  24    2662  2788  2974  3215
44   61    717   acpi         iomem       net            uptime
1018   13873  154   17331  18569  20452  25    2676  2798  2981  33
45   610   718   asound       ioports     pagetypeinfo   version
1030   13874  155   17332  186    20471  2540  2680  28    2992  34
46   62    744   buddyinfo    irq         partitions     vmallocinfo
1031   1390   156   17333  1899   20665  2542  2685  2804  2998  3465
47   63    75    bus          kallsyms    sched_debug    vmstat
1035   1399   157   1752   19     2076   26    2686  2807  3     36
48   641   757   cgroups      kcore       schedstat      zoneinfo
1065   14     158   1755   19063  21     2606  2691  2834  3002  368
486  652   76    cmdline      keys        scsi
11     1401   159   1797   19096  21080  2611  2694  2845  3010  37
487  6577  77    consoles     key-users   self
1108   1413   16    1798   19102  21135  2618  27    2862  3018  375
488  6586  79    cpuinfo      kmsg        slabinfo
1135   1414   160   1799   19103  21446  2621  2701  2864  3019  38
49   6587  795   crypto       kpagecount  softirqs
1174   1424   161   18     1913   21448  2623  2704  2897  302   381
5    664   8     devices      kpageflags  stat
1175   14254  162   1802   19131  21449  2626  2719  2899  31    3822
50   668   879   diskstats    loadavg     swaps
12     1468   163   1803   1916   21451  2635  2735  29    3103  384
51   673   888   dma          locks       sys
1294   1497   164   1804   2      21523  2640  2736  2944  3109  39
52   678   9     driver       mdstat      sysrq-trigger
13     1498   165   1805   20     21700  2649  2741  2947  3147  392
54   686   902   execdomains  meminfo     sysvipc
1320   1499   1682  1806   2003   2192   2655  2747  2953  3153  393
542  687   906   fb           misc        thread-self
13811  15     17    1807   20148  22     2656  2762  2954  3155  41
55   691   9154  filesystems  modules     timer_list
