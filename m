From: "Yon Mercury" <swirlee-HptHbbG/L9RWk0Htik3J/w@public.gmane.org>
Subject: Thermal zone reporting 0C
Date: Sat, 25 Dec 2004 13:00:07 -0700
Message-ID: <20041225200007.M60532@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Dear ACPI listers,

I'm seeking a bit of help with ACPI configuration on my new laptop, an
Averatec 3250. I am running a Debian-based distro with stock kernel 2.6.10.
After installing acpid, things are still working, but I notice something strange--

>From my kern.log:
Dec 25 16:48:00 mewkuwy kernel: ACPI: Thermal Zone [THRM] (0 C)

Doing a 'cat /proc/acpi/thermal_zone/THRM/temperature' gives:
temperature:             0 C

Always the temperature is reported as 0. The fan slows down when acpid is
started but never changes. Could this cause an overheating problem? Perhaps
this laptop's ACPI is not fully supported for Linux?

Below is the full listing from my kern.log. Help tips would be graciously
received.

Thank you,
JP Mercury

Dec 25 16:47:59 mewkuwy kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Dec 25 16:47:59 mewkuwy kernel: Inspecting /boot/System.map-2.6.10
Dec 25 16:47:59 mewkuwy kernel: Loaded 26594 symbols from /boot/System.map-2.6.10.
Dec 25 16:47:59 mewkuwy kernel: Symbols match kernel version 2.6.10.
Dec 25 16:47:59 mewkuwy kernel: No module symbols loaded - kernel modules not
enabled. 
Dec 25 16:47:59 mewkuwy kernel: Linux version 2.6.10 (root@mewkuwy) (gcc
version 3.3.4 (Debian 1:3.3.4-2)) #2 Sat Dec 25 05:54:53 MST 2004
Dec 25 16:47:59 mewkuwy kernel: BIOS-provided physical RAM map:
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 00000000000d0000 -
00000000000d6000 (reserved)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 0000000000100000 -
000000001dff0000 (usable)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 000000001dff0000 -
000000001dff8000 (ACPI data)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 000000001dff8000 -
000000001e000000 (ACPI NVS)
Dec 25 16:47:59 mewkuwy kernel:  BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Dec 25 16:47:59 mewkuwy kernel: 0MB HIGHMEM available.
Dec 25 16:47:59 mewkuwy kernel: 479MB LOWMEM available.
Dec 25 16:47:59 mewkuwy kernel: On node 0 totalpages: 122864
Dec 25 16:47:59 mewkuwy kernel:   DMA zone: 4096 pages, LIFO batch:1
Dec 25 16:47:59 mewkuwy kernel:   Normal zone: 118768 pages, LIFO batch:16
Dec 25 16:47:59 mewkuwy kernel:   HighMem zone: 0 pages, LIFO batch:1
Dec 25 16:47:59 mewkuwy kernel: DMI 2.3 present.
Dec 25 16:47:59 mewkuwy kernel: ACPI: RSDP (v000 AMI                         
         ) @ 0x000fa2d0
Dec 25 16:47:59 mewkuwy kernel: ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010
MSFT 0x00000097) @ 0x1dff0000
Dec 25 16:47:59 mewkuwy kernel: ACPI: FADT (v001 AMIINT VIA_K7   0x00000011
MSFT 0x00000097) @ 0x1dff0030
Dec 25 16:47:59 mewkuwy kernel: ACPI: DSDT (v001    VIA   VIA_K7 0x00001000
INTL 0x02002024) @ 0x00000000
Dec 25 16:47:59 mewkuwy kernel: ACPI: PM-Timer IO Port: 0x808
Dec 25 16:47:59 mewkuwy kernel: Built 1 zonelists
Dec 25 16:47:59 mewkuwy kernel: Kernel command line: root=/dev/hda2 ro 
Dec 25 16:47:59 mewkuwy kernel: Local APIC disabled by BIOS -- you can enable
it with "lapic"
Dec 25 16:47:59 mewkuwy kernel: mapped APIC to ffffd000 (013c5000)
Dec 25 16:47:59 mewkuwy kernel: Initializing CPU#0
Dec 25 16:47:59 mewkuwy kernel: PID hash table entries: 2048 (order: 11, 32768
bytes)
Dec 25 16:47:59 mewkuwy kernel: Detected 1659.162 MHz processor.
Dec 25 16:47:59 mewkuwy kernel: Using pmtmr for high-res timesource
Dec 25 16:47:59 mewkuwy kernel: Console: colour VGA+ 80x25
Dec 25 16:47:59 mewkuwy kernel: Dentry cache hash table entries: 65536 (order:
6, 262144 bytes)
Dec 25 16:47:59 mewkuwy kernel: Inode-cache hash table entries: 32768 (order:
5, 131072 bytes)
Dec 25 16:47:59 mewkuwy kernel: Memory: 479328k/491456k available (1605k
kernel code, 11544k reserved, 696k data, 168k init, 0k highmem)
Dec 25 16:47:59 mewkuwy kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Dec 25 16:47:59 mewkuwy kernel: Calibrating delay loop... 3276.80 BogoMIPS
(lpj=1638400)
Dec 25 16:47:59 mewkuwy kernel: Security Framework v1.0.0 initialized
Dec 25 16:47:59 mewkuwy kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Dec 25 16:47:59 mewkuwy kernel: CPU: After generic identify, caps: 0383f9ff
c1cbf9ff 00000000 00000000
Dec 25 16:47:59 mewkuwy kernel: CPU: After vendor identify, caps:  0383f9ff
c1cbf9ff 00000000 00000000
Dec 25 16:47:59 mewkuwy kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
Dec 25 16:47:59 mewkuwy kernel: CPU: L2 Cache: 512K (64 bytes/line)
Dec 25 16:47:59 mewkuwy kernel: CPU: After all inits, caps:        0383f9ff
c1cbf9ff 00000000 00000020
Dec 25 16:47:59 mewkuwy kernel: Intel machine check architecture supported.
Dec 25 16:47:59 mewkuwy kernel: Intel machine check reporting enabled on CPU#0.
Dec 25 16:47:59 mewkuwy kernel: CPU: AMD mobile AMD Athlon(tm) XP-M (LV) 2200+
stepping 00
Dec 25 16:47:59 mewkuwy kernel: Enabling fast FPU save and restore... done.
Dec 25 16:47:59 mewkuwy kernel: Enabling unmasked SIMD FPU exception
support... done.
Dec 25 16:47:59 mewkuwy kernel: Checking 'hlt' instruction... OK.
Dec 25 16:47:59 mewkuwy kernel: ACPI: setting ELCR to 0200 (from 0c00)
Dec 25 16:47:59 mewkuwy kernel: checking if image is initramfs...it isn't (bad
gzip magic numbers); looks like an initrd
Dec 25 16:47:59 mewkuwy kernel: Freeing initrd memory: 4564k freed
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 16
Dec 25 16:47:59 mewkuwy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb51,
last bus=1
Dec 25 16:47:59 mewkuwy kernel: PCI: Using configuration type 1
Dec 25 16:47:59 mewkuwy kernel: mtrr: v2.0 (20020519)
Dec 25 16:47:59 mewkuwy kernel: ACPI: Subsystem revision 20041105
Dec 25 16:47:59 mewkuwy kernel: ACPI: Interpreter enabled
Dec 25 16:47:59 mewkuwy kernel: ACPI: Using PIC for interrupt routing
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec 25 16:47:59 mewkuwy kernel: PCI: Probing PCI hardware (bus 00)
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Dec 25 16:47:59 mewkuwy kernel: ACPI: Embedded Controller [ECD] (gpe 4)
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.AGP_._PRT]
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 4 *11 14 15)
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 9 14
15) *0, disabled.
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *10 12)
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 6 7) *0,
disabled.
Dec 25 16:47:59 mewkuwy kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 25 16:47:59 mewkuwy kernel: pnp: PnP ACPI init
Dec 25 16:47:59 mewkuwy kernel: pnp: PnP ACPI: found 8 devices
Dec 25 16:47:59 mewkuwy kernel: PnPBIOS: Disabled by ACPI
Dec 25 16:47:59 mewkuwy kernel: Linux Kernel Card Services
Dec 25 16:47:59 mewkuwy kernel:   options:  [pci] [cardbus] [pm]
Dec 25 16:47:59 mewkuwy kernel: PCI: Using ACPI for IRQ routing
Dec 25 16:47:59 mewkuwy kernel: ** PCI interrupts are no longer routed
automatically.  If this
Dec 25 16:47:59 mewkuwy kernel: ** causes a device to stop working, it is
probably because the
Dec 25 16:47:59 mewkuwy kernel: ** driver failed to call pci_enable_device().
 As a temporary
Dec 25 16:47:59 mewkuwy kernel: ** workaround, the "pci=routeirq" argument
restores the old
Dec 25 16:47:59 mewkuwy kernel: ** behavior.  If this argument makes the
device work again,
Dec 25 16:47:59 mewkuwy kernel: ** please email the output of "lspci" to
bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
Dec 25 16:47:59 mewkuwy kernel: ** so I can fix the driver.
Dec 25 16:47:59 mewkuwy kernel: VFS: Disk quotas dquot_6.5.1
Dec 25 16:47:59 mewkuwy kernel: Dquot-cache hash table entries: 1024 (order 0,
4096 bytes)
Dec 25 16:47:59 mewkuwy kernel: devfs: 2004-01-31 Richard Gooch
(rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Dec 25 16:47:59 mewkuwy kernel: devfs: boot_options: 0x0
Dec 25 16:47:59 mewkuwy kernel: Initializing Cryptographic API
Dec 25 16:47:59 mewkuwy kernel: isapnp: Scanning for PnP cards...
Dec 25 16:47:59 mewkuwy kernel: isapnp: No Plug & Play device found
Dec 25 16:47:59 mewkuwy kernel: i8042.c: Detected active multiplexing
controller, rev 1.1.
Dec 25 16:47:59 mewkuwy kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 25 16:47:59 mewkuwy kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 25 16:47:59 mewkuwy kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 25 16:47:59 mewkuwy kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 25 16:47:59 mewkuwy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 25 16:47:59 mewkuwy kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 48
ports, IRQ sharing enabled
Dec 25 16:47:59 mewkuwy kernel: io scheduler noop registered
Dec 25 16:47:59 mewkuwy kernel: io scheduler anticipatory registered
Dec 25 16:47:59 mewkuwy kernel: io scheduler deadline registered
Dec 25 16:47:59 mewkuwy kernel: io scheduler cfq registered
Dec 25 16:47:59 mewkuwy kernel: RAMDISK driver initialized: 16 RAM disks of
8192K size 1024 blocksize
Dec 25 16:47:59 mewkuwy kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 2
Dec 25 16:47:59 mewkuwy kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Dec 25 16:47:59 mewkuwy kernel: TCP: Hash tables configured (established 32768
bind 65536)
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 8
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 20
Dec 25 16:47:59 mewkuwy kernel: RAMDISK: cramfs filesystem found at block 0
Dec 25 16:47:59 mewkuwy kernel: RAMDISK: Loading 4564KiB [1 disk] into ram
disk...
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone.
Dec 25 16:47:59 mewkuwy kernel: VFS: Mounted root (cramfs filesystem) readonly.
Dec 25 16:47:59 mewkuwy kernel: Freeing unused kernel memory: 168k freed
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 1
Dec 25 16:47:59 mewkuwy kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Dec 25 16:47:59 mewkuwy kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 25 16:47:59 mewkuwy kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
Dec 25 16:47:59 mewkuwy kernel: VP_IDE: chipset revision 6
Dec 25 16:47:59 mewkuwy kernel: VP_IDE: not 100%% native mode: will probe irqs
later
Dec 25 16:47:59 mewkuwy kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
controller on pci0000:00:11.1
Dec 25 16:47:59 mewkuwy kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS
settings: hda:DMA, hdb:pio
Dec 25 16:47:59 mewkuwy kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS
settings: hdc:DMA, hdd:pio
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide0...
Dec 25 16:47:59 mewkuwy kernel: hda: IC25N060ATMR04-0, ATA DISK drive
Dec 25 16:47:59 mewkuwy kernel: elevator: using anticipatory as default io
scheduler
Dec 25 16:47:59 mewkuwy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 25 16:47:59 mewkuwy kernel: hda: max request size: 1024KiB
Dec 25 16:47:59 mewkuwy kernel: hda: 117210240 sectors (60011 MB) w/7884KiB
Cache, CHS=16383/255/63, UDMA(100)
Dec 25 16:47:59 mewkuwy kernel: hda: cache flushes supported
Dec 25 16:47:59 mewkuwy kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide1...
Dec 25 16:47:59 mewkuwy kernel: hdc: QSI CD-RW/DVD-ROM SBW242C, ATAPI
CD/DVD-ROM drive
Dec 25 16:47:59 mewkuwy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide2...
Dec 25 16:47:59 mewkuwy kernel: ide2: Wait for ready failed before probe !
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide3...
Dec 25 16:47:59 mewkuwy kernel: ide3: Wait for ready failed before probe !
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide4...
Dec 25 16:47:59 mewkuwy kernel: ide4: Wait for ready failed before probe !
Dec 25 16:47:59 mewkuwy kernel: Probing IDE interface ide5...
Dec 25 16:47:59 mewkuwy kernel: ide5: Wait for ready failed before probe !
Dec 25 16:47:59 mewkuwy kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Dec 25 16:47:59 mewkuwy kernel: kjournald starting.  Commit interval 5 seconds
Dec 25 16:47:59 mewkuwy kernel: Adding 497972k swap on /dev/hda5.  Priority:-1
extents:1
Dec 25 16:47:59 mewkuwy kernel: EXT3 FS on hda2, internal journal
Dec 25 16:47:59 mewkuwy kernel: Real Time Clock Driver v1.12
Dec 25 16:47:59 mewkuwy kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB
Cache, UDMA(33)
Dec 25 16:47:59 mewkuwy kernel: Uniform CD-ROM driver Revision: 3.20
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Dec 25 16:47:59 mewkuwy kernel: PCI: setting IRQ 10 as level-triggered
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 10
(level, low) -> IRQ 10
Dec 25 16:47:59 mewkuwy kernel: PCI: Setting latency timer of device
0000:00:11.5 to 64
Dec 25 16:47:59 mewkuwy kernel: via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004
Written by Donald Becker
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Dec 25 16:47:59 mewkuwy kernel: PCI: setting IRQ 11 as level-triggered
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11
(level, low) -> IRQ 11
Dec 25 16:47:59 mewkuwy kernel: eth0: VIA Rhine II at 0xd800,
00:40:45:25:66:d3, IRQ 11.
Dec 25 16:47:59 mewkuwy kernel: eth0: MII PHY found at address 1, status
0x786d advertising 05e1 Link 41e1.
Dec 25 16:47:59 mewkuwy kernel: input: PC Speaker
Dec 25 16:47:59 mewkuwy kernel: Synaptics Touchpad, model: 1
Dec 25 16:47:59 mewkuwy kernel:  Firmware: 5.1
Dec 25 16:47:59 mewkuwy kernel:  180 degree mounted touchpad
Dec 25 16:47:59 mewkuwy kernel:  Sensor: 15
Dec 25 16:47:59 mewkuwy kernel:  new absolute packet format
Dec 25 16:47:59 mewkuwy kernel:  Touchpad has extended capability bits
Dec 25 16:47:59 mewkuwy kernel:  -> four buttons
Dec 25 16:47:59 mewkuwy kernel:  -> multifinger detection
Dec 25 16:47:59 mewkuwy kernel:  -> palm detection
Dec 25 16:47:59 mewkuwy kernel: input: SynPS/2 Synaptics TouchPad on
isa0060/serio4
Dec 25 16:47:59 mewkuwy kernel: mice: PS/2 mouse device common for all mice
Dec 25 16:47:59 mewkuwy kernel: ts: Compaq touchscreen protocol output
Dec 25 16:47:59 mewkuwy kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 25 16:47:59 mewkuwy kernel: agpgart: Detected VIA KM400/KM400A chipset
Dec 25 16:47:59 mewkuwy kernel: agpgart: Maximum main memory to use for agp
memory: 409M
Dec 25 16:47:59 mewkuwy kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Dec 25 16:47:59 mewkuwy kernel: cpci_hotplug: CompactPCI Hot Plug Core
version: 0.2
Dec 25 16:47:59 mewkuwy kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Dec 25 16:47:59 mewkuwy kernel: Evaluate _OSC Set fails. Status = 0x0005
Dec 25 16:47:59 mewkuwy kernel: pciehp: add_host_bridge: status 5
Dec 25 16:47:59 mewkuwy kernel: pciehp: Fails to gain control of native hot-plug
Dec 25 16:47:59 mewkuwy kernel: shpchp: shpc_init : shpc_cap_offset == 0
Dec 25 16:47:59 mewkuwy kernel: shpchp: Standard Hot Plug PCI Controller
Driver version: 0.4
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10
(level, low) -> IRQ 10
Dec 25 16:47:59 mewkuwy kernel: Yenta: CardBus bridge found at 0000:00:0a.0
[14ff:c602]
Dec 25 16:47:59 mewkuwy kernel: Yenta O2: res at 0x94/0xD4: 00/ea
Dec 25 16:47:59 mewkuwy kernel: Yenta O2: enabling read prefetch/write burst
Dec 25 16:47:59 mewkuwy kernel: Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Dec 25 16:47:59 mewkuwy kernel: Socket status: 30000007
Dec 25 16:47:59 mewkuwy kernel: usbcore: registered new driver usbfs
Dec 25 16:47:59 mewkuwy kernel: usbcore: registered new driver hub
Dec 25 16:47:59 mewkuwy kernel: USB Universal Host Controller Interface driver
v2.2
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
Dec 25 16:47:59 mewkuwy kernel: PCI: setting IRQ 7 as level-triggered
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 7
(level, low) -> IRQ 7
Dec 25 16:47:59 mewkuwy kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 7
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.0: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.0: irq 7, io base 0xe400
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.0: new USB bus registered,
assigned bus number 1
Dec 25 16:47:59 mewkuwy kernel: hub 1-0:1.0: USB hub found
Dec 25 16:47:59 mewkuwy kernel: hub 1-0:1.0: 2 ports detected
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 7
(level, low) -> IRQ 7
Dec 25 16:47:59 mewkuwy kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 7
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.1: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#2)
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.1: irq 7, io base 0xe800
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.1: new USB bus registered,
assigned bus number 2
Dec 25 16:47:59 mewkuwy kernel: hub 2-0:1.0: USB hub found
Dec 25 16:47:59 mewkuwy kernel: hub 2-0:1.0: 2 ports detected
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 7
(level, low) -> IRQ 7
Dec 25 16:47:59 mewkuwy kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 7
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.2: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#3)
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.2: irq 7, io base 0xec00
Dec 25 16:47:59 mewkuwy kernel: uhci_hcd 0000:00:10.2: new USB bus registered,
assigned bus number 3
Dec 25 16:47:59 mewkuwy kernel: hub 3-0:1.0: USB hub found
Dec 25 16:47:59 mewkuwy kernel: hub 3-0:1.0: 2 ports detected
Dec 25 16:47:59 mewkuwy kernel: ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 7
(level, low) -> IRQ 7
Dec 25 16:47:59 mewkuwy kernel: ehci_hcd 0000:00:10.3: VIA Technologies, Inc.
USB 2.0
Dec 25 16:47:59 mewkuwy kernel: ehci_hcd 0000:00:10.3: irq 7, pci mem 0xdfffdf00
Dec 25 16:47:59 mewkuwy kernel: ehci_hcd 0000:00:10.3: new USB bus registered,
assigned bus number 4
Dec 25 16:47:59 mewkuwy kernel: ehci_hcd 0000:00:10.3: USB 2.0 initialized,
EHCI 1.00, driver 26 Oct 2004
Dec 25 16:47:59 mewkuwy kernel: hub 4-0:1.0: USB hub found
Dec 25 16:47:59 mewkuwy kernel: hub 4-0:1.0: 6 ports detected
Dec 25 16:47:59 mewkuwy kernel: irda_init()
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 23
Dec 25 16:47:59 mewkuwy kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Dec 25 16:47:59 mewkuwy kernel: NET: Registered protocol family 17
Dec 25 16:48:00 mewkuwy kernel: ACPI: Battery Slot [BAT0] (battery present)
Dec 25 16:48:00 mewkuwy kernel: ACPI: AC Adapter [AC] (on-line)
Dec 25 16:48:00 mewkuwy kernel: ACPI: Processor [CPU1] (supports C1 C2 C3)
Dec 25 16:48:00 mewkuwy kernel: ACPI: Power Button (FF) [PWRF]
Dec 25 16:48:00 mewkuwy kernel: ACPI: Sleep Button (CM) [SLPB]
Dec 25 16:48:00 mewkuwy kernel: ACPI: Lid Switch [LIDD]
Dec 25 16:48:00 mewkuwy kernel: ACPI: Thermal Zone [THRM] (0 C)
Dec 25 16:48:02 mewkuwy kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Dec 25 16:48:02 mewkuwy kernel: apm: overridden by ACPI.
Dec 25 16:48:02 mewkuwy kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Dec 25 16:48:02 mewkuwy kernel: apm: disabled on user request.
Dec 25 16:48:02 mewkuwy kernel: NET: Registered protocol family 10
Dec 25 16:48:02 mewkuwy kernel: Disabled Privacy Extensions on device c0313f40(lo)
Dec 25 16:48:02 mewkuwy kernel: IPv6 over IPv4 tunneling driver
Dec 25 16:48:06 mewkuwy kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Dec 25 16:48:06 mewkuwy kernel: apm: disabled on user request.
Dec 25 16:48:07 mewkuwy kernel: mtrr: 0xd8000000,0x2000000 overlaps existing
0xd8000000,0x200000
Dec 25 16:48:13 mewkuwy kernel: eth0: no IPv6 routers present
Dec 25 16:55:57 mewkuwy kernel: SCSI subsystem initialized



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
