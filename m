From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: PROBLEM: High CPU load after resuming on Samsung NP550P5C in BIOS
 mode (correct kernel version)
Date: Mon, 14 Oct 2013 16:17:06 +0800
Message-ID: <CAOLK0py_rrvBreNc4RW0JzFTDOwVQzM_=nv1a986rdRqb8rAZQ@mail.gmail.com>
References: <CADya715dcTZxej6_4VSyOdhpHKsVYH4tFCiWPaK4-nDtPOq7=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40467 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab3JNIRH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2013 04:17:07 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so13673535iec.2
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2013 01:17:06 -0700 (PDT)
In-Reply-To: <CADya715dcTZxej6_4VSyOdhpHKsVYH4tFCiWPaK4-nDtPOq7=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Barto <abarto@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013/10/14 Agustin Barto <abarto@gmail.com>:
> A few days ago I sent an email to this list describing an issue, but I
> wasn't running on the latest kernel while generating the report.
> Here's a new problem description, this time running on 3.12-rc4. I
> apologize for the inconvenience.
>
> [1.] One line summary of the problem:
>
> Interrupt storm after plugin a device into one of the USB3 after resume on
> a Samsung NP550P5C laptop.
>
> [2.] Full description of the problem/report:
>
> After I resume the system and plug something in one of the machine's USB3
> ports (it doesn't happen if I plug the same device on a USB2 port), the CPU
> load raises to over 50%, with one particular process with the highest load:
>
> 4 root 20 0 0 0 0 R 50.1 0.0 1:43.63 kworker/0:0
>
> The problem seems to be caused by too many ACPI interrupts:
>
> root@huayra:~# grep -r . /sys/firmware/acpi/interrupts/
> /sys/firmware/acpi/interrupts/sci: 7501945
> /sys/firmware/acpi/interrupts/error:       0
> /sys/firmware/acpi/interrupts/gpe00:       0   invalid
> /sys/firmware/acpi/interrupts/gpe01:       0   invalid
> /sys/firmware/acpi/interrupts/gpe02:       0   enabled
> /sys/firmware/acpi/interrupts/gpe03:       0   disabled
> /sys/firmware/acpi/interrupts/gpe04:       0   disabled
> /sys/firmware/acpi/interrupts/gpe05:       0   disabled
> /sys/firmware/acpi/interrupts/gpe06:       0   enabled
> /sys/firmware/acpi/interrupts/gpe07:       0   invalid
> /sys/firmware/acpi/interrupts/gpe08:       0   invalid
> /sys/firmware/acpi/interrupts/gpe09:       0   disabled
> /sys/firmware/acpi/interrupts/gpe10:       0   invalid
> /sys/firmware/acpi/interrupts/gpe11:       0   invalid
> /sys/firmware/acpi/interrupts/gpe12:       0   invalid
> /sys/firmware/acpi/interrupts/gpe13:       0   invalid
> /sys/firmware/acpi/interrupts/gpe14:       0   invalid
> /sys/firmware/acpi/interrupts/gpe15:       0   invalid
> /sys/firmware/acpi/interrupts/gpe16:       0   invalid
> /sys/firmware/acpi/interrupts/gpe0A:       0   invalid
> /sys/firmware/acpi/interrupts/gpe17:    1055   enabled
> /sys/firmware/acpi/interrupts/gpe0B:       0   disabled
> /sys/firmware/acpi/interrupts/gpe18:       0   invalid
> /sys/firmware/acpi/interrupts/gpe0C:       0   disabled
> /sys/firmware/acpi/interrupts/gpe19:       0   invalid
> /sys/firmware/acpi/interrupts/gpe0D: 7500959   enabled
> /sys/firmware/acpi/interrupts/gpe0E:       0   disabled
> /sys/firmware/acpi/interrupts/gpe20:       0   disabled
> /sys/firmware/acpi/interrupts/gpe0F:       0   invalid
> /sys/firmware/acpi/interrupts/gpe21:       0   invalid
> /sys/firmware/acpi/interrupts/gpe22:       0   invalid
> /sys/firmware/acpi/interrupts/gpe23:       0   invalid
> /sys/firmware/acpi/interrupts/gpe24:       0   invalid
> /sys/firmware/acpi/interrupts/gpe25:       0   disabled
> /sys/firmware/acpi/interrupts/gpe26:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1A:       0   invalid
> /sys/firmware/acpi/interrupts/gpe27:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1B:       0   invalid
> /sys/firmware/acpi/interrupts/gpe28:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1C:       0   invalid
> /sys/firmware/acpi/interrupts/gpe29:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1D:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1E:       0   enabled
> /sys/firmware/acpi/interrupts/gpe30:       0   invalid
> /sys/firmware/acpi/interrupts/gpe1F:       0   enabled
> /sys/firmware/acpi/interrupts/gpe31:       0   invalid
> /sys/firmware/acpi/interrupts/gpe32:       0   invalid
> /sys/firmware/acpi/interrupts/gpe33:       0   invalid
> /sys/firmware/acpi/interrupts/gpe34:       0   invalid
> /sys/firmware/acpi/interrupts/gpe35:       0   invalid
> /sys/firmware/acpi/interrupts/gpe36:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2A:       0   invalid
> /sys/firmware/acpi/interrupts/gpe37:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2B:       0   invalid
> /sys/firmware/acpi/interrupts/gpe38:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2C:       0   invalid
> /sys/firmware/acpi/interrupts/gpe39:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2D:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2E:       0   invalid
> /sys/firmware/acpi/interrupts/gpe2F:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3A:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3B:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3C:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3D:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3E:       0   invalid
> /sys/firmware/acpi/interrupts/gpe3F:       0   invalid
> /sys/firmware/acpi/interrupts/sci_not:       0
> /sys/firmware/acpi/interrupts/ff_pmtimer:       0   invalid
> /sys/firmware/acpi/interrupts/ff_rt_clk:       0   disabled
> /sys/firmware/acpi/interrupts/gpe_all: 7502044
> /sys/firmware/acpi/interrupts/ff_gbl_lock:       0   disabled
> /sys/firmware/acpi/interrupts/ff_pwr_btn:       0   enabled
> /sys/firmware/acpi/interrupts/ff_slp_btn:       0   invalid
>
> I can mitigate the problem by disabling that particular source
>
> # echo disable > /sys/firmware/acpi/interrupts/gpe0D
>
> The issue was introduced in kernel 3.9 and has been present ever since.
> Kernel 3.8 doesn't have the problem.
>
> [3.] Keywords (i.e., modules, networking, kernel):
>
> kernel, acpi
>
> [4.] Kernel version (from /proc/version):
>
> Linux version 3.12.0-031200rc4-generic (apw@gomeisa) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201310080738 SMP Tue Oct 8
> 11:40:45 UTC 201
>
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
>
> N/A
>
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
>
> N/A
>
> [7.] Environment
>
> Description: Ubuntu Saucy Salamander (development branch)
> Release: 13.10
>
> [7.1.] Software (add the output of the ver_linux script here)
>
> Linux huayra 3.12.0-031200rc4-generic #201310080738 SMP Tue Oct 8
> 11:40:45 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.23.52.20130913
> util-linux             2.20.1
> mount                  support
> module-init-tools      9
> e2fsprogs              1.42.8
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.17
> Dynamic linker (ldd)   2.17
> Procps                 3.3.3
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.20
> wireless-tools         30
> Modules Loaded         usb_storage deflate ctr twofish_generic
> twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common
> camellia_generic camellia_aesni_avx_x86_64 camellia_x86_64
> serpent_avx_x86_64 serpent_sse2_x86_64 xts serpent_generic
> blowfish_generic blowfish_x86_64 blowfish_common cast5_avx_x86_64
> cast5_generic cast_common des_generic cmac xcbc rmd160 crypto_null
> af_key xfrm_algo parport_pc ppdev bnep rfcomm snd_hda_codec_hdmi
> snd_hda_codec_realtek x86_pkg_temp_thermal intel_powerclamp joydev
> coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel aesni_intel arc4 aes_x86_64 iwldvm lrw
> snd_hda_intel gf128mul snd_hda_codec mac80211 glue_helper snd_hwdep
> ablk_helper cryptd snd_pcm i915 mei_me iwlwifi mxm_wmi snd_page_alloc
> btusb snd_seq_midi samsung_laptop mei snd_seq_midi_event snd_rawmidi
> snd_seq uvcvideo videobuf2_vmalloc videobuf2_memops snd_seq_device
> videobuf2_core cfg80211 psmouse videodev bluetooth drm_kms_helper lp
> lpc_ich snd_timer drm parport snd soundcore serio_raw i2c_algo_bit
> mac_hid wmi video microcode hid_logitech_dj usbhid hid ahci r8169
> libahci mii
>
> [7.2.] Processor information (from /proc/cpuinfo):
>
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3289.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 0
> cpu cores : 4
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3128.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 1
> cpu cores : 4
> apicid : 2
> initial apicid : 2
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3082.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 2
> cpu cores : 4
> apicid : 4
> initial apicid : 4
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3082.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 3
> cpu cores : 4
> apicid : 6
> initial apicid : 6
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 4
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3082.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 0
> cpu cores : 4
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 5
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3151.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 1
> cpu cores : 4
> apicid : 3
> initial apicid : 3
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 6
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3082.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 2
> cpu cores : 4
> apicid : 5
> initial apicid : 5
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> processor : 7
> vendor_id : GenuineIntel
> cpu family : 6
> model : 58
> model name : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz
> stepping : 9
> microcode : 0x17
> cpu MHz : 3082.000
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 3
> cpu cores : 4
> apicid : 7
> initial apicid : 7
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
> vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
> xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> smep erms
> bogomips : 4589.41
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>
> [7.3.] Module information (from /proc/modules):
>
> usb_storage 66714 1 - Live 0xffffffffa06f0000
> deflate 12617 0 - Live 0xffffffffa06eb000
> ctr 13193 0 - Live 0xffffffffa06e6000
> twofish_generic 16635 0 - Live 0xffffffffa06e0000
> twofish_avx_x86_64 46380 0 - Live 0xffffffffa06d3000
> twofish_x86_64_3way 27146 1 twofish_avx_x86_64, Live 0xffffffffa06c7000
> twofish_x86_64 12907 2 twofish_avx_x86_64,twofish_x86_64_3way, Live
> 0xffffffffa06c2000
> twofish_common 21113 4
> twofish_generic,twofish_avx_x86_64,twofish_x86_64_3way,twofish_x86_64,
> Live 0xffffffffa06bb000
> camellia_generic 29348 0 - Live 0xffffffffa06b2000
> camellia_aesni_avx_x86_64 27549 0 - Live 0xffffffffa06a6000
> camellia_x86_64 52986 1 camellia_aesni_avx_x86_64, Live 0xffffffffa0694000
> serpent_avx_x86_64 48537 0 - Live 0xffffffffa0683000
> serpent_sse2_x86_64 50367 0 - Live 0xffffffffa0675000
> xts 12922 3 twofish_x86_64_3way,camellia_x86_64,serpent_sse2_x86_64,
> Live 0xffffffffa0670000
> serpent_generic 29823 2 serpent_avx_x86_64,serpent_sse2_x86_64, Live
> 0xffffffffa0667000
> blowfish_generic 12530 0 - Live 0xffffffffa0662000
> blowfish_x86_64 21400 0 - Live 0xffffffffa065b000
> blowfish_common 16739 2 blowfish_generic,blowfish_x86_64, Live
> 0xffffffffa0655000
> cast5_avx_x86_64 49919 0 - Live 0xffffffffa0647000
> cast5_generic 21429 1 cast5_avx_x86_64, Live 0xffffffffa0640000
> cast_common 12983 2 cast5_avx_x86_64,cast5_generic, Live 0xffffffffa063b000
> des_generic 21379 0 - Live 0xffffffffa0634000
> cmac 12788 0 - Live 0xffffffffa0605000
> xcbc 12815 0 - Live 0xffffffffa0577000
> rmd160 16744 0 - Live 0xffffffffa0520000
> crypto_null 12840 0 - Live 0xffffffffa056d000
> af_key 36360 0 - Live 0xffffffffa062a000
> xfrm_algo 15527 1 af_key, Live 0xffffffffa00d2000
> parport_pc 32866 0 - Live 0xffffffffa0620000
> ppdev 17711 0 - Live 0xffffffffa051a000
> bnep 23966 2 - Live 0xffffffffa0513000
> rfcomm 74658 12 - Live 0xffffffffa00be000
> snd_hda_codec_hdmi 41684 1 - Live 0xffffffffa00b2000
> snd_hda_codec_realtek 56695 1 - Live 0xffffffffa0611000
> x86_pkg_temp_thermal 14269 0 - Live 0xffffffffa0526000
> intel_powerclamp 19031 0 - Live 0xffffffffa0454000
> joydev 17575 0 - Live 0xffffffffa050d000
> coretemp 17728 0 - Live 0xffffffffa060b000
> kvm_intel 144049 0 - Live 0xffffffffa0a34000
> kvm 457676 1 kvm_intel, Live 0xffffffffa0594000
> crct10dif_pclmul 14250 0 - Live 0xffffffffa0572000
> crc32_pclmul 13160 0 - Live 0xffffffffa04fe000
> ghash_clmulni_intel 13259 0 - Live 0xffffffffa0568000
> aesni_intel 55720 1 - Live 0xffffffffa0585000
> arc4 12573 2 - Live 0xffffffffa0580000
> aes_x86_64 17131 1 aesni_intel, Live 0xffffffffa0507000
> iwldvm 243739 0 - Live 0xffffffffa052b000
> lrw 13294 7 twofish_avx_x86_64,twofish_x86_64_3way,camellia_aesni_avx_x86_64,camellia_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,aesni_intel,
> Live 0xffffffffa044f000
> snd_hda_intel 57183 3 - Live 0xffffffffa0440000
> gf128mul 14951 2 xts,lrw, Live 0xffffffffa00d7000
> snd_hda_codec 194881 3
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
> 0xffffffffa040f000
> mac80211 634661 1 iwldvm, Live 0xffffffffa045f000
> glue_helper 14095 7
> twofish_avx_x86_64,twofish_x86_64_3way,camellia_aesni_avx_x86_64,camellia_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,aesni_intel,
> Live 0xffffffffa0082000
> snd_hwdep 13613 1 snd_hda_codec, Live 0xffffffffa007d000
> ablk_helper 13597 6
> twofish_avx_x86_64,camellia_aesni_avx_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,cast5_avx_x86_64,aesni_intel,
> Live 0xffffffffa045a000
> cryptd 20501 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0xffffffffa0088000
> snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
> 0xffffffffa0059000
> i915 733800 2 - Live 0xffffffffa035a000
> mei_me 18418 0 - Live 0xffffffffa0350000
> iwlwifi 171124 1 iwldvm, Live 0xffffffffa0325000
> mxm_wmi 13021 0 - Live 0xffffffffa0270000
> snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0xffffffffa0275000
> btusb 28326 0 - Live 0xffffffffa031d000
> snd_seq_midi 13324 0 - Live 0xffffffffa026b000
> samsung_laptop 18627 0 - Live 0xffffffffa021e000
> mei 78609 1 mei_me, Live 0xffffffffa0256000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffa0237000
> snd_rawmidi 30465 1 snd_seq_midi, Live 0xffffffffa0249000
> snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffa0225000
> uvcvideo 82247 0 - Live 0xffffffffa0208000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffa0181000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffa0203000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffa016e000
> videobuf2_core 40903 1 uvcvideo, Live 0xffffffffa023e000
> cfg80211 504229 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa02a0000
> psmouse 104113 0 - Live 0xffffffffa01e8000
> videodev 139144 2 uvcvideo,videobuf2_core, Live 0xffffffffa027d000
> bluetooth 391597 22 bnep,rfcomm,btusb, Live 0xffffffffa0187000
> drm_kms_helper 53165 1 i915, Live 0xffffffffa0173000
> lp 17799 0 - Live 0xffffffffa00dd000
> lpc_ich 21163 0 - Live 0xffffffffa0163000
> snd_timer 30038 2 snd_pcm,snd_seq, Live 0xffffffffa0101000
> drm 303133 3 i915,drm_kms_helper, Live 0xffffffffa0117000
> parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffa010b000
> snd 73802 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0xffffffffa00ed000
> soundcore 12680 1 snd, Live 0xffffffffa00e5000
> serio_raw 13462 0 - Live 0xffffffffa0010000
> i2c_algo_bit 13564 1 i915, Live 0xffffffffa0098000
> mac_hid 13253 0 - Live 0xffffffffa009f000
> wmi 19363 1 mxm_wmi, Live 0xffffffffa008f000
> video 19574 2 i915,samsung_laptop, Live 0xffffffffa0077000
> microcode 23650 0 - Live 0xffffffffa0028000
> hid_logitech_dj 18767 0 - Live 0xffffffffa0038000
> usbhid 53067 0 - Live 0xffffffffa00a4000
> hid 106254 3 hid_logitech_dj,usbhid, Live 0xffffffffa003e000
> ahci 30063 4 - Live 0xffffffffa002f000
> r8169 73111 0 - Live 0xffffffffa0015000
> libahci 32088 1 ahci, Live 0xffffffffa0007000
> mii 13981 1 r8169, Live 0xffffffffa0000000
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>
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
>   0200-020f : pnp 00:04
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0454-0457 : pnp 00:06
>   0458-047f : pnp 00:04
>     0460-047f : iTCO_wdt
>   04d0-04d1 : pnp 00:09
>   0500-057f : pnp 00:04
>   0680-069f : pnp 00:04
>   0a00-0a07 : pnp 00:04
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   164e-164f : pnp 00:04
>   d000-dfff : PCI Bus 0000:03
>     d000-d0ff : 0000:03:00.0
>       d000-d0ff : r8169
>   e000-efff : PCI Bus 0000:01
>     e000-e07f : 0000:01:00.0
>   f000-f03f : 0000:00:02.0
>   f040-f05f : 0000:00:1f.3
>   f060-f07f : 0000:00:1f.2
>     f060-f07f : ahci
>   f080-f083 : 0000:00:1f.2
>     f080-f083 : ahci
>   f090-f097 : 0000:00:1f.2
>     f090-f097 : ahci
>   f0a0-f0a3 : 0000:00:1f.2
>     f0a0-f0a3 : ahci
>   f0b0-f0b7 : 0000:00:1f.2
>     f0b0-f0b7 : ahci
>   ffff-ffff : pnp 00:04
>     ffff-ffff : pnp 00:04
>
> 00000000-00000fff : reserved
> 00001000-0009d7ff : System RAM
> 0009d800-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000cedff : Video ROM
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000fffff : reserved
>   000e0000-000e3fff : PCI Bus 0000:00
>   000e4000-000e7fff : PCI Bus 0000:00
>   000f0000-000fffff : System ROM
> 00100000-1fffffff : System RAM
>   01000000-017626e4 : Kernel code
>   017626e5-01d18abf : Kernel data
>   01e71000-01fe3fff : Kernel bss
> 20000000-201fffff : reserved
>   20000000-201fffff : pnp 00:0c
> 20200000-40003fff : System RAM
> 40004000-40004fff : reserved
>   40004000-40004fff : pnp 00:0c
> 40005000-c9f75fff : System RAM
> c9f76000-ca247fff : reserved
> ca248000-ca254fff : ACPI Tables
> ca255000-ca405fff : reserved
> ca406000-ca40dfff : ACPI Tables
> ca40e000-ca49bfff : System RAM
> ca49c000-ca561fff : ACPI Non-volatile Storage
> ca562000-ca972fff : reserved
> ca973000-ca973fff : System RAM
> ca974000-ca9b6fff : ACPI Non-volatile Storage
> ca9b7000-cadbcfff : System RAM
> cadbd000-caff3fff : reserved
> caff4000-caffffff : System RAM
> cb000000-cb7fffff : RAM buffer
> cb800000-cf9fffff : reserved
>   cba00000-cf9fffff : Graphics Stolen Memory
> cfa00000-feafffff : PCI Bus 0000:00
>   cfa00000-cfa00fff : pnp 00:0b
>   d0000000-dfffffff : 0000:00:02.0
>   e0000000-f1ffffff : PCI Bus 0000:01
>     e0000000-efffffff : 0000:01:00.0
>     f0000000-f1ffffff : 0000:01:00.0
>   f2100000-f21fffff : PCI Bus 0000:03
>     f2100000-f2103fff : 0000:03:00.0
>       f2100000-f2103fff : r8169
>     f2104000-f2104fff : 0000:03:00.0
>       f2104000-f2104fff : r8169
>   f6000000-f70fffff : PCI Bus 0000:01
>     f6000000-f6ffffff : 0000:01:00.0
>     f7000000-f707ffff : 0000:01:00.0
>   f7400000-f77fffff : 0000:00:02.0
>   f7800000-f78fffff : PCI Bus 0000:02
>     f7800000-f7801fff : 0000:02:00.0
>       f7800000-f7801fff : iwlwifi
>   f7900000-f790ffff : 0000:00:14.0
>     f7900000-f790ffff : xhci_hcd
>   f7910000-f7913fff : 0000:00:1b.0
>     f7910000-f7913fff : ICH HD audio
>   f7915000-f79150ff : 0000:00:1f.3
>   f7916000-f79167ff : 0000:00:1f.2
>     f7916000-f79167ff : ahci
>   f7917000-f79173ff : 0000:00:1d.0
>     f7917000-f79173ff : ehci_hcd
>   f7918000-f79183ff : 0000:00:1a.0
>     f7918000-f79183ff : ehci_hcd
>   f791a000-f791a00f : 0000:00:16.0
>     f791a000-f791a00f : mei_me
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:0b
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
>   fed00000-fed003ff : HPET 0
> fed10000-fed17fff : pnp 00:0b
> fed18000-fed18fff : pnp 00:0b
> fed19000-fed19fff : pnp 00:0b
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:0b
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:0b
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:0b
> fed90000-fed93fff : pnp 00:0b
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : pnp 00:0b
> 100000000-42f5fffff : System RAM
> 42f600000-42fffffff : RAM buffer
>
> [7.5.] PCI information ('lspci -vvv' as root)
>
> 00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
> Controller (rev 09)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core
> processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: 0000e000-0000efff
> Memory behind bridge: f6000000-f70fffff
> Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [88] Subsystem: Samsung Electronics Co Ltd Device c0d1
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: feeff00c  Data: 4161
> Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <8us
> ClockPM- Surprise- LLActRep- BwNot+
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [140 v1] Root Complex Link
> Desc: PortNumber=02 ComponentID=01 EltType=Config
> Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
> Addr: 00000000fed19000
> Capabilities: [d94 v1] #19
> Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
> processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 46
> Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
> Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
> Region 4: I/O ports at f000 [size=64]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: feeff00c  Data: 41d1
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
>
> 00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
> Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 41
> Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+
> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
> Address: 00000000fee4400c  Data: 4181
> Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation 7 Series/C210
> Series Chipset Family MEI Controller #1 (rev 04)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 45
> Region 0: Memory at f791a000 (64-bit, non-prefetchable) [size=16]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000feeff00c  Data: 4142
> Kernel driver in use: mei_me
>
> 00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
> Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at f7918000 (32-bit, non-prefetchable) [size=1K]
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
> 00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
> Family High Definition Audio Controller (rev 04)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 47
> Region 0: Memory at f7910000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000feeff00c  Data: 4152
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE- FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
> <64ns, L1 <1us
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
> BWMgmt- ABWMgmt-
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
> Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=22
> Status: NegoPending- InProgress-
> Capabilities: [130 v1] Root Complex Link
> Desc: PortNumber=0f ComponentID=00 EltType=Config
> Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
> Addr: 00000000fed1c000
> Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
> Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: f7800000-f78fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0d1
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
> Family PCI Express Root Port 4 (rev c4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> I/O behind bridge: 0000d000-0000dfff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000f2100000-00000000f21fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0d1
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at f7917000 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP+
> Kernel driver in use: ehci-pci
>
> 00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC
> Controller (rev 04)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
> 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 43
> Region 0: I/O ports at f0b0 [size=8]
> Region 1: I/O ports at f0a0 [size=4]
> Region 2: I/O ports at f090 [size=8]
> Region 3: I/O ports at f080 [size=4]
> Region 4: I/O ports at f060 [size=32]
> Region 5: Memory at f7916000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0100c  Data: 41a1
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
> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
> SMBus Controller (rev 04)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 10
> Region 0: Memory at f7915000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at f040 [size=32]
>
> 01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [GeForce
> GT 630M] (rev a1) (prog-if 00 [VGA controller])
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 11
> Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
> Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
> Region 3: Memory at f0000000 (64-bit, prefetchable) [size=32M]
> Region 5: I/O ports at e000 [disabled] [size=128]
> Expansion ROM at f7000000 [disabled] [size=512K]
> Capabilities: [60] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [78] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <4us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b4] Vendor Specific Information: Len=14 <?>
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [128 v1] Power Budgeting <?>
> Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
>
> 02:00.0 Network controller: Intel Corporation Centrino Advanced-N 6235 (rev 24)
> Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 44
> Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=8K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0800c  Data: 41b1
> Capabilities: [e0] Express (v1) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Device Serial Number c4-85-08-ff-ff-c3-ec-0e
> Kernel driver in use: iwlwifi
>
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> Subsystem: Samsung Electronics Co Ltd Device c0d1
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 42
> Region 0: I/O ports at d000 [size=256]
> Region 2: Memory at f2104000 (64-bit, prefetchable) [size=4K]
> Region 4: Memory at f2100000 (64-bit, prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000feeff00c  Data: 4191
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800
> Capabilities: [d0] Vital Product Data
> No end tag found
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
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
> Kernel driver in use: r8169
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD10JPVT-00A Rev: 01.0
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: TSSTcorp Model: DVDWBD SN-406AB  Rev: SC00
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> Host: scsi6 Channel: 00 Id: 00 Lun: 00
>   Vendor: Seagate  Model: Expansion        Rev: 0634
>   Type:   Direct-Access                    ANSI  SCSI revision: 06
>
>
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
>
> root@huayra:~# ls /proc/
> 1     166   2887  44    6004  6437  6784  7354  asound         mounts
> 10    167   29    45    6006  6440  6790  7387  buddyinfo      mtrr
> 100   17    3     46    6086  6442  6853  74    bus            net
> 1074  175   31    460   6096  6446  6858  7452  cgroups        pagetypeinfo
> 11    176   3153  463   61    6447  6866  7476  cmdline        partitions
> 12    177   3154  464   6102  6448  6882  7478  consoles       sched_debug
> 120   178   3155  47    6119  647   69    7566  cpuinfo        schedstat
> 121   179   3156  471   6138  6478  6914  76    crypto         scsi
> 1217  18    3157  472   6156  6482  6915  7676  devices        self
> 1223  180   3158  473   6161  6483  6979  7775  diskstats      slabinfo
> 1274  1815  3159  474   6164  6494  7     78    dma            softirqs
> 1280  186   3160  48    6165  6499  70    79    driver         stat
> 1299  1873  3179  49    6170  65    7063  8     execdomains    swaps
> 13    1874  3181  498   6174  6532  7064  80    fb             sys
> 1300  19    32    5     6182  6534  71    81    filesystems    sysrq-trigger
> 1304  1916  33    50    6188  6535  7127  82    fs             sysvipc
> 1346  1977  331   504   6190  6536  7134  827   interrupts     timer_list
> 1365  2     338   51    6195  6537  7135  83    iomem          timer_stats
> 1367  20    34    52    62    6576  7136  84    ioports        tty
> 1395  205   3423  53    6206  6593  7142  865   irq            uptime
> 14    206   35    532   6213  6595  7143  872   kallsyms       version
> 1404  2070  36    54    6214  66    7186  873   kcore          vmallocinfo
> 1415  21    3666  542   6217  6600  719   883   key-users      vmstat
> 1416  212   3667  5563  6225  6604  7192  887   kmsg           zoneinfo
> 1417  213   37    56    63    6610  72    894   kpagecount
> 1418  22    3705  57    6385  6622  720   9     kpageflags
> 1432  23    38    5736  6395  6626  7251  903   latency_stats
> 1446  24    39    5742  64    6627  7264  904   loadavg
> 1499  25    4     58    6409  6691  727   96    locks
> 15    26    401   5843  6420  6698  728   975   mdstat
> 1548  2641  41    5858  6422  6699  73    986   meminfo
> 16    27    42    59    6430  67    7320  99    misc
> 1633  28    43    60    6431  674   7349  acpi  modules
>
> This bug was present both on Fedora and Ubuntu. A bug was opened on
> launchpad and it shows the kernel versions on which the issue is present:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1223851
>
> [X.] Other notes, patches, fixes, workarounds:
>
> As mentioned in the full description section, the following command
>
> # echo disable > /sys/firmware/acpi/interrupts/gpe0D
>
> makes the load of the system to drop to normal levels with no apparent
> ill-effects, but I don't know what event "0D" represents.
>
> Thanks,
> Agustin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

HI:
       Bug 61051 on the kernel bugzilla has the same symptom. Please
attach your acpidump to the bug.
        https://bugzilla.kernel.org/show_bug.cgi?id=61051


-- 
Best regards
Tianyu Lan
