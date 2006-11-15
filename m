From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: unsupported model Z96F
Date: Tue, 14 Nov 2006 21:55:38 -0500
Message-ID: <455A81AA.3010805@seclark.us>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030806060000090001010401"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:17308
	"HELO smtpout04-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1753763AbWKOCzk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Nov 2006 21:55:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806060000090001010401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello List,

this is 2.6.19-rc5
Asus Laptop ACPI Extras version 0.30
   Error calling BSTS
   unsupported model Z96F, trying default values
   send /proc/acpi/dsdt to the developers

attached is a dmidecode of /proc/acpi/dsdt

Thanks,
Steve
-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)




--------------030806060000090001010401
Content-Type: text/plain;
 name="z96f_dsdt.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="z96f_dsdt.txt"

# dmidecode 2.7
SMBIOS 2.4 present.
33 structures occupying 1418 bytes.
Table at 0x000F0690.

Handle 0x0000, DMI type 0, 24 bytes.
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 080012 
	Release Date: 08/29/2006
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
	BIOS Revision: 8.12

Handle 0x0001, DMI type 1, 27 bytes.
System Information
	Manufacturer: To Be Filled By O.E.M.
	Product Name: Z96F
	Version: 1.0
	Serial Number: NB-1234567890
	UUID: 703081DA-F20F-4E1F-F780-001731BFAAAD
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes.
Base Board Information
	Manufacturer: To Be Filled By O.E.M.
	Product Name: Z96F
	Version: 1.00
	Serial Number: NB-0123456789
	Asset Tag: To Be Filled By O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To Be Filled By O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes.
Chassis Information
	Manufacturer: To Be Filled By O.E.M.
	Type: Notebook
	Lock: Present
	Version: 1.0
	Serial Number: 0x00000000
	Asset Tag: 0x00000000
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Heigth: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: Socket 478M
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel            
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU T5600 @ 1.83GHz              
	Voltage: 1.4 V
	External Clock: 166 MHz
	Max Speed: 1833 MHz
	Current Speed: 1833 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0005, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Data
	Associativity: 2-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 2-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L3-Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0008, DMI type 5, 20 bytes.
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 2048 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 2
		0x0009
		0x000A
	Enabled Error Correcting Capabilities:
		None

Handle 0x0009, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 4 5
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Mic In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6J2 - PRI IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6J1 - SEC IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 10, 6 bytes.
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   To Be Filled By O.E.M.

Handle 0x0016, DMI type 11, 5 bytes.
OEM Strings
	String 1: To Be Filled By O.E.M.
	String 2: To Be Filled By O.E.M.
	String 3: To Be Filled By O.E.M.
	String 4: To Be Filled By O.E.M.

Handle 0x0017, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0018, DMI type 15, 35 bytes.
System Event Log
	Area Length: 4 bytes
	Header Start Offset: 0x0000
	Header Length: 2 bytes
	Data Start Offset: 0x0002
	Access Method: Indexed I/O, one 16-bit index port, one 8-bit data port
	Access Address: Index 0x046A, Data 0x046C
	Status: Invalid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 6
	Descriptor 1: End of log
	Data Format 1: OEM-specific
	Descriptor 2: End of log
	Data Format 2: OEM-specific
	Descriptor 3: End of log
	Data Format 3: OEM-specific
	Descriptor 4: End of log
	Data Format 4: OEM-specific
	Descriptor 5: End of log
	Data Format 5: OEM-specific
	Descriptor 6: End of log
	Data Format 6: OEM-specific

Handle 0x0019, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x001A, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000800003FF
	Range Size: 2097153 kB
	Physical Array Handle: 0x0019
	Partition Width: 0

Handle 0x001B, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0019
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: SDRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x001C, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x001B
	Memory Array Mapped Address Handle: 0x001A
	Partition Row Position: 1
	Interleaved Data Depth: 1

Handle 0x001D, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0019
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: SDRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x001E, DMI type 126, 19 bytes.
Inactive

Handle 0x001F, DMI type 32, 20 bytes.
System Boot Information
	Status: No errors detected

Handle 0x0020, DMI type 127, 4 bytes.
End Of Table


--------------030806060000090001010401--
