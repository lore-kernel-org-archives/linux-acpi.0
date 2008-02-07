From: Sebastian Smolorz <sesmo@gmx.net>
Subject: ACPI fails on Panasonic Toughbook CF-52
Date: Thu, 7 Feb 2008 23:41:16 +0100
Message-ID: <200802072341.16523.sesmo@gmx.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mk4qHKn+cmp3HsB"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757874AbYBGWnl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 17:43:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_Mk4qHKn+cmp3HsB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am not able to start the kernel on a Panasonic Toughbook CF-52 successfully 
with ACPI enabled. Only acpi=off or acpi=ht works. ACPI also fails with the 
latest linux-acpi-2.6 git checkout from today. The attached file 
failed_boot.txt shows the kernel log. After the last line the boot process 
does not proceed.

Interestingly, I managed to boot the system twice a few days ago. The 
successful dmesg output shows the attached file dmesg_acpi_osi_test. It shows 
a lot of ACPI errors, though.

Please let me know if you need more information or how I can help to debug 
this problem further.

-- 
Sebastian

--Boundary-00=_Mk4qHKn+cmp3HsB
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg_acpi_osi_test"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_acpi_osi_test"

Linux version 2.6.24 (rts@toughbook) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #1 SMP PREEMPT Wed Feb 6 15:36:59 CET 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6c0000 (usable)
 BIOS-e820: 000000003f6c0000 - 000000003f6d1000 (ACPI NVS)
 BIOS-e820: 000000003f6d1000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00f77a0] 000f77a0
Entering add_active_range(0, 0, 259776) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259776
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   259776
On node 0 totalpages: 259776
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 237 pages used for memmap
  HighMem zone: 30163 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP 000F7770, 0024 (r2 MATBIO)
ACPI: XSDT 3F6C4F19, 007C (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: FACP 3F6CDC60, 00F4 (r3 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: DSDT 3F6C62C1, 791B (r1 MATBIO CF52-1LA  6040000 MSFT  3000000)
ACPI: FACS 3F6D0FC0, 0040
ACPI: HPET 3F6CDD54, 0038 (r1 MATBIO CF52-1LA  6040000 MEI        5A)
ACPI: SLIC 3F6CDD8C, 0176 (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: APIC 3F6CDF02, 0068 (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: MCFG 3F6CDF6A, 003C (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: BOOT 3F6CDFA6, 0028 (r1 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: TCPA 3F6CDFCE, 0032 (r1 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: SSDT 3F6C5FC6, 02FB (r1 MATBIO CF52-1LA     1000 MEI  20050624)
ACPI: SSDT 3F6C5521, 025F (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: SSDT 3F6C547B, 00A6 (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: SSDT 3F6C4F95, 04E6 (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:b8000000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257747
Kernel command line: root=/dev/sda6 vga=0x318 acpi_osi=Linux
ACPI: Added _OSI(Linux)
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1795.531 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024748k/1039104k available (2814k kernel code, 13732k reserved, 1132k data, 216k init, 121600k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9a000 - 0xfffff000   ( 404 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc04e2000 - 0xc0518000   ( 216 kB)
      .data : 0xc03bfaa2 - 0xc04dab18   (1132 kB)
      .text : 0xc0100000 - 0xc03bfaa2   (2814 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 3593.86 BogoMIPS (lpj=1796934)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
using mwait in idle threads.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 825 Objects with 66 Devices 269 Methods 26 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 14 Objects with 3 Devices 8 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 13 Objects with 0 Devices 4 Methods 0 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Booting processor 1/1 ip 4000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3590.94 BogoMIPS (lpj=1795472)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Total of 2 processors activated (7184.81 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
net_namespace: 164 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 5 Wake, Enabled 3 Runtime GPEs in this block
ACPI: EC: Look up EC in DSDT
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI Error (exregion-0164): Could not map memory at F7C1E118000001AC, size 1000 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
ACPI Exception (dswexec-0462): AE_NO_MEMORY, While resolving operands for [LEqual] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.GFX0.ILID] (Node f7c143c0), AE_NO_MEMORY
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG] (Node f7c157e0), AE_NO_MEMORY
Completing Region/Field/Buffer/Package initialization:................................................................
Initialized 20/26 Regions 0/0 Fields 28/29 Buffers 16/24 Packages (872 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:<5>ACPI: BIOS _OSI(Linux) query honored via cmdline
ACPI: DMI System Vendor: Matsushita Electric Industrial Co.,Ltd.
ACPI: DMI Product Name: CF-52CCABVBG
ACPI: DMI Product Version: 001
ACPI: DMI Board Name: CF52-1LA
ACPI: DMI BIOS Vendor: Phoenix Technologies Ltd.
ACPI: DMI BIOS Date: 10/23/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI Error (exregion-0164): Could not map memory at F7C1E11800000310, size 1000 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
ACPI Exception (dswexec-0462): AE_NO_MEMORY, While resolving operands for [And] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.GFX0.INIG] (Node f7c143f0), AE_NO_MEMORY
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_._INI] (Node f7c12228), AE_NO_MEMORY
ACPI Exception (nsinit-0564): AE_NO_MEMORY, during \_SB_._INI._INI execution [20070126]
ACPI: EC: missing OBF confirmation, don't expect it any longer.
ACPI: EC: missing write data confirmation, don't expect it any longer.
.<5>ACPI: BIOS _OSI(Linux) query honored via cmdline
ACPI: DMI System Vendor: Matsushita Electric Industrial Co.,Ltd.
ACPI: DMI Product Name: CF-52CCABVBG
ACPI: DMI Product Version: 001
ACPI: DMI Board Name: CF52-1LA
ACPI: DMI BIOS Vendor: Phoenix Technologies Ltd.
ACPI: DMI BIOS Date: 10/23/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
..
Executed 3 _INI methods requiring 1 _STA executions (examined 75 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI Error (exregion-0164): Could not map memory at F7C1E11800000410, size F0 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.MOU3._STA] (Node f7c17198), AE_NO_MEMORY
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs *9)
ACPI: PCI Interrupt Link [LNKG] (IRQs *9)
ACPI: PCI Interrupt Link [LNKH] (IRQs *9)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
ACPI Error (exregion-0164): Could not map memory at F7C1E11800000410, size F0 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.MOU3._STA] (Node f7c17198), AE_NO_MEMORY
ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.LPCB.MOU3._STA] (Node f7c17198), AE_NO_MEMORY
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 11
hpet0: 3 64-bit timers, 14318180 Hz
Time: tsc clocksource has been installed.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
system 00:01: iomem range 0xcee00-0xcefff has been reserved
system 00:02: ioport range 0x900-0x91f has been reserved
system 00:02: ioport range 0x92c-0x97f has been reserved
system 00:02: ioport range 0xfe00-0xfe01 has been reserved
system 00:02: iomem range 0xff000000-0xffffffff could not be reserved
system 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
system 00:06: ioport range 0x800-0x80f has been reserved
system 00:06: ioport range 0x1000-0x107f has been reserved
system 00:06: ioport range 0x1180-0x11bf has been reserved
system 00:06: iomem range 0xfed1c000-0xfed1ffff could not be reserved
system 00:06: iomem range 0xfed14000-0xfed17fff could not be reserved
system 00:06: iomem range 0xfed18000-0xfed18fff could not be reserved
system 00:06: iomem range 0xfed19000-0xfed19fff could not be reserved
system 00:06: iomem range 0xf8000000-0xfbffffff could not be reserved
system 00:06: iomem range 0xfed20000-0xfed3ffff could not be reserved
system 00:06: iomem range 0xfed45000-0xfed8ffff could not be reserved
system 00:06: iomem range 0xfef00000-0xfef03fff has been reserved
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 2000-3fff
  MEM window: 0xd0000000-0xd3ffffff
  PREFETCH window: 0x00000000d8000000-0x00000000dbffffff
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: 0xfc500000-0xfc5fffff
  PREFETCH window: disabled.
PCI: Bus 15, cardbus bridge: 0000:0e:00.0
  IO window: 0x00004000-0x000040ff
  IO window: 0x00004400-0x000044ff
  PREFETCH window: 0x54000000-0x57ffffff
  MEM window: 0x58000000-0x5bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: 0xfc200000-0xfc4fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:0e:00.0[A] -> GSI 21 (level, low) -> IRQ 21
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x46 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
NTFS driver 2.1.29 [Flags: R/O].
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci 0000:00:02.0: Boot video device
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 6144k, total 7616k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BATA] (battery absent)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
ACPI: SSDT 3F6C5CC1, 023D (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
Parsing all Control Methods:
Table [SSDT](id 00F7) - 6 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT 3F6C5780, 04BC (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
Parsing all Control Methods:
Table [SSDT](id 00F8) - 1 Objects with 0 Devices 1 Methods 0 Regions
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 3F6C5EFE, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
Parsing all Control Methods:
Table [SSDT](id 0006) - 4 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT 3F6C5C3C, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
Parsing all Control Methods:
Table [SSDT](id 0007) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:01 is registered as cooling_device1
Marking TSC unstable due to: possible TSC halt in C2.
Time: hpet clocksource has been installed.
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI Error (exregion-0164): Could not map memory at F7C1E11800000410, size F0 [20070126]
ACPI Exception (evregion-0420): AE_NO_MEMORY, Returned by Handler for [SystemMemory] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.MOU3._STA] (Node f7c17198), AE_NO_MEMORY
ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.LPCB.MOU3._STA] (Node f7c17198), AE_NO_MEMORY
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [TZ00] (47 C)
ACPI: LNXTHERM:02 is registered as thermal_zone1
ACPI: Thermal Zone [TZ01] (49 C)
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.102
agpgart: Detected an Intel 965GM Chipset.
agpgart: Detected 7676K stolen memory.
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i915 1.6.0 20060119 on minor 0
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Clocksource tsc unstable (delta = -362918925 ns)
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:19.0 to 64
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:0b:97:d8:d8:73
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH8M: IDE controller (0x8086:0x2850 rev 0x03) at  PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 19
ICH8M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:PIO
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:PIO, hdd:PIO
Probing IDE interface ide0...
hda: TEAC DV-W28EC, ATAPI CD/DVD-ROM drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/33 mode selected
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide2: I/O resource 0x0-0x7 not free.
ide2: ports already in use, skipping probe
ide3: I/O resource 0x0-0x7 not free.
ide3: ports already in use, skipping probe
ide4: I/O resource 0x0-0x7 not free.
ide4: ports already in use, skipping probe
ide5: I/O resource 0x0-0x7 not free.
ide5: ports already in use, skipping probe
ide6: I/O resource 0x0-0x7 not free.
ide6: ports already in use, skipping probe
ide7: I/O resource 0x0-0x7 not free.
ide7: ports already in use, skipping probe
ide8: I/O resource 0x0-0x7 not free.
ide8: ports already in use, skipping probe
ide9: I/O resource 0x0-0x7 not free.
ide9: ports already in use, skipping probe
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB Cache
Uniform CD-ROM driver Revision: 3.20
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m2048@0xfc825000 port 0xfc825100 irq 19
ata2: SATA max UDMA/133 abar m2048@0xfc825000 port 0xfc825180 irq 19
ata3: SATA max UDMA/133 abar m2048@0xfc825000 port 0xfc825200 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: FUJITSU MHY2080BH, 0043000B, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHY2080B 0043 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
Fusion MPT base driver 3.04.06
Copyright (c) 1999-2007 LSI Corporation
Fusion MPT SPI Host driver 3.04.06
ACPI: PCI Interrupt 0000:0e:00.1[B] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[fc401000-fc4017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ieee1394: raw1394: /dev/raw1394 device initialized
Yenta: CardBus bridge found at 0000:0e:00.0 [10f7:8338]
Yenta: ISA IRQ mask 0x04b8, PCI irq 21
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#0e) from #0f to #12
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xfc200000 - 0xfc4fffff
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfc825800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc825c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[008045890009ac6a]
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x000018a0
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018c0
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
usb 5-2: new low speed USB device using uhci_hcd and address 2
usb 5-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:K101] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:0e:00.2 [1180:0822] (rev 15)
ACPI: PCI Interrupt 0000:0e:00.2[D] -> GSI 23 (level, low) -> IRQ 23
sdhci:slot0: Will use DMA mode even though HW doesn't fully claim to support it.
mmc0: SDHCI at 0xfc401800 irq 23 DMA
input: USB Optical Mouse as /class/input/input4
input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:1d.0-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
Using IPI No-Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 216k freed
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
EXT3 FS on sda6, internal journal
Adding 1357452k swap on /dev/sda5.  Priority:-1 extents:1 across:1357452k
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC02] (Node f7c15d68), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BATA._STA] (Node f7c10c30), AE_TIME
ACPI Exception (battery-0306): AE_ERROR, Evaluating _STA [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI: EC: acpi_ec_wait timeout, status = 255, expect_event = 2
ACPI: EC: input buffer is not empty, aborting transaction
ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for [EmbeddedControl] [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC87] (Node f7c15f48), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC86] (Node f7c15f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.EC01] (Node f7c15d50), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.ECPF] (Node f7c10ac8), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.AC__._PSR] (Node f7c10cc0), AE_TIME
ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state [20070126]

--Boundary-00=_Mk4qHKn+cmp3HsB
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode.output"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.output"

# dmidecode 2.9
SMBIOS 2.4 present.
46 structures occupying 1685 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies Ltd.
	Version: V1.54L21
	Release Date: 10/23/2007
	Address: 0xE50B0
	Runtime Size: 110416 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		3.5"/720 KB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 1.54
	Firmware Revision: 1.80

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Matsushita Electric Industrial Co.,Ltd.
	Product Name: CF-52CCABVBG
	Version: 001
	Serial Number: 7LTCB27246
	UUID: D7A8DB86-686D-53BE-A5C9-C0F2C1C80261
	Wake-up Type: Power Switch
	SKU Number: CF-52CCABVBG
	Family: CF52-1LA

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Matsushita Electric Industrial Co.,Ltd.
	Product Name: CF52-1LA
	Version: 001
	Serial Number: None

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Matsushita Electric Industrial Co.,Ltd.
	Type: Notebook
	Lock: Not Present
	Version: 001
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: IC1
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: FD 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz
	Voltage: 1.2 V
	External Clock: 200 MHz
	Max Speed: 1800 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN15
	Internal Connector Type: None
	External Reference Designator: USB 0
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN16
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN29
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN30
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN10
	Internal Connector Type: None
	External Reference Designator: PC Card
	External Connector Type: 68 Pin Dual Inline
	Port Type: Cardbus

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JK3004
	Internal Connector Type: None
	External Reference Designator: MIC
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JK3003
	Internal Connector Type: None
	External Reference Designator: Headphone
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN4001
	Internal Connector Type: None
	External Reference Designator: SERIAL
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN28
	Internal Connector Type: None
	External Reference Designator: EXT.DISPLAY
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN2001
	Internal Connector Type: None
	External Reference Designator: LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN4201
	Internal Connector Type: None
	External Reference Designator: Modem
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN13
	Internal Connector Type: None
	External Reference Designator: Wireless LAN
	External Connector Type: None
	Port Type: Network Port

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN9
	Internal Connector Type: None
	External Reference Designator: 1394
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN7
	Internal Connector Type: None
	External Reference Designator: Bluetooth
	External Connector Type: None
	Port Type: Network Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN31
	Internal Connector Type: None
	External Reference Designator: Port Replicator
	External Connector Type: Proprietary
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CN4301
	Internal Connector Type: None
	External Reference Designator: SD Card
	External Connector Type: Proprietary
	Port Type: Other

Handle 0x0017, DMI type 9, 13 bytes
System Slot Information
	Designation: PC Card
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Unknown
	Length: Other
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0018, DMI type 126, 13 bytes
Inactive

Handle 0x0019, DMI type 9, 13 bytes
System Slot Information
	Designation: ExpressCard
	Type: x1 PCI Express
	Current Usage: Unknown
	Length: Other
	ID: 0
	Characteristics:
		3.3 V is provided
		Hot-plug devices are supported

Handle 0x001A, DMI type 10, 10 bytes
On Board Device 1 Information
	Type: Video
	Status: Enabled
	Description: Intel 82G965
On Board Device 2 Information
	Type: Sound
	Status: Enabled
	Description: Analog Devices AD1884
On Board Device 3 Information
	Type: Ethernet
	Status: Enabled
	Description: Intel 82566MM

Handle 0x001B, DMI type 11, 5 bytes
OEM Strings
	String 1: 4yv7r4hKAY8MI
	String 2: vxSDCx5UrDEzw
	String 3: iu7ZWjnD3U1L+

Handle 0x001C, DMI type 12, 5 bytes
System Configuration Options
	Option 1: DSN:K41ET7B256SEFUJITSUMHY2080BH    
	Option 2: DSN:M4 70T2953EZ3-CE6 3D500D11      
	Option 3: DSN:                                
	Option 4: SMI:00B2C1

Handle 0x001D, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 2
		en|US|iso8859-1
		ja|JP|unicode-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x001E, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x001F, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: Flash Memory
	Error Correction Type: None
	Maximum Capacity: 1 MB
	Error Information Handle: Not Provided
	Number Of Devices: 1

Handle 0x0020, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001E
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM 1
	Bank Locator: DIMM 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: 3D500D11
	Asset Tag: Not Specified
	Part Number: M4 70T2953EZ3-CE6 

Handle 0x0021, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001E
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM 2
	Bank Locator: DIMM 2
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0022, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001F
	Error Information Handle: No Error
	Total Width: 8 bits
	Data Width: 8 bits
	Size: 1024 kB
	Form Factor: TSOP
	Set: None
	Locator: Flash ROM
	Bank Locator: Flash ROM
	Type: Flash
	Type Detail: Non-Volatile
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0023, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x001E
	Partition Width: 0

Handle 0x0024, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x000FFF00000
	Ending Address: 0x000FFFFFFFF
	Range Size: 1 MB
	Physical Array Handle: 0x001F
	Partition Width: 0

Handle 0x0025, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0020
	Memory Array Mapped Address Handle: 0x0023
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0026, DMI type 126, 19 bytes
Inactive

Handle 0x0027, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x000FFF00000
	Ending Address: 0x000FFFFFFFF
	Range Size: 1 MB
	Physical Device Handle: 0x0022
	Memory Array Mapped Address Handle: 0x0024
	Partition Row Position: 1

Handle 0x0028, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 2

Handle 0x0029, DMI type 126, 7 bytes
Inactive

Handle 0x002A, DMI type 22, 26 bytes
Portable Battery
	Location: in the front, left-hand side
	Manufacturer: Panasonic
	Name: Not Specified
	Chemistry: Lithium Ion
	Design Capacity: Unknown
	Design Voltage: Unknown
	SBDS Version: Not Specified
	Maximum Error: 0%
	SBDS Serial Number: 0000
	SBDS Manufacture Date: 1980-01-01
	OEM-specific Information: 0x00000000

Handle 0x002B, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Not Implemented
	Administrator Password Status: Disabled
	Front Panel Reset Status: Not Implemented

Handle 0x002C, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x002D, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_Mk4qHKn+cmp3HsB
Content-Type: text/plain;
  charset="us-ascii";
  name="failed_boot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="failed_boot.txt"

Linux version 2.6.24 (rts@toughbook) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #1 SMP PREEMPT Thu Feb 7 16:30:34 CET 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6c0000 (usable)
 BIOS-e820: 000000003f6c0000 - 000000003f6d1000 (ACPI NVS)
 BIOS-e820: 000000003f6d1000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00f77a0] 000f77a0
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259776
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   259776
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP 000F7770, 0024 (r2 MATBIO)
ACPI: XSDT 3F6C4F19, 007C (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: FACP 3F6CDC60, 00F4 (r3 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: DSDT 3F6C62C1, 791B (r1 MATBIO CF52-1LA  6040000 MSFT  3000000)
ACPI: FACS 3F6D0FC0, 0040
ACPI: HPET 3F6CDD54, 0038 (r1 MATBIO CF52-1LA  6040000 MEI        5A)
ACPI: SLIC 3F6CDD8C, 0176 (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: APIC 3F6CDF02, 0068 (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: MCFG 3F6CDF6A, 003C (r1 MATBIO CF52-1LA  6040000 MEI         0)
ACPI: BOOT 3F6CDFA6, 0028 (r1 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: TCPA 3F6CDFCE, 0032 (r1 MATBIO CF52-1LA  6040000 MEI         1)
ACPI: SSDT 3F6C5FC6, 02FB (r1 MATBIO CF52-1LA     1000 MEI  20050624)
ACPI: SSDT 3F6C5521, 025F (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: SSDT 3F6C547B, 00A6 (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: SSDT 3F6C4F95, 04E6 (r1 MATBIO CF52-1LA     3000 MEI  20050624)
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:b8000000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257747
Kernel command line: root=/dev/sda6 console=ttyS0,115200 console=tty0 acpi_osi=Linux
ACPI: Added _OSI(Linux)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1795.529 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024612k/1039104k available (2819k kernel code, 13868k reserved, 1135k data, 216k init, 121600k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9a000 - 0xfffff000   ( 404 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc04e4000 - 0xc051a000   ( 216 kB)
      .data : 0xc03c0eca - 0xc04dcb18   (1135 kB)
      .text : 0xc0100000 - 0xc03c0eca   (2819 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 3594.21 BogoMIPS (lpj=1797109)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
using mwait in idle threads.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 825 Objects with 66 Devices 269 Methods 26 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 14 Objects with 3 Devices 8 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 13 Objects with 0 Devices 4 Methods 0 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Booting processor 1/1 ip 4000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3590.95 BogoMIPS (lpj=1795478)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Total of 2 processors activated (7185.17 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
net_namespace: 164 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 5 Wake, Enabled 3 Runtime GPEs in this block
ACPI: EC: non-query interrupt received, switching to interrupt mode

--Boundary-00=_Mk4qHKn+cmp3HsB--
