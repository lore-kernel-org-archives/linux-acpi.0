From: Janosch Machowinski <scotch@tzi.de>
Subject: First battery not detected with 2.6.21-rc1
Date: Fri, 23 Feb 2007 20:37:46 +0100
Message-ID: <45DF428A.8070700@tzi.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080106090401000602080005"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:54446 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933187AbXBWThu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 14:37:50 -0500
Received: from [192.168.0.28] (dslc-082-082-087-063.pools.arcor-ip.net [82.82.87.63])
	(authenticated bits=0)
	by informatik.uni-bremen.de (8.14.0/8.13.2) with ESMTP id l1NJbkl9018120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Feb 2007 20:37:47 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106090401000602080005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hey,
I get some strange errors with 2.6.21-rc1 on an Asus M6Ne. My fist 
battery is not detected (no entry in /proc/acpi/battery) and there are 
some strange looking ACPI errors during harddisk detection. Dmesg is 
attached. Any ideas or patches I should try ?

	Janosch



--------------080106090401000602080005
Content-Type: text/plain;
 name="error.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error.log"

f900000-ff9fffff
[   21.980923]   PREFETCH window: dea00000-deafffff
[   21.980995] PCI: Enabling device 0000:00:1e.0 (0106 -> 0107)
[   21.981061] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   21.981078] PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
[   21.981839] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
[   21.981902] PCI: setting IRQ 4 as level-triggered
[   21.981909] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
[   21.982076] PCI: Setting latency timer of device 0000:02:01.0 to 64
[   21.982772] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   21.982834] PCI: setting IRQ 11 as level-triggered
[   21.982841] ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   21.983007] PCI: Setting latency timer of device 0000:02:01.1 to 64
[   21.983043] NET: Registered protocol family 2
[   22.063775] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   22.063914] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   22.064234] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   22.064436] TCP: Hash tables configured (established 16384 bind 16384)
[   22.064499] TCP reno registered
[   22.093962] checking if image is initramfs... it is
[   22.096815] Freeing initrd memory: 10k freed
[   22.096979] Machine check exception polling timer started.
[   22.097809] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   22.098071] NTFS driver 2.1.28 [Flags: R/O].
[   22.098169] fuse init (API version 7.8)
[   22.098358] io scheduler noop registered
[   22.098461] io scheduler anticipatory registered (default)
[   22.098608] io scheduler deadline registered
[   22.098723] io scheduler cfq registered
[   22.100531] ACPI: AC Adapter [AC] (off-line)
[   22.232334] ACPI: Battery Slot [BAT1] (battery present)
[   22.232573] input: Power Button (FF) as /class/input/input0
[   22.232636] ACPI: Power Button (FF) [PWRF]
[   22.233610] input: Lid Switch as /class/input/input1
[   22.233682] ACPI: Lid Switch [LID]
[   22.233856] input: Sleep Button (CM) as /class/input/input2
[   22.233918] ACPI: Sleep Button (CM) [SLPB]
[   22.234084] input: Power Button (CM) as /class/input/input3
[   22.234146] ACPI: Power Button (CM) [PWRB]
[   22.234557] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   22.234737] ACPI: Invalid PBLK length [7]
[   22.236803] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   22.264306] ACPI: Thermal Zone [THRM] (56 C)
[   22.264462] Asus Laptop ACPI Extras version 0.30
[   22.264838]   M6NE model detected, supported
[   22.323918] lp: driver loaded but no devices found
[   22.324012] intel_rng: FWH not detected
[   22.324071] Linux agpgart interface v0.102 (c) Dave Jones
[   22.324202] agpgart: Detected an Intel 855PM Chipset.
[   22.340657] agpgart: AGP aperture is 256M @ 0xe0000000
[   22.340755] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   22.341169] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
[   22.342342] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
[   22.342600] parport: PnPBIOS parport detected.
[   22.342688] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
[   22.343078] lp0: using parport0 (interrupt-driven).
[   22.344205] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   22.344726] loop: loaded (max 8 devices)
[   22.344921] tg3.c:v3.73 (February 12, 2007)
[   22.344996] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
[   22.408789] eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:11:2f:8d:b2:b5
[   22.409130] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
[   22.409204] eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   22.409414] PPP generic driver version 2.4.2
[   22.409701] ata_piix 0000:00:1f.1: version 2.00ac7
[   22.409717] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   22.409782] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[   22.409960] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   22.410032] ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
[   22.410142] ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
[   22.410236] scsi0 : ata_piix
[   22.583969] ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
[   22.584136] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c14776d0), AE_AML_OPERAND_VALUE
[   22.584457] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node c1479d9c), AE_AML_OPERAND_VALUE
[   22.584769] ata1.00: ATA-6: IC25N060ATMR04-0, MO3OAD4A, max UDMA/100
[   22.584833] ata1.00: 117210240 sectors, multi 16: LBA48 
[   22.603861] ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
[   22.604025] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c14776d0), AE_AML_OPERAND_VALUE
[   22.604333] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node c1479d9c), AE_AML_OPERAND_VALUE
[   22.604642] ata1.00: configured for UDMA/100
[   22.604708] scsi1 : ata_piix
[   22.763713] scsi 0:0:0:0: Direct-Access     ATA      IC25N060ATMR04-0 MO3O PQ: 0 ANSI: 5
[   22.763931] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   22.764052] sda: Write Protect is off
[   22.764111] sda: Mode Sense: 00 3a 00 00
[   22.764140] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   22.764278] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   22.764353] sda: Write Protect is off
[   22.764411] sda: Mode Sense: 00 3a 00 00
[   22.764439] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   22.764513]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   22.827901] sd 0:0:0:0: Attached scsi disk sda
[   22.828065] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   22.828270] ieee1394: raw1394: /dev/raw1394 device initialized
[   22.828440] Yenta: CardBus bridge found at 0000:02:01.0 [1043:1864]
[   22.963884] Yenta: ISA IRQ mask 0x0028, PCI irq 4
[   22.963945] Socket status: 30000006
[   22.964004] Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
[   22.964078] pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
[   22.964141] cs: IO port probe 0x1000-0x1fff: clean.
[   22.964812] pcmcia: parent PCI bridge Memory window: 0xff900000 - 0xff9fffff
[   22.964877] pcmcia: parent PCI bridge Memory window: 0xdea00000 - 0xdeafffff
[   23.223369] Yenta: CardBus bridge found at 0000:02:01.1 [1043:1864]
[   23.363644] Yenta: ISA IRQ mask 0x0028, PCI irq 11
[   23.363704] Socket status: 30000006
[   23.363763] Yenta: Raising subordinate bus# of parent bus (#02) from #06 to #0a
[   23.363836] pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
[   23.363899] cs: IO port probe 0x1000-0x1fff: clean.
[   23.364567] pcmcia: parent PCI bridge Memory window: 0xff900000 - 0xff9fffff
[   23.364632] pcmcia: parent PCI bridge Memory window: 0xdea00000 - 0xdeafffff
[   23.623237] usbmon: debugfs is not available
[   23.624082] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
[   23.624146] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
[   23.624316] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   23.624324] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   23.624474] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   23.624595] ehci_hcd 0000:00:1d.7: debug port 1
[   23.624660] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   23.624673] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xffaffc00
[   23.628614] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   23.628903] usb usb1: configuration #1 chosen from 1 choice
[   23.629033] hub 1-0:1.0: USB hub found
[   23.629101] hub 1-0:1.0: 6 ports detected
[   23.733365] USB Universal Host Controller Interface driver v3.0
[   23.733488] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   23.733656] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   23.733664] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   23.733785] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   23.733880] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000e800
[   23.734162] usb usb2: configuration #1 chosen from 1 choice
[   23.734292] hub 2-0:1.0: USB hub found
[   23.734359] hub 2-0:1.0: 2 ports detected
[   23.844021] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
[   23.844085] PCI: setting IRQ 5 as level-triggered
[   23.844092] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
[   23.844259] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   23.844267] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   23.844389] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   23.844485] uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000e880
[   23.844768] usb usb3: configuration #1 chosen from 1 choice
[   23.844899] hub 3-0:1.0: USB hub found
[   23.844966] hub 3-0:1.0: 2 ports detected
[   23.953280] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[   23.953448] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   23.953455] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   23.953571] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   23.953665] uhci_hcd 0000:00:1d.2: irq 10, io base 0x0000ec00
[   23.953944] usb usb4: configuration #1 chosen from 1 choice
[   23.954077] hub 4-0:1.0: USB hub found
[   23.954143] hub 4-0:1.0: 2 ports detected
[   24.063300] usbcore: registered new interface driver usblp
[   24.063363] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   24.063427] Initializing USB Mass Storage driver...
[   24.063538] usbcore: registered new interface driver usb-storage
[   24.063600] USB Mass Storage support registered.
[   24.063714] usbcore: registered new interface driver usbhid
[   24.063776] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   24.063971] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f12:PS2M] at 0x60,0x64 irq 1,12
[   24.066601] i8042.c: Detected active multiplexing controller, rev 1.1.
[   24.067999] serio: i8042 KBD port at 0x60,0x64 irq 1
[   24.068100] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   24.068162] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   24.068223] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   24.068285] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   24.068582] mice: PS/2 mouse device common for all mice
[   24.097569] input: AT Translated Set 2 keyboard as /class/input/input4
[   24.143240] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800031fe66b]
[   24.226733] sdhci: Secure Digital Host Controller Interface driver
[   24.226796] sdhci: Copyright(c) Pierre Ossman
[   24.257008] Advanced Linux Sound Architecture Driver Version 1.0.14rc2 (Wed Feb 14 07:42:13 2007 UTC).
[   24.257548] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
[   24.257733] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   24.893044] Synaptics Touchpad, model: 1, fw: 4.6, id: 0x925ea1, caps: 0x80471b/0x0
[   24.933134] input: SynPS/2 Synaptics TouchPad as /class/input/input5
[   25.102708] intel8x0_measure_ac97_clock: measured 60001 usecs
[   25.102771] intel8x0: clocking to 48000
[   25.104327] ALSA device list:
[   25.104386]   #0: Intel 82801DB-ICH4 with STAC9750,51 at irq 4
[   25.104607] TCP cubic registered
[   25.104675] NET: Registered protocol family 1
[   25.104736] NET: Registered protocol family 17
[   25.105243] speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
[   25.105248]  Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
[    9.403531] Using IPI Shortcut mode
[    9.410530] Time: acpi_pm clocksource has been installed.
[    9.428338] kjournald starting.  Commit interval 5 seconds
[    9.428399] EXT3-fs: mounted filesystem with ordered data mode.
[    9.428478] VFS: Mounted root (ext3 filesystem) readonly.
[    9.428661] Freeing unused kernel memory: 228k freed
[    9.550321] Clocksource tsc unstable (delta = 244793800 ns)
[   14.844078] ieee80211_crypt: registered algorithm 'NULL'
[   14.845288] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   14.845291] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   14.847369] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0km
[   14.847373] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[   14.847463] ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
[   14.847508] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   15.016674] cs: IO port probe 0x100-0x3af: clean.
[   15.018412] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   15.018749] cs: IO port probe 0x820-0x8ff: clean.
[   15.019369] cs: IO port probe 0xc00-0xcf7: clean.
[   15.020135] cs: IO port probe 0xa00-0xaff: clean.
[   15.020960] cs: IO port probe 0x100-0x3af: clean.
[   15.022765] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   15.023102] cs: IO port probe 0x820-0x8ff: clean.
[   15.023721] cs: IO port probe 0xc00-0xcf7: clean.
[   15.024485] cs: IO port probe 0xa00-0xaff: clean.
[   15.343208] ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
[   15.613097] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[   15.613344] EXT3 FS on sda5, internal journal
[   16.119416] NTFS volume version 3.1.
[   16.218893] Adding 506008k swap on /dev/sda6.  Priority:-1 extents:1 across:506008k
[   26.589279] PM: Writing back config space on device 0000:02:00.0 at offset b (was 3ed173b, writing 17351043)
[   26.589295] PM: Writing back config space on device 0000:02:00.0 at offset 3 (was 0, writing 4010)
[   26.589301] PM: Writing back config space on device 0000:02:00.0 at offset 2 (was 2000000, writing 2000003)
[   26.589307] PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 2b00000, writing 2b00106)
[   26.589313] PM: Writing back config space on device 0000:02:00.0 at offset 0 (was 3ed173b, writing 169c14e4)
[   74.971903] tg3: eth0: Link is up at 100 Mbps, full duplex.
[   74.971913] tg3: eth0: Flow control is on for TX and on for RX.
[  429.399676] [drm] Initialized drm 1.1.0 20060810
[  429.485331] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[  429.486282] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  430.701994] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  430.702021] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[  430.702064] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[  430.989179] [drm] Setting GART location based on new memory map
[  430.989195] [drm] Loading R300 Microcode
[  430.989254] [drm] writeback test succeeded in 2 usecs
[  444.783872] mtrr: no MTRR for d0000000,4000000 found
[  456.861987] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  456.862016] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[  456.862059] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[  457.106814] [drm] Setting GART location based on new memory map
[  457.106830] [drm] Loading R300 Microcode
[  457.106890] [drm] writeback test succeeded in 2 usecs

--------------080106090401000602080005--
