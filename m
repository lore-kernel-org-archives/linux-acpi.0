From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] ACPI: call init functions explicitly instead of using initcalls
Date: Thu, 30 Oct 2008 22:51:45 -0600
Message-ID: <200810302251.46443.bjorn.helgaas@hp.com>
References: <200810291525.58218.bjorn.helgaas@hp.com> <200810300913.32986.bjorn.helgaas@hp.com> <1225424543.3993.44.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:9779 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYJaEw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 00:52:27 -0400
In-Reply-To: <1225424543.3993.44.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thursday 30 October 2008 9:42:23 pm Zhao Yakui wrote:
> On Thu, 2008-10-30 at 23:13 +0800, Bjorn Helgaas wrote:
> > On Wednesday 29 October 2008 08:01:43 pm Zhao Yakui wrote:
> > > In your patch the module link order is also changed. In current k=
ernel
> > > some module parameters using the same ACPI prefix are defined in =
the
> > > different files. For example: acpi.debug_layer && acpi.debug_leve=
l are
> > > defined in debug.c. The acpi.acpica_version is defined in system.=
c.
> > >
> > > If they are separated by files with module parameter, there exist=
s the
> > > following warning message.
> > >
> > >      >WARNING: at /linux-2.6/fs/sysfs/dir.c:463
> > > >
> > > >sysfs_add_one+0x33/0x39()
> > > >sysfs: duplicate filename 'acpi' can not be created
> >
> > I did change the link order because acpi/debug.c and acpi/system.c
> > are not drivers in the same sense as things like ec.c, pci_root.c,
> > etc.  debug.c and system.c are really optional parts of ACPI itself=
,
> > not things that can be loaded in after the fact like drivers can.
> >
> > It would certainly be bad if the /sys/module/acpi directory creatio=
n
> > relies on module link order.  I don't know enough about sysfs to
> > intuit where this problem occurs, and I don't see it in my testing
> > (see dmesg below).  Can you give any more information about this?
>
>    For example: In my test the acpi.power_nocheck is defined in power=
=2Ec.
> The acpi.debug_level & acpi.debug_layer are defined in debug.c. And t=
hey
> are split by the thermal/processor module.(The thermal/processor modu=
le
> is also compiled as built-in kernel). So the following warning messag=
e
>
> will be reported in the boot phase:
>    >sysfs: duplicate filename 'acpi' can not be created
>
>     Why this happen is caused by the generic param code related with
> sysfs. (param_sysfs_init).
>
>    Please try your patch on the latest kernel(2.6.28-rc2) and enable =
the
> CONIF_ACPI_DEBUG in kernel configuration.(Of course the processor and
> thermal should also be compiled as built-in kernel).
>    Then you can see the warning message.

I did try this (see below), but I still don't see the warning, so
I don't completely understand this yet (maybe seeing your complete
dmesg log would help), but I think you're saying the warning is related
to the fact that I changed the link order from:

  processor.o
  thermal.o
  power.o
  debug.o

to:

  debug.o
  processor.o
  thermal.o
  power.o

As far as I can tell, CONFIG_ACPI_POWER is useless, since it
is always set the same as CONFIG_ACPI.  And interfaces from
acpi/power.c, such as acpi_power_transition(), are used
unconditionally from acpi/bus.c.  Given that, I think we
should remove the CONFIG_ACPI_POWER Kconfig option and change
the makefile to look like this:

  obj-y                           +=3D bus.o scan.o power.o
  obj-y                           +=3D glue.o
  obj-$(CONFIG_ACPI_DEBUG)        +=3D debug.o

That would put power.o and debug.o back together and maybe
avoid whatever problem was caused by sticking processor.o
and thermal.o in the middle.

IMHO, the end of the makefile (ec.o and everything after it)
should be drivers that are optional and not required by the
core.  The pci drivers (pci_root, pci_link, etc) are currently
not optional, but I think they should be.

Sorry I don't have time to try this and post updated patches
now; I'll try to do that tomorrow.

Bjorn


$ grep ACPI .config
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
# CONFIG_ACPI_PROCFS is not set
CONFIG_ACPI_PROCFS_POWER=3Dy
CONFIG_ACPI_SYSFS_POWER=3Dy
CONFIG_ACPI_PROC_EVENT=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_WMI is not set
CONFIG_ACPI_ASUS=3Dm
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=3D""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_DEBUG=3Dy
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_EC=3Dy
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dy
# CONFIG_ACPI_SBS is not set
CONFIG_PNPACPI=3Dy
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_BLK_DEV_IDEACPI is not set


BIOS EBDA/lowmem at: 0009f400/0009f000
Linux version 2.6.28-rc2-00193-gdfb259d (bjorn@bob) (gcc version 4.3.1 =
(Debian=20
4.3.1-9) ) #1 SMP Thu Oct 30 21:51:08 MDT 2008
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fffa000 (usable)
 BIOS-e820: 000000007fffa000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Early serial console at I/O port 0x3f8 (options '115200')
console [uart0] enabled
DMI 2.3 present.
last_pfn =3D 0x7fffa max_arch_pfn =3D 0x100000
ACPI: RSDP 000F4F70, 0014 (r0 COMPAQ)
ACPI: RSDT 7FFFA000, 0030 (r1 COMPAQ P31             2   =D2=04     162=
E)
ACPI: FACP 7FFFA040, 0074 (r1 COMPAQ P31             2   =D2=04     162=
E)
ACPI: DSDT 7FFFA240, 318A (r1 COMPAQ     DSDT        1 MSFT  100000B)
ACPI: FACS 7FFFA0C0, 0040
ACPI: APIC 7FFFA100, 00AC (r1 COMPAQ 00000083        2             0)
ACPI: SPCR 7FFFA1C0, 0050 (r1 COMPAQ SPCRRBSU        1   =D2=04     162=
E)
1159MB HIGHMEM available.
887MB LOWMEM available.
  mapped low ram: 0 - 377fe000
  low ram: 00000000 - 377fe000
  bootmap 00009000 - 0000ff00
(8 early reservations) =3D=3D> bootmem [0000000000 - 00377fe000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 0=
000001000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [0000001000 - 0=
000002000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> [0000006000 - 0=
000007000]
  #3 [0000200000 - 00007ae9d0]    TEXT DATA BSS =3D=3D> [0000200000 - 0=
0007ae9d0]
  #4 [00007af000 - 00007b2000]    INIT_PG_TABLE =3D=3D> [00007af000 - 0=
0007b2000]
  #5 [000009f000 - 0000100000]    BIOS reserved =3D=3D> [000009f000 - 0=
000100000]
  #6 [0000007000 - 0000009000]          PGTABLE =3D=3D> [0000007000 - 0=
000009000]
  #7 [0000009000 - 0000010000]          BOOTMAP =3D=3D> [0000009000 - 0=
000010000]
found SMP MP-table at [c00f4fd0] 000f4fd0
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x000377fe
  HighMem  0x000377fe -> 0x0007fffa
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x0007fffa
ACPI: PM-Timer IO Port: 0x920
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
ACPI: IOAPIC (id[0x05] address[0xfec03000] gsi_base[48])
IOAPIC[3]: apic_id 5, version 17, address 0xfec03000, GSI 48-63
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 4 I/O APICs
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
PERCPU: Allocating 32768 bytes of per cpu data
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 52=
0089
Kernel command line: console=3Duart,io,0x3f8 root=3D/dev/cciss!c0d0p1=20
BOOT_IMAGE=3DbzImage=20
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
=46ast TSC calibration using PIT
Detected 2799.190 MHz processor.
Console: colour VGA+ 80x25
console handover: boot [uart0] -> real [ttyS0]
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2072692k/2097128k available (3842k kernel code, 23216k reserved=
, 1406k=20
data, 296k init, 1187824k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff85000 - 0xfffff000   ( 488 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
      .init : 0xc0728000 - 0xc0772000   ( 296 kB)
      .data : 0xc05c09e7 - 0xc07203f4   (1406 kB)
      .text : 0xc0200000 - 0xc05c09e7   (3842 kB)
Checking if this processor honours the WP bit even in supervisor mode..=
=2EOk.
Calibrating delay loop (skipped), value calculated using timer frequenc=
y..=20
5598.38 BogoMIPS (lpj=3D11196760)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Checking 'hlt' instruction... OK.
ACPI: Core revision 20080926
Parsing all Control Methods:
Table [DSDT](id 0001) - 530 Objects with 38 Devices 108 Methods 11 Regi=
ons
 tbxface-0596 [00] tb_load_namespace     : ACPI Tables successfully acq=
uired
evxfevnt-0091 [00] enable                : Transition to ACPI mode succ=
essful
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 1 APIC 0x6 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5598.78 BogoMIPS=20
(lpj=3D11197568)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2 APIC 0x1 ip 0x6000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5598.79 BogoMIPS=20
(lpj=3D11197580)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3 APIC 0x7 ip 0x6000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5598.82 BogoMIPS=20
(lpj=3D11197658)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (22394.78 BogoMIPS).
net_namespace: 432 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=3D6
PCI: Using configuration type 1 for base access
PCI: HP ProLiant DL360 detected, enabling pci=3Dbfsort.
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
evgpeblk-1197 [00] ev_gpe_initialize     : There are no GPE blocks defi=
ned in=20
the FADT
Completing Region/Field/Buffer/Package=20
initialization:........................................................=
=2E....................................................................=
=2E....................................................................=
=2E........................
Initialized 8/11 Regions 149/149 Fields 57/57 Buffers 5/5 Packages (539=
 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods=
:
Executed 0 _INI methods requiring 0 _STA executions (examined 49 object=
s)
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:05.2: PME# supported from D0 D3hot D3cold
pci 0000:00:05.2: PME# disabled
ACPI: PCI Root Bridge [PCI1] (0000:01)
pci 0000:01:02.0: PME# supported from D3hot D3cold
pci 0000:01:02.0: PME# disabled
ACPI: PCI Root Bridge [PCI2] (0000:04)
pci 0000:04:02.0: PME# supported from D3hot D3cold
pci 0000:04:02.0: PME# disabled
ACPI: PCI Interrupt Link [IUSB] (IRQs 4 5 7 *10 11 15)
ACPI: PCI Interrupt Link [IN16] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN17] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN18] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN19] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN20] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN21] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN22] (IRQs 4 5 *7 10 11 15)
ACPI: PCI Interrupt Link [IN23] (IRQs 4 *5 7 10 11 15)
ACPI: PCI Interrupt Link [IN24] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN25] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN26] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN27] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN28] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN29] (IRQs 4 5 7 10 11 *15)
ACPI: PCI Interrupt Link [IN30] (IRQs 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [IN31] (IRQs 4 5 7 10 11 15) *3
ACPI: PCI Interrupt Link [IN32] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN33] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN34] (IRQs 4 5 7 10 11 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
NET: Registered protocol family 23
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: ioport range 0xf50-0xf58 has been reserved
system 00:01: ioport range 0x408-0x40f has been reserved
system 00:01: ioport range 0x900-0x903 has been reserved
system 00:01: ioport range 0x910-0x911 has been reserved
system 00:01: ioport range 0x920-0x923 has been reserved
system 00:01: ioport range 0x930-0x937 has been reserved
system 00:01: ioport range 0x940-0x947 has been reserved
system 00:01: ioport range 0x950-0x957 has been reserved
system 00:01: ioport range 0xc06-0xc08 has been reserved
system 00:01: ioport range 0xc14-0xc14 has been reserved
system 00:01: ioport range 0xc49-0xc4a has been reserved
system 00:01: ioport range 0xc50-0xc52 has been reserved
system 00:01: ioport range 0xc6c-0xc6f has been reserved
system 00:01: ioport range 0x230-0x233 has been reserved
system 00:01: ioport range 0x260-0x267 has been reserved
system 00:01: ioport range 0x4d0-0x4d1 has been reserved
system 00:01: ioport range 0x700-0x70f has been reserved
system 00:01: ioport range 0x800-0x81f has been reserved
system 00:01: ioport range 0xc80-0xc83 has been reserved
system 00:01: ioport range 0xcd4-0xcd7 has been reserved
system 00:01: ioport range 0xcf9-0xcf9 could not be reserved
bus: 00 index 0 io port: [0x00-0xffff]
bus: 00 index 1 mmio: [0x000000-0xffffffff]
bus: 01 index 0 io port: [0x00-0xffff]
bus: 01 index 1 mmio: [0x000000-0xffffffff]
bus: 04 index 0 io port: [0x00-0xffff]
bus: 04 index 1 mmio: [0x000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
platform rtc_cmos: registered platform RTC device (no PNP device found)
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.29 [Flags: R/O].
msgmni has been set to 1729
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
processor ACPI0007:00: registered as cooling_device0
processor ACPI0007:01: registered as cooling_device1
processor ACPI0007:06: registered as cooling_device2
processor ACPI0007:07: registered as cooling_device3
[ACPI Debug]  String [0x0B] "_TMP Method"
[ACPI Debug]  String [0x0B] "_CRT Method"
[ACPI Debug]  String [0x0B] "_PSV Method"
thermal LNXTHERM:01: registered as thermal_zone0
[ACPI Debug]  String [0x0B] "_TMP Method"
[ACPI Debug]  String [0x0B] "_TMP Method"
ACPI: Thermal Zone [THM0] (8 C)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a National Semiconductor PC87306
loop: module loaded
HP CISS Driver (v 3.6.20)
cciss 0000:00:04.0: PCI INT A -> GSI 31 (level, low) -> IRQ 31
cciss0: <0xb178> at PCI 0000:00:04.0 IRQ 31 using DAC
      blocks=3D 35553120 block_size=3D 512
      heads=3D255, sectors=3D32, cylinders=3D4357

      blocks=3D 35553120 block_size=3D 512
      heads=3D255, sectors=3D32, cylinders=3D4357

 cciss/c0d0: p1 p2
Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
tg3.c:v3.94 (August 14, 2008)
tg3 0000:01:02.0: PCI INT A -> GSI 30 (level, low) -> IRQ 30
eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit)=20
10/100/1000Base-T Ethernet 00:0e:7f:b4:69:94
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[769c4000] dma_mask[64-bit]
tg3 0000:04:02.0: PCI INT A -> GSI 29 (level, low) -> IRQ 29
eth1: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit)=20
10/100/1000Base-T Ethernet 00:0e:7f:b4:89:9f
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[769c4000] dma_mask[64-bit]
console [netcon0] enabled
netconsole: network logging started
Uniform Multi-Platform E-IDE driver
serverworks 0000:00:0f.1: IDE controller (0x1166:0x0212 rev 0x93)
serverworks 0000:00:0f.1: not 100% native mode: will probe irqs later
serverworks 0000:00:0f.1: simplex device: DMA forced
    ide0: BM-DMA at 0x2000-0x2007
serverworks 0000:00:0f.1: simplex device: DMA forced
    ide1: BM-DMA at 0x2008-0x200f
hda: CRN-8245B, ATAPI CD/DVD-ROM drive
hda: MWDMA2 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide_generic: please use "probe_mask=3D0x3f" module parameter for probin=
g all=20
legacy ISA IDE ports
ide-gd driver 1.18
ide-cd driver 5.00
ide-cd: hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt Link [IUSB] enabled at IRQ 10
ohci_hcd 0000:00:0f.2: PCI INT A -> Link[IUSB] -> GSI 10 (level, low) -=
> IRQ=20
10
ohci_hcd 0000:00:0f.2: OHCI Host Controller
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: irq 10, io mem 0xf5e70000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
cpuidle: using governor ladder
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
ALSA device list:
  No soundcards found.
IPv4 over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI No-Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 296k freed
Write protecting the kernel text: 3844k
Write protecting the kernel read-only data: 1112k
modprobe: FATAL: Could not=20
load /lib/modules/2.6.28-rc2-00193-gdfb259d/modules.dep: No such file o=
r=20
directory

INIT: version 2.86 booting
mount: wrong fs type, bad option, bad superblock on tmpfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

touch: cannot touch `/lib/init/rw/.ramfs': Read-only file system
mkdir: cannot create directory `/lib/init/rw/sendsigs.omit.d/': File ex=
ists
mount: wrong fs type, bad option, bad superblock on tmpfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

Setting the system clock.
System Clock set to: Fri Oct 31 03:16:19 UTC 2008.
Activating swap:swapon on /dev/cciss/c0d0p2
Adding 2097136k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1=20
across:2097136k
=2E
Will now check root file system:fsck 1.41.1 (01-Sep-2008)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/cciss/c0d0p1=20
/dev/cciss/c0d0p1: clean, 341153/1954560 files, 2425760/3906596 blocks
=2E
EXT3 FS on cciss/c0d0p1, internal journal
Setting the system clock.
System Clock set to: Fri Oct 31 03:16:20 UTC 2008.
Cleaning up ifupdown....
Loading kernel module tg3.
=46ATAL: Could not load /lib/modules/2.6.28-rc2-00193-gdfb259d/modules.=
dep: No=20
such file or directory
=46ATAL: Could not load /lib/modules/2.6.28-rc2-00193-gdfb259d/modules.=
dep: No=20
such file or directory
Creating device-mapper devices...done.
Loading device-mapper support.
Will now check all file systems.
fsck 1.41.1 (01-Sep-2008)
Checking all file systems.
Done checking file systems. A log is being saved in /var/log/fsck/check=
fs if=20
that location is writable..
Setting kernel variables (/etc/sysctl.conf)...done.
Will now mount local filesystems:.
Will now activate swapfile swap:done.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Checking minimum space in /tmp...done.
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking....
/etc/network/options still exists and it will be IGNORED! Read README.D=
ebian=20
of netbase. =1B[33m(warning).=1B[39;49m
Configuring network interfaces...Internet Systems Consortium DHCP Clien=
t=20
V3.1.1
Copyright 2004-2008 Internet Systems Consortium.
All rights reserved.
=46or info, please visit http://www.isc.org/sw/dhcp/

Listening on LPF/eth1/00:0e:7f:b4:89:9f
Sending on   LPF/eth1/00:0e:7f:b4:89:9f
Sending on   Socket/fallback
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 4
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 14
DHCPOFFER from 10.0.0.1
DHCPREQUEST on eth1 to 255.255.255.255 port 67
DHCPACK from 10.0.0.1
bound to 10.36.62.114 -- renewal in 127310 seconds.
modprobe: FATAL: Could not=20
load /lib/modules/2.6.28-rc2-00193-gdfb259d/modules.dep: No such file o=
r=20
directory

modprobe: FATAL: Could not=20
load /lib/modules/2.6.28-rc2-00193-gdfb259d/modules.dep: No such file o=
r=20
directory

done.
Loading the saved-state of the serial devices...=20
/dev/ttyS0 at 0x03f8 (irq =3D 4) is a 16550A
Setting console screen modes and fonts.
Initializing random number generator...done.
Optimizing hardware...done.
Recovering nvi editor sessions...none found.
Setting up X server socket directory /tmp/.X11-unix....
Setting up ICE socket directory /tmp/.ICE-unix....
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon....
Starting kernel log daemon....
Starting system message bus: dbus.
Starting OpenBSD Secure Shell server: sshd.
Starting internet superserver: inetd.
Starting Postfix Mail Transport Agent: postfix.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Running local boot scripts (/etc/rc.local).

Debian GNU/Linux lenny/sid dl360 ttyS0

dl360 login: root
Password:=20
dl360:~# dmesg | grep duplicate
dl360:~# ls /sys/module/acpi/parameters/
acpica_version	debug_level	   trace_debug_level  trace_state
debug_layer	trace_debug_layer  trace_method_name
dl360:~# ls /sys/module/thermal/parameters/
act  crt  psv  tzp
dl360:~# ls /sys/module/processor/parameters/
latency_factor
dl360:~#=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
