From: Alessandro Di Marco <dmr@c0nc3pt.com>
Subject: Please send dmidecode to linux-acpi@vger.kernel.org
Date: Thu, 13 Sep 2007 11:51:55 +0200
Message-ID: <87ir6eyjt0.fsf@c0nc3pt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bin.disi.unige.it ([130.251.61.176]:40132 "EHLO
	merlin.c0nc3pt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbXIMKLB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Sep 2007 06:11:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


# dmidecode 2.9
SMBIOS 2.31 present.
19 structures occupying 915 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: R0091N0
	Release Date: 07/10/2006
	Address: 0xE4510
	Runtime Size: 113392 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-SZ38GP_C
	Version: J0020Y9W
	Serial Number: 28247270-7003707
	UUID: CEBBB8E0-5B3C-11D9-8796-0013A98B94A4
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 10 bytes
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
	Serial Number: J0020Y9W
	Asset Tag:                                                   
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000009

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: N/A
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
	Voltage: 1.3 V
	External Clock: 166 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: N/A
	Asset Tag: N/A
	Part Number: N/A

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: None
	System Type: Other
	Associativity: 8-way Set-associative

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
	Error Correction Type: None
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Unknown
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0008, DMI type 9, 13 bytes
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

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: JPBL-002575
	String 2: FNC-CCIA0jieHDPW
	String 3: 6N6P000000005c5ca50ea4a54d24
	String 4: Reserved              
	String 5: Reserved              

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Unknown
	Maximum Capacity: 2048 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Unknown

Handle 0x000C, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM2
	Bank Locator: Bank 1
	Type: DDR
	Type Detail: Unknown

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0011, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 11 00 5A 5A

Handle 0x0012, DMI type 127, 4 bytes
End Of Table

Regards,

-- 
"In all large corporations, there is a pervasive fear that someone, somewhere
is having fun with a computer on company time. Networks help alleviate that
fear." - John C. Dvorak
