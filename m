From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch] ACPI: call init functions explicitly instead of using
	initcalls
Date: Fri, 31 Oct 2008 11:42:23 +0800
Message-ID: <1225424543.3993.44.camel@yakui_zhao.sh.intel.com>
References: <200810291525.58218.bjorn.helgaas@hp.com>
	 <1225332103.5189.298.camel@yakui_zhao.sh.intel.com>
	 <200810300913.32986.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3197 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbYJaDfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 23:35:51 -0400
In-Reply-To: <200810300913.32986.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thu, 2008-10-30 at 23:13 +0800, Bjorn Helgaas wrote:
> On Wednesday 29 October 2008 08:01:43 pm Zhao Yakui wrote:
> > On Thu, 2008-10-30 at 05:25 +0800, Bjorn Helgaas wrote:
> > > Call init_acpi_device_notify(), acpi_debug_init(), acpi_scan_init(),
> > > and acpi_system_init() explicitly from acpi_init() instead of using
> > > initcalls.  This removes some link order and initcall order dependencies.
> > >
> > What is the advantage after the following functions are explicitly from
> > acpi_init instead of using initcall?
> 
> The advantage of explicit calls is that you don't have to worry
> about whether the initcall ordering is correct.  The ordering
> is obvious from the code and doesn't depend on link order.
Understand.     
> > In your patch the module link order is also changed. In current kernel
> > some module parameters using the same ACPI prefix are defined in the
> > different files. For example: acpi.debug_layer && acpi.debug_level are
> > defined in debug.c. The acpi.acpica_version is defined in system.c.
> >
> > If they are separated by files with module parameter, there exists the
> > following warning message.
> >      >WARNING: at /linux-2.6/fs/sysfs/dir.c:463
> > >sysfs_add_one+0x33/0x39()
> > >sysfs: duplicate filename 'acpi' can not be created
> 
> I did change the link order because acpi/debug.c and acpi/system.c
> are not drivers in the same sense as things like ec.c, pci_root.c,
> etc.  debug.c and system.c are really optional parts of ACPI itself,
> not things that can be loaded in after the fact like drivers can.
> 
> It would certainly be bad if the /sys/module/acpi directory creation
> relies on module link order.  I don't know enough about sysfs to
> intuit where this problem occurs, and I don't see it in my testing
> (see dmesg below).  Can you give any more information about this?
   For example: In my test the acpi.power_nocheck is defined in power.c.
The acpi.debug_level & acpi.debug_layer are defined in debug.c. And they
are split by the thermal/processor module.(The thermal/processor module
is also compiled as built-in kernel). So the following warning message
will be reported in the boot phase:
   >sysfs: duplicate filename 'acpi' can not be created

    Why this happen is caused by the generic param code related with
sysfs. (param_sysfs_init).
  
   Please try your patch on the latest kernel(2.6.28-rc2) and enable the
CONIF_ACPI_DEBUG in kernel configuration.(Of course the processor and
thermal should also be compiled as built-in kernel).
   Then you can see the warning message.
   Thanks 
    
> 
> Bjorn
> 
> 
> $ grep ACPI .config
> # Power management and ACPI
> CONFIG_ACPI=y
> CONFIG_ACPI_PROCFS=y
> CONFIG_ACPI_PROCFS_POWER=y
> CONFIG_ACPI_SYSFS_POWER=y
> CONFIG_ACPI_PROC_EVENT=y
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_DEBUG_FUNC_TRACE=y
> CONFIG_ACPI_EC=y
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_ACPI_CONTAINER=m
> CONFIG_HOTPLUG_PCI_ACPI=m
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> CONFIG_PNPACPI=y
> # CONFIG_BLK_DEV_IDEACPI is not set
> CONFIG_ATA_ACPI=y
> # CONFIG_PATA_ACPI is not set
> 
> 
> 
> Initializing cgroup subsys cpuset
> Linux version 2.6.28-rc2-00192-gc2f341d (bjorn@bob) (gcc version 3.4.5) #2 SMP Thu Oct 30 08:56:44 MDT 2008
> EFI v1.10 by HP: SALsystab=0x723ff7f86c8 ACPI 2.0=0x723ffbc0000 HCDP=0x723ffc03318 SMBIOS=0x1fffe000
> booting generic kernel on platform hpzx1
> PCDP: v3 at 0x723ffc03318
> Early serial console at MMIO 0xf0100004000 (options '9600n8')
> console [uart8250] enabled
> ACPI: RSDP 723FFBC0000, 0024 (r2     HP)
> ACPI: XSDT 723FFBE2A18, 007C (r1     HP   rx7620        0   HP        0)
> ACPI: FACP 723FFBE2670, 00F4 (r3     HP   rx7620        0   HP        0)
> FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
> ACPI: DSDT 723FFBC0340, 222DC (r2     HP  CELL001        0   HP        0)
> ACPI: FACS 723FFBC0028, 0040
> ACPI: SPCR 723FFBC0068, 0050 (r1     HP   rx7620        0   HP        0)
> ACPI: DBGP 723FFBC00B8, 0034 (r1     HP   rx7620        0   HP        0)
> ACPI: APIC 723FFBC01A0, 019C (r1     HP   rx7620        0   HP        0)
> ACPI: SLIT 723FFBE2768, 014D (r1     HP   rx7620        0   HP        0)
> ACPI: CPEP 723FFBE28B8, 004C (r1     HP   rx7620        0   HP        0)
> ACPI: SRAT 723FFBE2908, 0110 (r1     HP   rx7620        0   HP        0)
> ACPI: SPMI 723FFBE2620, 0050 (r4     HP   rx7620        0   HP        0)
> ACPI: OEMD 723FFBC0128, 0074 (r1     HP   rx7620        0   HP        0)
> ACPI: HPET 723FFBC00F0, 0038 (r1     HP   rx7620        0   HP        0)
> ACPI: SSDT 723FFBE2B08, 2080D (r2     HP  CELL000        0   HP        0)
> ACPI: SLIT table looks invalid. Not used.
> Number of logical nodes in system = 3
> Number of memory chunks in system = 4
> warning: skipping physical page 0
> warning: skipping physical page 0
> warning: skipping physical page 0
> warning: skipping physical page 0
> SAL 3.2: HP Orca/IPF version 3.88
> SAL Platform features: None
> SAL: AP wakeup using external interrupt vector 0xff
> ACPI: Local APIC address c0000000fee00000
> GSI 16 (level, low) -> CPU 0 (0x0001) vector 48
> 4 CPUs available, 4 CPUs total
> MCA related initialization done
> warning: skipping physical page 0
> Virtual mem_map starts at 0xa07ffffe70200000
> Zone PFN ranges:
>   DMA      0x00000001 -> 0x00010000
>   Normal   0x00010000 -> 0x0723fe00
> Movable zone start PFN for each node
> early_node_map[3] active PFN ranges
>     2: 0x00000001 -> 0x00001fff
>     0: 0x07002000 -> 0x0703ff00
>     1: 0x07200000 -> 0x0723fe00
> On node 0 totalpages: 253696
> free_area_init_node: node 0, pgdat e000070020020000, node_mem_map a07ffffff8200000
>   DMA zone: 0 pages used for memmap
>   Normal zone: 217 pages used for memmap
>   Normal zone: 253479 pages, LIFO batch:1
>   Movable zone: 0 pages used for memmap
> On node 1 totalpages: 261632
> free_area_init_node: node 1, pgdat e000072000030080, node_mem_map a07fffffff200000
>   DMA zone: 0 pages used for memmap
>   Normal zone: 224 pages used for memmap
>   Normal zone: 261408 pages, LIFO batch:1
>   Movable zone: 0 pages used for memmap
> On node 2 totalpages: 8190
> free_area_init_node: node 2, pgdat e000000000120100, node_mem_map a07ffffe70200000
>   DMA zone: 7 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 8183 pages, LIFO batch:0
>   Normal zone: 0 pages used for memmap
>   Movable zone: 0 pages used for memmap
> SMP: Allowing 4 CPUs, 0 hotplug CPUs
> Built 3 zonelists in Zone order, mobility grouping on.  Total pages: 523070
> Policy zone: Normal
> Kernel command line: BOOT_IMAGE=net1:/helgaas/ia64/vmlinux.gz root=/dev/sda2 debug maxcpus=1 scsi_mod.scan=async 2 ro
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> CPU 0: base freq=200.000MHz, ITC ratio=12/2, ITC freq=1200.000MHz+/-300ppm
> Console: colour dummy device 80x25
> Memory: 33428608k/33460608k available (8351k code, 76608k reserved, 11052k data, 1792k init)
> SLUB: Unable to allocate memory from node 2
> SLUB: Allocating a useless per node structure in order to be able to continue
> SLUB: Genslabs=17, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1024
> Calibrating delay loop... 1798.14 BogoMIPS (lpj=3596288)
> Dentry cache hash table entries: 4194304 (order: 9, 33554432 bytes)
> Inode-cache hash table entries: 2097152 (order: 8, 16777216 bytes)
> Mount-cache hash table entries: 4096
> ACPI: Core revision 20080926
> Parsing all Control Methods:
> Table [DSDT](id 0001) - 2547 Objects with 117 Devices 1130 Methods 136 Regions
> Parsing all Control Methods:
> Table [SSDT](id 0002) - 2398 Objects with 114 Devices 1027 Methods 131 Regions
>  tbxface-0596 [02] tb_load_namespace     : ACPI Tables successfully acquired
> evxfevnt-0079 [02] enable                : System is already in ACPI mode
> Boot processor id 0x0/0x1
> Brought up 1 CPUs
> Total of 1 processors activated (1798.14 BogoMIPS).
> CPU0 attaching NULL sched-domain.
> net_namespace: 552 bytes
> DMI present.
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> evgpeblk-0957 [04] ev_create_gpe_block   : GPE 00 to 3F [_GPE] 8 regs on int 0x10
> evgpeblk-0957 [04] ev_create_gpe_block   : GPE 40 to 7F [_GPE] 8 regs on int 0x10
> ACPI: EC: Look up EC in DSDT
> Completing Region/Field/Buffer/Package initialization:..........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
> Initialized 107/267 Regions 130/130 Fields 298/298 Buffers 19/19 Packages (4954 nodes)
> Initializing Device/Processor/Thermal objects by executing _INI methods:..................
> Executed 18 _INI methods requiring 22 _STA executions (examined 237 objects)
> evgpeblk-1054 [03] ev_initialize_gpe_bloc: Found 0 Wake, Enabled 57 Runtime GPEs in this block
> evgpeblk-1054 [03] ev_initialize_gpe_bloc: Found 0 Wake, Enabled 1 Runtime GPEs in this block
> ACPI: Interpreter enabled
> ACPI: (supports S0 S5)
> ACPI: Using IOSAPIC for interrupt routing
> ACPI: No dock devices found.
> ACPI: PCI Root Bridge [L000] (0001:00)
> IO   host 0x00000000000000-0x00000000000fff PCI 0x00000000000000-0x00000000000fff
> MMIO host 0x000f0100000000-0x000f0107ffffff PCI 0x000000c0000000-0x000000c7ffffff
> pci 0001:00:00.0: reg 18 32bit mmio: [0xc0007000-0xc000700f]
> pci 0001:00:00.1: reg 10 32bit mmio: [0xc0004000-0xc0004fff]
> pci 0001:00:03.0: reg 10 io port: [0x800-0x8ff]
> pci 0001:00:03.0: reg 14 64bit mmio: [0xc0005000-0xc00053ff]
> pci 0001:00:03.0: reg 1c 64bit mmio: [0xc0000000-0xc0001fff]
> pci 0001:00:03.0: supports D1 D2
> pci 0001:00:03.1: reg 10 io port: [0x900-0x9ff]
> pci 0001:00:03.1: reg 14 64bit mmio: [0xc0006000-0xc00063ff]
> pci 0001:00:03.1: reg 1c 64bit mmio: [0xc0002000-0xc0003fff]
> pci 0001:00:03.1: supports D1 D2
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L000._PRT]
> ACPI: PCI Root Bridge [L001] (0001:1c)
> IO   host 0x00000000001000-0x00000000001fff PCI 0x00000000001000-0x00000000001fff
> MMIO host 0x000f0108000000-0x000f010fffffff PCI 0x000000c8000000-0x000000cfffffff
> pci 0001:1d:01.0: reg 10 io port: [0x1000-0x10ff]
> pci 0001:1d:01.0: reg 14 64bit mmio: [0xc8014000-0xc80143ff]
> pci 0001:1d:01.0: reg 1c 64bit mmio: [0xc8010000-0xc8011fff]
> pci 0001:1d:01.0: supports D1 D2
> pci 0001:1d:01.1: reg 10 io port: [0x1100-0x11ff]
> pci 0001:1d:01.1: reg 14 64bit mmio: [0xc8015000-0xc80153ff]
> pci 0001:1d:01.1: reg 1c 64bit mmio: [0xc8012000-0xc8013fff]
> pci 0001:1d:01.1: supports D1 D2
> pci 0001:1d:04.0: reg 10 64bit mmio: [0xc8000000-0xc800ffff]
> pci 0001:1d:04.0: PME# supported from D3hot
> pci 0001:1d:04.0: PME# disabled
> pci 0001:1c:01.0: bridge io port: [0x1000-0x1fff]
> pci 0001:1c:01.0: bridge 32bit mmio: [0xc8000000-0xc80fffff]
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L001._PRT]
> ACPI: PCI Root Bridge [L002] (0001:38)
> IO   host 0x00000000002000-0x00000000003fff PCI 0x00000000002000-0x00000000003fff
> MMIO host 0x000f0110000000-0x000f011fffffff PCI 0x000000d0000000-0x000000dfffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L002._PRT]
> ACPI: PCI Root Bridge [L004] (0001:54)
> IO   host 0x00000000004000-0x00000000005fff PCI 0x00000000004000-0x00000000005fff
> MMIO host 0x000f0120000000-0x000f012fffffff PCI 0x000000e0000000-0x000000efffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L004._PRT]
> ACPI: PCI Root Bridge [L006] (0001:70)
> IO   host 0x00000000006000-0x00000000007fff PCI 0x00000000006000-0x00000000007fff
> MMIO host 0x000f0130000000-0x000f013fffffff PCI 0x000000f0000000-0x000000ffffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L006._PRT]
> ACPI: PCI Root Bridge [L008] (0001:8c)
> IO   host 0x00000000008000-0x00000000009fff PCI 0x00000000008000-0x00000000009fff
> MMIO host 0x000f4100000000-0x000f410fffffff PCI 0x000000c0000000-0x000000cfffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L008._PRT]
> ACPI: PCI Root Bridge [L010] (0001:a9)
> IO   host 0x0000000000a000-0x0000000000bfff PCI 0x0000000000a000-0x0000000000bfff
> MMIO host 0x000f4110000000-0x000f411fffffff PCI 0x000000d0000000-0x000000dfffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L010._PRT]
> ACPI: PCI Root Bridge [L012] (0001:c6)
> IO   host 0x0000000000c000-0x0000000000dfff PCI 0x0000000000c000-0x0000000000dfff
> MMIO host 0x000f4120000000-0x000f412fffffff PCI 0x000000e0000000-0x000000efffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L012._PRT]
> ACPI: PCI Root Bridge [L014] (0001:e3)
> IO   host 0x0000000000e000-0x0000000000ffff PCI 0x0000000000e000-0x0000000000ffff
> MMIO host 0x000f4130000000-0x000f413fffffff PCI 0x000000f0000000-0x000000ffffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L014._PRT]
> ACPI: PCI Root Bridge [L000] (0000:00)
> IO   host 0x00000001000000-0x00000001000fff PCI 0x00000000000000-0x00000000000fff
> MMIO host 0x000f0000000000-0x000f0007ffffff PCI 0x000000c0000000-0x000000c7ffffff
> pci 0000:00:00.0: reg 18 32bit mmio: [0xc0007000-0xc000700f]
> pci 0000:00:00.1: reg 10 32bit mmio: [0xc0004000-0xc0004fff]
> pci 0000:00:03.0: reg 10 io port: [0x800-0x8ff]
> pci 0000:00:03.0: reg 14 64bit mmio: [0xc0005000-0xc00053ff]
> pci 0000:00:03.0: reg 1c 64bit mmio: [0xc0000000-0xc0001fff]
> pci 0000:00:03.0: supports D1 D2
> pci 0000:00:03.1: reg 10 io port: [0x900-0x9ff]
> pci 0000:00:03.1: reg 14 64bit mmio: [0xc0006000-0xc00063ff]
> pci 0000:00:03.1: reg 1c 64bit mmio: [0xc0002000-0xc0003fff]
> pci 0000:00:03.1: supports D1 D2
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L000._PRT]
> ACPI: PCI Root Bridge [L001] (0000:1c)
> IO   host 0x00000001001000-0x00000001001fff PCI 0x00000000001000-0x00000000001fff
> MMIO host 0x000f0008000000-0x000f000fffffff PCI 0x000000c8000000-0x000000cfffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L001._PRT]
> ACPI: PCI Root Bridge [L002] (0000:38)
> IO   host 0x00000001002000-0x00000001003fff PCI 0x00000000002000-0x00000000003fff
> MMIO host 0x000f0010000000-0x000f001fffffff PCI 0x000000d0000000-0x000000dfffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L002._PRT]
> ACPI: PCI Root Bridge [L004] (0000:54)
> IO   host 0x00000001004000-0x00000001005fff PCI 0x00000000004000-0x00000000005fff
> MMIO host 0x000f0020000000-0x000f002fffffff PCI 0x000000e0000000-0x000000efffffff
> pci 0000:54:01.0: reg 10 64bit mmio: [0xe0100000-0xe011ffff]
> pci 0000:54:01.0: reg 18 64bit mmio: [0xe0080000-0xe00bffff]
> pci 0000:54:01.0: reg 20 io port: [0x4000-0x403f]
> pci 0000:54:01.0: reg 30 32bit mmio: [0xe0000000-0xe003ffff]
> pci 0000:54:01.0: PME# supported from D0 D3hot D3cold
> pci 0000:54:01.0: PME# disabled
> pci 0000:54:01.1: reg 10 64bit mmio: [0xe0120000-0xe013ffff]
> pci 0000:54:01.1: reg 18 64bit mmio: [0xe00c0000-0xe00fffff]
> pci 0000:54:01.1: reg 20 io port: [0x4040-0x407f]
> pci 0000:54:01.1: reg 30 32bit mmio: [0xe0040000-0xe007ffff]
> pci 0000:54:01.1: PME# supported from D0 D3hot
> pci 0000:54:01.1: PME# disabled
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L004._PRT]
> ACPI: PCI Root Bridge [L006] (0000:70)
> IO   host 0x00000001006000-0x00000001007fff PCI 0x00000000006000-0x00000000007fff
> MMIO host 0x000f0030000000-0x000f003fffffff PCI 0x000000f0000000-0x000000ffffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L006._PRT]
> ACPI: PCI Root Bridge [L008] (0000:8c)
> IO   host 0x00000001008000-0x00000001009fff PCI 0x00000000008000-0x00000000009fff
> MMIO host 0x000f4000000000-0x000f400fffffff PCI 0x000000c0000000-0x000000cfffffff
> pci 0000:8d:01.0: reg 10 io port: [0x8000-0x80ff]
> pci 0000:8d:01.0: reg 14 64bit mmio: [0xc0014000-0xc00143ff]
> pci 0000:8d:01.0: reg 1c 64bit mmio: [0xc0010000-0xc0011fff]
> pci 0000:8d:01.0: supports D1 D2
> pci 0000:8d:01.1: reg 10 io port: [0x8100-0x81ff]
> pci 0000:8d:01.1: reg 14 64bit mmio: [0xc0015000-0xc00153ff]
> pci 0000:8d:01.1: reg 1c 64bit mmio: [0xc0012000-0xc0013fff]
> pci 0000:8d:01.1: supports D1 D2
> pci 0000:8d:04.0: reg 10 64bit mmio: [0xc0000000-0xc000ffff]
> pci 0000:8d:04.0: PME# supported from D3hot
> pci 0000:8d:04.0: PME# disabled
> pci 0000:8c:01.0: bridge io port: [0x8000-0x8fff]
> pci 0000:8c:01.0: bridge 32bit mmio: [0xc0000000-0xc00fffff]
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L008._PRT]
> ACPI: PCI Root Bridge [L010] (0000:a9)
> IO   host 0x0000000100a000-0x0000000100bfff PCI 0x0000000000a000-0x0000000000bfff
> MMIO host 0x000f4010000000-0x000f401fffffff PCI 0x000000d0000000-0x000000dfffffff
> pci 0000:aa:04.0: reg 10 32bit mmio: [0xd8030000-0xd8030fff]
> pci 0000:aa:04.0: supports D1 D2
> pci 0000:aa:04.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:aa:04.0: PME# disabled
> pci 0000:aa:04.1: reg 10 32bit mmio: [0xd8031000-0xd8031fff]
> pci 0000:aa:04.1: supports D1 D2
> pci 0000:aa:04.1: PME# supported from D0 D1 D2 D3hot
> pci 0000:aa:04.1: PME# disabled
> pci 0000:aa:04.2: reg 10 32bit mmio: [0xd8032000-0xd80320ff]
> pci 0000:aa:04.2: supports D1 D2
> pci 0000:aa:04.2: PME# supported from D0 D1 D2 D3hot
> pci 0000:aa:04.2: PME# disabled
> pci 0000:aa:05.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
> pci 0000:aa:05.0: reg 14 io port: [0xa000-0xa0ff]
> pci 0000:aa:05.0: reg 18 32bit mmio: [0xd8020000-0xd802ffff]
> pci 0000:aa:05.0: reg 30 32bit mmio: [0xd8000000-0xd801ffff]
> pci 0000:aa:05.0: supports D1 D2
> pci 0000:a9:01.0: bridge io port: [0xa000-0xafff]
> pci 0000:a9:01.0: bridge 32bit mmio: [0xd0000000-0xd80fffff]
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L010._PRT]
> ACPI: PCI Root Bridge [L012] (0000:c6)
> IO   host 0x0000000100c000-0x0000000100dfff PCI 0x0000000000c000-0x0000000000dfff
> MMIO host 0x000f4020000000-0x000f402fffffff PCI 0x000000e0000000-0x000000efffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L012._PRT]
> ACPI: PCI Root Bridge [L014] (0000:e3)
> IO   host 0x0000000100e000-0x0000000100ffff PCI 0x0000000000e000-0x0000000000ffff
> MMIO host 0x000f4030000000-0x000f403fffffff PCI 0x000000f0000000-0x000000ffffffff
> ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L014._PRT]
> SCSI subsystem initialized
> libata version 3.00 loaded.
> IOC: sx1000 0.1 HPA 0xf8120002000 IOVA space 1024Mb at 0x80000000
> IOC: sx1000 0.1 HPA 0xf8120003000 IOVA space 1024Mb at 0x80000000
> IOC: sx1000 0.1 HPA 0xf8020002000 IOVA space 1024Mb at 0x80000000
> IOC: sx1000 0.1 HPA 0xf8020003000 IOVA space 1024Mb at 0x80000000
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> GSI 17 (level, low) -> CPU 0 (0x0001) vector 49
> GSI 18 (edge, low) -> CPU 0 (0x0001) vector 50
> GSI 19 (edge, low) -> CPU 0 (0x0001) vector 51
> GSI 20 (edge, low) -> CPU 0 (0x0001) vector 52
> GSI 122 (edge, low) -> CPU 0 (0x0001) vector 53
> GSI 123 (edge, low) -> CPU 0 (0x0001) vector 54
> GSI 124 (edge, low) -> CPU 0 (0x0001) vector 55
> pnp: PnP ACPI: found 32 devices
> ACPI: ACPI bus type pnp unregistered
> NET: Registered protocol family 2
> IP route cache hash table entries: 1048576 (order: 7, 8388608 bytes)
> TCP established hash table entries: 524288 (order: 7, 8388608 bytes)
> TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
> TCP: Hash tables configured (established 524288 bind 65536)
> TCP reno registered
> NET: Registered protocol family 1
> perfmon: version 2.0 IRQ 238
> perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
> PAL Information Facility v0.5
> perfmon: added sampling format default_format
> perfmon_default_smpl: default_format v2.0 registered
> HugeTLB registered 256 MB page size, pre-allocated 0 pages
> SGI XFS with security attributes, large block/inode numbers, no debug enabled
> msgmni has been set to 32768
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> hpet0: at MMIO 0xffffc082000, IRQs 50, 51, 52
> hpet0: 3 comparators, 64-bit 250.000000 MHz counter
> hpet1: at MMIO 0xffffc002000, IRQs 53, 54, 55
> hpet1: 3 comparators, 64-bit 250.000000 MHz counter
> EFI Time Services Driver v0.4
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> GSI 29 (level, low) -> CPU 0 (0x0001) vector 56
> serial 0001:00:00.0: PCI INT A -> GSI 29 (level, low) -> IRQ 56
> 0001:00:00.0: ttyS0 at MMIO 0xf0100007000 (irq = 56) is a 16550A
> serial 0001:00:00.1: PCI INT A -> GSI 29 (level, low) -> IRQ 56
> 0001:00:00.1: ttyS1 at MMIO 0xf0100004000 (irq = 56) is a 16550A
> console handover: boot [uart8250] -> real [ttyS1]
> 0001:00:00.1: ttyS2 at MMIO 0xf0100004010 (irq = 56) is a 16550A
> 0001:00:00.1: ttyS3 at MMIO 0xf0100004038 (irq = 56) is a 16550A
> GSI 133 (level, low) -> CPU 0 (0x0001) vector 57
> serial 0000:00:00.0: PCI INT A -> GSI 133 (level, low) -> IRQ 57
> Couldn't register serial port 0000:00:00.0: -28
> serial 0000:00:00.1: PCI INT A -> GSI 133 (level, low) -> IRQ 57
> Couldn't register serial port 0000:00:00.1: -28
> brd: module loaded
> Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> GSI 158 (level, low) -> CPU 0 (0x0001) vector 58
> e1000 0000:54:01.0: PCI INT A -> GSI 158 (level, low) -> IRQ 58
> e1000: 0000:54:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:6e:5d:a2:26
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> GSI 159 (level, low) -> CPU 0 (0x0001) vector 59
> e1000 0000:54:01.1: PCI INT B -> GSI 159 (level, low) -> IRQ 59
> e1000: 0000:54:01.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:6e:5d:a2:27
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> Intel(R) Gigabit Ethernet Network Driver - version 1.2.45-k2
> Copyright (c) 2008 Intel Corporation.
> tg3.c:v3.94 (August 14, 2008)
> GSI 32 (level, low) -> CPU 0 (0x0001) vector 60
> tg3 0001:1d:04.0: PCI INT A -> GSI 32 (level, low) -> IRQ 60
> eth2: Tigon3 [partno(A6794-60001) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000Base-T Ethernet 00:30:6e:47:e2:b5
> eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[0]
> eth2: dma_rwctrl[76ff2d0f] dma_mask[64-bit]
> GSI 180 (level, low) -> CPU 0 (0x0001) vector 61
> tg3 0000:8d:04.0: PCI INT A -> GSI 180 (level, low) -> IRQ 61
> eth3: Tigon3 [partno(A6794-60001) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000Base-T Ethernet 00:30:6e:47:e2:39
> eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[0]
> eth3: dma_rwctrl[76ff2d0f] dma_mask[64-bit]
> console [netcon0] enabled
> netconsole: network logging started
> Uniform Multi-Platform E-IDE driver
> ide-gd driver 1.18
> ide-cd driver 5.00
> GSI 26 (level, low) -> CPU 0 (0x0001) vector 62
> sym53c8xx 0001:00:03.0: PCI INT A -> GSI 26 (level, low) -> IRQ 62
> sym0: <1010-66> rev 0x1 at pci 0001:00:03.0 irq 62
> sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym0: open drain IRQ line driver, using on-chip SRAM
> sym0: using LOAD/STORE-based firmware.
> sym0: handling phase mismatch from SCRIPTS.
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.2.3
> GSI 27 (level, low) -> CPU 0 (0x0001) vector 63
> sym53c8xx 0001:00:03.1: PCI INT B -> GSI 27 (level, low) -> IRQ 63
> sym1: <1010-66> rev 0x1 at pci 0001:00:03.1 irq 63
> sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
> sym1: open drain IRQ line driver, using on-chip SRAM
> sym1: using LOAD/STORE-based firmware.
> sym1: handling phase mismatch from SCRIPTS.
> sym1: SCSI BUS has been reset.
> scsi1 : sym-2.2.3
> GSI 33 (level, low) -> CPU 0 (0x0001) vector 64
> sym53c8xx 0001:1d:01.0: PCI INT A -> GSI 33 (level, low) -> IRQ 64
> sym2: <1010-66> rev 0x1 at pci 0001:1d:01.0 irq 64
> sym2: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym2: open drain IRQ line driver, using on-chip SRAM
> sym2: using LOAD/STORE-based firmware.
> sym2: handling phase mismatch from SCRIPTS.
> sym2: SCSI BUS has been reset.
> scsi2 : sym-2.2.3
> GSI 34 (level, low) -> CPU 0 (0x0001) vector 65
> sym53c8xx 0001:1d:01.1: PCI INT B -> GSI 34 (level, low) -> IRQ 65
> sym3: <1010-66> rev 0x1 at pci 0001:1d:01.1 irq 65
> sym3: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym3: open drain IRQ line driver, using on-chip SRAM
> sym3: using LOAD/STORE-based firmware.
> sym3: handling phase mismatch from SCRIPTS.
> sym3: SCSI BUS has been reset.
> scsi3 : sym-2.2.3
> GSI 130 (level, low) -> CPU 0 (0x0001) vector 66
> sym53c8xx 0000:00:03.0: PCI INT A -> GSI 130 (level, low) -> IRQ 66
> sym4: <1010-66> rev 0x1 at pci 0000:00:03.0 irq 66
> sym4: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym4: open drain IRQ line driver, using on-chip SRAM
> sym4: using LOAD/STORE-based firmware.
> sym4: handling phase mismatch from SCRIPTS.
> sym4: SCSI BUS has been reset.
> scsi4 : sym-2.2.3
> GSI 131 (level, low) -> CPU 0 (0x0001) vector 67
> sym53c8xx 0000:00:03.1: PCI INT B -> GSI 131 (level, low) -> IRQ 67
> sym5: <1010-66> rev 0x1 at pci 0000:00:03.1 irq 67
> sym5: Symbios NVRAM, ID 7, Fast-80, HVD, parity checking
> sym5: open drain IRQ line driver, using on-chip SRAM
> sym5: using LOAD/STORE-based firmware.
> sym5: handling phase mismatch from SCRIPTS.
> sym5: SCSI BUS has been reset.
> scsi5 : sym-2.2.3
> GSI 181 (level, low) -> CPU 0 (0x0001) vector 68
> sym53c8xx 0000:8d:01.0: PCI INT A -> GSI 181 (level, low) -> IRQ 68
> sym6: <1010-66> rev 0x1 at pci 0000:8d:01.0 irq 68
> sym6: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym6: open drain IRQ line driver, using on-chip SRAM
> sym6: using LOAD/STORE-based firmware.
> sym6: handling phase mismatch from SCRIPTS.
> sym6: SCSI BUS has been reset.
> scsi6 : sym-2.2.3
> GSI 182 (level, low) -> CPU 0 (0x0001) vector 69
> sym53c8xx 0000:8d:01.1: PCI INT B -> GSI 182 (level, low) -> IRQ 69
> sym7: <1010-66> rev 0x1 at pci 0000:8d:01.1 irq 69
> sym7: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
> sym7: open drain IRQ line driver, using on-chip SRAM
> sym7: using LOAD/STORE-based firmware.
> sym7: handling phase mismatch from SCRIPTS.
> sym7: SCSI BUS has been reset.
> scsi7 : sym-2.2.3
> Driver 'sd' needs updating - please use bus_type methods
> Fusion MPT base driver 3.04.07
> Copyright (c) 1999-2008 LSI Corporation
> Fusion MPT SPI Host driver 3.04.07
> Fusion MPT SAS Host driver 3.04.07
> mice: PS/2 mouse device common for all mice
> EFI Variables Facility v0.08 2004-May-17
> TCP cubic registered
> NET: Registered protocol family 17
> scsi: waiting for bus probes to complete ...
> scsi 1:0:2:0: CD-ROM            _NEC     DVD+RW ND-2100AD 1.28 PQ: 0 ANSI: 2
>  target1:0:2: Beginning Domain Validation
>  target1:0:2: asynchronous
> scsi 0:0:6:0: Direct-Access     HP 36.4G MAM3367MC        HP00 PQ: 0 ANSI: 2
>  target0:0:6: tagged command queuing enabled, command queue depth 16.
>  target0:0:6: Beginning Domain Validation
>  target0:0:6: asynchronous
>  target0:0:6: wide asynchronous
>  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target0:0:6: Ending Domain Validation
>  target1:0:2: wide asynchronous
>  target1:0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 14)
>  target1:0:2: Domain Validation skipping write tests
>  target1:0:2: Ending Domain Validation
> scsi 4:0:5:0: Direct-Access     HP 36.4G MAS3367NC        HPC3 PQ: 0 ANSI: 3
>  target4:0:5: tagged command queuing enabled, command queue depth 16.
>  target4:0:5: Beginning Domain Validation
>  target4:0:5: asynchronous
>  target4:0:5: wide asynchronous
>  target4:0:5: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
>  target4:0:5: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
>  target4:0:5: Ending Domain Validation
> scsi 4:0:6:0: Direct-Access     HP 36.4G ST336753LC       HPC3 PQ: 0 ANSI: 3
>  target4:0:6: tagged command queuing enabled, command queue depth 16.
>  target4:0:6: Beginning Domain Validation
>  target4:0:6: asynchronous
> scsi 3:0:6:0: Direct-Access     HP 36.4G ST336753LC       HPC3 PQ: 0 ANSI: 3
>  target3:0:6: tagged command queuing enabled, command queue depth 16.
>  target3:0:6: Beginning Domain Validation
>  target3:0:6: asynchronous
>  target4:0:6: wide asynchronous
>  target3:0:6: wide asynchronous
>  target4:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target3:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target4:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target3:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
>  target4:0:6: Ending Domain Validation
>  target3:0:6: Ending Domain Validation
> sd 0:0:6:0: [sda] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 0:0:6:0: [sda] Write Protect is off
> sd 0:0:6:0: [sda] Mode Sense: ab 00 00 08
> sd 0:0:6:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:6:0: [sda] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 0:0:6:0: [sda] Write Protect is off
> sd 0:0:6:0: [sda] Mode Sense: ab 00 00 08
> sd 0:0:6:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2
> sd 0:0:6:0: [sda] Attached SCSI disk
> sd 3:0:6:0: [sdb] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 3:0:6:0: [sdb] Write Protect is off
> sd 3:0:6:0: [sdb] Mode Sense: d3 00 10 08
> sd 3:0:6:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
> sd 3:0:6:0: [sdb] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 3:0:6:0: [sdb] Write Protect is off
> sd 3:0:6:0: [sdb] Mode Sense: d3 00 10 08
> sd 3:0:6:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
>  sdb: sdb1 sdb2 sdb3 sdb4
> sd 3:0:6:0: [sdb] Attached SCSI disk
> sd 4:0:5:0: [sdc] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 4:0:5:0: [sdc] Write Protect is off
> sd 4:0:5:0: [sdc] Mode Sense: cf 00 10 08
> sd 4:0:5:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
> sd 4:0:5:0: [sdc] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 4:0:5:0: [sdc] Write Protect is off
> sd 4:0:5:0: [sdc] Mode Sense: cf 00 10 08
> sd 4:0:5:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
>  sdc: sdc1 sdc2 sdc3
> sd 4:0:5:0: [sdc] Attached SCSI disk
> sd 4:0:6:0: [sdd] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 4:0:6:0: [sdd] Write Protect is off
> sd 4:0:6:0: [sdd] Mode Sense: d3 00 10 08
> sd 4:0:6:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> sd 4:0:6:0: [sdd] 71132960 512-byte hardware sectors: (36.4 GB/33.9 GiB)
> sd 4:0:6:0: [sdd] Write Protect is off
> sd 4:0:6:0: [sdd] Mode Sense: d3 00 10 08
> sd 4:0:6:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
>  sdd: sdd1 sdd2 sdd3
> sd 4:0:6:0: [sdd] Attached SCSI disk
> ReiserFS: sda2: found reiserfs format "3.6" with standard journal
> ReiserFS: sda2: using ordered data mode
> ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda2: checking transaction log (sda2)
> ReiserFS: sda2: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 1792kB freed
> INIT: version 2.86 booting
> System Boot Control: Running /etc/init.d/boot
> Mounting procfs at /proc7[?25l[80C[10D[1;32mdone[m8[?25h
> Mounting sysfs at /sys7[?25l[80C[10D[1;32mdone[m8[?25h
> Mounting tmpfs at /dev7[?25l[80C[10D[1;32mdone[m8[?25h
> Initializing /dev7[?25l[80C[10D[1;32mdone[m8[?25h
> Mounting devpts at /dev/pts7[?25l[80C[10D[1;32mdone[m8[?25h
> Activating swap-devices in /etc/fstab...
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> /bin/mknod -m600 /dev/shm/root b 8 2
> Checking root file system...
> fsck 1.38 (30-Jun-2005)
> [/sbin/fsck.reiserfs (1) -- /dev/shm/root] fsck.reiserfs -a /dev/shm/root
> Reiserfs super block in block 16 on 0x802 of format 3.6 with standard journal
> Blocks (total/free): 8835744/8011374 by 4096 bytes
> Filesystem is clean
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hStarting udevd 7[?25l[80C[10D[1;32mdone[m8[?25h
> Activating device mapper...
> FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 7[?25l[80C[10D[1;31mfailed[m8[?25h
> Loading required kernel modules
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hStarting MD Raid ... no MD support in kernel7[?25l[80C[10D[1;33mskipped[m8[?25h
> Waiting for udev to settle...
> Scanning for LVM volume groups...
>   Reading all physical volumes.  This may take a while...
>   No volume groups found
>   No volume groups found
>   /proc/misc: No entry for device-mapper found
>   Is device-mapper driver missing from kernel?
>   Failure to communicate with kernel device-mapper driver.
> Activating LVM volume groups...
>   No volume groups found
> 7[?25l[80C[10D[1;32mdone[m8[?25h
> showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> Checking file systems...
> fsck 1.38 (30-Jun-2005)
> Checking all file systems.
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h7[?25l[80C[10D[1;32mdone[m8[?25h
> Mounting local file systems...
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> udev on /dev type tmpfs (rw)
> FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
> /dev/sda1 on /boot/efi type vfat (rw)
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hmodprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> Setting up the hardware clock7[?25l[80C[10D[1;32mdone[m8[?25h
> Retry device configuration7[?25l[80C[10D[1;32mdone[m8[?25h
> Setting up hostname 'linux-l6ur'7[?25l[80C[10D[1;32mdone[m8[?25h
> Setting up loopback interface     lo
>     lo        IP address: 127.0.0.1/8
> Checking for network time protocol daemon (NTPD): 7[?25l[80C[10D[1munused[m8[?25h
> 7[?25l[80C[10D[1;32mdone[m8[?25h
> Creating /var/log/boot.msg
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hshowconsoUnable to find swap-space signature
> le: Warning: the ioctl TIOCGDEV is not known by the kernel
> Unable to find swap-space signature
> Unable to find swap-space signature
> Activating remaining swap-devices in /etc/fstab...
> 7[?25l[1A[80C[10D[1;31mfailed[m8[?25hFATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> Loading AppArmor module [80C[10D[1;31mfailed[m
> Setting current sysctl status from /etc/sysctl.conf
> net.ipv4.icmp_echo_ignore_broadcasts = 1
> net.ipv4.conf.all.rp_filter = 1
> 7[?25l[80C[10D[1;32mdone[m8[?25h
> Enabling syn flood protection[80C[10D[1;32mdone[m
> Disabling IP forwarding7[?25l[80C[10D[1;32mdone[m8[?25h
> 7[?25l[80C[10D[1;32mdone[m8[?25h
> System Boot Control: The system has been [80C[10D[1mset up[m
> Failed features: [80C[20D[1;31mboot.apparmor[m
> Skipped features: [80C[25D[1;33mboot.md boot.cycle[m
> System Boot Control: Running /etc/init.d/boot.local
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hINIT: Entering runlevel: 2
> Boot logging started on /dev/ttyS1(/dev/console) at Thu Oct 30 09:04:12 2008
> Master Resource Control: previous runlevel: N, switching to runlevel: [80C[10D[1m2[m
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> Starting ia32el FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> mount: unknown filesystem type 'binfmt_misc'
> /etc/init.d/ia32el: line 60: /proc/sys/fs/binfmt_misc/register: No such file or directory
> /etc/init.d/ia32el: line 62: /proc/sys/fs/binfmt_misc/register: No such file or directory
> 7[?25l[80C[10D[1;31mfailed[m8[?25h
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.28-rc2-00192-gc2f341d/modules.dep: No such file or directory
> 
> [acpid]: starting up
> 
> [acpid]: 0 rules loaded
> 
> acpid: loading ACPI modules ( ) 7[?25l[80C[10D[1;31mfailed[m8[?25h
> Starting acpid 7[?25l[80C[10D[1;32mdone[m8[?25h
> Initializing random number generator7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting resource manager7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting salinfo daemon 7[?25l[80C[10D[1;32mdone[m8[?25h
> Loading keymap i386/qwerty/us.map.gz
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hLoading compose table winkeys shiftctrl latin1.add7[?25l[80C[10D[1;32mdone[m8[?25h
> Start Unicode mode
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hLoading console font lat9w-16.psfu  -m trivial G0:loadable
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hSetting up network interfaces:
>     lo
>     lo        IP address: 127.0.0.1/8
> Checking for network time protocol daemon (NTPD): 7[?25l[80C[10D[1munused[m8[?25h
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0      device: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
>               No configuration found for eth0
> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1      device: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
>               No configuration found for eth1
> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth2      device: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
>               No configuration found for eth2
> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth3      device: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
>     eth3      configuration: eth-id-00:30:6e:47:e2:39
>     eth3      (DHCP) . . tg3: eth3: Link is up at 100 Mbps, full duplex.
> tg3: eth3: Flow control is off for TX and off for RX.
> . . . no IP address yet... backgrounding.
> Warning: Could not set up default route via interface
>  Command ip route replace to default via 10.0.0.1 returned:
>  . RTNETLINK answers: Network is unreachable
>  Configuration line: default 10.0.0.1 - -
>  This needs NOT to be AN ERROR if you set up multiple interfaces.
>  See man 5 routes how to avoid this warning.
> 
> [1A[80C[10D[1;33mwaiting[m
> Waiting for mandatory devices:  eth-id-00:30:6e:47:e2:39 __NSC__
> 12 10 9 8
>     eth3      device: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
>     eth3      configuration: eth-id-00:30:6e:47:e2:39
>     eth3      DHCP client (dhcpcd) is running
>     eth3      IP address: 10.100.6.41/9
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25hSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting syslog services7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting CRON daemon7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting cupsd7[?25l[80C[10D[1;32mdone[m8[?25h
> Starting powersaved: 7[?25l[80C[10D[1;32mdone[m8[?25h
> Master Resource Control: runlevel 2 has been [80C[10D[1mreached[m
> Failed services in runlevel 2: [80C[19D[1;31macpid ia32el[m
> Skipped services in runlevel 2: [80C[13D[1;33msplash[m
> 
> 
> Welcome to SUSE Linux Enterprise Server 10 SP2 (ia64) - Kernel 2.6.28-rc2-00192-gc2f341d (console).
> 
> 
> eiger login: root
> Password:
> Last login: Thu Oct 30 08:59:14 MDT 2008 on console
> You have new mail.
> eiger:~ # dmesg | grep duplicate
> eiger:~ # ls /sys/module/acpi/parameters/
> acpica_version  debug_level        trace_debug_level  trace_state
> debug_layer     trace_debug_layer  trace_method_name

