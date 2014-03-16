From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [HP Pavilion dm3-1109tu Entertainment Notebook PC] Brightness
 Keys not working after restarting system from Windows 7
Date: Sun, 16 Mar 2014 13:39:18 +0800
Message-ID: <CAOLK0pyOXex2pVyWqRd2Frhqyi1iAeyEP9sVzHSOGVB6skvRvw@mail.gmail.com>
References: <1394861064.66124.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:46727 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaCPFjT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Mar 2014 01:39:19 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so4608087qcx.20
        for <linux-acpi@vger.kernel.org>; Sat, 15 Mar 2014 22:39:18 -0700 (PDT)
In-Reply-To: <1394861064.66124.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ign_christian@yahoo.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi:
      Could you apply a new bug on the https://bugzilla.kernel.org?

2014-03-15 13:24 GMT+08:00  <ign_christian@yahoo.com>:
> [1.] One line summary of the problem:
> [HP Pavilion dm3-1109tu Entertainment Notebook PC] Brightness Keys not working after restarting system from Windows 7
>
> [2.] Full description of the problem/report:
> After I start system to Windows 7 then restart my laptop (soft reboot) to Ubuntu 12.04, brightness keys not working and reset to 100%.
>
> Restart & restart again to Ubuntu not make brightness keys working.
>
> WORKAROUND: Shutdown laptop then power on again to Ubuntu (hard reboot), or manually change brightnes via System Settings > Brightness & Lock.
>
> [3.] Keywords (i.e., modules, networking, kernel): -
>
> [4.] Kernel version (from /proc/version):
>
> $ cat /proc/version
> Linux version 3.14.0-031400rc6-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201403100035 SMP Mon Mar 10 04:57:43 UTC 2014
>
> [5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt)
> I don't whether it's relevant, while booting & after selecting kernel following messange appear (not happen in original Precise kernel) :
>
> [ 1,695383] ACPI: [Package] has zero elements (f72dab40)
>
> Note: that code/number changes in another boot, and there is also another message after the message that I couldn't catch
>
> [6.] A small shell script or example program which triggers the problem (if possible)
> -
>
> [7.] Environment
> $ lsb_release -rd
> Description:Ubuntu 12.04.4 LTS
> Release:12.04
>
> [7.1.] Software (add the output of the ver_linux script here)
>
> $ sh ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux ubuntu 3.14.0-031400rc6-generic #201403100035 SMP Mon Mar 10 04:57:43 UTC 2014 i686 i686 i386 GNU/Linux
>
> Gnu C                  4.6
> Gnu make               3.81
> binutils               2.22
> util-linux             2.20.1
> mount                  support
> module-init-tools      3.16
> e2fsprogs              1.42
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.15
> Dynamic linker (ldd)   2.15
> Procps                 3.2.8
> Net-tools              1.60
> Kbd                    1.15.2
> Sh-utils               8.13
> wireless-tools         30
> Modules Loaded         ctr ccm nls_utf8 cifs fscache xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT xt_LOG xt_multiport xt_limit snd_hda_codec_hdmi xt_tcpudp xt_addrtype snd_hda_codec_idt snd_hda_codec_generic nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ip6table_filter ip6_tables arc4 nf_conntrack_netbios_ns ath9k snd_hda_intel nf_conntrack_broadcast nf_nat_ftp snd_hda_codec bnep mac80211 nf_nat rfcomm nf_conntrack_ftp nf_conntrack snd_hwdep uvcvideo bluetooth snd_pcm iptable_filter snd_seq_midi videobuf2_core ath9k_common ip_tables snd_rawmidi i915 ath9k_hw videodev snd_seq_midi_event 6lowpan_iphc x_tables snd_seq videobuf2_vmalloc parport_pc snd_timer videobuf2_memops snd_seq_device ppdev ath hp_wmi psmouse sparse_keymap drm_kms_helper drm hp_accel cfg80211 serio_raw lis3lv02d
  lpc_ich snd i2c_algo_bit joydev soundcore input_polldev wmi video mac_hid binfmt_misc lp parport hid_generic usbhid hid ahci libahci r8169 mii
>
> [7.2.] Processor information (from /proc/cpuinfo):
>
> $ cat /proc/cpuinfo
> processor: 0
> vendor_id: GenuineIntel
> cpu family: 6
> model: 23
> model name: Genuine Intel(R) CPU           U4100  @ 1.30GHz
> stepping: 10
> microcode: 0xa07
> cpu MHz: 1200.000
> cache size: 2048 KB
> physical id: 0
> siblings: 2
> core id: 0
> cpu cores: 2
> apicid: 0
> initial apicid: 0
> fdiv_bug: no
> f00f_bug: no
> coma_bug: no
> fpu: yes
> fpu_exception: yes
> cpuid level: 13
> wp: yes
> flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm xsave lahf_lm dtherm
> bogomips: 2593.36
> clflush size: 64
> cache_alignment: 64
> address sizes: 36 bits physical, 48 bits virtual
> power management:
>
> processor: 1
> vendor_id: GenuineIntel
> cpu family: 6
> model: 23
> model name: Genuine Intel(R) CPU           U4100  @ 1.30GHz
> stepping: 10
> microcode: 0xa07
> cpu MHz: 1200.000
> cache size: 2048 KB
> physical id: 0
> siblings: 2
> core id: 1
> cpu cores: 2
> apicid: 1
> initial apicid: 1
> fdiv_bug: no
> f00f_bug: no
> coma_bug: no
> fpu: yes
> fpu_exception: yes
> cpuid level: 13
> wp: yes
> flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm xsave lahf_lm dtherm
> bogomips: 2593.36
> clflush size: 64
> cache_alignment: 64
> address sizes: 36 bits physical, 48 bits virtual
> power management:
>
> [7.3.] Module information (from /proc/modules):
> $ cat /proc/modules
>
> ctr 13025 2 - Live 0x00000000
> ccm 17596 2 - Live 0x00000000
> nls_utf8 12493 0 - Live 0x00000000
> cifs 421541 0 - Live 0x00000000
> fscache 57040 1 cifs, Live 0x00000000
> xt_hl 12465 6 - Live 0x00000000
> ip6t_rt 13259 3 - Live 0x00000000
> nf_conntrack_ipv6 18458 7 - Live 0x00000000
> nf_defrag_ipv6 26297 1 nf_conntrack_ipv6, Live 0x00000000
> ipt_REJECT 12515 1 - Live 0x00000000
> xt_LOG 17542 9 - Live 0x00000000
> xt_multiport 12694 4 - Live 0x00000000
> xt_limit 12541 12 - Live 0x00000000
> snd_hda_codec_hdmi 46041 1 - Live 0x00000000
> xt_tcpudp 12788 22 - Live 0x00000000
> xt_addrtype 12625 4 - Live 0x00000000
> snd_hda_codec_idt 49394 1 - Live 0x00000000
> snd_hda_codec_generic 63224 1 snd_hda_codec_idt, Live 0x00000000
> nf_conntrack_ipv4 14361 7 - Live 0x00000000
> nf_defrag_ipv4 12649 1 nf_conntrack_ipv4, Live 0x00000000
> xt_state 12514 14 - Live 0x00000000
> ip6table_filter 12711 1 - Live 0x00000000
> ip6_tables 18135 1 ip6table_filter, Live 0x00000000
> arc4 12509 2 - Live 0x00000000
> nf_conntrack_netbios_ns 12585 0 - Live 0x00000000
> ath9k 149810 0 - Live 0x00000000
> snd_hda_intel 43398 3 - Live 0x00000000
> nf_conntrack_broadcast 12541 1 nf_conntrack_netbios_ns, Live 0x00000000
> nf_nat_ftp 12692 0 - Live 0x00000000
> snd_hda_codec 119362 4 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_codec_generic,snd_hda_intel, Live 0x00000000
> bnep 19107 2 - Live 0x00000000
> mac80211 582807 1 ath9k, Live 0x00000000
> nf_nat 21081 1 nf_nat_ftp, Live 0x00000000
> rfcomm 59012 0 - Live 0x00000000
> nf_conntrack_ftp 14117 1 nf_nat_ftp, Live 0x00000000
> nf_conntrack 87867 8 nf_conntrack_ipv6,nf_conntrack_ipv4,xt_state,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ftp, Live 0x00000000
> snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
> uvcvideo 72275 0 - Live 0x00000000
> bluetooth 375778 10 bnep,rfcomm, Live 0x00000000
> snd_pcm 96053 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x00000000
> iptable_filter 12706 1 - Live 0x00000000
> snd_seq_midi 13132 0 - Live 0x00000000
> videobuf2_core 39843 1 uvcvideo, Live 0x00000000
> ath9k_common 13359 1 ath9k, Live 0x00000000
> ip_tables 18303 1 iptable_filter, Live 0x00000000
> snd_rawmidi 25198 1 snd_seq_midi, Live 0x00000000
> i915 737884 5 - Live 0x00000000
> ath9k_hw 438878 2 ath9k,ath9k_common, Live 0x00000000
> videodev 122418 2 uvcvideo,videobuf2_core, Live 0x00000000
> snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
> 6lowpan_iphc 18480 1 bluetooth, Live 0x00000000
> x_tables 22180 13 xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_multiport,xt_limit,xt_tcpudp,xt_addrtype,xt_state,ip6table_filter,ip6_tables,iptable_filter,ip_tables, Live 0x00000000
> snd_seq 55716 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
> videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
> parport_pc 32114 0 - Live 0x00000000
> snd_timer 28971 2 snd_pcm,snd_seq, Live 0x00000000
> videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
> snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
> ppdev 17423 0 - Live 0x00000000
> ath 24509 3 ath9k,ath9k_common,ath9k_hw, Live 0x00000000
> hp_wmi 17834 0 - Live 0x00000000
> psmouse 97104 0 - Live 0x00000000
> sparse_keymap 13658 1 hp_wmi, Live 0x00000000
> drm_kms_helper 47293 1 i915, Live 0x00000000
> drm 249035 6 i915,drm_kms_helper, Live 0x00000000
> hp_accel 25756 0 - Live 0x00000000
> cfg80211 447796 3 ath9k,mac80211,ath, Live 0x00000000
> serio_raw 13230 0 - Live 0x00000000
> lis3lv02d 19600 1 hp_accel, Live 0x00000000
> lpc_ich 16987 0 - Live 0x00000000
> snd 61456 18 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, Live 0x00000000
> i2c_algo_bit 13316 1 i915, Live 0x00000000
> joydev 17299 0 - Live 0x00000000
> soundcore 12600 1 snd, Live 0x00000000
> input_polldev 13648 1 lis3lv02d, Live 0x00000000
> wmi 18827 1 hp_wmi, Live 0x00000000
> video 19330 1 i915, Live 0x00000000
> mac_hid 13077 0 - Live 0x00000000
> binfmt_misc 13172 1 - Live 0x00000000
> lp 13359 0 - Live 0x00000000
> parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
> hid_generic 12492 0 - Live 0x00000000
> usbhid 47406 0 - Live 0x00000000
> hid 87718 2 hid_generic,usbhid, Live 0x00000000
> ahci 29802 1 - Live 0x00000000
> libahci 30899 1 ahci, Live 0x00000000
> r8169 62856 0 - Live 0x00000000
> mii 13693 1 r8169, Live 0x00000000
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>
> $ cat /proc/ioports
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>   03c0-03df : vesafb
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0460-047f : iTCO_wdt
>   0500-053f : pnp 00:00
>   0600-060f : pnp 00:00
>   0610-0610 : pnp 00:00
>   0800-080f : pnp 00:00
>   0810-0817 : pnp 00:00
>   0820-0823 : pnp 00:00
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   164e-164f : pnp 00:00
>   2000-2fff : PCI Bus 0000:02
>     2000-20ff : 0000:02:00.0
>       2000-20ff : r8169
>   3000-3fff : PCI Bus 0000:01
>   4000-401f : 0000:00:1f.3
>   4020-403f : 0000:00:1f.2
>     4020-403f : ahci
>   4040-405f : 0000:00:1d.2
>     4040-405f : uhci_hcd
>   4060-407f : 0000:00:1d.1
>     4060-407f : uhci_hcd
>   4080-409f : 0000:00:1d.0
>     4080-409f : uhci_hcd
>   40a0-40bf : 0000:00:1a.2
>     40a0-40bf : uhci_hcd
>   40c0-40df : 0000:00:1a.0
>     40c0-40df : uhci_hcd
>   40e0-40e7 : 0000:00:1f.2
>     40e0-40e7 : ahci
>   40e8-40ef : 0000:00:1f.2
>     40e8-40ef : ahci
>   40f0-40f7 : 0000:00:02.0
>   40f8-40fb : 0000:00:1f.2
>     40f8-40fb : ahci
>   40fc-40ff : 0000:00:1f.2
>     40fc-40ff : ahci
>
> $ cat /proc/iomem
> 00000000-00000fff : reserved
> 00001000-0009dfff : System RAM
> 0009e000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
>   000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-79bcefff : System RAM
>   01000000-0169cfb4 : Kernel code
>   0169cfb5-01a16e7f : Kernel data
>   01afd000-01be1fff : Kernel bss
> 79bcf000-79bd0fff : ACPI Non-volatile Storage
> 79bd1000-7ba6afff : System RAM
> 7ba6b000-7babefff : reserved
> 7babf000-7bb7ffff : System RAM
> 7bb80000-7bbbefff : ACPI Non-volatile Storage
> 7bbbf000-7bbddfff : System RAM
> 7bbde000-7bbf6fff : ACPI Tables
> 7bbf7000-7bbfffff : System RAM
> 7bc00000-7fffffff : reserved
>   7c000000-7fffffff : Graphics Stolen Memory
> 80000000-febfffff : PCI Bus 0000:00
>   80000000-8fffffff : 0000:00:02.0
>   90000000-903fffff : 0000:00:02.0
>   90400000-913fffff : PCI Bus 0000:01
>   91400000-923fffff : PCI Bus 0000:02
>     91400000-9140ffff : 0000:02:00.0
>       91400000-9140ffff : r8169
>     91410000-91410fff : 0000:02:00.0
>       91410000-91410fff : r8169
>     91420000-9143ffff : 0000:02:00.0
>   92400000-924fffff : 0000:00:02.1
>   92500000-934fffff : PCI Bus 0000:02
>   93500000-944fffff : PCI Bus 0000:01
>     93500000-9350ffff : 0000:01:00.0
>       93500000-9350ffff : ath9k
>   94500000-94503fff : 0000:00:1b.0
>     94500000-94503fff : ICH HD audio
>   94504000-94504fff : 0000:00:1f.6
>   94505000-945057ff : 0000:00:1f.2
>     94505000-945057ff : ahci
>   94505800-94505bff : 0000:00:1d.7
>     94505800-94505bff : ehci_hcd
>   94505c00-94505fff : 0000:00:1a.7
>     94505c00-94505fff : ehci_hcd
>   94506000-945060ff : 0000:00:1f.3
>   94507000-94507fff : Intel Flush Page
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:00
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
> fed10000-fed13fff : reserved
>   fed10000-fed13fff : pnp 00:00
> fed18000-fed19fff : reserved
>   fed18000-fed18fff : pnp 00:00
>   fed19000-fed19fff : pnp 00:00
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:00
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:00
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:00
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
>     fee00000-fee00fff : pnp 00:00
> ffe00000-ffffffff : reserved
>
> [7.5.] PCI information ('lspci -vvv' as root)
>
> $ sudo lspci -vvv
> [sudo] password for christian:
> 00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0a <?>
> Kernel driver in use: agpgart-intel
>
> 00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 44
> Region 0: Memory at 90000000 (64-bit, non-prefetchable) [size=4M]
> Region 2: Memory at 80000000 (64-bit, prefetchable) [size=256M]
> Region 4: I/O ports at 40f0 [size=8]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0100c  Data: 41e1
> Capabilities: [d0] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: i915
> Kernel modules: i915
>
> 00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Region 0: Memory at 92400000 (64-bit, non-prefetchable) [size=1M]
> Capabilities: [d0] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>
> 00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 4: I/O ports at 40c0 [size=32]
> Capabilities: [50] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: uhci_hcd
>
> 00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 03) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin C routed to IRQ 18
> Region 4: I/O ports at 40a0 [size=32]
> Capabilities: [50] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: uhci_hcd
>
> 00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at 94505c00 (32-bit, non-prefetchable) [size=1K]
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
> 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 45
> Region 0: Memory at 94500000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0100c  Data: 4142
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE- FLReset+
> DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap:Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl:ASPM Disabled; Disabled- Retrain- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta:Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> Capabilities: [100 v1] Virtual Channel
> Caps:LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:Fixed- WRR32- WRR64- WRR128-
> Ctrl:ArbSelect=Fixed
> Status:InProgress-
> VC0:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=0 ArbSelect=Fixed TC/VC=7f
> Status:NegoPending- InProgress-
> VC1:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=1 ArbSelect=Fixed TC/VC=80
> Status:NegoPending- InProgress-
> Capabilities: [130 v1] Root Complex Link
> Desc:PortNumber=0f ComponentID=02 EltType=Config
> Link0:Desc:TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
> Addr:00000000fed1c000
> Kernel driver in use: snd_hda_intel
> Kernel modules: snd-hda-intel
>
> 00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: 00003000-00003fff
> Memory behind bridge: 93500000-944fffff
> Prefetchable memory behind bridge: 0000000090400000-00000000913fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap:Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl:ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #0, PowerLimit 6.500W; Interlock- NoCompl-
> SltCtl:Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0300c  Data: 41a1
> Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3649
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Virtual Channel
> Caps:LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:Fixed+ WRR32- WRR64- WRR128-
> Ctrl:ArbSelect=Fixed
> Status:InProgress-
> VC0:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status:NegoPending- InProgress-
> Capabilities: [180 v1] Root Complex Link
> Desc:PortNumber=01 ComponentID=02 EltType=Config
> Link0:Desc:TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
> Addr:00000000fed1c000
> Kernel driver in use: pcieport
> Kernel modules: shpchp
>
> 00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> I/O behind bridge: 00002000-00002fff
> Memory behind bridge: 92500000-934fffff
> Prefetchable memory behind bridge: 0000000091400000-00000000923fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta:CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap:Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl:ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> SltCap:AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
> SltCtl:Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq- LinkChg+
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0300c  Data: 41b1
> Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3649
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v1] Virtual Channel
> Caps:LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:Fixed+ WRR32- WRR64- WRR128-
> Ctrl:ArbSelect=Fixed
> Status:InProgress-
> VC0:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status:NegoPending- InProgress-
> Capabilities: [180 v1] Root Complex Link
> Desc:PortNumber=03 ComponentID=02 EltType=Config
> Link0:Desc:TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
> Addr:00000000fed1c000
> Kernel driver in use: pcieport
> Kernel modules: shpchp
>
> 00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 20
> Region 4: I/O ports at 4080 [size=32]
> Capabilities: [50] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: uhci_hcd
>
> 00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 19
> Region 4: I/O ports at 4060 [size=32]
> Capabilities: [50] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: uhci_hcd
>
> 00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin D routed to IRQ 16
> Region 4: I/O ports at 4040 [size=32]
> Capabilities: [50] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: uhci_hcd
>
> 00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 20
> Region 0: Memory at 94505800 (32-bit, non-prefetchable) [size=1K]
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
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93) (prog-if 01 [Subtractive decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [50] Subsystem: Hewlett-Packard Company Device 3649
>
> 00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller (rev 03)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: lpc_ich
> Kernel modules: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM (ICH9M/ICH9M-E) 4 port SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 43
> Region 0: I/O ports at 40e8 [size=8]
> Region 1: I/O ports at 40fc [size=4]
> Region 2: I/O ports at 40e0 [size=8]
> Region 3: I/O ports at 40f8 [size=4]
> Region 4: I/O ports at 4020 [size=32]
> Region 5: Memory at 94505000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
> Address: fee0100c  Data: 41d1
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
> Capabilities: [b0] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ahci
> Kernel modules: ahci
>
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 5
> Region 0: Memory at 94506000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at 4000 [size=32]
> Kernel modules: i2c-i801
>
> 00:1f.6 Signal processing controller: Intel Corporation 82801I (ICH9 Family) Thermal Subsystem (rev 03)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 5
> Region 0: Memory at 94504000 (64-bit, non-prefetchable) [size=4K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> 01:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network Adapter (PCI-Express) (rev 01)
> Subsystem: Hewlett-Packard Company U98Z062.12 802.11bgn Wireless Half-size Mini PCIe Card
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at 93500000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
> DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl:ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
>  Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>  Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB
> Capabilities: [100 v1] Advanced Error Reporting
> UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta:RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps:LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:Fixed- WRR32- WRR64- WRR128-
> Ctrl:ArbSelect=Fixed
> Status:InProgress-
> VC0:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status:NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
> Capabilities: [170 v1] Power Budgeting <?>
> Kernel driver in use: ath9k
> Kernel modules: ath9k
>
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 02)
> Subsystem: Hewlett-Packard Company Device 3649
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 42
> Region 0: I/O ports at 2000 [size=256]
> Region 2: Memory at 91410000 (64-bit, prefetchable) [size=4K]
> Region 4: Memory at 91400000 (64-bit, prefetchable) [size=64K]
> Expansion ROM at 91420000 [disabled] [size=128K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0300c  Data: 41c1
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <2us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl:Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta:CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap:Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl:ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta:Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
>  Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>  Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB
> Capabilities: [ac] MSI-X: Enable- Count=2 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800
> Capabilities: [cc] Vital Product Data
> Unknown small resource type 00, will not decode more.
> Capabilities: [100 v1] Advanced Error Reporting
> UESta:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk:DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta:RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk:RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap:First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps:LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:Fixed- WRR32- WRR64- WRR128-
> Ctrl:ArbSelect=Fixed
> Status:InProgress-
> VC0:Caps:PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status:NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 01-00-00-00-ff-ff-00-00
> Kernel driver in use: r8169
> Kernel modules: r8169
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
>
> $ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD3200BEKT-6 Rev: 12.0
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>
> [7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant):
> $ ls /proc
>
> 1     1159  140   17    1857  1888  1928  20    2229  2356  2495  279  485  709  897        cmdline      fs          latency_stats  partitions     sysvipc
> 10    1168  1418  1714  1865  19    1938  2099  2230  236   2496  28   489  728  9          consoles     interrupts  loadavg        sched_debug    timer_list
> 1073  12    1420  1757  1866  1901  1943  21    2231  237   25    280  49   741  909        cpuinfo      iomem       locks          schedstat      timer_stats
> 1081  1201  1423  1784  1872  1903  1947  2120  2235  238   2552  29   5    768  936        crypto       ioports     mdstat         scsi           tty
> 11    1235  1438  1795  1873  1904  1951  2171  2236  239   26    3    537  796  952        devices      irq         meminfo        self           uptime
> 1103  1254  1442  18    1878  1909  1958  2186  2283  24    2667  33   627  8    983        diskstats    kallsyms    misc           slabinfo       version
> 1108  1257  1449  1831  1880  1911  1967  2194  23    240   2681  34   628  807  acpi       dma          kcore       modules        softirqs       vmallocinfo
> 1110  1295  1458  1834  1881  1919  1973  22    233   241   27    35   680  838  asound     driver       key-users   mounts         stat           vmstat
> 1148  13    15    1835  1882  1921  1995  2202  234   243   270   36   69   848  buddyinfo  execdomains  kmsg        mtrr           swaps          zoneinfo
> 1150  1385  1571  1847  1883  1926  1999  2208  235   2457  2701  37   7    849  bus        fb           kpagecount  net            sys
> 1151  14    16    1855  1887  1927  2     2224  2352  2491  277   4    70   888  cgroups    filesystems  kpageflags  pagetypeinfo   sysrq-trigger
>
> [X.] Other notes, patches, fixes, workarounds:
> Please provide a link to your Launchpad bug report.
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1155169
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
