From: raphaello-mouse@altern.org
Subject: Re: Packard Bell DSDT issue
Date: Fri, 17 Aug 2007 12:27:59 +0200
Message-ID: <200708171227.59620.raphaello-mouse@altern.org>
References: <46BDBAEF.5030204@suse.de> <200708150044.29820.lenb@kernel.org> <200708151119.09045.raphaello-mouse@altern.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vgXxGJR3X+9rBNn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([80.12.242.26]:3829 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXHQK2G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Aug 2007 06:28:06 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id BB88D1C0008C
	for <linux-acpi@vger.kernel.org>; Fri, 17 Aug 2007 12:28:03 +0200 (CEST)
Received: from unshared.local (ASt-Lambert-151-1-54-131.w83-199.abo.wanadoo.fr [83.199.60.131])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id 0D1C41C0008B
	for <linux-acpi@vger.kernel.org>; Fri, 17 Aug 2007 12:28:01 +0200 (CEST)
In-Reply-To: <200708151119.09045.raphaello-mouse@altern.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

--Boundary-00=_vgXxGJR3X+9rBNn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

Here some docs are attached for this issue: 
dmesg -64000 
less/proc/interrupts with and without "ACPI=off" option to kernel. 

I have posted a bugzilla report about this on 
http://bugzilla.kernel.org/show_bug.cgi?id=8896

Thanks for any hint! 


Subject: Packard Bell DSDT issue
From: raphaello-mouse@altern.org 
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: 
Date: Wednesday 15 August 2007, 11:19


> Dear all!
>
> I submit you this issue with my laptop, a Packard Bell Easynote R1983 W
> (running an updated Kubuntu 7.04, with updated BIOS). Issue not documented
> elsewhere I've looked for.
> Problem: I need to put at boot the option "acpi=force" to kernel
> (2.6.20-16) in order to have atheros wifi card working. But then, this
> disables my usb devices!
>
> More technical details have been posted on:
> kubuntuforums.net/forums/index.php?topic=3083009.msg68885#msg68885
>
> Some comments made on http://madwifi.org/ticket/1454
> "This is an ACPI error. [...] However, the problem in this case looks like
> a badly written DSDT. [...] the problem is the fault of your system
> vendor." (I first thought it was a madwifi issue)
>
> Please help, or at least give some hint that allow me to go on (I'm
> newbie)! Thanks in advance.
>
> Raf
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Boundary-00=_vgXxGJR3X+9rBNn
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg-s64000_ACPI_on.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-s64000_ACPI_on.txt"

[    0.000000] Linux version 2.6.20-16-generic (root@terranova) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #2 SMP Thu Jun 7 20:19:32 UTC 2007 (Ubuntu 2.6.20-16.29-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000e0000 size: 0000000000020000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000001beef000 end: 000000001bfef000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000001bff0000 size: 000000000000ffc0 end: 000000001bffffc0 type: 3
[    0.000000] copy_e820_map() start: 000000001bffffc0 size: 0000000000000040 end: 000000001c000000 type: 4
[    0.000000] copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001bfef000 (usable)
[    0.000000]  BIOS-e820: 000000001bff0000 - 000000001bffffc0 (ACPI data)
[    0.000000]  BIOS-e820: 000000001bffffc0 - 000000001c000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 447MB LOWMEM available.
[    0.000000] Entering add_active_range(0, 0, 114671) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   114671
[    0.000000]   HighMem    114671 ->   114671
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   114671
[    0.000000] On node 0 totalpages: 114671
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 863 pages used for memmap
[    0.000000]   Normal zone: 109712 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages used for memmap
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 OID_00                                ) @ 0x000e6010
[    0.000000] ACPI: RSDT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x1bffc2d0
[    0.000000] ACPI: FADT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x1bfffb00
[    0.000000] ACPI: MADT (v001 INSYDE APIC_000 0x30303030 0000 0x00010200) @ 0x1bfffb90
[    0.000000] ACPI: DSDT (v001 INSYDE    PN800 0x00001000 INTL 0x02002036) @ 0x00000000
[    0.000000] ACPI: BIOS age (400) fails cutoff (2000), acpi=force is required to enable ACPI
[    0.000000] ACPI: Disabling ACPI support
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 1c000000:e3f80000)
[    0.000000] Detected 1492.810 MHz processor.
[   13.153234] Built 1 zonelists.  Total pages: 113776
[   13.153239] Kernel command line: root=UUID=68735286-9074-4e91-9625-0b5d872ab4d2 ro quiet  splash
[   13.153430] Found and enabled local APIC!
[   13.153433] mapped APIC to ffffd000 (fee00000)
[   13.153438] Enabling fast FPU save and restore... done.
[   13.153441] Enabling unmasked SIMD FPU exception support... done.
[   13.153455] Initializing CPU#0
[   13.153566] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   13.155077] Console: colour VGA+ 80x25
[   13.155380] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   13.155673] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   13.170746] Memory: 443576k/458684k available (1992k kernel code, 14468k reserved, 900k data, 328k init, 0k highmem)
[   13.170758] virtual kernel memory layout:
[   13.170759]     fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
[   13.170761]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   13.170762]     vmalloc : 0xdc800000 - 0xff7fe000   ( 559 MB)
[   13.170764]     lowmem  : 0xc0000000 - 0xdbfef000   ( 447 MB)
[   13.170765]       .init : 0xc03d9000 - 0xc042b000   ( 328 kB)
[   13.170766]       .data : 0xc02f2374 - 0xc03d36d4   ( 900 kB)
[   13.170768]       .text : 0xc0100000 - 0xc02f2374   (1992 kB)
[   13.170772] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   13.249437] Calibrating delay using timer specific routine.. 2989.00 BogoMIPS (lpj=5978016)
[   13.249487] Security Framework v1.0.0 initialized
[   13.249498] SELinux:  Disabled at boot.
[   13.249519] Mount-cache hash table entries: 512
[   13.249695] CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   13.249710] CPU: L1 I cache: 32K, L1 D cache: 32K
[   13.249713] CPU: L2 cache: 1024K
[   13.249717] CPU: After all inits, caps: afe9fbff 00000000 00000000 00002040 00000000 00000000 00000000
[   13.249727] Compat vDSO mapped to ffffe000.
[   13.249732] Remapping vsyscall page to ffffe000
[   13.249746] Checking 'hlt' instruction... OK.
[   13.265523] SMP alternatives: switching to UP code
[   13.265745] Freeing SMP alternatives: 11k freed
[   13.265958] Early unpacking initramfs... done
[   13.641161] CPU0: Intel(R) Celeron(R) M processor         1.50GHz stepping 08
[   13.641170] SMP motherboard not detected.
[   13.748787] Brought up 1 CPUs
[   13.749094] Booting paravirtualized kernel on bare hardware
[   13.749212] Time: 12:06:09  Date: 07/17/107
[   13.749247] NET: Registered protocol family 16
[   13.749358] EISA bus registered
[   13.749442] PCI: PCI BIOS revision 2.10 entry at 0xe9b04, last bus=1
[   13.749445] PCI: Using configuration type 1
[   13.749447] Setting up standard PCI resources
[   13.750470] ACPI: Interpreter disabled.
[   13.750476] Linux Plug and Play Support v0.97 (c) Adam Belay
[   13.750489] pnp: PnP ACPI: disabled
[   13.750495] PnPBIOS: Scanning system for PnP BIOS support...
[   13.750568] PnPBIOS: Found PnP BIOS installation structure at 0xc00ff020
[   13.750572] PnPBIOS: PnP BIOS version 1.0, entry 0xeb000:0x3536, dseg 0xeb000
[   13.750580] PNPBIOS fault.. attempting recovery.
[   13.750631] PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue
[   13.750680] PnPBIOS: You may need to reboot with the "pnpbios=off" option to operate stably
[   13.750729] PnPBIOS: Check with your vendor for an updated BIOS
[   13.750776] PnPBIOS: dev_node_info: unexpected status 0x37
[   13.750822] PnPBIOS: Unable to get node info.  Aborting.
[   13.750919] PCI: Probing PCI hardware
[   13.750928] PCI: Probing PCI hardware (bus 00)
[   13.751655] PCI quirk: region 1000-107f claimed by vt8235 PM
[   13.751659] PCI quirk: region 1400-140f claimed by vt8235 SMB
[   13.751951] Boot video device is 0000:01:00.0
[   13.752701] PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
[   13.755053] NET: Registered protocol family 8
[   13.755055] NET: Registered protocol family 20
[   13.755419] PCI: Bridge: 0000:00:01.0
[   13.755422]   IO window: c000-dfff
[   13.755428]   MEM window: c0000000-cfffffff
[   13.755433]   PREFETCH window: 90000000-9fffffff
[   13.755456] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   13.755485] NET: Registered protocol family 2
[   13.788750] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   13.788844] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   13.788980] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[   13.789045] TCP: Hash tables configured (established 16384 bind 8192)
[   13.789048] TCP reno registered
[   13.800801] checking if image is initramfs... it is
[   14.534772] Freeing initrd memory: 6780k freed
[   14.535363] audit: initializing netlink socket (disabled)
[   14.535384] audit(1187352369.460:1): initialized
[   14.535552] VFS: Disk quotas dquot_6.5.1
[   14.535580] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   14.535686] io scheduler noop registered
[   14.535690] io scheduler anticipatory registered
[   14.535692] io scheduler deadline registered
[   14.535709] io scheduler cfq registered (default)
[   14.536043] isapnp: Scanning for PnP cards...
[   14.889999] isapnp: No Plug & Play device found
[   14.931575] Real Time Clock Driver v1.12ac
[   14.931658] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   14.932614] mice: PS/2 mouse device common for all mice
[   14.933241] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   14.933552] input: Macintosh mouse button emulation as /class/input/input0
[   14.933592] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   14.933597] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   14.933908] PNP: No PS/2 controller found. Probing ports directly.
[   14.944431] i8042.c: Detected active multiplexing controller, rev 1.1.
[   14.949438] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.949444] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   14.949447] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   14.949450] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   14.949453] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   14.949819] EISA: Probing bus 0 at eisa.0
[   14.949829] Cannot allocate resource for EISA slot 1
[   14.949862] EISA: Detected 0 cards.
[   14.949970] TCP cubic registered
[   14.949984] NET: Registered protocol family 1
[   14.950047] Testing NMI watchdog ... OK.
[   14.989726] Using IPI No-Shortcut mode
[   14.989756]   Magic number: 3:625:127
[   14.990233] Freeing unused kernel memory: 328k freed
[   14.990949] Time: tsc clocksource has been installed.
[   14.995599] input: AT Translated Set 2 keyboard as /class/input/input1
[   16.224718] Capability LSM initialized
[   16.269889] thermal: Unknown symbol acpi_processor_set_thermal_limit
[   16.711593] usbcore: registered new interface driver usbfs
[   16.711635] usbcore: registered new interface driver hub
[   16.711659] usbcore: registered new device driver usb
[   16.779335] USB Universal Host Controller Interface driver v3.0
[   16.779444] PCI: setting IRQ 11 as level-triggered
[   16.779449] PCI: Found IRQ 11 for device 0000:00:10.0
[   16.779477] PCI: Sharing IRQ 11 with 0000:00:12.0
[   16.779481] PCI: Sharing IRQ 11 with 0000:01:00.0
[   16.779496] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   16.779710] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   16.779743] uhci_hcd 0000:00:10.0: irq 11, io base 0x00001200
[   16.779893] usb usb1: configuration #1 chosen from 1 choice
[   16.779924] hub 1-0:1.0: USB hub found
[   16.779932] hub 1-0:1.0: 2 ports detected
[   16.791232] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[   16.881153] PCI: setting IRQ 7 as level-triggered
[   16.881161] PCI: Found IRQ 7 for device 0000:00:10.1
[   16.881203] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   16.881339] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   16.881372] uhci_hcd 0000:00:10.1: irq 7, io base 0x00001220
[   16.881796] usb usb2: configuration #1 chosen from 1 choice
[   16.881956] hub 2-0:1.0: USB hub found
[   16.881964] hub 2-0:1.0: 2 ports detected
[   16.984788] PCI: setting IRQ 5 as level-triggered
[   16.984793] PCI: Found IRQ 5 for device 0000:00:10.2
[   16.984819] PCI: Sharing IRQ 5 with 0000:00:11.5
[   16.984836] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   16.984862] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   16.984893] uhci_hcd 0000:00:10.2: irq 5, io base 0x00001240
[   16.984993] usb usb3: configuration #1 chosen from 1 choice
[   16.985021] hub 3-0:1.0: USB hub found
[   16.985028] hub 3-0:1.0: 2 ports detected
[   17.088816] VP_IDE: IDE controller at PCI slot 0000:00:11.1
[   17.088846] VP_IDE: chipset revision 6
[   17.088849] VP_IDE: not 100% native mode: will probe irqs later
[   17.088864] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
[   17.088874]     ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
[   17.088887]     ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:pio, hdd:pio
[   17.088895] Probing IDE interface ide0...
[   17.503741] hda: WDC WD800UE-22HCT0, ATA DISK drive
[   18.174869] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   18.175102] Probing IDE interface ide1...
[   18.751797] SCSI subsystem initialized
[   18.758479] libata version 2.20 loaded.
[   18.760701] PCI: Found IRQ 11 for device 0000:00:12.0
[   18.760717] PCI: Sharing IRQ 11 with 0000:00:10.0
[   18.760732] PCI: Sharing IRQ 11 with 0000:01:00.0
[   18.764921] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 11.
[   18.765640] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[   18.765751] PCI: setting IRQ 10 as level-triggered
[   18.765756] PCI: Found IRQ 10 for device 0000:00:10.3
[   18.765791] ehci_hcd 0000:00:10.3: EHCI Host Controller
[   18.765953] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   18.766003] ehci_hcd 0000:00:10.3: irq 10, io mem 0xf0000000
[   18.766012] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   18.766454] usb usb4: configuration #1 chosen from 1 choice
[   18.766623] hub 4-0:1.0: USB hub found
[   18.766633] hub 4-0:1.0: 6 ports detected
[   18.775407] hda: max request size: 128KiB
[   18.775413] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
[   18.824514] hda: cache flushes supported
[   18.824574]  hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
[   19.367682] Attempting manual resume
[   19.367687] swsusp: Resume From Partition 3:5
[   19.367689] PM: Checking swsusp image.
[   19.396155] PM: Resume from disk failed.
[   19.443821] kjournald starting.  Commit interval 5 seconds
[   19.443835] EXT3-fs: mounted filesystem with ordered data mode.
[   33.239814] eth0: link down
[   34.623221] NET: Registered protocol family 17
[   34.669032] Linux agpgart interface v0.102 (c) Dave Jones
[   34.681296] agpgart: Detected VIA PM800/PN800/PM880/PN880 chipset
[   34.684051] agpgart: AGP aperture is 32M @ 0xa0000000
[   35.346451] ath_hal: module license 'Proprietary' taints kernel.
[   35.347328] ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
[   35.429739] wlan: 0.8.4.2 (0.9.3.1)
[   35.456518] ath_pci: 0.9.4.5 (0.9.3.1)
[   35.456592] PCI: Enabling device 0000:00:06.0 (0000 -> 0002)
[   35.456602] PCI: No IRQ known for interrupt pin A of device 0000:00:06.0. Please try using pci=biosirq.
[   35.456627] IRQ handler type mismatch for IRQ 0
[   35.456631] current handler: timer
[   35.456643]  [<c015410e>] setup_irq+0x12e/0x1e0
[   35.456656]  [<dc98b520>] ath_intr+0x0/0xc20 [ath_pci]
[   35.456666]  [<c0154263>] request_irq+0xa3/0xc0
[   35.456671]  [<dc98df8d>] ath_pci_probe+0x1ad/0x3b0 [ath_pci]
[   35.456681]  [<c01b8eee>] sysfs_create_link+0x6e/0x160
[   35.456689]  [<dc98dde0>] ath_pci_probe+0x0/0x3b0 [ath_pci]
[   35.456698]  [<c01fba86>] pci_device_probe+0x56/0x80
[   35.456705]  [<c0257aa6>] really_probe+0x66/0x190
[   35.456713]  [<c0257c19>] driver_probe_device+0x49/0xc0
[   35.456719]  [<c0257dee>] __driver_attach+0x9e/0xa0
[   35.456723]  [<c0256f7b>] bus_for_each_dev+0x3b/0x60
[   35.456729]  [<c0257944>] driver_attach+0x24/0x30
[   35.456733]  [<c0257d50>] __driver_attach+0x0/0xa0
[   35.456737]  [<c025730b>] bus_add_driver+0x7b/0x1a0
[   35.456743]  [<c01fbc54>] __pci_register_driver+0x74/0xc0
[   35.456747]  [<dc84c030>] init_ath_pci+0x30/0x54 [ath_pci]
[   35.456755]  [<c014422d>] sys_init_module+0x15d/0x1ba0
[   35.456769]  [<c0107a5d>] sys_mmap2+0xcd/0xd0
[   35.456776]  [<c01031f0>] sysenter_past_esp+0x69/0xa9
[   35.456783]  =======================
[   35.456785] wifi%d: request_irq failed
[   35.647289] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   35.716272] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   36.027366] irda_init()
[   36.027381] NET: Registered protocol family 23
[   36.465599] Synaptics Touchpad, model: 1, fw: 5.9, id: 0xf6eb3, caps: 0xa04713/0x0
[   36.519578] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[   37.059114] PCI: Found IRQ 5 for device 0000:00:11.5
[   37.059135] PCI: Sharing IRQ 5 with 0000:00:10.2
[   37.059281] PCI: Setting latency timer of device 0000:00:11.5 to 64
[   37.797122] fuse init (API version 7.8)
[   37.950497] lp: driver loaded but no devices found
[   37.976173] Adding 1020088k swap on /dev/disk/by-uuid/36e9fbed-1278-4dd8-901f-9a14b01a7e12.  Priority:-1 extents:1 across:1020088k
[   38.206202] EXT3 FS on hda6, internal journal
[   47.051604] NTFS driver 2.1.28 [Flags: R/O MODULE].
[   47.130676] NTFS volume version 3.1.
[   53.126945] acpi_cpufreq: Unknown symbol acpi_processor_notify_smm
[   53.126995] acpi_cpufreq: Unknown symbol acpi_processor_unregister_performance
[   53.127121] acpi_cpufreq: Unknown symbol acpi_processor_preregister_performance
[   53.127184] acpi_cpufreq: Unknown symbol acpi_processor_register_performance
[   56.571765] ppdev: user-space parallel port driver
[   57.868632] apm: BIOS not found.
[   60.468774] [drm] Initialized drm 1.1.0 20060810
[   60.481368] PCI: Found IRQ 11 for device 0000:01:00.0
[   60.481650] PCI: Sharing IRQ 11 with 0000:00:10.0
[   60.481790] PCI: Sharing IRQ 11 with 0000:00:12.0
[   60.484762] [drm] Initialized via 2.11.0 20061227 on minor 0
[   60.524403] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[   60.524641] agpgart: Device is in legacy mode, falling back to 2.x
[   60.524792] agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
[   60.525036] agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode
[   60.530823] [drm:via_mem_alloc] *ERROR* Attempt to allocate from uninitialized memory manager.
[   79.709779] NET: Registered protocol family 10
[   79.709928] lo: Disabled Privacy Extensions
[   79.709986] ADDRCONF(NETDEV_UP): eth0: link is not ready

--Boundary-00=_vgXxGJR3X+9rBNn
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg-s64000_ACPI_off.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-s64000_ACPI_off.txt"

: resuming
[121695.928000] PM: Writing back config space on device 0000:00:12.0 at offset 1 (was 2100087, writing 2100083)
[121695.928000] pci 0000:01:00.0: resuming
[121696.428000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[121696.428000] pnp 00:00: resuming
[121696.428000] i8042 aux 00:01: resuming
[121696.428000] pnp: Failed to activate device 00:01.
[121696.428000] i8042 kbd 00:02: resuming
[121696.428000] pnp: Failed to activate device 00:02.
[121696.428000] pnp 00:03: resuming
[121696.428000] pnp 00:04: resuming
[121696.428000] system 00:05: resuming
[121696.428000] pnp 00:06: resuming
[121696.428000] system 00:07: resuming
[121696.428000] pnp 00:08: resuming
[121696.428000] pcspkr pcspkr: resuming
[121696.428000] serial8250 serial8250: resuming
[121696.428000] i8042 i8042: resuming
[121696.436000] atkbd serio0: resuming
[121696.448000] platform eisa.0: resuming
[121696.448000] serio serio1: resuming
[121696.448000] serio serio2: resuming
[121696.448000] psmouse serio3: resuming
[121697.136000] serio serio4: resuming
[121697.136000] platform vesafb.0: resuming
[121697.136000] usb usb1: resuming
[121697.176000] usb usb2: resuming
[121697.216000] usb usb3: resuming
[121697.256000] usb usb4: resuming
[121697.276000] ide-disk 0.0: resuming
[121697.304000] ac97 0-0:ALC655: resuming
[121697.308000] Restarting tasks ... done.
[121697.336000] Enabling non-boot CPUs ...
[121706.148000] ath_pci: 0.9.4.5 (0.9.3.1)
[121706.152000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 18
[121706.740000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[121706.740000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[121706.740000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[121706.740000] wifi0: mac 7.8 phy 4.5 radio 5.6
[121706.740000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[121706.740000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[121706.740000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[121706.740000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[121706.740000] wifi0: Use hw queue 8 for CAB traffic
[121706.740000] wifi0: Use hw queue 9 for beacons
[121706.744000] wifi0: Atheros 5212: mem=0x20000000, irq=18
[121707.848000] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[121707.852000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKB] -> GSI 23 (level, low) -> IRQ 16
[121707.856000] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 16.
[121707.856000] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[121708.456000] eth0: link down
[121708.456000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[121712.448000] input: Power Button (FF) as /class/input/input10
[121712.448000] ACPI: Power Button (FF) [PWRF]
[121712.448000] input: Lid Switch as /class/input/input11
[121712.448000] ACPI: Lid Switch [LID]
[121712.448000] input: Sleep Button (CM) as /class/input/input12
[121712.452000] ACPI: Sleep Button (CM) [SBTN]
[121713.848000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[121713.848000] ACPI: Processor [CPU0] (supports 16 throttling states)
[121714.068000] ACPI: Thermal Zone [TZ0] (0 C)
[121714.596000] ACPI: AC Adapter [AC] (on-line)
[121714.800000] ACPI: Battery Slot [BAT0] (battery present)
[121737.548000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121747.960000] ath0: no IPv6 routers present
[121769.684000] ADDRCONF(NETDEV_UP): ath0: link is not ready
[121771.788000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121773.868000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121777.752000] ADDRCONF(NETDEV_UP): ath0: link is not ready
[121779.772000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121789.960000] ath0: no IPv6 routers present
[121825.088000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121825.236000] ADDRCONF(NETDEV_UP): ath0: link is not ready
[121827.184000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[121846.140000] ath0: no IPv6 routers present
[123779.068000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[123779.068000] ath_pci: driver unloaded
[123779.220000] ACPI: PCI interrupt for device 0000:00:12.0 disabled
[123782.924000] PM: suspend-to-disk mode set to 'shutdown'
[123782.924000] Disabling non-boot CPUs ...
[123782.924000] Stopping tasks ... done.
[123783.744000] Shrinking memory...  -\|/-\done (57017 pages freed)
[123789.720000] Freed 228068 kbytes in 6.04 seconds (37.75 MB/s)
[123789.720000] Suspending console(s)
[123789.720000] ac97 0-0:ALC655: freeze
[123789.720000] ide-disk 0.0: freeze
[123790.700000]  usbdev4.1_ep81: PM: suspend 0->1, parent 4-0:1.0 already 2
[123790.700000] hub 4-0:1.0: PM: suspend 2-->1
[123790.700000] hub 4-0:1.0: PM: suspend 2->1, parent usb4 already 2
[123790.700000]  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
[123790.700000] usb usb4: PM: suspend 2-->1
[123790.700000]  usbdev3.1_ep81: PM: suspend 0->1, parent 3-0:1.0 already 2
[123790.700000] hub 3-0:1.0: PM: suspend 2-->1
[123790.700000] hub 3-0:1.0: PM: suspend 2->1, parent usb3 already 2
[123790.700000]  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
[123790.700000] usb usb3: PM: suspend 2-->1
[123790.700000]  usbdev2.1_ep81: PM: suspend 0->1, parent 2-0:1.0 already 2
[123790.700000] hub 2-0:1.0: PM: suspend 2-->1
[123790.700000] hub 2-0:1.0: PM: suspend 2->1, parent usb2 already 2
[123790.700000]  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
[123790.700000] usb usb2: PM: suspend 2-->1
[123790.700000]  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 2
[123790.700000] hub 1-0:1.0: PM: suspend 2-->1
[123790.700000] hub 1-0:1.0: PM: suspend 2->1, parent usb1 already 2
[123790.700000]  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
[123790.700000] usb usb1: PM: suspend 2-->1
[123790.700000] platform vesafb.0: freeze
[123790.700000] platform eisa.0: freeze
[123790.700000] i8042 i8042: freeze
[123791.148000] serial8250 serial8250: freeze
[123791.148000] pcspkr pcspkr: freeze
[123791.148000] pnp 00:08: freeze
[123791.148000] system 00:07: freeze
[123791.148000] pnp 00:06: freeze
[123791.148000] system 00:05: freeze
[123791.148000] pnp 00:04: freeze
[123791.148000] pnp 00:03: freeze
[123791.148000] i8042 kbd 00:02: freeze
[123791.148000] i8042 aux 00:01: freeze
[123791.148000] pnp 00:00: freeze
[123791.148000] pci 0000:01:00.0: freeze
[123791.148000] pci 0000:00:12.0: freeze
[123791.148000] VIA 82xx Audio 0000:00:11.5: freeze
[123791.152000] ACPI: PCI interrupt for device 0000:00:11.5 disabled
[123791.368000] VIA_IDE 0000:00:11.1: freeze
[123791.368000] pci 0000:00:11.0: freeze
[123791.368000] ehci_hcd 0000:00:10.3: freeze
[123791.368000] ACPI: Link isn't initialized
[123791.368000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[123791.384000] uhci_hcd 0000:00:10.2: freeze
[123791.384000] ACPI: Link isn't initialized
[123791.384000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[123791.400000] uhci_hcd 0000:00:10.1: freeze
[123791.400000] ACPI: Link isn't initialized
[123791.400000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[123791.416000] uhci_hcd 0000:00:10.0: freeze
[123791.416000] ACPI: Link isn't initialized
[123791.416000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[123791.432000] pci 0000:00:06.0: freeze
[123791.432000] pci 0000:00:01.0: freeze
[123791.432000] pci 0000:00:00.7: freeze
[123791.432000] pci 0000:00:00.4: freeze
[123791.432000] pci 0000:00:00.3: freeze
[123791.432000] pci 0000:00:00.2: freeze
[123791.432000] pci 0000:00:00.1: freeze
[123791.432000] agpgart-via 0000:00:00.0: freeze
[123791.448000] acpi acpi: freeze
[123791.448000] PM: snapshotting memory.
[123791.448000] platform vesafb.0: LATE freeze
[123791.448000] platform eisa.0: LATE freeze
[123791.448000] i8042 i8042: LATE freeze
[123791.448000] serial8250 serial8250: LATE freeze
[123791.448000] pcspkr pcspkr: LATE freeze
[123791.448000] pci 0000:01:00.0: LATE freeze
[123791.448000] pci 0000:00:12.0: LATE freeze
[123791.448000] VIA 82xx Audio 0000:00:11.5: LATE freeze
[123791.448000] VIA_IDE 0000:00:11.1: LATE freeze
[123791.448000] pci 0000:00:11.0: LATE freeze
[123791.448000] pci 0000:00:06.0: LATE freeze
[123791.448000] pci 0000:00:01.0: LATE freeze
[123791.448000] pci 0000:00:00.7: LATE freeze
[123791.448000] pci 0000:00:00.4: LATE freeze
[123791.448000] pci 0000:00:00.3: LATE freeze
[123791.448000] pci 0000:00:00.2: LATE freeze
[123791.448000] pci 0000:00:00.1: LATE freeze
[123791.448000] agpgart-via 0000:00:00.0: LATE freeze
[123791.448000] swsusp: critical section: 
[123791.448000] swsusp: Need to copy 55417 pages
[123791.448000] swsusp: Normal pages needed: 55417 + 1024 + 14, available pages: 59252
[160372.448000] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[160372.448000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
[160372.448000] ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 11, using IRQ 23
[160372.448000] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[160372.448000] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 5, using IRQ 22
[160372.448000] agpgart-via 0000:00:00.0: EARLY resume
[160372.448000] pci 0000:00:00.1: EARLY resume
[160372.448000] pci 0000:00:00.2: EARLY resume
[160372.448000] pci 0000:00:00.3: EARLY resume
[160372.448000] pci 0000:00:00.4: EARLY resume
[160372.448000] pci 0000:00:00.7: EARLY resume
[160372.448000] pci 0000:00:01.0: EARLY resume
[160372.448000] pci 0000:00:06.0: EARLY resume
[160372.448000] uhci_hcd 0000:00:10.0: EARLY resume
[160372.448000] uhci_hcd 0000:00:10.1: EARLY resume
[160372.448000] uhci_hcd 0000:00:10.2: EARLY resume
[160372.448000] ehci_hcd 0000:00:10.3: EARLY resume
[160372.448000] pci 0000:00:11.0: EARLY resume
[160372.448000] VIA_IDE 0000:00:11.1: EARLY resume
[160372.448000] VIA 82xx Audio 0000:00:11.5: EARLY resume
[160372.448000] pci 0000:00:12.0: EARLY resume
[160372.448000] pci 0000:01:00.0: EARLY resume
[160372.448000] pcspkr pcspkr: EARLY resume
[160372.448000] serial8250 serial8250: EARLY resume
[160372.448000] i8042 i8042: EARLY resume
[160372.448000] platform eisa.0: EARLY resume
[160372.448000] platform vesafb.0: EARLY resume
[160372.460000] PM: Image restored successfully.
[160372.476000] acpi acpi: resuming
[160372.484000] agpgart-via 0000:00:00.0: resuming
[160372.500000] pci 0000:00:00.1: resuming
[160372.500000] pci 0000:00:00.2: resuming
[160372.500000] pci 0000:00:00.3: resuming
[160372.500000] pci 0000:00:00.4: resuming
[160372.500000] pci 0000:00:00.7: resuming
[160372.500000] pci 0000:00:01.0: resuming
[160372.500000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[160372.500000] pci 0000:00:06.0: resuming
[160372.500000] PM: Writing back config space on device 0000:00:06.0 at offset 3 (was 0, writing a820)
[160372.500000] PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 2900000, writing 2900002)
[160372.500000] uhci_hcd 0000:00:10.0: resuming
[160372.516000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[160372.516000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[160372.516000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[160372.516000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[160372.516000] ACPI: Invalid IRQ link routing entry
[160372.516000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[160372.516000] ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI - using IRQ 11
[160372.516000] usb usb1: root hub lost power or was reset
[160372.516000] uhci_hcd 0000:00:10.1: resuming
[160372.532000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[160372.532000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[160372.532000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[160372.532000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[160372.532000] ACPI: Invalid IRQ link routing entry
[160372.532000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[160372.532000] ACPI: PCI Interrupt 0000:00:10.1[B]: no GSI - using IRQ 7
[160372.532000] usb usb2: root hub lost power or was reset
[160372.532000] uhci_hcd 0000:00:10.2: resuming
[160372.548000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[160372.548000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[160372.548000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[160372.548000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[160372.548000] ACPI: Invalid IRQ link routing entry
[160372.548000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[160372.548000] ACPI: PCI Interrupt 0000:00:10.2[C]: no GSI - using IRQ 5
[160372.548000] usb usb3: root hub lost power or was reset
[160372.548000] ehci_hcd 0000:00:10.3: resuming
[160372.564000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[160372.564000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[160372.564000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[160372.564000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[160372.564000] ACPI: Invalid IRQ link routing entry
[160372.564000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[160372.564000] ACPI: PCI Interrupt 0000:00:10.3[D]: no GSI - using IRQ 10
[160372.564000] usb usb4: root hub lost power or was reset
[160372.564000] pci 0000:00:11.0: resuming
[160372.564000] VIA_IDE 0000:00:11.1: resuming
[160372.564000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 17
[160372.564000] VIA 82xx Audio 0000:00:11.5: resuming
[160372.580000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 19
[160372.580000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[160372.580000] pci 0000:00:12.0: resuming
[160372.580000] PM: Writing back config space on device 0000:00:12.0 at offset 1 (was 2100087, writing 2100083)
[160372.580000] pci 0000:01:00.0: resuming
[160373.080000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[160373.080000] pnp 00:00: resuming
[160373.080000] i8042 aux 00:01: resuming
[160373.080000] pnp: Failed to activate device 00:01.
[160373.080000] i8042 kbd 00:02: resuming
[160373.080000] pnp: Failed to activate device 00:02.
[160373.080000] pnp 00:03: resuming
[160373.080000] pnp 00:04: resuming
[160373.080000] system 00:05: resuming
[160373.080000] pnp 00:06: resuming
[160373.080000] system 00:07: resuming
[160373.080000] pnp 00:08: resuming
[160373.080000] pcspkr pcspkr: resuming
[160373.080000] serial8250 serial8250: resuming
[160373.080000] i8042 i8042: resuming
[160373.088000] atkbd serio0: resuming
[160373.100000] platform eisa.0: resuming
[160373.100000] serio serio1: resuming
[160373.100000] serio serio2: resuming
[160373.100000] psmouse serio3: resuming
[160373.788000] serio serio4: resuming
[160373.788000] platform vesafb.0: resuming
[160373.788000] usb usb1: resuming
[160373.828000] usb usb2: resuming
[160373.868000] usb usb3: resuming
[160373.908000] usb usb4: resuming
[160373.928000] ide-disk 0.0: resuming
[160373.964000] ac97 0-0:ALC655: resuming
[160373.964000] Restarting tasks ... done.
[160373.972000] Enabling non-boot CPUs ...
[160403.068000] ath_pci: 0.9.4.5 (0.9.3.1)
[160403.068000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 18
[160403.756000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[160403.756000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[160403.756000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[160403.756000] wifi0: mac 7.8 phy 4.5 radio 5.6
[160403.756000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[160403.756000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[160403.756000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[160403.756000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[160403.756000] wifi0: Use hw queue 8 for CAB traffic
[160403.756000] wifi0: Use hw queue 9 for beacons
[160403.760000] wifi0: Atheros 5212: mem=0x20000000, irq=18
[160405.264000] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[160405.264000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKB] -> GSI 23 (level, low) -> IRQ 16
[160405.276000] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 16.
[160405.280000] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[160407.644000] eth0: link down
[160407.652000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[160414.692000] input: Power Button (FF) as /class/input/input13
[160414.692000] ACPI: Power Button (FF) [PWRF]
[160414.720000] input: Lid Switch as /class/input/input14
[160414.720000] ACPI: Lid Switch [LID]
[160414.740000] input: Sleep Button (CM) as /class/input/input15
[160414.740000] ACPI: Sleep Button (CM) [SBTN]
[160416.304000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[160416.304000] ACPI: Processor [CPU0] (supports 16 throttling states)
[160416.540000] ACPI: Thermal Zone [TZ0] (0 C)
[160416.780000] ACPI: AC Adapter [AC] (on-line)
[160417.152000] ACPI: Battery Slot [BAT0] (battery present)
[160496.540000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[160513.876000] ath0: no IPv6 routers present
[185413.312000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[185413.312000] ath_pci: driver unloaded
[185413.664000] ACPI: PCI interrupt for device 0000:00:12.0 disabled
[185419.376000] PM: suspend-to-disk mode set to 'shutdown'
[185419.380000] Disabling non-boot CPUs ...
[185419.380000] Stopping tasks ... done.
[185419.728000] Shrinking memory...  -\|/-\done (59554 pages freed)
[185434.172000] Freed 238216 kbytes in 14.52 seconds (16.40 MB/s)
[185434.172000] Suspending console(s)
[185434.172000] ac97 0-0:ALC655: freeze
[185434.172000] ide-disk 0.0: freeze
[185434.948000]  usbdev4.1_ep81: PM: suspend 0->1, parent 4-0:1.0 already 2
[185434.948000] hub 4-0:1.0: PM: suspend 2-->1
[185434.948000] hub 4-0:1.0: PM: suspend 2->1, parent usb4 already 2
[185434.948000]  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
[185434.948000] usb usb4: PM: suspend 2-->1
[185434.948000]  usbdev3.1_ep81: PM: suspend 0->1, parent 3-0:1.0 already 2
[185434.948000] hub 3-0:1.0: PM: suspend 2-->1
[185434.948000] hub 3-0:1.0: PM: suspend 2->1, parent usb3 already 2
[185434.948000]  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
[185434.948000] usb usb3: PM: suspend 2-->1
[185434.948000]  usbdev2.1_ep81: PM: suspend 0->1, parent 2-0:1.0 already 2
[185434.948000] hub 2-0:1.0: PM: suspend 2-->1
[185434.948000] hub 2-0:1.0: PM: suspend 2->1, parent usb2 already 2
[185434.948000]  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
[185434.948000] usb usb2: PM: suspend 2-->1
[185434.948000]  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 2
[185434.948000] hub 1-0:1.0: PM: suspend 2-->1
[185434.948000] hub 1-0:1.0: PM: suspend 2->1, parent usb1 already 2
[185434.948000]  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
[185434.948000] usb usb1: PM: suspend 2-->1
[185434.948000] platform vesafb.0: freeze
[185434.948000] platform eisa.0: freeze
[185434.948000] i8042 i8042: freeze
[185435.360000] serial8250 serial8250: freeze
[185435.360000] pcspkr pcspkr: freeze
[185435.360000] pnp 00:08: freeze
[185435.360000] system 00:07: freeze
[185435.360000] pnp 00:06: freeze
[185435.360000] system 00:05: freeze
[185435.360000] pnp 00:04: freeze
[185435.360000] pnp 00:03: freeze
[185435.360000] i8042 kbd 00:02: freeze
[185435.360000] i8042 aux 00:01: freeze
[185435.360000] pnp 00:00: freeze
[185435.360000] pci 0000:01:00.0: freeze
[185435.360000] pci 0000:00:12.0: freeze
[185435.360000] VIA 82xx Audio 0000:00:11.5: freeze
[185435.360000] ACPI: PCI interrupt for device 0000:00:11.5 disabled
[185435.576000] VIA_IDE 0000:00:11.1: freeze
[185435.576000] pci 0000:00:11.0: freeze
[185435.576000] ehci_hcd 0000:00:10.3: freeze
[185435.576000] ACPI: Link isn't initialized
[185435.576000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[185435.592000] uhci_hcd 0000:00:10.2: freeze
[185435.592000] ACPI: Link isn't initialized
[185435.592000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[185435.608000] uhci_hcd 0000:00:10.1: freeze
[185435.608000] ACPI: Link isn't initialized
[185435.608000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[185435.624000] uhci_hcd 0000:00:10.0: freeze
[185435.624000] ACPI: Link isn't initialized
[185435.624000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[185435.640000] pci 0000:00:06.0: freeze
[185435.640000] pci 0000:00:01.0: freeze
[185435.640000] pci 0000:00:00.7: freeze
[185435.640000] pci 0000:00:00.4: freeze
[185435.640000] pci 0000:00:00.3: freeze
[185435.640000] pci 0000:00:00.2: freeze
[185435.640000] pci 0000:00:00.1: freeze
[185435.640000] agpgart-via 0000:00:00.0: freeze
[185435.656000] acpi acpi: freeze
[185435.656000] PM: snapshotting memory.
[185435.656000] platform vesafb.0: LATE freeze
[185435.656000] platform eisa.0: LATE freeze
[185435.656000] i8042 i8042: LATE freeze
[185435.656000] serial8250 serial8250: LATE freeze
[185435.656000] pcspkr pcspkr: LATE freeze
[185435.656000] pci 0000:01:00.0: LATE freeze
[185435.656000] pci 0000:00:12.0: LATE freeze
[185435.656000] VIA 82xx Audio 0000:00:11.5: LATE freeze
[185435.656000] VIA_IDE 0000:00:11.1: LATE freeze
[185435.656000] pci 0000:00:11.0: LATE freeze
[185435.656000] pci 0000:00:06.0: LATE freeze
[185435.656000] pci 0000:00:01.0: LATE freeze
[185435.656000] pci 0000:00:00.7: LATE freeze
[185435.656000] pci 0000:00:00.4: LATE freeze
[185435.656000] pci 0000:00:00.3: LATE freeze
[185435.656000] pci 0000:00:00.2: LATE freeze
[185435.656000] pci 0000:00:00.1: LATE freeze
[185435.656000] agpgart-via 0000:00:00.0: LATE freeze
[185435.656000] swsusp: critical section: 
[185435.656000] swsusp: Need to copy 51493 pages
[185435.656000] swsusp: Normal pages needed: 51493 + 1024 + 14, available pages: 63176
[186055.656000] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[186055.656000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
[186055.656000] ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 11, using IRQ 23
[186055.656000] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[186055.656000] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 5, using IRQ 22
[186055.656000] agpgart-via 0000:00:00.0: EARLY resume
[186055.656000] pci 0000:00:00.1: EARLY resume
[186055.656000] pci 0000:00:00.2: EARLY resume
[186055.656000] pci 0000:00:00.3: EARLY resume
[186055.656000] pci 0000:00:00.4: EARLY resume
[186055.656000] pci 0000:00:00.7: EARLY resume
[186055.656000] pci 0000:00:01.0: EARLY resume
[186055.656000] pci 0000:00:06.0: EARLY resume
[186055.656000] uhci_hcd 0000:00:10.0: EARLY resume
[186055.656000] uhci_hcd 0000:00:10.1: EARLY resume
[186055.656000] uhci_hcd 0000:00:10.2: EARLY resume
[186055.656000] ehci_hcd 0000:00:10.3: EARLY resume
[186055.656000] pci 0000:00:11.0: EARLY resume
[186055.656000] VIA_IDE 0000:00:11.1: EARLY resume
[186055.656000] VIA 82xx Audio 0000:00:11.5: EARLY resume
[186055.656000] pci 0000:00:12.0: EARLY resume
[186055.656000] pci 0000:01:00.0: EARLY resume
[186055.656000] pcspkr pcspkr: EARLY resume
[186055.656000] serial8250 serial8250: EARLY resume
[186055.656000] i8042 i8042: EARLY resume
[186055.656000] platform eisa.0: EARLY resume
[186055.656000] platform vesafb.0: EARLY resume
[186055.656000] PM: Image restored successfully.
[186055.668000] acpi acpi: resuming
[186055.676000] agpgart-via 0000:00:00.0: resuming
[186055.692000] pci 0000:00:00.1: resuming
[186055.692000] pci 0000:00:00.2: resuming
[186055.692000] pci 0000:00:00.3: resuming
[186055.692000] pci 0000:00:00.4: resuming
[186055.692000] pci 0000:00:00.7: resuming
[186055.692000] pci 0000:00:01.0: resuming
[186055.692000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[186055.692000] pci 0000:00:06.0: resuming
[186055.692000] PM: Writing back config space on device 0000:00:06.0 at offset 3 (was 0, writing a820)
[186055.692000] PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 2900000, writing 2900002)
[186055.692000] uhci_hcd 0000:00:10.0: resuming
[186055.708000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[186055.708000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[186055.708000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[186055.708000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[186055.708000] ACPI: Invalid IRQ link routing entry
[186055.708000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[186055.708000] ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI - using IRQ 11
[186055.708000] usb usb1: root hub lost power or was reset
[186055.708000] uhci_hcd 0000:00:10.1: resuming
[186055.724000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[186055.724000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[186055.724000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[186055.724000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[186055.724000] ACPI: Invalid IRQ link routing entry
[186055.724000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[186055.724000] ACPI: PCI Interrupt 0000:00:10.1[B]: no GSI - using IRQ 7
[186055.724000] usb usb2: root hub lost power or was reset
[186055.724000] uhci_hcd 0000:00:10.2: resuming
[186055.740000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[186055.740000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[186055.740000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[186055.740000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[186055.740000] ACPI: Invalid IRQ link routing entry
[186055.740000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[186055.740000] ACPI: PCI Interrupt 0000:00:10.2[C]: no GSI - using IRQ 5
[186055.740000] usb usb3: root hub lost power or was reset
[186055.740000] ehci_hcd 0000:00:10.3: resuming
[186055.756000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[186055.756000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[186055.756000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[186055.756000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[186055.756000] ACPI: Invalid IRQ link routing entry
[186055.756000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[186055.756000] ACPI: PCI Interrupt 0000:00:10.3[D]: no GSI - using IRQ 10
[186055.756000] usb usb4: root hub lost power or was reset
[186055.756000] pci 0000:00:11.0: resuming
[186055.756000] VIA_IDE 0000:00:11.1: resuming
[186055.756000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 17
[186055.756000] VIA 82xx Audio 0000:00:11.5: resuming
[186055.772000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 19
[186055.772000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[186055.772000] pci 0000:00:12.0: resuming
[186055.772000] PM: Writing back config space on device 0000:00:12.0 at offset 1 (was 2100087, writing 2100083)
[186055.772000] pci 0000:01:00.0: resuming
[186056.272000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[186056.272000] pnp 00:00: resuming
[186056.272000] i8042 aux 00:01: resuming
[186056.272000] pnp: Failed to activate device 00:01.
[186056.272000] i8042 kbd 00:02: resuming
[186056.272000] pnp: Failed to activate device 00:02.
[186056.272000] pnp 00:03: resuming
[186056.272000] pnp 00:04: resuming
[186056.272000] system 00:05: resuming
[186056.272000] pnp 00:06: resuming
[186056.272000] system 00:07: resuming
[186056.272000] pnp 00:08: resuming
[186056.272000] pcspkr pcspkr: resuming
[186056.272000] serial8250 serial8250: resuming
[186056.272000] i8042 i8042: resuming
[186056.280000] atkbd serio0: resuming
[186056.292000] platform eisa.0: resuming
[186056.292000] serio serio1: resuming
[186056.292000] serio serio2: resuming
[186056.292000] psmouse serio3: resuming
[186056.984000] serio serio4: resuming
[186056.984000] platform vesafb.0: resuming
[186056.984000] usb usb1: resuming
[186057.024000] usb usb2: resuming
[186057.064000] usb usb3: resuming
[186057.104000] usb usb4: resuming
[186057.124000] ide-disk 0.0: resuming
[186057.152000] ac97 0-0:ALC655: resuming
[186057.152000] Restarting tasks ... done.
[186057.156000] Enabling non-boot CPUs ...
[186091.692000] ath_pci: 0.9.4.5 (0.9.3.1)
[186091.692000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 18
[186092.272000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[186092.272000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[186092.272000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[186092.272000] wifi0: mac 7.8 phy 4.5 radio 5.6
[186092.272000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[186092.272000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[186092.272000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[186092.272000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[186092.272000] wifi0: Use hw queue 8 for CAB traffic
[186092.272000] wifi0: Use hw queue 9 for beacons
[186092.272000] wifi0: Atheros 5212: mem=0x20000000, irq=18
[186094.552000] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[186094.552000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKB] -> GSI 23 (level, low) -> IRQ 16
[186094.564000] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 16.
[186094.564000] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[186097.072000] eth0: link down
[186097.072000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[186101.836000] input: Power Button (FF) as /class/input/input16
[186101.836000] ACPI: Power Button (FF) [PWRF]
[186101.836000] input: Lid Switch as /class/input/input17
[186101.840000] ACPI: Lid Switch [LID]
[186101.840000] input: Sleep Button (CM) as /class/input/input18
[186101.840000] ACPI: Sleep Button (CM) [SBTN]
[186103.796000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[186103.796000] ACPI: Processor [CPU0] (supports 16 throttling states)
[186104.524000] ACPI: Thermal Zone [TZ0] (0 C)
[186104.976000] ACPI: AC Adapter [AC] (on-line)
[186105.456000] ACPI: Battery Slot [BAT0] (battery present)
[187681.304000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[187701.180000] ath0: no IPv6 routers present
[192861.780000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 4
[192861.784000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[192861.800000] psmouse.c: TouchPad at isa0060/serio3/input0 - driver resynched.
[194637.152000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 4
[194637.152000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194637.172000] psmouse.c: TouchPad at isa0060/serio3/input0 - driver resynched.
[194934.980000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194934.980000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194934.984000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194934.992000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194934.992000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[194934.992000] psmouse.c: issuing reconnect request
[206937.724000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[206937.724000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[206937.728000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[206937.732000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[206937.736000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[206937.736000] psmouse.c: issuing reconnect request
[213729.472000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[213729.472000] ath_pci: driver unloaded
[213729.824000] ACPI: PCI interrupt for device 0000:00:12.0 disabled
[213733.864000] PM: suspend-to-disk mode set to 'shutdown'
[213733.864000] Disabling non-boot CPUs ...
[213733.864000] Stopping tasks ... done.
[213734.324000] Shrinking memory...  -\|/-\|done (60279 pages freed)
[213758.324000] Freed 241116 kbytes in 24.04 seconds (10.02 MB/s)
[213758.324000] Suspending console(s)
[213758.324000] ac97 0-0:ALC655: freeze
[213758.324000] ide-disk 0.0: freeze
[213759.200000]  usbdev4.1_ep81: PM: suspend 0->1, parent 4-0:1.0 already 2
[213759.200000] hub 4-0:1.0: PM: suspend 2-->1
[213759.200000] hub 4-0:1.0: PM: suspend 2->1, parent usb4 already 2
[213759.200000]  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
[213759.200000] usb usb4: PM: suspend 2-->1
[213759.200000]  usbdev3.1_ep81: PM: suspend 0->1, parent 3-0:1.0 already 2
[213759.200000] hub 3-0:1.0: PM: suspend 2-->1
[213759.200000] hub 3-0:1.0: PM: suspend 2->1, parent usb3 already 2
[213759.200000]  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
[213759.200000] usb usb3: PM: suspend 2-->1
[213759.200000]  usbdev2.1_ep81: PM: suspend 0->1, parent 2-0:1.0 already 2
[213759.200000] hub 2-0:1.0: PM: suspend 2-->1
[213759.200000] hub 2-0:1.0: PM: suspend 2->1, parent usb2 already 2
[213759.200000]  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
[213759.200000] usb usb2: PM: suspend 2-->1
[213759.200000]  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 2
[213759.200000] hub 1-0:1.0: PM: suspend 2-->1
[213759.200000] hub 1-0:1.0: PM: suspend 2->1, parent usb1 already 2
[213759.200000]  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
[213759.200000] usb usb1: PM: suspend 2-->1
[213759.200000] platform vesafb.0: freeze
[213759.200000] platform eisa.0: freeze
[213759.200000] i8042 i8042: freeze
[213759.648000] serial8250 serial8250: freeze
[213759.648000] pcspkr pcspkr: freeze
[213759.648000] pnp 00:08: freeze
[213759.648000] system 00:07: freeze
[213759.648000] pnp 00:06: freeze
[213759.648000] system 00:05: freeze
[213759.648000] pnp 00:04: freeze
[213759.648000] pnp 00:03: freeze
[213759.648000] i8042 kbd 00:02: freeze
[213759.648000] i8042 aux 00:01: freeze
[213759.648000] pnp 00:00: freeze
[213759.648000] pci 0000:01:00.0: freeze
[213759.648000] pci 0000:00:12.0: freeze
[213759.648000] VIA 82xx Audio 0000:00:11.5: freeze
[213759.652000] ACPI: PCI interrupt for device 0000:00:11.5 disabled
[213759.868000] VIA_IDE 0000:00:11.1: freeze
[213759.868000] pci 0000:00:11.0: freeze
[213759.868000] ehci_hcd 0000:00:10.3: freeze
[213759.868000] ACPI: Link isn't initialized
[213759.868000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[213759.884000] uhci_hcd 0000:00:10.2: freeze
[213759.884000] ACPI: Link isn't initialized
[213759.884000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[213759.900000] uhci_hcd 0000:00:10.1: freeze
[213759.900000] ACPI: Link isn't initialized
[213759.900000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[213759.916000] uhci_hcd 0000:00:10.0: freeze
[213759.916000] ACPI: Link isn't initialized
[213759.916000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[213759.932000] pci 0000:00:06.0: freeze
[213759.932000] pci 0000:00:01.0: freeze
[213759.932000] pci 0000:00:00.7: freeze
[213759.932000] pci 0000:00:00.4: freeze
[213759.932000] pci 0000:00:00.3: freeze
[213759.932000] pci 0000:00:00.2: freeze
[213759.932000] pci 0000:00:00.1: freeze
[213759.932000] agpgart-via 0000:00:00.0: freeze
[213759.948000] acpi acpi: freeze
[213759.948000] PM: snapshotting memory.
[213759.948000] platform vesafb.0: LATE freeze
[213759.948000] platform eisa.0: LATE freeze
[213759.948000] i8042 i8042: LATE freeze
[213759.948000] serial8250 serial8250: LATE freeze
[213759.948000] pcspkr pcspkr: LATE freeze
[213759.948000] pci 0000:01:00.0: LATE freeze
[213759.948000] pci 0000:00:12.0: LATE freeze
[213759.948000] VIA 82xx Audio 0000:00:11.5: LATE freeze
[213759.948000] VIA_IDE 0000:00:11.1: LATE freeze
[213759.948000] pci 0000:00:11.0: LATE freeze
[213759.948000] pci 0000:00:06.0: LATE freeze
[213759.948000] pci 0000:00:01.0: LATE freeze
[213759.948000] pci 0000:00:00.7: LATE freeze
[213759.948000] pci 0000:00:00.4: LATE freeze
[213759.948000] pci 0000:00:00.3: LATE freeze
[213759.948000] pci 0000:00:00.2: LATE freeze
[213759.948000] pci 0000:00:00.1: LATE freeze
[213759.948000] agpgart-via 0000:00:00.0: LATE freeze
[213759.948000] swsusp: critical section: 
[213759.948000] swsusp: Need to copy 52500 pages
[213759.948000] swsusp: Normal pages needed: 52500 + 1024 + 14, available pages: 62169
[242745.948000] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[242745.948000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
[242745.948000] ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 11, using IRQ 23
[242745.948000] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[242745.948000] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 5, using IRQ 22
[242745.948000] agpgart-via 0000:00:00.0: EARLY resume
[242745.948000] pci 0000:00:00.1: EARLY resume
[242745.948000] pci 0000:00:00.2: EARLY resume
[242745.948000] pci 0000:00:00.3: EARLY resume
[242745.948000] pci 0000:00:00.4: EARLY resume
[242745.948000] pci 0000:00:00.7: EARLY resume
[242745.948000] pci 0000:00:01.0: EARLY resume
[242745.948000] pci 0000:00:06.0: EARLY resume
[242745.948000] uhci_hcd 0000:00:10.0: EARLY resume
[242745.948000] uhci_hcd 0000:00:10.1: EARLY resume
[242745.948000] uhci_hcd 0000:00:10.2: EARLY resume
[242745.948000] ehci_hcd 0000:00:10.3: EARLY resume
[242745.948000] pci 0000:00:11.0: EARLY resume
[242745.948000] VIA_IDE 0000:00:11.1: EARLY resume
[242745.948000] VIA 82xx Audio 0000:00:11.5: EARLY resume
[242745.948000] pci 0000:00:12.0: EARLY resume
[242745.948000] pci 0000:01:00.0: EARLY resume
[242745.948000] pcspkr pcspkr: EARLY resume
[242745.948000] serial8250 serial8250: EARLY resume
[242745.948000] i8042 i8042: EARLY resume
[242745.948000] platform eisa.0: EARLY resume
[242745.948000] platform vesafb.0: EARLY resume
[242745.948000] PM: Image restored successfully.
[242745.964000] acpi acpi: resuming
[242745.968000] agpgart-via 0000:00:00.0: resuming
[242745.984000] pci 0000:00:00.1: resuming
[242745.984000] pci 0000:00:00.2: resuming
[242745.984000] pci 0000:00:00.3: resuming
[242745.984000] pci 0000:00:00.4: resuming
[242745.984000] pci 0000:00:00.7: resuming
[242745.984000] pci 0000:00:01.0: resuming
[242745.984000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[242745.984000] pci 0000:00:06.0: resuming
[242745.984000] PM: Writing back config space on device 0000:00:06.0 at offset 3 (was 0, writing a820)
[242745.984000] PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 2900000, writing 2900002)
[242745.984000] uhci_hcd 0000:00:10.0: resuming
[242746.000000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[242746.000000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[242746.000000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[242746.000000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[242746.000000] ACPI: Invalid IRQ link routing entry
[242746.000000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[242746.000000] ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI - using IRQ 11
[242746.000000] usb usb1: root hub lost power or was reset
[242746.000000] uhci_hcd 0000:00:10.1: resuming
[242746.016000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[242746.016000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[242746.016000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[242746.016000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[242746.016000] ACPI: Invalid IRQ link routing entry
[242746.016000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[242746.016000] ACPI: PCI Interrupt 0000:00:10.1[B]: no GSI - using IRQ 7
[242746.016000] usb usb2: root hub lost power or was reset
[242746.016000] uhci_hcd 0000:00:10.2: resuming
[242746.032000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[242746.032000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[242746.032000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[242746.032000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[242746.032000] ACPI: Invalid IRQ link routing entry
[242746.032000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[242746.032000] ACPI: PCI Interrupt 0000:00:10.2[C]: no GSI - using IRQ 5
[242746.032000] usb usb3: root hub lost power or was reset
[242746.032000] ehci_hcd 0000:00:10.3: resuming
[242746.048000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[242746.048000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[242746.048000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[242746.048000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[242746.048000] ACPI: Invalid IRQ link routing entry
[242746.048000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[242746.048000] ACPI: PCI Interrupt 0000:00:10.3[D]: no GSI - using IRQ 10
[242746.048000] usb usb4: root hub lost power or was reset
[242746.048000] pci 0000:00:11.0: resuming
[242746.048000] VIA_IDE 0000:00:11.1: resuming
[242746.048000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 17
[242746.048000] VIA 82xx Audio 0000:00:11.5: resuming
[242746.064000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 19
[242746.064000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[242746.064000] pci 0000:00:12.0: resuming
[242746.064000] PM: Writing back config space on device 0000:00:12.0 at offset 1 (was 2100087, writing 2100083)
[242746.064000] pci 0000:01:00.0: resuming
[242746.564000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[242746.564000] pnp 00:00: resuming
[242746.564000] i8042 aux 00:01: resuming
[242746.564000] pnp: Failed to activate device 00:01.
[242746.564000] i8042 kbd 00:02: resuming
[242746.564000] pnp: Failed to activate device 00:02.
[242746.564000] pnp 00:03: resuming
[242746.564000] pnp 00:04: resuming
[242746.564000] system 00:05: resuming
[242746.564000] pnp 00:06: resuming
[242746.564000] system 00:07: resuming
[242746.564000] pnp 00:08: resuming
[242746.564000] pcspkr pcspkr: resuming
[242746.564000] serial8250 serial8250: resuming
[242746.564000] i8042 i8042: resuming
[242746.572000] atkbd serio0: resuming
[242746.584000] platform eisa.0: resuming
[242746.584000] serio serio1: resuming
[242746.584000] serio serio2: resuming
[242746.584000] psmouse serio3: resuming
[242747.260000] serio serio4: resuming
[242747.260000] platform vesafb.0: resuming
[242747.260000] usb usb1: resuming
[242747.300000] usb usb2: resuming
[242747.340000] usb usb3: resuming
[242747.380000] usb usb4: resuming
[242747.400000] ide-disk 0.0: resuming
[242747.436000] ac97 0-0:ALC655: resuming
[242747.436000] Restarting tasks ... done.
[242747.440000] Enabling non-boot CPUs ...
[242784.748000] ath_pci: 0.9.4.5 (0.9.3.1)
[242784.748000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 18
[242785.332000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[242785.332000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[242785.332000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[242785.332000] wifi0: mac 7.8 phy 4.5 radio 5.6
[242785.332000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[242785.332000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[242785.332000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[242785.332000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[242785.332000] wifi0: Use hw queue 8 for CAB traffic
[242785.332000] wifi0: Use hw queue 9 for beacons
[242785.336000] wifi0: Atheros 5212: mem=0x20000000, irq=18
[242786.576000] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[242786.580000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKB] -> GSI 23 (level, low) -> IRQ 16
[242786.584000] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 16.
[242786.584000] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[242789.200000] eth0: link down
[242789.204000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[242799.068000] input: Power Button (FF) as /class/input/input19
[242799.068000] ACPI: Power Button (FF) [PWRF]
[242799.068000] input: Lid Switch as /class/input/input20
[242799.068000] ACPI: Lid Switch [LID]
[242799.072000] input: Sleep Button (CM) as /class/input/input21
[242799.072000] ACPI: Sleep Button (CM) [SBTN]
[242801.716000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[242801.716000] ACPI: Processor [CPU0] (supports 16 throttling states)
[242802.176000] ACPI: Thermal Zone [TZ0] (0 C)
[242802.500000] ACPI: AC Adapter [AC] (on-line)
[242803.072000] ACPI: Battery Slot [BAT0] (battery present)
[242880.960000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[242900.748000] ath0: no IPv6 routers present
[245061.432000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[245061.432000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[245061.436000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[245061.436000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[245061.440000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[245061.440000] psmouse.c: issuing reconnect request
[251263.576000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 4
[251263.576000] psmouse.c: TouchPad at isa0060/serio3/input0 lost sync at byte 1
[251263.592000] psmouse.c: TouchPad at isa0060/serio3/input0 - driver resynched.
[292731.152000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[292731.152000] ath_pci: driver unloaded
[292731.408000] ACPI: PCI interrupt for device 0000:00:12.0 disabled
[292735.976000] PM: suspend-to-disk mode set to 'shutdown'
[292735.976000] Disabling non-boot CPUs ...
[292735.976000] Stopping tasks ... done.
[292736.704000] Shrinking memory...  -\|/-\done (57617 pages freed)
[292771.276000] Freed 230468 kbytes in 34.60 seconds (6.66 MB/s)
[292771.276000] Suspending console(s)
[292771.276000] ac97 0-0:ALC655: freeze
[292771.276000] ide-disk 0.0: freeze
[292772.208000]  usbdev4.1_ep81: PM: suspend 0->1, parent 4-0:1.0 already 2
[292772.208000] hub 4-0:1.0: PM: suspend 2-->1
[292772.208000] hub 4-0:1.0: PM: suspend 2->1, parent usb4 already 2
[292772.208000]  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
[292772.208000] usb usb4: PM: suspend 2-->1
[292772.208000]  usbdev3.1_ep81: PM: suspend 0->1, parent 3-0:1.0 already 2
[292772.208000] hub 3-0:1.0: PM: suspend 2-->1
[292772.208000] hub 3-0:1.0: PM: suspend 2->1, parent usb3 already 2
[292772.208000]  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
[292772.208000] usb usb3: PM: suspend 2-->1
[292772.208000]  usbdev2.1_ep81: PM: suspend 0->1, parent 2-0:1.0 already 2
[292772.208000] hub 2-0:1.0: PM: suspend 2-->1
[292772.208000] hub 2-0:1.0: PM: suspend 2->1, parent usb2 already 2
[292772.208000]  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
[292772.208000] usb usb2: PM: suspend 2-->1
[292772.208000]  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 2
[292772.208000] hub 1-0:1.0: PM: suspend 2-->1
[292772.208000] hub 1-0:1.0: PM: suspend 2->1, parent usb1 already 2
[292772.208000]  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
[292772.208000] usb usb1: PM: suspend 2-->1
[292772.208000] platform vesafb.0: freeze
[292772.208000] platform eisa.0: freeze
[292772.208000] i8042 i8042: freeze
[292772.624000] serial8250 serial8250: freeze
[292772.624000] pcspkr pcspkr: freeze
[292772.624000] pnp 00:08: freeze
[292772.624000] system 00:07: freeze
[292772.624000] pnp 00:06: freeze
[292772.624000] system 00:05: freeze
[292772.624000] pnp 00:04: freeze
[292772.624000] pnp 00:03: freeze
[292772.624000] i8042 kbd 00:02: freeze
[292772.624000] i8042 aux 00:01: freeze
[292772.624000] pnp 00:00: freeze
[292772.624000] pci 0000:01:00.0: freeze
[292772.624000] pci 0000:00:12.0: freeze
[292772.624000] VIA 82xx Audio 0000:00:11.5: freeze
[292772.624000] ACPI: PCI interrupt for device 0000:00:11.5 disabled
[292772.840000] VIA_IDE 0000:00:11.1: freeze
[292772.840000] pci 0000:00:11.0: freeze
[292772.840000] ehci_hcd 0000:00:10.3: freeze
[292772.840000] ACPI: Link isn't initialized
[292772.840000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[292772.856000] uhci_hcd 0000:00:10.2: freeze
[292772.856000] ACPI: Link isn't initialized
[292772.856000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[292772.872000] uhci_hcd 0000:00:10.1: freeze
[292772.872000] ACPI: Link isn't initialized
[292772.872000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[292772.888000] uhci_hcd 0000:00:10.0: freeze
[292772.888000] ACPI: Link isn't initialized
[292772.888000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[292772.904000] pci 0000:00:06.0: freeze
[292772.904000] pci 0000:00:01.0: freeze
[292772.904000] pci 0000:00:00.7: freeze
[292772.904000] pci 0000:00:00.4: freeze
[292772.904000] pci 0000:00:00.3: freeze
[292772.904000] pci 0000:00:00.2: freeze
[292772.904000] pci 0000:00:00.1: freeze
[292772.904000] agpgart-via 0000:00:00.0: freeze
[292772.920000] acpi acpi: freeze
[292772.920000] PM: snapshotting memory.
[292772.920000] platform vesafb.0: LATE freeze
[292772.920000] platform eisa.0: LATE freeze
[292772.920000] i8042 i8042: LATE freeze
[292772.920000] serial8250 serial8250: LATE freeze
[292772.920000] pcspkr pcspkr: LATE freeze
[292772.920000] pci 0000:01:00.0: LATE freeze
[292772.920000] pci 0000:00:12.0: LATE freeze
[292772.920000] VIA 82xx Audio 0000:00:11.5: LATE freeze
[292772.920000] VIA_IDE 0000:00:11.1: LATE freeze
[292772.920000] pci 0000:00:11.0: LATE freeze
[292772.920000] pci 0000:00:06.0: LATE freeze
[292772.920000] pci 0000:00:01.0: LATE freeze
[292772.920000] pci 0000:00:00.7: LATE freeze
[292772.920000] pci 0000:00:00.4: LATE freeze
[292772.920000] pci 0000:00:00.3: LATE freeze
[292772.920000] pci 0000:00:00.2: LATE freeze
[292772.920000] pci 0000:00:00.1: LATE freeze
[292772.920000] agpgart-via 0000:00:00.0: LATE freeze
[292772.920000] swsusp: critical section: 
[292772.920000] swsusp: Need to copy 55245 pages
[292772.920000] swsusp: Normal pages needed: 55245 + 1024 + 14, available pages: 59424
[329434.920000] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[329434.920000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
[329434.920000] ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 11, using IRQ 23
[329434.920000] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[329434.920000] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 5, using IRQ 22
[329434.920000] agpgart-via 0000:00:00.0: EARLY resume
[329434.920000] pci 0000:00:00.1: EARLY resume
[329434.920000] pci 0000:00:00.2: EARLY resume
[329434.920000] pci 0000:00:00.3: EARLY resume
[329434.920000] pci 0000:00:00.4: EARLY resume
[329434.920000] pci 0000:00:00.7: EARLY resume
[329434.920000] pci 0000:00:01.0: EARLY resume
[329434.920000] pci 0000:00:06.0: EARLY resume
[329434.920000] uhci_hcd 0000:00:10.0: EARLY resume
[329434.920000] uhci_hcd 0000:00:10.1: EARLY resume
[329434.920000] uhci_hcd 0000:00:10.2: EARLY resume
[329434.920000] ehci_hcd 0000:00:10.3: EARLY resume
[329434.920000] pci 0000:00:11.0: EARLY resume
[329434.920000] VIA_IDE 0000:00:11.1: EARLY resume
[329434.920000] VIA 82xx Audio 0000:00:11.5: EARLY resume
[329434.920000] pci 0000:00:12.0: EARLY resume
[329434.920000] pci 0000:01:00.0: EARLY resume
[329434.920000] pcspkr pcspkr: EARLY resume
[329434.920000] serial8250 serial8250: EARLY resume
[329434.920000] i8042 i8042: EARLY resume
[329434.920000] platform eisa.0: EARLY resume
[329434.920000] platform vesafb.0: EARLY resume
[329434.920000] PM: Image restored successfully.
[329434.936000] acpi acpi: resuming
[329434.940000] agpgart-via 0000:00:00.0: resuming
[329434.956000] pci 0000:00:00.1: resuming
[329434.956000] pci 0000:00:00.2: resuming
[329434.956000] pci 0000:00:00.3: resuming
[329434.956000] pci 0000:00:00.4: resuming
[329434.956000] pci 0000:00:00.7: resuming
[329434.956000] pci 0000:00:01.0: resuming
[329434.956000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[329434.956000] pci 0000:00:06.0: resuming
[329434.956000] PM: Writing back config space on device 0000:00:06.0 at offset 3 (was 0, writing a820)
[329434.956000] PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 2900000, writing 2900002)
[329434.956000] uhci_hcd 0000:00:10.0: resuming
[329434.972000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[329434.972000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[329434.972000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[329434.972000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[329434.972000] ACPI: Invalid IRQ link routing entry
[329434.972000] ACPI: Unable to derive IRQ for device 0000:00:10.0
[329434.972000] ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI - using IRQ 11
[329434.972000] usb usb1: root hub lost power or was reset
[329434.972000] uhci_hcd 0000:00:10.1: resuming
[329434.988000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[329434.988000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[329434.988000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[329434.988000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[329434.988000] ACPI: Invalid IRQ link routing entry
[329434.988000] ACPI: Unable to derive IRQ for device 0000:00:10.1
[329434.988000] ACPI: PCI Interrupt 0000:00:10.1[B]: no GSI - using IRQ 7
[329434.988000] usb usb2: root hub lost power or was reset
[329434.988000] uhci_hcd 0000:00:10.2: resuming
[329435.004000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[329435.004000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[329435.004000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[329435.004000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[329435.004000] ACPI: Invalid IRQ link routing entry
[329435.004000] ACPI: Unable to derive IRQ for device 0000:00:10.2
[329435.004000] ACPI: PCI Interrupt 0000:00:10.2[C]: no GSI - using IRQ 5
[329435.004000] usb usb3: root hub lost power or was reset
[329435.004000] ehci_hcd 0000:00:10.3: resuming
[329435.020000] ACPI Error (uteval-0269): Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node da6469f0), AE_TYPE
[329435.020000] ACPI Error (uteval-0275): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20060707]
[329435.020000] ACPI Exception (pci_link-0278): AE_TYPE, Evaluating _CRS [20060707]
[329435.020000] ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD]. Try pci=noacpi or acpi=off
[329435.020000] ACPI: Invalid IRQ link routing entry
[329435.020000] ACPI: Unable to derive IRQ for device 0000:00:10.3
[329435.020000] ACPI: PCI Interrupt 0000:00:10.3[D]: no GSI - using IRQ 10
[329435.020000] usb usb4: root hub lost power or was reset
[329435.020000] pci 0000:00:11.0: resuming
[329435.020000] VIA_IDE 0000:00:11.1: resuming
[329435.020000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 17
[329435.020000] VIA 82xx Audio 0000:00:11.5: resuming
[329435.036000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 19
[329435.036000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[329435.036000] pci 0000:00:12.0: resuming
[329435.036000] PM: Writing back config space on device 0000:00:12.0 at offset 1 (was 2100087, writing 2100083)
[329435.036000] pci 0000:01:00.0: resuming
[329435.536000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[329435.536000] pnp 00:00: resuming
[329435.536000] i8042 aux 00:01: resuming
[329435.536000] pnp: Failed to activate device 00:01.
[329435.536000] i8042 kbd 00:02: resuming
[329435.536000] pnp: Failed to activate device 00:02.
[329435.536000] pnp 00:03: resuming
[329435.536000] pnp 00:04: resuming
[329435.536000] system 00:05: resuming
[329435.536000] pnp 00:06: resuming
[329435.536000] system 00:07: resuming
[329435.536000] pnp 00:08: resuming
[329435.536000] pcspkr pcspkr: resuming
[329435.536000] serial8250 serial8250: resuming
[329435.536000] i8042 i8042: resuming
[329435.544000] atkbd serio0: resuming
[329435.556000] platform eisa.0: resuming
[329435.556000] serio serio1: resuming
[329435.556000] serio serio2: resuming
[329435.556000] psmouse serio3: resuming
[329436.192000] serio serio4: resuming
[329436.192000] platform vesafb.0: resuming
[329436.192000] usb usb1: resuming
[329436.232000] usb usb2: resuming
[329436.272000] usb usb3: resuming
[329436.312000] usb usb4: resuming
[329436.332000] ide-disk 0.0: resuming
[329436.368000] ac97 0-0:ALC655: resuming
[329436.368000] Restarting tasks ... done.
[329436.372000] Enabling non-boot CPUs ...
[329471.292000] ath_pci: 0.9.4.5 (0.9.3.1)
[329471.292000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 18
[329471.872000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[329471.872000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[329471.872000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[329471.872000] wifi0: mac 7.8 phy 4.5 radio 5.6
[329471.872000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[329471.872000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[329471.872000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[329471.872000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[329471.872000] wifi0: Use hw queue 8 for CAB traffic
[329471.872000] wifi0: Use hw queue 9 for beacons
[329471.872000] wifi0: Atheros 5212: mem=0x20000000, irq=18
[329472.664000] via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
[329472.664000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKB] -> GSI 23 (level, low) -> IRQ 16
[329472.668000] eth0: VIA Rhine II at 0x1e200, 00:40:d0:8c:b7:37, IRQ 16.
[329472.672000] eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
[329478.368000] eth0: link down
[329478.368000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[329489.272000] ath0: no IPv6 routers present
[329489.656000] input: Power Button (FF) as /class/input/input22
[329489.656000] ACPI: Power Button (FF) [PWRF]
[329489.656000] input: Lid Switch as /class/input/input23
[329489.656000] ACPI: Lid Switch [LID]
[329489.656000] input: Sleep Button (CM) as /class/input/input24
[329489.656000] ACPI: Sleep Button (CM) [SBTN]
[329492.088000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[329492.088000] ACPI: Processor [CPU0] (supports 16 throttling states)
[329492.572000] ACPI: Thermal Zone [TZ0] (0 C)
[329493.216000] ACPI: AC Adapter [AC] (on-line)
[329493.916000] ACPI: Battery Slot [BAT0] (battery present)
[329785.608000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[329803.832000] ath0: no IPv6 routers present

--Boundary-00=_vgXxGJR3X+9rBNn
Content-Type: text/plain;
  charset="utf-8";
  name="less_proc_interrupts_ACPI_on.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="less_proc_interrupts_ACPI_on.txt"

           CPU0       
  0:      34597    XT-PIC-XT        timer
  1:        287    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:          0    XT-PIC-XT        uhci_hcd:usb3, VIA8233
  7:          0    XT-PIC-XT        uhci_hcd:usb2
  8:          3    XT-PIC-XT        rtc
 10:          0    XT-PIC-XT        ehci_hcd:usb4
 11:       5456    XT-PIC-XT        uhci_hcd:usb1, eth0, via@pci:0000:01:00.0
 12:       1363    XT-PIC-XT        i8042
 14:      12733    XT-PIC-XT        ide0
NMI:        364 
LOC:      34471 
ERR:          0
MIS:          0

--Boundary-00=_vgXxGJR3X+9rBNn
Content-Type: text/plain;
  charset="utf-8";
  name="less_proc_interrupts_ACPI_off.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="less_proc_interrupts_ACPI_off.txt"

           CPU0       
  0:   35866764   IO-APIC-edge      timer
  1:     156905   IO-APIC-edge      i8042
  5:          0   IO-APIC-fasteoi   uhci_hcd:usb3
  7:          0   IO-APIC-fasteoi   uhci_hcd:usb2
  8:          9   IO-APIC-edge      rtc
  9:      87398   IO-APIC-fasteoi   acpi
 10:          0   IO-APIC-fasteoi   ehci_hcd:usb4
 11:          0   IO-APIC-fasteoi   uhci_hcd:usb1
 12:    8933564   IO-APIC-edge      i8042
 14:    1007473   IO-APIC-edge      ide0
 16:          0   IO-APIC-fasteoi   eth0
 18:   29378962   IO-APIC-fasteoi   wifi0
 19:     587878   IO-APIC-fasteoi   VIA8233
 20:     777705   IO-APIC-fasteoi   via@pci:0000:01:00.0
NMI:          0 
LOC:   35866579 
ERR:          0
MIS:          0

--Boundary-00=_vgXxGJR3X+9rBNn--

