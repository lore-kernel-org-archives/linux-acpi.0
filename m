From: stl <stl555@gmx.com>
Subject: suspend/resume fails bug
Date: Wed, 10 Dec 2014 00:03:02 +0000
Message-ID: <54878DB6.2080008@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:52287 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbaLJADg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Dec 2014 19:03:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

[1.] Resuming from suspend fails(passphrase input screen appears insted
of resuming).

[2.]
Resuming from suspend fails (passphrase input screen appears insted of
resuming).this bug has existed since at least 3.13.11 possibly longer it
can be triggered by suspending the computer and then bringing it out of
suspend

[4.]
Linux version 3.18.0-031800-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201412071935 SMP Mon Dec 8 00:36:34
UTC 2014

[5.]
[6.]
[7.]
Description:	Ubuntu 14.10
Release:	14.10

[7.1.]
Linux dhcppc2 3.18.0-031800-generic #201412071935 SMP Mon Dec 8 00:36:34
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.9.1
Gnu make               4.0
binutils               2.24.90.20141014
util-linux             2.25.1
mount                  debug
module-init-tools      18
e2fsprogs              1.42.10
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.23
wireless-tools         30
Modules Loaded         ppp_deflate bsd_comp ppp_async crc_ccitt cdc_acm
xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4
nf_log_ipv4 nf_log_common xt_LOG xt_limit binfmt_misc xt_tcpudp
xt_addrtype eeepc_wmi asus_wmi nf_conntrack_ipv4 mxm_wmi nf_defrag_ipv4
sparse_keymap xt_conntrack snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic ip6table_filter ip6_tables snd_hda_intel
nf_conntrack_netbios_ns snd_hda_controller nf_conntrack_broadcast
nf_nat_ftp snd_hda_codec nf_nat intel_rapl nf_conntrack_ftp snd_hwdep
nf_conntrack snd_pcm x86_pkg_temp_thermal intel_powerclamp
iptable_filter coretemp snd_seq_midi snd_seq_midi_event ip_tables
kvm_intel snd_rawmidi kvm x_tables snd_seq snd_seq_device snd_timer snd
serio_raw lpc_ich soundcore 8250_fintek mei_me wmi mei tpm_infineon
mac_hid shpchp parport_pc ppdev lp parport dm_crypt hid_generic usbhid
uas hid usb_storage crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
i915 aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper
i2c_algo_bit cryptd ahci drm_kms_helper libahci drm psmouse r8169 mii video

[7.2.]

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4670K CPU @ 3.40GHz
stepping	: 3
microcode	: 0x1a
cpu MHz		: 799.929
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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat
epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 6812.04
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4670K CPU @ 3.40GHz
stepping	: 3
microcode	: 0x1a
cpu MHz		: 799.929
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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat
epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 6812.04
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4670K CPU @ 3.40GHz
stepping	: 3
microcode	: 0x1a
cpu MHz		: 800.062
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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat
epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 6812.04
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i5-4670K CPU @ 3.40GHz
stepping	: 3
microcode	: 0x1a
cpu MHz		: 799.929
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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat
epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 6812.04
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[7.3.]

ppp_deflate 13038 0 - Live 0x0000000000000000
bsd_comp 12994 0 - Live 0x0000000000000000
ppp_async 17539 1 - Live 0x0000000000000000
crc_ccitt 12707 1 ppp_async, Live 0x0000000000000000
cdc_acm 33090 3 - Live 0x0000000000000000
xt_hl 12521 6 - Live 0x0000000000000000
ip6t_rt 13537 3 - Live 0x0000000000000000
nf_conntrack_ipv6 18946 7 - Live 0x0000000000000000
nf_defrag_ipv6 35007 1 nf_conntrack_ipv6, Live 0x0000000000000000
ipt_REJECT 12541 1 - Live 0x0000000000000000
nf_reject_ipv4 13183 1 ipt_REJECT, Live 0x0000000000000000
nf_log_ipv4 12819 1 - Live 0x0000000000000000
nf_log_common 13425 1 nf_log_ipv4, Live 0x0000000000000000
xt_LOG 12690 1 - Live 0x0000000000000000
xt_limit 12711 2 - Live 0x0000000000000000
binfmt_misc 17501 1 - Live 0x0000000000000000
xt_tcpudp 12924 18 - Live 0x0000000000000000
xt_addrtype 12713 4 - Live 0x0000000000000000
eeepc_wmi 13151 0 - Live 0x0000000000000000
asus_wmi 24697 1 eeepc_wmi, Live 0x0000000000000000
nf_conntrack_ipv4 18953 7 - Live 0x0000000000000000
mxm_wmi 13021 0 - Live 0x0000000000000000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
xt_conntrack 12760 14 - Live 0x0000000000000000
snd_hda_codec_realtek 80420 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 52670 2 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
ip6table_filter 12815 1 - Live 0x0000000000000000
ip6_tables 27504 1 ip6table_filter, Live 0x0000000000000000
snd_hda_intel 30824 7 - Live 0x0000000000000000
nf_conntrack_netbios_ns 12665 0 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
nf_conntrack_broadcast 12589 1 nf_conntrack_netbios_ns, Live
0x0000000000000000
nf_nat_ftp 12825 0 - Live 0x0000000000000000
snd_hda_codec 144641 5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
nf_nat 26308 1 nf_nat_ftp, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
nf_conntrack_ftp 18715 1 nf_nat_ftp, Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
nf_conntrack 105636 8
nf_conntrack_ipv6,nf_conntrack_ipv4,xt_conntrack,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ftp,
Live 0x0000000000000000
snd_pcm 106273 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live
0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
iptable_filter 12810 1 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
ip_tables 27718 1 iptable_filter, Live 0x0000000000000000
kvm_intel 149984 0 - Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
kvm 475237 1 kvm_intel, Live 0x0000000000000000
x_tables 34102 12
xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_limit,xt_tcpudp,xt_addrtype,xt_conntrack,ip6table_filter,ip6_tables,iptable_filter,ip_tables,
Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 84025 25
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
8250_fintek 12925 0 - Live 0x0000000000000000
mei_me 19565 0 - Live 0x0000000000000000
wmi 19379 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
mei 88473 1 mei_me, Live 0x0000000000000000
tpm_infineon 17169 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
shpchp 37216 0 - Live 0x0000000000000000
parport_pc 32909 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
dm_crypt 23456 1 - Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53155 0 - Live 0x0000000000000000
uas 22673 0 - Live 0x0000000000000000
hid 110572 2 hid_generic,usbhid, Live 0x0000000000000000
usb_storage 67010 1 uas, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
i915 1031996 6 - Live 0x0000000000000000
aesni_intel 169686 2 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
cryptd 20531 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
ahci 34220 2 - Live 0x0000000000000000
drm_kms_helper 99802 1 i915, Live 0x0000000000000000
libahci 32353 1 ahci, Live 0x0000000000000000
drm 323675 5 i915,drm_kms_helper, Live 0x0000000000000000
psmouse 118332 0 - Live 0x0000000000000000
r8169 86907 0 - Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
video 20649 2 asus_wmi,i915, Live 0x0000000000000000

[7.4.]

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
  0290-029f : pnp 00:04
  03c0-03df : vga+
  03f8-03ff : serial
  04d0-04d1 : pnp 00:05
  0680-069f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:01
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1820-182f : ACPI GPE0_BLK
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:03
  1860-187f : iTCO_wdt
  1c00-1cfe : pnp 00:01
  1d00-1dfe : pnp 00:01
  1e00-1efe : pnp 00:01
  1f00-1ffe : pnp 00:01
  d000-dfff : PCI Bus 0000:03
    d000-d0ff : 0000:03:00.0
      d000-d0ff : r8169
  e000-efff : PCI Bus 0000:01
    e000-e07f : 0000:01:00.0
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
  ffff-ffff : pnp 00:01
    ffff-ffff : pnp 00:01
      ffff-ffff : pnp 00:01

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
  0290-029f : pnp 00:04
  03c0-03df : vga+
  03f8-03ff : serial
  04d0-04d1 : pnp 00:05
  0680-069f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:01
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1820-182f : ACPI GPE0_BLK
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:03
  1860-187f : iTCO_wdt
  1c00-1cfe : pnp 00:01
  1d00-1dfe : pnp 00:01
  1e00-1efe : pnp 00:01
  1f00-1ffe : pnp 00:01
  d000-dfff : PCI Bus 0000:03
    d000-d0ff : 0000:03:00.0
      d000-d0ff : r8169
  e000-efff : PCI Bus 0000:01
    e000-e07f : 0000:01:00.0
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
  ffff-ffff : pnp 00:01
    ffff-ffff : pnp 00:01
      ffff-ffff : pnp 00:01
cat: cat: No such file or directory
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-b6d6bfff : System RAM
  01000000-017b85b7 : Kernel code
  017b85b8-01d2123f : Kernel data
  01e87000-01fcffff : Kernel bss
b6d6c000-b6d72fff : ACPI Non-volatile Storage
b6d73000-b71c6fff : System RAM
b71c7000-b7627fff : reserved
b7628000-c877afff : System RAM
c877b000-c8983fff : reserved
c8984000-c899cfff : ACPI Tables
c899d000-c8ed8fff : ACPI Non-volatile Storage
c8ed9000-c9ffefff : reserved
c9fff000-c9ffffff : System RAM
ca000000-caffffff : RAM buffer
cb000000-cf1fffff : reserved
  cb200000-cf1fffff : Graphics Stolen Memory
cf200000-feafffff : PCI Bus 0000:00
  d0000000-dfffffff : 0000:00:02.0
  e0000000-f1ffffff : PCI Bus 0000:01
    e0000000-efffffff : 0000:01:00.0
    f0000000-f1ffffff : 0000:01:00.0
  f2100000-f21fffff : PCI Bus 0000:03
    f2100000-f2103fff : 0000:03:00.0
      f2100000-f2103fff : r8169
  f6000000-f70fffff : PCI Bus 0000:01
    f6000000-f6ffffff : 0000:01:00.0
    f7000000-f707ffff : 0000:01:00.0
    f7080000-f7083fff : 0000:01:00.1
      f7080000-f7083fff : ICH HD audio
  f7400000-f77fffff : 0000:00:02.0
  f7800000-f78fffff : PCI Bus 0000:03
    f7800000-f7800fff : 0000:03:00.0
      f7800000-f7800fff : r8169
  f7900000-f790ffff : 0000:00:14.0
    f7900000-f790ffff : xhci-hcd
  f7910000-f7913fff : 0000:00:1b.0
    f7910000-f7913fff : ICH HD audio
  f7914000-f7917fff : 0000:00:03.0
    f7914000-f7917fff : ICH HD audio
  f7919000-f79190ff : 0000:00:1f.3
  f791a000-f791a7ff : 0000:00:1f.2
    f791a000-f791a7ff : ahci
  f791b000-f791b3ff : 0000:00:1d.0
    f791b000-f791b3ff : ehci_hcd
  f791c000-f791c3ff : 0000:00:1a.0
    f791c000-f791c3ff : ehci_hcd
  f791e000-f791e00f : 0000:00:16.0
    f791e000-f791e00f : mei_me
  f7fdf000-f7fdffff : pnp 00:08
  f7fe0000-f7feffff : pnp 00:08
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:08
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:08
fed18000-fed18fff : pnp 00:08
fed19000-fed19fff : pnp 00:08
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:08
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:08
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:08
fed90000-fed93fff : pnp 00:08
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:08
100000000-22fdfffff : System RAM
22fe00000-22fffffff : RAM buffer

[7.5.]

00:00.0 Host bridge: Intel Corporation 4th Gen Core Processor DRAM
Controller (rev 06)
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: hsw_uncore

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f6000000-f70fffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 8534
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4181
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Via WAKE# ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Via
WAKE# ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] #19
	Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3/4th
Gen Core Processor Integrated Graphics Controller (rev 06) (prog-if 00
[VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4152
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller (rev 06)
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at f7914000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4172
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB xHCI (rev 05) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 41b1
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 8 Series/C220 Series
Chipset Family MEI Controller #1 (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at f791e000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4162
	Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f791c000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
High Definition Audio Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 85b0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at f7910000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4192
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=2 ArbSelect=Fixed TC/VC=04
			Status:	NegoPending- InProgress-
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
WAKE# ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 8534
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f7800000-f78fffff
	Prefetchable memory behind bridge: 00000000f2100000-00000000f21fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
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
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 8534
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d5) (prog-if
01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
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
<1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
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
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 8534
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f791b000 (32-bit, non-prefetchable) [size=1K]
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

00:1f.0 ISA bridge: Intel Corporation Z87 Express LPC Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset
Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 26
	Region 0: I/O ports at f0b0 [size=8]
	Region 1: I/O ports at f0a0 [size=4]
	Region 2: I/O ports at f090 [size=8]
	Region 3: I/O ports at f080 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at f791a000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0400c  Data: 4122
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8534
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 6
	Region 0: Memory at f7919000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]

01:00.0 VGA compatible controller: NVIDIA Corporation GK107 [GeForce GT
640] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 83f9
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [disabled]
[size=16M]
	Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] [size=256M]
	Region 3: Memory at f0000000 (64-bit, prefetchable) [disabled] [size=32M]
	Region 5: I/O ports at e000 [disabled] [size=128]
	Expansion ROM at f7000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
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
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>
	Capabilities: [900 v1] #19

01:00.1 Audio device: NVIDIA Corporation GK107 HDMI Audio Controller
(rev a1)
	Subsystem: ASUSTeK Computer Inc. Device 83f9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at f7080000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not
Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest+
	Kernel driver in use: snd_hda_intel

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 11)
	Subsystem: ASUSTeK Computer Inc. Device 859e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at d000 [size=256]
	Region 2: Memory at f7800000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at f2100000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4142
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 71680ns
		Max no snoop latency: 71680ns
	Kernel driver in use: r8169

04:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI
Bridge (rev 03) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [c0] Subsystem: ASUSTeK Computer Inc. Device 8489

[7.6.]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SanDisk SDSSDHP1 Rev: 6RL
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST1000DM003-1CH1 Rev: CC49
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic- Model: SD/MMC           Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic- Model: Compact Flash    Rev: 1.01
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic- Model: SM/xD-Picture    Rev: 1.02
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic- Model: MS/MS-Pro        Rev: 1.03
  Type:   Direct-Access                    ANSI  SCSI revision: 00
[7.7.]

1     158   1844  2144  2465  2944  4    684        driver
pagetypeinfo
10    159   19    2146  2474  2947  40   69         execdomains  partitions
1014  16    1902  2154  25    3     406  7          fb           sched_debug
1033  161   1915  2155  2558  300   41   70         filesystems  schedstat
1050  164   1925  22    2595  301   42   71         fs           scsi
1094  165   1937  2294  26    3028  43   72         interrupts   self
11    166   1983  2298  2608  31    44   8          iomem        slabinfo
1117  167   1984  231   261   3109  45   826        ioports      softirqs
1118  168   1994  232   2612  3127  46   841        irq          stat
1124  169   2     233   262   3131  47   847        kallsyms     swaps
1126  17    20    235   263   3150  471  9          kcore        sys
1181  170   2059  2356  264   32    479  91         keys
sysrq-trigger
12    171   2060  236   2640  3217  48   92         key-users    sysvipc
13    1711  2077  2380  265   3231  49   acpi       kmsg         thread-self
1380  173   2089  24    2665  3240  5    asound     kpagecount   timer_list
1384  1733  2094  2400  27    3241  50   buddyinfo  kpageflags   timer_stats
139   174   2096  2404  2701  33    51   bus        loadavg      tty
1390  1762  2098  2431  276   3384  52   cgroups    locks        uptime
1391  179   21    2432  277   3388  548  cmdline    mdstat       version
1396  1797  2102  2437  279   34    55   consoles   meminfo      vmallocinfo
14    18    2107  2442  28    35    56   cpuinfo    misc         vmstat
1404  181   2117  2443  280   36    57   crypto     modules      zoneinfo
1438  182   2120  2444  2843  37    629  devices    mounts
15    1822  2131  2445  2854  38    680  diskstats  mtrr
156   183   2135  2455  29    39    683  dma        net

[X]
original bug report
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1400826

Note that i have moved from using nvidia graphics to Intel graphics
since filing that report due to needing to use a graphical desktop that
doesn't crash on Linux 3.18 and as noted in the original report I have
updated my BIOS (actually a UEFI) to the latest version
