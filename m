From: Maximiliano Oropeza <moropeza28@gmail.com>
Subject: Backlight upstream bug
Date: Sat, 03 Aug 2013 18:12:15 -0700
Message-ID: <51FDAA6F.9020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58727 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3HDBMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Aug 2013 21:12:18 -0400
Received: by mail-pd0-f172.google.com with SMTP id z11so1935316pdj.31
        for <linux-acpi@vger.kernel.org>; Sat, 03 Aug 2013 18:12:18 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: 1173961@bugs.launchpad.net

[Gateway NV55C] Two backlight interfaces that wont adjust backlight.

Full Description:
I couldn't get the backlight to work after I upgraded to 13.04.

WORKAROUND: The only grub lines that seem to work are these:
GRUB_CMDLINE_LINUX="acpi_osi=Linux acpi_backlight=vendor"
GRUB_CMDLINE_LINUX="acpi_osi="

I tried changing the grub parameters, and after several trys, nothing. I
was asked to run grep . /sys/class/backlight/*/* and got the results of:

maxo@Dayman:~$ grep . /sys/class/backlight/*/*
/sys/class/backlight/acpi_video0/actual_brightness:9
/sys/class/backlight/acpi_video0/bl_power:0
/sys/class/backlight/acpi_video0/brightness:9
grep: /sys/class/backlight/acpi_video0/device: Is a directory
/sys/class/backlight/acpi_video0/max_brightness:9
grep: /sys/class/backlight/acpi_video0/power: Is a directory
grep: /sys/class/backlight/acpi_video0/subsystem: Is a directory
/sys/class/backlight/acpi_video0/type:firmware
/sys/class/backlight/intel_backlight/actual_brightness:976
/sys/class/backlight/intel_backlight/bl_power:0
/sys/class/backlight/intel_backlight/brightness:976
grep: /sys/class/backlight/intel_backlight/device: Is a directory
/sys/class/backlight/intel_backlight/max_brightness:976
grep: /sys/class/backlight/intel_backlight/power: Is a directory
grep: /sys/class/backlight/intel_backlight/subsystem: Is a directory
/sys/class/backlight/intel_backlight/type:raw

But using the Fn Keys, you can only adjust it a little, like from full
brightness to about half. To add something else, with the other
parameters when I adjust with the Fn Keys, the brightness bubble you get
on the top right of your screen doesn't appear.

ProblemType: Bug
DistroRelease: Ubuntu 13.04
Package: linux-image-3.8.0-19-generic 3.8.0-19.29 [modified:
boot/vmlinuz-3.8.0-19-generic]
ProcVersionSignature: Ubuntu 3.8.0-19.29-generic 3.8.8
Uname: Linux 3.8.0-19-generic x86_64
NonfreeKernelModules: wl
ApportVersion: 2.9.2-0ubuntu8
Architecture: amd64
AudioDevicesInUse:
   USER PID ACCESS COMMAND
   /dev/snd/controlC0: maxo 2482 F.... pulseaudio
Date: Sun Apr 28 07:01:21 2013
HibernationDevice: RESUME=UUID=f71ed279-badf-446b-afc6-d5a75316ec0a
InstallationDate: Installed on 2013-04-25 (2 days ago)
InstallationMedia: Ubuntu 13.04 "Raring Ringtail" - Release amd64 (20130424)
MachineType: Gateway NV55C
MarkForUpload: True
ProcEnviron:
   TERM=xterm
   PATH=(custom, no user)
   XDG_RUNTIME_DIR=<set>
   LANG=en_US.UTF-8
   SHELL=/bin/bash
ProcFB: 0 inteldrmfb
ProcKernelCmdLine: BOOT_IMAGE=/boot/vmlinuz-3.8.0-19-generic
root=UUID=bc22ba4b-fcd9-46f3-b10a-11477dd4f618 ro acpi_osi=
acpi_backlight=vendor quiet splash vt.handoff=7
RelatedPackageVersions:
   linux-restricted-modules-3.8.0-19-generic N/A
   linux-backports-modules-3.8.0-19-generic N/A
   linux-firmware 1.106
SourcePackage: linux
UpgradeStatus: No upgrade log present (probably fresh install)
dmi.bios.date: 08/10/2011
dmi.bios.vendor: Gateway
dmi.bios.version: V1.24
dmi.board.asset.tag: Base Board Asset Tag
dmi.board.name: NV55C
dmi.board.vendor: Gateway
dmi.board.version: V1.24
dmi.chassis.type: 10
dmi.chassis.vendor: Gateway
dmi.chassis.version: V1.24
dmi.modalias:
dmi:bvnGateway:bvrV1.24:bd08/10/2011:svnGateway:pnNV55C:pvrV1.24:rvnGateway:rnNV55C:rvrV1.24:cvnGateway:ct10:cvrV1.24:
dmi.product.name: NV55C
dmi.product.version: V1.24
dmi.sys.vendor: Gateway

Link:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1173961

Keywords:
amd64 apport-bug kernel-bug-exists-upstream
kernel-bug-exists-upstream-3.11.0-999-generic latest-bios-v1.30 precise
quantal raring

Kernel Version:
Linux version 3.11.0-999-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201307300405 SMP Tue Jul 30 08:07:20
UTC 2013

Environment:
Description:    Ubuntu 13.04
Release:    13.04

Software:
   If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux Dayman 3.11.0-999-generic #201307300405 SMP Tue Jul 30 08:07:20
UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.7
Gnu make               3.81
binutils               2.23.2
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.5
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         coretemp nvram pci_stub vboxpci vboxnetadp
vboxnetflt vboxdrv parport_pc ppdev uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_core rfcomm videodev bnep bluetooth
binfmt_misc snd_hda_codec_hdmi snd_hda_codec_realtek arc4 brcmsmac
cordic brcmutil b43 snd_hda_intel snd_hda_codec mac80211 snd_hwdep
snd_pcm cfg80211 snd_page_alloc snd_seq_midi snd_seq_midi_event
snd_rawmidi i915 snd_seq snd_seq_device snd_timer snd ssb drm_kms_helper
soundcore drm mei_me mei i2c_algo_bit psmouse lpc_ich serio_raw bcma
intel_ips joydev acer_wmi sparse_keymap mxm_wmi video lp wmi mac_hid
parport hid_generic ums_realtek usbhid usb_storage hid tg3 ptp pps_core
ahci libahci

Processor Info:
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 2399.000
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bogomips    : 4787.65
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 2399.000
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bogomips    : 4787.65
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 2399.000
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bogomips    : 4787.65
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 2399.000
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bogomips    : 4787.65
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

Modules:
coretemp 17728 0 - Live 0x0000000000000000
nvram 14413 0 - Live 0x0000000000000000
pci_stub 12622 1 - Live 0x0000000000000000
vboxpci 23194 0 - Live 0x0000000000000000 (OF)
vboxnetadp 25670 0 - Live 0x0000000000000000 (OF)
vboxnetflt 27613 0 - Live 0x0000000000000000 (OF)
vboxdrv 320461 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OF)
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 40785 1 uvcvideo, Live 0x0000000000000000
rfcomm 74589 0 - Live 0x0000000000000000
videodev 138443 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
bluetooth 391564 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 41688 1 - Live 0x0000000000000000
snd_hda_codec_realtek 56259 1 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
brcmsmac 564290 0 - Live 0x0000000000000000
cordic 12574 1 brcmsmac, Live 0x0000000000000000
brcmutil 15618 1 brcmsmac, Live 0x0000000000000000
b43 397252 0 - Live 0x0000000000000000
snd_hda_intel 48717 3 - Live 0x0000000000000000
snd_hda_codec 194727 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0x0000000000000000
mac80211 618984 2 brcmsmac,b43, Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
cfg80211 494624 3 brcmsmac,b43,mac80211, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30416 1 snd_seq_midi, Live 0x0000000000000000
i915 678644 8 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 69657 17
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 

Live 0x0000000000000000
ssb 62890 1 b43, Live 0x0000000000000000
drm_kms_helper 53178 1 i915, Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
drm 298236 4 i915,drm_kms_helper, Live 0x0000000000000000
mei_me 18539 0 - Live 0x0000000000000000
mei 78448 1 mei_me, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
psmouse 104015 0 - Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
serio_raw 13413 0 - Live 0x0000000000000000
bcma 47065 3 brcmsmac,b43, Live 0x0000000000000000
intel_ips 18520 0 - Live 0x0000000000000000
joydev 17613 0 - Live 0x0000000000000000
acer_wmi 32938 0 - Live 0x0000000000000000
sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
mxm_wmi 13021 0 - Live 0x0000000000000000
video 19574 2 i915,acer_wmi, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
wmi 19256 2 acer_wmi,mxm_wmi, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
parport 42466 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
ums_realtek 18336 0 - Live 0x0000000000000000
usbhid 53329 0 - Live 0x0000000000000000
usb_storage 66567 1 ums_realtek, Live 0x0000000000000000
hid 105557 2 hid_generic,usbhid, Live 0x0000000000000000
tg3 170347 0 - Live 0x0000000000000000
ptp 18627 1 tg3, Live 0x0000000000000000
pps_core 19027 1 ptp, Live 0x0000000000000000
ahci 30063 2 - Live 0x0000000000000000
libahci 32088 1 ahci, Live 0x0000000000000000

Loaded driver and hardware information:
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
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
    0450-0450 : ACPI PM2_CNT_BLK
    0460-047f : iTCO_wdt
    0500-057f : pnp 00:04
    0680-069f : pnp 00:04
    0800-080f : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
    1000-1fff : PCI Bus 0000:02
    2000-2fff : PCI Bus 0000:01
    3000-301f : 0000:00:1f.3
    3020-303f : 0000:00:1f.2
      3020-303f : ahci
    3040-3047 : 0000:00:1f.2
      3040-3047 : ahci
    3048-304f : 0000:00:1f.2
      3048-304f : ahci
    3050-3057 : 0000:00:02.0
    3058-305b : 0000:00:1f.2
      3058-305b : ahci
    305c-305f : 0000:00:1f.2
      305c-305f : ahci
    ff2c-ff2f : pnp 00:04
    ffff-ffff : pnp 00:04
      ffff-ffff : pnp 00:04
maxo@Dayman:~$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009cfff : System RAM
0009d000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000d0000-000d1fff : Adapter ROM
000e0000-000fffff : reserved
    000f0000-000fffff : System ROM
00100000-93680fff : System RAM
    01000000-01737753 : Kernel code
    01737754-01d0eaff : Kernel data
    01e70000-01fe2fff : Kernel bss
93681000-936befff : reserved
936bf000-93735fff : System RAM
93736000-937befff : ACPI Non-volatile Storage
937bf000-937defff : System RAM
937df000-937fefff : ACPI Tables
937ff000-937fffff : System RAM
93800000-9fffffff : reserved
a0000000-febfffff : PCI Bus 0000:00
    a0000000-afffffff : 0000:00:02.0
    b0000000-b03fffff : 0000:00:02.0
    b0400000-b13fffff : PCI Bus 0000:01
    b1400000-b23fffff : PCI Bus 0000:02
    b2400000-b33fffff : PCI Bus 0000:02
      b2400000-b2403fff : 0000:02:00.0
        b2400000-b2403fff : bcma-pci-bridge
    b3400000-b43fffff : PCI Bus 0000:01
      b3400000-b340ffff : 0000:01:00.0
        b3400000-b340ffff : tg3
    b4400000-b4403fff : 0000:00:1b.0
      b4400000-b4403fff : ICH HD audio
    b4404000-b4404fff : 0000:00:1f.6
      b4404000-b4404fff : ips thermal sensor
    b4405000-b44057ff : 0000:00:1f.2
      b4405000-b44057ff : ahci
    b4405800-b4405bff : 0000:00:1d.0
      b4405800-b4405bff : ehci_hcd
    b4405c00-b4405fff : 0000:00:1a.0
      b4405c00-b4405fff : ehci_hcd
    b4406000-b44060ff : 0000:00:1f.3
    b4406100-b440610f : 0000:00:16.0
      b4406100-b440610f : mei_me
    b4407000-b4407fff : Intel Flush Page
    b4500000-b4500fff : pnp 00:08
    e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
      e0000000-efffffff : reserved
        e0000000-efffffff : pnp 00:08
    feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed13fff : reserved
    fed10000-fed13fff : pnp 00:08
fed18000-fed19fff : reserved
    fed18000-fed18fff : pnp 00:08
    fed19000-fed19fff : pnp 00:08
fed1b000-fed1ffff : reserved
    fed1c000-fed1ffff : pnp 00:08
      fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:08
fed45000-fed8ffff : pnp 00:08
fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
ffe80000-ffffffff : reserved
100000000-157ffffff : System RAM

PCI information:

00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller
(rev 02)
      Subsystem: Acer Incorporated [ALI] TravelMate 5742
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
      Latency: 0
      Capabilities: [e0] Vendor Specific Information: Len=0c <?>
      Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Core Processor
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 42
      Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
      Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
      Region 4: I/O ports at 3050 [size=8]
      Expansion ROM at <unassigned> [disabled]
      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
          Address: fee0f00c  Data: 41b1
      Capabilities: [d0] Power Management version 2
          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [a4] PCI Advanced Features
          AFCap: TP+ FLR+
          AFCtrl: FLR-
          AFStatus: TP-
      Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series
Chipset HECI Controller (rev 06)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 41
      Region 0: Memory at b4406100 (64-bit, non-prefetchable) [size=16]
      Capabilities: [50] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
          Address: 00000000fee0f00c  Data: 4192
      Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 16
      Region 0: Memory at b4405c00 (32-bit, non-prefetchable) [size=1K]
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
High Definition Audio (rev 05)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 43
      Region 0: Memory at b4400000 (64-bit, non-prefetchable) [size=16K]
      Capabilities: [50] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
          Address: 00000000fee0f00c  Data: 41a2
      Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,
MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
              ExtTag- RBE- FLReset+
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
              ClockPM- Surprise- LLActRep- BwNot-
          LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
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
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
      I/O behind bridge: 00002000-00002fff
      Memory behind bridge: b3400000-b43fffff
      Prefetchable memory behind bridge: 00000000b0400000-00000000b13fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
              ExtTag- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
              ClockPM- Surprise- LLActRep+ BwNot-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
              Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
              Changed: MRL- PresDet- LinkState-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ ARIFwd-
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0487
      Capabilities: [a0] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 2 (rev 05) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
      I/O behind bridge: 00001000-00001fff
      Memory behind bridge: b2400000-b33fffff
      Prefetchable memory behind bridge: 00000000b1400000-00000000b23fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
              ExtTag- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
              ClockPM- Surprise- LLActRep+ BwNot-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
              Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
              Changed: MRL- PresDet- LinkState-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ ARIFwd-
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0487
      Capabilities: [a0] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 23
      Region 0: Memory at b4405800 (32-bit, non-prefetchable) [size=1K]
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

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a5)
(prog-if 01 [Subtractive decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
      I/O behind bridge: 0000f000-00000fff
      Memory behind bridge: fff00000-000fffff
      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
      Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [50] Subsystem: Acer Incorporated [ALI] Device 0487

00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 05)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Capabilities: [e0] Vendor Specific Information: Len=10 <?>
      Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
4 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin B routed to IRQ 40
      Region 0: I/O ports at 3048 [size=8]
      Region 1: I/O ports at 305c [size=4]
      Region 2: I/O ports at 3040 [size=8]
      Region 3: I/O ports at 3058 [size=4]
      Region 4: I/O ports at 3020 [size=32]
      Region 5: Memory at b4405000 (32-bit, non-prefetchable) [size=2K]
      Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
          Address: fee0100c  Data: 4181
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

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 05)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Interrupt: pin C routed to IRQ 10
      Region 0: Memory at b4406000 (64-bit, non-prefetchable) [size=256]
      Region 4: I/O ports at 3000 [size=32]

00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
Series Chipset Thermal Subsystem (rev 05)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Interrupt: pin A routed to IRQ 21
      Region 0: Memory at b4404000 (64-bit, non-prefetchable) [size=4K]
      Capabilities: [50] Power Management version 3
          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Kernel driver in use: intel ips

01:00.0 Ethernet controller: Broadcom Corporation NetLink BCM57780
Gigabit Ethernet PCIe (rev 01)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 44
      Region 0: Memory at b3400000 (64-bit, non-prefetchable) [size=64K]
      Capabilities: [48] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
      Capabilities: [60] Vendor Specific Information: Len=6c <?>
      Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
          Address: 00000000fee0f00c  Data: 41b2
      Capabilities: [cc] Express (v2) Endpoint, MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,
L1 unlimited
              ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 512 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <32us
              ClockPM+ Surprise- LLActRep- BwNot-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
          DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [100 v1] Advanced Error Reporting
          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
      Capabilities: [13c v1] Virtual Channel
          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
          Arb:    Fixed- WRR32- WRR64- WRR128-
          Ctrl:    ArbSelect=Fixed
          Status:    InProgress-
          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
              Status:    NegoPending- InProgress-
      Capabilities: [160 v1] Device Serial Number b8-70-f4-ff-fe-e4-9c-c0
      Capabilities: [16c v1] Power Budgeting <?>
      Kernel driver in use: tg3

02:00.0 Network controller: Broadcom Corporation BCM43225 802.11b/g/n
(rev 01)
      Subsystem: Broadcom Corporation Device 04da
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 17
      Region 0: Memory at b2400000 (64-bit, non-prefetchable) [size=16K]
      Capabilities: [40] Power Management version 3
          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
      Capabilities: [58] Vendor Specific Information: Len=78 <?>
      Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
          Address: 0000000000000000  Data: 0000
      Capabilities: [d0] Express (v1) Endpoint, MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,
L1 unlimited
              ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <4us, L1 <64us
              ClockPM+ Surprise- LLActRep+ BwNot-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
      Capabilities: [100 v1] Advanced Error Reporting
          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
          CESta:    RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout- NonFatalErr-
          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
      Capabilities: [13c v1] Virtual Channel
          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
          Arb:    Fixed- WRR32- WRR64- WRR128-
          Ctrl:    ArbSelect=Fixed
          Status:    InProgress-
          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
              Status:    NegoPending- InProgress-
      Capabilities: [160 v1] Device Serial Number 00-00-9d-ff-ff-2c-1c-65
      Capabilities: [16c v1] Power Budgeting <?>
      Kernel driver in use: bcma-pci-bridge

ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-core Registers (rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0
(rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

ff:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

ff:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
      Subsystem: Acer Incorporated [ALI] Device 0487
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0

SCSI information:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: ATA      Model: WDC WD3200BPVT-2 Rev: 01.0
    Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
    Vendor: MATSHITA Model: DVD-RAM UJ892AS  Rev: 1.00
    Type:   CD-ROM                           ANSI  SCSI revision: 05


Other Information:
1     1312   243   2628   31018  3283  54         bus mounts
10    1315   2440  2632   3124   3289  55         cgroups mtrr
1029  1322   245   2638   3127   33    56         cmdline net
1066  1337   246   2651   3134   3339  57         consoles pagetypeinfo
1067  1339   247   2663   3137   3365  58         cpuinfo partitions
1073  1340   25    2682   3139   3377  69         crypto sched_debug
1075  1396   2500  2683   3141   34    7          devices schedstat
1076  14     2503  2686   3142   35    73         diskstats scsi
1077  15     2504  2688   31626  36    731        dma self
11    16     2506  27     3193   362   759        dri slabinfo
1103  1631   2513  2737   3197   37    761        driver softirqs
1106  17     2516  2739   3198   3763  77         execdomains stat
1178  18     2530  2741   3205   38    785        fb swaps
1180  1831   2537  2743   3207   380   787        filesystems sys
1183  1874   2543  2745   3214   382   792        fs sysrq-trigger
1188  1885   2547  2749   3216   39    793        interrupts sysvipc
1194  19     2554  2750   32168  40    794        iomem timer_list
1195  2      2562  2752   32169  4052  795        ioports timer_stats
1197  20     2564  2782   32179  41    8          irq tty
12    20695  2569  28     3218   42    865        kallsyms uptime
1200  21     2575  2804   3220   43    875        kcore version
1203  2128   2581  283    3233   44    8835       key-users vmallocinfo
1219  2132   2584  284    3234   45    890        kmsg vmstat
1220  2133   2585  285    3248   46    9          kpagecount zoneinfo
1225  2134   2586  29     3249   47    933        kpageflags
1236  2178   2587  29520  32541  48    949        latency_stats
1241  22     2589  29942  32547  4845  954        loadavg
1265  23     2591  3      32549  49    96         locks
1276  2310   26    30     32556  5     97         mdstat
1294  2354   2606  30300  32559  50    acpi       meminfo
1299  24     2609  30592  32561  52    asound     misc
13    2429   2624  31     32718  53    buddyinfo  modules

