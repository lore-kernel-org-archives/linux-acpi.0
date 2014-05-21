From: Lewis Toohey <lewis@toohey.co.uk>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Wed, 21 May 2014 14:02:08 +0100
Message-ID: <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com>
 <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com>
 <537C9DC5.5040408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscan21.extendcp.co.uk ([176.32.226.67]:33761 "EHLO
	mailscan1.extendcp.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751254AbaEUNDH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 09:03:07 -0400
Received: from lb1.hi.local ([10.0.1.197] helo=mailscan2.extendcp.co.uk)
	by mailscan-s96.hi.local with esmtp (Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1Wn6Ai-0003o9-G6
	for linux-acpi@vger.kernel.org; Wed, 21 May 2014 14:03:04 +0100
Received: from lb1.hi.local ([10.0.1.197] helo=mail44.extendcp.co.uk)
	by mailscan2.extendcp.co.uk with esmtps (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <lewis@toohey.co.uk>)
	id 1Wn6Ad-00017R-Rw
	for linux-acpi@vger.kernel.org; Wed, 21 May 2014 14:03:04 +0100
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by mail44.extendcp.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	id 1Wn6AB-0000ZJ-Hy
	for linux-acpi@vger.kernel.org; Wed, 21 May 2014 14:02:31 +0100
Received: by mail-qc0-f170.google.com with SMTP id i8so3178697qcq.29
        for <linux-acpi@vger.kernel.org>; Wed, 21 May 2014 06:02:29 -0700 (PDT)
In-Reply-To: <537C9DC5.5040408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Aaron

I followed your instructions and can report some limited success. I
have two interfaces listed in /sys/class/backlight namely:
  acpi_video0  radeon_bl0

max_brightness for acpi_video0 is 11. Echo-ing new values to
brightness appears to have no effect.

max_brightness for radeon_bl0 is 255. Echo-ing new values to
brightness does adjust the screen brightness as you would expect.

Results are the same on both battery and powered.

I hope that is useful.

Many thanks

On 21 May 2014 13:36, Aaron Lu <aaron.lu@intel.com> wrote:
> On 05/21/2014 03:05 PM, Lewis Toohey wrote:
>> Aaron
>>
>> Thank you for your reply. I can confirm that I have uploaded my
>> acpidump to the Ubuntu bug page as requested. Please find a direct
>> link below:
>>
>> https://launchpadlibrarian.net/176019905/acpidump.txt
>>
>> Many thanks
>
> You are welcome.
>
> Please list /sys/class/backlight, and please test if any of the
> interfaces there work well like this:
> # ls /sys/class/backlight
> acpi_video, radeon_bl perhaps_other
> # cd /sys/class/backlight/acpi_video
> # cat max_brightness
> 11
> # echo 5 > brightness
> # echo 8 > brightness
> see if backlight level changes.
> Then test all other interfaces one by one.
>
> Thanks,
> Aaron
>
>>
>> On 21 May 2014 02:21, Aaron Lu <aaron.lu@intel.com> wrote:
>>> On 05/21/2014 02:32 AM, Lewis Toohey wrote:
>>>> Dear Sirs
>>>>
>>>> Please find a bug report below (hopefully) in the correct format.
>>>> Please let me know if you have any queries or require further
>>>> information
>>>
>>> Please attach acpidump:
>>> # acpidump > acpidump.txt
>>>
>>> Feel free to attach that into the original Ubuntu bug page or
>>> file a new bug at https://bugzilla.kernel.org/ under the Power/Video
>>> category.
>>>
>>> Thanks,
>>> Aaron
>>>
>>>>
>>>> Many thanks
>>>>
>>>> [1.] One line summary of the problem:
>>>> [Acer Aspire V5-122P] Unable to adjust screen brightness. Adjusting
>>>> brightness in the settings applet has no affect. Adjusting brightness
>>>> with the keyboard function keys turns the screen on and off seemingly
>>>> randomly.
>>>>
>>>> [2.] Full description of the problem/report:
>>>> The bug can be reproduced simply by loading the latest mainline kernel
>>>> (3.15 rc5) and then attempting to adjust screen brightness by using
>>>> either the keyboard hot keys or the settings applet proivded in
>>>> gnome/unity.
>>>>
>>>> [3.] Keywords (i.e., modules, networking, kernel):
>>>> N/A
>>>>
>>>> [4.] Kernel version (from /proc/version):
>>>> Linux version 3.15.0-031500rc5-generic (apw@gomeisa) (gcc version
>>>> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405091635 SMP Fri May 9
>>>> 20:36:31 UTC 2014
>>>>
>>>> [5.] Output of Oops.. message (if applicable) with symbolic
>>>> information resolved (see Documentation/oops-tracing.txt)
>>>> N/A
>>>>
>>>> [6.] A small shell script or example program which triggers the
>>>> problem (if possible)
>>>> N/A
>>>>
>>>> [7.] Environment
>>>> Description: Ubuntu 14.04 LTS
>>>> Release: 14.04
>>>>
>>>> [7.1.] Software (add the output of the ver_linux script here)
>>>> Linux HappyFunMeaowMeaow 3.15.0-031500rc5-generic #201405091635 SMP
>>>> Fri May 9 20:36:31 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> Gnu C                  4.8
>>>> Gnu make               3.81
>>>> binutils               2.24
>>>> util-linux             2.20.1
>>>> mount                  support
>>>> module-init-tools      15
>>>> e2fsprogs              1.42.9
>>>> pcmciautils            018
>>>> PPP                    2.4.5
>>>> Linux C Library        2.19
>>>> Dynamic linker (ldd)   2.19
>>>> Procps                 3.3.9
>>>> Net-tools              1.60
>>>> Kbd                    1.15.5
>>>> Sh-utils               8.21
>>>> wireless-tools         30
>>>> Modules Loaded         cmac rmd160 crypto_null camellia_generic
>>>> camellia_aesni_avx_x86_64 camellia_x86_64 cast6_avx_x86_64
>>>> cast6_generic cast5_avx_x86_64 cast5_generic cast_common deflate cts
>>>> gcm serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic
>>>> blowfish_generic blowfish_x86_64 blowfish_common twofish_generic
>>>> twofish_avx_x86_64 twofish_x86_64_3way xts twofish_x86_64
>>>> twofish_common xcbc sha256_ssse3 sha512_ssse3 des_generic xfrm_user
>>>> ah6 ah4 esp6 esp4 xfrm4_mode_beet xfrm4_tunnel tunnel4
>>>> xfrm4_mode_tunnel xfrm4_mode_transport xfrm6_mode_transport
>>>> xfrm6_mode_ro xfrm6_mode_beet xfrm6_mode_tunnel ipcomp ipcomp6
>>>> xfrm6_tunnel tunnel6 xfrm_ipcomp af_key xfrm_algo ctr ccm rfcomm bnep
>>>> nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi
>>>> snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec
>>>> snd_hwdep snd_pcm snd_seq_midi amd_freq_sensitivity snd_seq_midi_event
>>>> snd_rawmidi arc4 radeon snd_seq ath9k ath9k_common snd_seq_device
>>>> uvcvideo kvm ath9k_hw videobuf2_vmalloc videobuf2_memops snd_timer
>>>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel videobuf2_core ath
>>>> ttm snd mac80211 drm_kms_helper videodev aesni_intel hid_multitouch
>>>> aes_x86_64 lrw gf128mul glue_helper acer_wmi ablk_helper sparse_keymap
>>>> cryptd microcode parport_pc ath3k btusb k10temp fam15h_power ppdev wmi
>>>> lp soundcore joydev serio_raw drm cfg80211 bluetooth edac_core parport
>>>> 6lowpan_iphc video edac_mce_amd i2c_algo_bit i2c_piix4 mac_hid usbhid
>>>> hid psmouse sdhci_pci ahci sdhci libahci
>>>>
>>>> [7.2.] Processor information (from /proc/cpuinfo):
>>>> processor : 0
>>>> vendor_id : AuthenticAMD
>>>> cpu family : 22
>>>> model : 0
>>>> model name : AMD A6-1450 APU with Radeon(TM) HD Graphics
>>>> stepping : 1
>>>> microcode : 0x700010b
>>>> cpu MHz : 600.000
>>>> cache size : 2048 KB
>>>> physical id : 0
>>>> siblings : 4
>>>> core id : 0
>>>> cpu cores : 4
>>>> apicid : 0
>>>> initial apicid : 0
>>>> fpu : yes
>>>> fpu_exception : yes
>>>> cpuid level : 13
>>>> wp : yes
>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>>>> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
>>>> aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2
>>>> movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic
>>>> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
>>>> topoext perfctr_nb perfctr_l2 arat cpb xsaveopt hw_pstate
>>>> proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
>>>> decodeassists pausefilter pfthreshold bmi1
>>>> bogomips : 1996.26
>>>> TLB size : 1024 4K pages
>>>> clflush size : 64
>>>> cache_alignment : 64
>>>> address sizes : 40 bits physical, 48 bits virtual
>>>> power management: ts ttp tm 100mhzsteps hwpstate cpb [11]
>>>>
>>>> processor : 1
>>>> vendor_id : AuthenticAMD
>>>> cpu family : 22
>>>> model : 0
>>>> model name : AMD A6-1450 APU with Radeon(TM) HD Graphics
>>>> stepping : 1
>>>> microcode : 0x700010b
>>>> cpu MHz : 600.000
>>>> cache size : 2048 KB
>>>> physical id : 0
>>>> siblings : 4
>>>> core id : 1
>>>> cpu cores : 4
>>>> apicid : 1
>>>> initial apicid : 1
>>>> fpu : yes
>>>> fpu_exception : yes
>>>> cpuid level : 13
>>>> wp : yes
>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>>>> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
>>>> aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2
>>>> movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic
>>>> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
>>>> topoext perfctr_nb perfctr_l2 arat cpb xsaveopt hw_pstate
>>>> proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
>>>> decodeassists pausefilter pfthreshold bmi1
>>>> bogomips : 1996.26
>>>> TLB size : 1024 4K pages
>>>> clflush size : 64
>>>> cache_alignment : 64
>>>> address sizes : 40 bits physical, 48 bits virtual
>>>> power management: ts ttp tm 100mhzsteps hwpstate cpb [11]
>>>>
>>>> processor : 2
>>>> vendor_id : AuthenticAMD
>>>> cpu family : 22
>>>> model : 0
>>>> model name : AMD A6-1450 APU with Radeon(TM) HD Graphics
>>>> stepping : 1
>>>> microcode : 0x700010b
>>>> cpu MHz : 600.000
>>>> cache size : 2048 KB
>>>> physical id : 0
>>>> siblings : 4
>>>> core id : 2
>>>> cpu cores : 4
>>>> apicid : 2
>>>> initial apicid : 2
>>>> fpu : yes
>>>> fpu_exception : yes
>>>> cpuid level : 13
>>>> wp : yes
>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>>>> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
>>>> aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2
>>>> movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic
>>>> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
>>>> topoext perfctr_nb perfctr_l2 arat cpb xsaveopt hw_pstate
>>>> proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
>>>> decodeassists pausefilter pfthreshold bmi1
>>>> bogomips : 1996.26
>>>> TLB size : 1024 4K pages
>>>> clflush size : 64
>>>> cache_alignment : 64
>>>> address sizes : 40 bits physical, 48 bits virtual
>>>> power management: ts ttp tm 100mhzsteps hwpstate cpb [11]
>>>>
>>>> processor : 3
>>>> vendor_id : AuthenticAMD
>>>> cpu family : 22
>>>> model : 0
>>>> model name : AMD A6-1450 APU with Radeon(TM) HD Graphics
>>>> stepping : 1
>>>> microcode : 0x700010b
>>>> cpu MHz : 600.000
>>>> cache size : 2048 KB
>>>> physical id : 0
>>>> siblings : 4
>>>> core id : 3
>>>> cpu cores : 4
>>>> apicid : 3
>>>> initial apicid : 3
>>>> fpu : yes
>>>> fpu_exception : yes
>>>> cpuid level : 13
>>>> wp : yes
>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>>>> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
>>>> aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2
>>>> movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic
>>>> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
>>>> topoext perfctr_nb perfctr_l2 arat cpb xsaveopt hw_pstate
>>>> proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
>>>> decodeassists pausefilter pfthreshold bmi1
>>>> bogomips : 1996.26
>>>> TLB size : 1024 4K pages
>>>> clflush size : 64
>>>> cache_alignment : 64
>>>> address sizes : 40 bits physical, 48 bits virtual
>>>> power management: ts ttp tm 100mhzsteps hwpstate cpb [11]
>>>>
>>>>
>>>> [7.3.] Module information (from /proc/modules):
>>>> cmac 12788 0 - Live 0x0000000000000000
>>>> rmd160 16744 0 - Live 0x0000000000000000
>>>> crypto_null 12840 0 - Live 0x0000000000000000
>>>> camellia_generic 29348 0 - Live 0x0000000000000000
>>>> camellia_aesni_avx_x86_64 27549 0 - Live 0x0000000000000000
>>>> camellia_x86_64 52986 1 camellia_aesni_avx_x86_64, Live 0x0000000000000000
>>>> cast6_avx_x86_64 66938 0 - Live 0x0000000000000000
>>>> cast6_generic 21523 1 cast6_avx_x86_64, Live 0x0000000000000000
>>>> cast5_avx_x86_64 49919 0 - Live 0x0000000000000000
>>>> cast5_generic 21429 1 cast5_avx_x86_64, Live 0x0000000000000000
>>>> cast_common 12983 4
>>>> cast6_avx_x86_64,cast6_generic,cast5_avx_x86_64,cast5_generic, Live
>>>> 0x0000000000000000
>>>> deflate 12617 0 - Live 0x0000000000000000
>>>> cts 12902 0 - Live 0x0000000000000000
>>>> gcm 23507 0 - Live 0x0000000000000000
>>>> serpent_avx_x86_64 48537 0 - Live 0x0000000000000000
>>>> serpent_sse2_x86_64 50367 0 - Live 0x0000000000000000
>>>> serpent_generic 29823 2 serpent_avx_x86_64,serpent_sse2_x86_64, Live
>>>> 0x0000000000000000
>>>> blowfish_generic 12530 0 - Live 0x0000000000000000
>>>> blowfish_x86_64 21400 0 - Live 0x0000000000000000
>>>> blowfish_common 16739 2 blowfish_generic,blowfish_x86_64, Live
>>>> 0x0000000000000000
>>>> twofish_generic 16635 0 - Live 0x0000000000000000
>>>> twofish_avx_x86_64 46380 0 - Live 0x0000000000000000
>>>> twofish_x86_64_3way 27146 1 twofish_avx_x86_64, Live 0x0000000000000000
>>>> xts 12951 3 camellia_x86_64,serpent_sse2_x86_64,twofish_x86_64_3way,
>>>> Live 0x0000000000000000
>>>> twofish_x86_64 12907 2 twofish_avx_x86_64,twofish_x86_64_3way, Live
>>>> 0x0000000000000000
>>>> twofish_common 21113 4
>>>> twofish_generic,twofish_avx_x86_64,twofish_x86_64_3way,twofish_x86_64,
>>>> Live 0x0000000000000000
>>>> xcbc 12815 0 - Live 0x0000000000000000
>>>> sha256_ssse3 26322 0 - Live 0x0000000000000000
>>>> sha512_ssse3 42254 0 - Live 0x0000000000000000
>>>> des_generic 21379 0 - Live 0x0000000000000000
>>>> xfrm_user 36033 2 - Live 0x0000000000000000
>>>> ah6 17203 0 - Live 0x0000000000000000
>>>> ah4 17133 0 - Live 0x0000000000000000
>>>> esp6 17180 0 - Live 0x0000000000000000
>>>> esp4 17175 0 - Live 0x0000000000000000
>>>> xfrm4_mode_beet 12611 0 - Live 0x0000000000000000
>>>> xfrm4_tunnel 12857 0 - Live 0x0000000000000000
>>>> tunnel4 13252 1 xfrm4_tunnel, Live 0x0000000000000000
>>>> xfrm4_mode_tunnel 12639 0 - Live 0x0000000000000000
>>>> xfrm4_mode_transport 12631 0 - Live 0x0000000000000000
>>>> xfrm6_mode_transport 12631 0 - Live 0x0000000000000000
>>>> xfrm6_mode_ro 12564 0 - Live 0x0000000000000000
>>>> xfrm6_mode_beet 12658 0 - Live 0x0000000000000000
>>>> xfrm6_mode_tunnel 12639 0 - Live 0x0000000000000000
>>>> ipcomp 12790 0 - Live 0x0000000000000000
>>>> ipcomp6 12793 0 - Live 0x0000000000000000
>>>> xfrm6_tunnel 13807 1 ipcomp6, Live 0x0000000000000000
>>>> tunnel6 13254 1 xfrm6_tunnel, Live 0x0000000000000000
>>>> xfrm_ipcomp 13606 2 ipcomp,ipcomp6, Live 0x0000000000000000
>>>> af_key 36501 0 - Live 0x0000000000000000
>>>> xfrm_algo 15394 7 xfrm_user,ah6,ah4,esp6,esp4,xfrm_ipcomp,af_key, Live
>>>> 0x0000000000000000
>>>> ctr 13193 2 - Live 0x0000000000000000
>>>> ccm 17856 2 - Live 0x0000000000000000
>>>> rfcomm 75078 0 - Live 0x0000000000000000
>>>> bnep 19884 2 - Live 0x0000000000000000
>>>> nls_iso8859_1 12713 1 - Live 0x0000000000000000
>>>> snd_hda_codec_realtek 72529 1 - Live 0x0000000000000000
>>>> snd_hda_codec_hdmi 48229 1 - Live 0x0000000000000000
>>>> snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
>>>> snd_hda_intel 30608 5 - Live 0x0000000000000000
>>>> snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
>>>> snd_hda_codec 144671 5
>>>> snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
>>>> Live 0x0000000000000000
>>>> snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
>>>> snd_pcm 113863 4
>>>> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
>>>> Live 0x0000000000000000
>>>> snd_seq_midi 13564 0 - Live 0x0000000000000000
>>>> amd_freq_sensitivity 12615 0 - Live 0x0000000000000000
>>>> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
>>>> snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
>>>> arc4 12573 2 - Live 0x0000000000000000
>>>> radeon 1602208 3 - Live 0x0000000000000000
>>>> snd_seq 67636 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
>>>> ath9k 147545 0 - Live 0x0000000000000000
>>>> ath9k_common 15984 1 ath9k, Live 0x0000000000000000
>>>> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
>>>> uvcvideo 82299 0 - Live 0x0000000000000000
>>>> kvm 463808 0 - Live 0x0000000000000000
>>>> ath9k_hw 459576 2 ath9k,ath9k_common, Live 0x0000000000000000
>>>> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
>>>> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
>>>> snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
>>>> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
>>>> crc32_pclmul 13180 0 - Live 0x0000000000000000
>>>> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
>>>> videobuf2_core 45435 1 uvcvideo, Live 0x0000000000000000
>>>> ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
>>>> ttm 90341 1 radeon, Live 0x0000000000000000
>>>> snd 74195 21 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
>>>> Live 0x0000000000000000
>>>> mac80211 663883 1 ath9k, Live 0x0000000000000000
>>>> drm_kms_helper 59729 1 radeon, Live 0x0000000000000000
>>>> videodev 149504 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
>>>> aesni_intel 152648 4 - Live 0x0000000000000000
>>>> hid_multitouch 17656 0 - Live 0x0000000000000000
>>>> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
>>>> lrw 13323 8 camellia_aesni_avx_x86_64,camellia_x86_64,cast6_avx_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,twofish_avx_x86_64,twofish_x86_64_3way,aesni_intel,
>>>> Live 0x0000000000000000
>>>> gf128mul 14951 2 xts,lrw, Live 0x0000000000000000
>>>> glue_helper 14095 8
>>>> camellia_aesni_avx_x86_64,camellia_x86_64,cast6_avx_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,twofish_avx_x86_64,twofish_x86_64_3way,aesni_intel,
>>>> Live 0x0000000000000000
>>>> acer_wmi 32938 0 - Live 0x0000000000000000
>>>> ablk_helper 13597 7
>>>> camellia_aesni_avx_x86_64,cast6_avx_x86_64,cast5_avx_x86_64,serpent_avx_x86_64,serpent_sse2_x86_64,twofish_avx_x86_64,aesni_intel,
>>>> Live 0x0000000000000000
>>>> sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
>>>> cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
>>>> 0x0000000000000000
>>>> microcode 24391 0 - Live 0x0000000000000000
>>>> parport_pc 32906 0 - Live 0x0000000000000000
>>>> ath3k 13381 0 - Live 0x0000000000000000
>>>> btusb 32555 0 - Live 0x0000000000000000
>>>> k10temp 13191 0 - Live 0x0000000000000000
>>>> fam15h_power 13189 0 - Live 0x0000000000000000
>>>> ppdev 17711 0 - Live 0x0000000000000000
>>>> wmi 19379 1 acer_wmi, Live 0x0000000000000000
>>>> lp 17799 0 - Live 0x0000000000000000
>>>> soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
>>>> joydev 17587 0 - Live 0x0000000000000000
>>>> serio_raw 13483 0 - Live 0x0000000000000000
>>>> drm 310655 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
>>>> cfg80211 515248 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
>>>> bluetooth 461775 12 rfcomm,bnep,ath3k,btusb, Live 0x0000000000000000
>>>> edac_core 63001 0 - Live 0x0000000000000000
>>>> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>>>> 6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
>>>> video 19932 1 acer_wmi, Live 0x0000000000000000
>>>> edac_mce_amd 22792 0 - Live 0x0000000000000000
>>>> i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
>>>> i2c_piix4 22310 0 - Live 0x0000000000000000
>>>> mac_hid 13275 0 - Live 0x0000000000000000
>>>> usbhid 53121 0 - Live 0x0000000000000000
>>>> hid 106436 2 hid_multitouch,usbhid, Live 0x0000000000000000
>>>> psmouse 113320 0 - Live 0x0000000000000000
>>>> sdhci_pci 23347 0 - Live 0x0000000000000000
>>>> ahci 30133 3 - Live 0x0000000000000000
>>>> sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
>>>> libahci 32191 1 ahci, Live 0x0000000000000000
>>>>
>>>> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>>>> While booted into the newest upstream mainline kernel only, execute
>>>> the following in a terminal, and paste the results:
>>>> 0000-0cf7 : PCI Bus 0000:00
>>>>   0000-001f : dma1
>>>>   0020-0021 : pic1
>>>>   0040-0043 : timer0
>>>>   0050-0053 : timer1
>>>>   0060-0060 : keyboard
>>>>   0062-0062 : EC data
>>>>   0064-0064 : keyboard
>>>>   0066-0066 : EC cmd
>>>>   0070-0071 : rtc0
>>>>   0080-008f : dma page reg
>>>>   00a0-00a1 : pic2
>>>>   00c0-00df : dma2
>>>>   00f0-00ff : fpu
>>>>   0400-0403 : ACPI PM1a_EVT_BLK
>>>>   0404-0405 : ACPI PM1a_CNT_BLK
>>>>   0408-040b : ACPI PM_TMR
>>>>   0410-0415 : ACPI CPU throttle
>>>>   0420-0427 : ACPI GPE0_BLK
>>>>   04d0-04d1 : pnp 00:06
>>>>   04d6-04d6 : pnp 00:06
>>>>   0680-06ff : pnp 00:06
>>>>   077a-077a : pnp 00:06
>>>>   0800-0800 : ACPI PM2_CNT_BLK
>>>>   0840-0847 : pnp 00:06
>>>>   0c00-0c01 : pnp 00:06
>>>>   0c14-0c14 : pnp 00:06
>>>>   0c50-0c52 : pnp 00:06
>>>>   0c6c-0c6c : pnp 00:06
>>>>   0c6f-0c6f : pnp 00:06
>>>>   0cd0-0cdb : pnp 00:06
>>>> 0cf8-0cff : PCI conf1
>>>> 0d00-ffff : PCI Bus 0000:00
>>>>   2000-20ff : 0000:00:01.0
>>>>   2100-210f : 0000:00:11.0
>>>>     2100-210f : ahci
>>>>   2110-2117 : 0000:00:11.0
>>>>     2110-2117 : ahci
>>>>   2118-211f : 0000:00:11.0
>>>>     2118-211f : ahci
>>>>   2120-2123 : 0000:00:11.0
>>>>     2120-2123 : ahci
>>>>   2124-2127 : 0000:00:11.0
>>>>     2124-2127 : ahci
>>>>
>>>>
>>>> 00000000-00000fff : reserved
>>>> 00001000-0006dfff : System RAM
>>>> 0006e000-0006ffff : ACPI Non-volatile Storage
>>>> 00070000-00085fff : System RAM
>>>> 00086000-000bffff : reserved
>>>>   000a0000-000bffff : PCI Bus 0000:00
>>>> 000c0000-000c3fff : PCI Bus 0000:00
>>>> 000c4000-000c7fff : PCI Bus 0000:00
>>>> 000c8000-000cbfff : PCI Bus 0000:00
>>>> 000cc000-000cffff : PCI Bus 0000:00
>>>> 000d0000-000d3fff : PCI Bus 0000:00
>>>> 000d4000-000d7fff : PCI Bus 0000:00
>>>> 000d8000-000dbfff : PCI Bus 0000:00
>>>> 000dc000-000dffff : PCI Bus 0000:00
>>>> 000e0000-000e3fff : PCI Bus 0000:00
>>>> 000e4000-000e7fff : PCI Bus 0000:00
>>>> 000e8000-000ebfff : PCI Bus 0000:00
>>>> 000ec000-000effff : PCI Bus 0000:00
>>>> 000f0000-000fffff : System ROM
>>>> 00100000-b4b1cfff : System RAM
>>>>   02000000-0277c2d8 : Kernel code
>>>>   0277c2d9-02d1eeff : Kernel data
>>>>   02e7b000-02fe0fff : Kernel bss
>>>> b4b1d000-b531dfff : reserved
>>>> b531e000-b537bfff : System RAM
>>>> b537c000-b677bfff : reserved
>>>> b677c000-bf17efff : System RAM
>>>> bf17f000-bf57efff : reserved
>>>> bf57f000-bf97efff : reserved
>>>> bf97f000-bfb7efff : ACPI Non-volatile Storage
>>>> bfb7f000-bfbfefff : ACPI Tables
>>>> bfbff000-bfbfffff : System RAM
>>>> bfc00000-dfffffff : reserved
>>>> e0000000-f7ffffff : PCI Bus 0000:00
>>>>   e0000000-efffffff : 0000:00:01.0
>>>>   f0000000-f07fffff : 0000:00:01.0
>>>>   f0800000-f08fffff : PCI Bus 0000:01
>>>>     f0800000-f087ffff : 0000:01:00.0
>>>>       f0800000-f087ffff : ath9k
>>>>   f0900000-f093ffff : 0000:00:01.0
>>>>   f0940000-f0943fff : 0000:00:01.1
>>>>     f0940000-f0943fff : ICH HD audio
>>>>   f0944000-f0947fff : 0000:00:14.2
>>>>     f0944000-f0947fff : ICH HD audio
>>>>   f0948000-f0949fff : 0000:00:10.0
>>>>     f0948000-f0949fff : xhci_hcd
>>>>   f094a000-f094a0ff : 0000:00:14.7
>>>>     f094a000-f094a0ff : mmc0
>>>>   f094b000-f094b0ff : 0000:00:13.2
>>>>     f094b000-f094b0ff : ehci_hcd
>>>>   f094c000-f094cfff : 0000:00:13.0
>>>>     f094c000-f094cfff : ohci_hcd
>>>>   f094d000-f094d0ff : 0000:00:12.2
>>>>     f094d000-f094d0ff : ehci_hcd
>>>>   f094e000-f094efff : 0000:00:12.0
>>>>     f094e000-f094efff : ohci_hcd
>>>>   f094f000-f094f3ff : 0000:00:11.0
>>>>     f094f000-f094f3ff : ahci
>>>>   f0960000-f097ffff : 0000:00:01.0
>>>>   f0a00000-f0afffff : PCI Bus 0000:01
>>>>     f0a00000-f0a0ffff : 0000:01:00.0
>>>> f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>>>>   f8000000-fbffffff : reserved
>>>> fc000000-fed3ffff : PCI Bus 0000:00
>>>>   fec00000-fec00fff : reserved
>>>>     fec00000-fec003ff : IOAPIC 0
>>>>   fec01000-fec013ff : IOAPIC 1
>>>>   fec10000-fec10fff : reserved
>>>>   fed00000-fed003ff : HPET 0
>>>> fed45000-ffffffff : PCI Bus 0000:00
>>>>   fed80000-fed80fff : reserved
>>>>   fee00000-fee00fff : Local APIC
>>>>     fee00000-fee00fff : reserved
>>>>       fee00000-fee00fff : pnp 00:00
>>>>   ffc00000-ffffffff : reserved
>>>>     ffc00000-ffffffff : pnp 00:07
>>>> 100000000-11effffff : System RAM
>>>> 11f000000-11fffffff : RAM buffer
>>>>
>>>> [7.5.] PCI information ('lspci -vvv' as root)
>>>> While booted into the newest upstream mainline kernel only, execute
>>>> the following via a terminal, and paste the results:
>>>> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Root Complex
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0
>>>>
>>>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>> [AMD/ATI] Temash [Radeon HD 8250/8280G] (prog-if 00 [VGA controller])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx+
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 77
>>>> Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>>>> Region 2: Memory at f0000000 (64-bit, prefetchable) [size=8M]
>>>> Region 4: I/O ports at 2000 [size=256]
>>>> Region 5: Memory at f0900000 (32-bit, non-prefetchable) [size=256K]
>>>> Expansion ROM at f0960000 [disabled] [size=128K]
>>>> Capabilities: [48] Vendor Specific Information: Len=08 <?>
>>>> Capabilities: [50] Power Management version 3
>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
>>>> DevCap: MaxPayload 256 bytes, PhantFunc 0
>>>> ExtTag+ RBE+
>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
>>>> Not Supported
>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>>> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>> Address: 00000000fee0f00c  Data: 4142
>>>> Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>>>> Capabilities: [270 v1] #19
>>>> Kernel driver in use: radeon
>>>>
>>>> 00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 9840
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx+
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0, Cache Line Size: 64 bytes
>>>> Interrupt: pin B routed to IRQ 78
>>>> Region 0: Memory at f0940000 (64-bit, non-prefetchable) [size=16K]
>>>> Capabilities: [48] Vendor Specific Information: Len=08 <?>
>>>> Capabilities: [50] Power Management version 3
>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
>>>> DevCap: MaxPayload 256 bytes, PhantFunc 0
>>>> ExtTag+ RBE+
>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
>>>> Not Supported
>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>>> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>> Address: 00000000fee0f00c  Data: 4162
>>>> Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>>>> Kernel driver in use: snd_hda_intel
>>>>
>>>> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 0
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Functions 5:1 (prog-if 00 [Normal decode])
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0, Cache Line Size: 64 bytes
>>>> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>> I/O behind bridge: 0000f000-00000fff
>>>> Memory behind bridge: f0800000-f08fffff
>>>> Prefetchable memory behind bridge: 00000000f0a00000-00000000f0afffff
>>>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- <SERR- <PERR-
>>>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>> Capabilities: [50] Power Management version 3
>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
>>>> DevCap: MaxPayload 256 bytes, PhantFunc 0
>>>> ExtTag+ RBE+
>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>>>> LnkCap: Port #1, Speed 2.5GT/s, Width x2, ASPM L0s L1, Exit Latency
>>>> L0s <512ns, L1 <64us
>>>> ClockPM- Surprise- LLActRep+ BwNot+
>>>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>>>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>>>> BWMgmt- ABWMgmt-
>>>> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>>>> Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
>>>> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>>> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>>> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>>>> Changed: MRL- PresDet+ LinkState+
>>>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>>> RootCap: CRSVisible-
>>>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
>>>> Supported ARIFwd-
>>>> DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
>>>> Disabled ARIFwd-
>>>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
>>>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>>>> Compliance De-emphasis: -6dB
>>>> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
>>>> EqualizationPhase1-
>>>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>> Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>> Address: 0000000000000000  Data: 0000
>>>> Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1234
>>>> Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
>>>> Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>>>> Kernel driver in use: pcieport
>>>>
>>>> 00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
>>>> XHCI Controller (rev 01) (prog-if 30 [XHCI])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx+
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 18
>>>> Region 0: Memory at f0948000 (64-bit, non-prefetchable) [size=8K]
>>>> Capabilities: [50] Power Management version 3
>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>>>> Address: 0000000000000000  Data: 0000
>>>> Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
>>>> Vector table: BAR=0 offset=00001000
>>>> PBA: BAR=0 offset=00001080
>>>> Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI 00
>>>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>>>> ExtTag- RBE+
>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
>>>> Not Supported
>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>>> Capabilities: [100 v1] Latency Tolerance Reporting
>>>> Max snoop latency: 0ns
>>>> Max no snoop latency: 0ns
>>>> Kernel driver in use: xhci_hcd
>>>>
>>>> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
>>>> Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 19
>>>> Region 0: I/O ports at 2118 [size=8]
>>>> Region 1: I/O ports at 2124 [size=4]
>>>> Region 2: I/O ports at 2110 [size=8]
>>>> Region 3: I/O ports at 2120 [size=4]
>>>> Region 4: I/O ports at 2100 [size=16]
>>>> Region 5: Memory at f094f000 (32-bit, non-prefetchable) [size=1K]
>>>> Capabilities: [60] Power Management version 3
>>>> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [70] SATA HBA v1.0 InCfgSpace
>>>> Kernel driver in use: ahci
>>>>
>>>> 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
>>>> OHCI Controller (rev 39) (prog-if 10 [OHCI])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 18
>>>> Region 0: Memory at f094e000 (32-bit, non-prefetchable) [size=4K]
>>>> Kernel driver in use: ohci-pci
>>>>
>>>> 00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
>>>> EHCI Controller (rev 39) (prog-if 20 [EHCI])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin B routed to IRQ 17
>>>> Region 0: Memory at f094d000 (32-bit, non-prefetchable) [size=256]
>>>> Capabilities: [c0] Power Management version 2
>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Bridge: PM- B3+
>>>> Capabilities: [e4] Debug port: BAR=1 offset=00e0
>>>> Kernel driver in use: ehci-pci
>>>>
>>>> 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
>>>> OHCI Controller (rev 39) (prog-if 10 [OHCI])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 18
>>>> Region 0: Memory at f094c000 (32-bit, non-prefetchable) [size=4K]
>>>> Kernel driver in use: ohci-pci
>>>>
>>>> 00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
>>>> EHCI Controller (rev 39) (prog-if 20 [EHCI])
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin B routed to IRQ 17
>>>> Region 0: Memory at f094b000 (32-bit, non-prefetchable) [size=256]
>>>> Capabilities: [c0] Power Management version 2
>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Bridge: PM- B3+
>>>> Capabilities: [e4] Debug port: BAR=1 offset=00e0
>>>> Kernel driver in use: ehci-pci
>>>>
>>>> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 3a)
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx+
>>>> Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia
>>>> Controller (rev 02)
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx+
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 32, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 79
>>>> Region 0: Memory at f0944000 (64-bit, non-prefetchable) [size=16K]
>>>> Capabilities: [50] Power Management version 2
>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>> Address: 00000000fee0f00c  Data: 4172
>>>> Kernel driver in use: snd_hda_intel
>>>>
>>>> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 11)
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0
>>>>
>>>> 00:14.7 SD Host controller: Advanced Micro Devices, Inc. [AMD] FCH SD
>>>> Flash Controller (rev 01) (prog-if 01)
>>>> Subsystem: Acer Incorporated [ALI] Device 080d
>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 39, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 16
>>>> Region 0: Memory at f094a000 (64-bit, non-prefetchable) [size=256]
>>>> Kernel driver in use: sdhci-pci
>>>>
>>>> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 0
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 1
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 2
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 3
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Capabilities: [f0] Secure device <?>
>>>> Kernel driver in use: k10temp
>>>>
>>>> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 4
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Kernel driver in use: fam15h_power
>>>>
>>>> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
>>>> Processor Function 5
>>>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>
>>>> 01:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless
>>>> Network Adapter (rev 01)
>>>> Subsystem: Lite-On Communications Inc Device 0632
>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx-
>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> Latency: 0, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 32
>>>> Region 0: Memory at f0800000 (64-bit, non-prefetchable) [size=512K]
>>>> Expansion ROM at f0a00000 [disabled] [size=64K]
>>>> Capabilities: [40] Power Management version 2
>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>> Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
>>>> Address: 0000000000000000  Data: 0000
>>>> Masking: 00000000  Pending: 00000000
>>>> Capabilities: [70] Express (v2) Endpoint, MSI 00
>>>> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
>>>> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>>>> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
>>>> L0s <4us, L1 <64us
>>>> ClockPM- Surprise- LLActRep- BwNot-
>>>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>>>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>>>> BWMgmt- ABWMgmt-
>>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
>>>> Not Supported
>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>>>> Compliance De-emphasis: -6dB
>>>> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
>>>> EqualizationPhase1-
>>>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>> Capabilities: [100 v1] Advanced Error Reporting
>>>> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>>>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>>> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>>> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>>>> Capabilities: [140 v1] Virtual Channel
>>>> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
>>>> Arb: Fixed- WRR32- WRR64- WRR128-
>>>> Ctrl: ArbSelect=Fixed
>>>> Status: InProgress-
>>>> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>>> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>>> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>>>> Status: NegoPending- InProgress-
>>>> Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
>>>> Kernel driver in use: ath9k
>>>>
>>>>
>>>> [7.6.] SCSI information (from /proc/scsi/scsi)
>>>> Attached devices:
>>>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>>>   Vendor: ATA      Model: WDC WD5000LPVX-2 Rev: 01.0
>>>>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>>>>
>>>> [7.7.] Other information that might be relevant to the problem (please
>>>> look in /proc and include all information that you think to be
>>>> relevant):
>>>> 1
>>>> 10
>>>> 1043
>>>> 11
>>>> 1113
>>>> 1117
>>>> 1122
>>>> 1123
>>>> 1126
>>>> 1176
>>>> 118
>>>> 1186
>>>> 12
>>>> 1205
>>>> 1217
>>>> 1225
>>>> 1230
>>>> 13
>>>> 14
>>>> 1409
>>>> 1410
>>>> 1411
>>>> 1412
>>>> 1414
>>>> 1433
>>>> 1435
>>>> 1436
>>>> 1437
>>>> 144
>>>> 145
>>>> 146
>>>> 147
>>>> 15
>>>> 1502
>>>> 157
>>>> 158
>>>> 1580
>>>> 1598
>>>> 16
>>>> 1639
>>>> 1693
>>>> 17
>>>> 1734
>>>> 1762
>>>> 18
>>>> 19
>>>> 2
>>>> 20
>>>> 2011
>>>> 2013
>>>> 2067
>>>> 2073
>>>> 2081
>>>> 2085
>>>> 2086
>>>> 21
>>>> 2100
>>>> 2105
>>>> 2108
>>>> 2110
>>>> 2112
>>>> 2119
>>>> 2120
>>>> 2131
>>>> 2135
>>>> 2137
>>>> 2139
>>>> 2142
>>>> 2143
>>>> 2145
>>>> 2153
>>>> 2177
>>>> 2195
>>>> 2199
>>>> 22
>>>> 2201
>>>> 2206
>>>> 2209
>>>> 2213
>>>> 2218
>>>> 2220
>>>> 2225
>>>> 2247
>>>> 2249
>>>> 2251
>>>> 2269
>>>> 2299
>>>> 23
>>>> 2306
>>>> 2313
>>>> 2326
>>>> 2337
>>>> 2345
>>>> 2378
>>>> 2379
>>>> 2384
>>>> 2391
>>>> 24
>>>> 2411
>>>> 2434
>>>> 2442
>>>> 2449
>>>> 2459
>>>> 2463
>>>> 2468
>>>> 2485
>>>> 2488
>>>> 2489
>>>> 2490
>>>> 2494
>>>> 25
>>>> 2503
>>>> 2509
>>>> 2516
>>>> 2520
>>>> 2565
>>>> 2582
>>>> 2586
>>>> 2591
>>>> 26
>>>> 2669
>>>> 2688
>>>> 2695
>>>> 2710
>>>> 2715
>>>> 2721
>>>> 2743
>>>> 2757
>>>> 2775
>>>> 2794
>>>> 28
>>>> 2873
>>>> 2881
>>>> 2887
>>>> 29
>>>> 2953
>>>> 297
>>>> 2992
>>>> 3
>>>> 30
>>>> 304
>>>> 3064
>>>> 31
>>>> 3109
>>>> 32
>>>> 33
>>>> 338
>>>> 34
>>>> 348
>>>> 349
>>>> 35
>>>> 3511
>>>> 3513
>>>> 3516
>>>> 36
>>>> 37
>>>> 38
>>>> 39
>>>> 4
>>>> 40
>>>> 41
>>>> 42
>>>> 43
>>>> 441
>>>> 45
>>>> 46
>>>> 47
>>>> 475
>>>> 48
>>>> 49
>>>> 5
>>>> 51
>>>> 53
>>>> 54
>>>> 55
>>>> 563
>>>> 565
>>>> 642
>>>> 67
>>>> 68
>>>> 69
>>>> 7
>>>> 70
>>>> 71
>>>> 718
>>>> 72
>>>> 738
>>>> 744
>>>> 759
>>>> 760
>>>> 8
>>>> 801
>>>> 812
>>>> 816
>>>> 821
>>>> 827
>>>> 828
>>>> 846
>>>> 852
>>>> 854
>>>> 873
>>>> 9
>>>> 902
>>>> 905
>>>> 91
>>>> 92
>>>> acpi
>>>> asound
>>>> buddyinfo
>>>> bus
>>>> cgroups
>>>> cmdline
>>>> consoles
>>>> cpuinfo
>>>> crypto
>>>> devices
>>>> diskstats
>>>> dma
>>>> driver
>>>> execdomains
>>>> fb
>>>> filesystems
>>>> fs
>>>> interrupts
>>>> iomem
>>>> ioports
>>>> irq
>>>> kallsyms
>>>> kcore
>>>> key-users
>>>> kmsg
>>>> kpagecount
>>>> kpageflags
>>>> latency_stats
>>>> loadavg
>>>> locks
>>>> mdstat
>>>> meminfo
>>>> misc
>>>> modules
>>>> mounts
>>>> mtrr
>>>> net
>>>> pagetypeinfo
>>>> partitions
>>>> sched_debug
>>>> schedstat
>>>> scsi
>>>> self
>>>> slabinfo
>>>> softirqs
>>>> stat
>>>> swaps
>>>> sys
>>>> sysrq-trigger
>>>> sysvipc
>>>> timer_list
>>>> timer_stats
>>>> tty
>>>> uptime
>>>> version
>>>> vmallocinfo
>>>> vmstat
>>>> zoneinfo
>>>>
>>>> [X.] Other notes, patches, fixes, workarounds:
>>>> Launchpad bug report can be found at:
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1315834
>>>> I am happy to provide any additional iformaiton that might be useful.
>>>>
>>>>
>>>
>>
>>
>>
>



-- 
Lewis

Lewis@Toohey.co.uk
0782 588 4158
