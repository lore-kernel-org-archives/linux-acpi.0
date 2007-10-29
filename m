From: Robert Hunt <hunt.robertj@gmail.com>
Subject: ACPI problems on Toshiba Satellite P200-ST2061 laptop
Date: Mon, 29 Oct 2007 20:57:59 +0800
Message-ID: <4725D8D7.8050006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090807030802010002040401"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:9428 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbXJ2M6I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2007 08:58:08 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1141340nze
        for <linux-acpi@vger.kernel.org>; Mon, 29 Oct 2007 05:58:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807030802010002040401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Output of dmidecode and dmesg from Ubuntu 7:10 Gutsy.

Perhaps this is why I can't get Bluetooth running reliably???


Thanks for your good work,
Robert Hunt.
Hunt.RobertJ@gmail.com

--------------090807030802010002040401
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
22 structures occupying 1012 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: TOSHIBA
	Version: V1.50
	Release Date: 07/11/2007
	Address: 0xE5710
	Runtime Size: 108784 bytes
	ROM Size: 64 kB
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
		AGP is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.80
	Firmware Revision: 1.80

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: TOSHIBA
	Product Name: Satellite P200
	Version: PSPB6U-0UY02E
	Serial Number: 97274314K
	UUID: 57095A55-479B-11DC-8E9E-001B3840B20C
	Wake-up Type: Power Switch
	SKU Number: 012345678912345678912345678
	Family: ABCDEFGHIJKLMNOPQRSTUVWXYZ

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: ISRAA
	Version: 1.00
	Serial Number: 0123456789AB

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: TOSHIBA
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: *
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: FB 06 00 00 FF FB EB BF
	Version: CPU Version
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 4096 MHz
	Current Speed: 2200 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

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
	Error Correction Type: Unknown
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
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Mouse Port

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
	Designation: TI
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000A, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: Realtek HDA-01

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
	String 1: PSPB6U-0UY02E,SQ008691V02,11B

Handle 0x000C, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x000D, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1000 MB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0010, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x000D
	Partition Width: 0

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000E
	Memory Array Mapped Address Handle: 0x0010
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0012, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000F
	Memory Array Mapped Address Handle: 0x0010
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0013, DMI type 22, 26 bytes
Portable Battery
	Location: Rear
	Manufacturer: TOSHIBA   
	Name: TOSHIBA   
	Chemistry: Lithium Ion
	Design Capacity: 1000 mWh
	Design Voltage: 19 mV
	SBDS Version: BATT_1234
	Maximum Error: 100%
	SBDS Serial Number: 0001
	SBDS Manufacture Date: 1980-00-01
	OEM-specific Information: 0x00000000

Handle 0x0014, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0015, DMI type 127, 4 bytes
End Of Table


--------------090807030802010002040401
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@crested) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 21:45:15 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] Command line: root=UUID=67dc635b-f5a5-4323-91d8-54372b392bb3 ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fed0000 (usable)
[    0.000000]  BIOS-e820: 000000003fed0000 - 000000003fee3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fee3000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 261840) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F7100 checksum 0
[    0.000000] ACPI: RSDP 000F7100, 0024 (r2 TOSCPL)
[    0.000000] ACPI: XSDT 3FED7A7D, 0094 (r1 TOSCPL TOSCPL00  6040000  LTP        0)
[    0.000000] ACPI: FACP 3FEDFB60, 00F4 (r3 TOSCPL CRESTLNE  6040000 ALAN        1)
[    0.000000] ACPI: DSDT 3FED8E1A, 6CD2 (r2 TOSCPL CRESTLNE  6040000 INTL 20060608)
[    0.000000] ACPI: FACS 3FEE2FC0, 0040
[    0.000000] ACPI: APIC 3FEDFC54, 0068 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
[    0.000000] ACPI: HPET 3FEDFCBC, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
[    0.000000] ACPI: MCFG 3FEDFCF4, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
[    0.000000] ACPI: TCPA 3FEDFD30, 0032 (r1 Intel  CRESTLNE  6040000 LOHR       5A)
[    0.000000] ACPI: TMOR 3FEDFD62, 0026 (r1 PTLTD            6040000 PTL         3)
[    0.000000] ACPI: SLIC 3FEDFD88, 0176 (r1 TOSCPL TOSCPL00  6040000 LOHR        0)
[    0.000000] ACPI: OSFR 3FEDFEFE, 0072 (r1 TOSHIB A+2nd ID  6040000 TASM  4010000)
[    0.000000] ACPI: APIC 3FEDFF70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3FEDFFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT 3FED8B6D, 02AD (r1 SataRe SataAhci     1000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FED809D, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FED7FF7, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FED7B11, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000003fed0000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 261840) 1 entries of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000003fed0000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   261840
[    0.000000] On node 0 totalpages: 261743
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1124 pages reserved
[    0.000000]   DMA zone: 2819 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3523 pages used for memmap
[    0.000000]   DMA32 zone: 254221 pages, LIFO batch:31
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
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000d2000
[    0.000000] swsusp: Registered nosave memory region: 00000000000d2000 - 00000000000d4000
[    0.000000] swsusp: Registered nosave memory region: 00000000000d4000 - 00000000000dc000
[    0.000000] swsusp: Registered nosave memory region: 00000000000dc000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34696 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 257040
[    0.000000] Kernel command line: root=UUID=67dc635b-f5a5-4323-91d8-54372b392bb3 ro quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Marking TSC unstable due to TSCs unsynchronized
[   13.170229] time.c: Detected 2194.499 MHz processor.
[   13.171467] Console: colour VGA+ 80x25
[   13.171484] Checking aperture...
[   13.171496] Calgary: detecting Calgary via BIOS EBDA area
[   13.171498] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[   13.180543] Memory: 1020228k/1047360k available (2274k kernel code, 26744k reserved, 1181k data, 296k init)
[   13.180580] SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   13.256541] Calibrating delay using timer specific routine.. 4393.37 BogoMIPS (lpj=8786755)
[   13.256569] Security Framework v1.0.0 initialized
[   13.256576] SELinux:  Disabled at boot.
[   13.256659] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   13.257245] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   13.257528] Mount-cache hash table entries: 256
[   13.257635] CPU: L1 I cache: 32K, L1 D cache: 32K
[   13.257637] CPU: L2 cache: 4096K
[   13.257639] CPU 0/0 -> Node 0
[   13.257641] using mwait in idle threads.
[   13.257642] CPU: Physical Processor ID: 0
[   13.257644] CPU: Processor Core ID: 0
[   13.257648] CPU0: Thermal monitoring handled by SMI
[   13.257657] SMP alternatives: switching to UP code
[   13.257881] Early unpacking initramfs... done
[   13.550220] ACPI: Core revision 20070126
[   13.550261] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   13.596683] Using local APIC timer interrupts.
[   13.642193] result 12468740
[   13.642194] Detected 12.468 MHz APIC timer.
[   13.644066] SMP alternatives: switching to SMP code
[   13.644143] Booting processor 1/2 APIC 0x1
[   13.654649] Initializing CPU#1
[   13.731904] Calibrating delay using timer specific routine.. 4389.00 BogoMIPS (lpj=8778000)
[   13.731910] CPU: L1 I cache: 32K, L1 D cache: 32K
[   13.731911] CPU: L2 cache: 4096K
[   13.731913] CPU 1/1 -> Node 0
[   13.731915] CPU: Physical Processor ID: 0
[   13.731916] CPU: Processor Core ID: 1
[   13.731921] CPU1: Thermal monitoring enabled (TM2)
[   13.732373] Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz stepping 0b
[   13.735911] Brought up 2 CPUs
[   13.779257] migration_cost=18
[   13.779410] NET: Registered protocol family 16
[   13.779477] ACPI: bus type pci registered
[   13.779483] PCI: Using configuration type 1
[   13.780467] ACPI: EC: Look up EC in DSDT
[   13.781176] ACPI: EC: GPE=0x1c, ports=0x66, 0x62
[   13.787547] ACPI: System BIOS is requesting _OSI(Linux)
[   13.787549] ACPI: Please test with "acpi_osi=!Linux"
[   13.787550] Please send dmidecode to linux-acpi@vger.kernel.org
[   13.788011] ACPI: Interpreter enabled
[   13.788013] ACPI: (supports S0 S3 S4 S5)
[   13.788028] ACPI: Using IOAPIC for interrupt routing
[   13.840409] ACPI: EC: GPE=0x1c, ports=0x66, 0x62
[   13.840440] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   13.840446] PCI: Probing PCI hardware (bus 00)
[   13.842575] PCI: Transparent bridge - 0000:00:1e.0
[   13.842727] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   13.843056] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[   13.843175] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[   13.843288] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[   13.843403] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[   13.843519] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[   13.843651] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   13.854139] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   13.854230] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[   13.854319] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[   13.854407] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[   13.854495] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[   13.854585] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[   13.854674] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[   13.854767] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
[   13.854857] Linux Plug and Play Support v0.97 (c) Adam Belay
[   13.854867] pnp: PnP ACPI init
[   13.854875] ACPI: bus type pnp registered
[   13.875896] pnp: PnP ACPI: found 10 devices
[   13.875898] ACPI: ACPI bus type pnp unregistered
[   13.875935] PCI: Using ACPI for IRQ routing
[   13.875937] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   13.876094] NET: Registered protocol family 8
[   13.876095] NET: Registered protocol family 20
[   13.876107] PCI-GART: No AMD northbridge found.
[   13.876112] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   13.876116] hpet0: 3 64-bit timers, 14318180 Hz
[   13.877151] pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[   13.877154] pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
[   13.877157] pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
[   13.877159] pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
[   13.877164] pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
[   13.877400] PCI: Bridge: 0000:00:01.0
[   13.877402]   IO window: 2000-2fff
[   13.877405]   MEM window: c7e00000-c7efffff
[   13.877408]   PREFETCH window: d0000000-dfffffff
[   13.877411] PCI: Bridge: 0000:00:1c.0
[   13.877414]   IO window: 3000-3fff
[   13.877419]   MEM window: c0000000-c3ffffff
[   13.877424]   PREFETCH window: cc000000-cdffffff
[   13.877430] PCI: Bridge: 0000:00:1c.1
[   13.877432]   IO window: 4000-4fff
[   13.877438]   MEM window: f0000000-f3ffffff
[   13.877442]   PREFETCH window: fa000000-fbffffff
[   13.877448] PCI: Bridge: 0000:00:1c.2
[   13.877451]   IO window: 5000-5fff
[   13.877456]   MEM window: f4000000-f7ffffff
[   13.877461]   PREFETCH window: fc000000-fdffffff
[   13.877466] PCI: Bridge: 0000:00:1c.3
[   13.877469]   IO window: 6000-6fff
[   13.877475]   MEM window: b8000000-bbffffff
[   13.877479]   PREFETCH window: c8000000-c9ffffff
[   13.877486] PCI: Bus 13, cardbus bridge: 0000:0c:04.0
[   13.877488]   IO window: 00007000-000070ff
[   13.877493]   IO window: 00007400-000074ff
[   13.877498]   PREFETCH window: 50000000-53ffffff
[   13.877503]   MEM window: 58000000-5bffffff
[   13.877508] PCI: Bridge: 0000:00:1e.0
[   13.877510]   IO window: 7000-7fff
[   13.877516]   MEM window: f8000000-f80fffff
[   13.877520]   PREFETCH window: 50000000-53ffffff
[   13.877534] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   13.877538] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   13.877560] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   13.877565] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   13.877587] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
[   13.877592] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   13.877614] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   13.877619] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   13.877641] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   13.877646] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   13.877659] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   13.877675] ACPI: PCI Interrupt 0000:0c:04.0[A] -> GSI 16 (level, low) -> IRQ 16
[   13.877687] NET: Registered protocol family 2
[   13.879710] Time: hpet clocksource has been installed.
[   13.911705] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   13.911994] TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
[   13.913042] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   13.913436] TCP: Hash tables configured (established 131072 bind 65536)
[   13.913439] TCP reno registered
[   13.923766] checking if image is initramfs... it is
[   14.550867] Freeing initrd memory: 7757k freed
[   14.554268] Simple Boot Flag at 0x36 set to 0x1
[   14.554720] audit: initializing netlink socket (disabled)
[   14.554737] audit(1193690736.340:1): initialized
[   14.556394] VFS: Disk quotas dquot_6.5.1
[   14.556433] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   14.556509] io scheduler noop registered
[   14.556510] io scheduler anticipatory registered
[   14.556512] io scheduler deadline registered
[   14.556585] io scheduler cfq registered (default)
[   14.560156] Boot video device is 0000:01:00.0
[   14.560274] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   14.560305] assign_interrupt_mode Found MSI capability
[   14.560308] Allocate Port Service[0000:00:01.0:pcie00]
[   14.560335] Allocate Port Service[0000:00:01.0:pcie02]
[   14.560402] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   14.560457] assign_interrupt_mode Found MSI capability
[   14.560459] Allocate Port Service[0000:00:1c.0:pcie00]
[   14.560483] Allocate Port Service[0000:00:1c.0:pcie02]
[   14.560571] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   14.560627] assign_interrupt_mode Found MSI capability
[   14.560628] Allocate Port Service[0000:00:1c.1:pcie00]
[   14.560652] Allocate Port Service[0000:00:1c.1:pcie02]
[   14.560741] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   14.560796] assign_interrupt_mode Found MSI capability
[   14.560798] Allocate Port Service[0000:00:1c.2:pcie00]
[   14.560821] Allocate Port Service[0000:00:1c.2:pcie02]
[   14.560909] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   14.560964] assign_interrupt_mode Found MSI capability
[   14.560966] Allocate Port Service[0000:00:1c.3:pcie00]
[   14.560991] Allocate Port Service[0000:00:1c.3:pcie02]
[   14.577498] Real Time Clock Driver v1.12ac
[   14.577684] hpet_resources: 0xfed00000 is busy
[   14.577707] Linux agpgart interface v0.102 (c) Dave Jones
[   14.577709] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   14.578495] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   14.578598] input: Macintosh mouse button emulation as /class/input/input0
[   14.578659] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   14.611277] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.611281] serio: i8042 AUX port at 0x60,0x64 irq 12
[   14.611401] mice: PS/2 mouse device common for all mice
[   14.611572] TCP cubic registered
[   14.612515] NET: Registered protocol family 1
[   14.612679] /build/buildd/linux-source-2.6.22-2.6.22/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   14.612684] Freeing unused kernel memory: 296k freed
[   14.635223] input: AT Translated Set 2 keyboard as /class/input/input1
[   15.749703] AppArmor: AppArmor initialized<5>audit(1193690737.544:2):  type=1505 info="AppArmor initialized" pid=1269
[   15.754521] fuse init (API version 7.8)
[   15.757977] Failure registering capabilities with primary security module.
[   15.782307] ACPI: SSDT 3FED882B, 027A (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
[   15.782495] ACPI: SSDT 3FED82FC, 04AA (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
[   15.785234] Monitor-Mwait will be used to enter C-1 state
[   15.785237] Monitor-Mwait will be used to enter C-2 state
[   15.785239] Monitor-Mwait will be used to enter C-3 state
[   15.785242] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   15.785246] ACPI: Processor [CPU0] (supports 8 throttling states)
[   15.785444] ACPI: SSDT 3FED8AA5, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
[   15.785617] ACPI: SSDT 3FED87A6, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
[   15.786113] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   15.786117] ACPI: Processor [CPU1] (supports 8 throttling states)
[   16.070830] usbcore: registered new interface driver usbfs
[   16.070849] usbcore: registered new interface driver hub
[   16.078128] usbcore: registered new device driver usb
[   16.078757] USB Universal Host Controller Interface driver v3.0
[   16.078831] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
[   16.078842] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   16.078845] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   16.078970] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   16.079003] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
[   16.079096] usb usb1: configuration #1 chosen from 1 choice
[   16.079119] hub 1-0:1.0: USB hub found
[   16.079124] hub 1-0:1.0: 2 ports detected
[   16.102358] SCSI subsystem initialized
[   16.105861] libata version 2.21 loaded.
[   16.181042] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
[   16.181053] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   16.181057] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   16.181168] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[   16.181199] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001820
[   16.181449] usb usb2: configuration #1 chosen from 1 choice
[   16.181555] hub 2-0:1.0: USB hub found
[   16.181559] hub 2-0:1.0: 2 ports detected
[   16.204881] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   16.204888] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   16.204892] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   16.205007] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
[   16.205035] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001840
[   16.205281] usb usb3: configuration #1 chosen from 1 choice
[   16.205392] hub 3-0:1.0: USB hub found
[   16.205396] hub 3-0:1.0: 2 ports detected
[   16.225981] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   16.225990] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   16.225995] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   16.226115] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
[   16.226142] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
[   16.226421] usb usb4: configuration #1 chosen from 1 choice
[   16.226540] hub 4-0:1.0: USB hub found
[   16.226544] hub 4-0:1.0: 2 ports detected
[   16.231912] usb 1-1: new full speed USB device using uhci_hcd and address 2
[   16.250380] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   16.250390] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   16.250394] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   16.250528] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
[   16.250563] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
[   16.250856] usb usb5: configuration #1 chosen from 1 choice
[   16.250993] hub 5-0:1.0: USB hub found
[   16.250997] hub 5-0:1.0: 2 ports detected
[   16.269599] usb 1-1: configuration #1 chosen from 1 choice
[   16.270618] ahci 0000:00:1f.2: version 2.2
[   16.270639] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   16.342843] usb 2-1: new full speed USB device using uhci_hcd and address 2
[   16.386891] usb 2-1: configuration #1 chosen from 1 choice
[   16.509214] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
[   16.509220] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[   16.509228] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   16.509468] scsi0 : ahci
[   16.509504] scsi1 : ahci
[   16.509538] scsi2 : ahci
[   16.509607] ata1: SATA max UDMA/133 cmd 0xffffc2000060c100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 19
[   16.509611] ata2: SATA max UDMA/133 cmd 0xffffc2000060c180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 19
[   16.509614] ata3: SATA max UDMA/133 cmd 0xffffc2000060c200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 19
[   16.639150] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   16.640075] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7DP, max UDMA/100
[   16.640080] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   16.641182] ata1.00: configured for UDMA/100
[   16.705898] ata2: SATA link down (SStatus 0 SControl 300)
[   16.842438] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   16.843342] ata3.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7DP, max UDMA/100
[   16.843347] ata3.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   16.844453] ata3.00: configured for UDMA/100
[   16.844582] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[   16.844670] scsi 2:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[   16.845015] r8169 Gigabit Ethernet driver 2.2LK loaded
[   16.845043] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   16.845063] PCI: Setting latency timer of device 0000:04:00.0 to 64
[   16.845250] eth0: RTL8101e at 0xffffc2000060e000, 00:1b:38:40:b2:0c, XID 34000000 IRQ 17
[   16.846191] ACPI: PCI Interrupt 0000:0c:04.1[B] -> GSI 17 (level, low) -> IRQ 17
[   16.846243] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
[   16.847145] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   16.847150] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   16.847194] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
[   16.847229] ehci_hcd 0000:00:1a.7: debug port 1
[   16.847234] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   16.847241] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf8304800
[   16.851114] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   16.851188] usb usb6: configuration #1 chosen from 1 choice
[   16.851212] hub 6-0:1.0: USB hub found
[   16.851217] hub 6-0:1.0: 4 ports detected
[   16.896868] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[f8006000-f80067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   16.899624] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   16.899634] sd 0:0:0:0: [sda] Write Protect is off
[   16.899636] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   16.899646] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   16.899683] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   16.899689] sd 0:0:0:0: [sda] Write Protect is off
[   16.899690] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   16.899700] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   16.899703]  sda:<6>usb 1-1: USB disconnect, address 2
[   16.954453] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[   16.955558] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   16.955564] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   16.955605] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
[   16.955641] ehci_hcd 0000:00:1d.7: debug port 1
[   16.955647] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   16.955653] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf8304c00
[   16.959527] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   16.959599] usb usb7: configuration #1 chosen from 1 choice
[   16.959620] hub 7-0:1.0: USB hub found
[   16.959625] hub 7-0:1.0: 6 ports detected
[   17.062295] ata_piix 0000:00:1f.1: version 2.11
[   17.062315] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 19
[   17.062354] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   17.062575] scsi3 : ata_piix
[   17.062716] scsi4 : ata_piix
[   17.062773] ata4: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x00000000000118a0 irq 14
[   17.062776] ata5: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x00000000000118a8 irq 15
[   17.314711]  sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
[   17.390891] sd 0:0:0:0: [sda] Attached SCSI disk
[   17.391019] sd 2:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
[   17.391027] sd 2:0:0:0: [sdb] Write Protect is off
[   17.391028] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   17.391038] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   17.391066] sd 2:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
[   17.391071] sd 2:0:0:0: [sdb] Write Protect is off
[   17.391073] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   17.391082] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   17.391085]  sdb:<6>ata4.00: ATAPI: PIONEER DVD-RW DVR-K17LF, 4.53, max UDMA/33
[   17.521589] usb 6-3: new high speed USB device using ehci_hcd and address 3
[   17.585989] ata4.00: configured for UDMA/33
[   17.667541] usb 6-3: configuration #1 chosen from 1 choice
[   17.669546] usb 2-1: USB disconnect, address 2
[   17.761880] scsi 3:0:0:0: CD-ROM            PIONEER  DVD-RW DVR-K17LF 4.53 PQ: 0 ANSI: 5
[   17.803870]  sdb1 < sdb5 sdb6 sdb7 sdb8 sdb9 >
[   17.888337] sd 2:0:0:0: [sdb] Attached SCSI disk
[   17.890741] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.890756] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   17.890770] sr 3:0:0:0: Attached scsi generic sg2 type 5
[   17.939887] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   17.939894] Uniform CD-ROM driver Revision: 3.20
[   17.940185] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   18.036858] usb 1-1: new full speed USB device using uhci_hcd and address 3
[   18.165066] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f78ae402adb]
[   18.212958] usb 1-1: configuration #1 chosen from 1 choice
[   18.470995] Attempting manual resume
[   18.470998] swsusp: Resume From Partition 8:5
[   18.470999] PM: Checking swsusp image.
[   18.471167] PM: Resume from disk failed.
[   18.512569] kjournald starting.  Commit interval 5 seconds
[   18.512594] EXT3-fs: mounted filesystem with ordered data mode.
[   26.355167] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   26.413383] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   26.482213] Yenta: CardBus bridge found at 0000:0c:04.0 [1179:ff00]
[   26.482234] Yenta: Enabling burst memory read transactions
[   26.482239] Yenta: Using CSCINT to route CSC interrupts to PCI
[   26.482241] Yenta: Routing CardBus interrupts to PCI
[   26.482246] Yenta TI: socket 0000:0c:04.0, mfunc 0x10a01b22, devctl 0x64
[   26.583443] sdhci: Secure Digital Host Controller Interface driver
[   26.583446] sdhci: Copyright(c) Pierre Ossman
[   26.660484] Linux video capture interface: v2.00
[   26.713437] Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
[   26.713441] Socket status: 30000006
[   26.713443] Yenta: Raising subordinate bus# of parent bus (#0c) from #0d to #10
[   26.713449] pcmcia: parent PCI bridge I/O window: 0x7000 - 0x7fff
[   26.713451] pcmcia: parent PCI bridge Memory window: 0xf8000000 - 0xf80fffff
[   26.713453] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
[   26.713672] ACPI: PCI Interrupt 0000:0c:04.2[C] -> GSI 18 (level, low) -> IRQ 18
[   26.713748] sdhci: SDHCI controller found at 0000:0c:04.3 [104c:803c] (rev 0)
[   26.713766] ACPI: PCI Interrupt 0000:0c:04.3[C] -> GSI 18 (level, low) -> IRQ 18
[   26.714664] mmc0: SDHCI at 0xf8006800 irq 18 DMA
[   26.798920] uvcvideo: Found UVC 1.00 device Chicony USB 2.0 Camera (04f2:b008)
[   26.800775] usbcore: registered new interface driver uvcvideo
[   26.800780] USB Video Class driver (v0.1.0)
[   26.903625] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[   26.914486] [fglrx] Maximum main memory to use for locked dma buffers: 922 MBytes.
[   26.914516] [fglrx] ASYNCIO init succeed!
[   26.916177] [fglrx] PAT is enabled successfully!
[   26.916197] [fglrx] module loaded - fglrx 8.42.3 [Oct 19 2007] on minor 0
[   26.941994] iwl4965: Intel(R) Wireless WiFi Link 4965AGN driver for Linux, 1.1.0
[   26.941996] iwl4965: Copyright(c) 2003-2007 Intel Corporation
[   26.942091] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[   26.942120] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   26.942948] iwl4965: Detected Intel Wireless WiFi Link 4965AGN
[   27.186432] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
[   27.187339] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   27.276734] iwl4965: Tunable channels: 11 802.11bg, 13 802.11a channels
[   27.276889] wmaster0: Selected rate control algorithm 'iwl-4965-rs'
[   27.412430] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x9280b1, caps: 0xa04713/0x204000
[   27.503437] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[   27.567926] NET: Registered protocol family 17
[   28.502231] si3054: cannot initialize. EXT MID = 0000
[   29.655658] lp: driver loaded but no devices found
[   29.715679] Adding 8193108k swap on /dev/sda5.  Priority:-1 extents:1 across:8193108k
[   30.782690] EXT3 FS on sda7, internal journal
[   52.310792] kjournald starting.  Commit interval 5 seconds
[   52.311021] EXT3 FS on sda10, internal journal
[   52.311026] EXT3-fs: mounted filesystem with ordered data mode.
[   52.833655] kjournald starting.  Commit interval 5 seconds
[   52.833908] EXT3 FS on sda8, internal journal
[   52.833913] EXT3-fs: mounted filesystem with ordered data mode.
[   52.851652] kjournald starting.  Commit interval 5 seconds
[   52.851889] EXT3 FS on sda9, internal journal
[   52.851893] EXT3-fs: mounted filesystem with ordered data mode.
[   53.340203] kjournald starting.  Commit interval 5 seconds
[   53.380421] EXT3 FS on sda6, internal journal
[   53.380425] EXT3-fs: mounted filesystem with ordered data mode.
[   54.168409] ACPI: Battery Slot [BAT1] (battery present)
[   54.175174] No dock devices found.
[   54.240179] ACPI: AC Adapter [ACAD] (on-line)
[   54.259038] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   54.259443] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   54.306140] input: Power Button (FF) as /class/input/input3
[   54.306155] ACPI: Power Button (FF) [PWRF]
[   54.306186] input: Lid Switch as /class/input/input4
[   54.306196] ACPI: Lid Switch [LID0]
[   54.306221] input: Power Button (CM) as /class/input/input5
[   54.306231] ACPI: Power Button (CM) [PWRB]
[   55.523426] ppdev: user-space parallel port driver
[   55.662036] r8169: eth0: link up
[   55.662052] r8169: eth0: link up
[   55.789764] audit(1193661980.307:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5451 profile="/usr/sbin/cupsd"
[   56.189221] Failure registering capabilities with primary security module.
[   56.458213] Bluetooth: Core ver 2.11
[   56.458305] NET: Registered protocol family 31
[   56.458310] Bluetooth: HCI device and connection manager initialized
[   56.458357] Bluetooth: HCI socket layer initialized
[   56.495208] Bluetooth: L2CAP ver 2.8
[   56.495216] Bluetooth: L2CAP socket layer initialized
[   56.566836] Bluetooth: RFCOMM socket layer initialized
[   56.566864] Bluetooth: RFCOMM TTY layer initialized
[   56.566869] Bluetooth: RFCOMM ver 1.8
[   58.001010] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   60.188941] [fglrx] Reserve Block - 0 offset =  0Xfffb000 length = 0X5000
[   60.188952] [fglrx] Reserve Block - 1 offset =  0X0 length = 0X1000000
[   60.188959] [fglrx] Reserve Block - 2 offset =  0Xff7a000 length = 0X80000
[   60.422558] [fglrx] interrupt source 60000001 successfully enabled
[   60.422567] [fglrx] enable ID = 0x00000006
[   60.422923] [fglrx] Receive enable interrupt message with irqEnableMask: 60000001
[   60.423248] [fglrx] interrupt source 00000040 successfully enabled
[   60.423254] [fglrx] enable ID = 0x00000007
[   60.423552] [fglrx] Receive enable interrupt message with irqEnableMask: 00000040
[   60.424134] [fglrx] interrupt source ff00002c successfully enabled
[   60.424140] [fglrx] enable ID = 0x00000008
[   60.424443] [fglrx] Receive enable interrupt message with irqEnableMask: ff00002c
[   60.424728] [fglrx] interrupt source ff00002d successfully enabled
[   60.424733] [fglrx] enable ID = 0x00000009
[   60.425033] [fglrx] Receive enable interrupt message with irqEnableMask: ff00002d
[   60.425318] [fglrx] interrupt source 20000400 successfully enabled
[   60.425324] [fglrx] enable ID = 0x0000000A
[   60.425622] [fglrx] Receive enable interrupt message with irqEnableMask: 20000400
[   62.284504] NET: Registered protocol family 10
[   62.284888] lo: Disabled Privacy Extensions
[   62.285169] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   66.866923] eth0: no IPv6 routers present
[   72.834190] ata1.00: exception Emask 0x2 SAct 0x6b SErr 0x0 action 0x2 frozen
[   72.834205] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x6b FIS=005040a1:00000004)
[   72.834219] ata1.00: cmd 60/08:00:32:a6:43/00:00:07:00:00/40 tag 0 cdb 0x0 data 4096 in
[   72.834223]          res 50/00:08:4a:63:90/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   72.834235] ata1.00: cmd 60/20:08:72:99:b0/00:00:07:00:00/40 tag 1 cdb 0x0 data 16384 in
[   72.834238]          res 50/00:08:4a:63:90/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   72.834250] ata1.00: cmd 60/08:18:4a:63:90/00:00:06:00:00/40 tag 3 cdb 0x0 data 4096 in
[   72.834253]          res 50/00:08:4a:63:90/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   72.834265] ata1.00: cmd 60/00:28:62:bc:43/01:00:07:00:00/40 tag 5 cdb 0x0 data 131072 in
[   72.834269]          res 50/00:08:4a:63:90/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   72.834281] ata1.00: cmd 60/08:30:2a:a3:c5/00:00:07:00:00/40 tag 6 cdb 0x0 data 4096 in
[   72.834284]          res 50/00:08:4a:63:90/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   72.860672] ata1: soft resetting port
[   72.868589] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   72.869560] ata1.00: configured for UDMA/100
[   72.869594] ata1: EH complete
[   72.869879] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   72.870080] sd 0:0:0:0: [sda] Write Protect is off
[   72.870085] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   72.870359] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.364545] ata1.00: exception Emask 0x2 SAct 0x81 SErr 0x0 action 0x2 frozen
[   77.364553] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x81 FIS=005040a1:00000400)
[   77.364562] ata1.00: cmd 60/48:00:82:6d:a4/00:00:07:00:00/40 tag 0 cdb 0x0 data 36864 in
[   77.364565]          res 50/00:48:82:6d:a4/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   77.364573] ata1.00: cmd 60/08:38:aa:dd:41/00:00:07:00:00/40 tag 7 cdb 0x0 data 4096 in
[   77.364575]          res 50/00:48:82:6d:a4/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   77.385322] ata1: soft resetting port
[   77.393184] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   77.395237] ata1.00: configured for UDMA/100
[   77.395255] ata1: EH complete
[   77.395522] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   77.395724] sd 0:0:0:0: [sda] Write Protect is off
[   77.395730] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   77.396007] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   78.237317] ata1.00: exception Emask 0x2 SAct 0x3a SErr 0x0 action 0x2 frozen
[   78.237328] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x3a FIS=005040a1:00000001)
[   78.237342] ata1.00: cmd 60/90:08:da:8f:a7/00:00:07:00:00/40 tag 1 cdb 0x0 data 73728 in
[   78.237345]          res 50/00:90:da:8f:a7/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   78.237358] ata1.00: cmd 60/e0:18:32:1e:88/00:00:06:00:00/40 tag 3 cdb 0x0 data 114688 in
[   78.237361]          res 50/00:90:da:8f:a7/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   78.237373] ata1.00: cmd 60/00:20:2a:27:88/01:00:06:00:00/40 tag 4 cdb 0x0 data 131072 in
[   78.237376]          res 50/00:90:da:8f:a7/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   78.237388] ata1.00: cmd 60/20:28:02:67:af/00:00:07:00:00/40 tag 5 cdb 0x0 data 16384 in
[   78.237391]          res 50/00:90:da:8f:a7/00:00:07:00:00/40 Emask 0x2 (HSM violation)
[   78.261595] ata1: soft resetting port
[   78.284712] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   78.286743] ata1.00: configured for UDMA/100
[   78.286771] ata1: EH complete
[   78.287015] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   78.287183] sd 0:0:0:0: [sda] Write Protect is off
[   78.287189] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   78.287502] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  125.910062] Xgl[6120]: segfault at 0000000000000010 rip 00002b319d00cff8 rsp 00007fff0ed77480 error 6
[  126.393517] [fglrx] interrupt source 20000400 successfully disabled!
[  126.393525] [fglrx] enable ID = 0x00000000
[  126.393529] [fglrx] Receive disable interrupt message with irqEnableMask: 20000400; dwIRQEnableId: 0000000a
[  126.393545] [fglrx] interrupt source ff00002d successfully disabled!
[  126.393548] [fglrx] enable ID = 0x00000000
[  126.393552] [fglrx] Receive disable interrupt message with irqEnableMask: ff00002d; dwIRQEnableId: 00000009
[  126.393565] [fglrx] interrupt source ff00002c successfully disabled!
[  126.393568] [fglrx] enable ID = 0x00000000
[  126.393571] [fglrx] Receive disable interrupt message with irqEnableMask: ff00002c; dwIRQEnableId: 00000008
[  126.393584] [fglrx] interrupt source 00000040 successfully disabled!
[  126.393587] [fglrx] enable ID = 0x00000000
[  126.393590] [fglrx] Receive disable interrupt message with irqEnableMask: 00000040; dwIRQEnableId: 00000007
[  126.393603] [fglrx] interrupt source 60000001 successfully disabled!
[  126.393606] [fglrx] enable ID = 0x00000000
[  126.393610] [fglrx] Receive disable interrupt message with irqEnableMask: 60000001; dwIRQEnableId: 00000006
[  129.627049] [fglrx] PCIe has already been initialized. Reinitializing ...
[  129.648836] [fglrx] Reserve Block - 0 offset =  0Xfffb000 length = 0X5000
[  129.648847] [fglrx] Reserve Block - 1 offset =  0X0 length = 0X1000000
[  129.648849] [fglrx] Reserve Block - 2 offset =  0Xff7a000 length = 0X80000
[  129.945215] [fglrx] interrupt source ff00002c successfully enabled
[  129.945226] [fglrx] enable ID = 0x00000006
[  129.945233] [fglrx] Receive enable interrupt message with irqEnableMask: ff00002c
[  129.945278] [fglrx] interrupt source ff00002d successfully enabled
[  129.945280] [fglrx] enable ID = 0x00000007
[  129.945283] [fglrx] Receive enable interrupt message with irqEnableMask: ff00002d
[  129.945308] [fglrx] interrupt source 20000400 successfully enabled
[  129.945310] [fglrx] enable ID = 0x00000008
[  129.945313] [fglrx] Receive enable interrupt message with irqEnableMask: 20000400
[  142.345580] ata1.00: NCQ disabled due to excessive errors
[  142.345594] ata1.00: exception Emask 0x2 SAct 0x3fe1 SErr 0x0 action 0x2 frozen
[  142.345602] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x3fe1 FIS=005040a1:00000010)
[  142.345615] ata1.00: cmd 61/70:00:a5:55:91/00:00:05:00:00/40 tag 0 cdb 0x0 data 57344 out
[  142.345619]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345631] ata1.00: cmd 61/10:28:5a:1b:73/00:00:07:00:00/40 tag 5 cdb 0x0 data 8192 out
[  142.345635]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345647] ata1.00: cmd 61/08:30:d2:1b:73/00:00:07:00:00/40 tag 6 cdb 0x0 data 4096 out
[  142.345650]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345662] ata1.00: cmd 61/08:38:e2:1b:73/00:00:07:00:00/40 tag 7 cdb 0x0 data 4096 out
[  142.345666]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345677] ata1.00: cmd 61/08:40:f2:1b:73/00:00:07:00:00/40 tag 8 cdb 0x0 data 4096 out
[  142.345681]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345693] ata1.00: cmd 61/10:48:fa:1b:73/00:00:07:00:00/40 tag 9 cdb 0x0 data 8192 out
[  142.345696]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345708] ata1.00: cmd 61/08:50:02:1d:73/00:00:07:00:00/40 tag 10 cdb 0x0 data 4096 out
[  142.345712]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345724] ata1.00: cmd 61/08:58:12:1d:73/00:00:07:00:00/40 tag 11 cdb 0x0 data 4096 out
[  142.345727]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345739] ata1.00: cmd 61/08:60:42:1d:73/00:00:07:00:00/40 tag 12 cdb 0x0 data 4096 out
[  142.345743]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.345755] ata1.00: cmd 61/28:68:4a:1d:73/00:00:07:00:00/40 tag 13 cdb 0x0 data 20480 out
[  142.345759]          res 50/00:70:a5:55:91/00:00:05:00:00/40 Emask 0x2 (HSM violation)
[  142.394522] ata1: soft resetting port
[  142.409376] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  142.411440] ata1.00: configured for UDMA/100
[  142.411481] ata1: EH complete
[  142.414817] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  142.415287] sd 0:0:0:0: [sda] Write Protect is off
[  142.415293] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  142.417628] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

--------------090807030802010002040401--
