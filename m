From: =?ISO-8859-1?Q?Axel_H=FCbl?= <axel.huebl@web.de>
Subject: Re: PROBLEM: [Asus Taichi31] 2nd Backside Screen Backlight
Date: Fri, 10 Jan 2014 20:02:52 +0100
Message-ID: <52D043DC.4030805@web.de>
References: <52CFB038.8030007@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms040502000805050402010508"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:54953 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbaAJTCz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jan 2014 14:02:55 -0500
Received: from [192.168.0.112] ([146.52.18.170]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lcgkx-1VdOhO012d-00k80b for
 <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2014 20:02:53 +0100
In-Reply-To: <52CFB038.8030007@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040502000805050402010508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

it seems I did not catch the right kernel in my last message.
I am sorry for that and I would like to add the right report now.
(With the latest kernel from
 http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.13-rc7-trusty/)

The Xorg log changed a bit but the problem persists.

Thanks a lot!!

[1.] [Asus Taichi31] 2nd Backside Screen Backlight

[2.] The backlight on my Taichi31=B4s 2nd screen (that is the
touchscreen on the backside working like a tablet) is nearly black
(but as far as I can test working). The only problem seems to be
adequate LED brightness.

Triaged by Christopher M. Penalver (penalvch)
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1267646

[3.]

[4.] /proc/version
Linux version 3.13.0-031300rc7-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201401041835 SMP Sat Jan 4
23:36:50 UTC 2014

[5.]

[6.]

[7.] lsb_release -rd
Description:	Ubuntu 13.10
Release:	13.10

[7.1.] ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux steffi-taichi 3.13.0-031300rc7-generic #201401041835 SMP Sat Jan
4 23:36:50 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         cuse parport_pc ppdev rfcomm bnep
x86_pkg_temp_thermal intel_powerclamp coretemp kvm asus_nb_wmi
asus_wmi sparse_keymap snd_hda_codec_hdmi snd_hda_codec_realtek arc4
snd_hda_intel snd_hda_codec iwldvm snd_hwdep snd_pcm mac80211
snd_page_alloc snd_seq_midi microcode snd_seq_midi_event uvcvideo
snd_rawmidi snd_seq videobuf2_vmalloc snd_seq_device videobuf2_memops
videobuf2_core videodev psmouse snd_timer asix iwlwifi usbnet mii
serio_raw joydev btusb snd hid_multitouch mei_me cfg80211 soundcore
bluetooth mei lp mac_hid lpc_ich parport xts gf128mul dm_crypt
hid_generic usbhid hid i915 crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel cryptd i2c_algo_bit drm_kms_helper drm ahci
libahci wmi video

[7.2.] /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping	: 9
microcode	: 0x15
cpu MHz		: 2121.281
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 3392.26
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping	: 9
microcode	: 0x15
cpu MHz		: 1908.582
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 3392.26
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping	: 9
microcode	: 0x15
cpu MHz		: 1354.886
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 3392.26
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping	: 9
microcode	: 0x15
cpu MHz		: 2250.507
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 3392.26
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

cuse 13566 3 - Live 0xffffffffa0436000
parport_pc 36962 0 - Live 0xffffffffa0422000
ppdev 17711 0 - Live 0xffffffffa0440000
rfcomm 74748 0 - Live 0xffffffffa062d000
bnep 19884 2 - Live 0xffffffffa041c000
x86_pkg_temp_thermal 14269 0 - Live 0xffffffffa0431000
intel_powerclamp 19031 0 - Live 0xffffffffa0416000
coretemp 17728 0 - Live 0xffffffffa0410000
kvm 468147 0 - Live 0xffffffffa05b9000
asus_nb_wmi 16990 0 - Live 0xffffffffa030a000
asus_wmi 24794 1 asus_nb_wmi, Live 0xffffffffa0408000
sparse_keymap 13890 1 asus_wmi, Live 0xffffffffa037a000
snd_hda_codec_hdmi 46898 1 - Live 0xffffffffa05ac000
snd_hda_codec_realtek 61978 1 - Live 0xffffffffa04f3000
arc4 12573 2 - Live 0xffffffffa03d4000
snd_hda_intel 57222 3 - Live 0xffffffffa0507000
snd_hda_codec 199156 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0xffffffffa057a000
iwldvm 243417 0 - Live 0xffffffffa053d000
snd_hwdep 13613 1 snd_hda_codec, Live 0xffffffffa0386000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0xffffffffa0521000
mac80211 654078 1 iwldvm, Live 0xffffffffa0452000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0xffffffffa044c000
snd_seq_midi 13324 0 - Live 0xffffffffa043b000
microcode 23788 0 - Live 0xffffffffa03db000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffa0381000
uvcvideo 82247 0 - Live 0xffffffffa03be000
snd_rawmidi 30465 1 snd_seq_midi, Live 0xffffffffa036c000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffa03ac000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffa0375000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0xffffffffa035e000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffa02ee000
videobuf2_core 40972 1 uvcvideo, Live 0xffffffffa0352000
videodev 139761 2 uvcvideo,videobuf2_core, Live 0xffffffffa03e4000
psmouse 108513 0 - Live 0xffffffffa0390000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0xffffffffa0363000
asix 39131 0 - Live 0xffffffffa02ff000
iwlwifi 179720 1 iwldvm, Live 0xffffffffa0325000
usbnet 44005 1 asix, Live 0xffffffffa02f3000
mii 13981 2 asix,usbnet, Live 0xffffffffa038b000
serio_raw 13462 0 - Live 0xffffffffa01b7000
joydev 17575 0 - Live 0xffffffffa02e8000
btusb 28326 0 - Live 0xffffffffa02e0000
snd 73850 17
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_=
hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffa0311000
hid_multitouch 17645 0 - Live 0xffffffffa01ad000
mei_me 18578 0 - Live 0xffffffffa01a3000
cfg80211 509407 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa0262000
soundcore 12680 1 snd, Live 0xffffffffa0198000
bluetooth 411140 11 rfcomm,bnep,btusb, Live 0xffffffffa01fc000
mei 82671 1 mei_me, Live 0xffffffffa01e6000
lp 17799 0 - Live 0xffffffffa019d000
mac_hid 13253 0 - Live 0xffffffffa018b000
lpc_ich 21163 0 - Live 0xffffffffa0191000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffa017f000
xts 12951 3 - Live 0xffffffffa017a000
gf128mul 14951 1 xts, Live 0xffffffffa0096000
dm_crypt 23417 3 - Live 0xffffffffa008b000
hid_generic 12548 0 - Live 0xffffffffa002c000
usbhid 53067 0 - Live 0xffffffffa01d8000
hid 106254 3 hid_multitouch,hid_generic,usbhid, Live 0xffffffffa01bd000
i915 816826 4 - Live 0xffffffffa00b1000
crct10dif_pclmul 14250 0 - Live 0xffffffffa001e000
crc32_pclmul 13160 0 - Live 0xffffffffa00ac000
ghash_clmulni_intel 13259 0 - Live 0xffffffffa0086000
cryptd 20530 1 ghash_clmulni_intel, Live 0xffffffffa007f000
i2c_algo_bit 13564 1 i915, Live 0xffffffffa0006000
drm_kms_helper 53224 1 i915, Live 0xffffffffa009b000
drm 308397 5 i915,drm_kms_helper, Live 0xffffffffa0032000
ahci 30063 4 - Live 0xffffffffa0023000
libahci 32277 1 ahci, Live 0xffffffffa0015000
wmi 19363 1 asus_wmi, Live 0xffffffffa000b000
video 19859 2 asus_wmi,i915, Live 0xffffffffa0000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem=
)

/proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03f8-03ff : serial
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:06
  0458-047f : pnp 00:04
    0460-047f : iTCO_wdt
  04d0-04d1 : pnp 00:07
  0500-057f : pnp 00:04
  0680-069f : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:04
  164e-164f : pnp 00:04
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
  ffff-ffff : pnp 00:04
    ffff-ffff : pnp 00:04

/proc/iomem
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-0177119d : Kernel code
  0177119e-01d1bf3f : Kernel data
  01e78000-01fdcfff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:0c
20200000-40003fff : System RAM
40004000-40004fff : reserved
  40004000-40004fff : pnp 00:0c
40005000-d97cafff : System RAM
d97cb000-d9dcbfff : ACPI Non-volatile Storage
d9dcc000-d9dcefff : reserved
d9dcf000-d9de5fff : System RAM
d9de6000-d9debfff : reserved
d9dec000-d9dedfff : System RAM
d9dee000-d9df3fff : reserved
d9df4000-d9f4cfff : System RAM
d9f4d000-d9f50fff : reserved
d9f51000-d9f8ffff : System RAM
d9f90000-d9f96fff : reserved
d9f97000-d9f98fff : System RAM
d9f99000-d9fb7fff : reserved
d9fb8000-d9fbafff : System RAM
d9fbb000-d9fbcfff : reserved
d9fbd000-d9fd3fff : System RAM
d9fd4000-d9fd9fff : reserved
d9fda000-d9fe1fff : System RAM
d9fe2000-d9fe2fff : reserved
d9fe3000-d9ff1fff : System RAM
d9ff2000-d9ff2fff : reserved
d9ff3000-d9ffdfff : System RAM
d9ffe000-da002fff : reserved
da003000-da021fff : System RAM
da022000-da023fff : reserved
da024000-da038fff : System RAM
da039000-da039fff : reserved
da03a000-da04bfff : System RAM
da04c000-da071fff : reserved
da072000-da085fff : System RAM
da086000-da086fff : reserved
da087000-da087fff : System RAM
da088000-da089fff : reserved
da08a000-da08afff : System RAM
da08b000-da08ffff : reserved
da090000-da0a6fff : System RAM
da0a7000-da64afff : reserved
da64b000-da8cafff : ACPI Non-volatile Storage
da8cb000-da8cffff : ACPI Tables
da8d0000-da8d0fff : System RAM
da8d1000-da913fff : ACPI Non-volatile Storage
da914000-dad28fff : System RAM
dad29000-daff3fff : reserved
daff4000-daffffff : System RAM
db000000-dbbfffff : RAM buffer
dbc00000-dfdfffff : reserved
  dbe00000-dfdfffff : Graphics Stolen Memory
dfe00000-feafffff : PCI Bus 0000:00
  dfe00000-dfe00fff : pnp 00:0b
  dfe08000-dfe0ffff : 0000:00:04.0
  e0000000-efffffff : 0000:00:02.0
    e0000000-e07e8fff : BOOTFB
  f7800000-f7bfffff : 0000:00:02.0
  f7c00000-f7cfffff : PCI Bus 0000:02
    f7c00000-f7c01fff : 0000:02:00.0
      f7c00000-f7c01fff : iwlwifi
  f7d00000-f7d0ffff : 0000:00:14.0
    f7d00000-f7d0ffff : xhci_hcd
  f7d18000-f7d1bfff : 0000:00:1b.0
    f7d18000-f7d1bfff : ICH HD audio
  f7d1c000-f7d1cfff : 0000:00:1f.6
  f7d1d000-f7d1d0ff : 0000:00:1f.3
  f7d1e000-f7d1e7ff : 0000:00:1f.2
    f7d1e000-f7d1e7ff : ahci
  f7d1f000-f7d1f3ff : 0000:00:1d.0
    f7d1f000-f7d1f3ff : ehci_hcd
  f7d20000-f7d203ff : 0000:00:1a.0
    f7d20000-f7d203ff : ehci_hcd
  f7d23000-f7d2300f : 0000:00:16.0
    f7d23000-f7d2300f : mei_me
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:0b
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
fed10000-fed17fff : pnp 00:0b
fed18000-fed18fff : pnp 00:0b
fed19000-fed19fff : pnp 00:0b
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:0b
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0b
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:0b
fed90000-fed93fff : pnp 00:0b
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:0b
100000000-11f1fffff : System RAM
11f200000-11fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

lspci -vvv
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=3D4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
	Region 4: I/O ports at f000 [size=3D64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41a1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:04.0 Signal processing controller: Intel Corporation 3rd Gen Core
Processor Thermal Subsystem (rev 09)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dfe08000 (64-bit, non-prefetchable) [size=3D32K]
	Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 201f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=3D64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
		Address: 00000000fee0a00c  Data: 4171
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210
Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f7d23000 (64-bit, non-prefetchable) [size=3D16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41b1
	Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f7d20000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f7d18000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41e1
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00=

		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
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
			Ctrl:	Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D00 AssocRCRB-
LinkType=3DMemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
<1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-=

			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-=

		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 10cd
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f7c00000-f7cfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-=

			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-=

		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 10cd
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f7d1f000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QS77 Express Chipset LPC
Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 41
	Region 0: I/O ports at f0b0 [size=3D8]
	Region 1: I/O ports at f0a0 [size=3D4]
	Region 2: I/O ports at f090 [size=3D8]
	Region 3: I/O ports at f080 [size=3D4]
	Region 4: I/O ports at f060 [size=3D32]
	Region 5: Memory at f7d1e000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee0500c  Data: 4191
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
SMBus Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at f7d1d000 (64-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at f040 [size=3D32]

00:1f.6 Signal processing controller: Intel Corporation 7 Series/C210
Series Chipset Family Thermal Management Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 10cd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at f7d1c000 (64-bit, non-prefetchable) [size=3D4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-

02:00.0 Network controller: Intel Corporation Centrino Advanced-N 6235
(rev 24)
	Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 41c1
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
<4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number c8-f7-33-ff-ff-eb-c7-97
	Kernel driver in use: iwlwifi


[7.6.] /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SanDisk SD5SE212 Rev: 10.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Downstream report:
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1267646

$ ls /proc/
1     139   1796  20    2346  2873  52    asound         meminfo
10    14    1798  2015  2358  2891  53    buddyinfo      misc
1049  140   18    2022  2359  29    54    bus            modules
1055  1402  1806  2026  2363  3     55    cgroups        mounts
1060  141   1810  2037  2369  30    558   cmdline        mtrr
1077  1413  1818  2081  2376  306   559   consoles       net
1086  142   1819  2086  2382  31    565   cpuinfo        pagetypeinfo
11    1427  1823  21    2390  3117  566   crypto         partitions
1109  143   1824  2129  24    33    588   devices        sched_debug
1111  144   1828  2149  2405  34    602   diskstats      schedstat
1113  1452  1833  2167  2424  35    67    dma            scsi
1123  146   1838  2194  2449  36    69    driver         self
1159  147   1842  22    2461  37    7     execdomains    slabinfo
1161  1481  1849  2200  2468  38    8     fb             softirqs
12    1484  1852  2201  2469  39    814   filesystems    stat
1209  1487  1858  2203  25    40    816   fs             swaps
1218  149   1884  2204  254   41    827   interrupts     sys
1236  15    1893  223   256   42    828   iomem          sysrq-trigger
1238  16    1898  224   257   427   829   ioports        sysvipc
1257  1683  19    225   258   43    830   irq            timer_list
1266  1690  1904  226   259   433   831   kallsyms       timer_stats
13    17    1906  2268  26    434   89    kcore          tty
1329  1749  1907  2270  275   44    9     key-users      uptime
1333  1751  1908  228   276   440   90    kmsg           version
1338  1764  1909  2291  277   45    901   kpagecount     vmallocinfo
1343  1769  1910  2297  2794  47    902   kpageflags     vmstat
1370  1775  1911  23    28    49    91    latency_stats  zoneinfo
1385  1778  1912  2308  2805  5     92    loadavg
1387  1792  1920  2312  2807  50    964   locks
1389  1794  2     2318  2869  51    acpi  mdstat


$ cat /var/log/Xorg.0.log
[    33.416]
X.Org X Server 1.14.5
Release Date: 2013-12-12
[    33.416] X Protocol Version 11, Revision 0
[    33.416] Build Operating System: Linux 3.2.0-37-generic x86_64 Ubuntu=

[    33.416] Current Operating System: Linux steffi-taichi
3.13.0-031300rc7-generic #201401041835 SMP Sat Jan 4 23:36:50 UTC 2014
x86_64
[    33.416] Kernel command line:
BOOT_IMAGE=3D/vmlinuz-3.13.0-031300rc7-generic
root=3DUUID=3D0e7230c6-d126-4b9e-adf3-2cd0add113cd ro quiet splash
vt.handoff=3D7
[    33.416] Build Date: 17 December 2013  10:06:15AM
[    33.416] xorg-server 2:1.14.5-1ubuntu2~saucy1 (For technical
support please see http://www.ubuntu.com/support)
[    33.416] Current version of pixman: 0.30.2
[    33.416]    Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
[    33.416] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t
setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    33.416] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Fri Jan 10
19:26:59 2014
[    33.428] (=3D=3D) Using system config directory
"/usr/share/X11/xorg.conf.d"
[    33.428] (=3D=3D) No Layout section.  Using the first Screen section.=

[    33.428] (=3D=3D) No screen section available. Using defaults.
[    33.428] (**) |-->Screen "Default Screen Section" (0)
[    33.428] (**) |   |-->Monitor "<default monitor>"
[    33.428] (=3D=3D) No monitor specified for screen "Default Screen
Section".
        Using a default monitor configuration.
[    33.428] (=3D=3D) Automatically adding devices
[    33.428] (=3D=3D) Automatically enabling devices
[    33.428] (=3D=3D) Automatically adding GPU devices
[    33.428] (WW) The directory "/usr/share/fonts/X11/cyrillic" does
not exist.
[    33.428]    Entry deleted from font path.
[    33.428] (WW) The directory "/usr/share/fonts/X11/100dpi/" does
not exist.
[    33.428]    Entry deleted from font path.
[    33.428] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not
exist.
[    33.428]    Entry deleted from font path.
[    33.428] (WW) The directory "/usr/share/fonts/X11/100dpi" does not
exist.
[    33.428]    Entry deleted from font path.
[    33.428] (WW) The directory "/usr/share/fonts/X11/75dpi" does not
exist.
[    33.428]    Entry deleted from font path.
[    33.428] (=3D=3D) FontPath set to:
        /usr/share/fonts/X11/misc,
        /usr/share/fonts/X11/Type1,
        built-ins
[    33.428] (=3D=3D) ModulePath set to
"/usr/lib/x86_64-linux-gnu/xorg/extra-modules,/usr/lib/xorg/extra-modules=
,/usr/lib/xorg/modules"
[    33.428] (II) The server relies on udev to provide the list of
input devices.
        If no devices become available, reconfigure udev or disable
AutoAddDevices.
[    33.429] (II) Loader magic: 0x7f94d10a8d20
[    33.429] (II) Module ABI versions:
[    33.429]    X.Org ANSI C Emulation: 0.4
[    33.429]    X.Org Video Driver: 14.1
[    33.429]    X.Org XInput driver : 19.1
[    33.429]    X.Org Server Extension : 7.0
[    33.429] (II) xfree86: Adding drm device (/dev/dri/card0)
[    33.430] (--) PCI:*(0:0:2:0) 8086:0166:1043:10cd rev 9, Mem @
0xf7800000/4194304, 0xe0000000/268435456, I/O @ 0x0000f000/64
[    33.430] (WW) Open ACPI failed (/var/run/acpid.socket) (No such
file or directory)
[    33.430] Initializing built-in extension Generic Event Extension
[    33.430] Initializing built-in extension SHAPE
[    33.430] Initializing built-in extension MIT-SHM
[    33.430] Initializing built-in extension XInputExtension
[    33.430] Initializing built-in extension XTEST
[    33.430] Initializing built-in extension BIG-REQUESTS
[    33.430] Initializing built-in extension SYNC
[    33.430] Initializing built-in extension XKEYBOARD
[    33.430] Initializing built-in extension XC-MISC
[    33.430] Initializing built-in extension SECURITY
[    33.430] Initializing built-in extension XINERAMA
[    33.431] Initializing built-in extension XFIXES
[    33.431] Initializing built-in extension RENDER
[    33.431] Initializing built-in extension RANDR
[    33.431] Initializing built-in extension COMPOSITE
[    33.431] Initializing built-in extension DAMAGE
[    33.431] Initializing built-in extension MIT-SCREEN-SAVER
[    33.431] Initializing built-in extension DOUBLE-BUFFER
[    33.431] Initializing built-in extension RECORD
[    33.431] Initializing built-in extension DPMS
[    33.431] Initializing built-in extension X-Resource
[    33.431] Initializing built-in extension XVideo
[    33.431] Initializing built-in extension XVideo-MotionCompensation
[    33.431] Initializing built-in extension SELinux
[    33.431] Initializing built-in extension XFree86-VidModeExtension
[    33.431] Initializing built-in extension XFree86-DGA
[    33.431] Initializing built-in extension XFree86-DRI
[    33.431] Initializing built-in extension DRI2
[    33.431] (II) "glx" will be loaded by default.
[    33.431] (WW) "xmir" is not to be loaded by default. Skipping.
[    33.431] (II) LoadModule: "dri2"
[    33.431] (II) Module "dri2" already built-in
[    33.431] (II) LoadModule: "glamoregl"
[    33.440] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    33.465] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    33.465] 	compiled for 1.14.3, module version =3D 0.5.1
[    33.465] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    33.465] (II) LoadModule: "glx"
[    33.465] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    33.466] (II) Module glx: vendor=3D"X.Org Foundation"
[    33.466] 	compiled for 1.14.5, module version =3D 1.0.0
[    33.466] 	ABI class: X.Org Server Extension, version 7.0
[    33.466] (=3D=3D) AIGLX enabled
[    33.466] Loading extension GLX
[    33.466] (=3D=3D) Matched intel as autoconfigured driver 0
[    33.466] (=3D=3D) Matched intel as autoconfigured driver 1
[    33.466] (=3D=3D) Matched vesa as autoconfigured driver 2
[    33.466] (=3D=3D) Matched modesetting as autoconfigured driver 3
[    33.466] (=3D=3D) Matched fbdev as autoconfigured driver 4
[    33.466] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[    33.466] (II) LoadModule: "intel"
[    33.466] (II) Loading /usr/lib/xorg/modules/drivers/intel_drv.so
[    33.467] (II) Module intel: vendor=3D"X.Org Foundation"
[    33.468] 	compiled for 1.14.3, module version =3D 2.99.904
[    33.468] 	Module class: X.Org Video Driver
[    33.468] 	ABI class: X.Org Video Driver, version 14.1
[    33.468] (II) LoadModule: "vesa"
[    33.468] (II) Loading /usr/lib/xorg/modules/drivers/vesa_drv.so
[    33.468] (II) Module vesa: vendor=3D"X.Org Foundation"
[    33.468] 	compiled for 1.14.1, module version =3D 2.3.2
[    33.468] 	Module class: X.Org Video Driver
[    33.468] 	ABI class: X.Org Video Driver, version 14.1
[    33.468] (II) LoadModule: "modesetting"
[    33.468] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.s=
o
[    33.468] (II) Module modesetting: vendor=3D"X.Org Foundation"
[    33.468] 	compiled for 1.14.1, module version =3D 0.8.0
[    33.468] 	Module class: X.Org Video Driver
[    33.468] 	ABI class: X.Org Video Driver, version 14.1
[    33.468] (II) LoadModule: "fbdev"
[    33.468] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    33.469] (II) Module fbdev: vendor=3D"X.Org Foundation"
[    33.469] 	compiled for 1.14.1, module version =3D 0.4.3
[    33.469] 	Module class: X.Org Video Driver
[    33.469] 	ABI class: X.Org Video Driver, version 14.1
[    33.469] (II) intel: Driver for Intel(R) Integrated Graphics Chipsets=
:
	i810, i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G,
	915G, E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM,
	Pineview G, 965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q33,
	GM45, 4 Series, G45/G43, Q45/Q43, G41, B43, HD Graphics,
	HD Graphics 2000, HD Graphics 3000, HD Graphics 2500,
	HD Graphics 4000, HD Graphics P4000, HD Graphics 4600,
	HD Graphics 5000, HD Graphics P4600/P4700, Iris(TM) Graphics 5100,
	HD Graphics 4400, HD Graphics 4200, Iris(TM) Pro Graphics 5200
[    33.469] (II) VESA: driver for VESA chipsets: vesa
[    33.469] (II) modesetting: Driver for Modesetting Kernel Drivers: kms=

[    33.469] (II) FBDEV: driver for framebuffer: fbdev
[    33.469] (++) using VT number 7

[    33.469] (II) intel(0): SNA compiled: xserver-xorg-video-intel
2:2.99.904-0ubuntu2 (Timo Aaltonen <tjaalton@ubuntu.com>)
[    33.470] (WW) Falling back to old probe method for vesa
[    33.470] (WW) Falling back to old probe method for modesetting
[    33.470] (WW) Falling back to old probe method for fbdev
[    33.470] (II) Loading sub module "fbdevhw"
[    33.470] (II) LoadModule: "fbdevhw"
[    33.470] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    33.470] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    33.470] 	compiled for 1.14.5, module version =3D 0.0.2
[    33.470] 	ABI class: X.Org Video Driver, version 14.1
[    33.471] (II) intel(0): Creating default Display subsection in
Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    33.471] (=3D=3D) intel(0): Depth 24, (--) framebuffer bpp 32
[    33.471] (=3D=3D) intel(0): RGB weight 888
[    33.471] (=3D=3D) intel(0): Default visual is TrueColor
[    33.471] (--) intel(0): Integrated Graphics Chipset: Intel(R) HD
Graphics 4000
[    33.471] (--) intel(0): CPU: x86-64, sse2, sse3, ssse3, sse4.1,
sse4.2, avx
[    33.471] (**) intel(0): Framebuffer tiled
[    33.471] (**) intel(0): Pixmaps tiled
[    33.471] (**) intel(0): "Tear free" disabled
[    33.471] (**) intel(0): Forcing per-crtc-pixmaps? no
[    33.471] (II) intel(0): Output eDP1 has no monitor section
[    33.471] (--) intel(0): found backlight control interface
acpi_video0 (type 'firmware')
[    33.471] (II) intel(0): Output VGA1 has no monitor section
[    33.471] (II) intel(0): Output HDMI1 has no monitor section
[    33.471] (II) intel(0): Output DP1 has no monitor section
[    33.471] (II) intel(0): Output HDMI2 has no monitor section
[    33.471] (II) intel(0): Output DP2 has no monitor section
[    33.471] (II) intel(0): Output VIRTUAL1 has no monitor section
[    33.471] (--) intel(0): Output eDP1 using initial mode 1920x1080
on pipe 0
[    33.471] (--) intel(0): Output DP1 using initial mode 1920x1080 on
pipe 1
[    33.471] (=3D=3D) intel(0): DPI set to (96, 96)
[    33.471] (II) Loading sub module "dri2"
[    33.471] (II) LoadModule: "dri2"
[    33.471] (II) Module "dri2" already built-in
[    33.472] (II) UnloadModule: "vesa"
[    33.472] (II) Unloading vesa
[    33.472] (II) UnloadModule: "modesetting"
[    33.472] (II) Unloading modesetting
[    33.472] (II) UnloadModule: "fbdev"
[    33.472] (II) Unloading fbdev
[    33.472] (II) UnloadSubModule: "fbdevhw"
[    33.472] (II) Unloading fbdevhw
[    33.472] (=3D=3D) Depth 24 pixmap format is 32 bpp
[    33.472] (II) intel(0): SNA initialized with Ivybridge (gen7, gt2)
backend
[    33.472] (=3D=3D) intel(0): Backing store disabled
[    33.472] (=3D=3D) intel(0): Silken mouse enabled
[    33.472] (II) intel(0): HW Cursor enabled
[    33.472] (II) intel(0): RandR 1.2 enabled, ignore the following
RandR disabled message.
[    33.472] (=3D=3D) intel(0): DPMS enabled
[    33.472] (II) intel(0): [DRI2] Setup complete
[    33.472] (II) intel(0): [DRI2]   DRI driver: i965
[    33.472] (II) intel(0): direct rendering: DRI2 Enabled
[    33.473] (=3D=3D) intel(0): hotplug detection: "enabled"
[    33.473] (--) RandR disabled
[    33.479] (II) SELinux: Disabled on system
[    33.512] (II) AIGLX: enabled GLX_MESA_copy_sub_buffer
[    33.512] (II) AIGLX: enabled GLX_INTEL_swap_event
[    33.512] (II) AIGLX: enabled GLX_ARB_create_context
[    33.512] (II) AIGLX: enabled GLX_ARB_create_context_profile
[    33.512] (II) AIGLX: enabled GLX_EXT_create_context_es2_profile
[    33.512] (II) AIGLX: enabled GLX_SGI_swap_control and
GLX_MESA_swap_control
[    33.512] (II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer
objects
[    33.512] (II) AIGLX: Loaded and initialized i965
[    33.512] (II) GLX: Initialized DRI2 GL provider for screen 0
[    33.516] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[    33.528] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (0, 0), rotation normal
[    33.544] (II) intel(0): Setting screen physical size to 508 x 285
[    33.559] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    33.562] (II) config/udev: Adding input device Video Bus
(/dev/input/event6)
[    33.562] (**) Video Bus: Applying InputClass "evdev keyboard catchall=
"
[    33.562] (II) LoadModule: "evdev"
[    33.562] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    33.563] (II) Module evdev: vendor=3D"X.Org Foundation"
[    33.563] 	compiled for 1.14.1, module version =3D 2.7.3
[    33.563] 	Module class: X.Org XInput Driver
[    33.563] 	ABI class: X.Org XInput driver, version 19.1
[    33.563] (II) Using input driver 'evdev' for 'Video Bus'
[    33.563] (**) Video Bus: always reports core events
[    33.563] (**) evdev: Video Bus: Device: "/dev/input/event6"
[    33.564] (--) evdev: Video Bus: Vendor 0 Product 0x6
[    33.564] (--) evdev: Video Bus: Found keys
[    33.564] (II) evdev: Video Bus: Configuring as keyboard
[    33.564] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/inp=
ut10/event6"
[    33.564] (II) XINPUT: Adding extended input device "Video Bus"
(type: KEYBOARD, id 6)
[    33.564] (**) Option "xkb_rules" "evdev"
[    33.564] (**) Option "xkb_model" "pc105"
[    33.564] (**) Option "xkb_layout" "de"
[    33.564] (**) Option "xkb_variant" "nodeadkeys"
[    33.567] (II) XKB: reuse xkmfile
/var/lib/xkb/server-76D2B5A359D34EEB9BFAEB1701EF70014DF39715.xkm
[    33.568] (II) config/udev: Adding input device Power Button
(/dev/input/event1)
[    33.568] (**) Power Button: Applying InputClass "evdev keyboard
catchall"
[    33.568] (II) Using input driver 'evdev' for 'Power Button'
[    33.568] (**) Power Button: always reports core events
[    33.568] (**) evdev: Power Button: Device: "/dev/input/event1"
[    33.568] (--) evdev: Power Button: Vendor 0 Product 0x1
[    33.568] (--) evdev: Power Button: Found keys
[    33.568] (II) evdev: Power Button: Configuring as keyboard
[    33.568] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1/event1"
[    33.568] (II) XINPUT: Adding extended input device "Power Button"
(type: KEYBOARD, id 7)
[    33.568] (**) Option "xkb_rules" "evdev"
[    33.568] (**) Option "xkb_model" "pc105"
[    33.568] (**) Option "xkb_layout" "de"
[    33.568] (**) Option "xkb_variant" "nodeadkeys"
[    33.569] (II) config/udev: Adding input device Lid Switch
(/dev/input/event0)
[    33.569] (II) No input driver specified, ignoring this device.
[    33.569] (II) This device may have been added with another device
file.
[    33.569] (II) config/udev: Adding input device Sleep Button
(/dev/input/event2)
[    33.569] (**) Sleep Button: Applying InputClass "evdev keyboard
catchall"
[    33.569] (II) Using input driver 'evdev' for 'Sleep Button'
[    33.569] (**) Sleep Button: always reports core events
[    33.569] (**) evdev: Sleep Button: Device: "/dev/input/event2"
[    33.569] (--) evdev: Sleep Button: Vendor 0 Product 0x3
[    33.569] (--) evdev: Sleep Button: Found keys
[    33.569] (II) evdev: Sleep Button: Configuring as keyboard
[    33.569] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2/event2"
[    33.569] (II) XINPUT: Adding extended input device "Sleep Button"
(type: KEYBOARD, id 8)
[    33.569] (**) Option "xkb_rules" "evdev"
[    33.569] (**) Option "xkb_model" "pc105"
[    33.569] (**) Option "xkb_layout" "de"
[    33.569] (**) Option "xkb_variant" "nodeadkeys"
[    33.570] (II) config/udev: Adding drm device (/dev/dri/card0)
[    33.570] (II) config/udev: Ignoring already known drm device
(/dev/dri/card0)
[    33.570] (II) config/udev: Adding input device Logitech USB
Receiver (/dev/input/event4)
[    33.570] (**) Logitech USB Receiver: Applying InputClass "evdev
pointer catchall"
[    33.570] (II) Using input driver 'evdev' for 'Logitech USB Receiver'
[    33.570] (**) Logitech USB Receiver: always reports core events
[    33.570] (**) evdev: Logitech USB Receiver: Device:
"/dev/input/event4"
[    33.570] (--) evdev: Logitech USB Receiver: Vendor 0x46d Product
0xc51a
[    33.570] (--) evdev: Logitech USB Receiver: Found 20 mouse buttons
[    33.570] (--) evdev: Logitech USB Receiver: Found scroll wheel(s)
[    33.571] (--) evdev: Logitech USB Receiver: Found relative axes
[    33.571] (--) evdev: Logitech USB Receiver: Found x and y relative
axes
[    33.571] (II) evdev: Logitech USB Receiver: Configuring as mouse
[    33.571] (II) evdev: Logitech USB Receiver: Adding scrollwheel suppor=
t
[    33.571] (**) evdev: Logitech USB Receiver: YAxisMapping: buttons
4 and 5
[    33.571] (**) evdev: Logitech USB Receiver: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    33.571] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/input/input8/=
event4"
[    33.571] (II) XINPUT: Adding extended input device "Logitech USB
Receiver" (type: MOUSE, id 9)
[    33.571] (II) evdev: Logitech USB Receiver: initialized for
relative axes.
[    33.571] (**) Logitech USB Receiver: (accel) keeping acceleration
scheme 1
[    33.571] (**) Logitech USB Receiver: (accel) acceleration profile 0
[    33.571] (**) Logitech USB Receiver: (accel) acceleration factor:
2.000
[    33.571] (**) Logitech USB Receiver: (accel) acceleration threshold: =
4
[    33.571] (II) config/udev: Adding input device Logitech USB
Receiver (/dev/input/mouse0)
[    33.571] (II) No input driver specified, ignoring this device.
[    33.571] (II) This device may have been added with another device
file.
[    33.572] (II) config/udev: Adding input device Logitech USB
Receiver (/dev/input/event5)
[    33.572] (**) Logitech USB Receiver: Applying InputClass "evdev
keyboard catchall"
[    33.572] (II) Using input driver 'evdev' for 'Logitech USB Receiver'
[    33.572] (**) Logitech USB Receiver: always reports core events
[    33.572] (**) evdev: Logitech USB Receiver: Device:
"/dev/input/event5"
[    33.572] (--) evdev: Logitech USB Receiver: Vendor 0x46d Product
0xc51a
[    33.572] (--) evdev: Logitech USB Receiver: Found 1 mouse buttons
[    33.572] (--) evdev: Logitech USB Receiver: Found scroll wheel(s)
[    33.572] (--) evdev: Logitech USB Receiver: Found relative axes
[    33.572] (II) evdev: Logitech USB Receiver: Forcing relative x/y
axes to exist.
[    33.572] (--) evdev: Logitech USB Receiver: Found absolute axes
[    33.572] (II) evdev: Logitech USB Receiver: Forcing absolute x/y
axes to exist.
[    33.572] (--) evdev: Logitech USB Receiver: Found keys
[    33.572] (II) evdev: Logitech USB Receiver: Configuring as mouse
[    33.572] (II) evdev: Logitech USB Receiver: Configuring as keyboard
[    33.572] (II) evdev: Logitech USB Receiver: Adding scrollwheel suppor=
t
[    33.572] (**) evdev: Logitech USB Receiver: YAxisMapping: buttons
4 and 5
[    33.572] (**) evdev: Logitech USB Receiver: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    33.572] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.1/input/input9/=
event5"
[    33.572] (II) XINPUT: Adding extended input device "Logitech USB
Receiver" (type: KEYBOARD, id 10)
[    33.572] (**) Option "xkb_rules" "evdev"
[    33.572] (**) Option "xkb_model" "pc105"
[    33.572] (**) Option "xkb_layout" "de"
[    33.572] (**) Option "xkb_variant" "nodeadkeys"
[    33.573] (II) evdev: Logitech USB Receiver: initialized for
relative axes.
[    33.573] (WW) evdev: Logitech USB Receiver: ignoring absolute axes.
[    33.575] (**) Logitech USB Receiver: (accel) keeping acceleration
scheme 1
[    33.575] (**) Logitech USB Receiver: (accel) acceleration profile 0
[    33.575] (**) Logitech USB Receiver: (accel) acceleration factor:
2.000
[    33.575] (**) Logitech USB Receiver: (accel) acceleration threshold: =
4
[    33.576] (II) config/udev: Adding input device USB Camera
(/dev/input/event7)
[    33.576] (**) USB Camera: Applying InputClass "evdev keyboard
catchall"
[    33.576] (II) Using input driver 'evdev' for 'USB Camera'
[    33.576] (**) USB Camera: always reports core events
[    33.576] (**) evdev: USB Camera: Device: "/dev/input/event7"
[    33.576] (--) evdev: USB Camera: Vendor 0x4f2 Product 0xb379
[    33.576] (--) evdev: USB Camera: Found keys
[    33.576] (II) evdev: USB Camera: Configuring as keyboard
[    33.576] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/input=
/input15/event7"
[    33.576] (II) XINPUT: Adding extended input device "USB Camera"
(type: KEYBOARD, id 11)
[    33.576] (**) Option "xkb_rules" "evdev"
[    33.576] (**) Option "xkb_model" "pc105"
[    33.576] (**) Option "xkb_layout" "de"
[    33.576] (**) Option "xkb_variant" "nodeadkeys"
[    33.577] (II) config/udev: Adding input device USB Camera
(/dev/input/event8)
[    33.577] (**) USB Camera: Applying InputClass "evdev keyboard
catchall"
[    33.577] (II) Using input driver 'evdev' for 'USB Camera'
[    33.577] (**) USB Camera: always reports core events
[    33.577] (**) evdev: USB Camera: Device: "/dev/input/event8"
[    33.577] (--) evdev: USB Camera: Vendor 0x4f2 Product 0xb379
[    33.577] (--) evdev: USB Camera: Found keys
[    33.577] (II) evdev: USB Camera: Configuring as keyboard
[    33.577] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.2/input=
/input16/event8"
[    33.577] (II) XINPUT: Adding extended input device "USB Camera"
(type: KEYBOARD, id 12)
[    33.577] (**) Option "xkb_rules" "evdev"
[    33.577] (**) Option "xkb_model" "pc105"
[    33.577] (**) Option "xkb_layout" "de"
[    33.577] (**) Option "xkb_variant" "nodeadkeys"
[    33.577] (II) config/udev: Adding input device HDA Intel PCH
Headphone (/dev/input/event10)
[    33.577] (II) No input driver specified, ignoring this device.
[    33.577] (II) This device may have been added with another device
file.
[    33.578] (II) config/udev: Adding input device HDA Intel PCH
HDMI/DP,pcm=3D3 (/dev/input/event9)
[    33.578] (II) No input driver specified, ignoring this device.
[    33.578] (II) This device may have been added with another device
file.
[    33.578] (II) config/udev: Adding input device N-trig DuoSense Pen
(/dev/input/event13)
[    33.578] (**) N-trig DuoSense Pen: Applying InputClass "evdev
tablet catchall"
[    33.578] (II) Using input driver 'evdev' for 'N-trig DuoSense Pen'
[    33.578] (**) N-trig DuoSense Pen: always reports core events
[    33.578] (**) evdev: N-trig DuoSense Pen: Device: "/dev/input/event13=
"
[    33.578] (--) evdev: N-trig DuoSense Pen: Vendor 0x1b96 Product 0x100=
1
[    33.578] (--) evdev: N-trig DuoSense Pen: Found 1 mouse buttons
[    33.578] (--) evdev: N-trig DuoSense Pen: Found absolute axes
[    33.578] (--) evdev: N-trig DuoSense Pen: Found x and y absolute axes=

[    33.578] (--) evdev: N-trig DuoSense Pen: Found absolute tablet.
[    33.578] (II) evdev: N-trig DuoSense Pen: Configuring as tablet
[    33.578] (**) evdev: N-trig DuoSense Pen: YAxisMapping: buttons 4
and 5
[    33.578] (**) evdev: N-trig DuoSense Pen: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    33.578] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.0/input=
/input20/event13"
[    33.578] (II) XINPUT: Adding extended input device "N-trig
DuoSense Pen" (type: TABLET, id 13)
[    33.578] (II) evdev: N-trig DuoSense Pen: initialized for absolute
axes.
[    33.578] (**) N-trig DuoSense Pen: (accel) keeping acceleration
scheme 1
[    33.578] (**) N-trig DuoSense Pen: (accel) acceleration profile 0
[    33.578] (**) N-trig DuoSense Pen: (accel) acceleration factor: 2.000=

[    33.578] (**) N-trig DuoSense Pen: (accel) acceleration threshold: 4
[    33.578] (II) config/udev: Adding input device N-trig DuoSense Pen
(/dev/input/mouse2)
[    33.578] (II) No input driver specified, ignoring this device.
[    33.578] (II) This device may have been added with another device
file.
[    33.579] (II) config/udev: Adding input device N-trig DuoSense
(/dev/input/event14)
[    33.579] (**) N-trig DuoSense: Applying InputClass "evdev
touchscreen catchall"
[    33.579] (II) Using input driver 'evdev' for 'N-trig DuoSense'
[    33.579] (**) N-trig DuoSense: always reports core events
[    33.579] (**) evdev: N-trig DuoSense: Device: "/dev/input/event14"
[    33.579] (--) evdev: N-trig DuoSense: Vendor 0x1b96 Product 0x1001
[    33.579] (--) evdev: N-trig DuoSense: Found absolute axes
[    33.579] (--) evdev: N-trig DuoSense: Found absolute multitouch axes
[    33.579] (--) evdev: N-trig DuoSense: Found x and y absolute axes
[    33.579] (--) evdev: N-trig DuoSense: Found absolute touchscreen
[    33.579] (II) evdev: N-trig DuoSense: Configuring as touchscreen
[    33.579] (**) evdev: N-trig DuoSense: YAxisMapping: buttons 4 and 5
[    33.579] (**) evdev: N-trig DuoSense: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    33.579] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.0/input=
/input21/event14"
[    33.579] (II) XINPUT: Adding extended input device "N-trig
DuoSense" (type: TOUCHSCREEN, id 14)
[    33.579] (II) evdev: N-trig DuoSense: initialized for absolute axes.
[    33.579] (**) N-trig DuoSense: (accel) keeping acceleration scheme 1
[    33.579] (**) N-trig DuoSense: (accel) acceleration profile 0
[    33.579] (**) N-trig DuoSense: (accel) acceleration factor: 2.000
[    33.579] (**) N-trig DuoSense: (accel) acceleration threshold: 4
[    33.579] (II) config/udev: Adding input device N-trig DuoSense
(/dev/input/mouse3)
[    33.579] (II) No input driver specified, ignoring this device.
[    33.579] (II) This device may have been added with another device
file.
[    33.580] (II) config/udev: Adding input device Asus WMI hotkeys
(/dev/input/event11)
[    33.580] (**) Asus WMI hotkeys: Applying InputClass "evdev
keyboard catchall"
[    33.580] (II) Using input driver 'evdev' for 'Asus WMI hotkeys'
[    33.580] (**) Asus WMI hotkeys: always reports core events
[    33.580] (**) evdev: Asus WMI hotkeys: Device: "/dev/input/event11"
[    33.580] (--) evdev: Asus WMI hotkeys: Vendor 0 Product 0
[    33.580] (--) evdev: Asus WMI hotkeys: Found keys
[    33.580] (II) evdev: Asus WMI hotkeys: Configuring as keyboard
[    33.580] (**) Option "config_info"
"udev:/sys/devices/platform/asus-nb-wmi/input/input19/event11"
[    33.580] (II) XINPUT: Adding extended input device "Asus WMI
hotkeys" (type: KEYBOARD, id 15)
[    33.580] (**) Option "xkb_rules" "evdev"
[    33.580] (**) Option "xkb_model" "pc105"
[    33.580] (**) Option "xkb_layout" "de"
[    33.580] (**) Option "xkb_variant" "nodeadkeys"
[    33.580] (II) config/udev: Adding input device AT Translated Set 2
keyboard (/dev/input/event3)
[    33.580] (**) AT Translated Set 2 keyboard: Applying InputClass
"evdev keyboard catchall"
[    33.580] (II) Using input driver 'evdev' for 'AT Translated Set 2
keyboard'
[    33.580] (**) AT Translated Set 2 keyboard: always reports core event=
s
[    33.580] (**) evdev: AT Translated Set 2 keyboard: Device:
"/dev/input/event3"
[    33.580] (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1
Product 0x1
[    33.580] (--) evdev: AT Translated Set 2 keyboard: Found keys
[    33.580] (II) evdev: AT Translated Set 2 keyboard: Configuring as
keyboard
[    33.580] (**) Option "config_info"
"udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
[    33.580] (II) XINPUT: Adding extended input device "AT Translated
Set 2 keyboard" (type: KEYBOARD, id 16)
[    33.580] (**) Option "xkb_rules" "evdev"
[    33.580] (**) Option "xkb_model" "pc105"
[    33.580] (**) Option "xkb_layout" "de"
[    33.580] (**) Option "xkb_variant" "nodeadkeys"
[    33.581] (II) config/udev: Adding input device ETPS/2 Elantech
Touchpad (/dev/input/event12)
[    33.581] (**) ETPS/2 Elantech Touchpad: Applying InputClass "evdev
touchpad catchall"
[    33.581] (**) ETPS/2 Elantech Touchpad: Applying InputClass
"touchpad catchall"
[    33.581] (**) ETPS/2 Elantech Touchpad: Applying InputClass
"Default clickpad buttons"
[    33.581] (II) LoadModule: "synaptics"
[    33.581] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
[    33.581] (II) Module synaptics: vendor=3D"X.Org Foundation"
[    33.581] 	compiled for 1.14.2, module version =3D 1.7.1
[    33.581] 	Module class: X.Org XInput Driver
[    33.581] 	ABI class: X.Org XInput driver, version 19.1
[    33.581] (II) Using input driver 'synaptics' for 'ETPS/2 Elantech
Touchpad'
[    33.581] (**) ETPS/2 Elantech Touchpad: always reports core events
[    33.581] (**) Option "Device" "/dev/input/event12"
[    33.616] (II) synaptics: ETPS/2 Elantech Touchpad: found clickpad
property
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: x-axis range 0
- - 3260 (res 32)
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: y-axis range 0
- - 2119 (res 32)
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: pressure range
0 - 255
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: finger width
range 0 - 15
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: buttons: left
double triple
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: Vendor 0x2
Product 0xe
[    33.616] (**) Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
[    33.616] (--) synaptics: ETPS/2 Elantech Touchpad: touchpad found
[    33.616] (**) ETPS/2 Elantech Touchpad: always reports core events
[    33.628] (**) Option "config_info"
"udev:/sys/devices/platform/i8042/serio4/input/input14/event12"
[    33.628] (II) XINPUT: Adding extended input device "ETPS/2
Elantech Touchpad" (type: TOUCHPAD, id 17)
[    33.628] (**) synaptics: ETPS/2 Elantech Touchpad: (accel)
MinSpeed is now constant deceleration 2.5
[    33.628] (**) synaptics: ETPS/2 Elantech Touchpad: (accel)
MaxSpeed is now 1.75
[    33.628] (**) synaptics: ETPS/2 Elantech Touchpad: (accel)
AccelFactor is now 0.051
[    33.628] (**) ETPS/2 Elantech Touchpad: (accel) keeping
acceleration scheme 1
[    33.628] (**) ETPS/2 Elantech Touchpad: (accel) acceleration profile =
1
[    33.628] (**) ETPS/2 Elantech Touchpad: (accel) acceleration
factor: 2.000
[    33.628] (**) ETPS/2 Elantech Touchpad: (accel) acceleration
threshold: 4
[    33.628] (--) synaptics: ETPS/2 Elantech Touchpad: touchpad found
[    33.628] (II) config/udev: Adding input device ETPS/2 Elantech
Touchpad (/dev/input/mouse1)
[    33.629] (**) ETPS/2 Elantech Touchpad: Ignoring device from
InputClass "touchpad ignore duplicates"
[    41.441] (II) intel(0): EDID vendor "CMN", prod id 4934
[    41.441] (II) intel(0): Printing DDC gathered Modelines:
[    41.441] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    41.441] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[    41.661] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    41.878] (II) intel(0): EDID vendor "CMN", prod id 4934
[    41.878] (II) intel(0): Printing DDC gathered Modelines:
[    41.878] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    41.879] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[    42.000] (II) intel(0): resizing framebuffer to 3840x1080
[    42.000] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[    42.028] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (0, 0), rotation normal
[    42.044] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[    42.367] (II) intel(0): EDID vendor "CMN", prod id 4934
[    42.367] (II) intel(0): Printing DDC gathered Modelines:
[    42.367] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    42.367] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[    42.476] (II) intel(0): EDID vendor "CMN", prod id 4934
[    42.476] (II) intel(0): Printing DDC gathered Modelines:
[    42.476] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    42.476] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[    42.479] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    42.500] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    42.529] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    42.550] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    42.640] (II) intel(0): EDID vendor "CMN", prod id 4934
[    42.640] (II) intel(0): Printing DDC gathered Modelines:
[    42.640] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    42.640] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[    42.654] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    42.670] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[    43.352] (II) XKB: reuse xkmfile
/var/lib/xkb/server-13A6C9E12C73E8B72651F486B89B9BD9B05CD54B.xkm
[    62.883] (II) intel(0): EDID vendor "CMN", prod id 4934
[    62.883] (II) intel(0): Printing DDC gathered Modelines:
[    62.883] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[    62.883] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   555.390] (II) intel(0): EDID vendor "CMN", prod id 4934
[   555.391] (II) intel(0): Printing DDC gathered Modelines:
[   555.391] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[   555.391] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   569.263] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[   570.148] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[   655.948] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[   656.832] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[   685.942] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[   686.824] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[   701.896] (II) AIGLX: Suspending AIGLX clients for VT switch
[   712.320] (II) Open ACPI successful (/var/run/acpid.socket)
[   712.320] (II) AIGLX: Resuming AIGLX clients after VT switch
[   712.320] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[   712.336] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[   712.414] (II) intel(0): EDID vendor "CMN", prod id 4934
[   712.414] (II) intel(0): Printing DDC gathered Modelines:
[   712.414] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[   712.414] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   712.415] (--) synaptics: ETPS/2 Elantech Touchpad: touchpad found
[   712.415] setversion 1.4 failed
[   712.430] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.444] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.459] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.475] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.483] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.492] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   712.501] (II) XKB: reuse xkmfile
/var/lib/xkb/server-E094786309367653F5AD22DA116DE31F851C8F2B.xkm
[   718.662] (II) intel(0): EDID vendor "CMN", prod id 4934
[   718.662] (II) intel(0): Printing DDC gathered Modelines:
[   718.662] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[   718.662] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   718.725] (II) intel(0): resizing framebuffer to 1920x1080
[   718.725] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[   718.744] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (0, 0), rotation normal
[   722.918] (II) intel(0): EDID vendor "CMN", prod id 4934
[   722.918] (II) intel(0): Printing DDC gathered Modelines:
[   722.918] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[   722.918] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   722.981] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using DP1, position (0, 0), rotation normal
[   732.758] (II) intel(0): EDID vendor "CMN", prod id 4934
[   732.758] (II) intel(0): Printing DDC gathered Modelines:
[   732.758] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[   732.758] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[   732.761] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[  1371.506] (II) intel(0): EDID vendor "CMN", prod id 4934
[  1371.506] (II) intel(0): Printing DDC gathered Modelines:
[  1371.506] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[  1371.506] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[  1371.508] (II) intel(0): resizing framebuffer to 3840x1080
[  1371.509] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[  1371.529] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (1920, 0), rotation normal
[  1428.541] (II) intel(0): EDID vendor "CMN", prod id 4935
[  1428.541] (II) intel(0): Printing DDC gathered Modelines:
[  1428.541] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[  1428.541] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[  1431.682] (II) intel(0): EDID vendor "CMN", prod id 4934
[  1431.682] (II) intel(0): Printing DDC gathered Modelines:
[  1431.682] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[  1431.682] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)
[  1435.909] (II) intel(0): resizing framebuffer to 1920x1080
[  1435.909] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 0
using eDP1, position (0, 0), rotation normal
[  1435.925] (II) intel(0): switch to mode 1920x1080@60.0 on pipe 1
using DP1, position (0, 0), rotation normal
[  1446.802] (II) intel(0): EDID vendor "CMN", prod id 4934
[  1446.802] (II) intel(0): Printing DDC gathered Modelines:
[  1446.802] (II) intel(0): Modeline "1920x1080"x0.0  138.78  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (66.7 kHz eP)
[  1446.802] (II) intel(0): Modeline "1920x1080"x0.0   92.52  1920
1966 1996 2080  1080 1082 1086 1112 -hsync -vsync (44.5 kHz e)


[X.] Other notes, patches, fixes, workarounds:
N/A

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQJ8BAEBCgBmBQJS0EPbXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDMjAzN0EzNzlGM0JGMzFGQ0VFOTJDNENE
RDNGNjFFNUYxMTMyRjY1AAoJEN0/YeXxEy9lv5gQAIKr4T1qWaKiHbtml4krasGq
0c2OjI3ooW8ksONqN/JbKn6Cejy6I6f+EKaz/w76voNI2UmVC/NpGEtJiN4P3MvV
UlOGaRnHiTcDwJKLT6I3zO/j1RiLfLjlppN1tCQspFmBZSKMHxT1LUX8skdici0v
mxfAMUhIkHUXP++yZXcRzHw+eHCmg2ojiiX4zOtEcw5ZzhiYeymlizv72EAjXVUd
i3cpCuWQGzYUm1yC4ypkbucBvbLyUWtGgAvmGoFEapdC8ytI5UZWdijcaTX9oGuS
r1fHfv/X7VDG4N2MbT3o9jmYT4Sk5GcZ349CxQZ7+9k0DxmFTLkzGa+Sr59QyWA6
1xjkSvYveYnYo7tSbaErttxJc9ohPdiMDrRNuMoN5l8MUeWvPXIWXA2A0+2UVcIu
/nAnEov795NR0qHx/4Vfd+tsxIddpau1iAp3qIN13d7ynst6hfDVgKmpwhl0b9JJ
A7O5ynXQ08W81lO97ZG/5GBFNRwrBJP3CH0lazUqTXKcc8YNlIs65IpHTuPCZwVN
RbwzkoZsOplA3KEM4xbrc1CIrB1y/JcWzOPttn6IfqUtmV7kn4oCjrBXnX5AIMg6
HZ6NyL+7T21/f14xr2/BxTeJ8cs4kDCAIB7o9EIalVsNIO+4wD0mh1FjOcdOarj/
G5q+/zqIA/KfLPyxbMx1
=3DnRjM
-----END PGP SIGNATURE-----


--------------ms040502000805050402010508
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKRTCC
BRowggQCoAMCAQICEG0Z6qcZT2ozIuYiMnqqcd4wDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3Qu
Y29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
RW1haWwwHhcNMTEwNDI4MDAwMDAwWhcNMjAwNTMwMTA0ODM4WjCBkzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAJKEhFtLV5jUXi+LpOFAyKNTWF9mZfEyTvefMn1V0HhMVbdClOD5J3EHxcZppLkyxPFA
GpDMJ1Zifxe1cWmu5SAb5MtjXmDKokH2auGj/7jfH0htZUOMKi4rYzh337EXrMLaggLW1DJq
1GdvIBOPXDX65VSAr9hxCh03CgJQU2yVHakQFLSZlVkSMf8JotJM3FLb3uJAAVtIaN3FSrTg
7SQfOq9xXwfjrL8UO7AlcWg99A/WF1hGFYE8aIuLgw9teiFX5jSw2zJ+40rhpVJyZCaRTqWS
D//gsWD9Gm9oUZljjRqLpcxCm5t9ImPTqaD8zp6Q30QZ9FxbNboW86eb/8ECAwEAAaOCAUsw
ggFHMB8GA1UdIwQYMBaAFImCZ33EnSZwAEu0UEh83j2uBG59MB0GA1UdDgQWBBR6E04AdFvG
eGNkJ8Ev4qBbvHnFezAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNV
HSAECjAIMAYGBFUdIAAwWAYDVR0fBFEwTzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3Qu
Y29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwdAYI
KwYBBQUHAQEEaDBmMD0GCCsGAQUFBzAChjFodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVRO
QWRkVHJ1c3RDbGllbnRfQ0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1
c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCF1r54V1VtM39EUv5C1QaoAQOAivsNsv1Kv/av
QUn1G1rF0q0bc24+6SZ85kyYwTAo38v7QjyhJT4KddbQPTmGZtGhm7VNm2+vKGwdr+XqdFqo
2rHA8XV6L566k3nK/uKRHlZ0sviN0+BDchvtj/1gOSBH+4uvOmVIPJg9pSW/ve9g4EnlFsjr
P0OD8ODuDcHTzTNfm9C9YGqzO/761Mk6PB/tm/+bSTO+Qik5g+4zaS6CnUVNqGnagBsePdIa
XXxHmaWbCG0SmYbWXVcHG6cwvktJRLiQfsrReTjrtDP6oDpdJlieYVUYtCHVmdXgQ0BCML7q
peeU0rD+83X5f27nMIIFIzCCBAugAwIBAgIQJ3QU8LUx4O3UtD+MKZ9+RzANBgkqhkiG9w0B
AQUFADCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENP
TU9ETyBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xMzA1
MTQwMDAwMDBaFw0xNDA1MTQyMzU5NTlaMCIxIDAeBgkqhkiG9w0BCQEWEWF4ZWwuaHVlYmxA
d2ViLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0lK/kxYlQPbZv9UNFwyN
V0CxKIc6MZ5zXDre+Rw6Uv24k6KmYYbRznS7Mi2o9IK7wCzyEY328mRqY6q36hXBrl1OTSuP
/s2rJ7U69/6JOJOBEQwJOUe6aZUhqocVAShU+C1agj/UTHNhHg4CcAD+nooNVUrwbbbe/CE2
hcNXWfNmuoHADdBVdyfcGaT+zwPvRh55RacezgxL6xTeVSx615TFf/PnM0pAO+Yjm7iFVKEw
MJyKE1v4gAyTYVfOut5qzKnBg6fXy8G395l1hO0SnxkHSPp6UoxL23Z5nvYveLrl+3jrZYE2
Knu1n4xXDtDdfuI0uL4yiNpm7hc1Uf59jQIDAQABo4IB4TCCAd0wHwYDVR0jBBgwFoAUehNO
AHRbxnhjZCfBL+KgW7x5xXswHQYDVR0OBBYEFOdMWCLyLg+KHqadhKEj9N+Y2sGkMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIx
AQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzAp
BggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwVwYDVR0fBFAwTjBM
oEqgSIZGaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBiAYIKwYBBQUHAQEEfDB6MFIGCCsGAQUFBzAChkZo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50aWNhdGlvbmFuZFNl
Y3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20w
HAYDVR0RBBUwE4ERYXhlbC5odWVibEB3ZWIuZGUwDQYJKoZIhvcNAQEFBQADggEBADImMW+g
FmD3DPpnu5lhrs2zLAJnRr6rXPJ5U8MKJ1zmSAjulBbgMhULLFk1Bc0yusU17PV0qqlFQoMX
TfoLaoZd6dj2TZoZbYLIUDrI/E8443MP7SKEHh1dJW1zDr65WkW2cl56fykyIJcwemjv7VYI
lT6H7WeYr8n4CptFpzzfZe0Dei7JGwmqV5d4xOPchbm/L/WbjlS/EXwhRMNRyDdijdESI8w/
bXMrWmo8UFTtW6skMHDDNF5W7DJCNkvberYp4QeKWWfMnUj4y/y3DSibOEWff1AeSi7oP6or
YerzgWcNLbrxsznBCJrGgDCVITtDhVKXhPLsXUGGhXhExaExggQZMIIEFQIBATCBqDCBkzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQJ3QU8LUx4O3UtD+MKZ9+
RzAJBgUrDgMCGgUAoIICRTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0xNDAxMTAxOTAyNTJaMCMGCSqGSIb3DQEJBDEWBBSY1ea2Fx/lYdmaim9g+aqLkRWg
ezBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMIG5BgkrBgEEAYI3EAQxgaswgagwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMTkwNwYDVQQDEzBDT01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0ECECd0FPC1MeDt1LQ/jCmffkcwgbsGCyqGSIb3DQEJEAILMYGroIGoMIGT
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhAndBTwtTHg7dS0P4wp
n35HMA0GCSqGSIb3DQEBAQUABIIBAK403zO454Sk6bXbVA8m87tDkcNhRpGUWqE73ckAw8eE
r5+sz8BdfEYLAmpI1XrfOsa7hfOidvmYKOdpH/vlmmYxEmid7SE7+9pqwp/BM+XGnhDKQIlq
ralxZa5DEYdSd5r3Z3ntMb8Y3f92KTVD2YFYS5BZAkkB2gOe0DErJPV6TlV5+uquK2a0lamP
brGaKsUeWjAlIRtboUloyaFePqsnpcwwHj2R2l/TUSGUviYZI9efGMC6jFYdLL7ymu6M/bqN
oQQVwYsNaH+fuO4tnnM+mQzktb2OUUJUd0HT1TLx6t6XgxSrmSuVEznoeJ7hZYaf0CAwgnyS
cTPkWHkQtWoAAAAAAAA=
--------------ms040502000805050402010508--
