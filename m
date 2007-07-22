From: =?ISO-8859-15?Q?Felix_M=F6ller?= <felix@derklecks.de>
Subject: MacBook is requesting _OSI(Linux)
Date: Sun, 22 Jul 2007 09:05:11 +0200
Message-ID: <46A301A7.7000405@derklecks.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040404060805090409010704"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.planet-school.de ([194.116.187.6]:48518 "EHLO
	turbohermes.planet-school.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753785AbXGVHLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 03:11:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404060805090409010704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi,

I saw the follwing while booting my MacBook of early 2006 today.

---
Initialized 25/27 Regions 0/0 Fields 22/22 Buffers 8/18 Packages (698 nodes)
Initializing Device/Processor/Thermal objects by executing _INI
methods:<4>ACPI:
 System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
---

# uname -a
Linux linux-95zp 2.6.22-5-default #1 SMP 2007/07/16 06:54:15 UTC i686
i686 i386 GNU/Linux
# cat /etc/SuSE-release
openSUSE 10.3 (i586) Alpha6

Please CC: me on any replies and tell me if you need anything more.

Felix Möller

--------------040404060805090409010704
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
37 structures occupying 1472 bytes.
Table at 0x000E7440.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Apple Computer, Inc.
	Version:     MB11.88Z.0061.B03.0610121324
	Release Date: 10/12/06
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
	Product Name: MacBook1,1
	Version: 1.0
	Serial Number: 2Y6430MAU9B
	UUID: 9CFE245E-D0C8-BD45-A79F-54EA5FBD3D97
	Wake-up Type: Power Switch
	SKU Number: System SKUNumber
	Family: Napa Mac

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Apple Computer, Inc.
	Product Name: Mac-F4208CC8
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
	Type: Notebook
	Lock: Not Present
	Version: Mac-F4208CC8
	Serial Number: 2Y6430MAU9B
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
	External Reference Designator: USBA
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0109, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USBC
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

Handle 0x010E, DMI type 9, 13 bytes
System Slot Information
	Designation: AirPort
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Hot-plug devices are supported
		SMBus signal is supported

Handle 0x010F, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: ATI M56 Video

Handle 0x0110, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: Azalia Audio Codec

Handle 0x0111, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Yukon Ethernet Controller

Handle 0x0112, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: SATA

Handle 0x0113, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: PATA

Handle 0x0114, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: Sudden Motion Sensor

Handle 0x0115, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 15 01 00 00

Handle 0x0116, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: E8 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU            
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 1830 MHz
	Current Speed: 1830 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0119
	L2 Cache Handle: 0x0117
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x0117, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0118, DMI type 7, 19 bytes
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

Handle 0x0119, DMI type 7, 19 bytes
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

Handle 0x011A, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: E8 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU            
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 1830 MHz
	Current Speed: 1830 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x011D
	L2 Cache Handle: 0x011B
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x011B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
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
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x011D, DMI type 7, 19 bytes
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

Handle 0x011E, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x011F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x011E
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 256 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x00005029
	Asset Tag: Unknown
	Part Number: 0x48594D503533325336344250362D59352020

Handle 0x0120, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0000FFFFFFF
	Range Size: 256 MB
	Physical Device Handle: 0x011F
	Memory Array Mapped Address Handle: 0x0123
	Partition Row Position: 1

Handle 0x0121, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x011E
	Error Information Handle: Not Provided
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
	Manufacturer: 0x7F7F9E0000000000
	Serial Number: 0x00000000
	Asset Tag: Unknown
	Part Number: 0x565331475344533636374432202020202020

Handle 0x0122, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00010000000
	Ending Address: 0x0004FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0121
	Memory Array Mapped Address Handle: 0x0123
	Partition Row Position: 1

Handle 0x0123, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0004FFFFFFF
	Range Size: 1280 MB
	Physical Array Handle: 0x011E
	Partition Width: 0

Handle 0xFFFD, DMI type 127, 4 bytes
End Of Table


--------------040404060805090409010704--
