From: Patrick <acpi@puzzled.xs4all.nl>
Subject: dmidecode of Acer TM6460
Date: Thu, 27 Sep 2007 14:03:51 +0200
Message-ID: <1190894631.3029.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VKvouIjzbRdQ1/wvVVnJ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from puzzled.xs4all.nl ([213.84.38.78]:65123 "EHLO puzzled.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbXI0MPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2007 08:15:08 -0400
Received: from [10.0.0.105] (luna.puzzled.xs4all.nl [10.0.0.105])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by zeus.puzzled.xs4all.nl (Postfix) with ESMTP id BF7C34D901F7
	for <linux-acpi@vger.kernel.org>; Thu, 27 Sep 2007 14:04:20 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-VKvouIjzbRdQ1/wvVVnJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

In /var/log/messages I saw this:
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

So I have attached the requested information. Laptop is an Acer
Travelmate 6460 running Fedora 7. Please send questions/remarks off-list
as I am not subscribed.

Regards,
Patrick


--=-VKvouIjzbRdQ1/wvVVnJ
Content-Disposition: attachment; filename=dmidecode_Acer_TM6460.txt
Content-Type: text/plain; name=dmidecode_Acer_TM6460.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.7
SMBIOS 2.4 present.
35 structures occupying 1073 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes.
BIOS Information
	Vendor: Acer
	Version: 3.02    
	Release Date: 06/08/07
	Address: 0xE4B40
	Runtime Size: 111808 bytes
	ROM Size: 64 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		AGP is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes.
System Information
	Manufacturer: Acer
	Product Name: TravelMate 6460
	Version: CSR-000F
	Serial Number: 12345678901234567
	UUID: Not Settable
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: Acer
	Product Name: Coniston
	Version: Not Applicable
	Serial Number: Not Applicable

Handle 0x0003, DMI type 3, 17 bytes.
Chassis Information
	Manufacturer: Acer
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:  
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU         T7
	Voltage: 3.3 V
	External Clock: 166 MHz
	Max Speed: 500 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 4096 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J11
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0008, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Mouse Port

Handle 0x0009, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI Slot J8B1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000A, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI Slot J9B1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000B, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI Slot J13
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000C, DMI type 10, 6 bytes.
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: ADI

Handle 0x000D, DMI type 11, 5 bytes.
OEM Strings
	String 1: This is the Intel Calistoga
	String 2: Chipset CRB Platform

Handle 0x000E, DMI type 12, 5 bytes.
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x000F, DMI type 15, 29 bytes.
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Invalid
	Change Token: 0x00000026
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0010, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0011, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0012, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0013, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0010
	Partition Width: 0

Handle 0x0014, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0012
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0016, DMI type 23, 13 bytes.
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0017, DMI type 24, 5 bytes.
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x0018, DMI type 25, 9 bytes.
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0019, DMI type 26, 20 bytes.
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001A, DMI type 27, 12 bytes.
Cooling Device
	Temperature Probe Handle: 0x001B
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001B, DMI type 28, 20 bytes.
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001C, DMI type 29, 20 bytes.
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 30, 6 bytes.
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x001E, DMI type 32, 20 bytes.
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001F, DMI type 129, 16 bytes.
OEM-specific Type
	Header and Data:
		81 10 1F 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0020, DMI type 136, 6 bytes.
OEM-specific Type
	Header and Data:
		88 06 20 00 FF FF

Handle 0x0021, DMI type 150, 14 bytes.
OEM-specific Type
	Header and Data:
		96 0E 21 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x0022, DMI type 127, 4 bytes.
End Of Table


--=-VKvouIjzbRdQ1/wvVVnJ--

