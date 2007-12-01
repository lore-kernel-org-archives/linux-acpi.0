From: JM <v-j-m@suomi24.fi>
Subject: Acer Aspire 9813WKMI fan runs all the time after suspend to ram
Date: Sat, 1 Dec 2007 14:53:46 +0100 (CET)
Message-ID: <17761706.1196517226756.JavaMail.apache@eni-cpps11.sth.basefarm.net>
Reply-To: v-j-m@suomi24.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eni-mailout02.sth.basefarm.net ([80.76.148.9]:42608 "EHLO
	eni-mailout02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752152AbXLAOVi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Dec 2007 09:21:38 -0500
Received: from [10.7.4.193] (port=48906 helo=eni-cpps11.sth.basefarm.net)
	by eni-mailout02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1IySmw-0005kx-9I
	for linux-acpi@vger.kernel.org; Sat, 01 Dec 2007 14:53:49 +0100
Received: from localhost ([127.0.0.1]:48904 helo=eni-cpps11.sth.basefarm.net)
	by eni-cpps11.sth.basefarm.net with esmtp (Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1IySmw-0000KO-OY
	for linux-acpi@vger.kernel.org; Sat, 01 Dec 2007 14:53:46 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Notebook fan runs all the time after suspend to ram.
After suspend to disk fan works OK.

after suspend to ram:
cat /proc/acpi/fan/FAN0/state
status:                  off

cat /proc/acpi/thermal_zone/TZ00/temperature
temperature:             27 C

cat /proc/acpi/thermal_zone/TZ01/temperature
temperature:             39 C

cat /proc/acpi/thermal_zone/TZ00/trip_points
critical (S5):           107 C
active[0]:               53 C: devices=FAN0

cat /proc/acpi/thermal_zone/TZ01/trip_points
critical (S5):           106 C


dmesg after boot:
[    0.000000] Linux version 2.6.24-rc3-ge1cca7e8-15-default 
(abuild@build15) (gcc version 4.2.1 (SUSE Linux)) 
#e1cca7e8d484390169777b423a7fe46c7021fec1 SMP 2007/25/30 01:25:2
[    0.000000] Command line: root=/dev/disk/by-id/scsi-
SATA_SAMSUNG_HM120JIS09GJ30LB71446-part5 vga=0x348 resume=/dev/sda6 
splash=silent
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009b400 
(usable)
[    0.000000]  BIOS-e820: 000000000009b400 - 00000000000a0000 
(reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 
(reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 
(reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fe90000 
(usable)
[    0.000000]  BIOS-e820: 000000007fe90000 - 000000007fe9a000 (ACPI 
NVS)
[    0.000000]  BIOS-e820: 000000007fe9a000 - 0000000080000000 
(reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 
(reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 
(reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 
(reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 
(reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 
(reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 
(reserved)
[    0.000000] Entering add_active_range(0, 0, 155) 0 entries of 3200 
used
[    0.000000] Entering add_active_range(0, 256, 523920) 1 entries of 
3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F62A0, 0024 (r2 ACRSYS)
[    0.000000] ACPI: XSDT 7FE91BC9, 0064 (r1 ACRSYS ACRPRDCT  6040000  
LTP        0)
[    0.000000] ACPI: FACP 7FE98C2A, 00F4 (r3 ACRSYS ACRPRDCT  6040000 
ALAN        1)
[    0.000000] ACPI: DSDT 7FE925BB, 65FB (r1 ACRSYS ACRPRDCT  6040000 
INTL 20050624)
[    0.000000] ACPI: FACS 7FE99FC0, 0040
[    0.000000] ACPI: APIC 7FE98D1E, 0068 (r1 INTEL  CALISTGA  6040000 
LOHR       5A)
[    0.000000] ACPI: HPET 7FE98D86, 0038 (r1 INTEL  CALISTGA  6040000 
LOHR       5A)
[    0.000000] ACPI: MCFG 7FE98DBE, 003C (r1 INTEL  CALISTGA  6040000 
LOHR       5A)
[    0.000000] ACPI: APIC 7FE98DFA, 0068 (r1 ACRSYS ACRPRDCT  6040000  
LTP        0)
[    0.000000] ACPI: SLIC 7FE98E62, 0176 (r1 ACRSYS ACRPRDCT  6040000  
LTP        0)
[    0.000000] ACPI: BOOT 7FE98FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  
LTP        1)
[    0.000000] ACPI: SSDT 7FE91C2D, 0500 (r1  PmRef    CpuPm     3000 
INTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007fe90000
[    0.000000] Entering add_active_range(0, 0, 155) 0 entries of 3200 
used
[    0.000000] Entering add_active_range(0, 256, 523920) 1 entries of 
3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fe90000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      155
[    0.000000]     0:      256 ->   523920
[    0.000000] On node 0 totalpages: 523819
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1403 pages reserved
[    0.000000]   DMA zone: 2536 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7106 pages used for memmap
[    0.000000]   DMA32 zone: 512718 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl 
dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high 
level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 
000000000009b000 - 000000000009c000
[    0.000000] swsusp: Registered nosave memory region: 
000000000009c000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 
00000000000a0000 - 00000000000dc000
[    0.000000] swsusp: Registered nosave memory region: 
00000000000dc000 - 00000000000e0000
[    0.000000] swsusp: Registered nosave memory region: 
00000000000e0000 - 00000000000e4000
[    0.000000] swsusp: Registered nosave memory region: 
00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 
80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 46816 bytes of per cpu data
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  
Total pages: 515254
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/disk/by-id/scsi-
SATA_SAMSUNG_HM120JIS09GJ30LB71446-part5 vga=0x348 resume=/dev/sda6 
splash=silent
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] hpet clockevent registered
[    0.000000] TSC calibrated against HPET
[   23.221308] Marking TSC unstable due to TSCs unsynchronized
[   23.221312] time.c: Detected 1662.499 MHz processor.
[   23.221369] Console: colour dummy device 80x25
[   23.221374] console [tty0] enabled
[   23.221675] Checking aperture...
[   23.221694] Calgary: detecting Calgary via BIOS EBDA area
[   23.221697] Calgary: Unable to locate Rio Grande table in EBDA - 
bailing!
[   23.253921] Memory: 2056384k/2095680k available (2112k kernel code, 
38892k reserved, 983k data, 324k init)
[   23.331121] Calibrating delay using timer specific routine.. 
3329.33 BogoMIPS (lpj=6658673)
[   23.331227] Security Framework initialized
[   23.331239] Capability LSM initialized
[   23.331677] Dentry cache hash table entries: 262144 (order: 9, 
2097152 bytes)
[   23.333496] Inode-cache hash table entries: 131072 (order: 8, 
1048576 bytes)
[   23.334385] Mount-cache hash table entries: 256
[   23.334679] CPU: L1 I cache: 32K, L1 D cache: 32K
[   23.334690] CPU: L2 cache: 2048K
[   23.334697] CPU 0/0 -> Node 0
[   23.334702] using mwait in idle threads.
[   23.334707] CPU: Physical Processor ID: 0
[   23.334712] CPU: Processor Core ID: 0
[   23.334726] CPU0: Thermal monitoring handled by SMI
[   23.334751] SMP alternatives: switching to UP code
[   23.335859] ACPI: Core revision 20070126
[   23.343543] Parsing all Control Methods:
[   23.343751] Table [DSDT](id 0001) - 995 Objects with 94 Devices 220 
Methods 27 Regions
[   23.343917] Parsing all Control Methods:
[   23.344106] Table [SSDT](id 0002) - 13 Objects with 0 Devices 4 
Methods 0 Regions
[   23.344118]  tbxface-0598 [00] tb_load_namespace     : ACPI Tables 
successfully acquired
[   23.364362] evxfevnt-0091 [00] enable                : Transition 
to ACPI mode successful
[   23.405170] Using local APIC timer interrupts.
[   23.465238] APIC timer calibration result 10390617
[   23.465242] Detected 10.390 MHz APIC timer.
[   23.465403] SMP alternatives: switching to SMP code
[   23.466267] Booting processor 1/2 APIC 0x1
[   23.476843] Initializing CPU#1
[   23.557111] Calibrating delay using timer specific routine.. 
3325.08 BogoMIPS (lpj=6650160)
[   23.557122] CPU: L1 I cache: 32K, L1 D cache: 32K
[   23.557125] CPU: L2 cache: 2048K
[   23.557129] CPU 1/1 -> Node 0
[   23.557132] CPU: Physical Processor ID: 0
[   23.557134] CPU: Processor Core ID: 1
[   23.557146] CPU1: Thermal monitoring enabled (TM2)
[   23.557699] Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz 
stepping 06
[   23.557811] Brought up 2 CPUs
[   23.558562] net_namespace: 120 bytes
[   23.559339] NET: Registered protocol family 16
[   23.559711] ACPI: bus type pci registered
[   23.569420] PCI: Using MMCONFIG at e0000000 - efffffff
[   23.573002] evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F 
[_GPE] 4 regs on int 0x9
[   23.573702] evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 9 
Wake, Enabled 1 Runtime GPEs in this block
[   23.573721] ACPI: EC: Look up EC in DSDT
[   23.576448] Completing Region/Field/Buffer/Package 
initialization:..................................................................................................................................
[   23.579691] Initialized 26/27 Regions 39/39 Fields 44/45 Buffers 
21/39 Packages (1017 nodes)
[   23.579704] Initializing Device/Processor/Thermal objects by 
executing _INI methods:...
[   23.589206] Executed 3 _INI methods requiring 0 _STA executions 
(examined 100 objects)
[   23.589248] ACPI: Interpreter enabled
[   23.589255] ACPI: (supports S0 S3 S4 S5)
[   23.589293] ACPI: Using IOAPIC for interrupt routing
[   23.603021] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data 
= 0x62
[   23.603031] ACPI: EC: driver started in poll mode
[   23.603306] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   23.604033] PCI quirk: region 1000-107f claimed by ICH6 
ACPI/GPIO/TCO
[   23.604043] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[   23.605759] PCI: Transparent bridge - 0000:00:1e.0
[   23.605928] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   23.606644] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP.
_PRT]
[   23.606966] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01.
_PRT]
[   23.607284] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02.
_PRT]
[   23.607597] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03.
_PRT]
[   23.607909] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04.
_PRT]
[   23.608250] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB.
_PRT]
[   23.617059] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 
14 15) *11
[   23.617291] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 
12 14 15)
[   23.617514] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 
12 14 15)
[   23.617736] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 
14 15) *10
[   23.617959] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 
14 15) *0, disabled.
[   23.618184] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 
14 15) *0, disabled.
[   23.618407] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 
12 14 15)
[   23.618628] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11 12 
14 15)
[   23.618928] ACPI: Power Resource [FN00] (off)
[   23.619022] Linux Plug and Play Support v0.97 (c) Adam Belay
[   23.619089] pnp: PnP ACPI init
[   23.619105] ACPI: bus type pnp registered
[   23.639929] pnp: PnP ACPI: found 13 devices
[   23.639938] ACPI: ACPI bus type pnp unregistered
[   23.640389] PCI: Using ACPI for IRQ routing
[   23.640397] PCI: If a device doesn't work, try "pci=routeirq".  If 
it helps, post a report
[   23.661637] PCI-GART: No AMD northbridge found.
[   23.661650] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   23.661661] hpet0: 3 64-bit timers, 14318180 Hz
[   23.662748] ACPI: RTC can wake from S4
[   23.664947] Time: hpet clocksource has been installed.
[   23.664973] Switched to high resolution mode on CPU 0
[   23.665604] Switched to high resolution mode on CPU 1
[   23.673990] system 00:01: iomem range 0xe0000000-0xefffffff could 
not be reserved
[   23.674002] system 00:01: iomem range 0xfed14000-0xfed17fff could 
not be reserved
[   23.674013] system 00:01: iomem range 0xfed18000-0xfed18fff could 
not be reserved
[   23.674023] system 00:01: iomem range 0xfed19000-0xfed19fff could 
not be reserved
[   23.674033] system 00:01: iomem range 0xfed1c000-0xfed1ffff could 
not be reserved
[   23.674043] system 00:01: iomem range 0xfed20000-0xfed3ffff could 
not be reserved
[   23.674053] system 00:01: iomem range 0xfed45000-0xfed8ffff could 
not be reserved
[   23.674072] system 00:06: ioport range 0x400-0x401 has been 
reserved
[   23.674080] system 00:06: ioport range 0x680-0x69f has been 
reserved
[   23.674088] system 00:06: ioport range 0x800-0x80f has been 
reserved
[   23.674097] system 00:06: ioport range 0x1000-0x107f has been 
reserved
[   23.674105] system 00:06: ioport range 0x1180-0x11bf has been 
reserved
[   23.674113] system 00:06: ioport range 0x1640-0x164f has been 
reserved
[   23.674122] system 00:06: ioport range 0xfe10-0xfe11 has been 
reserved
[   23.674130] system 00:06: ioport range 0xfe00-0xfe00 has been 
reserved
[   23.674949] PCI: Failed to allocate mem resource #6:20000@d2000000 
for 0000:01:00.0
[   23.674960] PCI: Bridge: 0000:00:01.0
[   23.674966]   IO window: 2000-2fff
[   23.674972]   MEM window: d0000000-d1ffffff
[   23.674978]   PREFETCH window: b0000000-bfffffff
[   23.674986] PCI: Bridge: 0000:00:1c.0
[   23.674992]   IO window: 3000-3fff
[   23.675000]   MEM window: cc000000-cdffffff
[   23.675008]   PREFETCH window: c4000000-c5ffffff
[   23.675017] PCI: Bridge: 0000:00:1c.1
[   23.675023]   IO window: 4000-4fff
[   23.675031]   MEM window: c8000000-c9ffffff
[   23.675039]   PREFETCH window: c0000000-c1ffffff
[   23.675047] PCI: Bridge: 0000:00:1c.2
[   23.675054]   IO window: 5000-5fff
[   23.675062]   MEM window: ca000000-cbffffff
[   23.675069]   PREFETCH window: c2000000-c3ffffff
[   23.675078] PCI: Bridge: 0000:00:1c.3
[   23.675084]   IO window: 6000-6fff
[   23.675093]   MEM window: ce000000-cfffffff
[   23.675100]   PREFETCH window: c6000000-c7ffffff
[   23.675120] PCI: Bus 10, cardbus bridge: 0000:09:06.0
[   23.675126]   IO window: 00001400-000014ff
[   23.675134]   IO window: 00001c00-00001cff
[   23.675143]   PREFETCH window: 88000000-8bffffff
[   23.675151]   MEM window: 8c000000-8fffffff
[   23.675159] PCI: Bridge: 0000:00:1e.0
[   23.675163]   IO window: disabled.
[   23.675172]   MEM window: d2000000-d20fffff
[   23.675179]   PREFETCH window: disabled.
[   23.675200] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, 
low) -> IRQ 16
[   23.675212] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   23.675235] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, 
low) -> IRQ 17
[   23.675248] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   23.675269] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, 
low) -> IRQ 16
[   23.675282] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   23.675304] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, 
low) -> IRQ 18
[   23.675317] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   23.675340] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, 
low) -> IRQ 19
[   23.675353] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   23.675364] PCI: Enabling device 0000:00:1e.0 (0004 -> 0006)
[   23.675374] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   23.675390] PCI: Enabling device 0000:09:06.0 (0000 -> 0003)
[   23.675400] ACPI: PCI Interrupt 0000:09:06.0[A] -> GSI 21 (level, 
low) -> IRQ 21
[   23.675489] NET: Registered protocol family 2
[   23.713252] IP route cache hash table entries: 65536 (order: 7, 
524288 bytes)
[   23.714630] TCP established hash table entries: 262144 (order: 10, 
4194304 bytes)
[   23.718036] TCP bind hash table entries: 65536 (order: 8, 1048576 
bytes)
[   23.718899] TCP: Hash tables configured (established 262144 bind 
65536)
[   23.718907] TCP reno registered
[   23.729125] Unpacking initramfs... done
[   24.045819] Freeing initrd memory: 4410k freed
[   24.048746] Simple Boot Flag at 0x36 set to 0x1
[   24.050281] audit: initializing netlink socket (disabled)
[   24.050304] audit(1196522791.756:1): initialized
[   24.050761] Total HugeTLB memory allocated, 0
[   24.050987] VFS: Disk quotas dquot_6.5.1
[   24.051039] Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[   24.051322] Block layer SCSI generic (bsg) driver version 0.4 
loaded (major 254)
[   24.051334] io scheduler noop registered
[   24.051339] io scheduler anticipatory registered
[   24.051346] io scheduler deadline registered
[   24.051377] io scheduler cfq registered (default)
[   32.039690] 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 
01010001
[   32.040568] Boot video device is 0000:01:00.0
[   32.040818] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   32.040840] assign_interrupt_mode Found MSI capability
[   32.040869] Allocate Port Service[0000:00:01.0:pcie00]
[   32.040936] Allocate Port Service[0000:00:01.0:pcie03]
[   32.041039] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   32.041089] assign_interrupt_mode Found MSI capability
[   32.041133] Allocate Port Service[0000:00:1c.0:pcie00]
[   32.041194] Allocate Port Service[0000:00:1c.0:pcie02]
[   32.041254] Allocate Port Service[0000:00:1c.0:pcie03]
[   32.041375] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   32.041425] assign_interrupt_mode Found MSI capability
[   32.041469] Allocate Port Service[0000:00:1c.1:pcie00]
[   32.041531] Allocate Port Service[0000:00:1c.1:pcie02]
[   32.041589] Allocate Port Service[0000:00:1c.1:pcie03]
[   32.041709] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   32.041759] assign_interrupt_mode Found MSI capability
[   32.041803] Allocate Port Service[0000:00:1c.2:pcie00]
[   32.041870] Allocate Port Service[0000:00:1c.2:pcie02]
[   32.041928] Allocate Port Service[0000:00:1c.2:pcie03]
[   32.042044] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   32.042094] assign_interrupt_mode Found MSI capability
[   32.042138] Allocate Port Service[0000:00:1c.3:pcie00]
[   32.042198] Allocate Port Service[0000:00:1c.3:pcie02]
[   32.042260] Allocate Port Service[0000:00:1c.3:pcie03]
[   32.042644] vesafb: framebuffer at 0xb0000000, mapped to 
0xffffc20010980000, using 5742k, total 262144k
[   32.042656] vesafb: mode is 1400x1050x16, linelength=2800, pages=1
[   32.042663] vesafb: scrolling: redraw
[   32.042670] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   32.105682] Console: switching to colour frame buffer device 175x65
[   32.168798] fb0: VESA VGA frame buffer device
[   32.174000] hpet_resources: 0xfed00000 is busy
[   32.174108] Non-volatile memory driver v1.2
[   32.174384] Linux agpgart interface v0.102
[   32.174636] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, 
IRQ sharing disabled
[   32.175340] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   32.176526] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   32.177303] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 
0x60,0x64 irq 1,12
[   32.180444] i8042.c: Detected active multiplexing controller, rev 
1.1.
[   32.182265] serio: i8042 KBD port at 0x60,0x64 irq 1
[   32.182591] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   32.182930] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   32.183250] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   32.183601] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   32.184140] mice: PS/2 mouse device common for all mice
[   32.218255] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input0
[   32.371965] input: PC Speaker as 
/devices/platform/pcspkr/input/input1
[   32.984524] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, 
caps: 0xa04713/0x204000
[   33.016882] input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio4/input/input2
[   33.044408] cpuidle: using governor ladder
[   33.044677] cpuidle: using governor menu
[   33.045048] NET: Registered protocol family 1
[   33.045459] registered taskstats version 1
[   33.045921] Freeing unused kernel memory: 324k freed
[   33.104612] ACPI: SSDT 7FE9238A, 01A8 (r1  PmRef  Cpu0Ist     3000 
INTL 20050624)
[   33.105211] Parsing all Control Methods:
[   33.105727] Table [SSDT](id 00A1) - 5 Objects with 0 Devices 3 
Methods 0 Regions
[   33.106777] ACPI: SSDT 7FE9212D, 01D8 (r1  PmRef  Cpu0Cst     3001 
INTL 20050624)
[   33.107299] Parsing all Control Methods:
[   33.107805] Table [SSDT](id 00A2) - 1 Objects with 0 Devices 1 
Methods 0 Regions
[   33.109013] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   33.109426] ACPI: Processor [CPU0] (supports 8 throttling states)
[   33.110414] ACPI: SSDT 7FE92532, 0089 (r1  PmRef  Cpu1Ist     3000 
INTL 20050624)
[   33.110969] Parsing all Control Methods:
[   33.111484] Table [SSDT](id 00A7) - 3 Objects with 0 Devices 3 
Methods 0 Regions
[   33.112169] ACPI: SSDT 7FE92305, 0085 (r1  PmRef  Cpu1Cst     3000 
INTL 20050624)
[   33.112692] Parsing all Control Methods:
[   33.113204] Table [SSDT](id 00A8) - 1 Objects with 0 Devices 1 
Methods 0 Regions
[   33.114515] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   33.128091] ACPI: Processor [CPU1] (supports 8 throttling states)
[   33.147482] ACPI: Invalid passive threshold
[   33.161510] ACPI: Thermal Zone [TZ00] (50 C)
[   33.175878] ACPI: Thermal Zone [TZ01] (50 C)
[   33.202237] SCSI subsystem initialized
[   33.224626] libata version 3.00 loaded.
[   33.233180] ahci 0000:00:1f.2: version 3.0
[   33.233216] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, 
low) -> IRQ 19
[   33.248924] ahci 0000:00:1f.2: nr_ports (4) and implemented port 
map (0x5) don't match, using nr_ports
[   33.264374] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
[   33.284351] Clocksource tsc unstable (delta = -493461334 ns)
[   33.302440] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 
Gbps 0xf impl RAID mode
[   33.318831] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum 
part 
[   33.335341] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   33.335703] scsi0 : ahci
[   33.352555] scsi1 : ahci
[   33.369279] scsi2 : ahci
[   33.386025] scsi3 : ahci
[   33.402883] ata1: SATA max UDMA/133 abar m1024@0xd2304400 port 
0xd2304500 irq 4346
[   33.420139] ata2: SATA max UDMA/133 abar m1024@0xd2304400 port 
0xd2304580 irq 4346
[   33.437381] ata3: SATA max UDMA/133 abar m1024@0xd2304400 port 
0xd2304600 irq 4346
[   33.454493] ata4: SATA max UDMA/133 abar m1024@0xd2304400 port 
0xd2304680 irq 4346
[   33.488880] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.515702] ata1.00: ATA-7: SAMSUNG HM120JI, YF100-10, max UDMA7
[   33.533315] ata1.00: 234441648 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[   33.557351] ata1.00: configured for UDMA/133
[   33.578763] ata2: SATA link down (SStatus 0 SControl 0)
[   33.600141] ata3: SATA link down (SStatus 0 SControl 300)
[   33.621004] ata4: SATA link down (SStatus 0 SControl 0)
[   33.639278] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG 
HM120JI  YF10 PQ: 0 ANSI: 5
[   33.662850] ata_piix 0000:00:1f.1: version 2.12
[   33.662872] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, 
low) -> IRQ 18
[   33.681379] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   33.681494] scsi4 : ata_piix
[   33.699943] scsi5 : ata_piix
[   33.718226] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 
0x1880 irq 14
[   33.736420] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 
0x1888 irq 15
[   33.757197] ata5.01: ATAPI: MATSHITADVD-RAM UJ-85JS, F100, max 
UDMA/33
[   33.776928] ata5.01: configured for UDMA/33
[   33.794528] ata6: port disabled. ignoring.
[   33.795929] scsi 4:0:1:0: CD-ROM            MATSHITA DVD-RAM UJ-
85JS  F100 PQ: 0 ANSI: 5
[   33.823531] ACPI: Fan [FAN0] (off)
[   33.863111] BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
[   34.198789] usbcore: registered new interface driver usbfs
[   34.217208] usbcore: registered new interface driver hub
[   34.240983] usbcore: registered new device driver usb
[   34.259154] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors 
(120034 MB)
[   34.277396] sd 0:0:0:0: [sda] Write Protect is off
[   34.295185] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   34.295229] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   34.295259] USB Universal Host Controller Interface driver v3.0
[   34.331661] ACPI: PCI Interrupt 0000:00:1d.0[A] -> <5>sd 0:0:0:0: 
[sda] 234441648 512-byte hardware sectors (120034 MB)
[   34.331975] sd 0:0:0:0: [sda] Write Protect is off
[   34.331979] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   34.332009] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   34.332013]  sda:GSI 23 (level, low) -> IRQ 23
[   34.412552] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   34.412560] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   34.431588] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 1
[   34.468579] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
[   34.490782] usb usb1: configuration #1 chosen from 1 choice
[   34.513085] hub 1-0:1.0: USB hub found
[   34.531640] hub 1-0:1.0: 2 ports detected
[   34.654447] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, 
low) -> IRQ 23
[   34.673502] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   34.673511] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   34.691687] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned 
bus number 2
[   34.713912] ehci_hcd 0000:00:1d.7: debug port 1
[   34.731788] PCI: cache line size of 32 is not supported by device 
0000:00:1d.7
[   34.731799] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd2304000
[   34.766060] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, 
driver 10 Dec 2004
[   34.784234] usb usb2: configuration #1 chosen from 1 choice
[   34.801670]  sda1<6>hub 2-0:1.0: USB hub found
[   34.801720] hub 2-0:1.0: 8 ports detected
[   34.836304]  sda2 sda3 < sda5 sda6 >
[   34.894098] sd 0:0:0:0: [sda] Attached SCSI disk
[   34.911975] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, 
low) -> IRQ 19
[   34.929589] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   34.929595] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   34.947385] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 3
[   34.965415] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
[   34.983527] usb usb3: configuration #1 chosen from 1 choice
[   35.001358] hub 3-0:1.0: USB hub found
[   35.019039] hub 3-0:1.0: 2 ports detected
[   35.137658] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, 
low) -> IRQ 18
[   35.155209] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   35.155215] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   35.172468] usb 2-6: new high speed USB device using ehci_hcd and 
address 2
[   35.190360] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 4
[   35.208627] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
[   35.227013] usb usb4: configuration #1 chosen from 1 choice
[   35.245218] hub 4-0:1.0: USB hub found
[   35.263561] hub 4-0:1.0: 2 ports detected
[   35.330017] usb 2-6: configuration #1 chosen from 1 choice
[   35.362067] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, 
low) -> IRQ 16
[   35.380704] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   35.380711] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   35.399234] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned 
bus number 5
[   35.418083] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
[   35.436723] usb usb5: configuration #1 chosen from 1 choice
[   35.455447] hub 5-0:1.0: USB hub found
[   35.474109] hub 5-0:1.0: 2 ports detected
[   35.657720] swsusp: Marking nosave pages: 000000000009b000 - 
0000000000100000
[   35.657733] swsusp: Basic memory bitmaps created
[   35.694387] swsusp: Basic memory bitmaps freed
[   35.723147] Attempting manual resume
[   36.491855] kjournald starting.  Commit interval 5 seconds
[   36.492152] EXT3 FS on sda5, internal journal
[   36.492160] EXT3-fs: mounted filesystem with ordered data mode.
[   39.231900] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   39.250469] scsi 4:0:1:0: Attached scsi generic sg1 type 5
[   39.599245] ACPI: AC Adapter [ADP0] (on-line)
[   39.639314] input: Power Button (FF) as 
/devices/virtual/input/input3
[   39.661648] ACPI: Battery Slot [BAT0] (battery absent)
[   39.708445] iTCO_vendor_support: vendor-support=0
[   39.746820] ACPI: Power Button (FF) [PWRF]
[   39.766322] input: Lid Switch as /devices/virtual/input/input4
[   39.792381] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[   39.811391] rtc0: alarms up to one month, y3k
[   39.838777] ACPI: Lid Switch [LID]
[   39.858294] input: Power Button (CM) as 
/devices/virtual/input/input5
[   39.886182] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw 
xa/form2 cdda caddy
[   39.905993] Uniform CD-ROM driver Revision: 3.20
[   39.925525] sr 4:0:1:0: Attached scsi CD-ROM sr0
[   39.951685] ACPI: Power Button (CM) [PWRB]
[   39.971642] input: Sleep Button (CM) as 
/devices/virtual/input/input6
[   39.991432] NET: Registered protocol family 23
[   40.021731] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, 
low) -> IRQ 16
[   40.041493] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   40.042428] sky2 0000:02:00.0: v1.20 addr 0xcc000000 irq 16 Yukon-
EC Ultra (0xb4) rev 3
[   40.063673] sky2 eth0: addr 00:a0:d1:a1:41:72
[   40.093072] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-
2007)
[   40.113453] iTCO_wdt: Found a ICH7-M DH TCO device (Version=2, 
TCOBASE=0x1060)
[   40.133806] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   40.159297] parport_pc 00:0a: reported by Plug and Play ACPI
[   40.179465] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   40.206590] ACPI: Sleep Button (CM) [SLPB]
[   40.227306] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, 
low) -> IRQ 19
[   40.266954] ACPI: PCI Interrupt 0000:09:06.1[B] -> GSI 20 (level, 
low) -> IRQ 20
[   40.287256] PCI: Setting latency timer of device 0000:09:06.1 to 64
[   40.339174] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=
[d2005800-d2005fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   40.363158] PCI: Enabling device 0000:09:06.2 (0000 -> 0002)
[   40.384559] ACPI: PCI Interrupt 0000:09:06.2[A] -> GSI 21 (level, 
low) -> IRQ 21
[   40.405868] PCI: Setting latency timer of device 0000:09:06.2 to 64
[   40.412186] intel_rng: FWH not detected
[   40.438375] sdhci: Secure Digital Host Controller Interface driver
[   40.459613] sdhci: Copyright(c) Pierre Ossman
[   40.481038] sdhci: SDHCI controller found at 0000:09:06.3 [104c:
803c] (rev 0)
[   40.518390] PCI: Enabling device 0000:09:06.3 (0000 -> 0002)
[   40.539598] ACPI: PCI Interrupt 0000:09:06.3[A] -> GSI 21 (level, 
low) -> IRQ 21
[   40.561207] found SMC SuperIO Chip (devid=0x7a rev=01 base=0x004e): 
LPC47N227
[   40.583591] smsc_superio_flat(): IrDA not enabled
[   40.583988] PCI: Setting latency timer of device 0000:09:06.3 to 64
[   40.584749] mmc0: SDHCI at 0xd2006000 irq 21 DMA
[   40.626131] smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, 
irq: 0, mode: 0x02
[   40.650718] Yenta: CardBus bridge found at 0000:09:06.0 [1025:006c]
[   40.672208] Yenta: Enabling burst memory read transactions
[   40.694147] Yenta: Using CSCINT to route CSC interrupts to PCI
[   40.716000] Yenta: Routing CardBus interrupts to PCI
[   40.737851] Yenta TI: socket 0000:09:06.0, mfunc 0x01a61b22, devctl 
0x66
[   40.767585] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, 
low) -> IRQ 22
[   40.790792] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   40.990762] Yenta: ISA IRQ mask 0x0c78, PCI irq 21
[   41.011775] Socket status: 30000006
[   41.032580] Yenta: Raising subordinate bus# of parent bus (#09) 
from #09 to #0d
[   41.033210] ALSA sound/pci/hda/hda_codec.c:2140: hda_codec: model 
'acer' is selected
[   41.075083] pcmcia: parent PCI bridge Memory window: 0xd2000000 - 
0xd20fffff
[   41.853522] nvidia: module license 'NVIDIA' taints kernel.
[   42.131477] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, 
low) -> IRQ 16
[   42.152369] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   42.152545] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  
100.14.19  Wed Sep 12 14:08:38 PDT 2007
[   42.317594] Adding 1052216k swap on /dev/sda6.  Priority:-1 extents:
1 across:1052216k
[   42.604053] device-mapper: uevent: version 1.0.3
[   42.626183] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) 
initialised: dm-devel@redhat.com
[   43.119070] loop: module loaded
[   43.452390] fuse init (API version 7.9)
[   48.299978] IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.
fsnet.co.uk>
[   57.892547] sky2 eth0: enabling interface
[   58.824728] NET: Registered protocol family 17
[   60.878729] sky2 eth0: Link is up at 100 Mbps, full duplex, flow 
control both
[   63.637884] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   63.855577] ip_tables: (C) 2000-2006 Netfilter Core Team
[   63.966739] audit(1196515635.955:2): audit_backlog_limit=320 old=64 
by auid=4294967295 res=1
[   63.971515] audit(1196515635.959:3): audit_pid=2981 old=0 by 
auid=4294967295
[   80.671219] ACPI: EC: non-query interrupt received, switching to 
interrupt mode


dmesg after suspend to ram:
[  115.560694] Syncing filesystems ... done.
[  116.034375] Freezing user space processes ... (elapsed 0.00 
seconds) done.
[  116.034932] Freezing remaining freezable tasks ... (elapsed 0.00 
seconds) done.
[  116.034997] Suspending console(s)
[  116.035106] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  116.035243] sd 0:0:0:0: [sda] Stopping disk
[  116.505352] parport_pc 00:0a: disabled
[  116.505663] serial 00:09: disabled
[  116.505690] ACPI handle has no context!
[  116.505755] ACPI handle has no context!
[  116.505779] ACPI: PCI interrupt for device 0000:09:06.3 disabled
[  116.505786] ACPI handle has no context!
[  116.505926] ACPI handle has no context!
[  116.505941] ACPI: PCI interrupt for device 0000:09:06.2 disabled
[  116.505948] ACPI handle has no context!
[  116.506091] ieee1394: hpsb_bus_reset called while bus reset already 
in progress
[  116.506152] ACPI handle has no context!
[  116.522330] sky2 eth0: disabling interface
[  116.527158] ACPI handle has no context!
[  116.527198] NVRM: RmPowerManagement: 3
[  117.684341] ACPI: PCI interrupt for device 0000:00:1f.1 disabled
[  117.684463] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[  117.684608] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[  117.684639] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[  117.684669] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[  117.684700] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[  117.684904] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[  117.715490] Disabling non-boot CPUs ...
[  117.828746] CPU 1 is now offline
[  117.828751] SMP alternatives: switching to UP code
[  117.831037] CPU1 is down
[  117.831166] Extended CMOS year: 2000
[  117.831722]  hwsleep-0317 [00] enter_sleep_state     : Entering 
sleep state [S3]
[    0.581850] Back to C!
[    0.582193] Extended CMOS year: 2000
[    0.582303] Enabling non-boot CPUs ...
[    0.591885] SMP alternatives: switching to SMP code
[    0.593255] Booting processor 1/2 APIC 0x1
[    0.603694] Initializing CPU#1
[    0.683597] Calibrating delay using timer specific routine.. 
3324.90 BogoMIPS (lpj=6649814)
[    0.683609] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.683612] CPU: L2 cache: 2048K
[    0.683617] CPU 1/1 -> Node 0
[    0.683619] CPU: Physical Processor ID: 0
[    0.683622] CPU: Processor Core ID: 1
[    0.684176] Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz 
stepping 06
[    0.684862] CPU1 is up
[    0.688267] Switched to high resolution mode on CPU 1
[    0.725390] PM: Writing back config space on device 0000:00:01.0 at 
offset f (was 100, writing 1c010b)
[    0.725398] PM: Writing back config space on device 0000:00:01.0 at 
offset a (was f, writing 0)
[    0.725403] PM: Writing back config space on device 0000:00:01.0 at 
offset 9 (was 1fff1, writing bff1b001)
[    0.725408] PM: Writing back config space on device 0000:00:01.0 at 
offset 8 (was fff0, writing d1f0d000)
[    0.725413] PM: Writing back config space on device 0000:00:01.0 at 
offset 7 (was f0, writing 2020)
[    0.725418] PM: Writing back config space on device 0000:00:01.0 at 
offset 3 (was 10000, writing 10010)
[    0.725423] PM: Writing back config space on device 0000:00:01.0 at 
offset 1 (was 100000, writing 100407)
[    0.725437] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.725570] PM: Writing back config space on device 0000:00:1b.0 at 
offset 3 (was 0, writing 10)
[    0.725578] PM: Writing back config space on device 0000:00:1b.0 at 
offset 1 (was 100006, writing 100002)
[    0.725601] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, 
low) -> IRQ 22
[    0.725610] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[    0.725637] PM: Writing back config space on device 0000:00:1c.0 at 
offset f (was 40100, writing 4010b)
[    0.725650] PM: Writing back config space on device 0000:00:1c.0 at 
offset 9 (was 10001, writing c5f1c401)
[    0.725656] PM: Writing back config space on device 0000:00:1c.0 at 
offset 8 (was 0, writing cdf0cc00)
[    0.725662] PM: Writing back config space on device 0000:00:1c.0 at 
offset 7 (was 20000000, writing 20003030)
[    0.725669] PM: Writing back config space on device 0000:00:1c.0 at 
offset 6 (was 0, writing 20200)
[    0.725677] PM: Writing back config space on device 0000:00:1c.0 at 
offset 3 (was 810000, writing 810010)
[    0.725685] PM: Writing back config space on device 0000:00:1c.0 at 
offset 1 (was 100000, writing 100407)
[    0.725718] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.725730] PM: Writing back config space on device 0000:00:1c.1 at 
offset f (was 40200, writing 4020b)
[    0.725742] PM: Writing back config space on device 0000:00:1c.1 at 
offset 9 (was 10001, writing c1f1c001)
[    0.725748] PM: Writing back config space on device 0000:00:1c.1 at 
offset 8 (was 0, writing c9f0c800)
[    0.725755] PM: Writing back config space on device 0000:00:1c.1 at 
offset 7 (was 20000000, writing 4040)
[    0.725764] PM: Writing back config space on device 0000:00:1c.1 at 
offset 3 (was 810000, writing 810010)
[    0.725772] PM: Writing back config space on device 0000:00:1c.1 at 
offset 1 (was 100000, writing 100407)
[    0.725805] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.725817] PM: Writing back config space on device 0000:00:1c.2 at 
offset f (was 40300, writing 4030a)
[    0.725829] PM: Writing back config space on device 0000:00:1c.2 at 
offset 9 (was 10001, writing c3f1c201)
[    0.725835] PM: Writing back config space on device 0000:00:1c.2 at 
offset 8 (was 0, writing cbf0ca00)
[    0.725842] PM: Writing back config space on device 0000:00:1c.2 at 
offset 7 (was 20000000, writing 5050)
[    0.725848] PM: Writing back config space on device 0000:00:1c.2 at 
offset 6 (was 0, writing 60500)
[    0.725857] PM: Writing back config space on device 0000:00:1c.2 at 
offset 3 (was 810000, writing 810010)
[    0.725864] PM: Writing back config space on device 0000:00:1c.2 at 
offset 1 (was 100000, writing 100407)
[    0.725898] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.725909] PM: Writing back config space on device 0000:00:1c.3 at 
offset f (was 40400, writing 4040a)
[    0.725921] PM: Writing back config space on device 0000:00:1c.3 at 
offset 9 (was 10001, writing c7f1c601)
[    0.725928] PM: Writing back config space on device 0000:00:1c.3 at 
offset 8 (was 0, writing cff0ce00)
[    0.725934] PM: Writing back config space on device 0000:00:1c.3 at 
offset 7 (was 20000000, writing 6060)
[    0.725944] PM: Writing back config space on device 0000:00:1c.3 at 
offset 3 (was 810000, writing 810010)
[    0.725951] PM: Writing back config space on device 0000:00:1c.3 at 
offset 1 (was 100000, writing 100407)
[    0.725984] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.725995] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, 
low) -> IRQ 23
[    0.726002] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    0.726049] usb usb1: root hub lost power or was reset
[    0.726072] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, 
low) -> IRQ 19
[    0.726079] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    0.726125] usb usb3: root hub lost power or was reset
[    0.726146] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, 
low) -> IRQ 18
[    0.726153] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    0.726198] usb usb4: root hub lost power or was reset
[    0.726219] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, 
low) -> IRQ 16
[    0.726225] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    0.726271] usb usb5: root hub lost power or was reset
[    0.726400] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, 
low) -> IRQ 23
[    0.726407] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    0.726469] PM: Writing back config space on device 0000:00:1e.0 at 
offset 9 (was 10001, writing 1fff1)
[    0.726478] PM: Writing back config space on device 0000:00:1e.0 at 
offset 8 (was 0, writing d200d200)
[    0.726485] PM: Writing back config space on device 0000:00:1e.0 at 
offset 7 (was 22800000, writing 228000f0)
[    0.726493] PM: Writing back config space on device 0000:00:1e.0 at 
offset 6 (was 20090900, writing 200d0900)
[    0.726508] PM: Writing back config space on device 0000:00:1e.0 at 
offset 1 (was 100004, writing 100006)
[    0.726528] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.726577] PM: Writing back config space on device 0000:00:1f.1 at 
offset f (was 100, writing 1ff)
[    0.726598] PM: Writing back config space on device 0000:00:1f.1 at 
offset 1 (was 2880000, writing 2880005)
[    0.726610] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, 
low) -> IRQ 18
[    0.726617] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[    0.726694] ata6: port disabled. ignoring.
[    0.727974] PM: Writing back config space on device 0000:00:1f.2 at 
offset f (was 200, writing 20a)
[    0.727997] PM: Writing back config space on device 0000:00:1f.2 at 
offset 1 (was 2b00007, writing 2b00407)
[    0.728033] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    0.733167] ata5.01: configured for UDMA/33
[    0.734093] NVRM: RmPowerManagement: 4
[    1.038920] ata2: SATA link down (SStatus 0 SControl 0)
[    1.038996] ata4: SATA link down (SStatus 0 SControl 0)
[    1.039037] ata3: SATA link down (SStatus 0 SControl 300)
[    1.522163] PM: Writing back config space on device 0000:02:00.0 at 
offset f (was 100, writing 10b)
[    1.522189] PM: Writing back config space on device 0000:02:00.0 at 
offset 6 (was 1, writing 3001)
[    1.522198] PM: Writing back config space on device 0000:02:00.0 at 
offset 4 (was 4, writing cc000004)
[    1.522204] PM: Writing back config space on device 0000:02:00.0 at 
offset 3 (was 0, writing 10)
[    1.522213] PM: Writing back config space on device 0000:02:00.0 at 
offset 1 (was 100000, writing 100407)
[    1.522443] sky2 eth0: enabling interface
[    1.525090] PM: Writing back config space on device 0000:07:00.0 at 
offset f (was 100, writing 10a)
[    1.525152] PM: Writing back config space on device 0000:07:00.0 at 
offset 4 (was 0, writing ce000000)
[    1.525164] PM: Writing back config space on device 0000:07:00.0 at 
offset 3 (was 0, writing 10)
[    1.525181] PM: Writing back config space on device 0000:07:00.0 at 
offset 1 (was 100000, writing 100006)
[    1.525241] PM: Writing back config space on device 0000:09:04.0 at 
offset f (was 100, writing 10b)
[    1.525260] PM: Writing back config space on device 0000:09:04.0 at 
offset 4 (was 0, writing d2005000)
[    1.525287] PM: Writing back config space on device 0000:09:06.0 at 
offset f (was 34001ff, writing 5c001ff)
[    1.525293] PM: Writing back config space on device 0000:09:06.0 at 
offset e (was 0, writing 1cfc)
[    1.525298] PM: Writing back config space on device 0000:09:06.0 at 
offset d (was 0, writing 1c00)
[    1.525302] PM: Writing back config space on device 0000:09:06.0 at 
offset c (was 0, writing 14fc)
[    1.525308] PM: Writing back config space on device 0000:09:06.0 at 
offset b (was 0, writing 1400)
[    1.525313] PM: Writing back config space on device 0000:09:06.0 at 
offset a (was 0, writing 8ffff000)
[    1.525318] PM: Writing back config space on device 0000:09:06.0 at 
offset 9 (was 0, writing 8c000000)
[    1.525323] PM: Writing back config space on device 0000:09:06.0 at 
offset 8 (was 0, writing 8bfff000)
[    1.525328] PM: Writing back config space on device 0000:09:06.0 at 
offset 7 (was 0, writing 88000000)
[    1.525333] PM: Writing back config space on device 0000:09:06.0 at 
offset 6 (was 0, writing b00d0a09)
[    1.525340] PM: Writing back config space on device 0000:09:06.0 at 
offset 4 (was 0, writing d2007000)
[    1.525345] PM: Writing back config space on device 0000:09:06.0 at 
offset 3 (was 820000, writing 82a820)
[    1.525352] PM: Writing back config space on device 0000:09:06.0 at 
offset 1 (was 2100000, writing 2100007)
[    1.677925] PM: Writing back config space on device 0000:09:06.1 at 
offset f (was 4020200, writing 402020b)
[    1.677949] PM: Writing back config space on device 0000:09:06.1 at 
offset 5 (was 0, writing d2000000)
[    1.677956] PM: Writing back config space on device 0000:09:06.1 at 
offset 4 (was 0, writing d2005800)
[    1.677963] PM: Writing back config space on device 0000:09:06.1 at 
offset 3 (was 800000, writing 804000)
[    1.677972] PM: Writing back config space on device 0000:09:06.1 at 
offset 1 (was 2100000, writing 2100006)
[    1.728013] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=
[d2005800-d2005fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    1.741825] PM: Writing back config space on device 0000:09:06.2 at 
offset f (was 40701ff, writing 407010b)
[    1.741849] PM: Writing back config space on device 0000:09:06.2 at 
offset 4 (was 0, writing d2004000)
[    1.741855] PM: Writing back config space on device 0000:09:06.2 at 
offset 3 (was 800000, writing 804000)
[    1.741864] PM: Writing back config space on device 0000:09:06.2 at 
offset 1 (was 2100000, writing 2100006)
[    1.741888] ACPI: PCI Interrupt 0000:09:06.2[A] -> GSI 21 (level, 
low) -> IRQ 21
[    1.757797] PM: Writing back config space on device 0000:09:06.3 at 
offset f (was 40701ff, writing 407010b)
[    1.757820] PM: Writing back config space on device 0000:09:06.3 at 
offset 4 (was 0, writing d2006000)
[    1.757826] PM: Writing back config space on device 0000:09:06.3 at 
offset 3 (was 800000, writing 804000)
[    1.757834] PM: Writing back config space on device 0000:09:06.3 at 
offset 1 (was 2100000, writing 2100006)
[    1.757858] ACPI: PCI Interrupt 0000:09:06.3[A] -> GSI 21 (level, 
low) -> IRQ 21
[    1.759176] serial 00:09: activated
[    1.760821] parport_pc 00:0a: activated
[    2.204536] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.216471] ata1.00: configured for UDMA/133
[    2.217848] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors 
(120034 MB)
[    2.217888] sd 0:0:0:0: [sda] Write Protect is off
[    2.217892] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.217961] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.232235] sd 0:0:0:0: [sda] Starting disk
[    2.311647] Restarting tasks ... done.
[    2.440281] usb 2-6: USB disconnect, address 2
[    2.584158] ieee1394: Host added: ID:BUS[0-00:1023]  GUID
[00a0d1a0d1a14172]
[    2.679893] usb 2-6: new high speed USB device using ehci_hcd and 
address 3
[    2.828096] usb 2-6: configuration #1 chosen from 1 choice
[    4.457989] sky2 eth0: Link is up at 100 Mbps, full duplex, flow 
control both


dmesg after suspend to disk
[  127.231046] swsusp: Marking nosave pages: 000000000009b000 - 
0000000000100000
[  127.231061] swsusp: Basic memory bitmaps created
[  127.231064] Syncing filesystems ... done.
[  128.094581] Freezing user space processes ... (elapsed 0.00 
seconds) done.
[  128.095245] Freezing remaining freezable tasks ... (elapsed 0.00 
seconds) done.
[  128.095306] Shrinking memory...  -done (0 pages freed)
[  128.199771] Freed 0 kbytes in 0.10 seconds (0.00 MB/s)
[  128.199773] Suspending console(s)
[  128.199895] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  128.368758] parport_pc 00:0a: disabled
[  128.369056] serial 00:09: disabled
[  128.369080] ACPI handle has no context!
[  128.369144] ACPI handle has no context!
[  128.369167] ACPI: PCI interrupt for device 0000:09:06.3 disabled
[  128.369174] ACPI handle has no context!
[  128.369314] ACPI handle has no context!
[  128.369329] ACPI: PCI interrupt for device 0000:09:06.2 disabled
[  128.369336] ACPI handle has no context!
[  128.369476] ieee1394: hpsb_bus_reset called while bus reset already 
in progress
[  128.369539] ACPI handle has no context!
[  128.385715] sky2 eth0: disabling interface
[  128.390545] ACPI handle has no context!
[  128.390580] NVRM: RmPowerManagement: 3
[  129.789775] ACPI: PCI interrupt for device 0000:00:1f.1 disabled
[  129.789895] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[  129.790165] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[  129.790196] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[  129.790227] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[  129.790257] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[  129.790463] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[  129.850667] Disabling non-boot CPUs ...
[  129.962255] CPU 1 is now offline
[  129.962260] SMP alternatives: switching to UP code
[  129.964571] CPU1 is down
[  129.964703] Extended CMOS year: 2000
[  129.964807] swsusp: critical section: 
[  130.101859] swsusp: Need to copy 125356 pages
[   55.457320] evxfevnt-0079 [00] enable                : System is 
already in ACPI mode
[   55.457662] Extended CMOS year: 2000
[   55.457772] Enabling non-boot CPUs ...
[   55.467326] SMP alternatives: switching to SMP code
[   55.468697] Booting processor 1/2 APIC 0x1
[   55.479127] Initializing CPU#1
[   55.559036] Calibrating delay using timer specific routine.. 
3324.98 BogoMIPS (lpj=6649971)
[   55.559047] CPU: L1 I cache: 32K, L1 D cache: 32K
[   55.559051] CPU: L2 cache: 2048K
[   55.559055] CPU 1/1 -> Node 0
[   55.559058] CPU: Physical Processor ID: 0
[   55.559060] CPU: Processor Core ID: 1
[   55.559614] Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz 
stepping 06
[   55.560274] CPU1 is up
[   55.560280] evxfevnt-0079 [00] enable                : System is 
already in ACPI mode
[   55.573855] Switched to high resolution mode on CPU 1
[   56.031989] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   56.046311] PM: Writing back config space on device 0000:00:1b.0 at 
offset 1 (was 100006, writing 100002)
[   56.046334] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, 
low) -> IRQ 22
[   56.046343] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   56.046379] PM: Writing back config space on device 0000:00:1c.0 at 
offset 7 (was 3030, writing 20003030)
[   56.046419] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   56.046477] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   56.046532] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   56.046588] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   56.046599] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, 
low) -> IRQ 23
[   56.046606] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   56.046655] usb usb1: root hub lost power or was reset
[   56.046677] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, 
low) -> IRQ 19
[   56.046684] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   56.046731] usb usb2: root hub lost power or was reset
[   56.046751] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, 
low) -> IRQ 18
[   56.046757] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   56.046804] usb usb3: root hub lost power or was reset
[   56.046827] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, 
low) -> IRQ 16
[   56.046834] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   56.046884] usb usb4: root hub lost power or was reset
[   56.062254] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, 
low) -> IRQ 23
[   56.062261] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   56.062300] usb usb5: root hub lost power or was reset
[   56.066172] ehci_hcd 0000:00:1d.7: debug port 1
[   56.066179] PCI: cache line size of 32 is not supported by device 
0000:00:1d.7
[   56.066203] PM: Writing back config space on device 0000:00:1e.0 at 
offset 6 (was 20090900, writing 200d0900)
[   56.066228] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   56.066295] PM: Writing back config space on device 0000:00:1f.1 at 
offset 1 (was 2880001, writing 2880005)
[   56.066307] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, 
low) -> IRQ 18
[   56.066313] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   56.066362] PM: Writing back config space on device 0000:00:1f.2 at 
offset 1 (was 2b00403, writing 2b00407)
[   56.066398] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   56.066525] NVRM: RmPowerManagement: 4
[   56.067572] ata6: port disabled. ignoring.
[   56.381749] ata3: SATA link down (SStatus 0 SControl 300)
[   56.381767] ata2: SATA link down (SStatus 0 SControl 0)
[   56.381784] ata4: SATA link down (SStatus 0 SControl 0)
[   56.545487] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   56.557749] ata1.00: configured for UDMA/133
[   56.573484] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors 
(120034 MB)
[   56.573504] sd 0:0:0:0: [sda] Write Protect is off
[   56.573508] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   56.573539] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   56.729748] ata5.01: configured for UDMA/33
[   57.923360] PM: Writing back config space on device 0000:02:00.0 at 
offset 1 (was 100007, writing 100407)
[   57.923592] sky2 eth0: enabling interface
[   57.926442] PM: Writing back config space on device 0000:09:06.0 at 
offset f (was 34001ff, writing 5c001ff)
[   57.926464] PM: Writing back config space on device 0000:09:06.0 at 
offset 3 (was 823100, writing 82a820)
[   58.079078] PM: Writing back config space on device 0000:09:06.1 at 
offset 3 (was 800000, writing 804000)
[   58.129053] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=
[d2005800-d2005fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   58.142981] PM: Writing back config space on device 0000:09:06.2 at 
offset 3 (was 800000, writing 804000)
[   58.142988] PM: Writing back config space on device 0000:09:06.2 at 
offset 1 (was 2100000, writing 2100006)
[   58.143009] ACPI: PCI Interrupt 0000:09:06.2[A] -> GSI 21 (level, 
low) -> IRQ 21
[   58.158944] PM: Writing back config space on device 0000:09:06.3 at 
offset 3 (was 800000, writing 804000)
[   58.158951] PM: Writing back config space on device 0000:09:06.3 at 
offset 1 (was 2100000, writing 2100006)
[   58.158967] ACPI: PCI Interrupt 0000:09:06.3[A] -> GSI 21 (level, 
low) -> IRQ 21
[   58.159656] serial 00:09: activated
[   58.160705] parport_pc 00:0a: activated
[   58.733362] sd 0:0:0:0: [sda] Starting disk
[   59.671044] Restarting tasks ... done.
[   59.704359] swsusp: Basic memory bitmaps freed
[   59.865406] usb 5-6: USB disconnect, address 2
[   59.977050] usb 5-6: new high speed USB device using ehci_hcd and 
address 3
[   60.005109] ieee1394: Host added: ID:BUS[0-00:1023]  GUID
[00a0d1a0d1a14172]
[   60.125127] usb 5-6: configuration #1 chosen from 1 choice
[   61.740221] sky2 eth0: Link is up at 100 Mbps, full duplex, flow 
control both
[   64.660255] ACPI: EC: non-query interrupt received, switching to 
interrupt mode
