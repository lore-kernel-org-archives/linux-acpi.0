From: "Ricardo Rivera" <rivera151@hotmail.com>
Subject: dmidecode
Date: Mon, 19 Nov 2007 00:40:21 -0400
Message-ID: <BAY131-F32A663C888BB99B0395CB5E17E0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_729e_2ebe_44db"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc2-s41.bay0.hotmail.com ([65.54.246.177]:4957 "EHLO
	bay0-omc2-s41.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbXKSEkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Nov 2007 23:40:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_729e_2ebe_44db
Content-Type: text/plain; format=flowed

See if this helps!


------=_NextPart_000_729e_2ebe_44db
Content-Type: text/x-log; name="dmidecode-output.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmidecode-output.log"

# dmidecode 2.9
SMBIOS 2.4 present.
22 structures occupying 1007 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: TOSHIBA
	Version: V1.30
	Release Date: 03/26/2007
	Address: 0xE59C0
	Runtime Size: 108096 bytes
	ROM Size: 512 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.48
	Firmware Revision: 1.48

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: TOSHIBA
	Product Name: Satellite P205
	Version: PSPB0U-013008
	Serial Number: 47193468K
	UUID: E297E149-DD77-11DB-9580-0016D4F4FF54
	Wake-up Type: Power Switch
	SKU Number: 012345678912345678912345678
	Family: ABCDEFGHIJKLMNOPQRSTUVWXYZ

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: ISRAE
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
	ID: EC 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU           T2
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 2048 MHz
	Current Speed: 1730 MHz
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
	Installed Size: 32 KB
	Maximum Size: 32 KB
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
	Location: External
	Installed Size: 1024 KB
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

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J35
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J36
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
	Designation: TI7412
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
	Description: HD-Audio

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
	String 1: PSPB0U-013008,SQ004331V05,11B

Handle 0x000C, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x000D, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 3 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
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
	Location: 1st Battery
	Manufacturer: TOSHIBA   
	Manufacture Date: 12/01/2005
	Serial Number: 3658Q
	Name: PA3395U 
	Chemistry: Lithium Ion
	Design Capacity: 31500 mWh
	Design Voltage: 14800 mV
	SBDS Version: Not Specified
	Maximum Error: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0014, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0015, DMI type 127, 4 bytes
End Of Table



------=_NextPart_000_729e_2ebe_44db--
