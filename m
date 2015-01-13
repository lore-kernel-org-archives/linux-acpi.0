From: "dothiko(Akihiko Miura)" <dothiko@gmail.com>
Subject: PROBLEM:Computer resumes right after going into suspend
Date: Tue, 13 Jan 2015 21:58:56 +0900
Message-ID: <54B51690.2000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56863 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbAMM7A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jan 2015 07:59:00 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so3570689pac.8
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2015 04:59:00 -0800 (PST)
Received: from [192.168.0.32] (pdcd33819.tubehm00.ap.so-net.ne.jp. [220.211.56.25])
        by mx.google.com with ESMTPSA id kr10sm17071949pdb.42.2015.01.13.04.58.58
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2015 04:58:59 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
Computer resumes right after going into suspend

[2.] Full description of the problem/report:

first of all,my computer's motherboard is Asrock H77M.

on this H77M computer,usually, S3 suspend/resume of linux works fine,
but under certain conditions,
computer go into suspend state once,but right after into suspend,computer resumes automatically ,without any user interaction such as typing keyboard or pushing ACPI powerbutton.

how to exactly reproduce problem at my computer:

1) plug USB 3.0 HDD to USB 3.0 port of motherboard(Asrock H77M) backpanel with a USB3.0 micro-B superspeed(5Gbps) cable.

NOTE: connected with USB 2.0 micro-B highspeed(480Mbps)cable on USB 3.0 port,this issue does not happen.

2) mount USB 3.0 HDD
3) remove USB 3.0 HDD from system with such as 'eject' or 'safely remove' menu command of desktop environment or gnome-disk-utility application.
5) wait until HDD power indicater LED turned off,then, unplug HDD from USB 3.0 port.
6) do suspend from desktop environment menu or execute 'pm-suspend' command at terminal.

after this procedure,when computer enter suspend,it resume immidiately and automatically.

once this problem has happened,suspend always wakeup immidiately until reboot system or disable wakeup from usb devices.

[4.]kernel version
Linux version 3.19.0-031900rc4-generic (apw@tangerine) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201501112135 SMP Sun Jan 11 21:36:48 UTC 2015


[7.] Environment
Description:    Ubuntu 14.04.1 LTS
Release:    14.04


[7.1.] Software
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux testdesktop 3.19.0-031900rc4-generic #201501112135 SMP Sun Jan 11 21:36:48 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         snd_hrtimer cuse bnep rfcomm bluetooth binfmt_misc intel_rapl iosf_mbi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel snd_hda_codec_hdmi aes_x86_64 lrw i915 snd_hda_codec_realtek snd_hda_codec_generic gf128mul glue_helper snd_hda_intel snd_hda_controller ablk_helper snd_hda_codec snd_hwdep snd_pcm cryptd snd_seq_midi snd_seq_midi_event drm_kms_helper snd_rawmidi snd_seq mei_me snd_seq_device snd_timer drm wacom mei snd soundcore joydev i2c_algo_bit ppdev parport_pc intel_smartconnect serio_raw lp parport 8250_fintek nuvoton_cir rc_core mac_hid lpc_ich video hid_generic usbhid hid uas usb_storage psmouse ahci r8169 libahci mii


[7.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3470S CPU @ 2.90GHz
stepping    : 9
microcode    : 0x15
cpu MHz        : 2707.988
cache size    : 6144 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt
bugs        :
bogomips    : 5787.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3470S CPU @ 2.90GHz
stepping    : 9
microcode    : 0x15
cpu MHz        : 2900.000
cache size    : 6144 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt
bugs        :
bogomips    : 5787.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3470S CPU @ 2.90GHz
stepping    : 9
microcode    : 0x15
cpu MHz        : 1600.097
cache size    : 6144 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt
bugs        :
bogomips    : 5787.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3470S CPU @ 2.90GHz
stepping    : 9
microcode    : 0x15
cpu MHz        : 2894.902
cache size    : 6144 KB
physical id    : 0
siblings    : 4
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt
bugs        :
bogomips    : 5787.11
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:



[7.3.] Module information (from /proc/modules):
snd_hrtimer 12744 1 - Live 0x0000000000000000
cuse 13566 3 - Live 0x0000000000000000
bnep 23980 2 - Live 0x0000000000000000
rfcomm 75100 0 - Live 0x0000000000000000
bluetooth 510653 10 bnep,rfcomm, Live 0x0000000000000000
binfmt_misc 18163 1 - Live 0x0000000000000000
intel_rapl 19714 0 - Live 0x0000000000000000
iosf_mbi 13865 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
kvm_intel 154139 0 - Live 0x0000000000000000
kvm 480978 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 169686 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
i915 1087440 3 - Live 0x0000000000000000
snd_hda_codec_realtek 80490 1 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 30824 3 - Live 0x0000000000000000
snd_hda_controller 36330 1 snd_hda_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 144641 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 106365 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
drm_kms_helper 119701 1 i915, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 63540 3 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
mei_me 19610 0 - Live 0x0000000000000000
snd_seq_device 14875 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30118 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
drm 341532 5 i915,drm_kms_helper, Live 0x0000000000000000
wacom 82171 0 - Live 0x0000000000000000
mei 88864 1 mei_me, Live 0x0000000000000000
snd 84025 18 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
parport_pc 32909 1 - Live 0x0000000000000000
intel_smartconnect 12637 0 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 ppdev,parport_pc,lp, Live 0x0000000000000000
8250_fintek 12924 0 - Live 0x0000000000000000
nuvoton_cir 17920 0 - Live 0x0000000000000000
rc_core 27515 1 nuvoton_cir, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
video 24803 1 i915, Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53155 0 - Live 0x0000000000000000
hid 110883 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
uas 22673 0 - Live 0x0000000000000000
usb_storage 67005 1 uas, Live 0x0000000000000000
psmouse 118431 0 - Live 0x0000000000000000
ahci 34220 3 - Live 0x0000000000000000
r8169 87016 0 - Live 0x0000000000000000
libahci 32353 1 ahci, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000


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
   00c0-00df : dma2
   00f0-00ff : PNP0C04:00
     00f0-00ff : fpu
   0290-029f : pnp 00:04
   0378-037a : parport0
   037b-037f : parport0
   03f8-03ff : serial
   0400-0403 : ACPI PM1a_EVT_BLK
   0404-0405 : ACPI PM1a_CNT_BLK
   0408-040b : ACPI PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-042f : ACPI GPE0_BLK
   0430-0433 : iTCO_wdt
   0450-0450 : ACPI PM2_CNT_BLK
   0454-0457 : pnp 00:03
   0458-047f : pnp 00:01
     0460-047f : iTCO_wdt
   04d0-04d1 : pnp 00:06
   0500-057f : pnp 00:01
   0680-069f : pnp 00:01
   0778-077a : parport0
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-100f : pnp 00:01
   164e-164f : pnp 00:01
   2000-2fff : PCI Bus 0000:04
   e000-efff : PCI Bus 0000:02
     e000-e0ff : 0000:02:00.0
       e000-e0ff : r8169
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
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce5ff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
   01000000-017d73c3 : Kernel code
   017d73c4-01d24cff : Kernel data
   01e8d000-01fcffff : Kernel bss
20000000-201fffff : reserved
   20000000-201fffff : pnp 00:09
20200000-40003fff : System RAM
40004000-40004fff : reserved
   40004000-40004fff : pnp 00:09
40005000-bcfc1fff : System RAM
bcfc2000-bd78efff : reserved
bd78f000-bd818fff : System RAM
bd819000-bd8b8fff : ACPI Non-volatile Storage
bd8b9000-be0fbfff : reserved
be0fc000-be0fcfff : System RAM
be0fd000-be13ffff : ACPI Non-volatile Storage
be140000-bebd0fff : System RAM
bebd1000-beff1fff : reserved
beff2000-beffffff : System RAM
bf000000-bf7fffff : RAM buffer
bf800000-df9fffff : reserved
   bfa00000-df9fffff : Graphics Stolen Memory
dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:08
   dfb00000-dfcfffff : PCI Bus 0000:04
   dfd00000-dfefffff : PCI Bus 0000:04
   e0000000-efffffff : 0000:00:02.0
   f0000000-f00fffff : PCI Bus 0000:02
     f0000000-f0003fff : 0000:02:00.0
       f0000000-f0003fff : r8169
     f0004000-f0004fff : 0000:02:00.0
       f0004000-f0004fff : r8169
   f7800000-f7bfffff : 0000:00:02.0
   f7c00000-f7c0ffff : 0000:00:14.0
     f7c00000-f7c0ffff : xhci-hcd
   f7c10000-f7c13fff : 0000:00:1b.0
     f7c10000-f7c13fff : ICH HD audio
   f7c15000-f7c150ff : 0000:00:1f.3
   f7c16000-f7c167ff : 0000:00:1f.2
     f7c16000-f7c167ff : ahci
   f7c17000-f7c173ff : 0000:00:1d.0
     f7c17000-f7c173ff : ehci_hcd
   f7c18000-f7c183ff : 0000:00:1a.0
     f7c18000-f7c183ff : ehci_hcd
   f7c1a000-f7c1a00f : 0000:00:16.0
     f7c1a000-f7c1a00f : mei_me
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
100000000-41f5fffff : System RAM
41f600000-41fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor DRAM Controller (rev 09)
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: ivb_uncore

00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
     Subsystem: ASRock Incorporation Device 0152
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 29
     Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
     Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
     Region 4: I/O ports at f000 [size=64]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0100c  Data: 4142
     Capabilities: [d0] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 24
     Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 4181
     Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 27
     Region 0: Memory at f7c1a000 (64-bit, non-prefetchable) [size=16]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0f00c  Data: 4152
     Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at f7c18000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
     Subsystem: ASRock Incorporation Device 8892
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 28
     Region 0: Memory at f7c10000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0f00c  Data: 4162
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
             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=22
             Status:    NegoPending- InProgress-
     Capabilities: [130 v1] Root Complex Link
         Desc:    PortNumber=0f ComponentID=00 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #0, PowerLimit 25.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: ASRock Incorporation Motherboard
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 5 (rev c4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000e000-0000efff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
             Changed: MRL- PresDet- LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: ASRock Incorporation Motherboard
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c4) (prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fff00000-000fffff
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
         LnkCap:    Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
             Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
             Changed: MRL- PresDet- LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: ASRock Incorporation Device 244e
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at f7c17000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation H77 Express Chipset LPC Controller (rev 04)
     Subsystem: ASRock Incorporation Device 1e4a
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series/C210 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 25
     Region 0: I/O ports at f0b0 [size=8]
     Region 1: I/O ports at f0a0 [size=4]
     Region 2: I/O ports at f090 [size=8]
     Region 3: I/O ports at f080 [size=4]
     Region 4: I/O ports at f060 [size=32]
     Region 5: Memory at f7c16000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0100c  Data: 41b1
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Capabilities: [b0] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
     Subsystem: ASRock Incorporation Motherboard
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 3
     Region 0: Memory at f7c15000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at f040 [size=32]

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
     Subsystem: ASRock Incorporation Motherboard (one of many)
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 26
     Region 0: I/O ports at e000 [size=256]
     Region 2: Memory at f0004000 (64-bit, prefetchable) [size=4K]
     Region 4: Memory at f0000000 (64-bit, prefetchable) [size=16K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 41c1
     Capabilities: [70] Express (v2) Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
     Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00000800
     Capabilities: [d0] Vital Product Data
         No end tag found
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
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
     Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
     Kernel driver in use: r8169

03:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge (rev 03) (prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 32 bytes
     Bus: primary=03, secondary=04, subordinate=04, sec-latency=64
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: dfb00000-dfcfffff
     Prefetchable memory behind bridge: 00000000dfd00000-00000000dfefffff
     Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [c0] Subsystem: ASRock Incorporation Motherboard



[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: TOSHIBA THNSNH12 Rev: N101
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST31000528AS     Rev: CC46
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD5000BEVT-0 Rev: 1A01
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
   Vendor: Generic  Model: USB SD Reader    Rev: 1.00
   Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 01
   Vendor: Generic  Model: USB CF Reader    Rev: 1.01
   Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 02
   Vendor: Generic  Model: USB SM Reader    Rev: 1.02
   Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi6 Channel: 00 Id: 00 Lun: 03
   Vendor: Generic  Model: USB MS Reader    Rev: 1.03
   Type:   Direct-Access                    ANSI  SCSI revision: 00


[7.7.] Other information that might be relevant to the problem:
1
10
1017
1044
1057
106
1068
1073
1088
1092
1097
11
1181
1191
1194
1195
1196
12
1262
1274
1277
13
1330
1333
1345
1371
14
1425
145
146
1463
147
148
1489
149
15
150
151
152
153
154
155
156
157
158
159
16
160
161
162
163
164
165
166
17
170
171
172
1761
18
180
181
19
1921
1926
193
194
195
196
1997
2
20
2006
2010
2016
2022
2024
2026
2028
2034
2043
2050
2054
2060
2061
2066
2068
2072
2079
2092
21
2100
2104
2114
2119
2123
2125
2126
2127
2135
2137
2138
2148
2154
2156
2159
2161
2199
22
2256
2260
2264
23
2304
2308
2311
2317
2324
2328
2348
2353
2359
2370
2379
2385
2392
24
2416
2441
2464
2465
2467
2471
2472
2477
2478
25
2548
2551
2552
2556
2562
2590
2596
2598
26
2613
2644
27
28
29
2932
2933
2934
2935
2936
2937
2938
2939
2940
2941
2942
2943
2944
2945
2946
2947
2948
2949
2950
2951
2952
2957
2999
3
30
31
32
3285
33
3380
34
35
353
36
363
37
38
39
4
40
41
42
43
44
45
46
47
48
49
5
50
51
53
54
540
55
6
611
636
637
660
67
68
7
72
73
774
776
8
830
843
858
859
864
9
903
912
92
93
956
960
966
967
970
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
key-users
keys
kmsg
kpagecount
kpageflags
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
thread-self
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo


[X.] Other notes, patches, fixes, workarounds:

NOTES 1:

  * the BIOS(UEFI) of Motherboard Asrock H77M already upgraded to newest ver 1.60.

  * USB 2.0/3.0 HDD on USB 2.0 port does not cause this problem.

  * I have experienced this issue when connecting USB 3.0 HDD with USB3.0 micro-B superspeed(5Gbps) cable.
    with USB 2.0 micro-B highspeed(480Mbps)cable on USB 3.0 port,this issue does not happen.

  * my USB3.0 HDDs are BUFFALO HD-PCT1TU3-BW and SONY HD-E1.
    both HDD show same problem at linux on H77M.

  * I have no USB3.0 front panel blacket,so USB3.0 ports of motherboard header pin remain blank and untested.

  * To confirm the possibility of some other hardware failure might cause this problem,I removed all the peripherals except for usb keyboard ,mouse and monitor,but nothing changed at this problem.

    and then I changed keyboard/mouse from Realforce UB87/logitech LS1t to nonbrand compact keyboard/mouse and did test again,but nothing changed.

  * I also tested changing UEFI setup options of ACPI configuration,such as

     PS/2 Keyboard Power On
     PCI Devices Power On
     Ring-In Power On
     USB keyboard/Remote Power On
     USB Mouse Power On

    I set all of above as 'disabled',but nothing changed.

----

NOTES 2:

I found another curious behavior of H77M's USB3.0 port about suspend/resume.
how to reproduce such bahavior is:

1) boot ubuntu 14.04 PC and log in.(to ensure make system state clear)

2) connect USB3.0 HDD to USB 3.0 port with USB 3.0 superspeed cable.

3) mount it

4) leave USB 3.0 HDD as mounted and powered,do suspend computer.

5) computer suspended sucessfully,all peripherals power down and sleep.

6) wakeup computer by typing a usb keyboard or pushing powerbutton.it resumed successfully.


in summary,'when suspend prior to eject usb 3.0 HDD,this computer can sleep and resume successfully.'

and after this process,I can suspend/resume again successfully even execute "Safety remove" of USB3.0 HDD.

----
WORKAROUND:

my workaround for this problem is simply make system to ignore any USB wakeup events.

when 'cat /proc/acpi/wakeup',
it shows usb subsystem wakeup information something like that

EHC1      S4    *enabled   pci:0000:00:1d.0
EHC2      S4    *enabled   pci:0000:00:1a.0
XHC      S4    *enabled   pci:0000:00:14.0

then,use this information to disable both XHCI(XHC) and EHCI(EHC1&EHC2) wakeup.
disabling only either XHCI(XHC) or EHCI(ECH1&EHC2) did not work,at least my H77M motherboard.

sudo sh -c "echo 'disabled' > /sys/bus/pci/devices/0000\:00\:1d.0/power/wakeup"
sudo sh -c "echo 'disabled' >/sys/bus/pci/devices/0000\:00\:1a.0/power/wakeup"
sudo sh -c "echo 'disabled' >/sys/bus/pci/devices/0000\:00\:14.0/power/wakeup"

then, suspend/resume will work well because system simply ignore any USB wakeup events.

Consequently,this PC cannot wakeup from suspend with typing a USB keyboard...
but ACPI powerbutton still works,so I use powerbutton instead of keyboard to wakeup.
it is a little less convenient,but acceptable enough.

