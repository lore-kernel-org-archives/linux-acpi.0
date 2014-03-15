From: ign_christian@yahoo.com
Subject: [HP Pavilion dm3-1109tu Entertainment Notebook PC] Brightness Keys not working after restarting system from Windows 7
Date: Fri, 14 Mar 2014 22:24:24 -0700 (PDT)
Message-ID: <1394861064.66124.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Reply-To: ign_christian@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm22-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.182]:24793 "EHLO
	nm22-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbaCOFaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Mar 2014 01:30:05 -0400
References: 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

[1.] One line summary of the problem:=A0
[HP Pavilion dm3-1109tu Entertainment Notebook PC] Brightness Keys not =
working after restarting system from Windows 7

[2.] Full description of the problem/report:=A0
After I start system to Windows 7 then restart my laptop (soft reboot) =
to Ubuntu 12.04, brightness keys not working and reset to 100%.

Restart & restart again to Ubuntu not make brightness keys working.

WORKAROUND: Shutdown laptop then power on again to Ubuntu (hard reboot)=
, or manually change brightnes via System Settings > Brightness & Lock.

[3.] Keywords (i.e., modules, networking, kernel): -

[4.] Kernel version (from /proc/version):=A0

$ cat /proc/version
Linux version 3.14.0-031400rc6-generic (apw@gomeisa) (gcc version 4.6.3=
 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201403100035 SMP Mon Mar 10 04:57:43=
 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information=
 resolved (see Documentation/oops-tracing.txt)=A0
I don't whether it's relevant, while booting & after selecting kernel f=
ollowing messange appear (not happen in original Precise kernel) :

[ 1,695383] ACPI: [Package] has zero elements (f72dab40)

Note: that code/number changes in another boot, and there is also anoth=
er message after the message that I couldn't catch

[6.] A small shell script or example program which triggers the problem=
 (if possible)=A0
-

[7.] Environment=A0
$ lsb_release -rd
Description:Ubuntu 12.04.4 LTS
Release:12.04=A0

[7.1.] Software (add the output of the ver_linux script here)=A0

$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=A0
Linux ubuntu 3.14.0-031400rc6-generic #201403100035 SMP Mon Mar 10 04:5=
7:43 UTC 2014 i686 i686 i386 GNU/Linux
=A0
Gnu C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04.6
Gnu make =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.81
binutils =A0 =A0 =A0 =A0 =A0 =A0 =A0 2.22
util-linux =A0 =A0 =A0 =A0 =A0 =A0 2.20.1
mount =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0support
module-init-tools =A0 =A0 =A03.16
e2fsprogs =A0 =A0 =A0 =A0 =A0 =A0 =A01.42
pcmciautils =A0 =A0 =A0 =A0 =A0 =A0018
PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.4.5
Linux C Library =A0 =A0 =A0 =A02.15
Dynamic linker (ldd) =A0 2.15
Procps =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.2.8
Net-tools =A0 =A0 =A0 =A0 =A0 =A0 =A01.60
Kbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01.15.2
Sh-utils =A0 =A0 =A0 =A0 =A0 =A0 =A0 8.13
wireless-tools =A0 =A0 =A0 =A0 30
Modules Loaded =A0 =A0 =A0 =A0 ctr ccm nls_utf8 cifs fscache xt_hl ip6t=
_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT xt_LOG xt_multiport xt_=
limit snd_hda_codec_hdmi xt_tcpudp xt_addrtype snd_hda_codec_idt snd_hd=
a_codec_generic nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ip6table_filt=
er ip6_tables arc4 nf_conntrack_netbios_ns ath9k snd_hda_intel nf_connt=
rack_broadcast nf_nat_ftp snd_hda_codec bnep mac80211 nf_nat rfcomm nf_=
conntrack_ftp nf_conntrack snd_hwdep uvcvideo bluetooth snd_pcm iptable=
_filter snd_seq_midi videobuf2_core ath9k_common ip_tables snd_rawmidi =
i915 ath9k_hw videodev snd_seq_midi_event 6lowpan_iphc x_tables snd_seq=
 videobuf2_vmalloc parport_pc snd_timer videobuf2_memops snd_seq_device=
 ppdev ath hp_wmi psmouse sparse_keymap drm_kms_helper drm hp_accel cfg=
80211 serio_raw lis3lv02d lpc_ich snd i2c_algo_bit joydev soundcore inp=
ut_polldev wmi video mac_hid binfmt_misc lp parport hid_generic usbhid =
hid ahci libahci r8169 mii=A0

[7.2.] Processor information (from /proc/cpuinfo):=A0

$ cat /proc/cpuinfo
processor: 0
vendor_id: GenuineIntel
cpu family: 6
model: 23
model name: Genuine Intel(R) CPU =A0 =A0 =A0 =A0 =A0 U4100 =A0@ 1.30GHz
stepping: 10
microcode: 0xa07
cpu MHz: 1200.000
cache size: 2048 KB
physical id: 0
siblings: 2
core id: 0
cpu cores: 2
apicid: 0
initial apicid: 0
fdiv_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 13
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_=
tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 =
ssse3 cx16 xtpr pdcm xsave lahf_lm dtherm
bogomips: 2593.36
clflush size: 64
cache_alignment: 64
address sizes: 36 bits physical, 48 bits virtual
power management:

processor: 1
vendor_id: GenuineIntel
cpu family: 6
model: 23
model name: Genuine Intel(R) CPU =A0 =A0 =A0 =A0 =A0 U4100 =A0@ 1.30GHz
stepping: 10
microcode: 0xa07
cpu MHz: 1200.000
cache size: 2048 KB
physical id: 0
siblings: 2
core id: 1
cpu cores: 2
apicid: 1
initial apicid: 1
fdiv_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 13
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_=
tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 =
ssse3 cx16 xtpr pdcm xsave lahf_lm dtherm
bogomips: 2593.36
clflush size: 64
cache_alignment: 64
address sizes: 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):=A0
$ cat /proc/modules

ctr 13025 2 - Live 0x00000000
ccm 17596 2 - Live 0x00000000
nls_utf8 12493 0 - Live 0x00000000
cifs 421541 0 - Live 0x00000000
fscache 57040 1 cifs, Live 0x00000000
xt_hl 12465 6 - Live 0x00000000
ip6t_rt 13259 3 - Live 0x00000000
nf_conntrack_ipv6 18458 7 - Live 0x00000000
nf_defrag_ipv6 26297 1 nf_conntrack_ipv6, Live 0x00000000
ipt_REJECT 12515 1 - Live 0x00000000
xt_LOG 17542 9 - Live 0x00000000
xt_multiport 12694 4 - Live 0x00000000
xt_limit 12541 12 - Live 0x00000000
snd_hda_codec_hdmi 46041 1 - Live 0x00000000
xt_tcpudp 12788 22 - Live 0x00000000
xt_addrtype 12625 4 - Live 0x00000000
snd_hda_codec_idt 49394 1 - Live 0x00000000
snd_hda_codec_generic 63224 1 snd_hda_codec_idt, Live 0x00000000
nf_conntrack_ipv4 14361 7 - Live 0x00000000
nf_defrag_ipv4 12649 1 nf_conntrack_ipv4, Live 0x00000000
xt_state 12514 14 - Live 0x00000000
ip6table_filter 12711 1 - Live 0x00000000
ip6_tables 18135 1 ip6table_filter, Live 0x00000000
arc4 12509 2 - Live 0x00000000
nf_conntrack_netbios_ns 12585 0 - Live 0x00000000
ath9k 149810 0 - Live 0x00000000
snd_hda_intel 43398 3 - Live 0x00000000
nf_conntrack_broadcast 12541 1 nf_conntrack_netbios_ns, Live 0x00000000
nf_nat_ftp 12692 0 - Live 0x00000000
snd_hda_codec 119362 4 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_cod=
ec_generic,snd_hda_intel, Live 0x00000000
bnep 19107 2 - Live 0x00000000
mac80211 582807 1 ath9k, Live 0x00000000
nf_nat 21081 1 nf_nat_ftp, Live 0x00000000
rfcomm 59012 0 - Live 0x00000000
nf_conntrack_ftp 14117 1 nf_nat_ftp, Live 0x00000000
nf_conntrack 87867 8 nf_conntrack_ipv6,nf_conntrack_ipv4,xt_state,nf_co=
nntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrac=
k_ftp, Live 0x00000000
snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
uvcvideo 72275 0 - Live 0x00000000
bluetooth 375778 10 bnep,rfcomm, Live 0x00000000
snd_pcm 96053 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x=
00000000
iptable_filter 12706 1 - Live 0x00000000
snd_seq_midi 13132 0 - Live 0x00000000
videobuf2_core 39843 1 uvcvideo, Live 0x00000000
ath9k_common 13359 1 ath9k, Live 0x00000000
ip_tables 18303 1 iptable_filter, Live 0x00000000
snd_rawmidi 25198 1 snd_seq_midi, Live 0x00000000
i915 737884 5 - Live 0x00000000
ath9k_hw 438878 2 ath9k,ath9k_common, Live 0x00000000
videodev 122418 2 uvcvideo,videobuf2_core, Live 0x00000000
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
6lowpan_iphc 18480 1 bluetooth, Live 0x00000000
x_tables 22180 13 xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_multiport,xt_limit=
,xt_tcpudp,xt_addrtype,xt_state,ip6table_filter,ip6_tables,iptable_filt=
er,ip_tables, Live 0x00000000
snd_seq 55716 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
parport_pc 32114 0 - Live 0x00000000
snd_timer 28971 2 snd_pcm,snd_seq, Live 0x00000000
videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
0
ppdev 17423 0 - Live 0x00000000
ath 24509 3 ath9k,ath9k_common,ath9k_hw, Live 0x00000000
hp_wmi 17834 0 - Live 0x00000000
psmouse 97104 0 - Live 0x00000000
sparse_keymap 13658 1 hp_wmi, Live 0x00000000
drm_kms_helper 47293 1 i915, Live 0x00000000
drm 249035 6 i915,drm_kms_helper, Live 0x00000000
hp_accel 25756 0 - Live 0x00000000
cfg80211 447796 3 ath9k,mac80211,ath, Live 0x00000000
serio_raw 13230 0 - Live 0x00000000
lis3lv02d 19600 1 hp_accel, Live 0x00000000
lpc_ich 16987 0 - Live 0x00000000
snd 61456 18 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_codec_generic=
,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi=
,snd_seq,snd_timer,snd_seq_device, Live 0x00000000
i2c_algo_bit 13316 1 i915, Live 0x00000000
joydev 17299 0 - Live 0x00000000
soundcore 12600 1 snd, Live 0x00000000
input_polldev 13648 1 lis3lv02d, Live 0x00000000
wmi 18827 1 hp_wmi, Live 0x00000000
video 19330 1 i915, Live 0x00000000
mac_hid 13077 0 - Live 0x00000000
binfmt_misc 13172 1 - Live 0x00000000
lp 13359 0 - Live 0x00000000
parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
hid_generic 12492 0 - Live 0x00000000
usbhid 47406 0 - Live 0x00000000
hid 87718 2 hid_generic,usbhid, Live 0x00000000
ahci 29802 1 - Live 0x00000000
libahci 30899 1 ahci, Live 0x00000000
r8169 62856 0 - Live 0x00000000
mii 13693 1 r8169, Live 0x00000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em)=A0

$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
=A0 0000-001f : dma1
=A0 0020-0021 : pic1
=A0 0040-0043 : timer0
=A0 0050-0053 : timer1
=A0 0060-0060 : keyboard
=A0 0062-0062 : EC data
=A0 0064-0064 : keyboard
=A0 0066-0066 : EC cmd
=A0 0070-0077 : rtc0
=A0 0080-008f : dma page reg
=A0 00a0-00a1 : pic2
=A0 00c0-00df : dma2
=A0 00f0-00ff : fpu
=A0 03c0-03df : vesafb
=A0 0400-0403 : ACPI PM1a_EVT_BLK
=A0 0404-0405 : ACPI PM1a_CNT_BLK
=A0 0408-040b : ACPI PM_TMR
=A0 0410-0415 : ACPI CPU throttle
=A0 0420-042f : ACPI GPE0_BLK
=A0 0430-0433 : iTCO_wdt
=A0 0450-0450 : ACPI PM2_CNT_BLK
=A0 0460-047f : iTCO_wdt
=A0 0500-053f : pnp 00:00
=A0 0600-060f : pnp 00:00
=A0 0610-0610 : pnp 00:00
=A0 0800-080f : pnp 00:00
=A0 0810-0817 : pnp 00:00
=A0 0820-0823 : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
=A0 164e-164f : pnp 00:00
=A0 2000-2fff : PCI Bus 0000:02
=A0 =A0 2000-20ff : 0000:02:00.0
=A0 =A0 =A0 2000-20ff : r8169
=A0 3000-3fff : PCI Bus 0000:01
=A0 4000-401f : 0000:00:1f.3
=A0 4020-403f : 0000:00:1f.2
=A0 =A0 4020-403f : ahci
=A0 4040-405f : 0000:00:1d.2
=A0 =A0 4040-405f : uhci_hcd
=A0 4060-407f : 0000:00:1d.1
=A0 =A0 4060-407f : uhci_hcd
=A0 4080-409f : 0000:00:1d.0
=A0 =A0 4080-409f : uhci_hcd
=A0 40a0-40bf : 0000:00:1a.2
=A0 =A0 40a0-40bf : uhci_hcd
=A0 40c0-40df : 0000:00:1a.0
=A0 =A0 40c0-40df : uhci_hcd
=A0 40e0-40e7 : 0000:00:1f.2
=A0 =A0 40e0-40e7 : ahci
=A0 40e8-40ef : 0000:00:1f.2
=A0 =A0 40e8-40ef : ahci
=A0 40f0-40f7 : 0000:00:02.0
=A0 40f8-40fb : 0000:00:1f.2
=A0 =A0 40f8-40fb : ahci
=A0 40fc-40ff : 0000:00:1f.2
=A0 =A0 40fc-40ff : ahci

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
=A0 000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000fffff : reserved
=A0 000f0000-000fffff : System ROM
00100000-79bcefff : System RAM
=A0 01000000-0169cfb4 : Kernel code
=A0 0169cfb5-01a16e7f : Kernel data
=A0 01afd000-01be1fff : Kernel bss
79bcf000-79bd0fff : ACPI Non-volatile Storage
79bd1000-7ba6afff : System RAM
7ba6b000-7babefff : reserved
7babf000-7bb7ffff : System RAM
7bb80000-7bbbefff : ACPI Non-volatile Storage
7bbbf000-7bbddfff : System RAM
7bbde000-7bbf6fff : ACPI Tables
7bbf7000-7bbfffff : System RAM
7bc00000-7fffffff : reserved
=A0 7c000000-7fffffff : Graphics Stolen Memory
80000000-febfffff : PCI Bus 0000:00
=A0 80000000-8fffffff : 0000:00:02.0
=A0 90000000-903fffff : 0000:00:02.0
=A0 90400000-913fffff : PCI Bus 0000:01
=A0 91400000-923fffff : PCI Bus 0000:02
=A0 =A0 91400000-9140ffff : 0000:02:00.0
=A0 =A0 =A0 91400000-9140ffff : r8169
=A0 =A0 91410000-91410fff : 0000:02:00.0
=A0 =A0 =A0 91410000-91410fff : r8169
=A0 =A0 91420000-9143ffff : 0000:02:00.0
=A0 92400000-924fffff : 0000:00:02.1
=A0 92500000-934fffff : PCI Bus 0000:02
=A0 93500000-944fffff : PCI Bus 0000:01
=A0 =A0 93500000-9350ffff : 0000:01:00.0
=A0 =A0 =A0 93500000-9350ffff : ath9k
=A0 94500000-94503fff : 0000:00:1b.0
=A0 =A0 94500000-94503fff : ICH HD audio
=A0 94504000-94504fff : 0000:00:1f.6
=A0 94505000-945057ff : 0000:00:1f.2
=A0 =A0 94505000-945057ff : ahci
=A0 94505800-94505bff : 0000:00:1d.7
=A0 =A0 94505800-94505bff : ehci_hcd
=A0 94505c00-94505fff : 0000:00:1a.7
=A0 =A0 94505c00-94505fff : ehci_hcd
=A0 94506000-945060ff : 0000:00:1f.3
=A0 94507000-94507fff : Intel Flush Page
=A0 f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
=A0 =A0 f8000000-fbffffff : reserved
=A0 =A0 =A0 f8000000-fbffffff : pnp 00:00
fec00000-fec00fff : reserved
=A0 fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed13fff : reserved
=A0 fed10000-fed13fff : pnp 00:00
fed18000-fed19fff : reserved
=A0 fed18000-fed18fff : pnp 00:00
=A0 fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
=A0 fed1c000-fed1ffff : pnp 00:00
=A0 =A0 fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
=A0 fee00000-fee00fff : reserved
=A0 =A0 fee00000-fee00fff : pnp 00:00
ffe00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)=A0

$ sudo lspci -vvv
[sudo] password for christian:=A0
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory C=
ontroller Hub (rev 07)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0a <?>
Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Ch=
ipset Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controll=
er])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 44
Region 0: Memory at 90000000 (64-bit, non-prefetchable) [size=3D4M]
Region 2: Memory at 80000000 (64-bit, prefetchable) [size=3D256M]
Region 4: I/O ports at 40f0 [size=3D8]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0100c =A0Data: 41e1
Capabilities: [d0] Power Management version 3
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: i915
Kernel modules: i915

00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset I=
ntegrated Graphics Controller (rev 07)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Region 0: Memory at 92400000 (64-bit, non-prefetchable) [size=3D1M]
Capabilities: [d0] Power Management version 3
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #4 (rev 03) (prog-if 00 [UHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 4: I/O ports at 40c0 [size=3D32]
Capabilities: [50] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #6 (rev 03) (prog-if 00 [UHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 4: I/O ports at 40a0 [size=3D32]
Capabilities: [50] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHC=
I Controller #2 (rev 03) (prog-if 20 [EHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at 94505c00 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio C=
ontroller (rev 03)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 45
Region 0: Memory at 94500000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0100c =A0Data: 4142
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE- FLReset+
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns=
, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl:ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt=
- ABWMgmt-
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D7f
Status:NegoPending- InProgress-
VC1:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D80
Status:NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc:PortNumber=3D0f ComponentID=3D02 EltType=3DConfig
Link0:Desc:TargetPort=3D00 TargetComponent=3D02 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
Addr:00000000fed1c000
Kernel driver in use: snd_hda_intel
Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express =
Port 1 (rev 03) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
I/O behind bridge: 00003000-00003fff
Memory behind bridge: 93500000-944fffff
Prefetchable memory behind bridge: 0000000090400000-00000000913fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns=
, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl:ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt=
- ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #0, PowerLimit 6.500W; Interlock- NoCompl-
SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0300c =A0Data: 41a1
Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3649
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed+ WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status:NegoPending- InProgress-
Capabilities: [180 v1] Root Complex Link
Desc:PortNumber=3D01 ComponentID=3D02 EltType=3DConfig
Link0:Desc:TargetPort=3D00 TargetComponent=3D02 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
Addr:00000000fed1c000
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express =
Port 3 (rev 03) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: 92500000-934fffff
Prefetchable memory behind bridge: 0000000091400000-00000000923fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap:Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns=
, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl:ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt=
- ABWMgmt-
SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
SltCtl:Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq- LinkChg+
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0300c =A0Data: 41b1
Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3649
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [100 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed+ WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status:NegoPending- InProgress-
Capabilities: [180 v1] Root Complex Link
Desc:PortNumber=3D03 ComponentID=3D02 EltType=3DConfig
Link0:Desc:TargetPort=3D00 TargetComponent=3D02 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
Addr:00000000fed1c000
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #1 (rev 03) (prog-if 00 [UHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 20
Region 4: I/O ports at 4080 [size=3D32]
Capabilities: [50] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #2 (rev 03) (prog-if 00 [UHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 4: I/O ports at 4060 [size=3D32]
Capabilities: [50] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #3 (rev 03) (prog-if 00 [UHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin D routed to IRQ 16
Region 4: I/O ports at 4040 [size=3D32]
Capabilities: [50] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHC=
I Controller #1 (rev 03) (prog-if 20 [EHCI])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 20
Region 0: Memory at 94505800 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93) =
(prog-if 01 [Subtractive decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D32
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Subsystem: Hewlett-Packard Company Device 3649

00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller =
(rev 03)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
Kernel driver in use: lpc_ich
Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM (ICH9M/ICH9M-E)=
 4 port SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 43
Region 0: I/O ports at 40e8 [size=3D8]
Region 1: I/O ports at 40fc [size=3D4]
Region 2: I/O ports at 40e0 [size=3D8]
Region 3: I/O ports at 40f8 [size=3D4]
Region 4: I/O ports at 4020 [size=3D32]
Region 5: Memory at 94505000 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [80] MSI: Enable+ Count=3D1/16 Maskable- 64bit-
Address: fee0100c =A0Data: 41d1
Capabilities: [70] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci
Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller =
(rev 03)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 5
Region 0: Memory at 94506000 (64-bit, non-prefetchable) [size=3D256]
Region 4: I/O ports at 4000 [size=3D32]
Kernel modules: i2c-i801

00:1f.6 Signal processing controller: Intel Corporation 82801I (ICH9 Fa=
mily) Thermal Subsystem (rev 03)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 5
Region 0: Memory at 94504000 (64-bit, non-prefetchable) [size=3D4K]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network Ad=
apter (PCI-Express) (rev 01)
Subsystem: Hewlett-Packard Company U98Z062.12 802.11bgn Wireless Half-s=
ize Mini PCIe Card
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 16
Region 0: Memory at 93500000 (64-bit, non-prefetchable) [size=3D64K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA PME(D0+,D1+,D2-,D3hot+=
,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 =A0Data: 0000
Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns=
, L1 <64us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status:NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
Capabilities: [170 v1] Power Budgeting <?>
Kernel driver in use: ath9k
Kernel modules: ath9k

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/R=
TL8102E PCI Express Fast Ethernet controller (rev 02)
Subsystem: Hewlett-Packard Company Device 3649
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 42
Region 0: I/O ports at 2000 [size=3D256]
Region 2: Memory at 91410000 (64-bit, prefetchable) [size=3D4K]
Region 4: Memory at 91400000 (64-bit, prefetchable) [size=3D64K]
Expansion ROM at 91420000 [disabled] [size=3D128K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0300c =A0Data: 41c1
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <2us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns=
, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl:ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt=
- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB
Capabilities: [ac] MSI-X: Enable- Count=3D2 Masked-
Vector table: BAR=3D4 offset=3D00000000
PBA: BAR=3D4 offset=3D00000800
Capabilities: [cc] Vital Product Data
Unknown small resource type 00, will not decode more.
Capabilities: [100 v1] Advanced Error Reporting
UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-=
 ECRC- UnsupReq- ACSViol-
UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP=
+ ECRC- UnsupReq- ACSViol-
CESta:RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps:LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:Fixed- WRR32- WRR64- WRR128-
Ctrl:ArbSelect=3DFixed
Status:InProgress-
VC0:Caps:PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status:NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-ff-ff-00-00
Kernel driver in use: r8169
Kernel modules: r8169

[7.6.] SCSI information (from /proc/scsi/scsi)=A0

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
=A0 Vendor: ATA =A0 =A0 =A0Model: WDC WD3200BEKT-6 Rev: 12.0
=A0 Type: =A0 Direct-Access =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ANSI=
 =A0SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please =
look in /proc and include all information that you think to be relevant=
):=A0
$ ls /proc

1 =A0 =A0 1159 =A0140 =A0 17 =A0 =A01857 =A01888 =A01928 =A020 =A0 =A02=
229 =A02356 =A02495 =A0279 =A0485 =A0709 =A0897 =A0 =A0 =A0 =A0cmdline =
=A0 =A0 =A0fs =A0 =A0 =A0 =A0 =A0latency_stats =A0partitions =A0 =A0 sy=
svipc
10 =A0 =A01168 =A01418 =A01714 =A01865 =A019 =A0 =A01938 =A02099 =A0223=
0 =A0236 =A0 2496 =A028 =A0 489 =A0728 =A09 =A0 =A0 =A0 =A0 =A0consoles=
 =A0 =A0 interrupts =A0loadavg =A0 =A0 =A0 =A0sched_debug =A0 =A0timer_=
list
1073 =A012 =A0 =A01420 =A01757 =A01866 =A01901 =A01943 =A021 =A0 =A0223=
1 =A0237 =A0 25 =A0 =A0280 =A049 =A0 741 =A0909 =A0 =A0 =A0 =A0cpuinfo =
=A0 =A0 =A0iomem =A0 =A0 =A0 locks =A0 =A0 =A0 =A0 =A0schedstat =A0 =A0=
 =A0timer_stats
1081 =A01201 =A01423 =A01784 =A01872 =A01903 =A01947 =A02120 =A02235 =A0=
238 =A0 2552 =A029 =A0 5 =A0 =A0768 =A0936 =A0 =A0 =A0 =A0crypto =A0 =A0=
 =A0 ioports =A0 =A0 mdstat =A0 =A0 =A0 =A0 scsi =A0 =A0 =A0 =A0 =A0 tt=
y
11 =A0 =A01235 =A01438 =A01795 =A01873 =A01904 =A01951 =A02171 =A02236 =
=A0239 =A0 26 =A0 =A03 =A0 =A0537 =A0796 =A0952 =A0 =A0 =A0 =A0devices =
=A0 =A0 =A0irq =A0 =A0 =A0 =A0 meminfo =A0 =A0 =A0 =A0self =A0 =A0 =A0 =
=A0 =A0 uptime
1103 =A01254 =A01442 =A018 =A0 =A01878 =A01909 =A01958 =A02186 =A02283 =
=A024 =A0 =A02667 =A033 =A0 627 =A08 =A0 =A0983 =A0 =A0 =A0 =A0diskstat=
s =A0 =A0kallsyms =A0 =A0misc =A0 =A0 =A0 =A0 =A0 slabinfo =A0 =A0 =A0 =
version
1108 =A01257 =A01449 =A01831 =A01880 =A01911 =A01967 =A02194 =A023 =A0 =
=A0240 =A0 2681 =A034 =A0 628 =A0807 =A0acpi =A0 =A0 =A0 dma =A0 =A0 =A0=
 =A0 =A0kcore =A0 =A0 =A0 modules =A0 =A0 =A0 =A0softirqs =A0 =A0 =A0 v=
mallocinfo
1110 =A01295 =A01458 =A01834 =A01881 =A01919 =A01973 =A022 =A0 =A0233 =A0=
 241 =A0 27 =A0 =A035 =A0 680 =A0838 =A0asound =A0 =A0 driver =A0 =A0 =A0=
 key-users =A0 mounts =A0 =A0 =A0 =A0 stat =A0 =A0 =A0 =A0 =A0 vmstat
1148 =A013 =A0 =A015 =A0 =A01835 =A01882 =A01921 =A01995 =A02202 =A0234=
 =A0 243 =A0 270 =A0 36 =A0 69 =A0 848 =A0buddyinfo =A0execdomains =A0k=
msg =A0 =A0 =A0 =A0mtrr =A0 =A0 =A0 =A0 =A0 swaps =A0 =A0 =A0 =A0 =A0zo=
neinfo
1150 =A01385 =A01571 =A01847 =A01883 =A01926 =A01999 =A02208 =A0235 =A0=
 2457 =A02701 =A037 =A0 7 =A0 =A0849 =A0bus =A0 =A0 =A0 =A0fb =A0 =A0 =A0=
 =A0 =A0 kpagecount =A0net =A0 =A0 =A0 =A0 =A0 =A0sys
1151 =A014 =A0 =A016 =A0 =A01855 =A01887 =A01927 =A02 =A0 =A0 2224 =A02=
352 =A02491 =A0277 =A0 4 =A0 =A070 =A0 888 =A0cgroups =A0 =A0filesystem=
s =A0kpageflags =A0pagetypeinfo =A0 sysrq-trigger

[X.] Other notes, patches, fixes, workarounds:=A0
Please provide a link to your Launchpad bug report.=A0

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1155169
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
