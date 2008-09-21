From: pierre.lando@free.fr
Subject: vestel
Date: Sun, 21 Sep 2008 11:14:45 +0200 (CEST)
Message-ID: <195644343.3873591221988485319.JavaMail.root@spooler10-g27.priv.proxad.net>
References: <1191561764.3872521221988098197.JavaMail.root@spooler10-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wmproxy2-g27.free.fr ([212.27.42.92]:4766 "EHLO
	wmproxy2-g27.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYIUJWt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 05:22:49 -0400
Received: from spooler10-g27.priv.proxad.net (spooler10-g27.priv.proxad.net [172.20.243.231])
	by wmproxy2-g27.free.fr (Postfix) with ESMTP id 939B87FC0
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2008 11:14:45 +0200 (CEST)
In-Reply-To: <1191561764.3872521221988098197.JavaMail.root@spooler10-g27.priv.proxad.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I can modify /proc/acpi/video/VGA0/DD03/brightness 
echo 30 > /proc/acpi/video/VGA0/DD03/brightness 
levels:  100 80 30 40 50 60 70 80 90 100
current: 30
but, there wasn't efects on the brightness

a lot of multimedia key have the same code 0xd6 :
[  263.605335] atkbd.c: Unknown key pressed (translated set 2, code 0xd6 on isa0060/serio0).
[  263.605344] atkbd.c: Use 'setkeycodes e056 <keycode>' to make it known.

if I use setkeycodes, all keyboard don't work anymore.

dmesg :

[   50.602916] ACPI: DMI System Vendor: PERISTYLE
[   50.602917] ACPI: DMI Product Name: PORVJA9
[   50.602918] ACPI: DMI Product Version: 1
[   50.602919] ACPI: DMI Board Name: The Sun
[   50.602920] ACPI: DMI BIOS Vendor: VESTEL
[   50.602921] ACPI: DMI BIOS Date: 11/10/2007
[   50.602922] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
-----

# dmidecode 2.9
SMBIOS 2.4 present.
29 structures occupying 1606 bytes.
Table at 0x000E2A70.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: VESTEL
	Version: The Sun 0.11
	Release Date: 11/10/2007
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
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: PERISTYLE
	Product Name: PORVJA9
	Version: 1
	Serial Number: 123456789
	UUID: AA55AA55-AA55-AA55-55AA-AA5555AA55AA
	Wake-up Type: Power Switch
	SKU Number: SKU1234
	Family: FAMILY

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Vestel Digital
	Product Name: The Sun
	Version: 14MB03
	Serial Number: 12345678
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
	Asset Tag: Chassis Asset Tag
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

Handle 0x000A, DMI type 11, 10 bytes
OEM Strings
	String 1: String1 for Original Equipment Manufacturer
	String 2: String2 for Original Equipment Manufacturer
	String 3: String3 for Original Equipment Manufacturer
	String 4: String4 for Original Equipment Manufacturer
	String 5: String5 for Original Equipment Manufacturer

Handle 0x000B, DMI type 15, 29 bytes
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

Handle 0x000C, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000D, DMI type 129, 5 bytes
OEM-specific Type
	Header and Data:
		81 05 0D 00 4F
	Strings:
		em Test 1
		UUUU
		UUUUU
		Oem Test 2

Handle 0x000E, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R) Corporation
	ID: 76 06 01 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 23, Stepping 6
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
	Version: Intel(R) Core(TM)2 Duo CPU     T9300  @ 2.50GHz
	Voltage: 1.6 V
	External Clock: 800 MHz
	Max Speed: Unknown
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: Socket 478
	L1 Cache Handle: 0x0010
	L2 Cache Handle: Not Provided
	L3 Cache Handle: Not Provided
	Serial Number: NotSupport
	Asset Tag: FFFF
	Part Number: FFFF

Handle 0x000F, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0010, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0011, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R) Corporation
	ID: 76 06 01 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 23, Stepping 6
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
	Version: Intel(R) Core(TM)2 Duo CPU     T9300  @ 2.50GHz
	Voltage: 1.6 V
	External Clock: 800 MHz
	Max Speed: Unknown
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: Socket 478
	L1 Cache Handle: 0x0013
	L2 Cache Handle: Not Provided
	L3 Cache Handle: Not Provided
	Serial Number: NotSupport
	Asset Tag: FFFF
	Part Number: FFFF

Handle 0x0012, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0013, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0014, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0015, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0014
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0x0000000000000000
	Serial Number: 0x00000000
	Asset Tag: Unknown
	Part Number: 0x000000000000000000000000000000000000

Handle 0x0016, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0015
	Memory Array Mapped Address Handle: 0x001B
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x0017, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0014
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK 1
	Type: DDR2
	Type Detail: None
	Speed: Unknown
	Manufacturer: NO DIMM
	Serial Number: NO DIMM
	Asset Tag: NO DIMM
	Part Number: NO DIMM

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0014
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
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0x0000000000000000
	Serial Number: 0x00000000
	Asset Tag: Unknown
	Part Number: 0x000000000000000000000000000000000000

Handle 0x0019, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0018
	Memory Array Mapped Address Handle: 0x001B
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x001A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0014
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK 3
	Type: DDR2
	Type Detail: None
	Speed: Unknown
	Manufacturer: NO DIMM
	Serial Number: NO DIMM
	Asset Tag: NO DIMM
	Part Number: NO DIMM

Handle 0x001B, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0014
	Partition Width: 0

Handle 0x001C, DMI type 127, 4 bytes
End Of Table
