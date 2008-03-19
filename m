From: Matteo Alviti <malviti@gmx.de>
Subject: dmidecode + dmesg. thanks
Date: Wed, 19 Mar 2008 13:10:48 +0100
Message-ID: <1205928648.6603.5.camel@matteo-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936435AbYCSVKv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 17:10:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 810 bytes.
Table at 0x000F1D00.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Hewlett-Packard
        Version: F.30    
        Release Date: 04/02/2007
        Address: 0xE6AB0
        Runtime Size: 103760 bytes
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
        Product Name: Pavilion dv6000 (RG894EA#ABZ)     
        Version: Rev 1
        Serial Number: CNF63206Z0
        UUID: 434E4636-3332-3036-5A30-001B24118DE3
        Wake-up Type: Power Switch
        SKU Number: RG894EA#ABZ
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Quanta
        Product Name: 30B8
        Version: 65.27
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
        Security Status: None
        OEM Information: 0x00001234

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
        Version: AMD Turion(tm) 64 X2 Mobile TL50
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
        Installed Size: 512 KB
        Maximum Size: 512 KB
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
        Description:    

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
        String 1: $HP$

Handle 0x000B, DMI type 15, 29 bytes
System Event Log
        Area Length: 16 bytes
        Header Start Offset: 0x0000
        Header Length: 16 bytes
        Data Start Offset: 0x0010
        Access Method: General-purpose non-volatile data functions
        Access Address: 0x0000
        Status: Valid, Not Full
        Change Token: 0x000000F9
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
        Manufacturer: F7F7F7B000000000
        Serial Number: 42AB8CF0
        Asset Tag: Not Specified
        Part Number: NT512T64UH8A1FN-3C

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
        Manufacturer: F7F7F7B000000000
        Serial Number: 04AA8CF0
        Asset Tag: Not Specified
        Part Number: NT512T64UH8A1FN-3C

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

DMESG:

[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f8920
[    0.000000] Entering add_active_range(0, 0, 261888) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   261888
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   261888
[    0.000000] On node 0 totalpages: 261888
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 254 pages used for memmap
[    0.000000]   HighMem zone: 32258 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F88F0 checksum 0
[    0.000000] ACPI: RSDP 000F88F0, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 3FF0CE48, 003C (r1 HPQOEM SLIC-MPC  6040000  LTP        0)
[    0.000000] ACPI: FACP 3FF15D10, 0074 (r1 HP     MCP51M    6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 3FF0CE84, 8E8C (r1 HP       MCP51M  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 3FF16FC0, 0040
[    0.000000] ACPI: SSDT 3FF15D84, 0182 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: MCFG 3FF15F06, 003C (r1 HP       MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 3FF15F42, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 3FF15F7A, 005E (r1 HP          APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3FF15FD8, 0028 (r1     HP $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: nVIDIA   Product ID: C51-MCP51    APIC at: 0xFEE00000
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 2
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Built 1 zonelists.  Total pages: 259842
[    0.000000] Kernel command line: root=UUID=cff3743c-06ac-4107-899e-91ee0909cbea ro irqfixup quiet splash noapic nolapic locale=it_IT
[    0.000000] Misrouted IRQ fixup support enabled.
[    0.000000] This may impact system performance.
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1607.371 MHz processor.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1026920k/1047552k available (2015k kernel code, 19972k reserved, 915k data, 364k init, 130048k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000000]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[    0.000000]       .data : 0xc02f7e86 - 0xc03dce84   ( 915 kB)
[    0.000000]       .text : 0xc0100000 - 0xc02f7e86   (2015 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[    0.000000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.000000] hpet0: 3 32-bit timers, 25000000 Hz
[    0.080000] Calibrating delay using timer specific routine.. 3217.46 BogoMIPS (lpj=6434935)
[    0.080000] Security Framework v1.0.0 initialized
[    0.080000] SELinux:  Disabled at boot.
[    0.080000] Mount-cache hash table entries: 512
[    0.080000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.080000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.080000] CPU: L2 Cache: 256K (64 bytes/line)
[    0.080000] CPU 0(2) -> Core 0
[    0.080000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.080000] Compat vDSO mapped to ffffe000.
[    0.080000] Checking 'hlt' instruction... OK.
[    0.096000] SMP alternatives: switching to UP code
[    0.096000] Early unpacking initramfs... done
[    0.452000] ACPI: Core revision 20070126
[    0.452000] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[    0.456000] ACPI: setting ELCR to 0200 (from 0ca0)
[    0.460000] CPU0: AMD Turion(tm) 64 X2 Mobile Technology TL-50 stepping 02
[    0.460000] SMP alternatives: switching to SMP code
[    0.460000] Booting processor 1/1 eip 3000
[    0.472000] Initializing CPU#1
[    0.552000] Calibrating delay using timer specific routine.. 3214.63 BogoMIPS (lpj=6429275)
[    0.552000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.552000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.552000] CPU: L2 Cache: 256K (64 bytes/line)
[    0.552000] CPU 1(2) -> Core 1
[    0.552000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.552000] CPU1: AMD Turion(tm) 64 X2 Mobile Technology TL-50 stepping 02
[    0.552000] Total of 2 processors activated (6432.10 BogoMIPS).
[    0.552000] Brought up 2 CPUs
[    0.580000] migration_cost=4000
[    0.580000] Booting paravirtualized kernel on bare hardware
[    0.580000] Time: 12:43:03  Date: 02/19/108
[    0.580000] NET: Registered protocol family 16
[    0.580000] EISA bus registered
[    0.580000] ACPI: bus type pci registered
[    0.592000] PCI: BIOS BUG #81[49435000] found
[    0.592000] PCI: Using configuration type 1
[    0.592000] Setting up standard PCI resources
[    0.596000] ACPI: EC: Look up EC in DSDT
[    0.596000] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[    0.596000] ACPI: System BIOS is requesting _OSI(Linux)
[    0.596000] ACPI: Please test with "acpi_osi=!Linux"
[    0.596000] Please send dmidecode to linux-acpi@vger.kernel.org
[    0.596000] ACPI: Interpreter enabled
[    0.596000] ACPI: (supports S0 S3 S4 S5)
[    0.596000] ACPI: Using PIC for interrupt routing
[    0.608000] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[    0.608000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.608000] PCI: Probing PCI hardware (bus 00)
[    0.608000] PCI: Transparent bridge - 0000:00:10.0
[    0.608000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.608000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[    0.608000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.608000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[    0.608000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[    0.644000] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.644000] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 *11 14 15)
[    0.644000] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
[    0.644000] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LK1E] (IRQs 5 7 9 10 *11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LK2E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LK3E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LK4E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 *10 11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LUS0] (IRQs 5 7 9 10 *11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LUS2] (IRQs 5 *7 9 10 11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LPID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.648000] ACPI: PCI Interrupt Link [LTID] (IRQs *5 7 9 10 11 14 15)
[    0.648000] ACPI: PCI Interrupt Link [LSI1] (IRQs 5 7 9 *10 11 14 15)
[    0.648000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.648000] pnp: PnP ACPI init
[    0.648000] ACPI: bus type pnp registered
[    0.652000] pnp: PnP ACPI: found 13 devices
[    0.652000] ACPI: ACPI bus type pnp unregistered
[    0.652000] PnPBIOS: Disabled by ACPI PNP
[    0.652000] PCI: Using ACPI for IRQ routing
[    0.652000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.652000] NET: Registered protocol family 8
[    0.652000] NET: Registered protocol family 20
[    0.652000] pnp: 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.652000] pnp: 00:01: iomem range 0xffc00000-0xffffffff could not be reserved
[    0.652000] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.652000] pnp: 00:01: iomem range 0xfee00000-0xfeefffff could not be reserved
[    0.652000] pnp: 00:01: iomem range 0xfed00000-0xfed00fff has been reserved
[    0.652000] pnp: 00:03: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.652000] pnp: 00:04: ioport range 0x1000-0x107f has been reserved
[    0.652000] pnp: 00:04: ioport range 0x1080-0x10ff has been reserved
[    0.652000] pnp: 00:04: ioport range 0x1400-0x147f has been reserved
[    0.652000] pnp: 00:04: ioport range 0x1480-0x14ff has been reserved
[    0.652000] pnp: 00:04: ioport range 0x1800-0x187f has been reserved
[    0.652000] pnp: 00:04: ioport range 0x1880-0x18ff has been reserved
[    0.652000] pnp: 00:04: ioport range 0x2000-0x203f has been reserved
[    0.656000] Time: hpet clocksource has been installed.
[    0.684000] PCI: Bridge: 0000:00:02.0
[    0.684000]   IO window: 4000-4fff
[    0.684000]   MEM window: c4000000-c7ffffff
[    0.684000]   PREFETCH window: ce200000-ce3fffff
[    0.684000] PCI: Bridge: 0000:00:03.0
[    0.684000]   IO window: disabled.
[    0.684000]   MEM window: c8000000-cbffffff
[    0.684000]   PREFETCH window: disabled.
[    0.684000] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
[    0.684000] PCI: Bridge: 0000:00:04.0
[    0.684000]   IO window: disabled.
[    0.684000]   MEM window: cc000000-cdffffff
[    0.684000]   PREFETCH window: d0000000-dfffffff
[    0.684000] PCI: Bridge: 0000:00:10.0
[    0.684000]   IO window: disabled.
[    0.684000]   MEM window: ce000000-ce0fffff
[    0.684000]   PREFETCH window: disabled.
[    0.684000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.684000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    0.684000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    0.684000] PCI: Setting latency timer of device 0000:00:10.0 to 64
[    0.684000] NET: Registered protocol family 2
[    0.732000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.732000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.732000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.732000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.732000] TCP reno registered
[    0.748000] checking if image is initramfs... it is
[    1.456000] Freeing initrd memory: 7065k freed
[    1.456000] Simple Boot Flag at 0x36 set to 0x1
[    1.456000] audit: initializing netlink socket (disabled)
[    1.456000] audit(1205930583.156:1): initialized
[    1.456000] highmem bounce pool size: 64 pages
[    1.456000] VFS: Disk quotas dquot_6.5.1
[    1.456000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.456000] io scheduler noop registered
[    1.456000] io scheduler anticipatory registered
[    1.456000] io scheduler deadline registered
[    1.456000] io scheduler cfq registered (default)
[    1.476000] Boot video device is 0000:05:00.0
[    1.476000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    1.476000] assign_interrupt_mode Found MSI capability
[    1.476000] Allocate Port Service[0000:00:02.0:pcie00]
[    1.476000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    1.476000] assign_interrupt_mode Found MSI capability
[    1.476000] Allocate Port Service[0000:00:03.0:pcie00]
[    1.476000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    1.476000] assign_interrupt_mode Found MSI capability
[    1.476000] Allocate Port Service[0000:00:04.0:pcie00]
[    1.476000] isapnp: Scanning for PnP cards...
[    1.828000] isapnp: No Plug & Play device found
[    1.856000] Real Time Clock Driver v1.12ac
[    1.856000] hpet_resources: 0xfed00000 is busy
[    1.856000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.856000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.856000] input: Macintosh mouse button emulation as /class/input/input0
[    1.856000] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    1.872000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.872000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.876000] mice: PS/2 mouse device common for all mice
[    1.876000] EISA: Probing bus 0 at eisa.0
[    1.876000] Cannot allocate resource for EISA slot 1
[    1.876000] Cannot allocate resource for EISA slot 2
[    1.876000] Cannot allocate resource for EISA slot 3
[    1.876000] Cannot allocate resource for EISA slot 4
[    1.876000] EISA: Detected 0 cards.
[    1.876000] TCP cubic registered
[    1.876000] NET: Registered protocol family 1
[    1.876000] Using IPI No-Shortcut mode
[    1.876000]   Magic number: 0:365:734
[    1.876000] Freeing unused kernel memory: 364k freed
[    1.888000] input: AT Translated Set 2 keyboard as /class/input/input1
[    3.156000] AppArmor: AppArmor initialized<5>audit(1205930585.156:2):  type=1505 info="AppArmor initialized" pid=1272
[    3.164000] fuse init (API version 7.8)
[    3.168000] Failure registering capabilities with primary security module.
[    3.204000] ACPI: Thermal Zone [THRM] (50 C)
[    3.904000] SCSI subsystem initialized
[    3.920000] usbcore: registered new interface driver usbfs
[    3.920000] usbcore: registered new interface driver hub
[    3.920000] usbcore: registered new device driver usb
[    3.920000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.920000] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
[    3.920000] PCI: setting IRQ 11 as level-triggered
[    3.920000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
[    3.920000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    3.920000] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    3.920000] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[    3.920000] ohci_hcd 0000:00:0b.0: irq 11, io mem 0xc0004000
[    3.924000] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[    3.924000] libata version 2.21 loaded.
[    3.984000] usb usb1: configuration #1 chosen from 1 choice
[    3.984000] hub 1-0:1.0: USB hub found
[    3.984000] hub 1-0:1.0: 8 ports detected
[    4.088000] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
[    4.088000] PCI: setting IRQ 10 as level-triggered
[    4.088000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 10 (level, low) -> IRQ 10
[    4.088000] PCI: Setting latency timer of device 0000:00:14.0 to 64
[    4.088000] forcedeth: using HIGHDMA
[    4.392000] usb 1-2: new low speed USB device using ohci_hcd and address 2
[    4.608000] eth0: forcedeth.c: subsystem: 0103c:30b7 bound to 0000:00:14.0
[    4.608000] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 7
[    4.608000] PCI: setting IRQ 7 as level-triggered
[    4.608000] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 7 (level, low) -> IRQ 7
[    4.608000] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[    4.608000] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    4.608000] usb 1-2: configuration #1 chosen from 1 choice
[    4.608000] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[    4.608000] ehci_hcd 0000:00:0b.1: debug port 1
[    4.608000] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[    4.608000] ehci_hcd 0000:00:0b.1: irq 7, io mem 0xc0005000
[    4.608000] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    4.608000] usb usb2: configuration #1 chosen from 1 choice
[    4.608000] hub 2-0:1.0: USB hub found
[    4.608000] hub 2-0:1.0: 8 ports detected
[    4.612000] usb 1-2: can't set config #1, error -62
[    4.716000] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
[    4.716000] ACPI: PCI Interrupt 0000:07:05.0[A] -> Link [LNK1] -> GSI 11 (level, low) -> IRQ 11
[    4.764000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    4.764000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    4.768000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ce000000-ce0007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    4.772000] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[    4.772000] NFORCE-MCP51: chipset revision 241
[    4.772000] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    4.772000] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[    4.772000] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[    4.772000]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:DMA, hdb:pio
[    4.772000] Probing IDE interface ide0...
[    4.892000] usb 1-2: USB disconnect, address 2
[    5.444000] usb 2-4: new high speed USB device using ehci_hcd and address 3
[    5.508000] hda: HL-DT-ST DVDRAM GMA-4082N, ATAPI CD/DVD-ROM drive
[    5.584000] usb 2-4: configuration #1 chosen from 1 choice
[    5.844000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.848000] sata_nv 0000:00:0e.0: version 3.4
[    5.848000] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[    5.848000] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 5
[    5.848000] PCI: setting IRQ 5 as level-triggered
[    5.848000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 5 (level, low) -> IRQ 5
[    5.848000] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    5.848000] scsi0 : sata_nv
[    5.848000] scsi1 : sata_nv
[    5.848000] ata1: SATA max UDMA/133 cmd 0x000130c0 ctl 0x000130b6 bmdma 0x00013090 irq 5
[    5.848000] ata2: SATA max UDMA/133 cmd 0x000130b8 ctl 0x000130b2 bmdma 0x00013098 irq 5
[    5.860000] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
[    5.860000] Uniform CD-ROM driver Revision: 3.20
[    6.048000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b0076520a00]
[    6.072000] usb 1-2: new low speed USB device using ohci_hcd and address 3
[    6.288000] usb 1-2: configuration #1 chosen from 1 choice
[    6.316000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.324000] ata1.00: ATA-7: TOSHIBA MK1234GSX, AH001C, max UDMA/100
[    6.324000] ata1.00: 234441648 sectors, multi 16: LBA48 
[    6.332000] ata1.00: configured for UDMA/100
[    6.600000] usb 1-6: new low speed USB device using ohci_hcd and address 4
[    6.644000] ata2: SATA link down (SStatus 0 SControl 300)
[    6.648000] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK1234GS AH00 PQ: 0 ANSI: 5
[    6.660000] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
[    6.660000] sd 0:0:0:0: [sda] Write Protect is off
[    6.660000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.660000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.660000] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
[    6.660000] sd 0:0:0:0: [sda] Write Protect is off
[    6.660000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.660000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.660000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    6.716000] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.720000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.796000] usb 1-6: configuration #1 chosen from 1 choice
[    6.800000] usbcore: registered new interface driver hiddev
[    6.804000] input: CHESEN PS2 to USB Converter as /class/input/input2
[    6.804000] input: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:0b.0-2
[    6.816000] input: CHESEN PS2 to USB Converter as /class/input/input3
[    6.816000] input: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:0b.0-2
[    6.824000] input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input4
[    6.824000] input: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on usb-0000:00:0b.0-6
[    6.824000] usbcore: registered new interface driver usbhid
[    6.824000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    7.116000] Attempting manual resume
[    7.116000] swsusp: Resume From Partition 8:5
[    7.116000] PM: Checking swsusp image.
[    7.116000] PM: Resume from disk failed.
[    7.156000] kjournald starting.  Commit interval 5 seconds
[    7.156000] EXT3-fs: mounted filesystem with ordered data mode.
[   16.024000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   16.040000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   16.420000] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   16.420000] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   16.452000] input: PC Speaker as /class/input/input5
[   16.796000] ndiswrapper version 1.45 loaded (smp=yes)
[   16.952000] Linux agpgart interface v0.102 (c) Dave Jones
[   17.056000] Linux video capture interface: v2.00
[   17.148000] ndiswrapper: driver bcmwl5 (Broadcom,07/11/2007, 4.150.29.0) loaded
[   17.148000] ACPI: PCI Interrupt Link [LK4E] enabled at IRQ 10
[   17.148000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK4E] -> GSI 10 (level, low) -> IRQ 10
[   17.148000] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   17.156000] ndiswrapper: using IRQ 10
[   17.344000] sdhci: Secure Digital Host Controller Interface driver
[   17.344000] sdhci: Copyright(c) Pierre Ossman
[   17.432000] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (0c45:62c0)
[   17.432000] usbcore: registered new interface driver uvcvideo
[   17.432000] USB Video Class driver (v0.1.0)
[   17.500000] wlan0: ethernet device 00:14:a5:bb:da:6e using NDIS driver: bcmwl5, version: 0x4961d00, NDIS version: 0x501, vendor: '', 14E4:4312.5.conf
[   17.500000] wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP with WPA, WPA2, WPA2PSK
[   17.508000] usbcore: registered new interface driver ndiswrapper
[   17.508000] sdhci: SDHCI controller found at 0000:07:05.1 [1180:0822] (rev 19)
[   17.508000] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
[   17.508000] ACPI: PCI Interrupt 0000:07:05.1[B] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
[   17.508000] mmc0: SDHCI at 0xce000800 irq 11 DMA
[   18.044000] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1a0b1, caps: 0xa04713/0x200000
[   18.288000] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 11
[   18.288000] ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LK1E] -> GSI 11 (level, low) -> IRQ 11
[   18.288000] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   18.288000] NVRM: loading NVIDIA UNIX x86 Kernel Module  169.12  Thu Feb 14 17:53:07 PST 2008
[   18.304000] ndiswrapper: changing interface name from 'wlan0' to 'eth1'
[   18.340000] input: SynPS/2 Synaptics TouchPad as /class/input/input6
[   18.584000] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 9
[   18.584000] PCI: setting IRQ 9 as level-triggered
[   18.584000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA] -> GSI 9 (level, low) -> IRQ 9
[   18.584000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   19.108000] lp: driver loaded but no devices found
[   19.288000] powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-50 processors (version 2.00.00)
[   19.288000] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
[   19.288000] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
[   19.352000] Adding 1092380k swap on /dev/sda5.  Priority:-1 extents:1 across:1092380k
[   20.136000] EXT3 FS on sda6, internal journal
[   26.248000] ACPI: Battery Slot [BAT0] (battery present)
[   26.272000] input: Power Button (FF) as /class/input/input7
[   26.272000] ACPI: Power Button (FF) [PWRF]
[   26.272000] input: Power Button (CM) as /class/input/input8
[   26.272000] ACPI: Power Button (CM) [PWRB]
[   26.288000] input: Sleep Button (CM) as /class/input/input9
[   26.288000] ACPI: Sleep Button (CM) [SLPB]
[   26.296000] input: Lid Switch as /class/input/input10
[   26.296000] ACPI: Lid Switch [LID]
[   26.392000] No dock devices found.
[   26.656000] ACPI: AC Adapter [ACAD] (on-line)
[   26.680000] ACPI: Video Device [UVGA] (multi-head: yes  rom: no  post: no)
[   26.680000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   27.856000] Failure registering capabilities with primary security module.
[   28.112000] ppdev: user-space parallel port driver
[   28.388000] eth0: no link during initialization.
[   28.540000] audit(1205927010.616:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5371 profile="/usr/sbin/cupsd"
[   28.628000] apm: BIOS not found.
[   30.020000] audit(1205927012.116:4):  type=1503 operation="inode_permission" requested_mask="rw" denied_mask="rw" name="/dev/tty" pid=5501 profile="/usr/sbin/cupsd"
[   30.052000] audit(1205927012.116:5):  type=1503 operation="inode_permission" requested_mask="rw" denied_mask="rw" name="/dev/tty" pid=5504 profile="/usr/sbin/cupsd"
[   68.752000] NET: Registered protocol family 17
[   80.872000] NET: Registered protocol family 10
[   80.876000] lo: Disabled Privacy Extensions
[   80.876000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   91.792000] eth1: no IPv6 routers present




