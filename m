From: Christian Ruby <ch-ruby@gmx.de>
Subject: HP Pavillion dv6000
Date: Thu, 11 Oct 2007 21:21:26 +0200
Message-ID: <470E77B6.70701@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040807070300010606070602"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752373AbXJKTV3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2007 15:21:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040807070300010606070602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hallo,

ich habe Ubuntu 7.10 am laufen und kontrollierte mit dmesg mal den 
Bootvorgang, dabei  stieß ich auf diesen Abschnitt:

[   14.560001] ACPI: System BIOS is requesting _OSI(Linux)
[   14.560004] ACPI: Please test with "acpi_osi=!Linux"
[   14.560005] Please send dmidecode to linux-acpi@vger.kernel.org

Nun so wie es da steht hab ich acpi_osi=!Linux als Kernelparameter beim 
Booten versucht wie mann sieht leider kein Erfolg.
Also wollte ich euch helfen und schicke euch hiermit die Ausgabe von 
dmidecode als Anlage.

Zum System:

HP Pavillion dv6328eu

Kernel: 2.6.22-14-generic #1 SMP

Hab die dmesg Ausgabe mit angehängt.

Hoffe ich hab das richtig gemacht und helfe euch damit,  wenn Ihr  
weitere Fragen habt könnt Ihr euch per E-mail melden, 
werde euch mit meinen begrenzten Mitteln helfen.

Gruß Christian Ruby, zufriedener Linux-User

--------------040807070300010606070602
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 822 bytes.
Table at 0x000F1C80.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Hewlett-Packard
        Version: F.3A    
        Release Date: 07/19/2007
        Address: 0xE6A30
        Runtime Size: 103888 bytes
        ROM Size: 1024 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                Smart battery is supported
                BIOS boot specification is supported
                Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Hewlett-Packard
        Product Name:                                   
        Version: Rev 1
        Serial Number:           
        UUID: Not Settable
        Wake-up Type: Power Switch
        SKU Number:            
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Quanta
        Product Name: 30B7
        Version: 65.28
        Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: Quanta
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag:                     
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: Unknown
        OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: Socket S1
        Type: Central Processor
        Family: Opteron
        Manufacturer: AMD
        ID: 82 0F 04 00 FF FB 8B 17
        Signature: Family 15, Model 72, Stepping 2
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                MMX (MMX technology supported)
                FXSR (Fast floating-point save and restore)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                HTT (Hyper-threading technology)
        Version: AMD Turion(tm) 64 X2 Mobile TL52
        Voltage: 1.6 V
        External Clock: 200 MHz
        Max Speed: 1600 MHz
        Current Speed: 1600 MHz
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
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Asynchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 1024 KB
        Maximum Size: 1024 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unified
        Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot 1
        Type: 64-bit PCI Express
        Current Usage: Available
        Length: Short
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot 2
        Type: 64-bit PCI Express
        Current Usage: Available
        Length: Short
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported
                Hot-plug devices are supported

Handle 0x0009, DMI type 10, 6 bytes
On Board Device Information
        Type: Video
        Status: Enabled
        Description:  64

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
        String 1: $HP$
        String 2: LOC#       

Handle 0x000B, DMI type 15, 29 bytes
System Event Log
        Area Length: 16 bytes
        Header Start Offset: 0x0000
        Header Length: 16 bytes
        Data Start Offset: 0x0010
        Access Method: General-purpose non-volatile data functions
        Access Address: 0x0000
        Status: Valid, Not Full
        Change Token: 0x000000B1
        Header Format: Type 1
        Supported Log Type Descriptors: 3
        Descriptor 1: POST error
        Data Format 1: POST results bitmap
        Descriptor 2: Single-bit ECC memory error
        Data Format 2: Multiple-event
        Descriptor 3: Multi-bit ECC memory error
        Data Format 3: Multiple-event

Handle 0x000C, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 2 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000C
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: DIMM
        Set: 1
        Locator: DIMM 1
        Bank Locator: Bank 0,1
        Type: DDR2
        Type Detail: Synchronous
        Speed: 667 MHz (1.5 ns)
        Manufacturer: EC00000000000000
        Serial Number: 80219530
        Asset Tag: Not Specified
        Part Number: M4 70T6554EZ3-CE6 

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000C
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: DIMM
        Set: 1
        Locator: DIMM 2
        Bank Locator: Bank 2,3
        Type: DDR2
        Type Detail: Unknown
        Speed: 667 MHz (1.5 ns)
        Manufacturer: EC00000000000000
        Serial Number: 80219561
        Asset Tag: Not Specified
        Part Number: M4 70T6554EZ3-CE6 

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000C
        Partition Width: 0

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x000D
        Memory Array Mapped Address Handle: 0x000F
        Partition Row Position: 2
        Interleave Position: 2
        Interleaved Data Depth: 2

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00020000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x000E
        Memory Array Mapped Address Handle: 0x000F
        Partition Row Position: 2
        Interleave Position: 2
        Interleaved Data Depth: 2

Handle 0x0012, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0013, DMI type 127, 4 bytes
End Of Table


--------------040807070300010606070602
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Linux version 2.6.22-14-generic (buildd@crested) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Wed Oct 10 05:28:36 GMT 2007 (Ubuntu 2.6.22-14.43-generic)
[    0.000000] Command line: root=UUID=578a9856-a643-4dce-80d1-3a46b592e90a ro quiet splash locale=de_DE irqpoll acpi_osi=!Linux
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003bf00000 (usable)
[    0.000000]  BIOS-e820: 000000003bf00000 - 000000003bf15000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003bf15000 - 000000003bf80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003bf80000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 245504) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F88F0 checksum 0
[    0.000000] ACPI: RSDP 000F88F0, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 3BF0BD24, 003C (r1 HPQOEM SLIC-MPC  6040000  LTP        0)
[    0.000000] ACPI: FACP 3BF14D10, 0074 (r1 HP     MCP51M    6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 3BF0BD60, 8FB0 (r1 HP       MCP51M  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 3BF15FC0, 0040
[    0.000000] ACPI: SSDT 3BF14D84, 0182 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: MCFG 3BF14F06, 003C (r1 HP       MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 3BF14F42, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 3BF14F7A, 005E (r1 HP          APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3BF14FD8, 0028 (r1     HP $SBFTBL$  6040000  LTP        1)
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000003bf00000
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 245504) 1 entries of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000003bf00000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      157
[    0.000000]     0:      256 ->   245504
[    0.000000] On node 0 totalpages: 245405
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1125 pages reserved
[    0.000000]   DMA zone: 2816 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3300 pages used for memmap
[    0.000000]   DMA32 zone: 238108 pages, LIFO batch:31
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
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 000000000009d000 - 000000000009e000
[    0.000000] swsusp: Registered nosave memory region: 000000000009e000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000d2000
[    0.000000] swsusp: Registered nosave memory region: 00000000000d2000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34696 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 240924
[    0.000000] Kernel command line: root=UUID=578a9856-a643-4dce-80d1-3a46b592e90a ro quiet splash locale=de_DE irqpoll acpi_osi=!Linux
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] ACPI: Disabled _OSI(Linux)
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[   13.809479] time.c: Detected 1607.315 MHz processor.
[   13.812766] Console: colour VGA+ 80x25
[   13.812786] Checking aperture...
[   13.812789] CPU 0: aperture @ 0 size 32 MB
[   13.819909] No AGP bridge found
[   13.832038] Memory: 956328k/982016k available (2274k kernel code, 25292k reserved, 1181k data, 296k init)
[   13.832088] SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   13.911274] Calibrating delay using timer specific routine.. 3228.96 BogoMIPS (lpj=6457935)
[   13.911308] Security Framework v1.0.0 initialized
[   13.911314] SELinux:  Disabled at boot.
[   13.911422] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   13.912096] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   13.912421] Mount-cache hash table entries: 256
[   13.912561] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   13.912565] CPU: L2 Cache: 512K (64 bytes/line)
[   13.912568] CPU 0/0 -> Node 0
[   13.912570] CPU: Physical Processor ID: 0
[   13.912572] CPU: Processor Core ID: 0
[   13.912592] SMP alternatives: switching to UP code
[   13.912838] Early unpacking initramfs... done
[   14.280046] ACPI: Core revision 20070126
[   14.280131] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   14.327493] Using local APIC timer interrupts.
[   14.389704] result 12557144
[   14.389706] Detected 12.557 MHz APIC timer.
[   14.391266] SMP alternatives: switching to SMP code
[   14.391371] Booting processor 1/2 APIC 0x1
[   14.402162] Initializing CPU#1
[   14.479732] Calibrating delay using timer specific routine.. 3214.50 BogoMIPS (lpj=6429016)
[   14.479739] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   14.479742] CPU: L2 Cache: 512K (64 bytes/line)
[   14.479745] CPU 1/1 -> Node 0
[   14.479747] CPU: Physical Processor ID: 0
[   14.479749] CPU: Processor Core ID: 1
[   14.479842] AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
[   14.483195] Brought up 2 CPUs
[   14.556926] migration_cost=286
[   14.556557] NET: Registered protocol family 16
[   14.556654] ACPI: bus type pci registered
[   14.556661] PCI: Using configuration type 1
[   14.557683] ACPI: EC: Look up EC in DSDT
[   14.558220] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   14.560001] ACPI: System BIOS is requesting _OSI(Linux)
[   14.560004] ACPI: Please test with "acpi_osi=!Linux"
[   14.560005] Please send dmidecode to linux-acpi@vger.kernel.org
[   14.560273] ACPI: Interpreter enabled
[   14.560276] ACPI: (supports S0 S3 S4 S5)
[   14.560294] ACPI: Using IOAPIC for interrupt routing
[   14.569504] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   14.569591] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   14.569599] PCI: Probing PCI hardware (bus 00)
[   14.570610] PCI: Transparent bridge - 0000:00:10.0
[   14.570644] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   14.570759] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   14.570793] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[   14.570829] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[   14.609220] ACPI: PCI Interrupt Link [LNK1] (IRQs 5) *0, disabled.
[   14.609448] ACPI: PCI Interrupt Link [LNK2] (IRQs 7) *11
[   14.609672] ACPI: PCI Interrupt Link [LNK3] (IRQs 10) *0, disabled.
[   14.609895] ACPI: PCI Interrupt Link [LNK4] (IRQs 11) *0, disabled.
[   14.610118] ACPI: PCI Interrupt Link [LK1E] (IRQs 16) *0, disabled.
[   14.610341] ACPI: PCI Interrupt Link [LK2E] (IRQs 17) *0, disabled.
[   14.610566] ACPI: PCI Interrupt Link [LK3E] (IRQs 18) *11
[   14.610791] ACPI: PCI Interrupt Link [LK4E] (IRQs 19) *0, disabled.
[   14.611013] ACPI: PCI Interrupt Link [LSMB] (IRQs *10)
[   14.611393] ACPI: PCI Interrupt Link [LPMU] (IRQs 11) *10
[   14.611617] ACPI: PCI Interrupt Link [LUS0] (IRQs 22) *11
[   14.611840] ACPI: PCI Interrupt Link [LUS2] (IRQs 22) *7
[   14.612064] ACPI: PCI Interrupt Link [LMAC] (IRQs 20) *10
[   14.612295] ACPI: PCI Interrupt Link [LAZA] (IRQs 21) *0, disabled.
[   14.612518] ACPI: PCI Interrupt Link [LACI] (IRQs 21) *0, disabled.
[   14.612741] ACPI: PCI Interrupt Link [LMCI] (IRQs 21) *0, disabled.
[   14.612967] ACPI: PCI Interrupt Link [LPID] (IRQs 21) *0, disabled.
[   14.613200] ACPI: PCI Interrupt Link [LTID] (IRQs 23) *5
[   14.613423] ACPI: PCI Interrupt Link [LSI1] (IRQs 20) *10
[   14.613593] Linux Plug and Play Support v0.97 (c) Adam Belay
[   14.613608] pnp: PnP ACPI init
[   14.613619] ACPI: bus type pnp registered
[   14.616818] pnp: PnP ACPI: found 13 devices
[   14.616821] ACPI: ACPI bus type pnp unregistered
[   14.616886] PCI: Using ACPI for IRQ routing
[   14.616889] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   14.616980] NET: Registered protocol family 8
[   14.616983] NET: Registered protocol family 20
[   14.617068] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[   14.617074] hpet0: 3 32-bit timers, 25000000 Hz
[   14.618143] pnp: 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[   14.618150] pnp: 00:01: iomem range 0xffc00000-0xffffffff could not be reserved
[   14.618154] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[   14.618158] pnp: 00:01: iomem range 0xfee00000-0xfeefffff could not be reserved
[   14.618162] pnp: 00:01: iomem range 0xfed00000-0xfed00fff has been reserved
[   14.618169] pnp: 00:03: iomem range 0xe0000000-0xefffffff could not be reserved
[   14.618175] pnp: 00:04: ioport range 0x1000-0x107f has been reserved
[   14.618179] pnp: 00:04: ioport range 0x1080-0x10ff has been reserved
[   14.618182] pnp: 00:04: ioport range 0x1400-0x147f has been reserved
[   14.618186] pnp: 00:04: ioport range 0x1480-0x14ff has been reserved
[   14.618190] pnp: 00:04: ioport range 0x1800-0x187f has been reserved
[   14.618193] pnp: 00:04: ioport range 0x1880-0x18ff has been reserved
[   14.618197] pnp: 00:04: ioport range 0x2000-0x203f has been reserved
[   14.618556] PCI: Bridge: 0000:00:02.0
[   14.618559]   IO window: 4000-4fff
[   14.618564]   MEM window: b4000000-b5ffffff
[   14.618567]   PREFETCH window: d0000000-d01fffff
[   14.618570] PCI: Bridge: 0000:00:03.0
[   14.618572]   IO window: disabled.
[   14.618578]   MEM window: b6000000-b7ffffff
[   14.618580]   PREFETCH window: disabled.
[   14.618583] PCI: Bridge: 0000:00:10.0
[   14.618585]   IO window: disabled.
[   14.618588]   MEM window: disabled.
[   14.618591]   PREFETCH window: disabled.
[   14.618602] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   14.618610] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   14.618618] PCI: Setting latency timer of device 0000:00:10.0 to 64
[   14.618678] NET: Registered protocol family 2
[   14.619718] Time: hpet clocksource has been installed.
[   14.671205] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   14.671648] TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
[   14.673828] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   14.674523] TCP: Hash tables configured (established 131072 bind 65536)
[   14.674528] TCP reno registered
[   14.687283] checking if image is initramfs... it is
[   15.398367] Freeing initrd memory: 7199k freed
[   15.403317] Simple Boot Flag at 0x36 set to 0x1
[   15.404592] audit: initializing netlink socket (disabled)
[   15.404610] audit(1192129415.540:1): initialized
[   15.406934] VFS: Disk quotas dquot_6.5.1
[   15.406993] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   15.407097] io scheduler noop registered
[   15.407100] io scheduler anticipatory registered
[   15.407102] io scheduler deadline registered
[   15.407209] io scheduler cfq registered (default)
[   15.407232] Boot video device is 0000:00:05.0
[   15.624192] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   15.624217] assign_interrupt_mode Found MSI capability
[   15.624221] Allocate Port Service[0000:00:02.0:pcie00]
[   15.624293] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   15.624316] assign_interrupt_mode Found MSI capability
[   15.624319] Allocate Port Service[0000:00:03.0:pcie00]
[   15.652578] Real Time Clock Driver v1.12ac
[   15.652777] hpet_resources: 0xfed00000 is busy
[   15.652823] Linux agpgart interface v0.102 (c) Dave Jones
[   15.652827] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   15.654008] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   15.654247] input: Macintosh mouse button emulation as /class/input/input0
[   15.654330] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   15.672988] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.672996] serio: i8042 AUX port at 0x60,0x64 irq 12
[   15.673138] mice: PS/2 mouse device common for all mice
[   15.673301] TCP cubic registered
[   15.673362] NET: Registered protocol family 1
[   15.673582] /build/buildd/linux-source-2.6.22-2.6.22/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   15.673590] Freeing unused kernel memory: 296k freed
[   15.691081] input: AT Translated Set 2 keyboard as /class/input/input1
[   16.899271] AppArmor: AppArmor initialized<5>audit(1192129417.032:2):  type=1505 info="AppArmor initialized" pid=1273
[   16.907299] fuse init (API version 7.8)
[   16.911822] Failure registering capabilities with primary security module.
[   16.945763] ACPI: Thermal Zone [THRM] (79 C)
[   17.520068] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   17.520075] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   17.524962] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[   17.524985] NFORCE-MCP51: chipset revision 241
[   17.524988] NFORCE-MCP51: not 100% native mode: will probe irqs later
[   17.524993] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[   17.524999] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[   17.525009]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:DMA, hdb:pio
[   17.525021] Probing IDE interface ide0...
[   17.542670] SCSI subsystem initialized
[   17.552923] libata version 2.21 loaded.
[   17.583837] usbcore: registered new interface driver usbfs
[   17.583867] usbcore: registered new interface driver hub
[   17.583901] usbcore: registered new device driver usb
[   17.595142] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   17.599639] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   18.306801] hda: Optiarc DVD RW AD-7530A, ATAPI CD/DVD-ROM drive
[   19.028944] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   19.030070] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
[   19.030081] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 22 (level, high) -> IRQ 22
[   19.030251] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   19.030259] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[   19.030724] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[   19.030749] ohci_hcd 0000:00:0b.0: irq 22, io mem 0xb0004000
[   19.093035] usb usb1: configuration #1 chosen from 1 choice
[   19.093238] hub 1-0:1.0: USB hub found
[   19.093249] hub 1-0:1.0: 8 ports detected
[   19.199529] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 20
[   19.199541] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 20 (level, high) -> IRQ 20
[   19.199549] PCI: Setting latency timer of device 0000:00:14.0 to 64
[   19.199558] forcedeth: using HIGHDMA
[   19.199578] 0000:00:14.0: Invalid Mac address detected: 00:00:00:00:00:00
[   19.199581] Please complain to your hardware vendor. Switching to a random MAC.
[   19.216854] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, (U)DMA
[   19.216864] Uniform CD-ROM driver Revision: 3.20
[   19.514511] usb 1-6: new low speed USB device using ohci_hcd and address 2
[   19.727022] eth0: forcedeth.c: subsystem: 0103c:30b7 bound to 0000:00:14.0
[   19.727566] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 22
[   19.727570] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 22 (level, high) -> IRQ 22
[   19.728188] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[   19.728195] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[   19.728573] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[   19.728609] ehci_hcd 0000:00:0b.1: debug port 1
[   19.728614] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[   19.728622] ehci_hcd 0000:00:0b.1: irq 22, io mem 0xb0005000
[   19.728632] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   19.729035] usb usb2: configuration #1 chosen from 1 choice
[   19.729220] hub 2-0:1.0: USB hub found
[   19.729227] hub 2-0:1.0: 8 ports detected
[   19.733185] usb 1-6: configuration #1 chosen from 1 choice
[   19.736076] usb 1-6: can't set config #1, error -62
[   19.736147] usb 1-6: USB disconnect, address 2
[   19.835559] sata_nv 0000:00:0e.0: version 3.4
[   19.835577] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[   19.835966] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
[   19.835977] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 23
[   19.836192] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   19.836558] scsi0 : sata_nv
[   19.836627] scsi1 : sata_nv
[   19.836701] ata1: SATA max UDMA/133 cmd 0x00000000000130c0 ctl 0x00000000000130b6 bmdma 0x0000000000013090 irq 23
[   19.836706] ata2: SATA max UDMA/133 cmd 0x00000000000130b8 ctl 0x00000000000130b2 bmdma 0x0000000000013098 irq 23
[   20.314418] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   20.326589] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7BP, max UDMA/100
[   20.326593] ata1.00: 312581808 sectors, multi 16: LBA48 
[   20.350583] ata1.00: configured for UDMA/100
[   20.355029] usb 1-6: new low speed USB device using ohci_hcd and address 3
[   20.570059] usb 1-6: configuration #1 chosen from 1 choice
[   20.670360] ata2: SATA link down (SStatus 0 SControl 300)
[   20.681807] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[   20.687489] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   20.687505] sd 0:0:0:0: [sda] Write Protect is off
[   20.687509] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   20.687525] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   20.687580] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   20.687589] sd 0:0:0:0: [sda] Write Protect is off
[   20.687593] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   20.687607] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   20.687612]  sda: sda1 sda2 sda3 <<6>usbcore: registered new interface driver hiddev
[   20.718346] input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
[   20.718523] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-6
[   20.718540] usbcore: registered new interface driver usbhid
[   20.718544] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   20.726774]  sda5 >
[   20.726897] sd 0:0:0:0: [sda] Attached SCSI disk
[   20.730496] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   20.975853] Attempting manual resume
[   20.975858] swsusp: Resume From Partition 8:5
[   20.975860] PM: Checking swsusp image.
[   20.976091] PM: Resume from disk failed.
[   21.024599] kjournald starting.  Commit interval 5 seconds
[   21.025171] EXT3-fs: mounted filesystem with ordered data mode.
[   30.657748] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   30.669493] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   30.779589] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   30.779624] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   31.000697] nvidia: module license 'NVIDIA' taints kernel.
[   31.277909] ACPI: PCI Interrupt Link [LK3E] enabled at IRQ 18
[   31.277923] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LK3E] -> GSI 18 (level, high) -> IRQ 18
[   31.277932] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   31.278113] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  100.14.19  Wed Sep 12 14:08:38 PDT 2007
[   31.324199] input: PC Speaker as /class/input/input3
[   31.347312] ieee80211_crypt: registered algorithm 'NULL'
[   31.350025] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   31.350029] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   31.414105] bcm43xx driver
[   31.414617] ACPI: PCI Interrupt Link [LK4E] enabled at IRQ 19
[   31.414629] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK4E] -> GSI 19 (level, high) -> IRQ 19
[   31.414641] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   31.682608] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 21
[   31.682622] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA] -> GSI 21 (level, high) -> IRQ 21
[   31.682856] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   31.922036] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1a0b1, caps: 0xa04713/0x200000
[   31.984801] input: SynPS/2 Synaptics TouchPad as /class/input/input4
[   32.583462] lp: driver loaded but no devices found
[   32.675021] Adding 2634620k swap on /dev/sda5.  Priority:-1 extents:1 across:2634620k
[   33.092689] EXT3 FS on sda1, internal journal
[   34.603169] No dock devices found.
[   34.677177] ACPI: AC Adapter [ACAD] (on-line)
[   34.712772] ACPI: Video Device [UVGA] (multi-head: yes  rom: no  post: no)
[   34.715955] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   34.738102] ACPI: Battery Slot [BAT0] (battery present)
[   34.826584] input: Power Button (FF) as /class/input/input5
[   34.826609] ACPI: Power Button (FF) [PWRF]
[   34.826658] input: Power Button (CM) as /class/input/input6
[   34.826677] ACPI: Power Button (CM) [PWRB]
[   34.826722] input: Sleep Button (CM) as /class/input/input7
[   34.826739] ACPI: Sleep Button (CM) [SLPB]
[   34.826783] input: Lid Switch as /class/input/input8
[   34.826798] ACPI: Lid Switch [LID]
[   35.145672] powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-52 processors (version 2.00.00)
[   35.145198] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
[   35.145204] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
[   36.340591] ppdev: user-space parallel port driver
[   36.737781] audit(1192129437.375:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5161 profile="/usr/sbin/cupsd"
[   38.331310] Failure registering capabilities with primary security module.
[   38.603448] Bluetooth: Core ver 2.11
[   38.603573] NET: Registered protocol family 31
[   38.603577] Bluetooth: HCI device and connection manager initialized
[   38.603581] Bluetooth: HCI socket layer initialized
[   38.613343] Bluetooth: L2CAP ver 2.8
[   38.613349] Bluetooth: L2CAP socket layer initialized
[   38.661763] Bluetooth: RFCOMM socket layer initialized
[   38.661785] Bluetooth: RFCOMM TTY layer initialized
[   38.661790] Bluetooth: RFCOMM ver 1.8
[   42.141826] NET: Registered protocol family 17
[   44.956712] NET: Registered protocol family 10
[   44.956830] lo: Disabled Privacy Extensions
[   44.957094] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   50.989675] eth74: no IPv6 routers present


--------------040807070300010606070602--
