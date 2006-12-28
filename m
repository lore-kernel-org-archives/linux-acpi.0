From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18
 and later
Date: Fri, 29 Dec 2006 00:03:20 +0300
Message-ID: <45943118.3030500@linux.intel.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:10246 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754967AbWL1VD1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Dec 2006 16:03:27 -0500
In-Reply-To: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

Please look at bugzilla.kernel.org #7570, it could be same issue.

Regards,
    Alex.

Matthew Brett wrote:
> Hi,
>
> CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
>
> On my emachines 370, the CPU fan stops immediately on load of fan.ko
> during boot up.  It does not seem to come back on again even on high
> CPU load and very hot heatsink.  Removing fan.ko from the drivers/acpi
> directory solves the problem, but insmodding fan.ko after boot again
> stops the fan. 2.6.17 vanilla does not show the problem, nor does
> 2.6.17-5mdv (Mandriva) but 2.6.18, 2.6.19.1, and 2.6.20-rc2 do. The
> problem seems to have been noticed before on Suse:
>
> http://www.suseforums.net/lofiversion/index.php/t28013.html
>
> The machine is an otherwise well behaved celeron 1.8, 1GB memory,
> with Trigem imperial GL VE motherboard, phoenix bios.
>
> Keywords: fan, cpu, acpi, driver
>
> To reproduce: boot sequence inserting fan.ko, or insmod fan.ko after
> boot.
>
> Other bug report details follow,
>
> Thanks a lot,
>
> Matthew
>
>
> Environment:
>
> Linux bob.dynevor.org 2.6.20-rc2emach #0 SMP Thu Dec 28 09:55:13 GMT
> 2006 i686 Intel(R) Celeron(R) CPU 1.80GHz GNU/Linux
>
> Gnu C                  4.1.1
> Gnu make               3.81
> binutils               2.16.91.0.7
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> PPP                    2.4.3
> Linux C Library        > libc.2.4
> Dynamic linker (ldd)   2.4
> Procps                 3.2.6
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.97
> udev                   098
> wireless-tools         28
> Modules Loaded         i915 drm autofs4 ipv6 usblp rfcomm snd_pcm_oss
> snd_mixer_oss snd_usb_audio snd_pcm snd_timer l2cap snd_page_alloc
> bluetooth snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd
> soundcore 8139too mii af_packet ide_cd binfmt_misc loop vfat fat
> dm_mod video thermal processor fan container button battery asus_acpi
> backlight ac cpufreq_ondemand cpufreq_conservative cpufreq_powersave
> p4_clockmod speedstep_lib freq_table intel_agp agpgart nvram sr_mod
> scsi_mod evdev tsdev usbmouse usbhid hid ehci_hcd ff_memless uhci_hcd
> usbcore ext3 jbd
>
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 1
> model name      : Intel(R) Celeron(R) CPU 1.80GHz
> stepping        : 3
> cpu MHz         : 1800.000
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
> bogomips        : 3584.28
>
> cat /proc/modules
> i915 24448 2 - Live 0xf8b9e000
> drm 71444 3 i915, Live 0xf8bac000
> autofs4 20740 1 - Live 0xf8b72000
> ipv6 242848 16 - Live 0xf8bdd000
> usblp 15232 0 - Live 0xf89ad000
> rfcomm 38552 2 - Live 0xf8b8a000
> snd_pcm_oss 40864 0 - Live 0xf8b7f000
> snd_mixer_oss 17536 1 snd_pcm_oss, Live 0xf8b6c000
> snd_usb_audio 75360 0 - Live 0xf8b44000
> snd_pcm 68996 2 snd_pcm_oss,snd_usb_audio, Live 0xf8b5a000
> snd_timer 21508 1 snd_pcm, Live 0xf8b3d000
> l2cap 26624 5 rfcomm, Live 0xf8b27000
> snd_page_alloc 11400 1 snd_pcm, Live 0xf8b11000
> bluetooth 50916 4 rfcomm,l2cap, Live 0xf8b2f000
> snd_usb_lib 17408 1 snd_usb_audio, Live 0xf8b18000
> snd_rawmidi 21920 1 snd_usb_lib, Live 0xf8afd000
> snd_seq_device 10252 1 snd_rawmidi, Live 0xf8af9000
> snd_hwdep 10500 1 snd_usb_audio, Live 0xf8af5000
> snd 45668 8 
> snd_pcm_oss,snd_mixer_oss,snd_usb_audio,snd_pcm,snd_timer,snd_rawmidi,snd_seq_device,snd_hwdep, 
>
> Live 0xf8b04000
> soundcore 9824 1 snd, Live 0xf8af1000
> 8139too 25344 0 - Live 0xf8ade000
> mii 8576 1 8139too, Live 0xf8ada000
> af_packet 23304 2 - Live 0xf89b7000
> ide_cd 37920 0 - Live 0xf8ae6000
> binfmt_misc 12680 1 - Live 0xf89b2000
> loop 16264 0 - Live 0xf8995000
> vfat 13952 0 - Live 0xf899a000
> fat 47772 1 vfat, Live 0xf8acd000
> dm_mod 50252 0 - Live 0xf89be000
> video 17668 0 - Live 0xf89a7000
> thermal 15240 0 - Live 0xf88ee000
> processor 28520 1 thermal, Live 0xf899f000
> fan 7556 0 - Live 0xf8992000
> container 7296 0 - Live 0xf898f000
> button 10000 0 - Live 0xf8985000
> battery 12036 0 - Live 0xf8981000
> asus_acpi 18972 0 - Live 0xf8989000
> backlight 8448 1 asus_acpi, Live 0xf88fa000
> ac 7812 0 - Live 0xf88f7000
> cpufreq_ondemand 10508 0 - Live 0xf88f3000
> cpufreq_conservative 9992 0 - Live 0xf88b4000
> cpufreq_powersave 5632 0 - Live 0xf88cb000
> p4_clockmod 8708 0 - Live 0xf88c7000
> speedstep_lib 7940 1 p4_clockmod, Live 0xf88bb000
> freq_table 7936 2 cpufreq_ondemand,p4_clockmod, Live 0xf88b8000
> intel_agp 24092 1 - Live 0xf88a7000
> agpgart 29128 3 drm,intel_agp, Live 0xf88be000
> nvram 11144 0 - Live 0xf8898000
> sr_mod 17828 0 - Live 0xf88ae000
> scsi_mod 122124 1 sr_mod, Live 0xf88cf000
> evdev 11904 1 - Live 0xf8894000
> tsdev 10048 0 - Live 0xf8890000
> usbmouse 8192 0 - Live 0xf885a000
> usbhid 36896 0 - Live 0xf889c000
> hid 27268 1 usbhid, Live 0xf887d000
> ehci_hcd 31500 0 - Live 0xf8887000
> ff_memless 8840 1 usbhid, Live 0xf881c000
> uhci_hcd 24080 0 - Live 0xf8825000
> usbcore 115720 8
> usblp,snd_usb_audio,snd_usb_lib,usbmouse,usbhid,ehci_hcd,uhci_hcd,
> Live 0xf883c000
> ext3 117128 1 - Live 0xf885f000
> jbd 52008 1 ext3, Live 0xf882e000
>
> cat /proc/ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : 0000:00:1f.1
>  0170-0177 : ide1
> 01f0-01f7 : 0000:00:1f.1
>  01f0-01f7 : ide0
> 0376-0376 : 0000:00:1f.1
>  0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : 0000:00:1f.1
>  03f6-03f6 : ide0
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> 1000-107f : 0000:00:1f.0
>  1000-107f : motherboard
>    1000-1003 : ACPI PM1a_EVT_BLK
>    1004-1005 : ACPI PM1a_CNT_BLK
>    1008-100b : ACPI PM_TMR
>    1010-1015 : ACPI CPU throttle
>    1020-1020 : ACPI PM2_CNT_BLK
>    1028-102f : ACPI GPE0_BLK
> 1180-11bf : 0000:00:1f.0
>  1180-11bf : motherboard
> 1800-181f : 0000:00:1d.0
>  1800-181f : uhci_hcd
> 1820-183f : 0000:00:1d.1
>  1820-183f : uhci_hcd
> 1840-185f : 0000:00:1d.2
>  1840-185f : uhci_hcd
> 1860-186f : 0000:00:1f.1
>  1860-1867 : ide0
>  1868-186f : ide1
> 1880-189f : 0000:00:1f.3
> 18c0-18ff : 0000:00:1f.5
> 1c00-1cff : 0000:00:1f.5
> 2000-2fff : PCI Bus #02
>  2000-20ff : 0000:02:02.0
>
> cat /proc/ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : 0000:00:1f.1
>  0170-0177 : ide1
> 01f0-01f7 : 0000:00:1f.1
>  01f0-01f7 : ide0
> 0376-0376 : 0000:00:1f.1
>  0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : 0000:00:1f.1
>  03f6-03f6 : ide0
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> 1000-107f : 0000:00:1f.0
>  1000-107f : motherboard
>    1000-1003 : ACPI PM1a_EVT_BLK
>    1004-1005 : ACPI PM1a_CNT_BLK
>    1008-100b : ACPI PM_TMR
>    1010-1015 : ACPI CPU throttle
>    1020-1020 : ACPI PM2_CNT_BLK
>    1028-102f : ACPI GPE0_BLK
> 1180-11bf : 0000:00:1f.0
>  1180-11bf : motherboard
> 1800-181f : 0000:00:1d.0
>  1800-181f : uhci_hcd
> 1820-183f : 0000:00:1d.1
>  1820-183f : uhci_hcd
> 1840-185f : 0000:00:1d.2
>  1840-185f : uhci_hcd
> 1860-186f : 0000:00:1f.1
>  1860-1867 : ide0
>  1868-186f : ide1
> 1880-189f : 0000:00:1f.3
> 18c0-18ff : 0000:00:1f.5
> 1c00-1cff : 0000:00:1f.5
> 2000-2fff : PCI Bus #02
>  2000-20ff : 0000:02:02.0
>    2000-20ff : 8139too
> fe00-fe00 : motherboard
> [root@bob ~]#
> [root@bob ~]# cat /proc/iomem
> 00000000-0009efff : System RAM
>  00000000-00000000 : Crash kernel
> 0009f000-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-3fceffff : System RAM
>  00100000-002e9ef0 : Kernel code
>  002e9ef1-003a23f3 : Kernel data
> 3fcf0000-3fcfefff : ACPI Tables
> 3fcff000-3fcfffff : ACPI Non-volatile Storage
> 3fd00000-3fe7ffff : System RAM
> 3fe80000-3fffffff : reserved
> 50000000-500003ff : 0000:00:1f.1
> e8000000-e807ffff : 0000:00:02.0
> e8080000-e80803ff : 0000:00:1d.7
>  e8080000-e80803ff : ehci_hcd
> e8080800-e80808ff : 0000:00:1f.5
> e8080c00-e8080dff : 0000:00:1f.5
> e8100000-e81fffff : PCI Bus #02
>  e8100000-e81000ff : 0000:02:02.0
>    e8100000-e81000ff : 8139too
> ec000000-efffffff : 0000:00:00.0
> f0000000-f7ffffff : 0000:00:02.0
> ff800000-ffbfffff : reserved
> fff00000-ffffffff : reserved
>
> lspci -vvv
> 00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE
> DRAM Controller/Host-Hub Interface (rev 01)
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>        Latency: 0
>        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
>        Capabilities: [e4] Vendor Specific Information
>
> 00:02.0 VGA compatible controller: Intel Corporation
> 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 01)
> (prog-if 00 [VGA])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 17
>        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>        Region 1: Memory at e8000000 (32-bit, non-prefetchable) 
> [size=512K]
>        Capabilities: [d0] Power Management version 1
>                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00
> [UHCI])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 17
>        Region 4: I/O ports at 1800 [size=32]
>
> 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00
> [UHCI])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin B routed to IRQ 18
>        Region 4: I/O ports at 1820 [size=32]
>
> 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00
> [UHCI])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin C routed to IRQ 16
>        Region 4: I/O ports at 1840 [size=32]
>
> 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
> USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin D routed to IRQ 19
>        Region 0: Memory at e8080000 (32-bit, non-prefetchable) [size=1K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
> (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>        Latency: 0
>        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>        I/O behind bridge: 00002000-00002fff
>        Memory behind bridge: e8100000-e81fffff
>        Prefetchable memory behind bridge: fff00000-000fffff
>        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>
> 00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC
> Interface Bridge (rev 01)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>
> 00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller
> (rev 01) (prog-if 8a [Master SecP PriP])
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 16
>        Region 0: I/O ports at 01f0 [size=8]
>        Region 1: I/O ports at 03f4 [size=1]
>        Region 2: I/O ports at 0170 [size=8]
>        Region 3: I/O ports at 0374 [size=1]
>        Region 4: I/O ports at 1860 [size=16]
>        Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]
>
> 00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> SMBus Controller (rev 01)
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin B routed to IRQ 9
>        Region 4: I/O ports at 1880 [size=32]
>
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin B routed to IRQ 9
>        Region 0: I/O ports at 1c00 [size=256]
>        Region 1: I/O ports at 18c0 [size=64]
>        Region 2: Memory at e8080c00 (32-bit, non-prefetchable) [size=512]
>        Region 3: Memory at e8080800 (32-bit, non-prefetchable) [size=256]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>        Subsystem: Trigem Computer Inc. Unknown device 3189
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (8000ns min, 16000ns max)
>        Interrupt: pin A routed to IRQ 20
>        Region 0: I/O ports at 2000 [size=256]
>        Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=256]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
