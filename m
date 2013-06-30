From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: New motherboard not detecting all memory
Date: Sun, 30 Jun 2013 11:31:40 +0100
Message-ID: <51D0090C.90402@communistcode.co.uk>
References: <51CFF92C.8090404@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080003060809030408060301"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:49916 "EHLO owm.eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab3F3Kb4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jun 2013 06:31:56 -0400
In-Reply-To: <51CFF92C.8090404@communistcode.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ml@communistcode.co.uk
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080003060809030408060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 30/06/2013 10:23, Jack Mitchell wrote:
> I recently bought a new AMD FM2 motherboard[1] and coupled it with an
> AMD A4 APU. I put 2x2GB sticks of RAM in the board, and the UEFI bios
> detects both sticks and reports 4GB. Now, when I boot into a fresh
> install of Linux [2] only 1501MB is reported as available.
>
> I was told this may be an ACPI problem, I have updated the motherboard
> to the latest BIOS revision which works. Could anyone shed any light on
> this, or where I should make a start in helping to debug the problem?
>
> Kind Regards,
> Jack.
>
> [1] http://www.gigabyte.com/products/product-page.aspx?pid=4383&dl=#ov
> [2] Linux mediaserver 3.9.7-1-ARCH #1 SMP PREEMPT Thu Jun 20 22:45:32
> CEST 2013 x86_64 GNU/Linux
>
>

I have attached the dmidecode output in case that is of any help; I can 
see that it is only registering one bank of RAM, so detection of RAM 
seems to be the issue; but I don't know what is causing it.

I have also attached a dmesg.

Cheers,
Jack.

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

-- 

--------------080003060809030408060301
Content-Type: text/plain; charset=windows-1252;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmidecode"

# dmidecode 2.12
SMBIOS 2.7 present.
52 structures occupying 2261 bytes.
Table at 0x000EB2C0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: F2
	Release Date: 01/31/2013
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 8192 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 4.6

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: To be filled by O.E.M.
	Version: To be filled by O.E.M.
	Serial Number: To be filled by O.E.M.
	UUID: 032B0290-0434-05AB-D006-EB0700080009
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: F2A85XM-D3H
	Version: To be filled by O.E.M.
	Serial Number: To be filled by O.E.M.
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Type: Desktop
	Lock: Not Present
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0005, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0006, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: TV Out
	External Connector Type: Mini Centronics Type-14
	Port Type: Other

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2A
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2B
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9A1 - TPM HDR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9C1 - PCIE DOCKING CONN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2B3 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6C2 - EXT HDMI
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3C1 - GMCH FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1D1 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E2 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E4 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E3 - LPC HOT DOCKING
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E1 - SCAN MATRIX
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G1 - LPC SIDE BAND
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8F1 - UNIFIED
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6F1 - LVDS
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2F1 - LAI FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2G1 - GFX VID
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1G6 - AC JACK
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 9, 17 bytes
System Slot Information
	Designation: J6B2
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Long
	ID: 0
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:02.0

Handle 0x001D, DMI type 9, 17 bytes
System Slot Information
	Designation: J6B1
	Type: x1 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:1c.0

Handle 0x001E, DMI type 9, 17 bytes
System Slot Information
	Designation: J6D1
	Type: x8 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:01.0

Handle 0x001F, DMI type 9, 17 bytes
System Slot Information
	Designation: J7B1
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:03.0

Handle 0x0020, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:    To Be Filled By O.E.M.

Handle 0x0021, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.

Handle 0x0022, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x0023, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0024, DMI type 19, 31 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0023
	Partition Width: 255

Handle 0x0025, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm0
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: Dimm0_Manufacturer
	Serial Number: Dimm0_SerNum
	Asset Tag: Dimm0_AssetTag
	Part Number: Dimm0_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x0026, DMI type 126, 35 bytes
Inactive

Handle 0x0027, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm1
	Bank Locator: Node0_Bank0
	Type: DDR3
	Type Detail: Synchronous Unbuffered (Unregistered)
	Speed: 667 MHz
	Manufacturer: Corsair           
	Serial Number: 00000000    
	Asset Tag: Dimm1_AssetTag
	Part Number: CMX4GX3M2A160
	Rank: 2
	Configured Clock Speed: 29629 MHz

Handle 0x0028, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0027
	Memory Array Mapped Address Handle: 0x0024
	Partition Row Position: 1

Handle 0x0029, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm2
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm2_Manufacturer
	Serial Number: Dimm2_SerNum
	Asset Tag: Dimm2_AssetTag
	Part Number: Dimm2_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x002A, DMI type 126, 35 bytes
Inactive

Handle 0x002B, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm3
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm3_Manufacturer
	Serial Number: Dimm3_SerNum
	Asset Tag: Dimm3_AssetTag
	Part Number: Dimm3_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x002C, DMI type 126, 35 bytes
Inactive

Handle 0x002D, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x002E, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard LAN
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:19.0

Handle 0x002F, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 CACHE
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 96 kB
	Maximum Size: 96 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: 1 ns
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 2-way Set-associative

Handle 0x0030, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 CACHE
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1024 kB
	Maximum Size: 1024 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: 1 ns
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0035, DMI type 4, 42 bytes
Processor Information
	Socket Designation: P0
	Type: Central Processor
	Family: A-Series
	Manufacturer: AuthenticAMD
	ID: 31 0F 61 00 FF FB 8B 17
	Signature: Family 21, Model 19, Stepping 1
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
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Multi-threading)
	Version: AMD A4-4000 APU with Radeon(tm) HD Graphics    
	Voltage: 1.3 V
	External Clock: 100 MHz
	Max Speed: 3000 MHz
	Current Speed: 3000 MHz
	Status: Populated, Enabled
	Upgrade: Socket FM2
	L1 Cache Handle: 0x002F
	L2 Cache Handle: 0x0030
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 2
	Core Enabled: 2
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0036, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x003A, DMI type 127, 4 bytes
End Of Table


--------------080003060809030408060301
Content-Type: text/plain; charset=windows-1252;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.9.7-1-ARCH (tobias@T-POWA-LX) (gcc version 4.8.1 (GCC) ) #1 SMP PREEMPT Thu Jun 20 22:45:32 CEST 2013
[    0.000000] Command line: root=UUID=9ab40762-8eef-45ef-96fd-6a00cf13dc21 ro initrd=../initramfs-linux.img BOOT_IMAGE=../vmlinuz-linux 
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005d77efff] usable
[    0.000000] BIOS-e820: [mem 0x000000005d77f000-0x000000005da5ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005da60000-0x000000005ddb7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005ddb8000-0x000000005e179fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005e17a000-0x000000005e17afff] usable
[    0.000000] BIOS-e820: [mem 0x000000005e17b000-0x000000005e380fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005e381000-0x000000005e7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A85XM-D3H, BIOS F2 01/31/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x5e800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 00005E800000 mask FFFFFF800000 uncachable
[    0.000000]   2 base 00005F000000 mask FFFFFF000000 uncachable
[    0.000000]   3 base 000060000000 mask FFFFE0000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] found SMP MP-table at [mem 0x000fd760-0x000fd76f] mapped at [ffff8800000fd760]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b30000, 0x01b30fff] PGTABLE
[    0.000000] BRK [0x01b31000, 0x01b31fff] PGTABLE
[    0.000000] BRK [0x01b32000, 0x01b32fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x5e600000-0x5e7fffff]
[    0.000000]  [mem 0x5e600000-0x5e7fffff] page 2M
[    0.000000] BRK [0x01b33000, 0x01b33fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x5c000000-0x5d77efff]
[    0.000000]  [mem 0x5c000000-0x5d5fffff] page 2M
[    0.000000]  [mem 0x5d600000-0x5d77efff] page 4k
[    0.000000] BRK [0x01b34000, 0x01b34fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x5e17a000-0x5e17afff]
[    0.000000]  [mem 0x5e17a000-0x5e17afff] page 4k
[    0.000000] init_memory_mapping: [mem 0x5e381000-0x5e5fffff]
[    0.000000]  [mem 0x5e381000-0x5e3fffff] page 4k
[    0.000000]  [mem 0x5e400000-0x5e5fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x5bffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x5bffffff] page 2M
[    0.000000] RAMDISK: [mem 0x5c990000-0x5d77dfff]
[    0.000000] ACPI: RSDP 00000000000f0490 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 000000005dda1080 0007C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 000000005dda71c0 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI BIOS Bug: Warning: Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20130117/tbfadt-599)
[    0.000000] ACPI: DSDT 000000005dda1190 06029 (v02 ALASKA    A M I 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 000000005ddb0d80 00040
[    0.000000] ACPI: APIC 000000005dda72b8 00072 (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 000000005dda7330 00044 (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 000000005dda7378 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 000000005dda73b8 00038 (v01 ALASKA    A M I 01072009 AMI  00000005)
[    0.000000] ACPI: IFEU 000000005dda73f0 00042 (v01 ALASKA    A M I 01072009      00000000)
[    0.000000] ACPI: SSDT 000000005dda7438 006B2 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 000000005dda7af0 004B7 (v02    AMD     ALIB 00000001 MSFT 04000000)
[    0.000000] ACPI: IVRS 000000005dda7fa8 00070 (v02  AMD   AMDIOMMU 00000001 AMD  00000000)
[    0.000000] ACPI: CRAT 000000005dda8018 001A8 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: BGRT 000000005dda81c0 00038 (v00 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000005e7fffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x5e7fffff]
[    0.000000]   NODE_DATA [mem 0x5e7f9000-0x5e7fdfff]
[    0.000000]  [ffffea0000000000-ffffea00017fffff] PMD -> [ffff88005ac00000-ffff88005c3fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x5d77efff]
[    0.000000]   node   0: [mem 0x5e17a000-0x5e17afff]
[    0.000000]   node   0: [mem 0x5e381000-0x5e7fffff]
[    0.000000] On node 0 totalpages: 383900
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 5984 pages used for memmap
[    0.000000]   DMA32 zone: 379903 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x14] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x15] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 3, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 000000000009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000005d77f000 - 000000005da60000
[    0.000000] PM: Registered nosave memory: 000000005da60000 - 000000005ddb8000
[    0.000000] PM: Registered nosave memory: 000000005ddb8000 - 000000005e17a000
[    0.000000] PM: Registered nosave memory: 000000005e17b000 - 000000005e381000
[    0.000000] e820: [mem 0x5e800000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88005e400000 s85824 r8192 d20672 u524288
[    0.000000] pcpu-alloc: s85824 r8192 d20672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 377831
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=UUID=9ab40762-8eef-45ef-96fd-6a00cf13dc21 ro initrd=../initramfs-linux.img BOOT_IMAGE=../vmlinuz-linux 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ 0 size 32 MB
[    0.000000] Memory: 1484464k/1548288k available (4984k kernel code, 12688k absent, 51136k reserved, 3966k data, 1092k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] NR_IRQS:4352 nr_irqs:712 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 6291456 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.003333] tsc: Detected 2999.946 MHz processor
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 6002.88 BogoMIPS (lpj=9999820)
[    0.000005] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000048] AppArmor: AppArmor disabled by boot time parameter
[    0.000204] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000869] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.001169] Mount-cache hash table entries: 256
[    0.001365] Initializing cgroup subsys cpuacct
[    0.001368] Initializing cgroup subsys memory
[    0.001379] Initializing cgroup subsys devices
[    0.001381] Initializing cgroup subsys freezer
[    0.001382] Initializing cgroup subsys net_cls
[    0.001384] Initializing cgroup subsys blkio
[    0.001410] tseg: 005e800000
[    0.001412] CPU: Physical Processor ID: 0
[    0.001413] CPU: Processor Core ID: 0
[    0.001414] mce: CPU supports 7 MCE banks
[    0.001426] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512
tlb_flushall_shift: 5
[    0.001517] Freeing SMP alternatives: 20k freed
[    0.002241] ACPI: Core revision 20130117
[    0.004837] ACPI: All ACPI Tables successfully acquired
[    0.018447] ftrace: allocating 19550 entries in 77 pages
[    0.110791] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.143766] smpboot: CPU0: AMD A4-4000 APU with Radeon(tm) HD Graphics (fam: 15, model: 13, stepping: 01)
[    0.249453] Performance Events: 
[    0.249455] perf: AMD core performance counters detected
[    0.249456] perf: AMD northbridge performance counters detected
[    0.249460] AMD PMU driver.
[    0.249462] ... version:                0
[    0.249463] ... bit width:              48
[    0.249464] ... generic registers:      10
[    0.249465] ... value mask:             0000ffffffffffff
[    0.249466] ... max period:             00007fffffffffff
[    0.249467] ... fixed-purpose events:   0
[    0.249469] ... event mask:             00000000000003ff
[    0.282877] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.289565] smpboot: Booting Node   0, Processors  #1
[    0.302705] Brought up 2 CPUs
[    0.302710] smpboot: Total of 2 processors activated (12004.77 BogoMIPS)
[    0.303217] devtmpfs: initialized
[    0.304362] PM: Registering ACPI NVS region [mem 0x5da60000-0x5ddb7fff] (3506176 bytes)
[    0.304422] PM: Registering ACPI NVS region [mem 0x5e17b000-0x5e380fff] (2121728 bytes)
[    0.305179] RTC time: 17:06:41, date: 06/30/13
[    0.305227] NET: Registered protocol family 16
[    0.305370] ACPI: bus type PCI registered
[    0.305428] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.305430] PCI: not using MMCONFIG
[    0.305432] PCI: Using configuration type 1 for base access
[    0.305433] PCI: Using configuration type 1 for extended access
[    0.305978] bio: create slab <bio-0> at 0
[    0.306065] ACPI: Added _OSI(Module Device)
[    0.306067] ACPI: Added _OSI(Processor Device)
[    0.306068] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.306069] ACPI: Added _OSI(Processor Aggregator Device)
[    0.307068] ACPI: EC: Look up EC in DSDT
[    0.308351] ACPI: Executed 1 blocks of module-level executable AML code
[    0.311038] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.311516] ACPI: Interpreter enabled
[    0.311522] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20130117/hwxface-568)
[    0.311527] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130117/hwxface-568)
[    0.311539] ACPI: (supports S0 S3 S4 S5)
[    0.311540] ACPI: Using IOAPIC for interrupt routing
[    0.311685] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.311725] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.324824] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.331713] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.332115] PCI host bridge to bus 0000:00
[    0.332118] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.332121] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.332123] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.332125] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.332127] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.332128] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.332130] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.332132] pci_bus 0000:00: root bus resource [mem 0x7f000000-0xffffffff]
[    0.332139] pci 0000:00:00.0: [1022:1410] type 00 class 0x060000
[    0.332225] pci 0000:00:00.2: [1022:1419] type 00 class 0x080600
[    0.332335] pci 0000:00:01.0: [1002:9993] type 00 class 0x030000
[    0.332343] pci 0000:00:01.0: reg 10: [mem 0xc0000000-0xcfffffff pref]
[    0.332348] pci 0000:00:01.0: reg 14: [io  0xf000-0xf0ff]
[    0.332353] pci 0000:00:01.0: reg 18: [mem 0xfef00000-0xfef3ffff]
[    0.332387] pci 0000:00:01.0: supports D1 D2
[    0.332462] pci 0000:00:01.1: [1002:9902] type 00 class 0x040300
[    0.332469] pci 0000:00:01.1: reg 10: [mem 0xfef44000-0xfef47fff]
[    0.332508] pci 0000:00:01.1: supports D1 D2
[    0.332587] pci 0000:00:04.0: [1022:1414] type 01 class 0x060400
[    0.332627] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.332681] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.332743] pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330
[    0.332761] pci 0000:00:10.0: reg 10: [mem 0xfef4a000-0xfef4bfff 64bit]
[    0.332851] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.332893] pci 0000:00:10.0: System wakeup disabled by ACPI
[    0.332940] pci 0000:00:10.1: [1022:7812] type 00 class 0x0c0330
[    0.332958] pci 0000:00:10.1: reg 10: [mem 0xfef48000-0xfef49fff 64bit]
[    0.333048] pci 0000:00:10.1: PME# supported from D0 D3hot D3cold
[    0.333091] pci 0000:00:10.1: System wakeup disabled by ACPI
[    0.333137] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601
[    0.333153] pci 0000:00:11.0: reg 10: [io  0xf140-0xf147]
[    0.333161] pci 0000:00:11.0: reg 14: [io  0xf130-0xf133]
[    0.333169] pci 0000:00:11.0: reg 18: [io  0xf120-0xf127]
[    0.333177] pci 0000:00:11.0: reg 1c: [io  0xf110-0xf113]
[    0.333185] pci 0000:00:11.0: reg 20: [io  0xf100-0xf10f]
[    0.333193] pci 0000:00:11.0: reg 24: [mem 0xfef51000-0xfef517ff]
[    0.333287] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310
[    0.333298] pci 0000:00:12.0: reg 10: [mem 0xfef50000-0xfef50fff]
[    0.333360] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.333399] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320
[    0.333415] pci 0000:00:12.2: reg 10: [mem 0xfef4f000-0xfef4f0ff]
[    0.333483] pci 0000:00:12.2: supports D1 D2
[    0.333485] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.333509] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.333547] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310
[    0.333558] pci 0000:00:13.0: reg 10: [mem 0xfef4e000-0xfef4efff]
[    0.333623] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.333662] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320
[    0.333678] pci 0000:00:13.2: reg 10: [mem 0xfef4d000-0xfef4d0ff]
[    0.333746] pci 0000:00:13.2: supports D1 D2
[    0.333747] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.333774] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.333814] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500
[    0.333938] pci 0000:00:14.2: [1022:780d] type 00 class 0x040300
[    0.333956] pci 0000:00:14.2: reg 10: [mem 0xfef40000-0xfef43fff 64bit]
[    0.334011] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.334028] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.334061] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100
[    0.334153] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401
[    0.334195] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.334229] pci 0000:00:14.5: [1022:7809] type 00 class 0x0c0310
[    0.334241] pci 0000:00:14.5: reg 10: [mem 0xfef4c000-0xfef4cfff]
[    0.334312] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.334349] pci 0000:00:18.0: [1022:1400] type 00 class 0x060000
[    0.334428] pci 0000:00:18.1: [1022:1401] type 00 class 0x060000
[    0.334505] pci 0000:00:18.2: [1022:1402] type 00 class 0x060000
[    0.334581] pci 0000:00:18.3: [1022:1403] type 00 class 0x060000
[    0.334671] pci 0000:00:18.4: [1022:1404] type 00 class 0x060000
[    0.334749] pci 0000:00:18.5: [1022:1405] type 00 class 0x060000
[    0.334886] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
[    0.334899] pci 0000:01:00.0: reg 10: [io  0xe000-0xe0ff]
[    0.334920] pci 0000:01:00.0: reg 18: [mem 0xd0004000-0xd0004fff 64bit pref]
[    0.334933] pci 0000:01:00.0: reg 20: [mem 0xd0000000-0xd0003fff 64bit pref]
[    0.334987] pci 0000:01:00.0: supports D1 D2
[    0.334989] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.335019] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.339395] pci 0000:00:04.0: PCI bridge to [bus 01]
[    0.339403] pci 0000:00:04.0:   bridge window [io  0xe000-0xefff]
[    0.339408] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.339493] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    0.339501] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.339503] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.339505] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.339507] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.339508] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.339510] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.339512] pci 0000:00:14.4:   bridge window [mem 0x7f000000-0xffffffff] (subtractive decode)
[    0.339652] acpi PNP0A03:00: Requesting ACPI _OSC control (0x1d)
[    0.339838] acpi PNP0A03:00: ACPI _OSC control (0x1d) granted
[    0.340533] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.340605] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.340679] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.340752] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.340812] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.340860] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.340907] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.340955] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.341118] acpi root: \_SB_.PCI0 notify handler is installed
[    0.341158] Found 1 acpi root devices
[    0.341271] ACPI: No dock devices found.
[    0.341341] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    0.341347] vgaarb: loaded
[    0.341348] vgaarb: bridge control possible 0000:00:01.0
[    0.341382] PCI: Using ACPI for IRQ routing
[    0.348368] PCI: pci_cache_line_size set to 64 bytes
[    0.348417] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.348419] e820: reserve RAM buffer [mem 0x5d77f000-0x5fffffff]
[    0.348420] e820: reserve RAM buffer [mem 0x5e17b000-0x5fffffff]
[    0.348422] e820: reserve RAM buffer [mem 0x5e800000-0x5fffffff]
[    0.348516] NetLabel: Initializing
[    0.348518] NetLabel:  domain hash size = 128
[    0.348519] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.348530] NetLabel:  unlabeled traffic allowed by default
[    0.348545] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.348549] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.350572] Switching to clocksource hpet
[    0.356406] pnp: PnP ACPI init
[    0.356426] ACPI: bus type PNP registered
[    0.356547] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.356551] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.356878] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.356880] system 00:01: [io  0x040b] has been reserved
[    0.356882] system 00:01: [io  0x04d6] has been reserved
[    0.356885] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.356887] system 00:01: [io  0x0c14] has been reserved
[    0.356889] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.356891] system 00:01: [io  0x0c52] has been reserved
[    0.356892] system 00:01: [io  0x0c6c] has been reserved
[    0.356894] system 00:01: [io  0x0c6f] has been reserved
[    0.356896] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.356898] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.356900] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.356902] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.356908] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.356910] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.356913] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.356914] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.356916] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.356918] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.356921] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.356923] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.356926] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.356928] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.356930] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.356932] system 00:01: [mem 0xfed00000-0xfed00fff] has been reserved
[    0.356934] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.356937] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.357105] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.357108] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.357110] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.357112] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.357415] pnp 00:03: [dma 0 disabled]
[    0.357464] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.357781] pnp 00:04: [dma 0 disabled]
[    0.357898] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.357910] pnp 00:05: [dma 4]
[    0.357930] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.357962] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.357985] pnp 00:07: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.358044] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.358047] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.358076] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.358114] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.358265] system 00:0b: [mem 0x5f000000-0x7effffff] could not be reserved
[    0.358268] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.358352] system 00:0c: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    0.358354] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.358514] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.358517] pnp: PnP ACPI: found 14 devices
[    0.358519] ACPI: bus type PNP unregistered
[    0.365177] pci 0000:00:04.0: PCI bridge to [bus 01]
[    0.365181] pci 0000:00:04.0:   bridge window [io  0xe000-0xefff]
[    0.365186] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.365190] pci 0000:00:14.4: PCI bridge to [bus 02]
[    0.365292] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.365294] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.365296] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.365298] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.365300] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.365302] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.365304] pci_bus 0000:00: resource 10 [mem 0x7f000000-0xffffffff]
[    0.365306] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.365308] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.365310] pci_bus 0000:02: resource 4 [io  0x0000-0x03af]
[    0.365311] pci_bus 0000:02: resource 5 [io  0x03e0-0x0cf7]
[    0.365313] pci_bus 0000:02: resource 6 [io  0x03b0-0x03df]
[    0.365315] pci_bus 0000:02: resource 7 [io  0x0d00-0xffff]
[    0.365316] pci_bus 0000:02: resource 8 [mem 0x000a0000-0x000bffff]
[    0.365318] pci_bus 0000:02: resource 9 [mem 0x000c0000-0x000dffff]
[    0.365320] pci_bus 0000:02: resource 10 [mem 0x7f000000-0xffffffff]
[    0.365350] NET: Registered protocol family 2
[    0.365528] TCP established hash table entries: 16384 (order: 6, 262144 bytes)
[    0.365615] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.365675] TCP: Hash tables configured (established 16384 bind 16384)
[    0.365709] TCP: reno registered
[    0.365717] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.365729] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.365797] NET: Registered protocol family 1
[    0.365811] pci 0000:00:01.0: Boot video device
[    0.597201] PCI: CLS 64 bytes, default 64
[    0.597256] Unpacking initramfs...
[    0.845748] Freeing initrd memory: 14264k freed
[    0.849897] AMD-Vi: Applying erratum 746 workaround for IOMMU at 0000:00:00.2
[    0.850134] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    0.850136] AMD-Vi:  Extended features:  PreF PPR GT IA
[    0.850140] AMD-Vi: Interrupt remapping enabled
[    0.850169] pci 0000:00:00.2: irq 40 for MSI/MSI-X
[    0.861657] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.862358] LVT offset 0 assigned for vector 0x400
[    0.862383] perf: AMD IBS detected (0x000000ff)
[    0.862411] Scanning for low memory corruption every 60 seconds
[    0.862619] audit: initializing netlink socket (disabled)
[    0.862638] type=2000 audit(1372612000.666:1): initialized
[    0.873869] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.875382] VFS: Disk quotas dquot_6.5.2
[    0.875426] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.875610] msgmni has been set to 2927
[    0.875833] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.875864] io scheduler noop registered
[    0.875866] io scheduler deadline registered
[    0.875873] io scheduler cfq registered (default)
[    0.875998] pcieport 0000:00:04.0: irq 41 for MSI/MSI-X
[    0.876062] pcieport 0000:00:04.0: Signaling PME through PCIe PME interrupt
[    0.876064] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.876067] pcie_pme 0000:00:04.0:pcie01: service driver pcie_pme loaded
[    0.876169] GHES: HEST is not enabled!
[    0.876217] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.896713] 00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.897112] Linux agpgart interface v0.103
[    0.897157] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.897523] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.897553] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.897653] mousedev: PS/2 mouse device common for all mice
[    0.897704] rtc_cmos 00:06: RTC can wake from S4
[    0.897810] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    0.897832] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.897839] cpuidle: using governor ladder
[    0.897841] cpuidle: using governor menu
[    0.897843] EFI Variables Facility v0.08 2004-May-17
[    0.897890] drop_monitor: Initializing network drop monitor service
[    0.897953] TCP: cubic registered
[    0.898048] NET: Registered protocol family 10
[    0.898188] NET: Registered protocol family 17
[    0.898201] Key type dns_resolver registered
[    0.898441] PM: Hibernation image not present or could not be loaded.
[    0.898449] registered taskstats version 1
[    0.898803]   Magic number: 1:124:139
[    0.898826] acpi device:10: hash matches
[    0.898859] rtc_cmos 00:06: setting system clock to 2013-06-30 17:06:41 UTC (1372612001)
[    0.899753] Freeing unused kernel memory: 1092k freed
[    0.900041] Write protecting the kernel read-only data: 8192k
[    0.902887] Freeing unused kernel memory: 1148k freed
[    0.904294] Freeing unused kernel memory: 420k freed
[    0.911715] systemd-udevd[45]: starting version 204
[    0.915043] async_tx: api initialized (async)
[    0.915188] xor: automatically using best checksumming function:
[    0.946680]    avx       :  3838.800 MB/sec
[    1.003298] raid6: sse2x1    5552 MB/s
[    1.059897] raid6: sse2x2    9225 MB/s
[    1.116507] raid6: sse2x4   10519 MB/s
[    1.116509] raid6: using algorithm sse2x4 (10519 MB/s)
[    1.116511] raid6: using ssse3x2 recovery algorithm
[    1.118126] md: raid6 personality registered for level 6
[    1.118130] md: raid5 personality registered for level 5
[    1.118132] md: raid4 personality registered for level 4
[    1.124210] device-mapper: uevent: version 1.0.3
[    1.124353] device-mapper: ioctl: 4.24.0-ioctl (2013-01-15) initialised: dm-devel@redhat.com
[    1.149723] ACPI: bus type USB registered
[    1.149751] usbcore: registered new interface driver usbfs
[    1.149762] usbcore: registered new interface driver hub
[    1.149847] usbcore: registered new device driver usb
[    1.150399] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.150406] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[    1.150434] QUIRK: Enable AMD PLL fix
[    1.150645] xhci_hcd 0000:00:10.0: irq 42 for MSI/MSI-X
[    1.150653] xhci_hcd 0000:00:10.0: irq 43 for MSI/MSI-X
[    1.150660] xhci_hcd 0000:00:10.0: irq 44 for MSI/MSI-X
[    1.150845] xHCI xhci_add_endpoint called for root hub
[    1.150847] xHCI xhci_check_bandwidth called for root hub
[    1.150872] hub 1-0:1.0: USB hub found
[    1.150878] hub 1-0:1.0: 2 ports detected
[    1.150970] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.150974] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    1.155284] SCSI subsystem initialized
[    1.156602] xHCI xhci_add_endpoint called for root hub
[    1.156606] xHCI xhci_check_bandwidth called for root hub
[    1.156641] hub 2-0:1.0: USB hub found
[    1.156649] hub 2-0:1.0: 2 ports detected
[    1.157636] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.157827] ACPI: bus type ATA registered
[    1.157829] ehci-pci: EHCI PCI platform driver
[    1.158115] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.158149] libata version 3.00 loaded.
[    1.164340] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    1.164351] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[    1.164596] xhci_hcd 0000:00:10.1: irq 45 for MSI/MSI-X
[    1.164607] xhci_hcd 0000:00:10.1: irq 46 for MSI/MSI-X
[    1.164616] xhci_hcd 0000:00:10.1: irq 47 for MSI/MSI-X
[    1.165176] xHCI xhci_add_endpoint called for root hub
[    1.165179] xHCI xhci_check_bandwidth called for root hub
[    1.165207] hub 3-0:1.0: USB hub found
[    1.165213] hub 3-0:1.0: 2 ports detected
[    1.165300] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    1.165304] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 4
[    1.168480] xHCI xhci_add_endpoint called for root hub
[    1.168484] xHCI xhci_check_bandwidth called for root hub
[    1.168519] hub 4-0:1.0: USB hub found
[    1.168525] hub 4-0:1.0: 2 ports detected
[    1.176366] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.176376] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 5
[    1.176382] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.176392] ehci-pci 0000:00:12.2: debug port 1
[    1.176440] ehci-pci 0000:00:12.2: irq 17, io mem 0xfef4f000
[    1.186560] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.186736] hub 5-0:1.0: USB hub found
[    1.186741] hub 5-0:1.0: 5 ports detected
[    1.186993] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.187001] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 6
[    1.187004] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.187014] ehci-pci 0000:00:13.2: debug port 1
[    1.187040] ehci-pci 0000:00:13.2: irq 17, io mem 0xfef4d000
[    1.196512] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.196703] hub 6-0:1.0: USB hub found
[    1.196709] hub 6-0:1.0: 5 ports detected
[    1.197043] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    1.197053] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 7
[    1.197082] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfef50000
[    1.253963] hub 7-0:1.0: USB hub found
[    1.253972] hub 7-0:1.0: 5 ports detected
[    1.254104] ahci 0000:00:11.0: version 3.0
[    1.254274] ahci 0000:00:11.0: irq 48 for MSI/MSI-X
[    1.254279] ahci 0000:00:11.0: irq 49 for MSI/MSI-X
[    1.254283] ahci 0000:00:11.0: irq 50 for MSI/MSI-X
[    1.254288] ahci 0000:00:11.0: irq 51 for MSI/MSI-X
[    1.254292] ahci 0000:00:11.0: irq 52 for MSI/MSI-X
[    1.254296] ahci 0000:00:11.0: irq 53 for MSI/MSI-X
[    1.254300] ahci 0000:00:11.0: irq 54 for MSI/MSI-X
[    1.254304] ahci 0000:00:11.0: irq 55 for MSI/MSI-X
[    1.254397] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0xfc impl SATA mode
[    1.254400] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.255754] scsi0 : ahci
[    1.255843] scsi1 : ahci
[    1.255917] scsi2 : ahci
[    1.255993] scsi3 : ahci
[    1.256070] scsi4 : ahci
[    1.256146] scsi5 : ahci
[    1.256221] scsi6 : ahci
[    1.256295] scsi7 : ahci
[    1.256349] ata1: DUMMY
[    1.256351] ata2: DUMMY
[    1.256354] ata3: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51200 irq 50
[    1.256358] ata4: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51280 irq 51
[    1.256360] ata5: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51300 irq 52
[    1.256379] ata6: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51380 irq 53
[    1.256382] ata7: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51400 irq 54
[    1.256384] ata8: SATA max UDMA/133 abar m2048@0xfef51000 port 0xfef51480 irq 55
[    1.256569] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    1.256577] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 8
[    1.256599] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfef4e000
[    1.313933] hub 8-0:1.0: USB hub found
[    1.313941] hub 8-0:1.0: 5 ports detected
[    1.314176] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    1.314182] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 9
[    1.314198] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfef4c000
[    1.370534] hub 9-0:1.0: USB hub found
[    1.370542] hub 9-0:1.0: 2 ports detected
[    1.502886] usb 6-3: new high-speed USB device number 2 using ehci-pci
[    1.628790] Initializing USB Mass Storage driver...
[    1.628960] scsi8 : usb-storage 6-3:1.0
[    1.629041] usbcore: registered new interface driver usb-storage
[    1.629043] USB Mass Storage support registered.
[    1.742653] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.742683] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.742704] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.742723] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.742743] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.742762] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.744080] ata6.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744084] ata6.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.744117] ata8.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744119] ata8.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.744125] ata4.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744126] ata4.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.744136] ata5.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744138] ata5.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.744148] ata3.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744150] ata3.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.744159] ata7.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.744161] ata7.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.745569] ata8.00: configured for UDMA/133
[    1.745595] ata7.00: configured for UDMA/133
[    1.745615] ata5.00: configured for UDMA/133
[    1.745625] ata3.00: configured for UDMA/133
[    1.745701] ata4.00: configured for UDMA/133
[    1.745711] ata6.00: configured for UDMA/133
[    1.745744] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.745983] scsi 3:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.746151] scsi 4:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.746339] scsi 5:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.746539] scsi 6:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.746720] scsi 7:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 MX6O PQ: 0 ANSI: 5
[    1.749806] sd 3:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.749810] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    1.749826] sd 2:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.749829] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    1.749839] sd 4:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.749841] sd 4:0:0:0: [sdc] 4096-byte physical blocks
[    1.749895] sd 4:0:0:0: [sdc] Write Protect is off
[    1.749898] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.749922] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.749923] sd 3:0:0:0: [sdb] Write Protect is off
[    1.749926] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.749937] sd 2:0:0:0: [sda] Write Protect is off
[    1.749940] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.749986] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.750008] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.750734] sd 5:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.750738] sd 5:0:0:0: [sdd] 4096-byte physical blocks
[    1.750798] sd 5:0:0:0: [sdd] Write Protect is off
[    1.750801] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.750826] sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.750834] sd 6:0:0:0: [sde] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.750837] sd 6:0:0:0: [sde] 4096-byte physical blocks
[    1.750890] sd 6:0:0:0: [sde] Write Protect is off
[    1.750893] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    1.750917] sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.751113] sd 7:0:0:0: [sdf] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    1.751115] sd 7:0:0:0: [sdf] 4096-byte physical blocks
[    1.751172] sd 7:0:0:0: [sdf] Write Protect is off
[    1.751175] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    1.751199] sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.792685]  sdd: sdd1
[    1.792686]  sdc: sdc1
[    1.793186] sd 5:0:0:0: [sdd] Attached SCSI disk
[    1.793198] sd 4:0:0:0: [sdc] Attached SCSI disk
[    1.802393]  sda: sda1
[    1.802692] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.812229]  sdb: sdb1
[    1.812383]  sde: sde1
[    1.812619] sd 3:0:0:0: [sdb] Attached SCSI disk
[    1.812659] sd 6:0:0:0: [sde] Attached SCSI disk
[    1.813057]  sdf: sdf1
[    1.813369] sd 7:0:0:0: [sdf] Attached SCSI disk
[    1.862454] tsc: Refined TSC clocksource calibration: 2999.999 MHz
[    1.862459] Switching to clocksource tsc
[    1.955169] md: md0 stopped.
[    1.956038] md: bind<sda1>
[    1.956158] md: bind<sdf1>
[    1.956263] md: bind<sdc1>
[    1.956581] md: bind<sdd1>
[    1.956707] md: bind<sdb1>
[    1.956816] md: bind<sde1>
[    1.959574] md/raid:md0: device sde1 operational as raid disk 0
[    1.959578] md/raid:md0: device sdb1 operational as raid disk 5
[    1.959580] md/raid:md0: device sdd1 operational as raid disk 4
[    1.959581] md/raid:md0: device sdc1 operational as raid disk 3
[    1.959583] md/raid:md0: device sdf1 operational as raid disk 2
[    1.959584] md/raid:md0: device sda1 operational as raid disk 1
[    1.960131] md/raid:md0: allocated 6434kB
[    1.960170] md/raid:md0: raid level 6 active with 6 out of 6 devices, algorithm 2
[    1.960172] RAID conf printout:
[    1.960173]  --- level:6 rd:6 wd:6
[    1.960174]  disk 0, o:1, dev:sde1
[    1.960176]  disk 1, o:1, dev:sda1
[    1.960177]  disk 2, o:1, dev:sdf1
[    1.960178]  disk 3, o:1, dev:sdc1
[    1.960180]  disk 4, o:1, dev:sdd1
[    1.960181]  disk 5, o:1, dev:sdb1
[    1.960210] md0: detected capacity change from 0 to 12001828929536
[    1.970723]  md0: unknown partition table
[    2.015692] device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
[    2.015733] device-mapper: ioctl: error adding target to table
[    2.629487] scsi 8:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.26 PQ: 0 ANSI: 5
[    2.630978] sd 8:0:0:0: [sdg] 15633408 512-byte logical blocks: (8.00 GB/7.45 GiB)
[    2.632341] sd 8:0:0:0: [sdg] Write Protect is off
[    2.632346] sd 8:0:0:0: [sdg] Mode Sense: 43 00 00 00
[    2.633327] sd 8:0:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.639101]  sdg: sdg1
[    2.644323] sd 8:0:0:0: [sdg] Attached SCSI removable disk
[    2.810754] Btrfs loaded
[    2.813277] device fsid 9ab40762-8eef-45ef-96fd-6a00cf13dc21 devid 1 transid 61286 /dev/sdg1
[    7.043945] device fsid 9ab40762-8eef-45ef-96fd-6a00cf13dc21 devid 1 transid 61286 /dev/sdg1
[    7.046816] btrfs: disk space caching is enabled
[   16.230704] systemd[1]: systemd 204 running in system mode. (+PAM -LIBWRAP -AUDIT -SELINUX -IMA -SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
[   16.232530] systemd[1]: Set hostname to <mediaserver>.
[   16.354877] systemd[1]: [/etc/systemd/system/sabnzbd.service.d/custom_exec.conf:1] Assignment outside of section. Ignoring.
[   16.389026] systemd[1]: Cannot add dependency job for unit display-manager.service, ignoring: Unit display-manager.service failed to load: No such file or directory. See system logs and 'systemctl status display-manager.service' for details.
[   16.389225] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   16.389281] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   16.389293] systemd[1]: Expecting device sys-subsystem-net-devices-enp1s0.device...
[   16.389474] systemd[1]: Starting Remote File Systems.
[   16.389685] systemd[1]: Reached target Remote File Systems.
[   16.389695] systemd[1]: Starting LVM2 metadata daemon socket.
[   16.389923] systemd[1]: Listening on LVM2 metadata daemon socket.
[   16.389930] systemd[1]: Starting Device-mapper event daemon FIFOs.
[   16.390157] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   16.390165] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[   16.390380] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   16.390388] systemd[1]: Starting Delayed Shutdown Socket.
[   16.390607] systemd[1]: Listening on Delayed Shutdown Socket.
[   16.390618] systemd[1]: Starting Journal Socket.
[   16.390859] systemd[1]: Listening on Journal Socket.
[   16.393881] systemd[1]: Starting Apply Kernel Variables...
[   16.394700] systemd[1]: Starting Create static device nodes in /dev...
[   16.395436] systemd[1]: Starting Journal Service...
[   16.396436] systemd[1]: Started Journal Service.
[   16.396493] systemd[1]: Starting Setup Virtual Console...
[   16.397187] systemd[1]: Mounting Debug File System...
[   16.399982] systemd[1]: Starting Load Kernel Modules...
[   16.400719] systemd[1]: Starting udev Kernel Socket.
[   16.400991] systemd[1]: Listening on udev Kernel Socket.
[   16.401054] systemd[1]: Starting udev Control Socket.
[   16.401299] systemd[1]: Listening on udev Control Socket.
[   16.401352] systemd[1]: Starting udev Coldplug all Devices...
[   16.402053] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[   16.402430] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   16.406028] systemd[1]: Started Set Up Additional Binary Formats.
[   16.406066] systemd[1]: Mounting POSIX Message Queue File System...
[   16.406750] systemd[1]: Mounting Huge Pages File System...
[   16.407530] systemd[1]: Starting Encrypted Volumes.
[   16.407793] systemd[1]: Reached target Encrypted Volumes.
[   16.407812] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[   16.407874] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   16.407896] systemd[1]: Starting Paths.
[   16.408117] systemd[1]: Reached target Paths.
[   16.408125] systemd[1]: Starting Swap.
[   16.408349] systemd[1]: Reached target Swap.
[   16.408364] systemd[1]: Mounting Temporary Directory...
[   16.409029] systemd[1]: Starting File System Check on Root Device...
[   16.409771] systemd[1]: Expecting device dev-mapper-VolGroupArray\x2dlvSea2011.device...
[   16.871003] systemd-udevd[163]: starting version 204
[   17.024435] btrfs: disk space caching is enabled
[   17.168277] FS-Cache: Loaded
[   17.195708] RPC: Registered named UNIX socket transport module.
[   17.195712] RPC: Registered udp transport module.
[   17.195713] RPC: Registered tcp transport module.
[   17.195714] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   17.220983] FS-Cache: Netfs 'nfs' registered for caching
[   17.227967] btrfs: unlinked 77 orphans
[   17.227971] btrfs: truncated 2 orphans
[   17.594824] ACPI: acpi_idle registered with cpuidle
[   17.655457] parport_pc 00:04: reported by Plug and Play ACPI
[   17.655502] parport0: PC-style at 0x378, irq 5 [PCSPP,TRISTATE]
[   17.658469] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[   17.658479] ACPI: Power Button [PWRB]
[   17.658573] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   17.658576] ACPI: Power Button [PWRF]
[   17.677360] [drm] Initialized drm 1.1.0 20060810
[   17.687580] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   17.687836] r8169 0000:01:00.0: irq 56 for MSI/MSI-X
[   17.688058] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at 0xffffc90010ba2000, 90:2b:34:ab:d0:eb, XID 0c900800 IRQ 56
[   17.688061] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   17.749385] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   17.852720] ppdev: user-space parallel port driver
[   17.876922] systemd-udevd[191]: renamed network interface eth0 to enp1s0
[   17.937055] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   18.010059] microcode: CPU0: patch_level=0x00000000
[   18.014451] microcode: failed to load file amd-ucode/microcode_amd_fam15h.bin
[   18.014498] microcode: CPU1: patch_level=0x00000000
[   18.014556] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   18.080065] [drm] radeon kernel modesetting enabled.
[   18.080368] [drm] initializing kernel modesetting (ARUBA 0x1002:0x9993 0x1002:0x9993).
[   18.080397] [drm] register mmio base: 0xFEF00000
[   18.080398] [drm] register mmio size: 262144
[   18.080454] ATOM BIOS: 113
[   18.080482] radeon 0000:00:01.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[   18.080484] radeon 0000:00:01.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
[   18.080665] [drm] Detected VRAM RAM=512M, BAR=256M
[   18.080669] [drm] RAM width 32bits DDR
[   18.080726] [TTM] Zone  kernel: Available graphics memory: 750704 kiB
[   18.080728] [TTM] Initializing pool allocator
[   18.080732] [TTM] Initializing DMA pool allocator
[   18.080754] [drm] radeon: 512M of VRAM memory ready
[   18.080755] [drm] radeon: 512M of GTT memory ready.
[   18.080776] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   18.081736] [drm] Loading ARUBA Microcode
[   18.089996] bio: create slab <bio-1> at 1
[   18.169137] [drm] PCIE GART of 512M enabled (table at 0x0000000000040000).
[   18.169264] radeon 0000:00:01.0: WB enabled
[   18.169267] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0xffff88005812dc00
[   18.169270] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000020000c04 and cpu addr 0xffff88005812dc04
[   18.169272] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000020000c08 and cpu addr 0xffff88005812dc08
[   18.169274] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000020000c0c and cpu addr 0xffff88005812dc0c
[   18.169276] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000020000c10 and cpu addr 0xffff88005812dc10
[   18.169278] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   18.169279] [drm] Driver supports precise vblank timestamp query.
[   18.169315] radeon 0000:00:01.0: irq 57 for MSI/MSI-X
[   18.169326] radeon 0000:00:01.0: radeon: using MSI.
[   18.169605] [drm] radeon: irq initialized.
[   18.190979] [drm] ring test on 0 succeeded in 2 usecs
[   18.191042] [drm] ring test on 3 succeeded in 2 usecs
[   18.191049] [drm] ring test on 4 succeeded in 1 usecs
[   18.195387] kvm: Nested Virtualization enabled
[   18.195398] kvm: Nested Paging enabled
[   18.203094] [drm] ib test on ring 0 succeeded in 0 usecs
[   18.203765] [drm] ib test on ring 3 succeeded in 0 usecs
[   18.204322] [drm] ib test on ring 4 succeeded in 1 usecs
[   18.205387] [drm] Radeon Display Connectors
[   18.205390] [drm] Connector 0:
[   18.205392] [drm]   HDMI-A-1
[   18.205394] [drm]   HPD1
[   18.205396] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[   18.205397] [drm]   Encoders:
[   18.205398] [drm]     DFP1: INTERNAL_UNIPHY2
[   18.205400] [drm] Connector 1:
[   18.205401] [drm]   VGA-1
[   18.205402] [drm]   HPD2
[   18.205404] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[   18.205405] [drm]   Encoders:
[   18.205406] [drm]     CRT1: INTERNAL_UNIPHY2
[   18.205408] [drm]     CRT1: NUTMEG
[   18.205409] [drm] Connector 2:
[   18.205410] [drm]   DVI-D-1
[   18.205411] [drm]   HPD3
[   18.205413] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[   18.205414] [drm]   Encoders:
[   18.205415] [drm]     DFP2: INTERNAL_UNIPHY
[   18.205936] acpi-cpufreq: overriding BIOS provided _PSD data
[   18.243768] device fsid 9ab40762-8eef-45ef-96fd-6a00cf13dc21 devid 1 transid 61289 /dev/sdg1
[   18.251181] [drm] Internal thermal controller without fan control
[   18.251217] [drm] radeon: power management initialized
[   18.399009] [drm] fb mappable at 0xC114C000
[   18.399017] [drm] vram apper at 0xC0000000
[   18.399021] [drm] size 4325376
[   18.399023] [drm] fb depth is 24
[   18.399026] [drm]    pitch is 5632
[   18.399218] fbcon: radeondrmfb (fb0) is primary device
[   18.470592] Console: switching to colour frame buffer device 170x48
[   18.472837] radeon 0000:00:01.0: fb0: radeondrmfb frame buffer device
[   18.472839] radeon 0000:00:01.0: registered panic notifier
[   18.472843] [drm] Initialized radeon 2.30.0 20080528 for 0000:00:01.0 on minor 0
[   18.472992] hda-intel 0000:00:01.1: Force to non-snoop mode
[   18.473062] snd_hda_intel 0000:00:01.1: irq 58 for MSI/MSI-X
[   18.493758] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input3
[   18.514478] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[   18.520483] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/input/input4
[   18.534363] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:14.2/sound/card1/input5
[   18.534490] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input6
[   18.534574] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input7
[   18.534645] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input8
[   18.534717] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:14.2/sound/card1/input9
[   19.729717] systemd-logind[266]: Watching system buttons on /dev/input/event1 (Power Button)
[   19.729873] systemd-logind[266]: Watching system buttons on /dev/input/event0 (Power Button)
[   20.006439] systemd-journald[150]: File /var/log/journal/e39fb3f3d05e46a3af3c819b9e091e11/system.journal corrupted or uncleanly shut down, renaming and replacing.
[   21.285574] r8169 0000:01:00.0 enp1s0: link down
[   21.285583] r8169 0000:01:00.0 enp1s0: link down
[   21.285622] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[   23.603323] r8169 0000:01:00.0 enp1s0: link up
[   23.603339] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
[   31.026714] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   31.345958] NFSD: starting 90-second grace period (net ffffffff81892a00)
[   48.131902] SABnzbd.py[483]: segfault at 7f2e8c39e000 ip 00007f2eafe0546b sp 00007f2e5f7f4ac8 error 4 in libc-2.17.so[7f2eafd80000+1a3000]
[   52.077388] python2 invoked oom-killer: gfp_mask=0x201da, order=0, oom_score_adj=0
[   52.077393] python2 cpuset=/ mems_allowed=0
[   52.077396] Pid: 405, comm: python2 Not tainted 3.9.7-1-ARCH #1
[   52.077397] Call Trace:
[   52.077405]  [<ffffffff814caf13>] dump_header+0x7f/0x200
[   52.077410]  [<ffffffff8105b926>] ? put_online_cpus+0x56/0x80
[   52.077413]  [<ffffffff810e4244>] ? rcu_oom_notify+0xe4/0x100
[   52.077417]  [<ffffffff811250d6>] oom_kill_process+0x206/0x3a0
[   52.077420]  [<ffffffff81125857>] out_of_memory+0x427/0x470
[   52.077423]  [<ffffffff8112b2a4>] __alloc_pages_nodemask+0x9c4/0xa70
[   52.077428]  [<ffffffff81167af9>] alloc_pages_current+0xa9/0x160
[   52.077431]  [<ffffffff811223d7>] __page_cache_alloc+0x97/0xc0
[   52.077434]  [<ffffffff81123da8>] filemap_fault+0x188/0x430
[   52.077437]  [<ffffffff8114811f>] __do_fault+0x6f/0x580
[   52.077440]  [<ffffffff810e96d4>] ? __delayacct_blkio_end+0x34/0x60
[   52.077442]  [<ffffffff814d16b3>] ? io_schedule+0xb3/0xe0
[   52.077445]  [<ffffffff8114b7a3>] handle_pte_fault+0x93/0xaa0
[   52.077448]  [<ffffffff8107c3d0>] ? autoremove_wake_function+0x40/0x40
[   52.077450]  [<ffffffff8114d92d>] handle_mm_fault+0x2bd/0x650
[   52.077452]  [<ffffffff814cff30>] ? __mutex_lock_slowpath+0x260/0x360
[   52.077455]  [<ffffffff814d5fb0>] __do_page_fault+0x1d0/0x5c0
[   52.077479]  [<ffffffffa03265a8>] ? __btrfs_end_transaction+0x1b8/0x310 [btrfs]
[   52.077489]  [<ffffffffa0326710>] ? btrfs_end_transaction+0x10/0x20 [btrfs]
[   52.077499]  [<ffffffffa033667e>] ? btrfs_sync_file+0x29e/0x2c0 [btrfs]
[   52.077502]  [<ffffffff814d63ae>] do_page_fault+0xe/0x10
[   52.077505]  [<ffffffff814d3088>] page_fault+0x28/0x30
[   52.077507] Mem-Info:
[   52.077508] Node 0 DMA per-cpu:
[   52.077511] CPU    0: hi:    0, btch:   1 usd:   0
[   52.077512] CPU    1: hi:    0, btch:   1 usd:   0
[   52.077513] Node 0 DMA32 per-cpu:
[   52.077514] CPU    0: hi:  186, btch:  31 usd:   0
[   52.077516] CPU    1: hi:  186, btch:  31 usd:   0
[   52.077519] active_anon:173653 inactive_anon:160893 isolated_anon:0
 active_file:524 inactive_file:539 isolated_file:0
 unevictable:0 dirty:280 writeback:235 unstable:0
 free:12692 slab_reclaimable:5845 slab_unreclaimable:3085
 mapped:275 shmem:155370 pagetables:1224 bounce:0
 free_cma:0
[   52.077522] Node 0 DMA free:6196kB min:480kB low:600kB high:720kB active_anon:0kB inactive_anon:9692kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15988kB managed:15904kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:9692kB slab_reclaimable:16kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[   52.077527] lowmem_reserve[]: 0 1434 1434 1434
[   52.077530] Node 0 DMA32 free:44572kB min:44572kB low:55712kB high:66856kB active_anon:694612kB inactive_anon:633880kB active_file:2096kB inactive_file:2156kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:1519612kB managed:1468560kB mlocked:0kB dirty:1120kB writeback:940kB mapped:1100kB shmem:611788kB slab_reclaimable:23364kB slab_unreclaimable:12340kB kernel_stack:1224kB pagetables:4896kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:6571 all_unreclaimable? yes
[   52.077534] lowmem_reserve[]: 0 0 0 0
[   52.077537] Node 0 DMA: 1*4kB (M) 0*8kB 1*16kB (E) 3*32kB (UEM) 3*64kB (UE) 2*128kB (UE) 2*256kB (UE) 2*512kB (EM) 2*1024kB (UE) 1*2048kB (R) 0*4096kB = 6196kB
[   52.077548] Node 0 DMA32: 1115*4kB (UEM) 615*8kB (UE) 326*16kB (UEM) 146*32kB (UEM) 38*64kB (UM) 17*128kB (UM) 9*256kB (U) 6*512kB (U) 1*1024kB (U) 3*2048kB (UEM) 2*4096kB (UR) = 44612kB
[   52.077559] 156443 total pagecache pages
[   52.077560] 0 pages in swap cache
[   52.077562] Swap cache stats: add 0, delete 0, find 0/0
[   52.077563] Free swap  = 0kB
[   52.077564] Total swap = 0kB
[   52.081314] 387071 pages RAM
[   52.081317] 11719 pages reserved
[   52.081319] 527027 pages shared
[   52.081320] 359813 pages non-shared
[   52.081321] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_score_adj name
[   52.081331] [  150]     0   150    57502     1109     101        0             0 systemd-journal
[   52.081334] [  163]     0   163     7859      129      20        0         -1000 systemd-udevd
[   52.081337] [  215]     0   215    22170       46      14        0             0 lvmetad
[   52.081340] [  262]     0   262     9934      138      25        0         -1000 sshd
[   52.081343] [  264]   125   264   109588     5565      84        0             0 deluged
[   52.081345] [  265]   125   265    29448     5379      62        0             0 deluge-web
[   52.081348] [  266]     0   266     6005       60      19        0             0 systemd-logind
[   52.081350] [  267]    81   267     4330       63      14        0          -900 dbus-daemon
[   52.081353] [  274]     0   274     2039       30       8        0             0 agetty
[   52.081356] [  399]     0   399     2144       37      11        0             0 dhcpcd
[   52.081358] [  405]   998   405   238676     9481      98        0             0 python2
[   52.081361] [  406]    87   406     3672       74      14        0             0 ntpd
[   52.081363] [  407]     0   407     4725       82      13        0             0 ntpd
[   52.081365] [  408]     0   408     4255       69      14        0             0 rpcbind
[   52.081369] [  433]     0   433     5474      144      17        0             0 rpc.mountd
[   52.081371] [  434]     0   434     4260       40      13        0             0 rpc.idmapd
[   52.081374] [  435]     0   435    49850      374      97        0             0 nmbd
[   52.081376] [  439]     0   439    69259      523     135        0             0 smbd
[   52.081379] [  440]     0   440    69130      519     128        0             0 smbd
[   52.081381] [  520]   997   520   198730   156467     317        0             0 systemd-coredum
[   52.081384] Out of memory: Kill process 520 (systemd-coredum) score 417 or sacrifice child
[   52.081430] Killed process 520 (systemd-coredum) total-vm:794920kB, anon-rss:625868kB, file-rss:0kB

--------------080003060809030408060301--
