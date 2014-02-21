From: Jorren Schauwaert <jorren.schauwaert@gmail.com>
Subject: PROBLEM: ACPI Warning: 0x0000000000001828-0x000000000000182f SystemIO
 conflicts with Region ...
Date: Fri, 21 Feb 2014 18:24:58 +0100
Message-ID: <CAAcA6qpQgJhger8CmdWy=uDm-YssxobWT8jC5XvBcKfDi_exjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:42923 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbaBURY7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2014 12:24:59 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so6447270qcx.37
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2014 09:24:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:

When booting the system reports:

ACPI Warning: 0x0000000000001828-0x000000000000182f SystemIO conflicts
with Region ..... (20131115/utaddress-251)


[2.] Full description of the problem/report:

The full report is:

[ 16.181980] ACPI Warning: SystemIO range
0x0000000000001828-0x000000000000182f conflicts with OpRegion
0x0000000000001800-0x000000000000187f (\PMIO) (20131218/utaddress-258)
[ 16.181986] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver
[ 16.182001] ACPI Warning: SystemIO range
0x0000000000001c30-0x0000000000001c3f conflicts with OpRegion
0x0000000000001c00-0x0000000000001c3f (\GPRL) (20131218/utaddress-258)
[ 16.182004] ACPI Warning: SystemIO range
0x0000000000001c30-0x0000000000001c3f conflicts with OpRegion
0x0000000000001c00-0x0000000000001fff (\GPR_) (20131218/utaddress-258)
[ 16.182007] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver
[ 16.182008] ACPI Warning: SystemIO range
0x0000000000001c00-0x0000000000001c2f conflicts with OpRegion
0x0000000000001c00-0x0000000000001c3f (\GPRL) (20131218/utaddress-258)
[ 16.182010] ACPI Warning: SystemIO range
0x0000000000001c00-0x0000000000001c2f conflicts with OpRegion
0x0000000000001c00-0x0000000000001fff (\GPR_) (20131218/utaddress-258)
[ 16.182029] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver


[3.] Keywords (i.e., modules, networking, kernel):


[4.] Kernel version (from /proc/version):

Linux version 3.14.0-031400rc3-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201402201029 SMP Thu Feb 20
15:31:09 UTC 2014


[5.] Output of Oops.. message (if applicable)


[6.] A small shell script or example program which triggers the
problem (if possible)


[7.] Environment

Description: Ubuntu Trusty Tahr (development branch)
Release: 14.04


[7.1.] Software (add the output of the ver_linux script here)

Linux culemborg 3.14.0-031400rc3-generic #201402201029 SMP Thu Feb 20
15:31:09 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  ./ver_linux:
./ver_linux: 20: ./ver_linux: ld: not found
binutils
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
PPP                    2.4.5
Linux C Library        2.18
Dynamic linker (ldd)   2.18
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30

Modules Loaded         btrfs raid6_pq xor ufs qnx4 hfsplus hfs minix
ntfs msdos jfs xfs libcrc32c bonding x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper
ablk_helper cryptd ast ttm microcode drm_kms_helper joydev drm
syscopyarea sysfillrect sysimgblt lpc_ich ipmi_si shpchp
ipmi_msghandler video mac_hid lp parport hid_generic usbhid hid igb
ahci i2c_algo_bit mpt2sas libahci dca netxen_nic ptp raid_class
pps_core scsi_transport_sas


[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 4
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 5
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 6
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 7
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Xeon(R) CPU E3-1230 v3 @ 3.30GHz
stepping : 3
microcode : 0x10
cpu MHz : 3498.000
cache size : 8192 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 7
initial apicid : 7
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 6585.44
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

btrfs 908212 0 - Live 0xffffffffa04cd000
raid6_pq 97812 1 btrfs, Live 0xffffffffa04b4000
xor 21411 1 btrfs, Live 0xffffffffa0256000
ufs 75385 0 - Live 0xffffffffa04a0000
qnx4 13394 0 - Live 0xffffffffa0219000
hfsplus 103791 0 - Live 0xffffffffa0338000
hfs 54819 0 - Live 0xffffffffa0329000
minix 36454 0 - Live 0xffffffffa031f000
ntfs 97805 0 - Live 0xffffffffa0234000
msdos 17332 0 - Live 0xffffffffa01fe000
jfs 186915 0 - Live 0xffffffffa0359000
xfs 942166 0 - Live 0xffffffffa03b8000
libcrc32c 12644 1 xfs, Live 0xffffffffa0066000
bonding 147364 0 - Live 0xffffffffa02fa000
x86_pkg_temp_thermal 14269 0 - Live 0xffffffffa01ef000
intel_powerclamp 19077 0 - Live 0xffffffffa0250000
coretemp 17768 0 - Live 0xffffffffa018d000
kvm_intel 148674 0 - Live 0xffffffffa0392000
kvm 471679 1 kvm_intel, Live 0xffffffffa0285000
crct10dif_pclmul 14250 0 - Live 0xffffffffa01f9000
crc32_pclmul 13160 0 - Live 0xffffffffa0204000
ghash_clmulni_intel 13259 0 - Live 0xffffffffa0183000
aesni_intel 152634 0 - Live 0xffffffffa025e000
aes_x86_64 17131 1 aesni_intel, Live 0xffffffffa022e000
lrw 13323 1 aesni_intel, Live 0xffffffffa01f4000
gf128mul 14951 1 lrw, Live 0xffffffffa0188000
glue_helper 14095 1 aesni_intel, Live 0xffffffffa0132000
ablk_helper 13597 1 aesni_intel, Live 0xffffffffa0224000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0xffffffffa0146000
ast 60432 1 - Live 0xffffffffa0209000
ttm 90127 1 ast, Live 0xffffffffa016b000
microcode 24391 0 - Live 0xffffffffa0138000
drm_kms_helper 53224 1 ast, Live 0xffffffffa0124000
joydev 17575 0 - Live 0xffffffffa0140000
drm 308197 3 ast,ttm,drm_kms_helper, Live 0xffffffffa01a2000
syscopyarea 12633 1 ast, Live 0xffffffffa00ac000
sysfillrect 12901 1 ast, Live 0xffffffffa011f000
sysimgblt 12806 1 ast, Live 0xffffffffa00b1000
lpc_ich 21163 0 - Live 0xffffffffa006b000
ipmi_si 53966 0 - Live 0xffffffffa00dc000
shpchp 37201 0 - Live 0xffffffffa00d1000
ipmi_msghandler 46058 1 ipmi_si, Live 0xffffffffa00c4000
video 19859 0 - Live 0xffffffffa0060000
mac_hid 13253 0 - Live 0xffffffffa0054000
lp 17799 0 - Live 0xffffffffa005a000
parport 42481 1 lp, Live 0xffffffffa0048000
hid_generic 12548 0 - Live 0xffffffffa007d000
usbhid 53067 0 - Live 0xffffffffa0194000
hid 106254 2 hid_generic,usbhid, Live 0xffffffffa0150000
igb 190391 0 - Live 0xffffffffa00ef000
ahci 30066 2 - Live 0xffffffffa00bb000
i2c_algo_bit 13564 2 ast,igb, Live 0xffffffffa00b6000
mpt2sas 166916 0 - Live 0xffffffffa0082000
libahci 32191 1 ahci, Live 0xffffffffa0074000
dca 15232 1 igb, Live 0xffffffffa0019000
netxen_nic 115074 0 - Live 0xffffffffa002a000
ptp 18980 1 igb, Live 0xffffffffa0020000
raid_class 13554 1 mpt2sas, Live 0xffffffffa000c000
pps_core 19381 1 ptp, Live 0xffffffffa0013000
scsi_transport_sas 41028 1 mpt2sas, Live 0xffffffffa0000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
  00b2-00b2 : APEI ERST
  00c0-00df : dma2
  00f0-00ff : fpu
  02f8-02ff : serial
  03c0-03df : vesafb
  03e8-03ef : serial
  03f8-03ff : serial
  04d0-04d1 : pnp 00:0c
  0580-059f : 0000:00:1f.3
  0680-069f : pnp 00:05
  0a00-0a1f : pnp 00:08
    0a00-0a1f : pnp 00:0b
  0a30-0a3f : pnp 00:08
  0ca2-0ca2 : ipmi_si
  0ca3-0ca3 : ipmi_si
  0ca4-0ca7 : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:05
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1820-182f : ACPI GPE0_BLK
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:07
  1860-187f : iTCO_wdt
  1c00-1cfe : pnp 00:05
  1d00-1dfe : pnp 00:05
  1e00-1efe : pnp 00:05
  1f00-1ffe : pnp 00:05
  b000-bfff : PCI Bus 0000:06
    b000-b01f : 0000:06:00.0
  c000-cfff : PCI Bus 0000:05
    c000-c01f : 0000:05:00.0
  d000-dfff : PCI Bus 0000:03
    d000-dfff : PCI Bus 0000:04
      d000-d07f : 0000:04:00.0
  e000-efff : PCI Bus 0000:02
    e000-e0ff : 0000:02:00.0
  f000-f01f : 0000:00:1f.2
    f000-f01f : ahci
  f020-f023 : 0000:00:1f.2
    f020-f023 : ahci
  f030-f037 : 0000:00:1f.2
    f030-f037 : ahci
  f040-f043 : 0000:00:1f.2
    f040-f043 : ahci
  f050-f057 : 0000:00:1f.2
    f050-f057 : ahci
  ffff-ffff : pnp 00:05
    ffff-ffff : pnp 00:05
      ffff-ffff : pnp 00:05

00000000-00000fff : reserved
00001000-00099bff : System RAM
00099c00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Adapter ROM
000c8800-000c97ff : Adapter ROM
000c9800-000c9fff : Adapter ROM
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-ccd7ffff : System RAM
  01000000-01774145 : Kernel code
  01774146-01d157ff : Kernel data
  01e73000-01fd8fff : Kernel bss
ccd80000-ccd86fff : ACPI Non-volatile Storage
ccd87000-dd620fff : System RAM
dd621000-dd837fff : reserved
  dd7c0018-dd7c003e : APEI ERST
  dd7c003f-dd7c203e : APEI ERST
dd838000-dd892fff : System RAM
dd893000-dd9c4fff : ACPI Non-volatile Storage
dd9c5000-df7fefff : reserved
df7ff000-df7fffff : System RAM
df800000-dfffffff : RAM buffer
e0000000-feafffff : PCI Bus 0000:00
  f5000000-f60fffff : PCI Bus 0000:03
    f5000000-f60fffff : PCI Bus 0000:04
      f5000000-f5ffffff : 0000:04:00.0
      f6000000-f601ffff : 0000:04:00.0
  f6100000-f610ffff : 0000:00:14.0
    f6100000-f610ffff : xhci_hcd
  f6110000-f6110fff : 0000:00:1f.6
  f6111000-f61110ff : 0000:00:1f.3
  f6112000-f61127ff : 0000:00:1f.2
    f6112000-f61127ff : ahci
  f6113000-f61133ff : 0000:00:1d.0
    f6113000-f61133ff : ehci_hcd
  f6114000-f61143ff : 0000:00:1a.0
    f6114000-f61143ff : ehci_hcd
  f6200000-f6afffff : PCI Bus 0000:07
    f6200000-f63fffff : 0000:07:00.3
      f6200000-f63fffff : netxen_nic
    f6400000-f65fffff : 0000:07:00.2
      f6400000-f65fffff : netxen_nic
    f6600000-f67fffff : 0000:07:00.1
      f6600000-f67fffff : netxen_nic
    f6800000-f69fffff : 0000:07:00.0
      f6800000-f69fffff : netxen_nic
    f6a00000-f6a0ffff : 0000:07:00.0
  f6c00000-f6dfffff : PCI Bus 0000:02
    f6c00000-f6cfffff : 0000:02:00.0
    f6d00000-f6d3ffff : 0000:02:00.0
      f6d00000-f6d3ffff : mpt2sas
    f6d40000-f6d4ffff : 0000:02:00.0
      f6d40000-f6d4ffff : mpt2sas
  f6e00000-f6efffff : PCI Bus 0000:06
    f6e00000-f6e7ffff : 0000:06:00.0
      f6e00000-f6e7ffff : igb
    f6e80000-f6e83fff : 0000:06:00.0
      f6e80000-f6e83fff : igb
  f6f00000-f6ffffff : PCI Bus 0000:05
    f6f00000-f6f7ffff : 0000:05:00.0
      f6f00000-f6f7ffff : igb
    f6f80000-f6f83fff : 0000:05:00.0
      f6f80000-f6f83fff : igb
  f7fef000-f7feffff : pnp 00:0f
  f7ff0000-f7ff0fff : pnp 00:0f
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:0f
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
fed10000-fed17fff : pnp 00:0f
fed18000-fed18fff : pnp 00:0f
fed19000-fed19fff : pnp 00:0f
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:0f
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0f
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:0f
fed90000-fed90fff : dmar0
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:0f
100000000-41fffffff : System RAM


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3 Processor DRAM
Controller (rev 06)

Subsystem: Super Micro Computer Inc Device 0804

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

I/O behind bridge: 0000f000-00000fff

Memory behind bridge: fff00000-000fffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [88] Subsystem: Intel Corporation Device 2010

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee002d8  Data: 0000

Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 256 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 256 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-

LnkCap: Port #2, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s
<1us, L1 <8us

ClockPM- Surprise- LLActRep- BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #1, PowerLimit 75.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Via WAKE# ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Via
WAKE# ARIFwd-

LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [100 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff

Status: NegoPending+ InProgress-

Capabilities: [140 v1] Root Complex Link

Desc: PortNumber=02 ComponentID=01 EltType=Config

Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+

Addr: 00000000fed19000

Capabilities: [d94 v1] #19

Kernel driver in use: pcieport


00:01.1 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor PCI Express x8 Controller (rev 06) (prog-if 00 [Normal
decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=02, subordinate=02, sec-latency=0

I/O behind bridge: 0000e000-0000efff

Memory behind bridge: f6c00000-f6dfffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [88] Subsystem: Intel Corporation Device 2010

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee002f8  Data: 0000

Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-

LnkCap: Port #3, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <8us

ClockPM- Surprise- LLActRep- BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #0, PowerLimit 0.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Not Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+

EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest+

Capabilities: [100 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff

Status: NegoPending- InProgress-

Capabilities: [140 v1] Root Complex Link

Desc: PortNumber=03 ComponentID=01 EltType=Config

Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+

Addr: 00000000fed19000

Capabilities: [d94 v1] #19

Kernel driver in use: pcieport


00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB xHCI (rev 05) (prog-if 30 [XHCI])

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin A routed to IRQ 47

Region 0: Memory at f6100000 (64-bit, non-prefetchable) [size=64K]

Capabilities: [70] Power Management version 2

Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+

Address: 00000000fee003d8  Data: 0000

Kernel driver in use: xhci_hcd


00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f6114000 (32-bit, non-prefetchable) [size=1K]

Capabilities: [50] Power Management version 2

Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [58] Debug port: BAR=1 offset=00a0

Capabilities: [98] PCI Advanced Features

AFCap: TP+ FLR+

AFCtrl: FLR-

AFStatus: TP-

Kernel driver in use: ehci-pci


00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=03, subordinate=04, sec-latency=0

I/O behind bridge: 0000d000-0000dfff

Memory behind bridge: f5000000-f60fffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #0, PowerLimit 10.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00318  Data: 0000

Capabilities: [90] Subsystem: Super Micro Computer Inc Device 0804

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v1] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Kernel driver in use: pcieport


00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=05, subordinate=05, sec-latency=0

I/O behind bridge: 0000c000-0000cfff

Memory behind bridge: f6f00000-f6ffffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #2, PowerLimit 10.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00358  Data: 0000

Capabilities: [90] Subsystem: Super Micro Computer Inc Device 0804

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v1] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Kernel driver in use: pcieport


00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=06, subordinate=06, sec-latency=0

I/O behind bridge: 0000b000-0000bfff

Memory behind bridge: f6e00000-f6efffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train+ SlotClk+ DLActive+
BWMgmt+ ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #3, PowerLimit 10.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00398  Data: 0000

Capabilities: [90] Subsystem: Super Micro Computer Inc Device 0804

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v1] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Kernel driver in use: pcieport


00:1c.4 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #5 (rev d5) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=07, subordinate=07, sec-latency=0

I/O behind bridge: 0000f000-00000fff

Memory behind bridge: f6200000-f6afffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag- RBE+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 128 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

LnkCap: Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<1us, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #4, PowerLimit 25.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee003b8  Data: 0000

Capabilities: [90] Subsystem: Super Micro Computer Inc Device 0804

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v1] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Kernel driver in use: pcieport


00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin A routed to IRQ 23

Region 0: Memory at f6113000 (32-bit, non-prefetchable) [size=1K]

Capabilities: [50] Power Management version 2

Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [58] Debug port: BAR=1 offset=00a0

Capabilities: [98] PCI Advanced Features

AFCap: TP+ FLR+

AFCtrl: FLR-

AFStatus: TP-

Kernel driver in use: ehci-pci


00:1f.0 ISA bridge: Intel Corporation C222 Series Chipset Family
Server Essential SKU LPC Controller (rev 05)

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Capabilities: [e0] Vendor Specific Information: Len=0c <?>

Kernel driver in use: lpc_ich


00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if
01 [AHCI 1.0])

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin B routed to IRQ 48

Region 0: I/O ports at f050 [size=8]

Region 1: I/O ports at f040 [size=4]

Region 2: I/O ports at f030 [size=8]

Region 3: I/O ports at f020 [size=4]

Region 4: I/O ports at f000 [size=32]

Region 5: Memory at f6112000 (32-bit, non-prefetchable) [size=2K]

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee003f8  Data: 0000

Capabilities: [70] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004

Kernel driver in use: ahci


00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller (rev 05)

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Interrupt: pin C routed to IRQ 5

Region 0: Memory at f6111000 (64-bit, non-prefetchable) [size=256]

Region 4: I/O ports at 0580 [size=32]


00:1f.6 Signal processing controller: Intel Corporation 8 Series
Chipset Family Thermal Management Controller (rev 05)

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin C routed to IRQ 5

Region 0: Memory at f6110000 (64-bit, non-prefetchable) [size=4K]

Capabilities: [50] Power Management version 3

Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-

Address: 00000000  Data: 0000


02:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic
SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)

Subsystem: Super Micro Computer Inc Device 0691

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 16

Region 0: I/O ports at e000 [size=256]

Region 1: Memory at f6d40000 (64-bit, non-prefetchable) [size=64K]

Region 3: Memory at f6d00000 (64-bit, non-prefetchable) [size=256K]

Expansion ROM at f6c00000 [disabled] [size=1M]

Capabilities: [50] Power Management version 3

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [68] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us

ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-

LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L0s, Exit Latency L0s
<64ns, L1 <1us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest+

Capabilities: [d0] Vital Product Data

Unknown small resource type 00, will not decode more.

Capabilities: [a8] MSI: Enable- Count=1/1 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [c0] MSI-X: Enable+ Count=16 Masked-

Vector table: BAR=1 offset=0000e000

PBA: BAR=1 offset=0000f000

Capabilities: [100 v2] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Capabilities: [1e0 v1] #19

Capabilities: [1c0 v1] Power Budgeting <?>

Capabilities: [190 v1] #16

Capabilities: [148 v1] Alternative Routing-ID Interpretation (ARI)

ARICap: MFVC- ACS-, Next Function: 0

ARICtl: MFVC- ACS-, Function Group: 0

Kernel driver in use: mpt2sas


03:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
(rev 03) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=03, secondary=04, subordinate=04, sec-latency=0

I/O behind bridge: 0000d000-0000dfff

Memory behind bridge: f5000000-f60fffff

Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-

BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [78] Power Management version 3

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [80] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0

ExtTag+ AttnBtn- AttnInd- PwrInd- RBE-

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <16us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

Capabilities: [a4] Subsystem: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge

Capabilities: [100 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01

Status: NegoPending- InProgress-


04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
Graphics Family (rev 30) (prog-if 00 [VGA controller])

Subsystem: Super Micro Computer Inc Device 0804

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]

Region 1: Memory at f6000000 (32-bit, non-prefetchable) [size=128K]

Region 2: I/O ports at d000 [size=128]

Expansion ROM at <unassigned> [disabled]

Capabilities: [40] Power Management version 3

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Kernel driver in use: ast


05:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)

Subsystem: Super Micro Computer Inc Device 1533

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 18

Region 0: Memory at f6f00000 (32-bit, non-prefetchable) [size=512K]

Region 2: I/O ports at c000 [size=32]

Region 3: Memory at f6f80000 (32-bit, non-prefetchable) [size=16K]

Capabilities: [40] Power Management version 3

Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-

Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+

Address: 0000000000000000  Data: 0000

Masking: 00000000  Pending: 00000000

Capabilities: [70] MSI-X: Enable+ Count=5 Masked-

Vector table: BAR=3 offset=00000000

PBA: BAR=3 offset=00002000

Capabilities: [a0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <16us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [100 v2] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 00-25-90-ff-ff-86-ce-0c

Capabilities: [1a0 v1] Transaction Processing Hints

Device specific mode supported

Steering table in TPH capability structure

Kernel driver in use: igb


06:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)

Subsystem: Super Micro Computer Inc Device 1533

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 19

Region 0: Memory at f6e00000 (32-bit, non-prefetchable) [size=512K]

Region 2: I/O ports at b000 [size=32]

Region 3: Memory at f6e80000 (32-bit, non-prefetchable) [size=16K]

Capabilities: [40] Power Management version 3

Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-

Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+

Address: 0000000000000000  Data: 0000

Masking: 00000000  Pending: 00000000

Capabilities: [70] MSI-X: Enable+ Count=5 Masked-

Vector table: BAR=3 offset=00000000

PBA: BAR=3 offset=00002000

Capabilities: [a0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <16us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [100 v2] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 00-25-90-ff-ff-86-ce-0d

Capabilities: [1a0 v1] Transaction Processing Hints

Device specific mode supported

Steering table in TPH capability structure

Kernel driver in use: igb


07:00.0 Ethernet controller: NetXen Incorporated NX3031 Multifunction
1/10-Gigabit Server Adapter (rev 42)

Subsystem: Hewlett-Packard Company NC375T PCI Express Quad Port
Gigabit Server Adapter

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f6800000 (64-bit, non-prefetchable) [size=2M]

Expansion ROM at f6a00000 [disabled] [size=64K]

Capabilities: [40] MSI-X: Enable+ Count=64 Masked-

Vector table: BAR=0 offset=00090000

PBA: BAR=0 offset=00090800

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [c0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 256 bytes

DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-

LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM not supported, Exit
Latency L0s <64ns, L1 <1us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

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

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 59-69-46-61-6e-48-73-75

Kernel driver in use: netxen_nic


07:00.1 Ethernet controller: NetXen Incorporated NX3031 Multifunction
1/10-Gigabit Server Adapter (rev 42)

Subsystem: Hewlett-Packard Company NC375T PCI Express Quad Port
Gigabit Server Adapter

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f6600000 (64-bit, non-prefetchable) [size=2M]

Capabilities: [40] MSI-X: Enable+ Count=64 Masked-

Vector table: BAR=0 offset=00091000

PBA: BAR=0 offset=00091800

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [c0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 256 bytes

DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-

LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM not supported, Exit
Latency L0s <64ns, L1 <1us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

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

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 59-69-46-61-6e-48-73-75

Kernel driver in use: netxen_nic


07:00.2 Ethernet controller: NetXen Incorporated NX3031 Multifunction
1/10-Gigabit Server Adapter (rev 42)

Subsystem: Hewlett-Packard Company NC375T PCI Express Quad Port
Gigabit Server Adapter

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f6400000 (64-bit, non-prefetchable) [size=2M]

Capabilities: [40] MSI-X: Enable+ Count=64 Masked-

Vector table: BAR=0 offset=00092000

PBA: BAR=0 offset=00092800

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [c0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 256 bytes

DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-

LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM not supported, Exit
Latency L0s <64ns, L1 <1us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

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

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 59-69-46-61-6e-48-73-75

Kernel driver in use: netxen_nic


07:00.3 Ethernet controller: NetXen Incorporated NX3031 Multifunction
1/10-Gigabit Server Adapter (rev 42)

Subsystem: Hewlett-Packard Company NC375T PCI Express Quad Port
Gigabit Server Adapter

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 16

Region 0: Memory at f6200000 (64-bit, non-prefetchable) [size=2M]

Capabilities: [40] MSI-X: Enable+ Count=64 Masked-

Vector table: BAR=0 offset=00093000

PBA: BAR=0 offset=00093800

Capabilities: [80] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+

Address: 0000000000000000  Data: 0000

Capabilities: [c0] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 256 bytes

DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-

LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM not supported, Exit
Latency L0s <64ns, L1 <1us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

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

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Device Serial Number 59-69-46-61-6e-48-73-75

Kernel driver in use: netxen_nic


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Samsung SSD 840  Rev: EXT0
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):

1     1554  19   32    3965  4240  54   710  acpi         irq
  schedstat

10    1558  190  3251  3966  426   55   72   buddyinfo    kallsyms       scsi

101   1573  191  3272  3967  43    56   73   bus          kcore          self

102   1580  2    3289  3968  4301  57   74   cgroups      key-users
  slabinfo

103   16    20   33    3969  4302  58   75   cmdline      kmsg
  softirqs

104   17    202  331   3970  4307  581  774  consoles     kpagecount     stat

11    177   21   34    3971  4308  59   79   cpuinfo      kpageflags     swaps

12    178   217  348   3990  4309  60   8    crypto       latency_stats  sys

123   179   218  35    4     44    601  80   devices      loadavg
  sysrq-trigger

125   18    22   354   40    4419  61   81   diskstats    locks          sysvipc

13    180   224  36    41    45    62   82   dma          mdstat
  timer_list

14    181   23   37    4134  453   63   83   driver       meminfo
  timer_stats

1495  182   24   38    4141  46    64   9    execdomains  misc           tty

1498  183   25   39    418   47    65   95   fb           modules        uptime

15    184   26   3954  42    48    66   96   filesystems  mounts         version

1503  185   27   3956  4206  49    67   962  fs           mtrr
  vmallocinfo

1504  186   28   3957  4216  5     68   97   interrupts   net            vmstat

1506  187   29   3962  4217  51    69   976  iomem        pagetypeinfo
  zoneinfo

1530  188   3    3963  4221  52    7    98   ioports      partitions

1531  189   31   3964  4239  53    71   99   ipmi         sched_debug


[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/bugs/1280467
