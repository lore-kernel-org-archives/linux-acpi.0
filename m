From: Matt R Hall <mhall-Hv3ogNYU3JfZZajBQzqCxQ@public.gmane.org>
Subject: Re: ACER Aspire 5000
Date: Wed, 31 Aug 2005 13:19:25 -0700 (PDT)
Message-ID: <20050831201925.19263.qmail@web81601.mail.yahoo.com>
References: <20050829180845.98096.qmail@web81605.mail.yahoo.com>
Reply-To: mhall-Hv3ogNYU3JfZZajBQzqCxQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050829180845.98096.qmail-ZDCUxwME616A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am happy to report that I believe that the system is working properly
now that the necessary DSDT modifications have been performed. Once I
have fully tested this to ensure there are no remaining issues I will
release my fixed DSDT for the latest BIOS revision 3A26 onto the Linux
ACPI page.

Now, regarding the secondary issue brought up by my thread: how can we
encourage vendors to quit using Microsoft's non-standard inferior ACPI
compiler? I am quite disappointed by this sad state of affairs. It is
very frustrating that every laptop I have ever owned had broken ACPI
support.

Additionally [off-topic a little I think] it's also ridiculous that
Broadcom wireless chips (used in so many laptops) are incompetently
supported by their vendor. They are so incompetent they will not
release decent working reference drivers on their website for any OS,
including XP and XP 64-bit edition. Sadly (or happily depending on
one's angle) many of the devices in my laptop do not support XP 64-bit
at all and Linux support for 64-bit mode is far superior.

I owe you all an e-beer for your great assistance with my problem.

Thanks,
Matt

--- Matt R Hall <mhall-Hv3ogNYU3JfZZajBQzqCxQ@public.gmane.org> wrote:

> I am having some problems with ACPI battery support on an ACER Aspire
> 5000. I am unable to read the battery state, which makes this laptop
> nearly useless. I suspect the DSDT code was missing a variable
> declaration or something and this was not caught by Microsoft's
> compiler, but I'm nowhere near expert with the DSDT programming
> language, so some help would be greatly appreciated.
>=20
> Relevant ASCII information is included inline. The /proc/acpi/dsdt
> file
> is attached.
>=20
> Please note that I compiled the ACPI support as modules for
> troubleshooting purposes. If this is bad please let me know and I can
> do a static link. BTW, it did not seem to work when compiled
> statically
> either.
>=20
> Thanks in advance!
>=20
> uname -a output:
> Linux themhalltop 2.6.13 #1 Mon Aug 29 00:52:21 PDT 2005 i686
> GNU/Linux
>=20
>=20
>=20
>=20
> dmesg output that occurs reading the /proc/acpi/battery/BAT1/state
> file:
>   psargs-0362: *** Error: Looking up [Z007] in namespace,
> AE_NOT_FOUND
> search_node c142a1a8 start_node c142a1a8 return_node 00000000
>  dswexec-0457 [439] ds_exec_end_op        : [Index]: Could not
> resolve
> operands, AE_NOT_FOUND
>  psparse-1172: *** Error: Method execution failed [\_SB_.BAT1._BST]
> (Node ddec0ee8), AE_NOT_FOUND
> acpi_battery-0208 [431] acpi_battery_get_statu: Error evaluating _BST
>=20
>=20
>=20
>=20
> dmesg output from boot cycle:
> Linux version 2.6.13 (root@themhalltop) (gcc version 4.0.2 20050821
> (prerelease) (Debian 4.0.1-6)) #1 Mon Aug 29 00:52:21 PDT 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
>  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001def0000 (usable)
>  BIOS-e820: 000000001def0000 - 000000001defa000 (ACPI data)
>  BIOS-e820: 000000001defa000 - 000000001df00000 (ACPI NVS)
>  BIOS-e820: 000000001df00000 - 0000000020000000 (reserved)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> 478MB LOWMEM available.
> found SMP MP-table at 000f7fd0
> On node 0 totalpages: 122608
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 118512 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7f60
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
> 0x1def61be
> ACPI: FADT (v001 SiS    755F     0x06040000 PTL  0x000f4240) @
> 0x1def9e5f
> ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
> 0x1def9ed3
> ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @
> 0x1def9f88
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
> 0x1def9fd8
> ACPI: DSDT (v001 PTLTD       755 0x06040000 MSFT 0x0100000e) @
> 0x00000000
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:4 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ11 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 20000000 (gap:
> 20000000:dff00000)
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=3Dlinux root=3D303 ec_burst=3D0
> ACPI: EC polling mode.
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 1600.563 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 480092k/490432k available (3827k kernel code, 9780k reserved,
> 1237k data, 180k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor
> mode... Ok.
> Calibrating delay using timer specific routine.. 3201.22 BogoMIPS
> (lpj=3D1600613)
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000
> 00000000
> 00000001 00000000 00000001
> CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000
> 00000001 00000000 00000001
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000010
> 00000001 00000000 00000001
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> mtrr: v2.0 (20020519)
> CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
>  tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully
> acquired
> Parsing all Control
>
Methods:.................................................................=
.................
> Table [DSDT](id F005) - 496 Objects with 38 Devices 82 Methods 12
> Regions
> Parsing all Control Methods:
> Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
> ACPI Namespace successfully loaded at root c06496a0
> evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode
> successful
> ENABLING IO-APIC IRQs
> ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfd776, last bus=3D1
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20050408
> evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs
> on int 0xB
> evgpeblk-1024 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0
> Runtime GPEs in this block
> evgpeblk-1016 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs
> on int 0xB
> evgpeblk-1024 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0
> Runtime GPEs in this block
> Completing Region/Field/Buffer/Package
>
initialization:.........................................................
>  psargs-0362: *** Error: Looking up [Z007] in namespace, AE_NOT_FOUND
> search_node c142a1a8 start_node c142a1a8 return_node 00000000
>=20
>   nsinit-0316 [06] ns_init_one_object    : Could not execute
> arguments
> for [PBST] (Package), AE_NOT_FOUND
> .........
> Initialized 12/12 Regions 5/5 Fields 26/26 Buffers 23/30 Packages
> (508
> nodes)
> Executing all Device _STA and_INI
> methods:..........................................
> 42 Devices found containing: 42 _STA, 1 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
> Uncovering SIS963 that hid as a SIS503 (compatible=3D0)
> Enabling SiS 96x SMBus.
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
> Boot video device is 0000:01:00.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Embedded Controller [EC0] (gpe 25)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 *7 9 10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 7 9 10 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 7 devices
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post
> a
> report
> PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
> PCI: Bridge: 0000:00:01.0
>   IO window: a000-afff
>   MEM window: e2100000-e21fffff
>   PREFETCH window: e8000000-efffffff
> PCI: Bus 2, cardbus bridge: 0000:00:06.0
>   IO window: 00002400-000024ff
>   IO window: 00002800-000028ff
>   PREFETCH window: 20000000-21ffffff
>   MEM window: 22000000-23ffffff
> PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
> ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 169
> pnp: 00:03: ioport range 0x8000-0x807f could not be reserved
> pnp: 00:03: ioport range 0x8080-0x80ff has been reserved
> pnp: 00:03: ioport range 0x8100-0x811f has been reserved
> pnp: 00:03: ioport range 0x4d0-0x4d1 has been reserved
> Simple Boot Flag at 0x38 set to 0x1
> IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
> NTFS driver 2.1.23 [Flags: R/O].
> SGI XFS with ACLs, no debug enabled
> Initializing Cryptographic API
> Real Time Clock Driver v1.12
> Non-volatile memory driver v1.2
> Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0
> soft_margin=3D60
> sec (nowayout=3D 1)
> Linux agpgart interface v0.101 (c) Dave Jones
> agpgart: Detected SiS 760 chipset
> agpgart: AGP aperture is 4M @ 0xe0000000
> [drm] Initialized drm 1.0.0 20040925
> Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds,
> margin
> is 60 seconds).
> Hangcheck: Using monotonic_clock().
> PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
> disabled
> acpi_bus-0212 [08] acpi_bus_set_power    : Device is not power
> manageable
> ACPI: PCI Interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 177
> ACPI: PCI interrupt for device 0000:00:02.6 disabled
> io scheduler noop registered
> io scheduler cfq registered
> pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe-l3A5Bk7waGM@public.gmane.org) and
> petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
> sis900.c: v1.08.08 Jan. 22 2005
> acpi_bus-0212 [08] acpi_bus_set_power    : Device is not power
> manageable
> ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 169
> 0000:00:04.0: Realtek RTL8201 PHY transceiver found at address 13.
> 0000:00:04.0: Using transceiver found at address 13 as default
> eth0: SiS 900 PCI Fast Ethernet at 0x1800, IRQ 169,
> 00:c0:9f:a6:f3:00.
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=3Dxx
> SIS5513: IDE controller at PCI slot 0000:00:02.5
> ACPI: PCI Interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 185
> SIS5513: chipset revision 0
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
>     ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: ST9808210A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: Slimtype DVDRW SOSW-833S, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=3D16383/255/63,
> UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4
> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 19 (level, low) -> IRQ 169
> Yenta: CardBus bridge found at 0000:00:06.0 [1025:0083]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:00:06.0, mfunc 0x00521d22, devctl 0x64
> Yenta: ISA IRQ mask 0x06f8, PCI irq 169
> Socket status: 30000020
> acpi_bus-0212 [08] acpi_bus_set_power    : Device is not power
> manageable
> ACPI: PCI Interrupt 0000:00:03.2[D] -> GSI 23 (level, low) -> IRQ 193
> ehci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 2.0
> Controller
> ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:03.2: irq 193, io mem 0xe2004000
> PCI: cache line size of 64 is not supported by device 0000:00:03.2
> ehci_hcd 0000:00:03.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
> 2004
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
> (PCI)
> ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 201
> ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0
> Controller
> ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:03.0: irq 201, io mem 0xe2002000
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 209
> ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0
> Controller (#2)
> ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:00:03.1: irq 209, io mem 0xe2003000
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 3 ports detected
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> mice: PS/2 mouse device common for all mice
> Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
> 12:20:13 2005 UTC).
> ACPI: PCI Interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 177
> input: AT Translated Set 2 keyboard on isa0060/serio0
> intel8x0_measure_ac97_clock: measured 50518 usecs
> intel8x0: clocking to 48000
> ACPI: PCI Interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 177
> ALSA device list:
>   #0: SiS SI7012 with ALC203 at 0x1400, irq 177
>   #1: SiS SI7013 Modem at 0x1000, irq 177
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> Disabled Privacy Extensions on device c059b760(lo)
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version
> 1.50.3)
> powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)
> powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> cpu_init done, current fid 0x8, vid 0x4
> Using IPI Shortcut mode
> ACPI wakeup devices:=20
> PCI0  LAN MODM USB0 USB1 USB2 USB3=20
> ACPI: (supports S0 S3 S4 S5)
> BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps:
> 0xa04713/0x4000
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> UDF-fs: No VRS found
> XFS mounting filesystem hda3
> Ending clean XFS mount for filesystem: hda3
> VFS: Mounted root (xfs filesystem) readonly.
> Freeing unused kernel memory: 180k freed
> Adding 979924k swap on /dev/hda1.  Priority:-1 extents:1
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> ath_hal: module license 'Proprietary' taints kernel.
> ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
> wlan: 0.8.6.0 (EXPERIMENTAL)
> ath_rate_sample: 1.2
> ath_pci: 0.9.6.0 (EXPERIMENTAL)
> PCI: Enabling device 0000:02:00.0 (0000 -> 0002)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 169
> Build date: Aug 29 2005
> Debugging version (IEEE80211)
> ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
> ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps
> 24Mbps 36Mbps 48Mbps 54Mbps
> ath0: turboG rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps
> 54Mbps
> ath0: H/W encryption support: WEP AES AES_CCM TKIP
> ath0: mac 5.9 phy 4.3 radio 4.6
> ath0: Use hw queue 1 for WME_AC_BE traffic
> ath0: Use hw queue 0 for WME_AC_BK traffic
> ath0: Use hw queue 2 for WME_AC_VI traffic
> ath0: Use hw queue 3 for WME_AC_VO traffic
> ath0: Use hw queue 8 for CAB traffic
> ath0: Use hw queue 9 for beacons
> Debugging version (ATH)
> ath0: Atheros 5212: mem=3D0x22000000, irq=3D169
> input: PC Speaker
> eth0: Media Link On 100mbps full-duplex=20
> eth0: no IPv6 routers present
> ACPI: AC Adapter [ACAD] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Power Button (CM) [PWRB]
> ACPI: Sleep Button (CM) [SLPB]
> Using specific hotkey driver
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> ACPI: Thermal Zone [THRM] (58 C)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
