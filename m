From: Anders Kaseorg <andersk@MIT.EDU>
Subject: PROBLEM: Native backlight regressed from logarithmic to linear
 scale
Date: Tue, 22 Jul 2014 00:32:44 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1407212333200.44274@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:42938 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930AbaGVEhw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jul 2014 00:37:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

[1.] One line summary of the problem:   =20

Native backlight regressed from logarithmic to linear scale

[2.] Full description of the problem/report:

With the new default of video.use_native_backlight=3D0 (commit=20
v3.16-rc1~30^2~2^3), my Thinkpad T510 backlight has become very difficu=
lt=20
to control near the low end of the scale.  The lowest setting now turns=
=20
the backlight completely off, but the second-lowest setting is too brig=
ht. =20
Meanwhile, the difference between the highest several settings is nearl=
y=20
imperceptible.

This happened because /sys/class/backlight/acpi_video0/brightness (whic=
h=20
has now disappeared) used a different scale than=20
/sys/class/intel_backlight/brightness; the relationship between=20
acpi_video0 and intel_backlight was not linear.  I measured the exact=20
relationship as follows:

acpi    intel
0       52
1       87
2       139
3       174
4       226
5       261
6       313
7       435
8       591
9       800
10      1078
11      1461
12      1914
13      2557
14      3358
15      4437

The relationship is close to logarithmic; a good fit is intel =3D=20
60*(4/3)^acpi, or acpi =3D log_{4/3} (intel/60).  It=E2=80=99s well kno=
wn that=20
perceived brightness varies logarithmically with physical luminance=20
(Fechner=E2=80=99s law), so it=E2=80=99s no surprise that the acpi_vide=
o0 scale was more=20
useful.

Since the kernel no longer uses ACPI to do this translation, it should =
do=20
the translation itself.

Anders


(Unless you=E2=80=99re interested in the boring details requested by=20
REPORTING-BUGS, feel free to ignore everything below this line.)


[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel information
[4.1.] Kernel version (from /proc/version):

Linux version 3.16.0-031600rc6-generic (apw@gomeisa) (gcc version 4.6.3=
 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201407210035 SMP Mon Jul 21 04:36:11=
 UTC 2014

[4.2.] Kernel .config file:

(Let me know if you actually want this.)

[5.] Most recent kernel version which did not have the bug:

3.15

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment

$ lsb_release -rd
Description:	Ubuntu Utopic Unicorn (development branch)
Release:	14.10

[8.1.] Software (add the output of the ver_linux script here)

Linux fixed-disk 3.16.0-031600rc6-generic #201407210035 SMP Mon Jul 21 =
04:36:11 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
=20
Gnu C                  4.8
Gnu make               4.0
binutils               2.24.51.20140709
util-linux             2.20.1
mount                  support
module-init-tools      18
e2fsprogs              1.42.10
jfsutils               1.1.15
reiserfsprogs          3.6.24
xfsprogs               3.1.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptabl=
e_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack =
nf_conntrack ipt_REJECT xt_tcpudp iptable_filter ip_tables x_tables bri=
dge stp llc openafs ctr ccm snd_hrtimer rfcomm bnep nfnetlink_queue nfn=
etlink_log nfnetlink bbswitch binfmt_misc uvcvideo videobuf2_vmalloc vi=
deobuf2_memops videobuf2_core snd_hda_codec_hdmi v4l2_common btusb blue=
tooth i2400m_usb i2400m snd_hda_codec_conexant snd_hda_codec_generic wi=
max videodev 6lowpan_iphc media snd_hda_intel snd_hda_controller intel_=
powerclamp coretemp snd_hda_codec snd_hwdep kvm_intel kvm snd_pcm crct1=
0dif_pclmul crc32_pclmul arc4 ghash_clmulni_intel aesni_intel dm_multip=
ath scsi_dh iwldvm aes_x86_64 lrw gf128mul mac80211 glue_helper ablk_he=
lper cryptd microcode snd_seq_midi snd_seq_midi_event snd_rawmidi iwlwi=
fi joydev serio_raw snd_seq thinkpad_acpi cfg80211 snd_seq_device intel=
_ips nvram snd_timer lpc_ich snd mei_me shpchp mei soundcore mac_hid tp=
m_rng parport_pc ppdev lp parport autofs4 btrfs xor raid6_pq mxm_wmi i9=
15 psmouse i2c_algo_bit ahci firewire_ohci drm_kms_helper libahci e1000=
e firewire_core drm crc_itu_t sdhci_pci ptp sdhci pps_core wmi video

[8.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1199.000
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 =
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes lahf_lm ida arat dth=
erm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 5319.71
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1199.000
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 =
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes lahf_lm ida arat dth=
erm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 5319.71
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1199.000
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 2
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 =
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes lahf_lm ida arat dth=
erm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 5319.71
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1199.000
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 2
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 =
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt aes lahf_lm ida arat dth=
erm tpr_shadow vnmi flexpriority ept vpid
bogomips	: 5319.71
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

[8.3.] Module information (from /proc/modules):

xt_CHECKSUM 12549 1 - Live 0x0000000000000000
iptable_mangle 12734 1 - Live 0x0000000000000000
ipt_MASQUERADE 12880 3 - Live 0x0000000000000000
iptable_nat 13110 1 - Live 0x0000000000000000
nf_nat_ipv4 13316 1 iptable_nat, Live 0x0000000000000000
nf_nat 26308 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live 0x000000000=
0000000
nf_conntrack_ipv4 14857 2 - Live 0x0000000000000000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 12760 1 - Live 0x0000000000000000
nf_conntrack 105687 6 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4,nf_nat,nf_=
conntrack_ipv4,xt_conntrack, Live 0x0000000000000000
ipt_REJECT 12579 2 - Live 0x0000000000000000
xt_tcpudp 12924 6 - Live 0x0000000000000000
iptable_filter 12810 1 - Live 0x0000000000000000
ip_tables 27718 3 iptable_mangle,iptable_nat,iptable_filter, Live 0x000=
0000000000000
x_tables 34194 8 xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_conntrack=
,ipt_REJECT,xt_tcpudp,iptable_filter,ip_tables, Live 0x0000000000000000
bridge 121755 0 - Live 0x0000000000000000
stp 12976 1 bridge, Live 0x0000000000000000
llc 14441 2 bridge,stp, Live 0x0000000000000000
openafs 791500 2 - Live 0x0000000000000000 (POE)
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
snd_hrtimer 12744 1 - Live 0x0000000000000000
rfcomm 75114 8 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
nfnetlink_queue 18405 0 - Live 0x0000000000000000
nfnetlink_log 18004 0 - Live 0x0000000000000000
nfnetlink 14650 2 nfnetlink_queue,nfnetlink_log, Live 0x000000000000000=
0
bbswitch 13943 0 - Live 0x0000000000000000 (OE)
binfmt_misc 17508 1 - Live 0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59635 1 uvcvideo, Live 0x0000000000000000
snd_hda_codec_hdmi 48243 1 - Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
btusb 32605 0 - Live 0x0000000000000000
bluetooth 467228 22 rfcomm,bnep,btusb, Live 0x0000000000000000
i2400m_usb 36708 0 - Live 0x0000000000000000
i2400m 108172 1 i2400m_usb, Live 0x0000000000000000
snd_hda_codec_conexant 23005 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_conexant, Live 0x0000000000=
000000
wimax 34571 1 i2400m, Live 0x0000000000000000
videodev 154834 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x000000000=
0000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
snd_hda_intel 30683 3 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
snd_hda_codec 144889 5 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hd=
a_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x00000000000000=
00
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
kvm_intel 149086 0 - Live 0x0000000000000000
kvm 464279 1 kvm_intel, Live 0x0000000000000000
snd_pcm 105052 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,sn=
d_hda_codec, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 152648 8 - Live 0x0000000000000000
dm_multipath 23188 0 - Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
iwldvm 243680 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
mac80211 687067 1 iwldvm, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20531 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000=
000000000000
microcode 24525 0 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
iwlwifi 190534 1 iwldvm, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd_seq 63540 3 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
thinkpad_acpi 82198 1 - Live 0x0000000000000000
cfg80211 521225 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
intel_ips 18534 0 - Live 0x0000000000000000
nvram 14462 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 30118 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
snd 84025 19 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_ge=
neric,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq=
,thinkpad_acpi,snd_seq_device,snd_timer, Live 0x0000000000000000
mei_me 19565 0 - Live 0x0000000000000000
shpchp 37216 0 - Live 0x0000000000000000
mei 88632 1 mei_me, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
tpm_rng 12492 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 39229 2 - Live 0x0000000000000000
btrfs 934513 0 - Live 0x0000000000000000
xor 21411 1 btrfs, Live 0x0000000000000000
raid6_pq 97812 1 btrfs, Live 0x0000000000000000
mxm_wmi 13021 0 - Live 0x0000000000000000
i915 945853 9 - Live 0x0000000000000000
psmouse 113097 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
ahci 30167 1 - Live 0x0000000000000000
firewire_ohci 45300 0 - Live 0x0000000000000000
drm_kms_helper 62042 1 i915, Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
e1000e 229859 0 - Live 0x0000000000000000
firewire_core 69403 1 firewire_ohci, Live 0x0000000000000000
drm 316819 6 i915,drm_kms_helper, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
sdhci_pci 23352 0 - Live 0x0000000000000000
ptp 19534 1 e1000e, Live 0x0000000000000000
sdhci 44159 1 sdhci_pci, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000
wmi 19379 1 mxm_wmi, Live 0x0000000000000000
video 20521 1 i915, Live 0x0000000000000000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em)

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
    00f0-00f0 : PNP0C04:00
  03c0-03df : vesafb
  0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1003 : ACPI PM1a_EVT_BLK
  1004-1005 : ACPI PM1a_CNT_BLK
  1008-100b : ACPI PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-102f : ACPI GPE0_BLK
  1030-1033 : iTCO_wdt
  1050-1050 : ACPI PM2_CNT_BLK
  1060-107f : iTCO_wdt
  1180-11ff : pnp 00:01
  15e0-15ef : pnp 00:01
  1600-1641 : pnp 00:01
  164e-164f : pnp 00:01
  1800-1807 : 0000:00:02.0
  1810-1813 : 0000:00:1f.2
    1810-1813 : ahci
  1814-1817 : 0000:00:1f.2
    1814-1817 : ahci
  1818-181f : 0000:00:1f.2
    1818-181f : ahci
  1820-183f : 0000:00:19.0
  1840-185f : 0000:00:1f.2
    1840-185f : ahci
  1860-1867 : 0000:00:1f.2
    1860-1867 : ahci
  1880-189f : 0000:00:1f.3
  2000-2fff : PCI Bus 0000:01
    2000-207f : 0000:01:00.0
  3000-3fff : PCI Bus 0000:05

00000000-00000fff : reserved
00001000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000fffff : reserved
  000e0000-000effff : Extension ROM
  000f0000-000fffff : System ROM
00100000-bb27bfff : System RAM
  01000000-01796498 : Kernel code
  01796499-01d1747f : Kernel data
  01e76000-01fb8fff : Kernel bss
  2c000000-33ffffff : Crash kernel
bb27c000-bb281fff : reserved
bb282000-bb35efff : System RAM
bb35f000-bb370fff : reserved
bb371000-bb3f1fff : ACPI Non-volatile Storage
bb3f2000-bb40efff : reserved
bb40f000-bb46efff : System RAM
bb46f000-bb667fff : reserved
bb668000-bb6e7fff : ACPI Non-volatile Storage
bb6e8000-bb70efff : reserved
bb70f000-bb716fff : System RAM
bb717000-bb71efff : reserved
bb71f000-bb76afff : System RAM
bb76b000-bb776fff : ACPI Non-volatile Storage
bb777000-bb779fff : ACPI Tables
bb77a000-bb780fff : ACPI Non-volatile Storage
bb781000-bb781fff : ACPI Tables
bb782000-bb78afff : ACPI Non-volatile Storage
bb78b000-bb78bfff : ACPI Tables
bb78c000-bb79efff : ACPI Non-volatile Storage
bb79f000-bb7fefff : ACPI Tables
bb7ff000-bb7fffff : System RAM
bb800000-bfffffff : reserved
  be000000-bfffffff : Graphics Stolen Memory
c0000000-febfffff : PCI Bus 0000:00
  c0000000-c0000fff : Intel Flush Page
  cc000000-cdefffff : PCI Bus 0000:01
    cc000000-ccffffff : 0000:01:00.0
    cd000000-cd07ffff : 0000:01:00.0
  ce000000-dfffffff : PCI Bus 0000:01
    ce000000-cfffffff : 0000:01:00.0
    d0000000-dfffffff : 0000:01:00.0
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:01
  f0000000-f7ffffff : 0000:00:02.0
  f8000000-f80fffff : PCI Bus 0000:05
  f8100000-f81fffff : PCI Bus 0000:03
    f8100000-f8101fff : 0000:03:00.0
      f8100000-f8101fff : iwlwifi
  f8200000-f82fffff : PCI Bus 0000:0d
    f8200000-f82007ff : 0000:0d:00.3
      f8200000-f82007ff : firewire_ohci
    f8200800-f82008ff : 0000:0d:00.0
      f8200800-f82008ff : mmc0
    f8200c00-f8200cff : 0000:0d:00.1
  f8500000-f851ffff : 0000:00:19.0
    f8500000-f851ffff : e1000e
  f8520000-f8523fff : 0000:00:1b.0
    f8520000-f8523fff : ICH HD audio
  f8525000-f8525fff : 0000:00:19.0
    f8525000-f8525fff : e1000e
  f8526000-f8526fff : 0000:00:1f.6
    f8526000-f8526fff : ips thermal sensor
  f8527000-f85277ff : 0000:00:1f.2
    f8527000-f85277ff : ahci
  f8527800-f852780f : 0000:00:16.0
    f8527800-f852780f : mei_me
  f8528000-f85283ff : 0000:00:1a.0
    f8528000-f85283ff : ehci_hcd
  f8528400-f85287ff : 0000:00:1d.0
    f8528400-f85287ff : ehci_hcd
  f8528800-f85288ff : 0000:00:1f.3
  f8800000-f8bfffff : 0000:00:02.0
  fa000000-fbffffff : PCI Bus 0000:05
  feaff000-feafffff : reserved
    feaff000-feafffff : pnp 00:01
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : reserved
    fed00000-fed003ff : PNP0103:00
fed10000-fed13fff : pnp 00:01
fed18000-fed18fff : pnp 00:01
fed19000-fed19fff : pnp 00:01
fed1c000-fed8ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
  fed45000-fed4bfff : pnp 00:01
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
100000000-1fbffffff : System RAM
200000000-23bffffff : System RAM

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (=
rev 02)
	Subsystem: Lenovo Device 2193
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: agpgart-intel

00:01.0 PCI bridge: Intel Corporation Core Processor PCI Express x16 Ro=
ot Port (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: cc000000-cdefffff
	Prefetchable memory behind bridge: 00000000ce000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Lenovo Device 2194
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4171
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit Latency =
L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled+ CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BW=
Mgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #17, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF N=
ot Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending+ InProgress-
	Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation Core Processor Int=
egrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21d9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f8800000 (64-bit, non-prefetchable) [size=3D4M]
	Region 2: Memory at f0000000 (64-bit, prefetchable) [size=3D128M]
	Region 4: I/O ports at 1800 [size=3D8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41c1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 5 Series/3400 Serie=
s Chipset HECI Controller (rev 06)
	Subsystem: Lenovo Device 215f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f8527800 (64-bit, non-prefetchable) [size=3D16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41d1
	Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82577LM Gigabit Network =
Connection (rev 06)
	Subsystem: Lenovo Device 2153
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f8500000 (32-bit, non-prefetchable) [size=3D128K]
	Region 1: Memory at f8525000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: I/O ports at 1820 [size=3D32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4162
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset =
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 2163
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at f8528000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP+
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset Hi=
gh Definition Audio (rev 06)
	Subsystem: Lenovo Device 215e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 46
	Region 0: Memory at f8520000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4142
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D02
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D00 AssocRCRB- LinkType=
=3DMemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 1 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Su=
pported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 2164
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 2 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f8100000-f81fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Su=
pported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 2164
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 4 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D05, subordinate=3D0c, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f8000000-00000000f80fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Su=
pported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 2164
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 5 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D0d, subordinate=3D0d, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f8200000-f82fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Su=
pported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 2164
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset =
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 2163
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f8528400 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a6) =
(prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=3D00, secondary=3D0e, subordinate=3D0e, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Lenovo Device 2165

00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC Inter=
face Controller (rev 06)
	Subsystem: Lenovo Device 2166
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D10 <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset=
 6 port SATA AHCI Controller (rev 06) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 2168
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 42
	Region 0: I/O ports at 1860 [size=3D8]
	Region 1: I/O ports at 1814 [size=3D4]
	Region 2: I/O ports at 1818 [size=3D8]
	Region 3: I/O ports at 1810 [size=3D4]
	Region 4: I/O ports at 1840 [size=3D32]
	Region 5: Memory at f8527000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41b1
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus Con=
troller (rev 06)
	Subsystem: Lenovo Device 2167
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8528800 (64-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at 1880 [size=3D32]

00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400 S=
eries Chipset Thermal Subsystem (rev 06)
	Subsystem: Lenovo Device 2190
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f8526000 (64-bit, non-prefetchable) [size=3D4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel ips

01:00.0 VGA compatible controller: NVIDIA Corporation GT218M [NVS 3100M=
] (rev ff) (prog-if ff)
	!!! Unknown header type 7f

03:00.0 Network controller: Intel Corporation Centrino Advanced-N + WiM=
AX 6250 [Kilmer Peak] (rev 35)
	Subsystem: Intel Corporation Centrino Advanced-N + WiMAX 6250 2x2 AGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f8100000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4122
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unl=
imited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <128ns, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-23-15-ff-ff-82-dc-7c
	Kernel driver in use: iwlwifi

0d:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 01=
)
	Subsystem: Lenovo Device 2133
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f8200800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sdhci-pci

0d:00.1 System peripheral: Ricoh Co Ltd R5U2xx (R5U230 / R5U231 / R5U24=
1) [Memory Stick Host Controller] (rev 01)
	Subsystem: Lenovo Device 2134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at f8200c00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

0d:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394 Contro=
ller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Lenovo Device 2136
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f8200000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D2 PME+
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: firewire_ohci

ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath Archite=
cture Generic Non-core Registers (rev 02)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath Archite=
cture System Address Decoder (rev 02)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 0=
2)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

ff:02.1 Host bridge: Intel Corporation 1st Generation Core Processor QP=
I Physical 0 (rev 02)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

ff:02.2 Host bridge: Intel Corporation 1st Generation Core Processor Re=
served (rev 02)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

ff:02.3 Host bridge: Intel Corporation 1st Generation Core Processor Re=
served (rev 02)
	Subsystem: Lenovo Device 2196
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: INTEL SSDSA1M160 Rev: 02L1
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Optiarc  Model: DVD RW AD-7700H  Rev: 1.FA
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/sys/class/backlight/acpi_video0/actual_brightness 8
/sys/class/backlight/acpi_video0/bl_power 0
/sys/class/backlight/acpi_video0/brightness 8
/sys/class/backlight/acpi_video0/max_brightness 15
/sys/class/backlight/acpi_video0/type firmware
/sys/class/backlight/acpi_video1/actual_brightness 8
/sys/class/backlight/acpi_video1/bl_power 0
/sys/class/backlight/acpi_video1/brightness 8
/sys/class/backlight/acpi_video1/max_brightness 15
/sys/class/backlight/acpi_video1/type firmware
/sys/class/backlight/intel_backlight/actual_brightness 591
/sys/class/backlight/intel_backlight/bl_power 0
/sys/class/backlight/intel_backlight/brightness 591
/sys/class/backlight/intel_backlight/max_brightness 4437
/sys/class/backlight/intel_backlight/type raw

[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1341108
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
