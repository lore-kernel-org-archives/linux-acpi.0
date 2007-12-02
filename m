From: Michael Doube <michael@doube.net>
Subject: dmidecode for Sony Vaio VGN-SZ650NC
Date: Sun, 02 Dec 2007 15:03:29 +0000
Message-ID: <4752C941.90801@doube.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050202060104020203050809"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:33021 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbXLBPDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Dec 2007 10:03:41 -0500
Received: by mu-out-0910.google.com with SMTP id i10so271316mue
        for <linux-acpi@vger.kernel.org>; Sun, 02 Dec 2007 07:03:38 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202060104020203050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I checked out my dmesg and it said that I should send this file to you.
Thought you might like dmesg and lspci as well.

Hope it helps

Mike

--------------050202060104020203050809
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@crested) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 21:45:15 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] Command line: BOOT_IMAGE=/casper/vmlinuz file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.gz quiet splash --
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f6b0000 (usable)
[    0.000000]  BIOS-e820: 000000007f6b0000 - 000000007f6cb000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f6cb000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 521904) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F76E0 checksum 0
[    0.000000] ACPI: RSDP 000F76E0, 0024 (r2 PTLTD )
[    0.000000] ACPI: XSDT 7F6BE7D2, 009C (r1   Sony     VAIO 20070712 PTL         0)
[    0.000000] ACPI: FACP 7F6C7BD2, 00F4 (r3   Sony     VAIO 20070712 PTL         1)
[    0.000000] ACPI: DSDT 7F6C07F3, 736B (r2   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: FACS 7F6CAFC0, 0040
[    0.000000] ACPI: APIC 7F6C7CC6, 0068 (r1   Sony     VAIO 20070712 PTL        5A)
[    0.000000] ACPI: HPET 7F6C7D2E, 0038 (r1   Sony     VAIO 20070712 PTL        5A)
[    0.000000] ACPI: MCFG 7F6C7D66, 003C (r1   Sony     VAIO 20070712 PTL        5A)
[    0.000000] ACPI: TCPA 7F6C7DA2, 0032 (r1   Sony     VAIO 20070712 PTL      5A52)
[    0.000000] ACPI: TMOR 7F6C7DD4, 0026 (r1   Sony     VAIO 20070712 PTL         3)
[    0.000000] ACPI: SLIC 7F6C7DFA, 0176 (r1   Sony     VAIO 20070712 PTL   1000000)
[    0.000000] ACPI: APIC 7F6C7F70, 0068 (r1   Sony     VAIO 20070712 PTL         0)
[    0.000000] ACPI: BOOT 7F6C7FD8, 0028 (r1   Sony     VAIO 20070712 PTL         1)
[    0.000000] ACPI: SSDT 7F6C0132, 06C1 (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BFA24, 070E (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BF902, 0122 (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BEDFA, 025F (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BED54, 00A6 (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BE86E, 04E6 (r1   Sony     VAIO 20070712 PTL  20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007f6b0000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 521904) 1 entries of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000007f6b0000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   521904
[    0.000000] On node 0 totalpages: 521807
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1125 pages reserved
[    0.000000]   DMA zone: 2818 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7079 pages used for memmap
[    0.000000]   DMA32 zone: 510729 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
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
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000e0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34696 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 513547
[    0.000000] Kernel command line: BOOT_IMAGE=/casper/vmlinuz file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.gz quiet splash --
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[   29.566644] time.c: Detected 2194.488 MHz processor.
[   29.567993] Console: colour VGA+ 80x25
[   29.568010] Checking aperture...
[   29.568022] Calgary: detecting Calgary via BIOS EBDA area
[   29.568024] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[   29.587012] Memory: 2046288k/2087616k available (2274k kernel code, 40940k reserved, 1181k data, 296k init)
[   29.587051] SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   29.664947] Calibrating delay using timer specific routine.. 4393.77 BogoMIPS (lpj=8787540)
[   29.664976] Security Framework v1.0.0 initialized
[   29.664983] SELinux:  Disabled at boot.
[   29.665135] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   29.666327] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   29.666887] Mount-cache hash table entries: 256
[   29.667006] CPU: L1 I cache: 32K, L1 D cache: 32K
[   29.667008] CPU: L2 cache: 4096K
[   29.667010] CPU 0/0 -> Node 0
[   29.667012] using mwait in idle threads.
[   29.667013] CPU: Physical Processor ID: 0
[   29.667015] CPU: Processor Core ID: 0
[   29.667020] CPU0: Thermal monitoring enabled (TM2)
[   29.667029] SMP alternatives: switching to UP code
[   29.667263] Early unpacking initramfs... done
[   29.959695] ACPI: Core revision 20070126
[   29.959738] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   30.010629] Using local APIC timer interrupts.
[   30.056139] result 12468680
[   30.056140] Detected 12.468 MHz APIC timer.
[   30.056465] SMP alternatives: switching to SMP code
[   30.056545] Booting processor 1/2 APIC 0x1
[   30.067033] Initializing CPU#1
[   30.144302] Calibrating delay using timer specific routine.. 4389.08 BogoMIPS (lpj=8778165)
[   30.144308] CPU: L1 I cache: 32K, L1 D cache: 32K
[   30.144310] CPU: L2 cache: 4096K
[   30.144312] CPU 1/1 -> Node 0
[   30.144313] CPU: Physical Processor ID: 0
[   30.144314] CPU: Processor Core ID: 1
[   30.144319] CPU1: Thermal monitoring enabled (TM2)
[   30.144770] Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz stepping 0b
[   30.148310] Brought up 2 CPUs
[   30.179474] migration_cost=17
[   30.179624] NET: Registered protocol family 16
[   30.179693] ACPI: bus type pci registered
[   30.179699] PCI: Using configuration type 1
[   30.180724] ACPI: EC: Look up EC in DSDT
[   30.181280] ACPI: EC: GPE=0x17, ports=0x66, 0x62
[   30.182405] ACPI: System BIOS is requesting _OSI(Linux)
[   30.182407] ACPI: Please test with "acpi_osi=!Linux"
[   30.182408] Please send dmidecode to linux-acpi@vger.kernel.org
[   30.183112] ACPI: Interpreter enabled
[   30.183114] ACPI: (supports S0 S3 S4 S5)
[   30.183129] ACPI: Using IOAPIC for interrupt routing
[   30.199415] ACPI: EC: GPE=0x17, ports=0x66, 0x62
[   30.199450] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   30.199460] PCI: Probing PCI hardware (bus 00)
[   30.201982] PCI: Transparent bridge - 0000:00:1e.0
[   30.202137] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   30.202482] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[   30.202608] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[   30.202722] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[   30.202840] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[   30.202972] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   30.209975] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   30.210068] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   30.210159] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   30.210251] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   30.210341] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   30.210432] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   30.210525] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   30.210613] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   30.210707] Linux Plug and Play Support v0.97 (c) Adam Belay
[   30.210716] pnp: PnP ACPI init
[   30.210722] ACPI: bus type pnp registered
[   30.219062] pnp: PnP ACPI: found 12 devices
[   30.219064] ACPI: ACPI bus type pnp unregistered
[   30.219108] PCI: Using ACPI for IRQ routing
[   30.219110] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   30.219257] NET: Registered protocol family 8
[   30.219259] NET: Registered protocol family 20
[   30.219273] PCI-GART: No AMD northbridge found.
[   30.219279] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   30.219282] hpet0: 3 64-bit timers, 14318180 Hz
[   30.220341] pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[   30.220344] pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
[   30.220346] pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
[   30.220348] pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
[   30.220587] PCI: Bridge: 0000:00:1c.0
[   30.220590]   IO window: 2000-2fff
[   30.220596]   MEM window: f6000000-f7ffffff
[   30.220601]   PREFETCH window: f0000000-f1ffffff
[   30.220607] PCI: Bridge: 0000:00:1c.1
[   30.220610]   IO window: 3000-3fff
[   30.220616]   MEM window: f8000000-f9ffffff
[   30.220621]   PREFETCH window: f2000000-f3ffffff
[   30.220627] PCI: Bridge: 0000:00:1c.2
[   30.220630]   IO window: 4000-4fff
[   30.220636]   MEM window: fa000000-fbffffff
[   30.220641]   PREFETCH window: f4000000-f5ffffff
[   30.220647] PCI: Bridge: 0000:00:1c.3
[   30.220650]   IO window: 5000-5fff
[   30.220656]   MEM window: c8000000-c9ffffff
[   30.220661]   PREFETCH window: cc000000-cdffffff
[   30.220668] PCI: Bus 10, cardbus bridge: 0000:09:04.0
[   30.220670]   IO window: 00006000-000060ff
[   30.220675]   IO window: 00006400-000064ff
[   30.220681]   PREFETCH window: 88000000-8bffffff
[   30.220686]   MEM window: 90000000-93ffffff
[   30.220691] PCI: Bridge: 0000:00:1e.0
[   30.220694]   IO window: 6000-6fff
[   30.220700]   MEM window: fc200000-fc2fffff
[   30.220705]   PREFETCH window: 88000000-8bffffff
[   30.220735] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   30.220742] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   30.220766] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[   30.220772] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   30.220796] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   30.220802] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   30.220826] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   30.220832] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   30.220846] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   30.220865] ACPI: PCI Interrupt 0000:09:04.0[A] -> GSI 20 (level, low) -> IRQ 20
[   30.220877] NET: Registered protocol family 2
[   30.224198] Time: hpet clocksource has been installed.
[   30.260209] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   30.260771] TCP established hash table entries: 262144 (order: 10, 6291456 bytes)
[   30.263389] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   30.263975] TCP: Hash tables configured (established 262144 bind 65536)
[   30.263977] TCP reno registered
[   30.272270] checking if image is initramfs... it is
[   30.898036] Freeing initrd memory: 7706k freed
[   30.901461] Simple Boot Flag at 0x36 set to 0x1
[   30.901938] audit: initializing netlink socket (disabled)
[   30.901951] audit(1196468917.296:1): initialized
[   30.903619] VFS: Disk quotas dquot_6.5.1
[   30.903656] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   30.903728] io scheduler noop registered
[   30.903730] io scheduler anticipatory registered
[   30.903732] io scheduler deadline registered
[   30.903807] io scheduler cfq registered (default)
[   30.903823] Boot video device is 0000:00:02.0
[   30.907517] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   30.907579] assign_interrupt_mode Found MSI capability
[   30.907582] Allocate Port Service[0000:00:1c.0:pcie00]
[   30.907612] Allocate Port Service[0000:00:1c.0:pcie02]
[   30.907710] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   30.907771] assign_interrupt_mode Found MSI capability
[   30.907773] Allocate Port Service[0000:00:1c.1:pcie00]
[   30.907796] Allocate Port Service[0000:00:1c.1:pcie02]
[   30.907892] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   30.907953] assign_interrupt_mode Found MSI capability
[   30.907954] Allocate Port Service[0000:00:1c.2:pcie00]
[   30.907980] Allocate Port Service[0000:00:1c.2:pcie02]
[   30.908076] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   30.908137] assign_interrupt_mode Found MSI capability
[   30.908139] Allocate Port Service[0000:00:1c.3:pcie00]
[   30.908163] Allocate Port Service[0000:00:1c.3:pcie02]
[   30.924867] Real Time Clock Driver v1.12ac
[   30.925070] hpet_resources: 0xfed00000 is busy
[   30.925092] Linux agpgart interface v0.102 (c) Dave Jones
[   30.925095] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   30.925922] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   30.926027] input: Macintosh mouse button emulation as /class/input/input0
[   30.926089] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   30.928466] serio: i8042 KBD port at 0x60,0x64 irq 1
[   30.928470] serio: i8042 AUX port at 0x60,0x64 irq 12
[   30.928565] mice: PS/2 mouse device common for all mice
[   30.928668] TCP cubic registered
[   30.928712] NET: Registered protocol family 1
[   30.928875] /build/buildd/linux-source-2.6.22-2.6.22/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   30.928881] Freeing unused kernel memory: 296k freed
[   30.956437] input: AT Translated Set 2 keyboard as /class/input/input1
[   32.070667] AppArmor: AppArmor initialized<5>audit(1196468918.464:2):  type=1505 info="AppArmor initialized" pid=1277
[   32.075471] fuse init (API version 7.8)
[   32.078912] Failure registering capabilities with primary security module.
[   32.107571] ACPI: SSDT 7F6BF5C0, 027A (r1   Sony     VAIO 20070712 PTL  20050624)
[   32.107757] ACPI: SSDT 7F6BF059, 04E2 (r1   Sony     VAIO 20070712 PTL  20050624)
[   32.109868] Monitor-Mwait will be used to enter C-1 state
[   32.109871] Monitor-Mwait will be used to enter C-2 state
[   32.109873] Monitor-Mwait will be used to enter C-3 state
[   32.109876] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   32.109880] ACPI: Processor [CPU0] (supports 8 throttling states)
[   32.110078] ACPI: SSDT 7F6BF83A, 00C8 (r1   Sony     VAIO 20070712 PTL  20050624)
[   32.110250] ACPI: SSDT 7F6BF53B, 0085 (r1   Sony     VAIO 20070712 PTL  20050624)
[   32.112391] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   32.112395] ACPI: Processor [CPU1] (supports 8 throttling states)
[   32.119965] ACPI: Thermal Zone [ATF0] (64 C)
[   32.120643] ACPI: Thermal Zone [DTS0] (61 C)
[   32.121328] ACPI: Thermal Zone [DTS1] (62 C)
[   32.430304] usbcore: registered new interface driver usbfs
[   32.430325] usbcore: registered new interface driver hub
[   32.430345] usbcore: registered new device driver usb
[   32.431077] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 20 (level, low) -> IRQ 20
[   32.432128] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   32.432135] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   32.432263] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[   32.432302] ehci_hcd 0000:00:1a.7: debug port 1
[   32.432308] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   32.432319] ehci_hcd 0000:00:1a.7: irq 20, io mem 0xfc504000
[   32.436216] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   32.436308] usb usb1: configuration #1 chosen from 1 choice
[   32.436328] hub 1-0:1.0: USB hub found
[   32.436335] hub 1-0:1.0: 4 ports detected
[   32.437053] USB Universal Host Controller Interface driver v3.0
[   32.461426] SCSI subsystem initialized
[   32.481166] libata version 2.21 loaded.
[   32.518824] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[   32.519780] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   32.519785] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   32.519831] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[   32.519873] ehci_hcd 0000:00:1d.7: debug port 1
[   32.519880] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   32.519891] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc504400
[   32.523777] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   32.523852] usb usb2: configuration #1 chosen from 1 choice
[   32.523873] hub 2-0:1.0: USB hub found
[   32.523878] hub 2-0:1.0: 6 ports detected
[   32.527294] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
[   32.527303] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   32.527307] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   32.527321] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[   32.527347] uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001820
[   32.527419] usb usb3: configuration #1 chosen from 1 choice
[   32.527437] hub 3-0:1.0: USB hub found
[   32.527442] hub 3-0:1.0: 2 ports detected
[   32.566329] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 20 (level, low) -> IRQ 20
[   32.566342] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   32.566346] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   32.566454] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[   32.566487] uhci_hcd 0000:00:1a.1: irq 20, io base 0x00001840
[   32.566725] usb usb4: configuration #1 chosen from 1 choice
[   32.566832] hub 4-0:1.0: USB hub found
[   32.566836] hub 4-0:1.0: 2 ports detected
[   32.571140] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   32.571149] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   32.571154] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   32.571265] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[   32.571296] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001860
[   32.571544] usb usb5: configuration #1 chosen from 1 choice
[   32.571653] hub 5-0:1.0: USB hub found
[   32.571657] hub 5-0:1.0: 2 ports detected
[   32.575363] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 23 (level, low) -> IRQ 23
[   32.575374] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   32.575378] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   32.575497] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[   32.575528] uhci_hcd 0000:00:1d.1: irq 23, io base 0x00001880
[   32.575796] usb usb6: configuration #1 chosen from 1 choice
[   32.575914] hub 6-0:1.0: USB hub found
[   32.575918] hub 6-0:1.0: 2 ports detected
[   32.578904] usb 1-2: new high speed USB device using ehci_hcd and address 3
[   32.592518] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ 23
[   32.592529] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   32.592535] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   32.592677] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[   32.592702] uhci_hcd 0000:00:1d.2: irq 23, io base 0x000018a0
[   32.592993] usb usb7: configuration #1 chosen from 1 choice
[   32.593125] hub 7-0:1.0: USB hub found
[   32.593130] hub 7-0:1.0: 2 ports detected
[   32.608138] usb 1-2: configuration #1 chosen from 1 choice
[   32.620279] ACPI: PCI Interrupt 0000:09:04.1[B] -> GSI 21 (level, low) -> IRQ 21
[   32.671053] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[fc206000-fc2067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   32.671517] ata_piix 0000:00:1f.1: version 2.11
[   32.671532] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   32.671561] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   32.671665] scsi0 : ata_piix
[   32.671703] scsi1 : ata_piix
[   32.671759] ata1: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x0000000000011810 irq 14
[   32.671762] ata2: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x0000000000011818 irq 15
[   32.704960] usb 3-1: new full speed USB device using uhci_hcd and address 2
[   32.710672] ata1.00: ATAPI: MATSHITADVD-RAM UJ-852S, 1.01, max UDMA/33
[   32.714166] usb 3-1: configuration #1 chosen from 1 choice
[   32.727288] ata1.00: configured for UDMA/33
[   32.757678] scsi 0:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-852S  1.01 PQ: 0 ANSI: 5
[   32.757729] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   32.763982] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ 22
[   32.764009] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   32.764046] scsi2 : ata_piix
[   32.764167] scsi3 : ata_piix
[   32.764242] ata3: SATA max UDMA/133 cmd 0x0000000000011c00 ctl 0x00000000000118f6 bmdma 0x00000000000118e0 irq 22
[   32.764244] ata4: SATA max UDMA/133 cmd 0x00000000000118f8 ctl 0x00000000000118f2 bmdma 0x00000000000118e8 irq 22
[   32.770910] ata3.00: ATA-7: ST91608220AS, 3.ALE, max UDMA/133
[   32.770913] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   32.772637] ata3.00: configured for UDMA/133
[   32.791976] scsi 2:0:0:0: Direct-Access     ATA      ST91608220AS     3.AL PQ: 0 ANSI: 5
[   32.795925] sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   32.795934] sd 2:0:0:0: [sda] Write Protect is off
[   32.795936] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   32.795947] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.795982] sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   32.795989] sd 2:0:0:0: [sda] Write Protect is off
[   32.795990] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   32.796001] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.796003]  sda: sda1 sda2
[   32.797987] sd 2:0:0:0: [sda] Attached SCSI disk
[   32.800127] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   32.800140] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   32.805647] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   32.805650] Uniform CD-ROM driver Revision: 3.20
[   32.805684] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   32.900421] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[080046030293d09b]
[   36.382772] ISO 9660 Extensions: Microsoft Joliet Level 3
[   36.435147] ISO 9660 Extensions: RRIP_1991A
[   36.708436] Registering unionfs 1.4
[   36.708439] unionfs: debugging is not enabled
[   36.713872] loop: module loaded
[   36.977888] squashfs: version 3.2-UBUNTU (2007/07/26) Phillip Lougher
[  112.729597] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  112.882535] agpgart: Detected an Intel 965GM Chipset.
[  112.884190] agpgart: Detected 7676K stolen memory.
[  112.896555] agpgart: AGP aperture is 256M @ 0xd0000000
[  113.136079] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[  114.056077] Yenta: CardBus bridge found at 0000:09:04.0 [104d:9008]
[  114.056099] Yenta: Enabling burst memory read transactions
[  114.056105] Yenta: Using CSCINT to route CSC interrupts to PCI
[  114.056107] Yenta: Routing CardBus interrupts to PCI
[  114.056113] Yenta TI: socket 0000:09:04.0, mfunc 0x01a21b22, devctl 0x64
[  114.287493] Yenta: ISA IRQ mask 0x0cf8, PCI irq 20
[  114.287497] Socket status: 30000006
[  114.287500] Yenta: Raising subordinate bus# of parent bus (#09) from #0a to #0d
[  114.287505] pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
[  114.287509] pcmcia: parent PCI bridge Memory window: 0xfc200000 - 0xfc2fffff
[  114.287511] pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8bffffff
[  114.347371] input: PS/2 Mouse as /class/input/input2
[  114.363038] input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
[  114.597025] tpm_inf_pnp 00:09: Found TPM with ID IFX0102
[  114.743150] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[  114.743180] PCI: Setting latency timer of device 0000:07:00.0 to 64
[  114.744141] sky2 0000:07:00.0: v1.18 addr 0xfa000000 irq 18 Yukon-EC Ultra (0xb4) rev 3
[  114.744530] sky2 eth0: addr 00:1a:80:57:41:ac
[  114.745650] ACPI: PCI Interrupt 0000:09:04.2[C] -> GSI 22 (level, low) -> IRQ 22
[  114.891324] Linux video capture interface: v2.00
[  115.061822] uvcvideo: Found UVC 1.00 device <unnamed> (05ca:183a)
[  115.063444] usbcore: registered new interface driver uvcvideo
[  115.063448] USB Video Class driver (v0.1.0)
[  115.492229] iwl4965: Intel(R) Wireless WiFi Link 4965AGN driver for Linux, 1.1.0
[  115.492232] iwl4965: Copyright(c) 2003-2007 Intel Corporation
[  115.492317] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[  115.492326] PCI: Setting latency timer of device 0000:06:00.0 to 64
[  115.493272] iwl4965: Detected Intel Wireless WiFi Link 4965AGN
[  116.060461] iwl4965: Tunable channels: 11 802.11bg, 13 802.11a channels
[  116.060664] wmaster0: Selected rate control algorithm 'iwl-4965-rs'
[  116.332097] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[  116.333001] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[  120.074277] ACPI: AC Adapter [ACAD] (on-line)
[  120.113137] ACPI: Battery Slot [BAT1] (battery present)
[  120.121961] ACPI: ACPI Dock Station Driver 
[  120.140417] input: Power Button (CM) as /class/input/input4
[  120.140437] ACPI: Power Button (CM) [PWRB]
[  120.140468] input: Lid Switch as /class/input/input5
[  120.140477] ACPI: Lid Switch [LID0]
[  120.224118] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[  126.137886] sky2 eth0: enabling interface
[  126.202177] lp: driver loaded but no devices found
[  126.401880] ppdev: user-space parallel port driver
[  129.197119] sony-laptop: Sony Programmable IO Control Driver v0.5.
[  129.197274] sony-laptop: detected Type2 model
[  129.199176] input: Sony Vaio Keys as /class/input/input6
[  129.199296] input: Sony Vaio Jogdial as /class/input/input7
[  129.211687] sony-laptop: device allocated minor is 63
[  129.212822] sony-laptop: Sony Notebook Control Driver v0.5.
[  129.515638] Failure registering capabilities with primary security module.
[  130.435795] Bluetooth: Core ver 2.11
[  130.435888] NET: Registered protocol family 31
[  130.435892] Bluetooth: HCI device and connection manager initialized
[  130.435899] Bluetooth: HCI socket layer initialized
[  130.499213] Bluetooth: L2CAP ver 2.8
[  130.499221] Bluetooth: L2CAP socket layer initialized
[  130.979275] Bluetooth: RFCOMM socket layer initialized
[  130.979444] Bluetooth: RFCOMM TTY layer initialized
[  130.979450] Bluetooth: RFCOMM ver 1.8
[  140.824858] [drm] Initialized drm 1.1.0 20060810
[  140.867580] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[  140.870246] [drm] Initialized i915 1.6.0 20060119 on minor 0
[  290.427579] JFS: nTxBlock = 8192, nTxLock = 65536
[  290.747543] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[  290.751467] SGI XFS Quota Management subsystem
[  291.106982] program parted_devices is using a deprecated SCSI ioctl, please convert it to SG_IO
[  312.992373] iwl4965: Radio Frequency Kill Switch is On:
[  312.992379] Kill switch must be turned off for wireless networking to work.
[  407.269876] program parted_devices is using a deprecated SCSI ioctl, please convert it to SG_IO
[  647.365724] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  647.544013] QNX4 filesystem 0.2.3 registered.
[  647.622530] cramfs: wrong magic
[  649.975414] Unable to identify CD-ROM format.
[  649.982787] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  650.115810] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  650.394763] cramfs: wrong magic
[  650.434127] Unable to identify CD-ROM format.
[  650.436436] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  650.448608] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  651.772353] cramfs: wrong magic
[  651.805993] Unable to identify CD-ROM format.
[  651.809905] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  651.933731] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  664.090508] program parted_devices is using a deprecated SCSI ioctl, please convert it to SG_IO
[  715.942861] cramfs: wrong magic
[  715.976824] Unable to identify CD-ROM format.
[  715.980389] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  716.039499] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  716.142163] cramfs: wrong magic
[  716.493183] cramfs: wrong magic
[  716.532859] Unable to identify CD-ROM format.
[  716.535168] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  716.549647] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  716.641819] cramfs: wrong magic
[  717.400339] cramfs: wrong magic
[  717.434719] Unable to identify CD-ROM format.
[  717.437867] SQUASHFS error: Can't find a SQUASHFS superblock on sda1
[  717.489557] EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2
[  717.570485] cramfs: wrong magic
[  721.513654] Adding 449812k swap on /dev/sda3.  Priority:-1 extents:1 across:449812k
[  727.665295] kjournald starting.  Commit interval 5 seconds
[  727.666000] EXT3 FS on sda1, internal journal
[  727.666138] EXT3-fs: mounted filesystem with ordered data mode.

--------------050202060104020203050809
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.9
# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 1176 bytes.
Table at 0x7F6CB000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: R0081S5
	Release Date: 07/12/2007
	Address: 0xE5240
	Runtime Size: 110016 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 8.1
	Firmware Revision: 8.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-SZ650N
	Version: J002UR2M
	Serial Number: 28205633-3028891
	UUID: 9C4FAD20-0EBE-11DC-807E-001A805741AC
	Wake-up Type: Power Switch
	SKU Number: N/A                             
	Family: N/A                             

Handle 0x0002, DMI type 2, 9 bytes
Base Board Information
	Manufacturer: Sony Corporation
	Product Name: VAIO                            
	Version: N/A                             
	Serial Number: N/A                             

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Sony Corporation
	Type: Notebook
	Lock: Not Present
	Version: N/A                  
	Serial Number:                                                   
	Asset Tag:                                                   
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: N/A
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: FB 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz
	Voltage: 1.2 V
	External Clock: 200 MHz
	Max Speed: 2200 MHz
	Current Speed: 2200 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: N/A
	Asset Tag: N/A
	Part Number: N/A

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 4096 KB
	Maximum Size: 4096 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCCARD1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Other
	ID: Adapter 0, Socket 1
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0008, DMI type 11, 5 bytes
OEM Strings
	String 1: 0000010012
	String 2: FNC-HDPWCCIA0oke
	String 3: 02VE0000000061BDF8F005D20C05
	String 4: Reserved              
	String 5: Reserved              

Handle 0x0009, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1000 MB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0009
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 0
	Serial Number: 1234-B0
	Asset Tag: Not Specified
	Part Number: SODIMM000

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0009
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 1
	Serial Number: 1234-B1
	Asset Tag: Not Specified
	Part Number: SODIMM001

Handle 0x000C, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0009
	Partition Width: 0

Handle 0x000D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000A
	Memory Array Mapped Address Handle: 0x000C
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000C
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0010, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 10 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0011, DMI type 136, 11 bytes
OEM-specific Type
	Header and Data:
		88 0B 11 00 01 44 49 52 53 03 03
	Strings:
		Sony Corporation

Handle 0x0012, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 12 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x0013, DMI type 127, 4 bytes
End Of Table


--------------050202060104020203050809
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub (rev 0c)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c) (prog-if 00 [VGA])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fc000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 1800 [size=8]
	Capabilities: <access denied>

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Contoller #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 1820 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at 1840 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at fc504000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fc500000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f6000000-f7ffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: 00000000f2000000-00000000f3ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f4000000-00000000f5ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: c8000000-c9ffffff
	Prefetchable memory behind bridge: 00000000cc000000-00000000cdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 1860 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 23
	Region 4: I/O ports at 1880 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 23
	Region 4: I/O ports at 18a0 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at fc504400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=09, subordinate=0d, sec-latency=32
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fc200000-fc2fffff
	Prefetchable memory behind bridge: 0000000088000000-000000008bffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>

00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at 1810 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 22
	Region 0: I/O ports at 1c00 [size=8]
	Region 1: I/O ports at 18f4 [size=4]
	Region 2: I/O ports at 18f8 [size=8]
	Region 3: I/O ports at 18f0 [size=4]
	Region 4: I/O ports at 18e0 [size=16]
	Region 5: I/O ports at 18d0 [size=16]
	Capabilities: <access denied>

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at 8c000000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 1c20 [size=32]

06:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or AGN Network Connection (rev 61)
	Subsystem: Intel Corporation Unknown device 1100
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: <access denied>

07:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8055 PCI-E Gigabit Ethernet Controller (rev 12)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at 4000 [size=256]
	[virtual] Expansion ROM at f4000000 [disabled] [size=128K]
	Capabilities: <access denied>

09:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fc204000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
	Memory window 0: 88000000-8bfff000 (prefetchable)
	Memory window 1: 90000000-93fff000
	I/O window 0: 00006000-000060ff
	I/O window 1: 00006400-000064ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

09:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at fc206000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fc200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

09:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card Reader (SD/MMC/MS/MS PRO/xD)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at fc205000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>


--------------050202060104020203050809--
