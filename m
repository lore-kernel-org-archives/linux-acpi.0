From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: PROBLEM: [Acer Aspire 5742] Screen brightness not working
Date: Wed, 10 Dec 2014 13:08:58 +0800
Message-ID: <5487D56A.4080207@intel.com>
References: <CANiiDBGMAmmLtrEsAhUXuGObZeu-7vU7Sh2tc8ryTrz-Hp6YdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23327 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaLJFJA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2014 00:09:00 -0500
In-Reply-To: <CANiiDBGMAmmLtrEsAhUXuGObZeu-7vU7Sh2tc8ryTrz-Hp6YdA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Merlijn Sebrechts <merlijn.sebrechts@gmail.com>, linux-acpi@vger.kernel.org

On 12/09/2014 08:49 PM, Merlijn Sebrechts wrote:
> [1.] One line summary of the problem:
> 8086:0046 [Acer Aspire 5742] Screen brightness not working
> 
> [2.] Full description of the problem/report:
> The screen brightness control is not working on an Acer Aspire 5742.
> The OS recognizes when I press my function keys, but the brightness
> does not change. Changing the screen brightness in settings also
> doesn't do anything.

acpidump please:
# acpidump > acpidump.txt

Please also list:
# ls /sys/class/backlight

And does any of those interface work? e.g.
# cd /sys/class/backlight/acpi_videX
# cat max_brightness
15
# echo 4 > brightness
# echo 6 > brightness
...

Thanks,
Aaron

> 
> [3.] Keywords (i.e., modules, networking, kernel):
> 
> [4.] Kernel version (from /proc/version):
> Linux version 3.18.0-031800rc7-generic (apw@gomeisa) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411302035 SMP Mon Dec 1
> 01:58:20 UTC 2014
> 
> [5.] Output of Oops.. message (if applicable) with symbolic
> information resolved (see Documentation/oops-tracing.txt)
> 
> [6.] A small shell script or example program which triggers the
> problem (if possible)
> 
> [7.] Environment
> Description: Ubuntu 14.04.1 LTS
> Release: 14.04
> 
> [7.1.] Software (add the output of the ver_linux script here)
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.24
> util-linux             2.20.1
> mount                  support
> module-init-tools      15
> e2fsprogs              1.42.9
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.21
> wireless-tools         30
> Modules Loaded         ctr ccm rfcomm bnep bluetooth binfmt_misc
> uvcvideo snd_hda_codec_hdmi snd_hda_codec_realtek videobuf2_vmalloc
> videobuf2_memops snd_hda_codec_generic videobuf2_core snd_hda_intel
> v4l2_common snd_hda_controller videodev arc4 snd_hda_codec media
> snd_hwdep snd_pcm ath9k ath9k_common snd_seq_midi ath9k_hw i915
> snd_seq_midi_event ath mac80211 snd_rawmidi snd_seq drm_kms_helper
> intel_powerclamp snd_seq_device snd_timer coretemp cfg80211 drm
> kvm_intel snd kvm mei_me i2c_algo_bit soundcore mei joydev serio_raw
> intel_ips lpc_ich acer_wmi sparse_keymap mxm_wmi parport_pc ppdev wmi
> video lp mac_hid parport hid_logitech_dj usbhid hid broadcom tg3
> psmouse ptp ahci libahci pps_core
> 
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 37
> model name : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
> stepping : 5
> microcode : 0x2
> cpu MHz : 2399.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 0
> initial apicid : 0
> fdiv_bug : no
> f00f_bug : no
> coma_bug : no
> fpu : yes
> fpu_exception : yes
> cpuid level : 11
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf
> pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1
> sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi flexpriority ept
> vpid
> bugs :
> bogomips : 4787.60
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
> 
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 37
> model name : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
> stepping : 5
> microcode : 0x2
> cpu MHz : 933.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 1
> initial apicid : 1
> fdiv_bug : no
> f00f_bug : no
> coma_bug : no
> fpu : yes
> fpu_exception : yes
> cpuid level : 11
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf
> pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1
> sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi flexpriority ept
> vpid
> bugs :
> bogomips : 4787.60
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
> 
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 37
> model name : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
> stepping : 5
> microcode : 0x2
> cpu MHz : 933.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 2
> cpu cores : 2
> apicid : 4
> initial apicid : 4
> fdiv_bug : no
> f00f_bug : no
> coma_bug : no
> fpu : yes
> fpu_exception : yes
> cpuid level : 11
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf
> pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1
> sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi flexpriority ept
> vpid
> bugs :
> bogomips : 4787.60
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
> 
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 37
> model name : Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz
> stepping : 5
> microcode : 0x2
> cpu MHz : 1866.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 2
> cpu cores : 2
> apicid : 5
> initial apicid : 5
> fdiv_bug : no
> f00f_bug : no
> coma_bug : no
> fpu : yes
> fpu_exception : yes
> cpuid level : 11
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
> constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf
> pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1
> sse4_2 popcnt lahf_lm arat dtherm tpr_shadow vnmi flexpriority ept
> vpid
> bugs :
> bogomips : 4787.60
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
> 
> 
> [7.3.] Module information (from /proc/modules):
> ctr 13025 2 - Live 0x00000000
> ccm 17562 2 - Live 0x00000000
> rfcomm 59288 0 - Live 0x00000000
> bnep 19107 2 - Live 0x00000000
> bluetooth 421512 10 rfcomm,bnep, Live 0x00000000
> binfmt_misc 13165 1 - Live 0x00000000
> uvcvideo 76687 0 - Live 0x00000000
> snd_hda_codec_hdmi 47211 1 - Live 0x00000000
> snd_hda_codec_realtek 68787 1 - Live 0x00000000
> videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
> videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
> snd_hda_codec_generic 63667 1 snd_hda_codec_realtek, Live 0x00000000
> videobuf2_core 45571 1 uvcvideo, Live 0x00000000
> snd_hda_intel 29576 3 - Live 0x00000000
> v4l2_common 15158 1 videobuf2_core, Live 0x00000000
> snd_hda_controller 30930 1 snd_hda_intel, Live 0x00000000
> videodev 140643 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x00000000
> arc4 12509 2 - Live 0x00000000
> snd_hda_codec 121018 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x00000000
> media 21030 2 uvcvideo,videodev, Live 0x00000000
> snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
> snd_pcm 89138 4
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
> Live 0x00000000
> ath9k 137891 0 - Live 0x00000000
> ath9k_common 20782 1 ath9k, Live 0x00000000
> snd_seq_midi 13324 0 - Live 0x00000000
> ath9k_hw 439617 2 ath9k,ath9k_common, Live 0x00000000
> i915 905336 9 - Live 0x00000000
> snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
> ath 24509 3 ath9k,ath9k_common,ath9k_hw, Live 0x00000000
> mac80211 593840 1 ath9k, Live 0x00000000
> snd_rawmidi 25786 1 snd_seq_midi, Live 0x00000000
> snd_seq 56978 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
> drm_kms_helper 87512 1 i915, Live 0x00000000
> intel_powerclamp 18561 0 - Live 0x00000000
> snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
> snd_timer 29036 2 snd_pcm,snd_seq, Live 0x00000000
> coretemp 13358 0 - Live 0x00000000
> cfg80211 440091 4 ath9k,ath9k_common,ath,mac80211, Live 0x00000000
> drm 263568 6 i915,drm_kms_helper, Live 0x00000000
> kvm_intel 143291 0 - Live 0x00000000
> snd 67102 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x00000000
> kvm 411214 1 kvm_intel, Live 0x00000000
> mei_me 18957 0 - Live 0x00000000
> i2c_algo_bit 13316 1 i915, Live 0x00000000
> soundcore 14635 2 snd_hda_codec,snd, Live 0x00000000
> mei 72544 1 mei_me, Live 0x00000000
> joydev 17311 0 - Live 0x00000000
> serio_raw 13251 0 - Live 0x00000000
> intel_ips 18118 0 - Live 0x00000000
> lpc_ich 17000 0 - Live 0x00000000
> acer_wmi 19307 0 - Live 0x00000000
> sparse_keymap 13658 1 acer_wmi, Live 0x00000000
> mxm_wmi 12893 0 - Live 0x00000000
> parport_pc 32154 0 - Live 0x00000000
> ppdev 17423 0 - Live 0x00000000
> wmi 18843 2 acer_wmi,mxm_wmi, Live 0x00000000
> video 19969 2 i915,acer_wmi, Live 0x00000000
> lp 13359 0 - Live 0x00000000
> mac_hid 13099 0 - Live 0x00000000
> parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
> hid_logitech_dj 18161 0 - Live 0x00000000
> usbhid 47478 0 - Live 0x00000000
> hid 91996 3 hid_logitech_dj,usbhid, Live 0x00000000
> broadcom 13065 0 - Live 0x00000000
> tg3 159838 0 - Live 0x00000000
> psmouse 106559 0 - Live 0x00000000
> ptp 18938 1 tg3, Live 0x00000000
> ahci 25756 2 - Live 0x00000000
> libahci 31003 1 ahci, Live 0x00000000
> pps_core 18768 1 ptp, Live 0x00000000
> 
> 
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>     00f0-00f0 : PNP0C04:00
>   03c0-03df : vesafb
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0460-047f : iTCO_wdt
>   0500-057f : pnp 00:00
>   0680-069f : pnp 00:00
>   0800-080f : pnp 00:00
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   1000-1fff : PCI Bus 0000:02
>   2000-2fff : PCI Bus 0000:01
>   3000-301f : 0000:00:1f.3
>   3020-303f : 0000:00:1f.2
>     3020-303f : ahci
>   3040-3047 : 0000:00:1f.2
>     3040-3047 : ahci
>   3048-304f : 0000:00:1f.2
>     3048-304f : ahci
>   3050-3057 : 0000:00:02.0
>   3058-305b : 0000:00:1f.2
>     3058-305b : ahci
>   305c-305f : 0000:00:1f.2
>     305c-305f : ahci
>   ff2c-ff2f : pnp 00:00
>   ffff-ffff : pnp 00:00
>     ffff-ffff : pnp 00:00
> 
> 00000000-00000fff : reserved
> 00001000-0009cfff : System RAM
> 0009d000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
>   000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000d0000-000d1fff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-93680fff : System RAM
>   01000000-016d1ae2 : Kernel code
>   016d1ae3-01a718ff : Kernel data
>   01b61000-01c27fff : Kernel bss
> 93681000-936befff : reserved
> 936bf000-93735fff : System RAM
> 93736000-937befff : ACPI Non-volatile Storage
> 937bf000-937defff : System RAM
> 937df000-937fefff : ACPI Tables
> 937ff000-937fffff : System RAM
> 93800000-9fffffff : reserved
>   98000000-9fffffff : Graphics Stolen Memory
> a0000000-febfffff : PCI Bus 0000:00
>   a0000000-afffffff : 0000:00:02.0
>   b0000000-b03fffff : 0000:00:02.0
>   b0400000-b13fffff : PCI Bus 0000:01
>   b1400000-b23fffff : PCI Bus 0000:02
>   b2400000-b33fffff : PCI Bus 0000:02
>     b2400000-b240ffff : 0000:02:00.0
>       b2400000-b240ffff : ath9k
>   b3400000-b43fffff : PCI Bus 0000:01
>     b3400000-b340ffff : 0000:01:00.0
>       b3400000-b340ffff : tg3
>   b4400000-b4403fff : 0000:00:1b.0
>     b4400000-b4403fff : ICH HD audio
>   b4404000-b4404fff : 0000:00:1f.6
>     b4404000-b4404fff : ips thermal sensor
>   b4405000-b44057ff : 0000:00:1f.2
>     b4405000-b44057ff : ahci
>   b4405800-b4405bff : 0000:00:1d.0
>     b4405800-b4405bff : ehci_hcd
>   b4405c00-b4405fff : 0000:00:1a.0
>     b4405c00-b4405fff : ehci_hcd
>   b4406000-b44060ff : 0000:00:1f.3
>   b4406100-b440610f : 0000:00:16.0
>     b4406100-b440610f : mei_me
>   b4407000-b4407fff : Intel Flush Page
>   b4500000-b4500fff : pnp 00:04
>   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>     e0000000-efffffff : reserved
>       e0000000-efffffff : pnp 00:04
>   feb00000-feb03fff : reserved
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed10000-fed13fff : reserved
>   fed10000-fed13fff : pnp 00:04
> fed18000-fed19fff : reserved
>   fed18000-fed18fff : pnp 00:04
>   fed19000-fed19fff : pnp 00:04
> fed1b000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:04
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:04
> fed45000-fed8ffff : pnp 00:04
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff000000-ffffffff : INT0800:00
>   ffe80000-ffffffff : reserved
> 100000000-11bffffff : System RAM
> 
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 02)
> Subsystem: Acer Incorporated [ALI] TravelMate 5742
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: agpgart-intel
> 
> 00:02.0 VGA compatible controller: Intel Corporation Core Processor
> Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 26
> Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
> Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
> Region 4: I/O ports at 3050 [size=8]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0f00c  Data: 41d1
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
> 
> 00:16.0 Communication controller: Intel Corporation 5 Series/3400
> Series Chipset HECI Controller (rev 06)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 25
> Region 0: Memory at b4406100 (64-bit, non-prefetchable) [size=16]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 41c1
> Kernel driver in use: mei_me
> 
> 00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
> USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at b4405c00 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
> High Definition Audio (rev 05)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 27
> Region 0: Memory at b4400000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4122
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status: NegoPending- InProgress-
> VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=02
> Status: NegoPending- InProgress-
> Capabilities: [130 v1] Root Complex Link
> Desc: PortNumber=0f ComponentID=00 EltType=Config
> Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
> Addr: 00000000fed1c000
> Kernel driver in use: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
> Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: 00002000-00002fff
> Memory behind bridge: b3400000-b43fffff
> Prefetchable memory behind bridge: 00000000b0400000-00000000b13fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <256ns, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0487
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
> Express Root Port 2 (rev 05) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> I/O behind bridge: 00001000-00001fff
> Memory behind bridge: b2400000-b33fffff
> Prefetchable memory behind bridge: 00000000b1400000-00000000b23fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <256ns, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0487
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
> USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at b4405800 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci-pci
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a5)
> (prog-if 01 [Subtractive decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [50] Subsystem: Acer Incorporated [ALI] Device 0487
> 
> 00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
> Interface Controller (rev 05)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=10 <?>
> Kernel driver in use: lpc_ich
> 
> 00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series
> Chipset 4 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 24
> Region 0: I/O ports at 3048 [size=8]
> Region 1: I/O ports at 305c [size=4]
> Region 2: I/O ports at 3040 [size=8]
> Region 3: I/O ports at 3058 [size=4]
> Region 4: I/O ports at 3020 [size=32]
> Region 5: Memory at b4405000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0c00c  Data: 41a1
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
> Capabilities: [b0] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ahci
> 
> 00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
> Controller (rev 05)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 10
> Region 0: Memory at b4406000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at 3000 [size=32]
> 
> 00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
> Series Chipset Thermal Subsystem (rev 05)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 21
> Region 0: Memory at b4404000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Kernel driver in use: intel ips
> 
> 01:00.0 Ethernet controller: Broadcom Corporation NetLink BCM57780
> Gigabit Ethernet PCIe (rev 01)
> Subsystem: Acer Incorporated [ALI] Device 036d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 28
> Region 0: Memory at b3400000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [48] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> Capabilities: [60] Vendor Specific Information: Len=6c <?>
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0100c  Data: 4142
> Capabilities: [cc] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
> ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <1us, L1 <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [13c v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 88-ae-1d-ff-fe-86-97-b9
> Capabilities: [16c v1] Power Budgeting <?>
> Kernel driver in use: tg3
> 
> 02:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network
> Adapter (PCI-Express) (rev 01)
> Subsystem: Foxconn International, Inc. Device e034
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 17
> Region 0: Memory at b2400000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <512ns, L1 <64us
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
> Not Supported
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
> Capabilities: [170 v1] Power Budgeting <?>
> Kernel driver in use: ath9k
> 
> ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath
> Architecture Generic Non-core Registers (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath
> Architecture System Address Decoder (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> ff:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> ff:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
> Subsystem: Acer Incorporated [ALI] Device 0487
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> 
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Hitachi HTS54502 Rev: C60F
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: HL-DT-ST Model: DVDRAM GT30N     Rev: 1.01
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> 
> [7.7.] Other information that might be relevant to the problem (please
> look in /proc and include all information that you think to be
> relevant):
> 1     1163  1388  144   148   1579  1712  1945  2068  23    27    36
> 45   647  725        cgroups      iomem       misc          swaps
> 10    12    139   1443  15    1593  1717  2     21    2315  2767  366
> 46   65   758        cmdline      ioports     modules       sys
> 1009  1220  1390  1447  1510  16    1753  20    2128  2383  28    367
> 5    66   8          consoles     irq         mounts
> sysrq-trigger
> 1022  1279  1399  145   1525  1623  1757  2014  2130  24    288   368
> 514  662  85         cpuinfo      kallsyms    mtrr          sysvipc
> 1024  1288  14    1450  1527  165   1784  2022  2138  2414  29    37
> 543  678  86         crypto       kcore       net
> thread-self
> 1070  13    140   1451  1559  166   1793  2023  2148  2434  294   38
> 58   679  872        devices      keys        pagetypeinfo  timer_list
> 1074  1300  1405  1456  1562  1667  1797  2026  2167  2484  3     39
> 583  689  874        diskstats    key-users   partitions
> timer_stats
> 1079  1310  141   1458  1564  1672  18    2027  2178  25    30    40
> 60   699  877        dma          kmsg        sched_debug   tty
> 1080  1314  1410  146   1565  1679  19    2030  2182  2507  31    404
> 61   7    878        driver       kpagecount  schedstat     uptime
> 1083  1323  1412  1460  1567  1680  1906  2037  2195  2517  32    407
> 616  700  9          execdomains  kpageflags  scsi          version
> 11    137   1413  1462  1571  1681  1918  2050  22    2519  33    408
> 627  704  acpi       fb           loadavg     self
> vmallocinfo
> 1124  1375  1415  1464  1572  1682  1924  2062  2245  2550  34    42
> 63   710  asound     filesystems  locks       slabinfo      vmstat
> 1143  138   142   1466  1573  1683  1934  2063  2270  26    35    436
> 640  720  buddyinfo  fs           mdstat      softirqs      zoneinfo
> 1156  1384  143   1476  1575  17    1940  2067  2283  2666  355   44
> 644  722  bus        interrupts   meminfo     stat
> 
> 
> [X.] Other notes, patches, fixes, workarounds:
> 
> Original reported at the Ubuntu bug tracker at:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1399611
> 
> Workaround:
> http://askubuntu.com/a/450594
> 
> Thanks for your time!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

