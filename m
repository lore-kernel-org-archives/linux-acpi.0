From: a.biardi@tiscali.it
Subject: dmidecode (acpi_osi=!Linux)
Date: Sun, 1 Jul 2007 14:39:23 +0000
Message-ID: <200707011439.23511.a.biardi@tiscali.it>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_by7hG/JO+6j6PZp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from busyinternet.com ([66.36.229.35]:36055 "EHLO busylab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbXGATyR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Jul 2007 15:54:17 -0400
Received: from [192.168.1.90] (81.199.79.162.ipplanet.com [81.199.79.162] (may be forged))
	(authenticated (0 bits))
	by slsp-db4p6.busyworks.com (8.11.6/8.11.6) with ESMTP id l61JC3X17410
	for <linux-acpi@vger.kernel.org>; Sun, 1 Jul 2007 15:12:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_by7hG/JO+6j6PZp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Upon booting 2.6.22-rc6, the kernel says:

Initializing Device/Processor/Thermal objects by executing _INI 
methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

so, attached is the dmidecode for my macbook pro (core2 duo)

let me know if you need further information

andrea.

--Boundary-00=_by7hG/JO+6j6PZp
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode-to-linux-acpi@vger.kernel.org"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode-to-linux-acpi@vger.kernel.org"

# dmidecode 2.9
SMBIOS 2.4 present.
40 structures occupying 1552 bytes.
Table at 0x000E73F0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Apple Computer, Inc.
	Version:    MBP22.88Z.00A5.B01.0611031551
	Release Date: 11/03/06
	ROM Size: 2048 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		ACPI is supported
		IEEE 1394 boot is supported
		Smart battery is supported
		Function key-initiated network boot is supported
	BIOS Revision: 0.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Apple Computer, Inc.
	Product Name: MacBookPro2,2
	Version: 1.0
	Serial Number: W864523QW0K
	UUID: 29649BED-2E50-5C42-B76E-2ECE64DD7E6C
	Wake-up Type: Power Switch
	SKU Number: System SKUNumber
	Family: MacBook Pro

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Apple Computer, Inc.
	Product Name: Mac-F42187C8
	Version: PVT
	Serial Number: 1
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Part Component
	Chassis Handle: 0x0003
	Type: Unknown
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: Apple Computer, Inc.
	Type: Portable
	Lock: Not Present
	Version: Mac-F42187C8
	Serial Number: W864523QW0K
	Asset Tag: Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Other
	Security Status: Other
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: Unspecified
	Contained Elements: 0

Handle 0x0004, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0005, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		<BAD INDEX>
	Currently Installed Language: Not Specified

Handle 0x0106, DMI type 12, 5 bytes
System Configuration Options

Handle 0x0107, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: DVI
	External Connector Type: Other
	Port Type: Video Port

Handle 0x0108, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USBB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0109, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USBA
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x010A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: 1394A
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x010B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Audio Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x010C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Microphone
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x010D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: RJ-45
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x010E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: PCI-Express Mini Card
	External Connector Type: Other
	Port Type: Other

Handle 0x010F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Digital Battery
	External Connector Type: Other
	Port Type: Other

Handle 0x0110, DMI type 9, 13 bytes
System Slot Information
	Designation: Airport
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Hot-plug devices are supported
		SMBus signal is supported

Handle 0x0111, DMI type 9, 13 bytes
System Slot Information
	Designation: ExpressCard
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Hot-plug devices are supported
		SMBus signal is supported

Handle 0x0112, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: ATI M56 Video

Handle 0x0113, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: Azalia Audio Codec

Handle 0x0114, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Yukon Ethernet Controller

Handle 0x0115, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: Sata

Handle 0x0116, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: Pata

Handle 0x0117, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: Sudden Motion Sensor

Handle 0x0118, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 18 01 00 00

Handle 0x0119, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 2160 MHz
	Current Speed: 2160 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x011C
	L2 Cache Handle: 0x011A
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x011A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 4096 KB
	Maximum Size: 4096 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x011B, DMI type 7, 19 bytes
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

Handle 0x011C, DMI type 7, 19 bytes
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

Handle 0x011D, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 2160 MHz
	Current Speed: 2160 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0120
	L2 Cache Handle: 0x011E
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x011E, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 4096 KB
	Maximum Size: 4096 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x011F, DMI type 7, 19 bytes
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

Handle 0x0120, DMI type 7, 19 bytes
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

Handle 0x0121, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0122, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0121
	Error Information Handle: No Error
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
	Manufacturer: 0x7F98000000000000
	Serial Number: 0x992DAC7B
	Asset Tag: Unknown
	Part Number: 0x000000000000000000000000000000000000

Handle 0x0123, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0122
	Memory Array Mapped Address Handle: 0x0126
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x0124, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0121
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0x2CFFFFFFFFFFFFFF
	Serial Number: 0xD3103332
	Asset Tag: Unknown
	Part Number: 0x3136485446313238363448592D3636374233

Handle 0x0125, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0124
	Memory Array Mapped Address Handle: 0x0126
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x0126, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0121
	Partition Width: 0

Handle 0xFFFD, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_by7hG/JO+6j6PZp--
