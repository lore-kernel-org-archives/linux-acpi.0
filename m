From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org: [BUG] pdc202xx_new and ACPI
 fails]
Date: 05 Dec 2004 17:36:09 -0500
Message-ID: <1102286168.2308.13.camel@d845pe>
References: <20041205211754.GB7695@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041205211754.GB7695-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nico Schottelius <nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nico,
Please verify that you're running the latest system BIOS,
then re-test with 2.6.10-rc3.

If it still fails, then file a bug here
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
category: config-interrupts

In the bug report, please attach the 2.6.10-rc3 dmesg
and include the /proc/interrupts for:

A. no kernel parameters (the failure)
B. "noapic" (may work, may fail)
C. "acpi=noirq". (success case)

Also attache the output from "lspci -vv" and the output
from acpidmp, available in /usr/sbin or in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

It is possible that this failure is isolated to IOAPIC mode,
which ACPI enablds by default.  So it may be that config B
above with the IOAPIC manually disabled will run ACPI
just fine, including power-button interrupts etc.

That would still be a workaround, however, and the
lspci and acpidmp output along with the dmesg should
tell us exactly what is happening in ACPI+IOAPIC mode.

thanks,
-Len



On Sun, 2004-12-05 at 16:17, Nico Schottelius wrote:


> when loading with apm onlyi and enabling forced, 
> it works fine [1].

> [0]: see attached dmesg.eiche
> 
> [1]: 
> PDC20270: IDE controller at PCI slot 0000:02:01.0
> PDC20270: chipset revision 2
> PDC20270: ROM enabled at 0xdfee0000
> PDC20270: 100% native mode on irq 10
>     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
>     ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
> ide3 at 0xc400-0xc407,0xc002 on irq 10
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hdk: WDC WD1200BB-00GUA0, ATA DISK drive
> ide5 at 0xb000-0xb007,0xac02 on irq 10
> hdk: max request size: 1024KiB
> hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hdk: cache flushes supported
>  /dev/ide/host4/bus1/target0/lun0: unknown partition table

> Linux version 2.6.9 (root@eiche) (gcc version 3.3.4 (Debian 1:3.3.4-11)) #11 Sun Dec 5 01:44:49 CET 2004
> BIOS-provided physical RAM map:
>  
> Kernel command line: rsbac_softmode

> ACPI: Subsystem revision 20040816
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Power Resource [URP1] (off)
> ACPI: Power Resource [URP2] (off)
> ACPI: Power Resource [FDDP] (off)
> ACPI: Power Resource [LPTP] (off)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> SCSI subsystem initialized
> PCI: Using ACPI for IRQ routing
> ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
> ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
> ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
> ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
> ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
> ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
> ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 19
> ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> Machine check exception polling timer started.
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> devfs: boot_options: 0x1
> SGI XFS with ACLs, no debug enabled
> SGI XFS Quota Management subsystem
> Initializing Cryptographic API
> PCI: Via IRQ fixup for 0000:00:10.1, from 3 to 5
> PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
> Linux agpgart interface v0.100 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: SAMSUNG SV2042H, ATA DISK drive
> Using cfq io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: WDC WD400EB-00CPF0, ATA DISK drive
> hdd: SAMSUNG SV3064D, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 39865392 sectors (20411 MB) w/426KiB Cache, CHS=39549/16/63, UDMA(100)
> hda: cache flushes not supported
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> hdc: max request size: 128KiB
> hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> hdc: cache flushes not supported
>  /dev/ide/host0/bus1/target0/lun0: unknown partition table
> hdd: max request size: 128KiB
> hdd: 59794560 sectors (30614 MB) w/434KiB Cache, CHS=59320/16/63, UDMA(66)
> hdd: cache flushes not supported
>  /dev/ide/host0/bus1/target1/lun0: unknown partition table
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 32768)
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> ACPI: (supports S0 S1 S4 S5)
> ACPI wakeup devices: 
> PCI0 UAR1 USB1 USB2 USB3 EHCI PS2M PS2K  AC9  MC9 ILAN SLPB 
> BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
> Mount JFS Failure: -22
> XFS mounting filesystem hda2
> Ending clean XFS mount for filesystem: hda2
> VFS: Mounted root (xfs filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 164k freed
> Adding 112444k swap on /dev/ide/host0/bus0/target0/lun0/part3.  Priority:-1 extents:1
> device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
> XFS mounting filesystem hda1
> Ending clean XFS mount for filesystem: hda1
> XFS mounting filesystem hdc
> Ending clean XFS mount for filesystem: hdc
> XFS mounting filesystem hdd
> Ending clean XFS mount for filesystem: hdd
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: irq 21, io base 0000e400
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: irq 21, io base 0000e800
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: irq 21, io base 0000ec00
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
> ehci_hcd 0000:00:10.3: EHCI Host Controller
> ehci_hcd 0000:00:10.3: irq 21, pci mem d0806f00
> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
> ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 6 ports detected
> via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
> ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
> eth0: VIA Rhine II at 0xdffffe00, 00:0b:6a:15:06:68, IRQ 23.
> eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> apm: BIOS not found.
> PDC20270: IDE controller at PCI slot 0000:02:01.0
> ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 19
> PDC20270: chipset revision 2
> PDC20270: ROM enabled at 0xdfee0000
> PDC20270: 100% native mode on irq 19
>     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
> ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
>     ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
> ide3 at 0xc400-0xc407,0xc002 on irq 19
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hdk: WDC WD1200BB-00GUA0, ATA DISK drive
> ide5 at 0xb000-0xb007,0xac02 on irq 16
> hdk: max request size: 1024KiB
> irq 19: nobody cared!
>  [<c0106614>] __report_bad_irq+0x24/0x80
>  [<c01066f1>] note_interrupt+0x61/0x90
>  [<c01065bb>] handle_IRQ_event+0x2b/0x60
>  [<c01069aa>] do_IRQ+0x11a/0x130
>  [<c0104974>] common_interrupt+0x18/0x20
> handlers:
> [<c0290d90>] (ide_intr+0x0/0x170)
> Disabling IRQ #19




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
