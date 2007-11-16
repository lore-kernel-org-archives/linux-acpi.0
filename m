From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: no acpi events generated at all Sony Vaio SZ61
Date: Fri, 16 Nov 2007 15:54:28 +0800
Message-ID: <1195199668.3286.13.camel@acpi-hp.sh.intel.com>
References: <200711151138.42821.frank.munsche@gmx.net>
	 <1195177084.3337.93.camel@acpi-hp.sh.intel.com>
	 <200711160821.05066.frank.munsche@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23033 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbXKPHq7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2007 02:46:59 -0500
In-Reply-To: <200711160821.05066.frank.munsche@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank Munsche <frank.munsche@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Fri, 2007-11-16 at 15:21 +0800, Frank Munsche wrote:
> Hello Rui,
> 
> 
> On Friday 16 November 2007, Zhang Rui wrote:
> > On Thu, 2007-11-15 at 11:38 +0100, Frank Munsche wrote:
> > > Hello,
> > >
> > > I've got a Sony Vaio SZ61 running gentoo, 2.6.22-gentoo-r9 .
> Although
> > > there is acpi - information available in /proc/acpi (e.g. battery,
> > > ac_adapter, processor) I never get apci - events reported.
Then can you kill acpid and "cat /proc/acpi/event"
and see if there is anything happen when you unplugging the AC?
> > > If I pull the ac - cable, it is recognized and the processors
> freq. gets
> > > modified by cpufreqd. But there seems no (visible) acpi event
> generated.
> >
> > That's weird.
> > Please open an ACPI bug in http://bugzilla.kernel.org/enter_bug.cgi
> 
> I'm not sure about ACPI_PROC_EVENTS yet. Alexey also told me to enable
> this.
> But I can't find it . Should be in .config of 2.6.23.1 ?
> Googled around with buzzword 'ACPI_PROC_EVENTS' and got nothing.
> These are the acpi-options of my 2.6.23.1:
It's ACPI_PROC_EVENT. 
And I'm sure you should see it in 2.6.23.1.
> da linux # grep -i acpi  .config
> # Power management options (ACPI, APM)
> # ACPI (Advanced Configuration and Power Interface) Support
> CONFIG_ACPI=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_SLEEP_PROC_SLEEP=y
Weird.
These two config options have already been removed in 2.6.23.1.
Please check your kernel version again.
> CONFIG_ACPI_PROCFS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_DOCK=m
> # CONFIG_ACPI_BAY is not set
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=2001
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_ACPI_CONTAINER=y
> # CONFIG_ACPI_SBS is not set
> CONFIG_X86_ACPI_CPUFREQ=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set
> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> CONFIG_PNPACPI=y
> # CONFIG_THINKPAD_ACPI is not set
> CONFIG_BLK_DEV_IDEACPI=y
> CONFIG_ATA_ACPI=y
> 
> 
> 
> >
> > Please attach the acpidump, and dmesg output there.
> > please do the following test,
> > #dmesg -c
> > #echo 0x04 > /sys/module/acpi/parameters/debug_layer
> > #echo 0x8800001f > /sys/module/acpi/parameters/debug_level
> > plug/unuplug the ac cable
> > and attach the dmesg output after this test.
> 
> Attached the dmesg.
Well, the debug information in the dmesg is not what I expected.
Could you please check if you're using the right debug mask?
> 
Thanks,
Rui
> >
> > > I' ve tried the current 2.6.23.1, but got the same result.
> > >
> > > Just as other  things (like the powerbutton), which should
> generate an
> > > event, but don't.
> >
> > That's really strange.
> > For 2.6.23.1, please make sure ACPI_PROC_EVENTS is set.
> >
> > Thanks,
> > Rui
> >
> > > Linux version 2.6.23.1 (root@da) (gcc version 4.1.2 (Gentoo 4.1.2
> > > p1.0.2)) #1 SMP Mon Nov 12 13:16:57 CET 2007
> > > BIOS-provided physical RAM map:
> > >  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> > >  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> > >  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
> > >  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> > >  BIOS-e820: 0000000000100000 - 000000007f6b0000 (usable)
> > >  BIOS-e820: 000000007f6b0000 - 000000007f6cb000 (ACPI NVS)
> > >  BIOS-e820: 000000007f6cb000 - 0000000080000000 (reserved)
> > >  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> > >  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> > >  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
> > >  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
> > >  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
> > >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> > >  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> > > 1142MB HIGHMEM available.
> > > 896MB LOWMEM available.
> > > found SMP MP-table at 000f7710
> > > Entering add_active_range(0, 0, 521904) 0 entries of 256 used
> > > Zone PFN ranges:
> > >   DMA             0 ->     4096
> > >   Normal       4096 ->   229376
> > >   HighMem    229376 ->   521904
> > > Movable zone start PFN for each node
> > > early_node_map[1] active PFN ranges
> > >     0:        0 ->   521904
> > > On node 0 totalpages: 521904
> > >   DMA zone: 32 pages used for memmap
> > >   DMA zone: 0 pages reserved
> > >   DMA zone: 4064 pages, LIFO batch:0
> > >   Normal zone: 1760 pages used for memmap
> > >   Normal zone: 223520 pages, LIFO batch:31
> > >   HighMem zone: 2285 pages used for memmap
> > >   HighMem zone: 290243 pages, LIFO batch:31
> > >   Movable zone: 0 pages used for memmap
> > > DMI present.
> > > ACPI: RSDP 000F76E0, 0024 (r2 PTLTD )
> > > ACPI: XSDT 7F6BE790, 009C (r1   Sony     VAIO 20070712 PTL
> 0)
> > > ACPI: FACP 7F6C7BD2, 00F4 (r3   Sony     VAIO 20070712 PTL
> 1)
> > > ACPI: DSDT 7F6C07F3, 736B (r2   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: FACS 7F6CAFC0, 0040
> > > ACPI: APIC 7F6C7CC6, 0068 (r1   Sony     VAIO 20070712 PTL
> 5A)
> > > ACPI: HPET 7F6C7D2E, 0038 (r1   Sony     VAIO 20070712 PTL
> 5A)
> > > ACPI: MCFG 7F6C7D66, 003C (r1   Sony     VAIO 20070712 PTL
> 5A)
> > > ACPI: TCPA 7F6C7DA2, 0032 (r1   Sony     VAIO 20070712 PTL
> 5A52)
> > > ACPI: TMOR 7F6C7DD4, 0026 (r1   Sony     VAIO 20070712 PTL
> 3)
> > > ACPI: SLIC 7F6C7DFA, 0176 (r1   Sony     VAIO 20070712 PTL
> 1000000)
> > > ACPI: APIC 7F6C7F70, 0068 (r1   Sony     VAIO 20070712 PTL
> 0)
> > > ACPI: BOOT 7F6C7FD8, 0028 (r1   Sony     VAIO 20070712 PTL
> 1)
> > > ACPI: SSDT 7F6C0132, 06C1 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: SSDT 7F6BFA24, 070E (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: SSDT 7F6BF902, 0122 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: SSDT 7F6BEDB8, 025F (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: SSDT 7F6BED12, 00A6 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: SSDT 7F6BE82C, 04E6 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > ACPI: BIOS bug: multiple APIC/MADT found, using 0
> > > ACPI: If "acpi_apic_instance=2" works better, notify
> > > linux-acpi@vger.kernel.org
> > > ACPI: PM-Timer IO Port: 0x1008
> > > ACPI: Local APIC address 0xfee00000
> > > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> > > Processor #0 6:15 APIC version 20
> > > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> > > Processor #1 6:15 APIC version 20
> > > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > > ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > > ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> > > IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > > ACPI: IRQ0 used by override.
> > > ACPI: IRQ2 used by override.
> > > ACPI: IRQ9 used by override.
> > > Enabling APIC mode:  Flat.  Using 1 I/O APICs
> > > ACPI: HPET id: 0x8086a201 base: 0xfed00000
> > > Using ACPI (MADT) for SMP configuration information
> > > Allocating PCI resources starting at 88000000 (gap:
> 80000000:60000000)
> > > swsusp: Registered nosave memory region: 000000000009f000 -
> > > 00000000000a0000 swsusp: Registered nosave memory region:
> > > 00000000000a0000 - 00000000000d2000 swsusp: Registered nosave
> memory
> > > region: 00000000000d2000 - 00000000000d4000 swsusp: Registered
> nosave
> > > memory region: 00000000000d4000 - 00000000000e0000 swsusp:
> Registered
> > > nosave memory region: 00000000000e0000 - 0000000000100000 Built 1
> > > zonelists in Zone order.  Total pages: 517827
> > > Kernel command line: root=/dev/sda6
> > > mapped APIC to ffffb000 (fee00000)
> > > mapped IOAPIC to ffffa000 (fec00000)
> > > Enabling fast FPU save and restore... done.
> > > Enabling unmasked SIMD FPU exception support... done.
> > > Initializing CPU#0
> > > PID hash table entries: 4096 (order: 12, 16384 bytes)
> > > Detected 2393.969 MHz processor.
> > > Console: colour VGA+ 80x25
> > > console [tty0] enabled
> > > Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo
> Molnar
> > > ... MAX_LOCKDEP_SUBCLASSES:    8
> > > ... MAX_LOCK_DEPTH:          30
> > > ... MAX_LOCKDEP_KEYS:        2048
> > > ... CLASSHASH_SIZE:           1024
> > > ... MAX_LOCKDEP_ENTRIES:     8192
> > > ... MAX_LOCKDEP_CHAINS:      16384
> > > ... CHAINHASH_SIZE:          8192
> > >  memory used by lock dependency info: 1024 kB
> > >  per task-struct memory footprint: 1680 bytes
> > > Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > > Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > > Memory: 2062060k/2087616k available (2235k kernel code, 24476k
> reserved,
> > > 1229k data, 560k init, 1170112k highmem)
> > > virtual kernel memory layout:
> > >     fixmap  : 0xffee4000 - 0xfffff000   (1132 kB)
> > >     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> > >     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
> > >     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
> > >       .init : 0xc0469000 - 0xc04f5000   ( 560 kB)
> > >       .data : 0xc032ec36 - 0xc04621c4   (1229 kB)
> > >       .text : 0xc0100000 - 0xc032ec36   (2235 kB)
> > > Checking if this processor honours the WP bit even in supervisor
> mode...
> > > Ok. hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> > > hpet0: 3 64-bit timers, 14318180 Hz
> > > Calibrating delay using timer specific routine.. 4795.10 BogoMIPS
> > > (lpj=9590211)
> > > Security Framework v1.0.0 initialized
> > > SELinux:  Initializing.
> > > SELinux:  Starting in permissive mode
> > > Mount-cache hash table entries: 512
> > > CPU: After generic identify, caps: bfebfbff 20100000 00000000
> 00000000
> > > 0000e3bd 00000000 00000001 00000001
> > > monitor/mwait feature present.
> > > using mwait in idle threads.
> > > CPU: L1 I cache: 32K, L1 D cache: 32K
> > > CPU: L2 cache: 4096K
> > > CPU: Physical Processor ID: 0
> > > CPU: Processor Core ID: 0
> > > CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940
> 0000e3bd
> > > 00000000 00000001 00000001
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#0.
> > > Compat vDSO mapped to ffffe000.
> > > Checking 'hlt' instruction... OK.
> > > lockdep: not fixing up alternatives.
> > > ACPI: Core revision 20070126
> > > Parsing all Control Methods:
> > > Table [DSDT](id 0001) - 1019 Objects with 94 Devices 235 Methods
> 38
> > > Regions Parsing all Control Methods:
> > > Table [SSDT](id 0002) - 12 Objects with 3 Devices 4 Methods 0
> Regions
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0003) - 13 Objects with 3 Devices 5 Methods 0
> Regions
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0004) - 5 Objects with 0 Devices 3 Methods 0
> Regions
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0005) - 7 Objects with 0 Devices 3 Methods 0
> Regions
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0006) - 4 Objects with 0 Devices 3 Methods 0
> Regions
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0007) - 13 Objects with 0 Devices 4 Methods 0
> Regions
> > >  tbxface-0598 [00] tb_load_namespace     : ACPI Tables
> successfully
> > > acquired evxfevnt-0091 [00] enable                : Transition to
> ACPI
> > > mode successful CPU0: Intel(R) Core(TM)2 Duo CPU     T7700  @
> 2.40GHz
> > > stepping 0b lockdep: not fixing up alternatives.
> > > Booting processor 1/1 eip 3000
> > > Initializing CPU#1
> > > Calibrating delay using timer specific routine.. 4787.88 BogoMIPS
> > > (lpj=9575775)
> > > CPU: After generic identify, caps: bfebfbff 20100000 00000000
> 00000000
> > > 0000e3bd 00000000 00000001 00000001
> > > monitor/mwait feature present.
> > > CPU: L1 I cache: 32K, L1 D cache: 32K
> > > CPU: L2 cache: 4096K
> > > CPU: Physical Processor ID: 0
> > > CPU: Processor Core ID: 1
> > > CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940
> 0000e3bd
> > > 00000000 00000001 00000001
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#1.
> > > CPU1: Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz stepping 0b
> > > Total of 2 processors activated (9582.99 BogoMIPS).
> > > ENABLING IO-APIC IRQs
> > > ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> > > checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> > > Brought up 2 CPUs
> > > Booting paravirtualized kernel on bare hardware
> > > NET: Registered protocol family 16
> > > ACPI: bus type pci registered
> > > PCI: Using MMCONFIG
> > > Setting up standard PCI resources
> > > evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4
> regs on
> > > int 0x9
> > > evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 5
> > > Runtime GPEs in this block
> > > ACPI: EC: Look up EC in DSDT
> > > ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
> > > Completing Region/Field/Buffer/Package
> > >
> initialization:..........................................................
> > >...................... Initialized 36/38 Regions 0/0 Fields 27/28
> Buffers
> > > 17/46 Packages (1082 nodes) Initializing Device/Processor/Thermal
> objects
> > > by executing _INI
> > > methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
> > > ACPI: If "acpi_osi=Linux" works better,
> > > Please send dmidecode to linux-acpi@vger.kernel.org
> > > .
> > > Executed 1 _INI methods requiring 0 _STA executions (examined 107
> > > objects) ACPI: Interpreter enabled
> > > ACPI: (supports S0 S3 S4 S5)
> > > ACPI: Using IOAPIC for interrupt routing
> > > ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
> > > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > > PCI: Transparent bridge - 0000:00:1e.0
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
> > > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> > > ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> > > ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
> > > ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> > > ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
> > > ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> > > ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
> > > ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> > > ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
> > > Linux Plug and Play Support v0.97 (c) Adam Belay
> > > pnp: PnP ACPI init
> > > ACPI: bus type pnp registered
> > > pnp: PnP ACPI: found 12 devices
> > > ACPI: ACPI bus type pnp unregistered
> > > SCSI subsystem initialized
> > > libata version 2.21 loaded.
> > > PCI: Using ACPI for IRQ routing
> > > PCI: If a device doesn't work, try "pci=routeirq".  If it helps,
> post a
> > > report NetLabel: Initializing
> > > NetLabel:  domain hash size = 128
> > > NetLabel:  protocols = UNLABELED CIPSOv4
> > > NetLabel:  unlabeled traffic allowed by default
> > > ACPI: RTC can wake from S4
> > > Time: tsc clocksource has been installed.
> > > pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be
> reserved
> > > pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be
> reserved
> > > pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be
> reserved
> > > pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be
> reserved
> > > PCI: Bridge: 0000:00:1c.0
> > >   IO window: 2000-2fff
> > >   MEM window: f6000000-f7ffffff
> > >   PREFETCH window: f0000000-f1ffffff
> > > PCI: Bridge: 0000:00:1c.1
> > >   IO window: 3000-3fff
> > >   MEM window: f8000000-f9ffffff
> > >   PREFETCH window: f2000000-f3ffffff
> > > PCI: Bridge: 0000:00:1c.2
> > >   IO window: 4000-4fff
> > >   MEM window: fa000000-fbffffff
> > >   PREFETCH window: f4000000-f5ffffff
> > > PCI: Bridge: 0000:00:1c.3
> > >   IO window: 5000-5fff
> > >   MEM window: c8000000-c9ffffff
> > >   PREFETCH window: cc000000-cdffffff
> > > PCI: Bus 10, cardbus bridge: 0000:09:04.0
> > >   IO window: 00006000-000060ff
> > >   IO window: 00006400-000064ff
> > >   PREFETCH window: 88000000-8bffffff
> > >   MEM window: 90000000-93ffffff
> > > PCI: Bridge: 0000:00:1e.0
> > >   IO window: 6000-6fff
> > >   MEM window: fc200000-fc2fffff
> > >   PREFETCH window: 88000000-8bffffff
> > > ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ
> 16
> > > PCI: Setting latency timer of device 0000:00:1c.0 to 64
> > > ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ
> 17
> > > PCI: Setting latency timer of device 0000:00:1c.1 to 64
> > > ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ
> 18
> > > PCI: Setting latency timer of device 0000:00:1c.2 to 64
> > > ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ
> 19
> > > PCI: Setting latency timer of device 0000:00:1c.3 to 64
> > > PCI: Setting latency timer of device 0000:00:1e.0 to 64
> > > ACPI: PCI Interrupt 0000:09:04.0[A] -> GSI 20 (level, low) -> IRQ
> 20
> > > NET: Registered protocol family 2
> > > IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> > > TCP established hash table entries: 65536 (order: 9, 2621440
> bytes)
> > > TCP bind hash table entries: 65536 (order: 9, 2359296 bytes)
> > > TCP: Hash tables configured (established 65536 bind 65536)
> > > TCP reno registered
> > > Simple Boot Flag at 0x36 set to 0x1
> > > audit: initializing netlink socket (disabled)
> > > audit(1195124180.432:1): initialized
> > > highmem bounce pool size: 64 pages
> > > Total HugeTLB memory allocated, 0
> > > VFS: Disk quotas dquot_6.5.1
> > > Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> > > SELinux:  Registering netfilter hooks
> > > io scheduler noop registered
> > > io scheduler anticipatory registered (default)
> > > io scheduler deadline registered
> > > io scheduler cfq registered
> > > Boot video device is 0000:00:02.0
> > > PCI: Setting latency timer of device 0000:00:1c.0 to 64
> > > assign_interrupt_mode Found MSI capability
> > > Allocate Port Service[0000:00:1c.0:pcie00]
> > > Allocate Port Service[0000:00:1c.0:pcie02]
> > > Allocate Port Service[0000:00:1c.0:pcie03]
> > > PCI: Setting latency timer of device 0000:00:1c.1 to 64
> > > assign_interrupt_mode Found MSI capability
> > > Allocate Port Service[0000:00:1c.1:pcie00]
> > > Allocate Port Service[0000:00:1c.1:pcie02]
> > > Allocate Port Service[0000:00:1c.1:pcie03]
> > > PCI: Setting latency timer of device 0000:00:1c.2 to 64
> > > assign_interrupt_mode Found MSI capability
> > > Allocate Port Service[0000:00:1c.2:pcie00]
> > > Allocate Port Service[0000:00:1c.2:pcie02]
> > > Allocate Port Service[0000:00:1c.2:pcie03]
> > > PCI: Setting latency timer of device 0000:00:1c.3 to 64
> > > assign_interrupt_mode Found MSI capability
> > > Allocate Port Service[0000:00:1c.3:pcie00]
> > > Allocate Port Service[0000:00:1c.3:pcie02]
> > > Allocate Port Service[0000:00:1c.3:pcie03]
> > > ACPI: AC Adapter [ACAD] (on-line)
> > > ACPI: Battery Slot [BAT1] (battery present)
> > > ACPI: SSDT 7F6BF57E, 02BC (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > Parsing all Control Methods:
> > > Table [SSDT](id 002D) - 6 Objects with 0 Devices 3 Methods 0
> Regions
> > > ACPI: SSDT 7F6BF017, 04E2 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > Parsing all Control Methods:
> > > Table [SSDT](id 002E) - 1 Objects with 0 Devices 1 Methods 0
> Regions
> > > Monitor-Mwait will be used to enter C-1 state
> > > Monitor-Mwait will be used to enter C-2 state
> > > Monitor-Mwait will be used to enter C-3 state
> > > ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> > > ACPI: Processor [CPU0] (supports 8 throttling states)
> > > ACPI: SSDT 7F6BF83A, 00C8 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > Parsing all Control Methods:
> > > Table [SSDT](id 0039) - 4 Objects with 0 Devices 4 Methods 0
> Regions
> > > ACPI: SSDT 7F6BF4F9, 0085 (r1   Sony     VAIO 20070712 PTL
> 20050624)
> > > Parsing all Control Methods:
> > > Table [SSDT](id 003A) - 1 Objects with 0 Devices 1 Methods 0
> Regions
> > > ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> > > ACPI: Processor [CPU1] (supports 8 throttling states)
> > > Marking TSC unstable due to: possible TSC halt in C2.
> > > Time: hpet clocksource has been installed.
> > > ACPI: Thermal Zone [ATF0] (28 C)
> > > Switched to high resolution mode on CPU 0
> > > Switched to high resolution mode on CPU 1
> > > ACPI: Thermal Zone [DTS0] (27 C)
> > > ACPI: Thermal Zone [DTS1] (26 C)
> > > hpet_resources: 0xfed00000 is busy
> > > Linux agpgart interface v0.102
> > > agpgart: Detected an Intel 965GM Chipset.
> > > agpgart: Detected 7676K stolen memory.
> > > agpgart: AGP aperture is 256M @ 0xd0000000
> > > Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
> disabled
> > > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
> blocksize
> > > netconsole: not configured, aborting
> > > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > > idebus=xx ICH8M: IDE controller at PCI slot 0000:00:1f.1
> > > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ
> 21
> > > ICH8M: chipset revision 3
> > > ICH8M: not 100% native mode: will probe irqs later
> > >     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
> > >     ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:pio, hdd:pio
> > > Probing IDE interface ide0...
> > > Clocksource tsc unstable (delta = -358258157 ns)
> > > hda: MATSHITADVD-RAM UJ-852S, ATAPI CD/DVD-ROM drive
> > > hda: selected mode 0x42
> > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > Probing IDE interface ide1...
> > > Probing IDE interface ide1...
> > > ata_piix 0000:00:1f.2: version 2.12
> > > ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> > > ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ
> 21
> > > PCI: Setting latency timer of device 0000:00:1f.2 to 64
> > > scsi0 : ata_piix
> > > scsi1 : ata_piix
> > > ata1: SATA max UDMA/133 cmd 0x00011c00 ctl 0x000118f6 bmdma
> 0x000118e0
> > > irq 21 ata2: SATA max UDMA/133 cmd 0x000118f8 ctl 0x000118f2 bmdma
> > > 0x000118e8 irq 21 ata1.00: ATA-7: TOSHIBA MK2035GSS, DK022A, max
> UDMA/100
> > > ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 0/32)
> > > ata1.00: configured for UDMA/100
> > > scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK2035GS DK02 PQ:
> 0
> > > ANSI: 5 sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors
> (200050 MB)
> > > sd 0:0:0:0: [sda] Write Protect is off
> > > sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> doesn't
> > > support DPO or FUA
> > > sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> > > sd 0:0:0:0: [sda] Write Protect is off
> > > sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> doesn't
> > > support DPO or FUA
> > >  sda: sda1 sda2 sda3 < sda5 sda6 >
> > > sd 0:0:0:0: [sda] Attached SCSI disk
> > > PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq
> 1,12
> > > serio: i8042 KBD port at 0x60,0x64 irq 1
> > > serio: i8042 AUX port at 0x60,0x64 irq 12
> > > mice: PS/2 mouse device common for all mice
> > > input: AT Translated Set 2 keyboard as /class/input/input0
> > > TCP cubic registered
> > > NET: Registered protocol family 1
> > > NET: Registered protocol family 17
> > > Starting balanced_irq
> > > Using IPI No-Shortcut mode
> > > kjournald starting.  Commit interval 5 seconds
> > > EXT3-fs: mounted filesystem with ordered data mode.
> > > VFS: Mounted root (ext3 filesystem) readonly.
> > > Freeing unused kernel memory: 560k freed
> > > Real Time Clock Driver v1.12ac
> > > ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 22 (level, low) -> IRQ
> 21
> > > usbcore: registered new interface driver usbfs
> > > usbcore: registered new interface driver hub
> > > usbcore: registered new device driver usb
> > > ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 20 (level, low) -> IRQ
> 20
> > > PCI: Setting latency timer of device 0000:00:1a.7 to 64
> > > ehci_hcd 0000:00:1a.7: EHCI Host Controller
> > > ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number
> 1
> > > ehci_hcd 0000:00:1a.7: debug port 1
> > > PCI: cache line size of 32 is not supported by device 0000:00:1a.7
> > > ehci_hcd 0000:00:1a.7: irq 20, io mem 0xfc504000
> > > ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec
> 2004
> > > usb usb1: configuration #1 chosen from 1 choice
> > > hub 1-0:1.0: USB hub found
> > > hub 1-0:1.0: 4 ports detected
> > > USB Universal Host Controller Interface driver v3.0
> > > input: Video Bus as /class/input/input1
> > > ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> > > input: Power Button (CM) as /class/input/input2
> > > ACPI: Power Button (CM) [PWRB]
> > > input: Lid Switch as /class/input/input3
> > > ACPI: Lid Switch [LID0]
> > > ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ
> 20
> > > PCI: Setting latency timer of device 0000:00:1a.0 to 64
> > > uhci_hcd 0000:00:1a.0: UHCI Host Controller
> > > uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number
> 2
> > > uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001820
> > > usb usb2: configuration #1 chosen from 1 choice
> > > hub 2-0:1.0: USB hub found
> > > hub 2-0:1.0: 2 ports detected
> > > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > > sony-laptop: Sony Programmable IO Control Driver v0.5.
> > > sony-laptop: detected Type2 model
> > > input: Sony Vaio Keys as /class/input/input4
> > > input: Sony Vaio Jogdial as /class/input/input5
> > > sony-laptop: device allocated minor is 62
> > > ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 20 (level, low) -> IRQ
> 20
> > > PCI: Setting latency timer of device 0000:00:1a.1 to 64
> > > uhci_hcd 0000:00:1a.1: UHCI Host Controller
> > > uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number
> 3
> > > uhci_hcd 0000:00:1a.1: irq 20, io base 0x00001840
> > > usb usb3: configuration #1 chosen from 1 choice
> > > hub 3-0:1.0: USB hub found
> > > hub 3-0:1.0: 2 ports detected
> > > input: PS/2 Mouse as /class/input/input6
> > > input: AlpsPS/2 ALPS GlidePoint as /class/input/input7
> > > sony-laptop: Sony Notebook Control Driver v0.5.
> > > ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ
> 22
> > > PCI: Setting latency timer of device 0000:00:1d.0 to 64
> > > uhci_hcd 0000:00:1d.0: UHCI Host Controller
> > > uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number
> 4
> > > uhci_hcd 0000:00:1d.0: irq 22, io base 0x00001860
> > > usb usb4: configuration #1 chosen from 1 choice
> > > hub 4-0:1.0: USB hub found
> > > hub 4-0:1.0: 2 ports detected
> > > hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
> UDMA(33)
> > > Uniform CD-ROM driver Revision: 3.20
> > > ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 23 (level, low) -> IRQ
> 22
> > > PCI: Setting latency timer of device 0000:00:1d.1 to 64
> > > uhci_hcd 0000:00:1d.1: UHCI Host Controller
> > > uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number
> 5
> > > uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001880
> > > usb usb5: configuration #1 chosen from 1 choice
> > > hub 5-0:1.0: USB hub found
> > > hub 5-0:1.0: 2 ports detected
> > > ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ
> 22
> > > PCI: Setting latency timer of device 0000:00:1d.2 to 64
> > > uhci_hcd 0000:00:1d.2: UHCI Host Controller
> > > uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number
> 6
> > > uhci_hcd 0000:00:1d.2: irq 22, io base 0x000018a0
> > > usb usb6: configuration #1 chosen from 1 choice
> > > hub 6-0:1.0: USB hub found
> > > hub 6-0:1.0: 2 ports detected
> > > usb 1-2: new high speed USB device using ehci_hcd and address 3
> > > ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ
> 22
> > > PCI: Setting latency timer of device 0000:00:1d.7 to 64
> > > ehci_hcd 0000:00:1d.7: EHCI Host Controller
> > > ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number
> 7
> > > ehci_hcd 0000:00:1d.7: debug port 1
> > > PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> > > ehci_hcd 0000:00:1d.7: irq 22, io mem 0xfc504400
> > > ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec
> 2004
> > > usb usb7: configuration #1 chosen from 1 choice
> > > hub 7-0:1.0: USB hub found
> > > hub 7-0:1.0: 6 ports detected
> > > ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level, low) -> IRQ
> 18
> > > PCI: Setting latency timer of device 0000:07:00.0 to 64
> > > sky2 0000:07:00.0: v1.18 addr 0xfa000000 irq 18 Yukon-EC Ultra
> (0xb4) rev
> > > 3 sky2 eth0: addr 00:1a:80:56:69:98
> > > ACPI: PCI Interrupt 0000:09:04.2[C] -> GSI 22 (level, low) -> IRQ
> 21
> > > Yenta: CardBus bridge found at 0000:09:04.0 [104d:9008]
> > > Yenta: Enabling burst memory read transactions
> > > Yenta: Using CSCINT to route CSC interrupts to PCI
> > > Yenta: Routing CardBus interrupts to PCI
> > > Yenta TI: socket 0000:09:04.0, mfunc 0x01a21b22, devctl 0x64
> > > ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ
> 23
> > > PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > > usb 1-2: configuration #1 chosen from 1 choice
> > > Yenta: ISA IRQ mask 0x0cb8, PCI irq 20
> > > Socket status: 30000006
> > > Yenta: Raising subordinate bus# of parent bus (#09) from #0a to
> #0d
> > > pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
> > > cs: IO port probe 0x6000-0x6fff: clean.
> > > pcmcia: parent PCI bridge Memory window: 0xfc200000 - 0xfc2fffff
> > > pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8bffffff
> > > ACPI: PCI Interrupt 0000:09:04.1[B] -> GSI 21 (level, low) -> IRQ
> 23
> > > usb 2-1: new full speed USB device using uhci_hcd and address 2
> > > ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[23]
> > > MMIO=[fc206000-fc2067ff] Max Packet=[2048]  IR/IT contexts=[4/8]
> > > usb 2-1: configuration #1 chosen from 1 choice
> > > usb 7-1: new high speed USB device using ehci_hcd and address 2
> > > usb 7-1: configuration #1 chosen from 1 choice
> > > hub 7-1:1.0: USB hub found
> > > hub 7-1:1.0: 4 ports detected
> > > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[080046030292f887]
> > > EXT3 FS on sda6, internal journal
> > > usbcore: registered new interface driver snd-usb-audio
> > > device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
> > > dm-devel@redhat.com
> > > Adding 2002836k swap on /dev/sda5.  Priority:-1 extents:1
> across:2002836k
> > > sky2 eth0: enabling interface
> > > sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
> > > NET: Registered protocol family 10
> > > lo: Disabled Privacy Extensions
> > > eth0: no IPv6 routers present
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > lspci  -vv
> > > 00:00.0 Host bridge: Intel Corporation Mobile Memory Controller
> Hub (rev
> > > 0c) Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR+ FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Capabilities: [e0] Vendor Specific Information
> > >
> > > 00:02.0 VGA compatible controller: Intel Corporation Mobile
> Integrated
> > > Graphics Controller (rev 0c) (prog-if 00 [VGA])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 10
> > >         Region 0: Memory at fc000000 (64-bit, non-prefetchable)
> [size=1M]
> > >         Region 2: Memory at d0000000 (64-bit, prefetchable)
> [size=256M]
> > >         Region 4: I/O ports at 1800 [size=8]
> > >         Capabilities: [90] Message Signalled Interrupts: Mask-
> 64bit-
> > > Queue=0/0 Enable-
> > >                 Address: 00000000  Data: 0000
> > >         Capabilities: [d0] Power Management version 3
> > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >                 Bridge: PM- B3+
> > >
> > > 00:02.1 Display controller: Intel Corporation Mobile Integrated
> Graphics
> > > Controller (rev 0c)
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Region 0: Memory at fc100000 (64-bit, non-prefetchable)
> [size=1M]
> > >         Capabilities: [d0] Power Management version 3
> > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >                 Bridge: PM- B3+
> > >
> > > 00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
> UHCI
> > > Contoller #4 (rev 03) (prog-if 00 [UHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 20
> > >         Region 4: I/O ports at 1820 [size=32]
> > >
> > > 00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
> UHCI
> > > Controller #5 (rev 03) (prog-if 00 [UHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 20
> > >         Region 4: I/O ports at 1840 [size=32]
> > >
> > > 00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family)
> USB2 EHCI
> > > Controller #2 (rev 03) (prog-if 20 [EHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin C routed to IRQ 20
> > >         Region 0: Memory at fc504000 (32-bit, non-prefetchable)
> [size=1K]
> > >         Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [58] Debug port
> > >
> > > 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD
> Audio
> > > Controller (rev 03)
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Interrupt: pin A routed to IRQ 23
> > >         Region 0: Memory at fc500000 (64-bit, non-prefetchable)
> > > [size=16K] Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [60] Message Signalled Interrupts: Mask-
> 64bit+
> > > Queue=0/0 Enable-
> > >                 Address: 0000000000000000  Data: 0000
> > >         Capabilities: [70] Express (v1) Root Complex Integrated
> Endpoint,
> > > MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > <64ns, L1 <1us
> > >                         ExtTag- RBE- FLReset-
> > >                 DevCtl: Report errors: Correctable- Non-Fatal-
> Fatal-
> > > Unsupported-
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop+
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #0, Speed unknown, Width x0, ASPM
> unknown,
> > > Latency L0 <64ns, L1 <1us
> > >                         ClockPM- Suprise- LLActRep- BwNot-
> > >                 LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed unknown, Width x0, TrErr- Train-
> SlotClk-
> > > DLActive- BWMgmt- ABWMgmt-
> > >         Capabilities: [100] Virtual Channel
> > >         Capabilities: [130] Root Complex Link
> > >
> > > 00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI
> Express
> > > Port 1 (rev 03) (prog-if 00 [Normal decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Bus: primary=00, secondary=02, subordinate=05,
> sec-latency=0
> > >         I/O behind bridge: 00002000-00002fff
> > >         Memory behind bridge: f6000000-f7ffffff
> > >         Prefetchable memory behind bridge:
> > > 00000000f0000000-00000000f1ffffff Secondary status: 66MHz-
> FastB2B-
> > > ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
> FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat-
> DiscTmrSERREn-
> > >         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > unlimited, L1 unlimited
> > >                         ExtTag- RBE+ FLReset-
> > >                 DevCtl: Report errors: Correctable+ Non-Fatal+
> Fatal+
> > > Unsupported+
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop-
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <1us, L1 <4us
> > >                         ClockPM- Suprise- LLActRep+ BwNot-
> > >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
> Retrain-
> > > CommClk-
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+
> > > DLActive- BWMgmt- ABWMgmt-
> > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug+
> > > Surpise+
> > >                         Slot #  2, PowerLimit 6.500000; Interlock-
> > > NoCompl- SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq-
> > > LinkChg-
> > >                         Control: AttnInd Unknown, PwrInd Unknown,
> Power-
> > > Interlock-
> > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet-
> > > Interlock-
> > >                         Changed: MRL- PresDet- LinkState-
> > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > PMEIntEna- CRSVisible-
> > >                 RootCap: CRSVisible-
> > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > >         Capabilities: [80] Message Signalled Interrupts: Mask-
> 64bit-
> > > Queue=0/0 Enable+
> > >                 Address: fee0300c  Data: 41d1
> > >         Capabilities: [90] Subsystem: Sony Corporation Unknown
> device
> > > 9008 Capabilities: [a0] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [100] Virtual Channel
> > >         Capabilities: [180] Root Complex Link
> > >
> > > 00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI
> Express
> > > Port 2 (rev 03) (prog-if 00 [Normal decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Bus: primary=00, secondary=06, subordinate=06,
> sec-latency=0
> > >         I/O behind bridge: 00003000-00003fff
> > >         Memory behind bridge: f8000000-f9ffffff
> > >         Prefetchable memory behind bridge:
> > > 00000000f2000000-00000000f3ffffff Secondary status: 66MHz-
> FastB2B-
> > > ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
> FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat-
> DiscTmrSERREn-
> > >         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > unlimited, L1 unlimited
> > >                         ExtTag- RBE+ FLReset-
> > >                 DevCtl: Report errors: Correctable+ Non-Fatal+
> Fatal+
> > > Unsupported+
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop-
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <256ns, L1 <4us
> > >                         ClockPM- Suprise- LLActRep+ BwNot-
> > >                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
> Retrain-
> > > CommClk+
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+
> > > DLActive+ BWMgmt- ABWMgmt-
> > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug+
> > > Surpise+
> > >                         Slot #  3, PowerLimit 6.500000; Interlock-
> > > NoCompl- SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq-
> > > LinkChg-
> > >                         Control: AttnInd Unknown, PwrInd Unknown,
> Power-
> > > Interlock-
> > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+
> > > Interlock-
> > >                         Changed: MRL- PresDet- LinkState-
> > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > PMEIntEna- CRSVisible-
> > >                 RootCap: CRSVisible-
> > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > >         Capabilities: [80] Message Signalled Interrupts: Mask-
> 64bit-
> > > Queue=0/0 Enable+
> > >                 Address: fee0300c  Data: 41d9
> > >         Capabilities: [90] Subsystem: Sony Corporation Unknown
> device
> > > 9008 Capabilities: [a0] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [100] Virtual Channel
> > >         Capabilities: [180] Root Complex Link
> > >
> > > 00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI
> Express
> > > Port 3 (rev 03) (prog-if 00 [Normal decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Bus: primary=00, secondary=07, subordinate=07,
> sec-latency=0
> > >         I/O behind bridge: 00004000-00004fff
> > >         Memory behind bridge: fa000000-fbffffff
> > >         Prefetchable memory behind bridge:
> > > 00000000f4000000-00000000f5ffffff Secondary status: 66MHz-
> FastB2B-
> > > ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
> FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat-
> DiscTmrSERREn-
> > >         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > unlimited, L1 unlimited
> > >                         ExtTag- RBE+ FLReset-
> > >                 DevCtl: Report errors: Correctable+ Non-Fatal+
> Fatal+
> > > Unsupported+
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop-
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <256ns, L1 <4us
> > >                         ClockPM- Suprise- LLActRep+ BwNot-
> > >                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes
> Disabled-
> > > Retrain- CommClk+
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+
> > > DLActive+ BWMgmt- ABWMgmt-
> > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug+
> > > Surpise+
> > >                         Slot #  4, PowerLimit 6.500000; Interlock-
> > > NoCompl- SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq-
> > > LinkChg-
> > >                         Control: AttnInd Unknown, PwrInd Unknown,
> Power-
> > > Interlock-
> > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+
> > > Interlock-
> > >                         Changed: MRL- PresDet- LinkState-
> > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > PMEIntEna- CRSVisible-
> > >                 RootCap: CRSVisible-
> > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > >         Capabilities: [80] Message Signalled Interrupts: Mask-
> 64bit-
> > > Queue=0/0 Enable+
> > >                 Address: fee0300c  Data: 41e1
> > >         Capabilities: [90] Subsystem: Sony Corporation Unknown
> device
> > > 9008 Capabilities: [a0] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [100] Virtual Channel
> > >         Capabilities: [180] Root Complex Link
> > >
> > > 00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI
> Express
> > > Port 4 (rev 03) (prog-if 00 [Normal decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Bus: primary=00, secondary=08, subordinate=08,
> sec-latency=0
> > >         I/O behind bridge: 00005000-00005fff
> > >         Memory behind bridge: c8000000-c9ffffff
> > >         Prefetchable memory behind bridge:
> > > 00000000cc000000-00000000cdffffff Secondary status: 66MHz-
> FastB2B-
> > > ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
> FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat-
> DiscTmrSERREn-
> > >         Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > unlimited, L1 unlimited
> > >                         ExtTag- RBE+ FLReset-
> > >                 DevCtl: Report errors: Correctable+ Non-Fatal+
> Fatal+
> > > Unsupported+
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop-
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <1us, L1 <4us
> > >                         ClockPM- Suprise- LLActRep+ BwNot-
> > >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
> Retrain-
> > > CommClk-
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
> SlotClk+
> > > DLActive- BWMgmt- ABWMgmt-
> > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug+
> > > Surpise+
> > >                         Slot #  5, PowerLimit 6.500000; Interlock-
> > > NoCompl- SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq-
> > > LinkChg-
> > >                         Control: AttnInd Unknown, PwrInd Unknown,
> Power-
> > > Interlock-
> > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet-
> > > Interlock-
> > >                         Changed: MRL- PresDet- LinkState-
> > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > PMEIntEna- CRSVisible-
> > >                 RootCap: CRSVisible-
> > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > >         Capabilities: [80] Message Signalled Interrupts: Mask-
> 64bit-
> > > Queue=0/0 Enable+
> > >                 Address: fee0300c  Data: 41e9
> > >         Capabilities: [90] Subsystem: Sony Corporation Unknown
> device
> > > 9008 Capabilities: [a0] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [100] Virtual Channel
> > >         Capabilities: [180] Root Complex Link
> > >
> > > 00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
> UHCI
> > > Controller #1 (rev 03) (prog-if 00 [UHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 22
> > >         Region 4: I/O ports at 1860 [size=32]
> > >
> > > 00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
> UHCI
> > > Controller #2 (rev 03) (prog-if 00 [UHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 22
> > >         Region 4: I/O ports at 1880 [size=32]
> > >
> > > 00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
> UHCI
> > > Controller #3 (rev 03) (prog-if 00 [UHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin C routed to IRQ 22
> > >         Region 4: I/O ports at 18a0 [size=32]
> > >
> > > 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family)
> USB2 EHCI
> > > Controller #1 (rev 03) (prog-if 20 [EHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin D routed to IRQ 22
> > >         Region 0: Memory at fc504400 (32-bit, non-prefetchable)
> [size=1K]
> > >         Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> > >         Capabilities: [58] Debug port
> > >
> > > 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
> f3)
> > > (prog-if 01 [Subtractive decode])
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Bus: primary=00, secondary=09, subordinate=0d,
> sec-latency=32
> > >         I/O behind bridge: 00006000-00006fff
> > >         Memory behind bridge: fc200000-fc2fffff
> > >         Prefetchable memory behind bridge:
> > > 0000000088000000-000000008bffffff Secondary status: 66MHz- FastB2B
> +
> > > ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
> FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat-
> DiscTmrSERREn-
> > >         Capabilities: [50] Subsystem: Sony Corporation Unknown
> device
> > > 9008
> > >
> > > 00:1f.0 ISA bridge: Intel Corporation Mobile LPC Interface
> Controller
> > > (rev 03) Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Capabilities: [e0] Vendor Specific Information
> > >
> > > 00:1f.1 IDE interface: Intel Corporation Mobile IDE Controller
> (rev 03)
> > > (prog-if 8a [Master SecP PriP])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin A routed to IRQ 21
> > >         Region 0: I/O ports at 01f0 [size=8]
> > >         Region 1: I/O ports at 03f4 [size=1]
> > >         Region 2: I/O ports at 0170 [size=8]
> > >         Region 3: I/O ports at 0374 [size=1]
> > >         Region 4: I/O ports at 1810 [size=16]
> > >
> > > 00:1f.2 IDE interface: Intel Corporation Mobile SATA IDE
> Controller (rev
> > > 03) (prog-if 8f [Master SecP SecO PriP PriO])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 21
> > >         Region 0: I/O ports at 1c00 [size=8]
> > >         Region 1: I/O ports at 18f4 [size=4]
> > >         Region 2: I/O ports at 18f8 [size=8]
> > >         Region 3: I/O ports at 18f0 [size=4]
> > >         Region 4: I/O ports at 18e0 [size=16]
> > >         Region 5: I/O ports at 18d0 [size=16]
> > >         Capabilities: [70] Power Management version 3
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > PME(D0-,D1-,D2-,D3hot+,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > 00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus
> Controller
> > > (rev 03)
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Interrupt: pin C routed to IRQ 21
> > >         Region 0: Memory at 8c000000 (32-bit, non-prefetchable)
> > > [size=256] Region 4: I/O ports at 1c20 [size=32]
> > >
> > > 06:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
> > > Network Connection (rev 02)
> > >         Subsystem: Intel Corporation Unknown device 1051
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Interrupt: pin A routed to IRQ 10
> > >         Region 0: Memory at f8000000 (32-bit, non-prefetchable)
> [size=4K]
> > >         Capabilities: [c8] Power Management version 2
> > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [d0] Message Signalled Interrupts: Mask-
> 64bit+
> > > Queue=0/0 Enable-
> > >                 Address: 0000000000000000  Data: 0000
> > >         Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > <512ns, L1 unlimited
> > >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> FLReset-
> > >                 DevCtl: Report errors: Correctable- Non-Fatal-
> Fatal-
> > > Unsupported-
> > >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr-
> NoSnoop+
> > >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                 DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <128ns, L1 <64us
> > >                         ClockPM+ Suprise- LLActRep- BwNot-
> > >                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
> Retrain-
> > > CommClk+
> > >                         ExtSynch- ClockPM+ AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+
> > > DLActive- BWMgmt- ABWMgmt-
> > >         Capabilities: [100] Advanced Error Reporting
> > >         Capabilities: [140] Device Serial Number
> 7a-db-ff-ff-77-1b-00-00
> > >
> > > 07:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8055
> PCI-E
> > > Gigabit Ethernet Controller (rev 12)
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Interrupt: pin A routed to IRQ 219
> > >         Region 0: Memory at fa000000 (64-bit, non-prefetchable)
> > > [size=16K] Region 2: I/O ports at 4000 [size=256]
> > >         [virtual] Expansion ROM at f4000000 [disabled] [size=128K]
> > >         Capabilities: [48] Power Management version 3
> > >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> > > PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> > >         Capabilities: [50] Vital Product Data
> > >         Capabilities: [5c] Message Signalled Interrupts: Mask-
> 64bit+
> > > Queue=0/0 Enable+
> > >                 Address: 00000000fee0300c  Data: 4142
> > >         Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
> > >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency
> L0s
> > > unlimited, L1 unlimited
> > >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset-
> > >                 DevCtl: Report errors: Correctable- Non-Fatal-
> Fatal-
> > > Unsupported-
> > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr-
> NoSnoop-
> > >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> > >                 DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+
> AuxPwr+
> > > TransPend-
> > >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s
> L1,
> > > Latency L0 <256ns, L1 unlimited
> > >                         ClockPM+ Suprise- LLActRep- BwNot-
> > >                 LnkCtl: ASPM L0s L1 Enabled; RCB 128 bytes
> Disabled-
> > > Retrain- CommClk+
> > >                         ExtSynch- ClockPM+ AutWidDis- BWInt-
> AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+
> > > DLActive- BWMgmt- ABWMgmt-
> > >         Capabilities: [100] Advanced Error Reporting
> > >
> > > 09:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus
> Controller
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 168, Cache Line Size: 64 bytes
> > >         Interrupt: pin A routed to IRQ 20
> > >         Region 0: Memory at fc204000 (32-bit, non-prefetchable)
> [size=4K]
> > >         Bus: primary=09, secondary=0a, subordinate=0d,
> sec-latency=176
> > >         Memory window 0: 88000000-8bfff000 (prefetchable)
> > >         Memory window 1: 90000000-93fff000
> > >         I/O window 0: 00006000-000060ff
> > >         I/O window 1: 00006400-000064ff
> > >         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> > > PostWrite+ 16-bit legacy interface ports at 0001
> > >
> > > 09:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI
> Compliant
> > > IEEE 1394 Host Controller (prog-if 10 [OHCI])
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 32 (750ns min, 1000ns max), Cache Line Size: 64
> bytes
> > >         Interrupt: pin B routed to IRQ 23
> > >         Region 0: Memory at fc206000 (32-bit, non-prefetchable)
> [size=2K]
> > >         Region 1: Memory at fc200000 (32-bit, non-prefetchable)
> > > [size=16K] Capabilities: [44] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
> > > PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> > >
> > > 09:04.2 Mass storage controller: Texas Instruments 5-in-1
> Multimedia Card
> > > Reader (SD/MMC/MS/MS PRO/xD)
> > >         Subsystem: Sony Corporation Unknown device 9008
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
> VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64
> bytes
> > >         Interrupt: pin C routed to IRQ 21
> > >         Region 0: Memory at fc205000 (32-bit, non-prefetchable)
> [size=4K]
> > >         Capabilities: [44] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> > > PME(D0+,D1+,D2+,D3hot+,D3cold-)
> > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > >
> > >
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
