From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: git-acpi.patch failures
Date: Wed, 27 Jul 2005 19:55:00 -0700
Message-ID: <20050727195500.56bb9cde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


For a while now (days, at least) I've been getting a stream of ACPI
method execution failures due to the tree which I pull from
master.kernel.org:/pub/scm/linux/kernel/git/lenb/to-akpm.git

This doesn't happen with current -linus.

It's a fairly vanilla x86 PC which Intel is loaning me.



Linux version 2.6.13-rc3 (akpm@bix) (gcc version 2.95.3 20010315 (release)) #145 SMP Wed Jul 27 19:50:32 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 65472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61376 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D850MV MV85010A 0x20021111 MSFT 0x00001011) @ 0x0fff0000
ACPI: FADT (v001 D850MV MV85010A 0x20021111 MSFT 0x00001011) @ 0x0fff1000
ACPI: MADT (v001 D850MV MV85010A 0x20021111 MSFT 0x00001011) @ 0x0ffe3954
ACPI: DSDT (v001 D850MV MV85010A 0x00000010 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=d ro root=302 BOOT_FILE=/boot/bzImage-2.6.13-rc3 profile=1 log_buf_len=128k gdb gdbbaud=115200 gdbttyS=0 nmi_watchdog=1 console=ttyS0
kernel profiling enabled (shift: 1)
log_buf_len: 131072
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2808.746 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 246708k/261888k available (3203k kernel code, 14664k reserved, 1458k data, 308k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5625.23 BogoMIPS (lpj=11250468)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module registered.
Failure registering Root Plug  module with primary security module.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium 4 (Northwood) stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5617.15 BogoMIPS (lpj=11234304)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel Pentium 4 (Northwood) stepping 07
Total of 2 processors activated (11242.38 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 265k freed
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050708
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC0._S3D] (Node cff9c160), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC1._S3D] (Node cff9c140), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.PCI1.NEC2._S3D] (Node cff9c120), AE_NULL_OBJECT
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
    ACPI-0171: *** Error: Method execution failed [\_SB_.PCI0.USB2._S3D] (Node cff9c180), AE_NULL_OBJECT
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc900000-fe9fffff
  PREFETCH window: e4500000-f46fffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fea00000-feafffff
  PREFETCH window: f4700000-f47fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: 00:01: ioport range 0x400-0x47f could not be reserved
pnp: 00:01: ioport range 0x500-0x53f has been reserved
pnp: 00:01: ioport range 0x800-0x87f has been reserved
pnp: match found with the PnP device '00:0d' and the driver 'system'
audit: initializing netlink socket (disabled)
audit(1122493926.120:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
SELinux:  Registering netfilter hooks
seclvl: seclvl_init: seclvl: Failure registering with the kernel.
selinux_register_security:  There is already a secondary security module registered.
seclvl: seclvl_init: seclvl: Failure registering with primary security module.
seclvl: Error during initialization: rc = [-22]
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
rivafb: nVidia device/chipset 10DE0171
rivafb: Detected CRTC controller 0 being used
rivafb: setting virtual Y resolution to 104857
rivafb: PCI nVidia NV17 framebuffer ver 0.9.5b (64MB @ 0xE8000000)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i850 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipsets
intelfb: Version 0.9.2
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:07' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:06' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:0a' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4000K size 1024 blocksize
loop: loaded (max 8 devices)
v2.3 : Micro Memory(tm) PCI memory board block driver
MM: desc_per_page = 128
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0xfeafb000, irq 17, MAC addr 00:07:E9:C7:E3:1E
HDLC support module revision 1.18
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 17 (level, low) -> IRQ 18
sym0: <895> rev 0x2 at pci 0000:02:0c.0 irq 18
sym0: Symbios NVRAM, ID 7, Fast-40, SE, parity checking
sym0: SCSI BUS has been reset.
sym0: SCSI BUS mode change from SE to SE.
scsi0 : sym-2.2.1
sym0: SCSI BUS has been reset.
  Vendor: SEAGATE   Model: ST336737LW        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:0: tagged command queuing enabled, command queue depth 64.
 target0:0:0: Beginning Domain Validation
 target0:0:0: asynchronous.
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target0:0:0: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:2: Beginning Domain Validation
 target0:0:2: asynchronous.
 target0:0:2: wide asynchronous.
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:2: Ending Domain Validation
SCSI device sda: 72176566 512-byte hdwr sectors (36954 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 72176566 512-byte hdwr sectors (36954 MB)
SCSI device sda: drive cache: write back
 sda: sda1 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 5
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:02:01.2[C] -> GSI 23 (level, low) -> IRQ 19
ehci_hcd 0000:02:01.2: EHCI Host Controller
ehci_hcd 0000:02:01.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:02:01.2: irq 19, io mem 0xfeaff800
ehci_hcd 0000:02:01.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 20
ohci_hcd 0000:02:01.0: OHCI Host Controller
ohci_hcd 0000:02:01.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:02:01.0: irq 20, io mem 0xfeafc000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:01.1[B] -> GSI 18 (level, low) -> IRQ 21
ohci_hcd 0000:02:01.1: OHCI Host Controller
ohci_hcd 0000:02:01.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:02:01.1: irq 21, io mem 0xfeafd000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1f.2: irq 20, io base 0x0000ef80
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 2 port USB adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 4 port USB adapter
usbcore: registered new driver digi_acceleport
drivers/usb/serial/digi_acceleport.c: v1.80.1.2:Digi AccelePort USB-2/USB-4 Serial Converter driver
mice: PS/2 mouse device common for all mice
I2O subsystem v1.288
i2o: max drivers = 8
I2O Configuration OSM v1.248
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
md: linear personality registered as nr 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3522.000 MB/sec
raid5: using function: pIII_sse (3522.000 MB/sec)
raid6: int32x1    676 MB/s
raid6: int32x2    945 MB/s
raid6: int32x4    885 MB/s
raid6: int32x8    769 MB/s
raid6: mmxx1     2313 MB/s
raid6: mmxx2     2933 MB/s
raid6: sse1x1    1435 MB/s
raid6: sse1x2    1950 MB/s
raid6: sse2x1    2506 MB/s
raid6: sse2x2    3035 MB/s
raid6: using algorithm sse2x2 (3035 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
EISA: Probing bus 0 at eisa.0
Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29 07:31:02 2005 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 44550 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801BA-ICH2 with AD1981B at 0xe800, irq 18
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
IPVS: Registered protocols (TCP)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
IPVS: ipvs loaded.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Testing NMI watchdog ... OK.
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 4096000
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0, recovered transactions 313171 to 313184
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 1040 and revoked 0/93 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 308k freed
Using generic hotkey driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PBTN]
ibm_acpi: Using generic hotkey driver
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
toshiba_acpi: Using generic hotkey driver
EXT3 FS on hda2, internal journal
Adding 1020116k swap on /dev/hda3.  Priority:-1 extents:1
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
