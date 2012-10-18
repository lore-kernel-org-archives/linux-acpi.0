From: joeyli <jlee@suse.com>
Subject: Re: Screen backlight problem on HP Folio 13-1050la
Date: Thu, 18 Oct 2012 15:32:17 +0800
Message-ID: <1350545537.29823.75.camel@linux-s257.site>
References: <CAC=LiNNtQue1Pzy9RtY5OAsizkTVux1nnYxCHr86cBwiXnPRyA@mail.gmail.com>
	 <CAC=LiNOSH_3wkKxS3VQxLR3vRgfZxNgKd-dKx55ZXS_KNFD0oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44174 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab2JRHkG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Oct 2012 03:40:06 -0400
In-Reply-To: <CAC=LiNOSH_3wkKxS3VQxLR3vRgfZxNgKd-dKx55ZXS_KNFD0oQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guillaume Pothier <gpothier@gmail.com>
Cc: linux-acpi@vger.kernel.org, christopher.penalver@gmx.com

Hi Guillaume,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2012-10-17 =E6=96=BC 15:11 -0300=EF=BC=8CGu=
illaume Pothier =E6=8F=90=E5=88=B0=EF=BC=9A
> [1.]
> Screen backlight problem on HP Folio 13-1050la
>=20
> [2.]
> On an HP Folio 13, the monitor's backlight is turned off on startup. =
Going
> to the gnome brightness settings (using an external monitor) allows t=
o turn
> it on.
>=20
> WORKAROUND: Add a kernel parameter through grub's config to make it w=
ork:
> acpi_backlight=3Dvendor
>=20
> See http://labo.eliaz.fr/spip.php?article94
>=20

Please try 'video.use_bios_initial_backlight=3D0' kernel parameter.


Thanks
Joey Lee

>=20
> [3.]
> backlight, HP Folio 13
>=20
> [4.]
> Linux version 3.6.2-030602-generic (apw@gomeisa) (gcc version 4.6.3
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201210121823 SMP Fri Oct 12 22:24:1=
8 UTC
> 2012
>=20
> [7.]
> Description: Ubuntu 12.10
> Release: 12.10
>=20
> [7.1.]
> Linux tadzim2 3.6.2-030602-generic #201210121823 SMP Fri Oct 12 22:24=
:18 UTC
> 2012 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Gnu C                  4.7
> Gnu make               3.81
> binutils               2.22.90.20120924
> util-linux             2.20.1
> mount                  support
> module-init-tools      3.16
> e2fsprogs              1.42.5
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.15
> Dynamic linker (ldd)   2.15
> Procps                 3.3.3
> Net-tools              1.60
> Kbd                    1.15.3
> Sh-utils               8.13
> wireless-tools         30
> Modules Loaded         hid_generic hidp snd_hda_codec_hdmi snd_hda_co=
dec_idt
> joydev btusb uvcvideo videobuf2_core videodev videobuf2_vmalloc
> videobuf2_memops arc4 iwldvm hid_monterey mac80211 snd_hda_intel rfco=
mm bnep
> snd_hda_codec bluetooth snd_hwdep hp_wmi usbhid hid sparse_keymap snd=
_pcm
> parport_pc ppdev snd_seq_midi snd_rawmidi coretemp snd_seq_midi_event
> kvm_intel snd_seq kvm i915 snd_timer ghash_clmulni_intel snd_seq_devi=
ce
> drm_kms_helper aesni_intel drm ablk_helper cryptd snd iwlwifi aes_x86=
_64
> psmouse cfg80211 microcode rts_pstor serio_raw i2c_algo_bit mei sound=
core
> snd_page_alloc r8169 lpc_ich sdhci_pci sdhci wmi mac_hid video lp par=
port
>=20
> [7.2]
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 42
> model name : Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
> stepping : 7
> microcode : 0x25
> cpu MHz : 800.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_ts=
c
> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16=
 xtpr
> pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave av=
x
> lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexprio=
rity
> ept vpid
> bogomips : 3192.80
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>=20
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 42
> model name : Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
> stepping : 7
> microcode : 0x25
> cpu MHz : 800.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_ts=
c
> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16=
 xtpr
> pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave av=
x
> lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexprio=
rity
> ept vpid
> bogomips : 3192.80
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>=20
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 42
> model name : Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
> stepping : 7
> microcode : 0x25
> cpu MHz : 800.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 2
> initial apicid : 2
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_ts=
c
> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16=
 xtpr
> pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave av=
x
> lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexprio=
rity
> ept vpid
> bogomips : 3192.80
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>=20
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 42
> model name : Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
> stepping : 7
> microcode : 0x25
> cpu MHz : 1601.000
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 3
> initial apicid : 3
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_ts=
c
> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16=
 xtpr
> pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave av=
x
> lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexprio=
rity
> ept vpid
> bogomips : 3192.80
> clflush size : 64
> cache_alignment : 64
> address sizes : 36 bits physical, 48 bits virtual
> power management:
>=20
>=20
> [7.3]
> hid_generic 12493 0 - Live 0x0000000000000000
> hidp 22562 1 - Live 0x0000000000000000
> snd_hda_codec_hdmi 32506 1 - Live 0x0000000000000000
> snd_hda_codec_idt 70773 1 - Live 0x0000000000000000
> joydev 17693 0 - Live 0x0000000000000000
> btusb 18291 0 - Live 0x0000000000000000
> uvcvideo 82212 0 - Live 0x0000000000000000
> videobuf2_core 36094 1 uvcvideo, Live 0x0000000000000000
> videodev 120715 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
> videobuf2_vmalloc 12860 1 uvcvideo, Live 0x0000000000000000
> videobuf2_memops 13368 1 videobuf2_vmalloc, Live 0x0000000000000000
> arc4 12573 2 - Live 0x0000000000000000
> iwldvm 249157 0 - Live 0x0000000000000000
> hid_monterey 12667 0 - Live 0x0000000000000000
> mac80211 564631 1 iwldvm, Live 0x0000000000000000
> snd_hda_intel 34147 3 - Live 0x0000000000000000
> rfcomm 47922 12 - Live 0x0000000000000000
> bnep 18315 2 - Live 0x0000000000000000
> snd_hda_codec 135374 3 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_i=
ntel,
> Live 0x0000000000000000
> bluetooth 218412 27 hidp,btusb,rfcomm,bnep, Live 0x0000000000000000
> snd_hwdep 13668 1 snd_hda_codec, Live 0x0000000000000000
> hp_wmi 18092 0 - Live 0x0000000000000000
> usbhid 47307 0 - Live 0x0000000000000000
> hid 100612 4 hid_generic,hidp,hid_monterey,usbhid, Live 0x00000000000=
00000
> sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
> snd_pcm 97661 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
> 0x0000000000000000
> parport_pc 32866 0 - Live 0x0000000000000000
> ppdev 17113 0 - Live 0x0000000000000000
> snd_seq_midi 13324 0 - Live 0x0000000000000000
> snd_rawmidi 30749 1 snd_seq_midi, Live 0x0000000000000000
> coretemp 13554 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> kvm_intel 137895 0 - Live 0x0000000000000000
> snd_seq 61897 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000=
000
> kvm 437435 1 kvm_intel, Live 0x0000000000000000
> i915 550154 4 - Live 0x0000000000000000
> snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
> ghash_clmulni_intel 13180 0 - Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
> 0x0000000000000000
> drm_kms_helper 46931 1 i915, Live 0x0000000000000000
> aesni_intel 50947 2 - Live 0x0000000000000000
> drm 277074 5 i915,drm_kms_helper, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> cryptd 20530 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> snd 79391 16
> snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_=
hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
> Live 0x0000000000000000
> iwlwifi 167779 1 iwldvm, Live 0x0000000000000000
> aes_x86_64 17208 1 aesni_intel, Live 0x0000000000000000
> psmouse 92362 0 - Live 0x0000000000000000
> cfg80211 212917 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
> microcode 23040 0 - Live 0x0000000000000000
> rts_pstor 445272 0 - Live 0x0000000000000000 (C)
> serio_raw 13215 0 - Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> mei 41409 0 - Live 0x0000000000000000
> soundcore 15091 1 snd, Live 0x0000000000000000
> snd_page_alloc 18572 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
> r8169 68885 0 - Live 0x0000000000000000
> lpc_ich 17144 0 - Live 0x0000000000000000
> sdhci_pci 18748 0 - Live 0x0000000000000000
> sdhci 33144 1 sdhci_pci, Live 0x0000000000000000
> wmi 19256 1 hp_wmi, Live 0x0000000000000000
> mac_hid 13253 0 - Live 0x0000000000000000
> video 19412 1 i915, Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> parport 46562 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>=20
> [7.4]
> gpothier@tadzim2:~$ cat /proc/ioports
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
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0460-047f : iTCO_wdt
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   2000-2fff : PCI Bus 0000:03
>   3000-3fff : PCI Bus 0000:01
>     3000-30ff : 0000:01:00.0
>       3000-30ff : r8169
>   4000-403f : 0000:00:02.0
>   4040-405f : 0000:00:1f.3
>   4060-407f : 0000:00:1f.2
>     4060-407f : ahci
>   4080-4087 : 0000:00:1f.2
>     4080-4087 : ahci
>   4088-408f : 0000:00:1f.2
>     4088-408f : ahci
>   4090-4093 : 0000:00:1f.2
>     4090-4093 : ahci
>   4094-4097 : 0000:00:1f.2
>     4094-4097 : ahci
> gpothier@tadzim2:~$ cat /proc/iomem
> 00000000-0000ffff : reserved
> 00010000-0009d7ff : System RAM
> 0009d800-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
>   000a6d60-000b4d5f : efifb
> 000c0000-000cf1ff : Video ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-aa86cfff : System RAM
>   01000000-016ab6aa : Kernel code
>   016ab6ab-01ce033f : Kernel data
>   01dd7000-01f31fff : Kernel bss
> aa86d000-aaa97fff : reserved
> aaa98000-acdd8fff : System RAM
> acdd9000-ace1afff : reserved
> ace1b000-ace3efff : System RAM
> ace3f000-acebefff : reserved
> acebf000-acfbefff : ACPI Non-volatile Storage
> acfbf000-acffefff : ACPI Tables
> acfff000-acffffff : System RAM
> ad000000-af9fffff : reserved
> afa00000-feafffff : PCI Bus 0000:00
>   afa00000-afa00fff : pnp 00:07
>   b0000000-bfffffff : 0000:00:02.0
>   c0000000-c03fffff : 0000:00:02.0
>   c0400000-c04fffff : PCI Bus 0000:01
>     c0400000-c0403fff : 0000:01:00.0
>       c0400000-c0403fff : r8169
>     c0404000-c0404fff : 0000:01:00.0
>       c0404000-c0404fff : r8169
>   c0500000-c14fffff : PCI Bus 0000:03
>   c1500000-c15fffff : PCI Bus 0000:09
>     c1500000-c150ffff : 0000:09:00.0
>       c1500000-c150ffff : xhci_hcd
>     c1510000-c1510fff : 0000:09:00.0
>     c1511000-c1511fff : 0000:09:00.0
>   c1600000-c25fffff : PCI Bus 0000:03
>     c1600000-c16000ff : 0000:03:00.1
>       c1600000-c16000ff : mmc0
>     c1601000-c1601fff : 0000:03:00.0
>       c1601000-c1601fff : rts_pstor
>   c2600000-c26fffff : PCI Bus 0000:02
>     c2600000-c2601fff : 0000:02:00.0
>       c2600000-c2601fff : iwlwifi
>   c2700000-c2703fff : 0000:00:1b.0
>     c2700000-c2703fff : ICH HD audio
>   c2704000-c270400f : 0000:00:16.0
>     c2704000-c270400f : mei
>   c2705000-c27050ff : 0000:00:1f.3
>   c2707000-c27077ff : 0000:00:1f.2
>     c2707000-c27077ff : ahci
>   c2708000-c27083ff : 0000:00:1d.0
>     c2708000-c27083ff : ehci_hcd
>   c2709000-c27093ff : 0000:00:1a.0
>     c2709000-c27093ff : ehci_hcd
>   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>     e0000000-efffffff : reserved
>       e0000000-efffffff : pnp 00:07
> feb00000-feb03fff : reserved
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
> fed10000-fed19fff : reserved
>   fed10000-fed17fff : pnp 00:07
>   fed18000-fed18fff : pnp 00:07
>   fed19000-fed19fff : pnp 00:07
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:07
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:07
> fed90000-fed93fff : pnp 00:07
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ffd80000-ffffffff : reserved
> 100000000-14fdfffff : System RAM
> 14fe00000-14fffffff : RAM buffer
>=20
> [7.5]
>=20
> 00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Fa=
mily
> PCI Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D03, subordinate=3D08, sec-latency=3D0
> I/O behind bridge: 00002000-00002fff
> Memory behind bridge: c1600000-c25fffff
> Prefetchable memory behind bridge: 00000000c0500000-00000000c14fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512n=
s, L1
> <16us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWM=
gmt+
> ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Select=
able
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Hewlett-Packard Company Device 17f8
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
> Kernel modules: shpchp
>=20
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Fa=
mily
> PCI Express Root Port 5 (rev b4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D09, subordinate=3D09, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: c1500000-c15fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> ExtTag- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512n=
s, L1
> <16us
> ClockPM- Surprise- LLActRep+ BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgm=
t+
> ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Select=
able
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Hewlett-Packard Company Device 17f8
> Capabilities: [a0] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
> Kernel modules: shpchp
>=20
> 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipse=
t
> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at c2708000 (32-bit, non-prefetchable) [size=3D1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci_hcd
>=20
> 00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC
> Controller (rev 04)
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> Kernel driver in use: lpc_ich
> Kernel modules: lpc_ich
>=20
> 00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chips=
et
> Family 6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI 1.0])
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 40
> Region 0: I/O ports at 4088 [size=3D8]
> Region 1: I/O ports at 4094 [size=3D4]
> Region 2: I/O ports at 4080 [size=3D8]
> Region 3: I/O ports at 4090 [size=3D4]
> Region 4: I/O ports at 4060 [size=3D32]
> Region 5: Memory at c2707000 (32-bit, non-prefetchable) [size=3D2K]
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee0300c  Data: 4191
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> Capabilities: [b0] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ahci
>=20
> 00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family =
SMBus
> Controller (rev 04)
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort-
> <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 10
> Region 0: Memory at c2705000 (64-bit, non-prefetchable) [size=3D256]
> Region 4: I/O ports at 4040 [size=3D32]
> Kernel modules: i2c-i801
>=20
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/=
8168B
> PCI Express Gigabit Ethernet controller (rev 06)
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 46
> Region 0: I/O ports at 3000 [size=3D256]
> Region 2: Memory at c0404000 (64-bit, prefetchable) [size=3D4K]
> Region 4: Memory at c0400000 (64-bit, prefetchable) [size=3D16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4122
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64=
us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 unl=
imited,
> L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt-
> ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
> Vector table: BAR=3D4 offset=3D00000000
> PBA: BAR=3D4 offset=3D00000800
> Capabilities: [d0] Vital Product Data
> No end tag found
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq+ ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+
> ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=3DFixed
> Status: InProgress-
> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 95-00-00-00-68-4c-e0-00
> Kernel driver in use: r8169
> Kernel modules: r8169
>=20
> 02:00.0 Network controller: Intel Corporation Centrino Wireless-N 103=
0 (rev
> 34)
> Subsystem: Intel Corporation Centrino Wireless-N 1030 BGN
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 48
> Region 0: Memory at c2600000 (64-bit, non-prefetchable) [size=3D8K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0100c  Data: 4152
> Capabilities: [e0] Express (v1) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unl=
imited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4u=
s, L1
> <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt-
> ABWMgmt-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+
> ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Device Serial Number 4c-eb-42-ff-ff-9d-d5-d2
> Kernel driver in use: iwlwifi
> Kernel modules: iwlwifi
>=20
> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5=
209 PCI
> Express Card Reader (rev 01)
> Subsystem: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card R=
eader
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 19
> Region 0: Memory at c1601000 (32-bit, non-prefetchable) [size=3D4K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+=
,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [70] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 unl=
imited,
> L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt-
> ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+
> ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
> Kernel driver in use: rts_pstor
> Kernel modules: rts_pstor
>=20
> 03:00.1 SD Host controller: Realtek Semiconductor Co., Ltd. RTS5209 P=
CI
> Express Card Reader (rev 01)
> Subsystem: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card R=
eader
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin B routed to IRQ 16
> Region 0: Memory at c1600000 (32-bit, non-prefetchable) [size=3D256]
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+=
,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [b0] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 unl=
imited,
> L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt-
> ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+
> ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
> Kernel driver in use: sdhci-pci
> Kernel modules: sdhci-pci
>=20
> 09:00.0 USB controller: Fresco Logic Device 1009 (rev 02) (prog-if 30
> [XHCI])
> Subsystem: Hewlett-Packard Company Device 17f8
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAb=
ort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at c1500000 (64-bit, non-prefetchable) [size=3D64K]
> Region 2: Memory at c1510000 (64-bit, non-prefetchable) [size=3D4K]
> Region 4: Memory at c1511000 (64-bit, non-prefetchable) [size=3D4K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA PME(D0+,D1+,D2-,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [70] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1
> unlimited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 unlim=
ited,
> L1 unlimited
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgm=
t-
> ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Select=
able
> De-emphasis: -6dB
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable+ Count=3D8 Masked-
> Vector table: BAR=3D2 offset=3D00000000
> PBA: BAR=3D4 offset=3D00000000
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP-
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+
> ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Kernel driver in use: xhci_hcd
>=20
> [7.6]
> gpothier@tadzim2:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: SAMSUNG MZMPC128 Rev: CXM1
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi6 Channel: 00 Id: 00 Lun: 00
>   Vendor: Generic- Model: xD/SD/M.S.       Rev: 1.00
>   Type:   Direct-Access                    ANSI  SCSI revision: 02
>=20
> [7.7]
> gpothier@tadzim2:~$ ls /proc
> 1     1618  2012  2252  2489  298  568  889        execdomains    sch=
edstat
> 10    17    2013  2253  2496  3    58   89         fb             scs=
i
> 11    1760  2017  2257  25    30   59   894        filesystems    sel=
f
> 1100  18    202   2258  2517  303  60   895        fs             sla=
binfo
> 1125  1897  2022  2279  2551  31   61   9          interrupts     sof=
tirqs
> 1133  19    203   2297  2555  32   62   90         iomem          sta=
t
> 1149  1908  204   23    2557  33   63   91         ioports        swa=
ps
> 1152  194   2045  2309  2558  34   633  916        irq            sys
> 1160  1943  2052  2312  26    35   65   919        kallsyms
> sysrq-trigger
> 1187  1946  2076  2322  2659  36   679  92         kcore          sys=
vipc
> 1188  1947  2094  2324  2662  38   68   923        key-users      tim=
er_list
> 1189  1949  21    2327  2679  39   69   924        kmsg
> timer_stats
> 1191  1953  2102  2328  27    4    7    970        kpagecount     tty
> 1192  1956  2110  2334  2704  40   708  acpi       kpageflags     upt=
ime
> 12    1970  2117  2335  2721  41   746  asound     latency_stats  ver=
sion
> 1202  1975  2121  2336  2732  42   765  buddyinfo  loadavg
> vmallocinfo
> 1211  1979  2180  2337  2746  43   772  bus        locks          vms=
tat
> 1260  1990  2193  2341  2747  44   778  cgroups    mdstat         zon=
einfo
> 13    1995  2195  2385  2752  5    780  cmdline    meminfo
> 1375  2     22    24    2754  507  783  consoles   misc
> 1388  20    2203  2402  28    53   788  cpuinfo    modules
> 14    2000  2205  2403  2808  54   795  crypto     mounts
> 1406  2002  2206  2410  29    55   8    devices    mtrr
> 15    2004  2228  2441  2900  556  801  diskstats  net
> 1546  2005  2230  2444  2904  563  846  dma        pagetypeinfo
> 1551  2009  2246  2445  2905  566  853  dri        partitions
> 1613  2010  2250  2483  2914  567  854  driver     sched_debug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
