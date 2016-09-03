From: Vincas Dargis <vindrg@gmail.com>
Subject: Asus N551JM screen brightness keys fn+F5/F6 don't work unless using
 kernel parameter acpi_osi=
Date: Sat, 3 Sep 2016 21:27:18 +0300
Message-ID: <7b99bd3a-480a-b5b9-ff4d-9274f84e75ed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34087 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcICS1l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2016 14:27:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so7181952wmv.1
        for <linux-acpi@vger.kernel.org>; Sat, 03 Sep 2016 11:27:23 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,

Keyboard combination fn+F5/F6 keys doesn't decrease/increase the screen brightness.

As a note, same problem exists for 3.13 version, meanwhile on 3.2 screen AND keyboard brightness keys does not work even 
with attempted workaround (acpi_osi=).



cat /proc/version
Linux version 4.8.0-040800rc4-generic (kernel@gomeisa) (gcc version 6.2.0 20160824 (Ubuntu 6.2.0-1ubuntu12) ) 
#201608312129 SMP Thu Sep 1 01:31:59 UTC 2016



$ /usr/src//linux-headers-4.8.0-040800rc4/scripts/ver_linux
Linux vinco 4.8.0-040800rc4-generic #201608312129 SMP Thu Sep 1 01:31:59 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C            5.4.0
GNU Make        4.1
Binutils        2.26.1
Util-linux        2.27.1
Mount            2.27.1
Module-init-tools    22
E2fsprogs        1.42.13
Pcmciautils        018
PPP            2.4.7
Linux C Library        2.23
Dynamic linker (ldd)    2.23
Linux C++ Library    6.0.21
Procps            3.3.10
Net-tools        1.60
Kbd            1.15.5
Console-tools        1.15.5
Sh-utils        8.25
Udev            229
Wireless-tools        30
Modules Loaded        ablk_helper ac aesni_intel aes_x86_64 ahci arc4 asus_nb_wmi asus_wireless asus_wmi autofs4 battery 
bbswitch binfmt_misc bluetooth bnep bridge btbcm btintel btrtl btusb button cdrom cfg80211 coretemp crc16 crc32c_intel 
crc32_pclmul crct10dif_pclmul cryptd drm drm_kms_helper ebtable_filter ebtables edac_core efi_pstore efivarfs efivars 
ehci_hcd ehci_pci evdev ext4 fat fjes fscrypto gf128mul ghash_clmulni_intel glue_helper hid hid_logitech_dj 
hid_logitech_hidpp i2c_algo_bit i915 ie31200_edac intel_cstate intel_powerclamp intel_rapl intel_rapl_perf 
ip6table_filter ip6_tables iptable_filter iptable_mangle iptable_nat ip_tables ipt_MASQUERADE ipt_REJECT irqbypass 
iwlmvm iwlwifi jbd2 joydev kvm kvm_intel libahci libata llc lp lpc_ich lrw mac80211 mbcache media mei mei_me memstick 
mfd_core mii mmc_core mxm_wmi nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4 nf_nat_masquerade_ipv4 
nf_reject_ipv4 nls_cp437 nls_utf8 nvidia nvidia_drm nvidia_modeset parport parport_pc pci_stub ppdev psmouse r8169 
rfkill rtsx_pci rtsx_pci_ms rtsx_pci_sdmmc scsi_mod sd_mod serio_raw sg shpchp snd snd_hda_codec snd_hda_codec_generic 
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm snd_rawmidi snd_seq snd_seq_device 
snd_seq_midi snd_seq_midi_event snd_timer soundcore sparse_keymap sr_mod stp thermal tpm tpm_tis tpm_tis_core tun 
usb_common usbcore usbhid uvcvideo vboxdrv vboxnetadp vboxnetflt vboxpci vfat video videobuf2_core videobuf2_memops 
videobuf2_v4l2 videobuf2_vmalloc videodev wmi x86_pkg_temp_thermal xhci_hcd xhci_pci x_tables xt_CHECKSUM xt_conntrack 
xt_multiport xt_tcpudp



cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2500.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4988.57
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2526.397
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.32
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2500.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.34
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2499.847
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.37
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2499.847
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.62
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2500.305
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.44
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2500.305
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.40
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 2500.305
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse 
sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
bugs        :
bogomips    : 4989.39
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:




cat /proc/modules
xt_CHECKSUM 16384 2 - Live 0x0000000000000000
iptable_mangle 16384 1 - Live 0x0000000000000000
ipt_MASQUERADE 16384 6 - Live 0x0000000000000000
nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0x0000000000000000
iptable_nat 16384 1 - Live 0x0000000000000000
nf_nat_ipv4 16384 1 iptable_nat, Live 0x0000000000000000
nf_nat 28672 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack_ipv4 20480 3 - Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 16384 2 - Live 0x0000000000000000
nf_conntrack 114688 5 nf_nat_masquerade_ipv4,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack, Live 0x0000000000000000
ipt_REJECT 16384 4 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
xt_tcpudp 16384 12 - Live 0x0000000000000000
xt_multiport 16384 1 - Live 0x0000000000000000
tun 28672 2 - Live 0x0000000000000000
bridge 135168 0 - Live 0x0000000000000000
stp 16384 1 bridge, Live 0x0000000000000000
llc 16384 2 bridge,stp, Live 0x0000000000000000
ebtable_filter 16384 0 - Live 0x0000000000000000
ebtables 36864 1 ebtable_filter, Live 0x0000000000000000
ip6table_filter 16384 0 - Live 0x0000000000000000
ip6_tables 28672 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
ip_tables 28672 3 iptable_mangle,iptable_nat,iptable_filter, Live 0x0000000000000000
x_tables 36864 12 
xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_tcpudp,xt_multiport,ebtables,ip6table_filter,ip6_tables,iptable_filter,ip_tables, 
Live 0x0000000000000000
bbswitch 16384 0 - Live 0x0000000000000000 (OE)
bnep 20480 2 - Live 0x0000000000000000
pci_stub 16384 1 - Live 0x0000000000000000
vboxpci 24576 0 - Live 0x0000000000000000 (OE)
vboxnetadp 28672 0 - Live 0x0000000000000000 (OE)
vboxnetflt 28672 0 - Live 0x0000000000000000 (OE)
vboxdrv 487424 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OE)
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
snd_hda_intel 36864 7 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
snd_hda_codec 131072 4 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
iwlmvm 241664 0 - Live 0x0000000000000000
mac80211 663552 1 iwlmvm, Live 0x0000000000000000
snd_hda_core 81920 5 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
iwlwifi 147456 1 iwlmvm, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
kvm_intel 192512 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
kvm 593920 1 kvm_intel, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_pcm 110592 5 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
asus_nb_wmi 24576 0 - Live 0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
mxm_wmi 16384 0 - Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live 0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
bluetooth 544768 11 bnep,btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
snd 86016 24 
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
intel_rapl_perf 16384 0 - Live 0x0000000000000000
rfkill 24576 7 cfg80211,asus_wmi,bluetooth, Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
ie31200_edac 16384 0 - Live 0x0000000000000000
evdev 24576 29 - Live 0x0000000000000000
edac_core 57344 1 ie31200_edac, Live 0x0000000000000000
tpm 45056 2 tpm_tis,tpm_tis_core, Live 0x0000000000000000
mei_me 36864 0 - Live 0x0000000000000000
mei 102400 1 mei_me, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
wmi 16384 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
asus_wireless 16384 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 3 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 4 ext4, Live 0x0000000000000000
sr_mod 24576 0 - Live 0x0000000000000000
sd_mod 45056 6 - Live 0x0000000000000000
cdrom 61440 1 sr_mod, Live 0x0000000000000000
hid_logitech_hidpp 28672 0 - Live 0x0000000000000000
hid_logitech_dj 20480 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 118784 4 hid_logitech_hidpp,hid_logitech_dj,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
mmc_core 143360 1 rtsx_pci_sdmmc, Live 0x0000000000000000
nvidia_drm 49152 0 - Live 0x0000000000000000 (POE)
nvidia_modeset 774144 1 nvidia_drm, Live 0x0000000000000000 (POE)
crc32c_intel 24576 0 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
i915 1294336 8 - Live 0x0000000000000000
ahci 36864 5 - Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
mfd_core 16384 2 lpc_ich,rtsx_pci, Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
nvidia 11907072 1 nvidia_modeset, Live 0x0000000000000000 (POE)
r8169 81920 0 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
scsi_mod 225280 4 sg,sr_mod,sd_mod,libata, Live 0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
ehci_pci 16384 0 - Live 0x0000000000000000
ehci_hcd 81920 1 ehci_pci, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 155648 2 nvidia_drm,i915, Live 0x0000000000000000
usbcore 253952 7 uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd,ehci_pci,ehci_hcd, Live 0x0000000000000000
drm 360448 10 nvidia_drm,i915,drm_kms_helper, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
video 40960 2 asus_wmi,i915, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
button 16384 1 i915, Live 0x0000000000000000



cat /proc/ioports
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : PNP0C09:00
     0000-0000 : EC data
   0000-0000 : keyboard
   0000-0000 : PNP0C09:00
     0000-0000 : EC cmd
   0000-0000 : rtc0
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : fpu
     0000-0000 : PNP0C04:00
   0000-0000 : pnp 00:05
   0000-0000 : pnp 00:04
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI GPE0_BLK
     0000-0000 : iTCO_wdt.0.auto
     0000-0000 : ACPI PM2_CNT_BLK
     0000-0000 : pnp 00:03
     0000-0000 : iTCO_wdt.0.auto
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : PCI Bus 0000:03
   0000-0000 : PCI Bus 0000:05
     0000-0000 : 0000:05:00.1
       0000-0000 : r8169
   0000-0000 : PCI Bus 0000:01
     0000-0000 : 0000:01:00.0
   0000-0000 : 0000:00:02.0
   0000-0000 : 0000:00:1f.3
   0000-0000 : 0000:00:1f.2
     0000-0000 : ahci
   0000-0000 : 0000:00:1f.2
     0000-0000 : ahci
   0000-0000 : 0000:00:1f.2
     0000-0000 : ahci
   0000-0000 : 0000:00:1f.2
     0000-0000 : ahci
   0000-0000 : 0000:00:1f.2
     0000-0000 : ahci
   0000-0000 : pnp 00:01
     0000-0000 : pnp 00:01
       0000-0000 : pnp 00:01



cat /proc/iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Video ROM
00000000-00000000 : Adapter ROM
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : System ROM
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : reserved
   00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:03
   00000000-00000000 : 0000:00:02.0
     00000000-00000000 : BOOTFB
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : 0000:01:00.0
     00000000-00000000 : 0000:01:00.0
   00000000-00000000 : PCI Bus 0000:03
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : 0000:01:00.0
       00000000-00000000 : nvidia
     00000000-00000000 : 0000:01:00.0
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : PCI Bus 0000:05
     00000000-00000000 : 0000:05:00.0
     00000000-00000000 : 0000:05:00.1
       00000000-00000000 : r8169
     00000000-00000000 : 0000:05:00.1
       00000000-00000000 : r8169
     00000000-00000000 : 0000:05:00.0
       00000000-00000000 : rtsx_pci
   00000000-00000000 : PCI Bus 0000:04
     00000000-00000000 : 0000:04:00.0
       00000000-00000000 : iwlwifi
   00000000-00000000 : 0000:00:14.0
     00000000-00000000 : xhci-hcd
   00000000-00000000 : 0000:00:1b.0
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:03.0
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:1f.3
   00000000-00000000 : 0000:00:1f.2
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:1d.0
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:1a.0
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:16.0
     00000000-00000000 : mei_me
   00000000-00000000 : pnp 00:08
   00000000-00000000 : pnp 00:08
   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
     00000000-00000000 : reserved
       00000000-00000000 : pnp 00:08
00000000-00000000 : reserved
   00000000-00000000 : IOAPIC 0
00000000-00000000 : reserved
   00000000-00000000 : HPET 0
     00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:08
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:08
     00000000-00000000 : iTCO_wdt.0.auto
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:08
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
   00000000-00000000 : reserved
00000000-00000000 : reserved
   00000000-00000000 : INT0800:00
     00000000-00000000 : pnp 00:08
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer



sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller (rev 06)
     Subsystem: ASUSTeK Computer Inc. Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel modules: ie31200_edac

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor PCI Express x16 Controller (rev 06) 
(prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 26
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000e000-0000efff
     Memory behind bridge: f6000000-f70fffff
     Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Xeon E3-1200 v3/4th Gen Core Processor PCI Express x16 Controller
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00218  Data: 0000
     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 256 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
             ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [140 v1] Root Complex Link
         Desc:    PortNumber=02 ComponentID=01 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
             Addr:    00000000fed19000
     Capabilities: [d94 v1] #19
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller (rev 06) 
(prog-if 00 [VGA controller])
     Subsystem: ASUSTeK Computer Inc. 4th Gen Core Processor Integrated Graphics Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 35
     Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
     Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
     Region 4: I/O ports at f000 [size=64]
     [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00018  Data: 0000
     Capabilities: [d0] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: i915
     Kernel modules: i915

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller (rev 06)
     Subsystem: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 39
     Region 0: Memory at f7a14000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00438  Data: 0000
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI (rev 05) (prog-if 30 [XHCI])
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family USB xHCI
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 33
     Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee00378  Data: 0000
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci

00:16.0 Communication controller: Intel Corporation 8 Series/C220 Series Chipset Family MEI Controller #1 (rev 04)
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family MEI Controller
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 36
     Region 0: Memory at f7a1e000 (64-bit, non-prefetchable) [size=16]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee003b8  Data: 0000
     Kernel driver in use: mei_me
     Kernel modules: mei_me

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family USB EHCI
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at f7a1c000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller (rev 05)
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset High Definition Audio Controller
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 38
     Region 0: Memory at f7a10000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00418  Data: 0000
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
             Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
             Status:    NegoPending- InProgress-
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #1 (rev d5) (prog-if 00 
[Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 27
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via WAKE# ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00238  Data: 0000
     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family PCI Express Root Port
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #2 (rev d5) (prog-if 00 
[Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 28
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: cfe00000-cfffffff
     Prefetchable memory behind bridge: 00000000f2000000-00000000f21fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
             Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00278  Data: 0000
     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family PCI Express Root Port
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #3 (rev d5) (prog-if 00 
[Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 29
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: f7900000-f79fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee002b8  Data: 0000
     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family PCI Express Root Port
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #4 (rev d5) (prog-if 00 
[Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin D routed to IRQ 30
     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
     I/O behind bridge: 0000d000-0000dfff
     Memory behind bridge: f7800000-f78fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee002f8  Data: 0000
     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family PCI Express Root Port
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family USB EHCI
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at f7a1b000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller (rev 05)
     Subsystem: ASUSTeK Computer Inc. HM86 Express LPC Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich
     Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 
05) (prog-if 01 [AHCI 1.0])
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 34
     Region 0: I/O ports at f0b0 [size=8]
     Region 1: I/O ports at f0a0 [size=4]
     Region 2: I/O ports at f090 [size=8]
     Region 3: I/O ports at f080 [size=4]
     Region 4: I/O ports at f060 [size=32]
     Region 5: Memory at f7a1a000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00398  Data: 0000
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Kernel driver in use: ahci
     Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family SMBus Controller (rev 05)
     Subsystem: ASUSTeK Computer Inc. 8 Series/C220 Series Chipset Family SMBus Controller
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 4
     Region 0: Memory at f7a19000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at f040 [size=32]
     Kernel modules: i2c_i801

01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 860M] (rev a2)
     Subsystem: ASUSTeK Computer Inc. GM107M [GeForce GTX 860M]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
     Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
     Region 3: Memory at f0000000 (64-bit, prefetchable) [size=32M]
     Region 5: I/O ports at e000 [size=128]
     Expansion ROM at f7000000 [disabled] [size=512K]
     Capabilities: [60] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [78] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF Via message
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [250 v1] Latency Tolerance Reporting
         Max snoop latency: 71680ns
         Max no snoop latency: 71680ns
     Capabilities: [258 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
               PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
     Capabilities: [128 v1] Power Budgeting <?>
     Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
     Capabilities: [900 v1] #19
     Kernel driver in use: nvidia
     Kernel modules: nvidiafb, nouveau, nvidia_370, nvidia_370_drm

04:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
     Subsystem: Intel Corporation Dual Band Wireless-N 7260
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 37
     Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [c8] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee003d8  Data: 0000
     Capabilities: [40] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <32us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [140 v1] Device Serial Number 48-51-b7-ff-ff-6b-7d-3a
     Capabilities: [14c v1] Latency Tolerance Reporting
         Max snoop latency: 71680ns
         Max no snoop latency: 71680ns
     Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
     Kernel driver in use: iwlwifi
     Kernel modules: iwlwifi

05:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5287 (rev 01)
     Subsystem: ASUSTeK Computer Inc. Device 202f
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 32
     Region 0: Memory at f7815000 (32-bit, non-prefetchable) [size=4K]
     Expansion ROM at f7800000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00338  Data: 0000
     Capabilities: [70] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
         Vector table: BAR=0 offset=00000000
         PBA: BAR=0 offset=00000000
     Capabilities: [d0] Vital Product Data
         Not readable
     Capabilities: [100 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
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
     Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [170 v1] Latency Tolerance Reporting
         Max snoop latency: 71680ns
         Max no snoop latency: 71680ns
     Capabilities: [178 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
               PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
     Kernel driver in use: rtsx_pci
     Kernel modules: rtsx_pci

05:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 
(rev 12)
     Subsystem: ASUSTeK Computer Inc. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 31
     Region 0: I/O ports at d000 [size=256]
     Region 2: Memory at f7814000 (64-bit, non-prefetchable) [size=4K]
     Region 4: Memory at f7810000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00318  Data: 0000
     Capabilities: [70] Express (v2) Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00000800
     Capabilities: [d0] Vital Product Data
         Not readable
     Capabilities: [100 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
     Capabilities: [170 v1] Latency Tolerance Reporting
         Max snoop latency: 71680ns
         Max no snoop latency: 71680ns
     Capabilities: [178 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
               PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
     Kernel driver in use: r8169
     Kernel modules: r8169


