From: Michael Doube <michael@doube.net>
Subject: acpi_apic_instance=2
Date: Tue, 04 Dec 2007 17:59:23 +0000
Message-ID: <4755957B.2040607@doube.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060609000502060704080206"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:36326 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXLDR7e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Dec 2007 12:59:34 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1275838mue
        for <linux-acpi@vger.kernel.org>; Tue, 04 Dec 2007 09:59:30 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060609000502060704080206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I saw this in my dmesg and tried it:

[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org

And software (RAM) suspend seems to work a bit better.  I'll test it 
some more and let you know.  At least, nothing overtly bad has happened 
since I set acpi_apic_instance=2.

The machine is a Sony Vaio SZ650N, and I'm keen to get everything going 
on it so let me know if I can help in any way.

Major problem at the moment is that screen brightness control does not work.

Cheers

Mike

--------------060609000502060704080206
Content-Type: text/plain;
 name="dmesg_apic_option.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_apic_option.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@crested) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 21:45:15 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] Command line: root=UUID=ebb0a92b-3d24-4178-9275-b99817c75602 ro quiet splash acpi_apic_instance=2
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
[    0.000000] ACPI: Shall use APIC/MADT table 2
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 521904) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F76D0 checksum 0
[    0.000000] ACPI: RSDP 000F76D0, 0024 (r2 PTLTD )
[    0.000000] ACPI: XSDT 7F6BEDBC, 0094 (r1   Sony     VAIO 20070905 PTL         0)
[    0.000000] ACPI: FACP 7F6C7BD2, 00F4 (r3   Sony     VAIO 20070905 PTL         1)
[    0.000000] ACPI: DSDT 7F6C041A, 7744 (r2   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: FACS 7F6CAFC0, 0040
[    0.000000] ACPI: APIC 7F6C7CC6, 0068 (r1   Sony     VAIO 20070905 PTL        5A)
[    0.000000] ACPI: HPET 7F6C7D2E, 0038 (r1   Sony     VAIO 20070905 PTL        5A)
[    0.000000] ACPI: MCFG 7F6C7D66, 003C (r1   Sony     VAIO 20070905 PTL        5A)
[    0.000000] ACPI: TCPA 7F6C7DA2, 0032 (r1   Sony     VAIO 20070905 PTL      5A52)
[    0.000000] ACPI: TMOR 7F6C7DD4, 0026 (r1   Sony     VAIO 20070905 PTL         3)
[    0.000000] ACPI: SLIC 7F6C7DFA, 0176 (r1   Sony     VAIO 20070905 PTL   1000000)
[    0.000000] ACPI: APIC 7F6C7F70, 0068 (r1   Sony     VAIO 20070905 PTL         0)
[    0.000000] ACPI: BOOT 7F6C7FD8, 0028 (r1   Sony     VAIO 20070905 PTL         1)
[    0.000000] ACPI: SSDT 7F6C013D, 02DD (r1   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6C001B, 0122 (r1   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BF3DC, 025F (r1   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BF336, 00A6 (r1   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: SSDT 7F6BEE50, 04E6 (r1   Sony     VAIO 20070905 PTL  20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 2
[    0.000000] ACPI: If "acpi_apic_instance=0" works better, notify linux-acpi@vger.kernel.org
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
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
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
[    0.000000] Kernel command line: root=UUID=ebb0a92b-3d24-4178-9275-b99817c75602 ro quiet splash acpi_apic_instance=2
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[   17.044341] time.c: Detected 2194.504 MHz processor.
[   17.045682] Console: colour VGA+ 80x25
[   17.045699] Checking aperture...
[   17.045711] Calgary: detecting Calgary via BIOS EBDA area
[   17.045713] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[   17.064634] Memory: 2046252k/2087616k available (2274k kernel code, 40976k reserved, 1181k data, 296k init)
[   17.064674] SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   17.142638] Calibrating delay using timer specific routine.. 4393.42 BogoMIPS (lpj=8786843)
[   17.142667] Security Framework v1.0.0 initialized
[   17.142673] SELinux:  Disabled at boot.
[   17.142829] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   17.144035] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   17.144615] Mount-cache hash table entries: 256
[   17.144736] CPU: L1 I cache: 32K, L1 D cache: 32K
[   17.144739] CPU: L2 cache: 4096K
[   17.144742] CPU 0/0 -> Node 0
[   17.144743] using mwait in idle threads.
[   17.144745] CPU: Physical Processor ID: 0
[   17.144746] CPU: Processor Core ID: 0
[   17.144752] CPU0: Thermal monitoring enabled (TM2)
[   17.144760] SMP alternatives: switching to UP code
[   17.144996] Early unpacking initramfs... done
[   17.438502] ACPI: Core revision 20070126
[   17.438547] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   17.489408] Using local APIC timer interrupts.
[   17.534919] result 12468771
[   17.534920] Detected 12.468 MHz APIC timer.
[   17.538152] SMP alternatives: switching to SMP code
[   17.538232] Booting processor 1/2 APIC 0x1
[   17.548701] Initializing CPU#1
[   17.625990] Calibrating delay using timer specific routine.. 4389.07 BogoMIPS (lpj=8778148)
[   17.625997] CPU: L1 I cache: 32K, L1 D cache: 32K
[   17.625999] CPU: L2 cache: 4096K
[   17.626001] CPU 1/1 -> Node 0
[   17.626002] CPU: Physical Processor ID: 0
[   17.626003] CPU: Processor Core ID: 1
[   17.626008] CPU1: Thermal monitoring enabled (TM2)
[   17.626459] Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz stepping 0b
[   17.629999] Brought up 2 CPUs
[   17.716542] migration_cost=16
[   17.716694] NET: Registered protocol family 16
[   17.716762] ACPI: bus type pci registered
[   17.716768] PCI: Using configuration type 1
[   17.717799] ACPI: EC: Look up EC in DSDT
[   17.718362] ACPI: EC: GPE=0x17, ports=0x66, 0x62
[   17.719525] ACPI: System BIOS is requesting _OSI(Linux)
[   17.719527] ACPI: Please test with "acpi_osi=!Linux"
[   17.719528] Please send dmidecode to linux-acpi@vger.kernel.org
[   17.721696] ACPI: Interpreter enabled
[   17.721699] ACPI: (supports S0 S3 S4 S5)
[   17.721713] ACPI: Using IOAPIC for interrupt routing
[   17.737118] ACPI: EC: GPE=0x17, ports=0x66, 0x62
[   17.737151] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   17.737161] PCI: Probing PCI hardware (bus 00)
[   17.739696] PCI: Transparent bridge - 0000:00:1e.0
[   17.739851] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   17.740194] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[   17.740320] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[   17.740435] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[   17.740553] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[   17.740685] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   17.747749] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   17.747840] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   17.747930] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   17.748020] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   17.748110] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   17.748200] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   17.748290] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   17.748383] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   17.748476] Linux Plug and Play Support v0.97 (c) Adam Belay
[   17.748484] pnp: PnP ACPI init
[   17.748492] ACPI: bus type pnp registered
[   17.756798] pnp: PnP ACPI: found 12 devices
[   17.756800] ACPI: ACPI bus type pnp unregistered
[   17.756841] PCI: Using ACPI for IRQ routing
[   17.756843] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   17.756992] NET: Registered protocol family 8
[   17.756994] NET: Registered protocol family 20
[   17.757007] PCI-GART: No AMD northbridge found.
[   17.757012] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   17.757016] hpet0: 3 64-bit timers, 14318180 Hz
[   17.758074] pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[   17.758077] pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
[   17.758079] pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
[   17.758082] pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
[   17.758325] PCI: Bridge: 0000:00:1c.0
[   17.758328]   IO window: 2000-2fff
[   17.758334]   MEM window: f6000000-f7ffffff
[   17.758339]   PREFETCH window: f0000000-f1ffffff
[   17.758345] PCI: Bridge: 0000:00:1c.1
[   17.758348]   IO window: 3000-3fff
[   17.758354]   MEM window: f8000000-f9ffffff
[   17.758359]   PREFETCH window: f2000000-f3ffffff
[   17.758366] PCI: Bridge: 0000:00:1c.2
[   17.758369]   IO window: 4000-4fff
[   17.758375]   MEM window: fa000000-fbffffff
[   17.758379]   PREFETCH window: f4000000-f5ffffff
[   17.758385] PCI: Bridge: 0000:00:1c.3
[   17.758388]   IO window: 5000-5fff
[   17.758394]   MEM window: c8000000-c9ffffff
[   17.758399]   PREFETCH window: cc000000-cdffffff
[   17.758407] PCI: Bus 10, cardbus bridge: 0000:09:04.0
[   17.758408]   IO window: 00006000-000060ff
[   17.758414]   IO window: 00006400-000064ff
[   17.758419]   PREFETCH window: 88000000-8bffffff
[   17.758424]   MEM window: 90000000-93ffffff
[   17.758429] PCI: Bridge: 0000:00:1e.0
[   17.758432]   IO window: 6000-6fff
[   17.758438]   MEM window: fc200000-fc2fffff
[   17.758443]   PREFETCH window: 88000000-8bffffff
[   17.758472] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   17.758479] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   17.758503] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[   17.758509] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   17.758533] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   17.758538] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   17.758563] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   17.758568] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   17.758583] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   17.758601] ACPI: PCI Interrupt 0000:09:04.0[A] -> GSI 20 (level, low) -> IRQ 20
[   17.758613] NET: Registered protocol family 2
[   17.761811] Time: hpet clocksource has been installed.
[   17.797825] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   17.798381] TCP established hash table entries: 262144 (order: 10, 6291456 bytes)
[   17.800994] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   17.801579] TCP: Hash tables configured (established 262144 bind 65536)
[   17.801582] TCP reno registered
[   17.809890] checking if image is initramfs... it is
[   18.438372] Freeing initrd memory: 7738k freed
[   18.441794] Simple Boot Flag at 0x36 set to 0x80
[   18.442272] audit: initializing netlink socket (disabled)
[   18.442290] audit(1196786792.356:1): initialized
[   18.443946] VFS: Disk quotas dquot_6.5.1
[   18.443986] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   18.444060] io scheduler noop registered
[   18.444062] io scheduler anticipatory registered
[   18.444063] io scheduler deadline registered
[   18.444138] io scheduler cfq registered (default)
[   18.444154] Boot video device is 0000:00:02.0
[   18.447856] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   18.447919] assign_interrupt_mode Found MSI capability
[   18.447922] Allocate Port Service[0000:00:1c.0:pcie00]
[   18.447951] Allocate Port Service[0000:00:1c.0:pcie02]
[   18.448050] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   18.448112] assign_interrupt_mode Found MSI capability
[   18.448113] Allocate Port Service[0000:00:1c.1:pcie00]
[   18.448136] Allocate Port Service[0000:00:1c.1:pcie02]
[   18.448232] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   18.448293] assign_interrupt_mode Found MSI capability
[   18.448295] Allocate Port Service[0000:00:1c.2:pcie00]
[   18.448319] Allocate Port Service[0000:00:1c.2:pcie02]
[   18.448415] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   18.448476] assign_interrupt_mode Found MSI capability
[   18.448478] Allocate Port Service[0000:00:1c.3:pcie00]
[   18.448502] Allocate Port Service[0000:00:1c.3:pcie02]
[   18.464947] Real Time Clock Driver v1.12ac
[   18.465465] hpet_resources: 0xfed00000 is busy
[   18.465487] Linux agpgart interface v0.102 (c) Dave Jones
[   18.465489] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   18.466320] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   18.466423] input: Macintosh mouse button emulation as /class/input/input0
[   18.466484] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   18.469015] serio: i8042 KBD port at 0x60,0x64 irq 1
[   18.469018] serio: i8042 AUX port at 0x60,0x64 irq 12
[   18.469143] mice: PS/2 mouse device common for all mice
[   18.469244] TCP cubic registered
[   18.469297] NET: Registered protocol family 1
[   18.469464] /build/buildd/linux-source-2.6.22-2.6.22/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   18.469470] Freeing unused kernel memory: 296k freed
[   18.492872] input: AT Translated Set 2 keyboard as /class/input/input1
[   19.611938] AppArmor: AppArmor initialized<5>audit(1196786793.528:2):  type=1505 info="AppArmor initialized" pid=1277
[   19.616708] fuse init (API version 7.8)
[   19.619629] Failure registering capabilities with primary security module.
[   19.656675] ACPI: SSDT 7F6BFCD9, 027A (r1   Sony     VAIO 20070905 PTL  20050624)
[   19.656863] ACPI: SSDT 7F6BF63B, 0619 (r1   Sony     VAIO 20070905 PTL  20050624)
[   19.658972] Monitor-Mwait will be used to enter C-1 state
[   19.658975] Monitor-Mwait will be used to enter C-2 state
[   19.658978] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   19.658982] ACPI: Processor [CPU0] (supports 8 throttling states)
[   19.659183] ACPI: SSDT 7F6BFF53, 00C8 (r1   Sony     VAIO 20070905 PTL  20050624)
[   19.659357] ACPI: SSDT 7F6BFC54, 0085 (r1   Sony     VAIO 20070905 PTL  20050624)
[   19.661510] ACPI: CPU1 (power states: C1[C1] C2[C2])
[   19.661513] ACPI: Processor [CPU1] (supports 8 throttling states)
[   19.669151] ACPI: Thermal Zone [ATF0] (56 C)
[   19.669860] ACPI: Thermal Zone [DTS0] (55 C)
[   19.670578] ACPI: Thermal Zone [DTS1] (57 C)
[   20.004957] usbcore: registered new interface driver usbfs
[   20.004979] usbcore: registered new interface driver hub
[   20.004998] usbcore: registered new device driver usb
[   20.005552] USB Universal Host Controller Interface driver v3.0
[   20.005631] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
[   20.005642] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   20.005645] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   20.005769] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   20.005801] uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001820
[   20.005888] usb usb1: configuration #1 chosen from 1 choice
[   20.005907] hub 1-0:1.0: USB hub found
[   20.005911] hub 1-0:1.0: 2 ports detected
[   20.040512] SCSI subsystem initialized
[   20.046608] libata version 2.21 loaded.
[   20.107007] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 20 (level, low) -> IRQ 20
[   20.107018] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   20.107021] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   20.107131] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[   20.107159] uhci_hcd 0000:00:1a.1: irq 20, io base 0x00001840
[   20.107421] usb usb2: configuration #1 chosen from 1 choice
[   20.107537] hub 2-0:1.0: USB hub found
[   20.107541] hub 2-0:1.0: 2 ports detected
[   20.210851] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 20 (level, low) -> IRQ 20
[   20.211755] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   20.211761] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   20.211981] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 3
[   20.212016] ehci_hcd 0000:00:1a.7: debug port 1
[   20.212023] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   20.212029] ehci_hcd 0000:00:1a.7: irq 20, io mem 0xfc504800
[   20.215925] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   20.216183] usb usb3: configuration #1 chosen from 1 choice
[   20.216297] hub 3-0:1.0: USB hub found
[   20.216302] hub 3-0:1.0: 4 ports detected
[   20.318700] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   20.318712] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   20.318715] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   20.318733] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[   20.318764] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001860
[   20.318837] usb usb4: configuration #1 chosen from 1 choice
[   20.318856] hub 4-0:1.0: USB hub found
[   20.318860] hub 4-0:1.0: 2 ports detected
[   20.422340] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 23 (level, low) -> IRQ 23
[   20.422347] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   20.422350] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   20.422365] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
[   20.422390] uhci_hcd 0000:00:1d.1: irq 23, io base 0x00001880
[   20.422460] usb usb5: configuration #1 chosen from 1 choice
[   20.422478] hub 5-0:1.0: USB hub found
[   20.422482] hub 5-0:1.0: 2 ports detected
[   20.526199] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ 23
[   20.526206] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   20.526210] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   20.526223] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
[   20.526249] uhci_hcd 0000:00:1d.2: irq 23, io base 0x000018a0
[   20.526323] usb usb6: configuration #1 chosen from 1 choice
[   20.526340] hub 6-0:1.0: USB hub found
[   20.526345] hub 6-0:1.0: 2 ports detected
[   20.630159] ahci 0000:00:1f.2: version 2.2
[   20.630182] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ 22
[   20.969558] usb 3-2: new high speed USB device using ehci_hcd and address 3
[   21.104846] usb 3-2: configuration #1 chosen from 1 choice
[   21.468893] usb 1-1: new full speed USB device using uhci_hcd and address 2
[   21.632699] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
[   21.632702] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[   21.632708] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   21.632909] scsi0 : ahci
[   21.632942] scsi1 : ahci
[   21.632967] scsi2 : ahci
[   21.633036] ata1: SATA max UDMA/133 cmd 0xffffc20000ad6100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
[   21.633040] ata2: SATA max UDMA/133 cmd 0xffffc20000ad6180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
[   21.633044] ata3: SATA max UDMA/133 cmd 0xffffc20000ad6200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
[   21.646697] usb 1-1: configuration #1 chosen from 1 choice
[   22.116038] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   22.118321] ata1.00: ATA-7: ST91608220AS, 3.ALE, max UDMA/133
[   22.118324] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   22.119069] ata1.00: configured for UDMA/133
[   22.427623] ata2: SATA link down (SStatus 0 SControl 300)
[   22.739208] ata3: SATA link down (SStatus 0 SControl 300)
[   22.739287] scsi 0:0:0:0: Direct-Access     ATA      ST91608220AS     3.AL PQ: 0 ANSI: 5
[   22.740027] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[   22.740031] ACPI: PCI Interrupt 0000:09:04.1[B] -> GSI 21 (level, low) -> IRQ 21
[   22.740905] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   22.740911] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   22.741348] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
[   22.741382] ehci_hcd 0000:00:1d.7: debug port 1
[   22.741389] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   22.741395] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc504c00
[   22.745283] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   22.745588] usb usb7: configuration #1 chosen from 1 choice
[   22.745723] hub 7-0:1.0: USB hub found
[   22.745728] hub 7-0:1.0: 6 ports detected
[   22.790641] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[fc206000-fc2067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   22.792036] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   22.792045] sd 0:0:0:0: [sda] Write Protect is off
[   22.792047] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   22.792058] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   22.792097] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   22.792103] sd 0:0:0:0: [sda] Write Protect is off
[   22.792105] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   22.792116] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   22.792119]  sda: sda1 sda2 sda3
[   22.796319] sd 0:0:0:0: [sda] Attached SCSI disk
[   22.798589] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   22.847234] ata_piix 0000:00:1f.1: version 2.11
[   22.847253] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   22.847285] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   22.847336] scsi3 : ata_piix
[   22.847372] scsi4 : ata_piix
[   22.847429] ata4: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x0000000000011810 irq 14
[   22.847432] ata5: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x0000000000011818 irq 15
[   23.167090] ata4.00: ATAPI: MATSHITADVD-RAM UJ-852S, 1.01, max UDMA/33
[   23.205478] Attempting manual resume
[   23.205481] swsusp: Resume From Partition 8:2
[   23.205482] PM: Checking swsusp image.
[   23.205989] PM: Resume from disk failed.
[   23.234307] kjournald starting.  Commit interval 5 seconds
[   23.234315] EXT3-fs: mounted filesystem with ordered data mode.
[   23.282496] usb 7-4: new high speed USB device using ehci_hcd and address 2
[   23.338861] ata4.00: configured for UDMA/33
[   23.480390] usb 7-4: configuration #1 chosen from 1 choice
[   23.507511] scsi 3:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-852S  1.01 PQ: 0 ANSI: 5
[   23.507552] scsi 3:0:0:0: Attached scsi generic sg1 type 5
[   23.985574] usb 6-1: new full speed USB device using uhci_hcd and address 2
[   24.057547] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[080046030293d09b]
[   24.196611] usb 6-1: configuration #1 chosen from 1 choice
[   28.609996] ip_tables: (C) 2000-2006 Netfilter Core Team
[   28.636029] Netfilter messages via NETLINK v0.30.
[   28.645485] nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
[   29.953180] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   29.954855] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   30.206886] agpgart: Detected an Intel 965GM Chipset.
[   30.208472] agpgart: Detected 7676K stolen memory.
[   30.221140] agpgart: AGP aperture is 256M @ 0xd0000000
[   30.229278] tpm_inf_pnp 00:09: Found TPM with ID IFX0102
[   30.278847] Yenta: CardBus bridge found at 0000:09:04.0 [104d:9008]
[   30.278872] Yenta: Using CSCINT to route CSC interrupts to PCI
[   30.278874] Yenta: Routing CardBus interrupts to PCI
[   30.278880] Yenta TI: socket 0000:09:04.0, mfunc 0x01a21b22, devctl 0x64
[   30.347843] Bluetooth: Core ver 2.11
[   30.347881] NET: Registered protocol family 31
[   30.347882] Bluetooth: HCI device and connection manager initialized
[   30.347885] Bluetooth: HCI socket layer initialized
[   30.379271] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   30.379275] Uniform CD-ROM driver Revision: 3.20
[   30.379320] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   30.420251] usbcore: registered new interface driver libusual
[   30.509725] Yenta: ISA IRQ mask 0x0cf8, PCI irq 20
[   30.509729] Socket status: 30000006
[   30.509732] Yenta: Raising subordinate bus# of parent bus (#09) from #0a to #0d
[   30.509737] pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
[   30.509739] pcmcia: parent PCI bridge Memory window: 0xfc200000 - 0xfc2fffff
[   30.509742] pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8bffffff
[   30.510026] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[   30.510056] PCI: Setting latency timer of device 0000:07:00.0 to 64
[   30.510975] sky2 0000:07:00.0: v1.18 addr 0xfa000000 irq 18 Yukon-EC Ultra (0xb4) rev 3
[   30.511401] sky2 eth0: addr 00:1a:80:57:41:ac
[   30.511454] ACPI: PCI Interrupt 0000:09:04.2[C] -> GSI 22 (level, low) -> IRQ 22
[   30.524116] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   30.524120] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   30.537030] Bluetooth: HCI USB driver ver 2.9
[   30.549075] usbcore: registered new interface driver hci_usb
[   30.569347] iwl4965: Intel(R) Wireless WiFi Link 4965AGN driver for Linux, 1.1.0
[   30.569351] iwl4965: Copyright(c) 2003-2007 Intel Corporation
[   30.569436] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   30.569446] PCI: Setting latency timer of device 0000:06:00.0 to 64
[   30.570285] iwl4965: Detected Intel Wireless WiFi Link 4965AGN
[   30.603454] input: PS/2 Mouse as /class/input/input2
[   30.611119] Initializing USB Mass Storage driver...
[   30.620021] input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
[   30.621393] scsi5 : SCSI emulation for USB Mass Storage devices
[   30.621481] usb-storage: device found at 2
[   30.621489] usb-storage: waiting for device to settle before scanning
[   30.621492] usbcore: registered new interface driver usb-storage
[   30.621501] USB Mass Storage support registered.
[   30.626346] Linux video capture interface: v2.00
[   30.762513] uvcvideo: Found UVC 1.00 device <unnamed> (05ca:183a)
[   30.762960] usbcore: registered new interface driver uvcvideo
[   30.762963] USB Video Class driver (v0.1.0)
[   30.852034] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[   30.852925] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   30.916450] iwl4965: Tunable channels: 11 802.11bg, 13 802.11a channels
[   30.916605] wmaster0: Selected rate control algorithm 'iwl-4965-rs'
[   32.372639] lp: driver loaded but no devices found
[   32.480458] usbcam: registering driver r5u870 0.10.0
[   32.481224] usbcore: registered new interface driver r5u870
[   32.517075] Adding 449812k swap on /dev/sda2.  Priority:-1 extents:1 across:449812k
[   32.847350] EXT3 FS on sda1, internal journal
[   33.389615] kjournald starting.  Commit interval 5 seconds
[   33.389923] EXT3 FS on sda3, internal journal
[   33.389926] EXT3-fs: mounted filesystem with ordered data mode.
[   33.969872] ACPI: AC Adapter [ACAD] (on-line)
[   34.094841] ACPI: Battery Slot [BAT1] (battery present)
[   34.103749] input: Power Button (CM) as /class/input/input4
[   34.103881] ACPI: Power Button (CM) [PWRB]
[   34.104526] input: Lid Switch as /class/input/input5
[   34.104651] ACPI: Lid Switch [LID0]
[   34.131329] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   34.145284] ACPI: ACPI Dock Station Driver 
[   35.277429] ppdev: user-space parallel port driver
[   35.458526] sky2 eth0: enabling interface
[   35.489453] audit(1196786810.229:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5402 profile="/usr/sbin/cupsd"
[   35.620278] usb-storage: device scan complete
[   35.624419] scsi 5:0:0:0: Direct-Access     Sony     USB   HS-CARD    4.82 PQ: 0 ANSI: 0
[   35.628305] sd 5:0:0:0: [sdb] Attached SCSI removable disk
[   35.628336] sd 5:0:0:0: Attached scsi generic sg2 type 0
[   35.708323] sony-laptop: Sony Programmable IO Control Driver v0.5.
[   35.708503] sony-laptop: detected Type2 model
[   35.722001] input: Sony Vaio Keys as /class/input/input6
[   35.722174] input: Sony Vaio Jogdial as /class/input/input7
[   35.735720] sony-laptop: device allocated minor is 63
[   35.735923] sony-laptop: Sony Notebook Control Driver v0.5.
[   36.972788] vboxdrv: Trying to deactivate the NMI watchdog permanently...
[   36.972797] vboxdrv: Successfully done.
[   37.387047] Failure registering capabilities with primary security module.

--------------060609000502060704080206
Content-Type: application/x-gzip;
 name="dmidecode.txt.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmidecode.txt.tar.gz"

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
--------------060609000502060704080206
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

00:01.0 PCI bridge: Intel Corporation Mobile PM965/GM965/GL960 PCI Express Root Port (rev 0c) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8000000-caffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Contoller #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 1800 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at 1820 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at fc304000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fc300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 00003000-00003fff
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
	I/O behind bridge: 00004000-00004fff
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
	I/O behind bridge: 00005000-00005fff
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
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: c4000000-c5ffffff
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
	Region 4: I/O ports at 1840 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 23
	Region 4: I/O ports at 1860 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 23
	Region 4: I/O ports at 1880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at fc304400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=09, subordinate=0d, sec-latency=32
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: fc000000-fc0fffff
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
	Region 4: I/O ports at 18a0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 22
	Region 0: I/O ports at 18f8 [size=8]
	Region 1: I/O ports at 18cc [size=4]
	Region 2: I/O ports at 18f0 [size=8]
	Region 3: I/O ports at 18c8 [size=4]
	Region 4: I/O ports at 18e0 [size=16]
	Region 5: I/O ports at 18d0 [size=16]
	Capabilities: <access denied>

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at 8c000000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 1c00 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M GS (rev a1) (prog-if 00 [VGA])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ca000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at c8000000 (64-bit, non-prefetchable) [size=32M]
	Region 5: I/O ports at 2000 [size=128]
	Capabilities: <access denied>

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
	Region 2: I/O ports at 5000 [size=256]
	[virtual] Expansion ROM at f4000000 [disabled] [size=128K]
	Capabilities: <access denied>

09:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fc004000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
	Memory window 0: 88000000-8bfff000 (prefetchable)
	Memory window 1: 90000000-93fff000
	I/O window 0: 00007000-000070ff
	I/O window 1: 00007400-000074ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

09:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at fc006000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fc000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

09:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card Reader (SD/MMC/MS/MS PRO/xD)
	Subsystem: Sony Corporation Unknown device 9008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at fc005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>


--------------060609000502060704080206
Content-Type: application/x-gzip;
 name="vaio-vgn-sz650n_dsdt.dsl.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vaio-vgn-sz650n_dsdt.dsl.tar.gz"

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
KDtZ/j+y5ON3AGAEAA==
--------------060609000502060704080206--
