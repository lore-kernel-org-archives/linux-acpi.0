From: Sebastian Schleehauf <S.Schleehauf@gmx.de>
Subject: APIC
Date: Sun, 16 Dec 2007 10:56:18 +0100
Message-ID: <4764F642.7050709@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020509000303020101080403"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:54803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756153AbXLPJ4V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Dec 2007 04:56:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509000303020101080403
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
with "acpi_apic_instance=2"
I get   APIC error on CPU1: 00(40) (with dmesg) - so I guess working
better is with acpi_apic_instance=0. acpi_apic_instance=2I attached the
output of dmidecode. By the way I have big problems with overheating and
 therefore shutting down, but I am not sure if that is related.
Cheers,
Sebastian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHZPZCbGnBMi06ftIRAiSVAKDBAZrmnsdV2am1b4A18FuUwkTlaQCfVVXR
602DQwu2toZiuP2FoGfje0k=
=1qJe
-----END PGP SIGNATURE-----

--------------020509000303020101080403
Content-Type: text/plain;
 name="dmidecode-output-lenovo3000V100"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode-output-lenovo3000V100"

# dmidecode 2.9
SMBIOS 2.4 present.
31 structures occupying 1028 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: LENOVO
	Version: 62ETC1WW (1.11 )
	Release Date: 04/20/2007
	Address: 0xE8600
	Runtime Size: 96768 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.11

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: LENOVO
	Product Name: 076326G
	Version: LENOVO3000 V100
	Serial Number: L3A1376
	UUID: 4C998760-ED2C-11DA-BE79-95616C7EBF70
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: LENOVO
	Product Name: INVALID
	Version: Not Applicable
	Serial Number: X64S1BZ

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: LENOVO
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: INVALID
	Asset Tag: No Asset Tag
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
	ID: E8 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU           T2
	Voltage: 3.3 V
	External Clock: 533 MHz
	Max Speed: 2048 MHz
	Current Speed: 1800 MHz
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

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 2048 KB
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
	Internal Reference Designator: J19
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J8B1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J9B1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
	Designation: PEG Slot J6C1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 6
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J7C1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J8C1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000D, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x000E, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel Calistoga
	String 2: Chipset CRB Platform

Handle 0x000F, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0010, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
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

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
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

Handle 0x0013, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0010
	Partition Width: 0

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0012
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0016, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0017, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 17 00 01 01 02 01 00 00 00 01 06 01 00 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0018, DMI type 131, 22 bytes
OEM-specific Type
	Header and Data:
		83 16 18 00 01 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 01
	Strings:
		TVT-Enablement

Handle 0x0019, DMI type 133, 5 bytes
OEM-specific Type
	Header and Data:
		85 05 19 00 01
	Strings:
		KHOIHGIUCCHHII

Handle 0x001A, DMI type 135, 10 bytes
OEM-specific Type
	Header and Data:
		87 0A 1A 00 54 50 07 03 01 07

Handle 0x001B, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 1B 00 FF FF

Handle 0x001C, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 1C 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x001D, DMI type 200, 7 bytes
OEM-specific Type
	Header and Data:
		C8 07 1D 00 01 02 03
	Strings:
		17C0
		             
		0001

Handle 0x001E, DMI type 127, 4 bytes
End Of Table


--------------020509000303020101080403--
