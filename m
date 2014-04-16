From: Juho Rinta-Paavola <juho.s.rp@gmail.com>
Subject: Problem: Kernel panic on systems with an invalid XSDT
Date: Wed, 16 Apr 2014 13:35:09 +0003
Message-ID: <1397655129.911.2@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:45848 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161111AbaDPNcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Apr 2014 09:32:14 -0400
Received: by mail-la0-f42.google.com with SMTP id ec20so8240746lab.29
        for <linux-acpi@vger.kernel.org>; Wed, 16 Apr 2014 06:32:12 -0700 (PDT)
Received: from [192.168.0.13] (85-23-143-251.bb.dnainternet.fi. [85.23.143.251])
        by mx.google.com with ESMTPSA id t3sm22159371laj.15.2014.04.16.06.32.10
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Apr 2014 06:32:11 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
The kernel panics during early boot, which seems to be caused by an 
invalid XSDT.

[2.] Full description of the problem/report:
The panic can be worked around by passing acpi=off on the kernel 
command line. Passing acpi=ht crashes.

[3.] Keywords (i.e., modules, networking, kernel): -
[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Several kernels were tested

[4.2.] Kernel .config file:
I used the default arch linux config 
(https://projects.archlinux.org/svntogit/packages.git/tree/trunk/config.x86_64?h=packages/linux), 
running make oldconfig and selecting the defaults.

[5.] Most recent kernel version which did not have the bug:
Output of git bisect:

671cc68dc61f029d44b43a681356078e02d8dab8 is the first bad commit
commit 671cc68dc61f029d44b43a681356078e02d8dab8
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Wed Jan 8 13:43:34 2014 +0800

    ACPICA: Back port and refine validation of the XSDT root table.
    
    Some platforms contain an XSDT that is ill-formed or otherwise 
invalid
    (such as containing some or all entries that are NULL pointers).
    This change adds a new function to validate the XSDT before actually
    using it. If the XSDT is found to be invalid, ACPICA will now fall
    back to using the RSDT instead.
    
    This feature is already in the Linux kernel.  When it is back 
ported to
    ACPICA, code is refined to follow ACPICA coding style and this patch
    is the generation of the integration.
    
    Original-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Lv Zheng <lv.zheng@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 b9b63bad9d65df4ebb65f85a56dcba9cd8840eda 
338c3b6dfb615c66cb395454c93b286fca2d90ea M	drivers
:040000 040000 0b24f0b4c5222c4c7fa484a77af7df5e522b25f6 
332ff4f01ef48abbc2074eadee6c5a6ac4fac4f8 M	include

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
ACPI: RSDP 0x00000000BA7D8000 000024 (v02 ALASKA)
ACPI BIOS Warning (bug): XSDT is invalid (AE_NULL_ENTRY), using RSDT 
(20140214/tbutils-514)
BUG: unable to handle kernel paging request at ffffffffff4b5010
IP: [<ffffffff81920bb4>] acpi_tb_parse_root_table+0x123/0x2e1
PGD 1812067 PUD 1814067 PMD 19f1067 PTE 0
Oops: 0000 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 
3.15.0-rc1-BISECT-00049-g10ec34f #1
Hardware name: Gigabyte Technology Co., Ltd. H87N-WIFI/H87N-WIFI, BIOS 
F1 05/07/2013
task: ffffffff81816460 ti: ffffffff81800000 task.ti: ffffffff81800000
RIP: 0010:[<ffffffff81920bb4>]  [<ffffffff81920bb4>] 
acpi_tb_parse_root_table+0x123/0x2e1
RSP: 0000:ffffffff81801e58  EFLAGS: 00010096
RAX: 0000000000000017 RBX: 00000000ba7d8078 RCX: 0000000000000086
RDX: 0000000000000090 RSI: 0000000000000046 RDI: 0000000000000046
RBP: ffffffff81801e98 R08: ffffffff81a30d90 R09: 000000000000011f
R10: 000000000000011e R11: 0000000000000003 R12: 0000000000000004
R13: ffffffffff4b5000 R14: 000000000000000a R15: 000000000000007c
FS:  0000000000000000(0000) GS:ffffffff818cf000(0000) knlGS: 
0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff4b5010 CR3: 000000000180f000 CR4: 00000000000000b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 0000000000000000 662f6c656e73656b 2f657261776d7269 ffff88007fffffbd
 00000000002fefbd 0000000080000000 0000000000000003 0000000000000000
 ffffffff81801ea8 ffffffff81920dc9 ffffffff81801ec8 ffffffff8191ee1a
Call Trace:
 [<ffffffff81920dc9>] acpi_initialize_tables+0x57/0x59
 [<ffffffff8191ee1a>] acpi_table_init+0x1b/0x99
 [<ffffffff818f6793>] acpi_boot_table_init+0x1e/0x85
 [<ffffffff818ed6e2>] setup_arch+0x98y/0xcb3
 [<ffffffff818e5120>] ? early_idt_handlers+0x120/0x120
 [<ffffffff818e5c02>] start_kernel+0xcf/0x44c
 [<ffffffff818e5120>] ? early_idt_handlers+0x120/0x120
 [<ffffffff818e55ee>] x86_64_start_reservations+0x2a/0x2c
 [<ffffffff818e572e>] x86_64_start_kernel+0x13e/0x14d
Code: 44 89 f7 e8 61 ca 9e ff 48 c7 c2 d2 65 72 81 48 89 c1 be 02 00 00 
48 c7 c7 10 c3 64 81 31 c0 41 bc 04 00 00 00 e8 48 fd 9e ff <41> 8b 5d 
10 be 24 00 00 00 48 89 df e8 34 aa ba ff 48 85 c0 49
RIP  [<ffffffff81920bb4>] acpi_tb_parse_root_table+0x123/0x2e1
 RSP <ffffffff81801e58>
CR2: ffffffffff4b5010
---[ end trace 7bd752337c2c2b7b ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

[7.] A small shell script or example program which triggers the
     problem (if possible)
n/a

[8.] Environment
Note: these are from a boot with acpi=off.

[8.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ananas 3.14.1-1-ARCH #1 SMP PREEMPT Mon Apr 14 20:40:47 CEST 2014 
x86_64 GNU/Linux
 
Gnu C                  4.8.2
Gnu make               4.0
binutils               2.24
util-linux             2.24.1
mount                  assert
module-init-tools      17
e2fsprogs              1.42.9
jfsutils               1.1.15
reiserfsprogs          3.6.24
xfsprogs               3.1.11
pcmciautils            018
PPP                    2.4.6
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Linux C++ Library      so -> libstdc++.so.6
Procps                 3.3.9
Kbd                    2.0.1
Sh-utils               8.22
wireless-tools         30
Modules Loaded         fuse ctr ccm nvidia_uvm mousedev mac_hid btusb 
bluetooth hid_generic snd_usb_audio uvcvideo videobuf2_vmalloc 
videobuf2_memops snd_usbmidi_lib usbhid videobuf2_core snd_rawmidi 
videodev hid 6lowpan_iphc snd_seq_device media it87 hwmon_vid 
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic 
nls_iso8859_1 nls_cp437 vfat fat nvidia arc4 evdev iTCO_wdt gpio_ich 
iTCO_vendor_support iwldvm led_class coretemp hwmon mac80211 processor 
x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm iwlwifi 
crct10dif_pclmul crc32_pclmul snd_hda_intel crc32c_intel snd_hda_codec 
ghash_clmulni_intel snd_hwdep snd_pcm aesni_intel drm cfg80211 
aes_x86_64 lrw gf128mul glue_helper ablk_helper e1000e cryptd microcode 
alx i2c_i801 pcspkr mdio i2c_core snd_timer snd rfkill soundcore mei_me 
ptp mei pps_core shpchp lpc_ich ext4 crc16 mbcache jbd2 sd_mod 
crc_t10dif crct10dif_common ahci libahci libata ehci_pci scsi_mod 
ehci_hcd xhci_hcd usbcore usb_common

[8.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz
stepping	: 3
microcode	: 0x9
cpu MHz		: 832.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm
bogomips	: 6388.58
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz
stepping	: 3
microcode	: 0x9
cpu MHz		: 832.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm
bogomips	: 6388.58
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz
stepping	: 3
microcode	: 0x9
cpu MHz		: 782.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm
bogomips	: 6388.58
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz
stepping	: 3
microcode	: 0x9
cpu MHz		: 832.000
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand 
lahf_lm abm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm
bogomips	: 6388.58
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[8.3.] Module information (from /proc/modules):
fuse 77228 3 - Live 0xffffffffa003d000
ctr 3831 3 - Live 0xffffffffa0002000
ccm 7894 3 - Live 0xffffffffa003a000
nvidia_uvm 25904 2 - Live 0xffffffffa0032000 (PO)
mousedev 10464 0 - Live 0xffffffffa198f000
mac_hid 3305 0 - Live 0xffffffffa1987000
btusb 20136 0 - Live 0xffffffffa1973000
bluetooth 342577 2 btusb, Live 0xffffffffa18e6000
hid_generic 1153 0 - Live 0xffffffffa1885000
snd_usb_audio 118323 3 - Live 0xffffffffa185a000
uvcvideo 72804 0 - Live 0xffffffffa1842000
videobuf2_vmalloc 3304 1 uvcvideo, Live 0xffffffffa182e000
videobuf2_memops 2335 1 videobuf2_vmalloc, Live 0xffffffffa182a000
snd_usbmidi_lib 19756 1 snd_usb_audio, Live 0xffffffffa1801000
usbhid 40577 0 - Live 0xffffffffa17f1000
videobuf2_core 29255 1 uvcvideo, Live 0xffffffffa17e4000
snd_rawmidi 18742 1 snd_usbmidi_lib, Live 0xffffffffa17bc000
videodev 122955 2 uvcvideo,videobuf2_core, Live 0xffffffffa1753000
hid 91094 2 hid_generic,usbhid, Live 0xffffffffa1735000
6lowpan_iphc 11364 1 bluetooth, Live 0xffffffffa1729000
snd_seq_device 5180 1 snd_rawmidi, Live 0xffffffffa1723000
media 12103 2 uvcvideo,videodev, Live 0xffffffffa171b000
it87 29239 0 - Live 0xffffffffa170d000
hwmon_vid 3260 1 it87, Live 0xffffffffa1709000
snd_hda_codec_hdmi 36588 1 - Live 0xffffffffa16fa000
snd_hda_codec_realtek 46566 1 - Live 0xffffffffa16e7000
snd_hda_codec_generic 53211 1 snd_hda_codec_realtek, Live 
0xffffffffa16d3000
nls_iso8859_1 4421 1 - Live 0xffffffffa16ce000
nls_cp437 5953 1 - Live 0xffffffffa16c9000
vfat 10119 1 - Live 0xffffffffa16c3000
fat 51960 1 vfat, Live 0xffffffffa16b0000
nvidia 10784100 38 nvidia_uvm, Live 0xffffffffa0bc2000 (PO)
arc4 2000 2 - Live 0xffffffffa0bbe000
evdev 10629 4 - Live 0xffffffffa0bb7000
iTCO_wdt 5375 0 - Live 0xffffffffa0bb2000
gpio_ich 4552 0 - Live 0xffffffffa0bad000
iTCO_vendor_support 1929 1 iTCO_wdt, Live 0xffffffffa0ba9000
iwldvm 167546 0 - Live 0xffffffffa0b76000
led_class 3547 1 iwldvm, Live 0xffffffffa0b72000
coretemp 6390 0 - Live 0xffffffffa0b5d000
hwmon 3057 2 it87,coretemp, Live 0xffffffffa0b51000
mac80211 490609 1 iwldvm, Live 0xffffffffa0ab2000
processor 24385 0 - Live 0xffffffffa0a66000
x86_pkg_temp_thermal 6991 0 - Live 0xffffffffa0a4e000
intel_powerclamp 9154 0 - Live 0xffffffffa0a32000
kvm_intel 132876 0 - Live 0xffffffffa098e000
kvm 404172 1 kvm_intel, Live 0xffffffffa083e000
iwlwifi 143364 1 iwldvm, Live 0xffffffffa0741000
crct10dif_pclmul 4682 0 - Live 0xffffffffa071c000
crc32_pclmul 2923 0 - Live 0xffffffffa06f9000
snd_hda_intel 37704 13 - Live 0xffffffffa06e6000
crc32c_intel 14185 0 - Live 0xffffffffa06ce000
snd_hda_codec 99871 4 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, 
Live 0xffffffffa0641000
ghash_clmulni_intel 4330 0 - Live 0xffffffffa063c000
snd_hwdep 6332 2 snd_usb_audio,snd_hda_codec, Live 0xffffffffa062a000
snd_pcm 79815 8 
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0xffffffffa05e2000
aesni_intel 144295 6 - Live 0xffffffffa051d000
drm 237667 2 nvidia, Live 0xffffffffa04c6000
cfg80211 431038 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa0427000
aes_x86_64 7399 1 aesni_intel, Live 0xffffffffa0418000
lrw 3565 1 aesni_intel, Live 0xffffffffa0414000
gf128mul 5858 1 lrw, Live 0xffffffffa03fc000
glue_helper 4417 1 aesni_intel, Live 0xffffffffa03e5000
ablk_helper 2004 1 aesni_intel, Live 0xffffffffa03df000
e1000e 222996 0 - Live 0xffffffffa0398000
cryptd 8441 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0xffffffffa0381000
microcode 16837 0 - Live 0xffffffffa036f000
alx 29404 0 - Live 0xffffffffa0362000
i2c_i801 11269 0 - Live 0xffffffffa035b000
pcspkr 2027 0 - Live 0xffffffffa0349000
mdio 3215 1 alx, Live 0xffffffffa0345000
i2c_core 24824 4 videodev,nvidia,drm,i2c_i801, Live 0xffffffffa0337000
snd_timer 18718 5 snd_pcm, Live 0xffffffffa0300000
snd 59286 36 
snd_usb_audio,snd_usbmidi_lib,snd_rawmidi,snd_seq_device,snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer, 
Live 0xffffffffa02ce000
rfkill 15619 3 bluetooth,cfg80211, Live 0xffffffffa02c5000
soundcore 5418 1 snd, Live 0xffffffffa02b9000
mei_me 9456 0 - Live 0xffffffffa02ab000
ptp 8212 1 e1000e, Live 0xffffffffa02af000
mei 64646 1 mei_me, Live 0xffffffffa0293000
pps_core 8833 1 ptp, Live 0xffffffffa0268000
shpchp 25393 0 - Live 0xffffffffa025c000
lpc_ich 13368 0 - Live 0xffffffffa0253000
ext4 481838 2 - Live 0xffffffffa01b9000
crc16 1359 2 bluetooth,ext4, Live 0xffffffffa01b5000
mbcache 6074 1 ext4, Live 0xffffffffa01af000
jbd2 82704 1 ext4, Live 0xffffffffa018e000
sd_mod 36882 6 - Live 0xffffffffa0170000
crc_t10dif 1039 1 sd_mod, Live 0xffffffffa0168000
crct10dif_common 1372 2 crct10dif_pclmul,crc_t10dif, Live 
0xffffffffa0164000
ahci 23627 4 - Live 0xffffffffa0158000
libahci 21484 1 ahci, Live 0xffffffffa014c000
libata 172264 2 ahci,libahci, Live 0xffffffffa0106000
ehci_pci 3928 0 - Live 0xffffffffa0102000
scsi_mod 134432 2 sd_mod,libata, Live 0xffffffffa00cd000
ehci_hcd 64491 1 ehci_pci, Live 0xffffffffa00b7000
xhci_hcd 145277 0 - Live 0xffffffffa0088000
usbcore 182430 8 
btusb,snd_usb_audio,uvcvideo,snd_usbmidi_lib,usbhid,ehci_pci,ehci_hcd,xhci_hcd, 
Live 0xffffffffa0004000
usb_common 1648 1 usbcore, Live 0xffffffffa0000000

[8.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc_cmos
  0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03f8-03ff : serial
0a35-0a36 : it87
  0a35-0a36 : it87
0cf8-0cff : PCI conf1
1828-182f : gpio_ich
1830-1833 : iTCO_wdt
1860-187f : iTCO_wdt
1c00-1c3f : gpio_ich
d000-dfff : PCI Bus 0000:03
  d000-d07f : 0000:03:00.0
e000-efff : PCI Bus 0000:01
  e000-e07f : 0000:01:00.0
f000-f03f : 0000:00:02.0
f040-f05f : 0000:00:1f.3
  f040-f05f : i801_smbus
f060-f07f : 0000:00:1f.2
  f060-f07f : ahci
f080-f09f : 0000:00:19.0
f0a0-f0a3 : 0000:00:1f.2
  f0a0-f0a3 : ahci
f0b0-f0b7 : 0000:00:1f.2
  f0b0-f0b7 : ahci
f0c0-f0c3 : 0000:00:1f.2
  f0c0-f0c3 : ahci
f0d0-f0d7 : 0000:00:1f.2
  f0d0-f0d7 : ahci
f0e0-f0e7 : 0000:00:16.3
  f0e0-f0e7 : serial

-------------------------------------
00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009ffff : System RAM
000c0000-000ce7ff : Video ROM
000f0000-000fffff : System ROM
00100000-a95fb017 : System RAM
  01000000-014e7348 : Kernel code
  014e7349-018c88ff : Kernel data
  019e6000-01b26fff : Kernel bss
a95fb018-a960a857 : System RAM
a960a858-a960b017 : System RAM
a960b018-a961b457 : System RAM
a961b458-a961c017 : System RAM
a961c018-a962c057 : System RAM
a962c058-a962d017 : System RAM
a962d018-a963c457 : System RAM
a963c458-a99f7fff : System RAM
a99f8000-a99fefff : ACPI Non-volatile Storage
a99ff000-aa258fff : System RAM
aa259000-aa4cefff : reserved
aa4cf000-ba5bffff : System RAM
ba5c0000-ba7d3fff : reserved
ba7d4000-ba7e7fff : ACPI Tables
ba7e8000-ba8bbfff : ACPI Non-volatile Storage
ba8bc000-baffefff : reserved
bafff000-baffffff : System RAM
bb000000-bb7fffff : RAM buffer
bb800000-bf9fffff : reserved
c0000000-cfffffff : 0000:00:02.0
d0000000-db0fffff : PCI Bus 0000:01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-d9ffffff : 0000:01:00.0
    d9000000-d92fffff : efifb
  da000000-daffffff : 0000:01:00.0
    da000000-daffffff : nvidia
  db000000-db07ffff : 0000:01:00.0
  db080000-db083fff : 0000:01:00.1
    db080000-db083fff : ICH HD audio
db400000-db7fffff : 0000:00:02.0
db800000-db8fffff : PCI Bus 0000:04
  db800000-db801fff : 0000:04:00.0
    db800000-db801fff : iwlwifi
db900000-db9fffff : PCI Bus 0000:03
  db900000-db93ffff : 0000:03:00.0
    db900000-db93ffff : alx
dba00000-dba1ffff : 0000:00:19.0
  dba00000-dba1ffff : e1000e
dba20000-dba2ffff : 0000:00:14.0
  dba20000-dba2ffff : xhci_hcd
dba30000-dba33fff : 0000:00:1b.0
  dba30000-dba33fff : ICH HD audio
dba34000-dba37fff : 0000:00:03.0
dba39000-dba390ff : 0000:00:1f.3
dba3a000-dba3a7ff : 0000:00:1f.2
  dba3a000-dba3a7ff : ahci
dba3b000-dba3b3ff : 0000:00:1d.0
  dba3b000-dba3b3ff : ehci_hcd
dba3c000-dba3c3ff : 0000:00:1a.0
  dba3c000-dba3c3ff : ehci_hcd
dba3d000-dba3dfff : 0000:00:19.0
  dba3d000-dba3dfff : e1000e
dba3e000-dba3efff : 0000:00:16.3
dba40000-dba4000f : 0000:00:16.0
  dba40000-dba4000f : mei_me
f8000000-fbffffff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
fed1c000-fed1ffff : reserved
  fed1f410-fed1f414 : iTCO_wdt
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
100000000-23e5fffff : System RAM
23e600000-23fffffff : RAM buffer

[8.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 4th Gen Core Processor DRAM 
Controller (rev 06)
	Subsystem: Gigabyte Technology Co., Ltd Device 5000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal 
decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d0000000-db0fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Gigabyte Technology Co., Ltd Device 5000
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41c1
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- 
BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF 
Via WAKE# ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Via WAKE# ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, 
EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 
v3/4th Gen Core Processor Integrated Graphics Controller (rev 06) 
(prog-if 00 [VGA controller])
	Subsystem: Gigabyte Technology Co., Ltd Device d000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at db400000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [disabled] [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel modules: i915

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor HD Audio Controller (rev 06)
	Subsystem: Intel Corporation Device 2010
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dba34000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB xHCI (rev 04) (prog-if 30 [XHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5007
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at dba20000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4142
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_hcd

00:16.0 Communication controller: Intel Corporation 8 Series/C220 
Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Gigabyte Technology Co., Ltd Device 1c3a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at dba40000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4162
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:16.3 Serial controller: Intel Corporation 8 Series/C220 Series 
Chipset Family KT Controller (rev 04) (prog-if 02 [16550])
	Subsystem: Gigabyte Technology Co., Ltd Device 1c3a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at f0e0 [size=8]
	Region 1: Memory at dba3e000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection 
I217-V (rev 04)
	Subsystem: Gigabyte Technology Co., Ltd Device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at dba00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at dba3d000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at f080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41c2
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dba3c000 (32-bit, non-prefetchable) [size=1K]
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
	Kernel modules: ehci_pci

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset 
High Definition Audio Controller (rev 04)
	Subsystem: Gigabyte Technology Co., Ltd Device a002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at dba30000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4192
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #1 (rev d4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM not supported, Exit 
Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via 
WAKE# ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41d1
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #4 (rev d4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: db900000-db9fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not 
Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41e1
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #5 (rev d4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: db800000-db8fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not 
Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4122
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at dba3b000 (32-bit, non-prefetchable) [size=1K]
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
	Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation H87 Express LPC Controller (rev 
04)
	Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset 
Family 6-port SATA Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 
1.0])
	Subsystem: Gigabyte Technology Co., Ltd Device b005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 45
	Region 0: I/O ports at f0d0 [size=8]
	Region 1: I/O ports at f0c0 [size=4]
	Region 2: I/O ports at f0b0 [size=8]
	Region 3: I/O ports at f0a0 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at dba3a000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4152
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family 
SMBus Controller (rev 04)
	Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at dba39000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

01:00.0 VGA compatible controller: NVIDIA Corporation GK106 [GeForce 
GTX 660] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 843b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 50
	Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at d8000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at e000 [size=128]
	[virtual] Expansion ROM at db000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41b2
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 
<64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not 
Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, 
EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest+
	Capabilities: [b4] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: nvidia
	Kernel modules: nouveau, nvidia

01:00.1 Audio device: NVIDIA Corporation GK106 HDMI Audio Controller 
(rev a1)
	Subsystem: ASUSTeK Computer Inc. Device 843b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at db080000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 
<64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not 
Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

03:00.0 Ethernet controller: Qualcomm Atheros AR8161 Gigabit Ethernet 
(rev 10)
	Subsystem: Gigabyte Technology Co., Ltd Device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 51
	Region 0: Memory at db900000 (64-bit, non-prefetchable) [size=256K]
	Region 2: I/O ports at d000 [size=128]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 4096 bytes, PhantFunc 0, Latency L0s unlimited, L1 
unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s unlimited, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [c0] MSI: Enable+ Count=1/16 Maskable+ 64bit+
		Address: 00000000fee0f00c  Data: 41d2
		Masking: 0000fffe  Pending: 00000000
	Capabilities: [d8] MSI-X: Enable- Count=16 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Kernel driver in use: alx
	Kernel modules: alx

04:00.0 Network controller: Intel Corporation Centrino Wireless-N 2230 
(rev c4)
	Subsystem: Intel Corporation Centrino Wireless-N 2230 BGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at db800000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4182
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

[8.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: KINGSTON SV300S3 Rev: 506A
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST1000DM003-9YN1 Rev: CC4B
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
The kernel oops message was transcribed by hand from a photograph, and 
might not be perfect.




