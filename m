From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: Upstream testing of bug 1069144 about Toshiba brightness control
 after wakeup
Date: Thu, 30 May 2013 20:45:30 +0800
Message-ID: <51A749EA.8000908@gmail.com>
References: <51A4BD55.8030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:38797 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab3E3MpU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 May 2013 08:45:20 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so286448pbc.15
        for <linux-acpi@vger.kernel.org>; Thu, 30 May 2013 05:45:19 -0700 (PDT)
In-Reply-To: <51A4BD55.8030004@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: To Do <entodoays@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 05/28/2013 10:21 PM, To Do wrote:
> Dear Sirs,
> 
> I've gone through the upstream kernel testing procedure as strictly as 
> possible and here are the results of the tests done.
> 
> I hope this helps render Linux and Ubuntu and better product.

Thanks for the report.
Can you please file a bug to https://bugzilla.kernel.org?
Please also attach acpidump output there.

BTW, I have a Toshiba laptop that has a similar problem, the backlight
control interface for acpi_video and toshiba doesn't work after
a S3 cycle. I checked my system, it uses SMI to handle backlight, it's
normally not easy to solve such bugs.

But since the intel_backlight interface always works, we can solve
the problem in another way.

Thanks,
Aaron

> 
> Regards,
> 
> To Do
> 
> Test Results:
> ----------------
> 1. One line summary of the problem:
> [Toshiba Satellite R830] brightness control works until sleep
> 
> 2. Full description of the problem/report:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1069144
> On my Toshiba Satellite R830, I have 13.04 AMD64. The Fn + F6, Fn + F7 
> buttons reduce/increase the brightness level of the screen. The issue is 
> that they stop working after waking my computer from sleep. When this 
> happens I cannot even control brightness by going to "System 
> Settings/Brightness and Lock". I had Ubuntu 12.04 and 12.10 installed 
> before and I had the same identical problem.
> 
> With the two previous versions of Ubuntu (and hence kernels 3.2.0 and 
> 3.5.0) there was a workaround:
> WORKAROUND: I modified /etc/default/grub changing the line:
> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
> 
> to:
> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_osi=Linux 
> acpi_backlight=vendor"
> 
> Then updated grub with:
> sudo update-grub
> 
> and the problem was solved.
> 
> This workaround does not work with 13.04. Furthermore I noticed that 
> with Ubuntu 12.10 and hence the 3.5.0 kernel, adding 
> acpi_backlight=vendor increased the number of brightness levels. With 
> Ubuntu raring and the 3.8.0 kernel, this grub command no longer changes 
> the number of levels. However, it is doing something, because if I 
> remove this grub command, when I wake my computer from sleep, the 
> brightness level goes up to maximum, whereas with the Grub command it is 
> remembered.
> 
> I noticed that the brightness keys and brightness and lock settings 
> change the /sys/class/backlight/toshiba/brightness value. Now this no 
> longer has any effect on the actual brightness level after wakeup from 
> sleep. However /sys/class/backlight/intel_backlight/brightness is 
> associated with the actual brightness level, before and after wakeup 
> from sleep. If I change this value with echo 300 | sudo tee 
> /sys/class/backlight/intel_backlight/brightness, the level changes.
> 
> 3. Keywords
> Toshiba, brightness control, kernel
> 
> 4. Kernel version (from /proc/version):
> Linux version 3.10.0-031000rc3-generic (apw@gomeisa) (gcc version 4.6.3 
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201305261935 SMP Sun May 26 23:35:53 
> UTC 2013
> 
> 5. Output of Oops..
> No oops crash
> 
> 6. A simple shell script
> No script is needed. Simply put the laptop on sleep, wait a few seconds 
> and wake it from sleep.
> 
> 7. Environment
> Description:    Ubuntu 13.04
> Release:    13.04
> 
> 7.1 Software (add the output of the ver_linux script here)
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux chris-SATELLITE-R830 3.10.0-031000rc3-generic #201305261935 SMP 
> Sun May 26 23:35:53 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
> 
> Gnu C                  4.7
> Gnu make               3.81
> binutils               2.23.2
> util-linux             2.20.1
> mount                  support
> module-init-tools      9
> e2fsprogs              1.42.5
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.17
> Dynamic linker (ldd)   2.17
> Procps                 3.3.3
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.20
> wireless-tools         30
> Modules Loaded         bnep ath3k parport_pc btusb rfcomm ppdev 
> bluetooth binfmt_misc joydev snd_hda_codec_hdmi snd_hda_codec_realtek 
> uvcvideo arc4 snd_hda_intel intel_powerclamp coretemp ath9k ath9k_common 
> snd_hda_codec snd_hwdep snd_pcm kvm_intel i915 ath9k_hw snd_page_alloc 
> snd_seq_midi videobuf2_vmalloc ath drm_kms_helper videobuf2_memops kvm 
> videobuf2_core psmouse videodev crc32_pclmul ghash_clmulni_intel 
> aesni_intel snd_seq_midi_event aes_x86_64 lrw snd_rawmidi gf128mul 
> toshiba_acpi drm mac80211 snd_seq serio_raw sparse_keymap cfg80211 
> glue_helper ablk_helper cryptd video lpc_ich lp wmi toshiba_bluetooth 
> snd_seq_device i2c_algo_bit snd_timer snd mac_hid microcode parport 
> soundcore e1000e ptp pps_core ahci sdhci_pci libahci sdhci
> 
> 7.2. Processor information (from /proc/cpuinfo):
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 42
> model name    : Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
> stepping    : 7
> microcode    : 0x23
> cpu MHz        : 1125.000
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 2
> apicid        : 0
> initial apicid    : 0
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
> nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
> est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt 
> tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts 
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips    : 4988.61
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> processor    : 1
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 42
> model name    : Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
> stepping    : 7
> microcode    : 0x23
> cpu MHz        : 1125.000
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 2
> apicid        : 1
> initial apicid    : 1
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
> nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
> est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt 
> tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts 
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips    : 4988.61
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> processor    : 2
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 42
> model name    : Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
> stepping    : 7
> microcode    : 0x23
> cpu MHz        : 1125.000
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 1
> cpu cores    : 2
> apicid        : 2
> initial apicid    : 2
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
> nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
> est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt 
> tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts 
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips    : 4988.61
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> processor    : 3
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 42
> model name    : Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
> stepping    : 7
> microcode    : 0x23
> cpu MHz        : 1125.000
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 1
> cpu cores    : 2
> apicid        : 3
> initial apicid    : 3
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
> nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx 
> est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt 
> tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts 
> dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips    : 4988.61
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> 7.3. Module information (from /proc/modules):
> bnep 18258 2 - Live 0x0000000000000000
> ath3k 12968 0 - Live 0x0000000000000000
> parport_pc 32866 0 - Live 0x0000000000000000
> btusb 22581 0 - Live 0x0000000000000000
> rfcomm 47804 0 - Live 0x0000000000000000
> ppdev 17106 0 - Live 0x0000000000000000
> bluetooth 253071 12 bnep,ath3k,btusb,rfcomm, Live 0x0000000000000000
> binfmt_misc 17508 1 - Live 0x0000000000000000
> joydev 17526 0 - Live 0x0000000000000000
> snd_hda_codec_hdmi 41507 1 - Live 0x0000000000000000
> snd_hda_codec_realtek 47818 1 - Live 0x0000000000000000
> uvcvideo 82296 0 - Live 0x0000000000000000
> arc4 12573 2 - Live 0x0000000000000000
> snd_hda_intel 44464 3 - Live 0x0000000000000000
> intel_powerclamp 18950 0 - Live 0x0000000000000000
> coretemp 13596 0 - Live 0x0000000000000000
> ath9k 157135 0 - Live 0x0000000000000000
> ath9k_common 13859 1 ath9k, Live 0x0000000000000000
> snd_hda_codec 194558 3 
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live 
> 0x0000000000000000
> snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
> snd_pcm 102595 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
> 0x0000000000000000
> kvm_intel 143810 0 - Live 0x0000000000000000
> i915 636322 4 - Live 0x0000000000000000
> ath9k_hw 431507 2 ath9k,ath9k_common, Live 0x0000000000000000
> snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
> snd_seq_midi 13324 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13056 1 uvcvideo, Live 0x0000000000000000
> ath 24123 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
> drm_kms_helper 53178 1 i915, Live 0x0000000000000000
> videobuf2_memops 13202 1 videobuf2_vmalloc, Live 0x0000000000000000
> kvm 436329 1 kvm_intel, Live 0x0000000000000000
> videobuf2_core 40785 1 uvcvideo, Live 0x0000000000000000
> psmouse 102030 0 - Live 0x0000000000000000
> videodev 131387 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
> crc32_pclmul 13160 0 - Live 0x0000000000000000
> ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
> aesni_intel 55720 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13294 1 aesni_intel, Live 0x0000000000000000
> snd_rawmidi 30416 1 snd_seq_midi, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> toshiba_acpi 18774 0 - Live 0x0000000000000000
> drm 295600 5 i915,drm_kms_helper, Live 0x0000000000000000
> mac80211 615833 1 ath9k, Live 0x0000000000000000
> snd_seq 61930 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> serio_raw 13253 0 - Live 0x0000000000000000
> sparse_keymap 13890 1 toshiba_acpi, Live 0x0000000000000000
> cfg80211 495341 3 ath9k,ath,mac80211, Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> cryptd 20501 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
> 0x0000000000000000
> video 19574 1 i915, Live 0x0000000000000000
> lpc_ich 17060 0 - Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> wmi 19256 1 toshiba_acpi, Live 0x0000000000000000
> toshiba_bluetooth 12852 0 - Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
> 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 69437 16 
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
> Live 0x0000000000000000
> mac_hid 13253 0 - Live 0x0000000000000000
> microcode 22922 0 - Live 0x0000000000000000
> parport 42432 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> soundcore 12680 1 snd, Live 0x0000000000000000
> e1000e 211206 0 - Live 0x0000000000000000
> ptp 18627 1 e1000e, Live 0x0000000000000000
> pps_core 14080 1 ptp, Live 0x0000000000000000
> ahci 30063 3 - Live 0x0000000000000000
> sdhci_pci 18720 0 - Live 0x0000000000000000
> libahci 32088 1 ahci, Live 0x0000000000000000
> sdhci 33170 1 sdhci_pci, Live 0x0000000000000000
> 
> 7.4. Loaded driver and hardware information (/proc/ioports)
> 0000-0cf7 : PCI Bus 0000:00
>    0000-001f : dma1
>    0020-0021 : pic1
>    0040-0043 : timer0
>    0050-0053 : timer1
>    0060-0060 : keyboard
>    0064-0064 : keyboard
>    0070-0077 : rtc0
>    0080-008f : dma page reg
>    00a0-00a1 : pic2
>    00c0-00df : dma2
>    00f0-00ff : fpu
>    01e0-01e7 : pnp 00:05
>    0400-047f : pnp 00:04
>      0400-0403 : ACPI PM1a_EVT_BLK
>      0404-0405 : ACPI PM1a_CNT_BLK
>      0408-040b : ACPI PM_TMR
>      0410-0415 : ACPI CPU throttle
>      0420-042f : ACPI GPE0_BLK
>      0430-0433 : iTCO_wdt
>      0450-0450 : ACPI PM2_CNT_BLK
>      0460-047f : iTCO_wdt
>    0500-053f : pnp 00:04
>    0680-06ff : pnp 00:05
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>    1000-100f : pnp 00:04
>    2000-2fff : PCI Bus 0000:02
>    3000-303f : 0000:00:02.0
>    3040-305f : 0000:00:1f.2
>      3040-305f : ahci
>    3060-307f : 0000:00:19.0
>    3080-3087 : 0000:00:1f.2
>      3080-3087 : ahci
>    3088-308f : 0000:00:1f.2
>      3088-308f : ahci
>    3098-309b : 0000:00:1f.2
>      3098-309b : ahci
>    309c-309f : 0000:00:1f.2
>      309c-309f : ahci
>    4000-4fff : PCI Bus 0000:06
>    ffff-ffff : pnp 00:04
>      ffff-ffff : pnp 00:04
>      7.4. Loaded driver and hardware information (/proc/iomem)
> 00000000-00000fff : reserved
> 00001000-0009ebff : System RAM
> 0009ec00-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000cf1ff : Video ROM
> 000cf800-000d07ff : Adapter ROM
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000fffff : reserved
>    000f0000-000fffff : System ROM
> 00100000-1fffffff : System RAM
>    01000000-016d8d81 : Kernel code
>    016d8d82-01cf05ff : Kernel data
>    01e26000-01f7ffff : Kernel bss
> 20000000-201fffff : reserved
>    20000000-201fffff : pnp 00:09
> 20200000-3fffffff : System RAM
> 40000000-401fffff : reserved
>    40000000-401fffff : pnp 00:09
> 40200000-aa5cffff : System RAM
> aa5d0000-aa5d01ff : ACPI Non-volatile Storage
> aa5d0200-aa5d2fff : reserved
> aa5d3000-aa6cffff : ACPI Non-volatile Storage
> aa6d0000-aa6effff : ACPI Tables
> aa6f0000-af9fffff : reserved
> afa00000-feafffff : PCI Bus 0000:00
>    afa00000-afa00fff : pnp 00:00
>    afb00000-afcfffff : PCI Bus 0000:06
>    b0000000-bfffffff : 0000:00:02.0
>    c0000000-c03fffff : 0000:00:02.0
>    c0400000-c23fffff : PCI Bus 0000:02
>    c2400000-c24fffff : PCI Bus 0000:06
>    c2500000-c25fffff : PCI Bus 0000:05
>      c2500000-c2501fff : 0000:05:00.0
>        c2500000-c2501fff : xhci_hcd
>    c2600000-c26fffff : PCI Bus 0000:04
>      c2600000-c260ffff : 0000:04:00.0
>        c2600000-c260ffff : ath9k
>    c2700000-c46fffff : PCI Bus 0000:02
>    c4700000-c47fffff : PCI Bus 0000:01
>      c4700000-c47000ff : 0000:01:00.0
>        c4700000-c47000ff : mmc0
>    c4800000-c481ffff : 0000:00:19.0
>      c4800000-c481ffff : e1000e
>    c4820000-c4823fff : 0000:00:1b.0
>      c4820000-c4823fff : ICH HD audio
>    c4824000-c482400f : 0000:00:16.0
>      c4824000-c482400f : mei_me
>    c4827000-c48277ff : 0000:00:1f.2
>      c4827000-c48277ff : ahci
>    c4828000-c48283ff : 0000:00:1d.0
>      c4828000-c48283ff : ehci_hcd
>    c4829000-c48293ff : 0000:00:1a.0
>      c4829000-c48293ff : ehci_hcd
>    c482a000-c482afff : 0000:00:19.0
>      c482a000-c482afff : e1000e
>    f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>      f8000000-fbffffff : reserved
> feb00000-feb03fff : pnp 00:00
> fec00000-fec00fff : reserved
>    fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>    fed00000-fed003ff : pnp 00:02
> fed10000-fed19fff : reserved
>    fed10000-fed17fff : pnp 00:00
>    fed18000-fed18fff : pnp 00:00
>    fed19000-fed19fff : pnp 00:00
> fed1c000-fed1ffff : reserved
>    fed1c000-fed1ffff : pnp 00:00
>      fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:00
> fed40000-fed8ffff : pnp 00:00
> fee00000-fee00fff : Local APIC
>    fee00000-fee00fff : reserved
> ffc00000-ffffffff : reserved
> 100000000-14fdfffff : System RAM
> 14fe00000-14fffffff : RAM buffer
> 
> 7.5. PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor 
> Family DRAM Controller (rev 09)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>      Latency: 0
>      Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 
> 00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core 
> Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 
> [VGA controller])
>      Subsystem: Toshiba America Info Systems Device 0005
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin A routed to IRQ 48
>      Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=4M]
>      Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
>      Region 4: I/O ports at 3000 [size=64]
>      Expansion ROM at <unassigned> [disabled]
>      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>          Address: fee0f00c  Data: 4162
>      Capabilities: [d0] Power Management version 2
>          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [a4] PCI Advanced Features
>          AFCap: TP+ FLR+
>          AFCtrl: FLR-
>          AFStatus: TP-
>      Kernel driver in use: i915
> 
> 00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series 
> Chipset Family MEI Controller #1 (rev 04)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin A routed to IRQ 40
>      Region 0: Memory at c4824000 (64-bit, non-prefetchable) [size=16]
>      Capabilities: [50] Power Management version 3
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>          Address: 00000000fee0f00c  Data: 41b2
>      Kernel driver in use: mei_me
> 
> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network 
> Connection (rev 04)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin A routed to IRQ 49
>      Region 0: Memory at c4800000 (32-bit, non-prefetchable) [size=128K]
>      Region 1: Memory at c482a000 (32-bit, non-prefetchable) [size=4K]
>      Region 2: I/O ports at 3060 [size=32]
>      Capabilities: [c8] Power Management version 2
>          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>      Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>          Address: 00000000fee0f00c  Data: 4123
>      Capabilities: [e0] PCI Advanced Features
>          AFCap: TP+ FLR+
>          AFCtrl: FLR-
>          AFStatus: TP-
>      Kernel driver in use: e1000e
> 
> 00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset 
> Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin A routed to IRQ 16
>      Region 0: Memory at c4829000 (32-bit, non-prefetchable) [size=1K]
>      Capabilities: [50] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [58] Debug port: BAR=1 offset=00a0
>      Capabilities: [98] PCI Advanced Features
>          AFCap: TP+ FLR+
>          AFCtrl: FLR-
>          AFStatus: TP-
>      Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset 
> Family High Definition Audio Controller (rev 04)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 47
>      Region 0: Memory at c4820000 (64-bit, non-prefetchable) [size=16K]
>      Capabilities: [50] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>          Address: 00000000fee0f00c  Data: 41c2
>      Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
> MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE- FLReset+
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, 
> Latency L0 <64ns, L1 <1us
>              ClockPM- Surprise- LLActRep- BwNot-
>          LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- 
> DLActive- BWMgmt- ABWMgmt-
>      Capabilities: [100 v1] Virtual Channel
>          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>          Arb:    Fixed- WRR32- WRR64- WRR128-
>          Ctrl:    ArbSelect=Fixed
>          Status:    InProgress-
>          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>              Status:    NegoPending- InProgress-
>          VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>              Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=22
>              Status:    NegoPending- InProgress-
>      Capabilities: [130 v1] Root Complex Link
>          Desc:    PortNumber=0f ComponentID=00 EltType=Config
>          Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB- 
> LinkType=MemMapped LinkValid+
>              Addr:    00000000fed1c000
>      Kernel driver in use: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset 
> Family PCI Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>      I/O behind bridge: 0000f000-00000fff
>      Memory behind bridge: c4700000-c47fffff
>      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <512ns, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive+ BWMgmt+ ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
> Surprise-
>              Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
> Interlock-
>              Changed: MRL- PresDet- LinkState+
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -3.5dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset 
> Family PCI Express Root Port 2 (rev b4) (prog-if 00 [Normal decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
>      I/O behind bridge: 00002000-00002fff
>      Memory behind bridge: c2700000-c46fffff
>      Prefetchable memory behind bridge: 00000000c0400000-00000000c23fffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <1us, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
> Surprise+
>              Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
> Interlock-
>              Changed: MRL- PresDet- LinkState-
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -3.5dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Kernel driver in use: pcieport
> 
> 00:1c.2 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset 
> Family PCI Express Root Port 3 (rev b4) (prog-if 00 [Normal decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>      I/O behind bridge: 0000f000-00000fff
>      Memory behind bridge: c2600000-c26fffff
>      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <512ns, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive+ BWMgmt+ ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
> Surprise-
>              Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
> Interlock-
>              Changed: MRL- PresDet- LinkState+
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -3.5dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Kernel driver in use: pcieport
> 
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset 
> Family PCI Express Root Port 5 (rev b4) (prog-if 00 [Normal decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>      I/O behind bridge: 0000f000-00000fff
>      Memory behind bridge: c2500000-c25fffff
>      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <512ns, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive+ BWMgmt+ ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
> Surprise-
>              Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
> Interlock-
>              Changed: MRL- PresDet- LinkState+
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -6dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Kernel driver in use: pcieport
> 
> 00:1c.5 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset 
> Family PCI Express Root Port 6 (rev b4) (prog-if 00 [Normal decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>      I/O behind bridge: 00004000-00004fff
>      Memory behind bridge: c2400000-c24fffff
>      Prefetchable memory behind bridge: 00000000afb00000-00000000afcfffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <1us, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
> Surprise+
>              Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
> Interlock-
>              Changed: MRL- PresDet- LinkState-
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -3.5dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Kernel driver in use: pcieport
> 
> 00:1c.6 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev b4) 
> (prog-if 01 [Subtractive decode])
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
>      I/O behind bridge: 0000f000-00000fff
>      Memory behind bridge: fff00000-000fffff
>      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ <SERR- <PERR-
>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <64ns, L1 <1us
>              ExtTag- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #7, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <1us, L1 <16us
>              ClockPM- Surprise- LLActRep+ BwNot-
>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
> Surprise-
>              Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
> HPIrq- LinkChg-
>              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
> Interlock-
>              Changed: MRL- PresDet- LinkState-
>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
> CRSVisible-
>          RootCap: CRSVisible-
>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>          DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -3.5dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
>      Capabilities: [a0] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset 
> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin A routed to IRQ 23
>      Region 0: Memory at c4828000 (32-bit, non-prefetchable) [size=1K]
>      Capabilities: [50] Power Management version 2
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
>      Capabilities: [58] Debug port: BAR=1 offset=00a0
>      Capabilities: [98] PCI Advanced Features
>          AFCap: TP+ FLR+
>          AFCtrl: FLR-
>          AFStatus: TP-
>      Kernel driver in use: ehci-pci
> 
> 00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC 
> Controller (rev 04)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>      Kernel driver in use: lpc_ich
> 
> 00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset 
> Family 6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI 1.0])
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0
>      Interrupt: pin B routed to IRQ 46
>      Region 0: I/O ports at 3088 [size=8]
>      Region 1: I/O ports at 309c [size=4]
>      Region 2: I/O ports at 3080 [size=8]
>      Region 3: I/O ports at 3098 [size=4]
>      Region 4: I/O ports at 3040 [size=32]
>      Region 5: Memory at c4827000 (32-bit, non-prefetchable) [size=2K]
>      Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>          Address: fee0c00c  Data: 4122
>      Capabilities: [70] Power Management version 3
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>      Capabilities: [b0] PCI Advanced Features
>          AFCap: TP+ FLR+
>          AFCtrl: FLR-
>          AFStatus: TP-
>      Kernel driver in use: ahci
> 
> 01:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller 
> (rev 07) (prog-if 01)
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 16
>      Region 0: Memory at c4700000 (32-bit, non-prefetchable) [size=256]
>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>          Address: 0000000000000000  Data: 0000
>      Capabilities: [78] Power Management version 3
>          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>      Capabilities: [80] Express (v1) Endpoint, MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> unlimited, L1 unlimited
>              ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
> TransPend-
>          LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
> Latency L0 <4us, L1 unlimited
>              ClockPM+ Surprise- LLActRep- BwNot-
>          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>      Capabilities: [100 v1] Virtual Channel
>          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>          Arb:    Fixed- WRR32- WRR64- WRR128-
>          Ctrl:    ArbSelect=Fixed
>          Status:    InProgress-
>          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>              Status:    NegoPending- InProgress-
>      Capabilities: [800 v1] Advanced Error Reporting
>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>      Kernel driver in use: sdhci-pci
> 
> 04:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless 
> Network Adapter (PCI-Express) (rev 01)
>      Subsystem: Lite-On Communications Inc Device 6613
>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 18
>      Region 0: Memory at c2600000 (64-bit, non-prefetchable) [size=64K]
>      Capabilities: [40] Power Management version 3
>          Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
> PME(D0+,D1+,D2-,D3hot+,D3cold-)
>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
>          Address: 00000000  Data: 0000
>      Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> <512ns, L1 <64us
>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
> TransPend-
>          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
> Latency L0 <512ns, L1 <64us
>              ClockPM- Surprise- LLActRep- BwNot-
>          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>          DevCap2: Completion Timeout: Not Supported, TimeoutDis+
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
> SpeedDis-, Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -6dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [100 v1] Advanced Error Reporting
>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>          CESta:    RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr-
>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>      Capabilities: [140 v1] Virtual Channel
>          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>          Arb:    Fixed- WRR32- WRR64- WRR128-
>          Ctrl:    ArbSelect=Fixed
>          Status:    InProgress-
>          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>              Status:    NegoPending- InProgress-
>      Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
>      Capabilities: [170 v1] Power Budgeting <?>
>      Kernel driver in use: ath9k
> 
> 05:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host 
> Controller (rev 04) (prog-if 30 [XHCI])
>      Subsystem: Toshiba America Info Systems Device 0001
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 0, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 16
>      Region 0: Memory at c2500000 (64-bit, non-prefetchable) [size=8K]
>      Capabilities: [50] Power Management version 3
>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>      Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>          Address: 0000000000000000  Data: 0000
>      Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
>          Vector table: BAR=0 offset=00001000
>          PBA: BAR=0 offset=00001080
>      Capabilities: [a0] Express (v2) Endpoint, MSI 00
>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
> unlimited, L1 unlimited
>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
> Unsupported-
>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
> TransPend-
>          LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
> L0 <4us, L1 unlimited
>              ClockPM+ Surprise- LLActRep- BwNot-
>          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- 
> CommClk+
>              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>          LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
> DLActive- BWMgmt- ABWMgmt-
>          DevCap2: Completion Timeout: Not Supported, TimeoutDis+
>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
> Selectable De-emphasis: -6dB
>               Transmit Margin: Normal Operating Range, 
> EnterModifiedCompliance- ComplianceSOS-
>               Compliance De-emphasis: -6dB
>          LnkSta2: Current De-emphasis Level: -6dB, 
> EqualizationComplete-, EqualizationPhase1-
>               EqualizationPhase2-, EqualizationPhase3-, 
> LinkEqualizationRequest-
>      Capabilities: [100 v1] Advanced Error Reporting
>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>          AERCap:    First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
>      Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
>      Capabilities: [150 v1] Latency Tolerance Reporting
>          Max snoop latency: 0ns
>          Max no snoop latency: 0ns
>      Kernel driver in use: xhci_hcd
> 
> 7.6 SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>    Vendor: ATA      Model: TOSHIBA MK6475GS Rev: GT00
>    Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>    Vendor: MATSHITA Model: DVD-RAM UJ8B2E   Rev: 1.20
>    Type:   CD-ROM                           ANSI  SCSI revision: 05
> 
> 7.7 Other information that might be relevant to the problem (please look 
> in /proc and include all information that you think to be relevant):
> 
> cat /proc/acpi/toshiba/video
> lcd_out:                 0
> crt_out:                 0
> tv_out:                  0
> 
> cat /proc/acpi/toshiba/version
> driver:                  0.19
> proc_interface:          1
> 
> cat /proc/acpi/toshiba/lcd
> brightness:              0
> brightness_levels:       8
> 
> cat /proc/acpi/wakeup
> Device    S-state      Status   Sysfs node
> LANC      S4    *enabled   pci:0000:00:19.0
> HDEF      S3    *disabled  pci:0000:00:1b.0
> RP02      S4    *disabled  pci:0000:00:1c.1
> PXSX      S4    *disabled
> RP04      S4    *disabled
> PXSX      S4    *disabled
> USBB      S4    *disabled
> USBC      S4    *disabled
> EHC1      S4    *enabled   pci:0000:00:1d.0
> EHC2      S4    *enabled   pci:0000:00:1a.0
> PWRB      S4    *enabled
> LID      S4    *enabled
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

