From: "Jason Wood" <sandain@hotmail.com>
Subject: dmidecode
Date: Tue, 14 Aug 2007 00:24:39 -0600
Message-ID: <BAY117-F12D83EA91D8FBFD00E0E0BB1DD0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_5cab_63ac_ba1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s7.bay0.hotmail.com ([65.54.246.207]:60190 "EHLO
	bay0-omc3-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759445AbXHNGYn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Aug 2007 02:24:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_5cab_63ac_ba1
Content-Type: text/plain; format=flowed

dmesg told me to send the output of dmidecode to this list.  The boot option 
acpi_osi=!Linux seems to have fixed a number of issues, including an 
intermittent boot lockup, and the ability to hibernate.

Thank you,
Jason Wood

_________________________________________________________________
More photos, more messages, more storage—get 2GB with Windows Live Hotmail. 
http://imagine-windowslive.com/hotmail/?locale=en-us&ocid=TXT_TAGHM_migration_HM_mini_2G_0507

------=_NextPart_000_5cab_63ac_ba1
Content-Type: text/plain; name="dmidecode.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 822 bytes.
Table at 0x000F1C90.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.32M1
	Release Date: 04/26/2007
	Address: 0xE6A40
	Runtime Size: 103872 bytes
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
	Product Name: HP Pavilion dv6000(EW468AV#ABA)
	Version: Rev 1
	Serial Number: CNF635048Q
	UUID: 434E4636-3335-3034-3851-001B24369AF4
	Wake-up Type: Power Switch
	SKU Number: EW468AV#ABA
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
	Version: AMD Turion(tm) 64 X2 Mobile TL56
	Voltage: 1.6 V
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
	Description:

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
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 1
	Bank Locator: Bank 0,1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: F7F7F7B000000000
	Serial Number: 1174F167
	Asset Tag: Not Specified
	Part Number: NT1GT64U8HA0BN-3C

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 2
	Bank Locator: Bank 2,3
	Type: DDR2
	Type Detail: Unknown
	Speed: 667 MHz (1.5 ns)
	Manufacturer: F7F7F7B000000000
	Serial Number: 8074F176
	Asset Tag: Not Specified
	Part Number: NT1GT64U8HA0BN-3C

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000C
	Partition Width: 0

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000D
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
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



------=_NextPart_000_5cab_63ac_ba1--
