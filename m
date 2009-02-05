From: Adam Pigg <piggz1@gmail.com>
Subject: Problems with Toshiba Satellite L355
Date: Thu, 5 Feb 2009 23:11:30 +0000
Message-ID: <200902052311.31794.adam@piggz.co.uk>
Reply-To: adam@piggz.co.uk
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jI3iJ3BneSQ8ooF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:46383 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZBEXOT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2009 18:14:19 -0500
Received: by ewy13 with SMTP id 13so952511ewy.17
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2009 15:14:17 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_jI3iJ3BneSQ8ooF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

i have 2 acpi related (i think) problems with my satellite l355 which i hope 
someone can help with.

1. /proc/acpi/ac_adapter.../state always show the correct state, but 
acpi_listen and lshal --monitor dont see any un/plug events.

2. The machine will suspend to ram, resume, but after a second suspend, wont 
resume.

I think i saw a similar sounding problem on an R500, but it was fixed.

Ive attached the output of dmidecode, and am using 2.6.29rc3.

Anything else that will  help let me know.

Cheers

Adam

--Boundary-00=_jI3iJ3BneSQ8ooF
Content-Type: text/plain;
  charset="UTF-8";
  name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.txt"

# dmidecode 2.10
SMBIOS 2.4 present.
25 structures occupying 1287 bytes.
Table at 0x000E6AB0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: INSYDE
	Version: 1.10
	Release Date: 02/26/2008
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: TOSHIBA
	Product Name: Satellite L355
	Version: PSLD0U-00800X
	Serial Number: 38200334Q
	UUID: 5C657E00-F5A0-11DC-A70E-001E33345D5C
	Wake-up Type: Power Switch
	SKU Number: 123456789
	Family: Type1Family

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Intel Corp.
	Product Name: Base Board Product Name
	Version: Base Board Version
	Serial Number: Base Board Serial Number
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Chassis Manufacturer
	Type: Other
	Lock: Not Present
	Version: Chassis Version
	Serial Number: Chassis Serial Number
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 9, 13 bytes
System Slot Information
	Designation: J6C1
	Type: x16 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0005, DMI type 9, 13 bytes
System Slot Information
	Designation: J8C1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
	Designation: J7C1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 1
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: J8D1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 2
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: J8B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		SMBus signal is supported

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
	Designation: J9B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		SMBus signal is supported

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
	String 1: PSLD0U-00800X,SQ004659V05,11B40
	String 2: 9SWWDh73DNDIz
	String 3: oGaPtK+k5J8Ai
	String 4: Ob8sV0aRlDI28
	String 5:                                 

Handle 0x000B, DMI type 12, 5 bytes
System Configuration Options
	Option 1: NVR:00707002
	Option 2: DSN:080208BB0D00WHG9KLGA
	Option 3: DSN:HYMP125S64CP8-Y5  00006228 
	Option 4: DSN:00000000

Handle 0x000C, DMI type 15, 29 bytes
System Event Log
	Area Length: 32672 bytes
	Header Start Offset: 0x0000
	Data Start Offset: 0x0000
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x12345678
	Header Format: OEM-specific
	Supported Log Type Descriptors: 3
	Descriptor 1: POST memory resize
	Data Format 1: None
	Descriptor 2: POST error
	Data Format 2: POST results bitmap
	Descriptor 3: Log area reset/cleared
	Data Format 3: None

Handle 0x000D, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000E, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R) Corporation
	ID: FD 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 13
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
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz
	Voltage: 1.6 V
	External Clock: 667 MHz
	Max Speed: 4096 MHz
	Current Speed: 1833 MHz
	Status: Populated, Enabled
	Upgrade: Socket 478
	L1 Cache Handle: 0x0011
	L2 Cache Handle: 0x000F
	L3 Cache Handle: Not Provided
	Serial Number: NotSupport
	Asset Tag: FFFF
	Part Number: FFFF

Handle 0x000F, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0010, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 kB
	Maximum Size: 32 kB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0011, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 kB
	Maximum Size: 32 kB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0012, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0013, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x00006294
	Asset Tag: Unknown
	Part Number: 0x48594D503132355336344350382D59352020

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0013
	Memory Array Mapped Address Handle: 0x0017
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x0015, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK 2
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: 0xCE00000000000000
	Serial Number: 0x734AAA8E
	Asset Tag: Unknown
	Part Number: 0x4D342037305432393533455A332D43453620

Handle 0x0016, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000BFFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0015
	Memory Array Mapped Address Handle: 0x0017
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x0017, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000BFFFFFFF
	Range Size: 3 GB
	Physical Array Handle: 0x0012
	Partition Width: 0

Handle 0x0018, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_jI3iJ3BneSQ8ooF--
