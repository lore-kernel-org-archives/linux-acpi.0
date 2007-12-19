From: Jesse Burt <genecide@comcast.net>
Subject: dmidecode Compaq Presario C500 (C552US)
Date: Wed, 19 Dec 2007 12:11:39 -0500
Message-ID: <1198084299.10729.17.camel@headhunter.avsa.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9MtGn2JTLm+prTO9wXcd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:34368
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbXLSRSy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2007 12:18:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-9MtGn2JTLm+prTO9wXcd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As per the kernel message, attached is the output of dmidecode for this
machine.
Adding acpi_osi=!Linux causes this to be logged:
ACPI: Disabled _OSI(Linux)
 (at least I think it does; I don't remember seeing it before)
I'm not sure what other effects, if any, this is supposed to have?

The ACPI driver also complains on boot:

ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify
linux-acpi@vger.kernel.org

This kernel option doesn't have any perceptible effect on anything other
than to say the same thing but to try to use acpi_apic_instance=0 :)
(IMO this laptop has more than its fair share of problems in Linux, or
Ubuntu at least; no particularly exotic hardware or anything. I don't
know how much ACPI-related stuff could be affecting this?)
Please don't hesitate to ask for any more information about this laptop!

Cheers, and happy holidays!
Jesse Burt


--=-9MtGn2JTLm+prTO9wXcd
Content-Disposition: attachment; filename=dmidecode
Content-Type: text/plain; name=dmidecode; charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.4 present.
17 structures occupying 644 bytes.
Table at 0x000E3810.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.13
	Release Date: 01/16/2007
	Address: 0xE71D0
	Runtime Size: 101936 bytes
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
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.6
	Firmware Revision: 1.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: Presario C500 (RZ342UA#ABA)       
	Version: F.13
	Serial Number: CND709290W
	UUID: 07285F90-C697-11DB-B067-0016D4C0FDDB
	Wake-up Type: Power Switch
	SKU Number: RZ342UA#ABA
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Hewlett-Packard 
	Product Name: 30C6
	Version: 78.10
	Serial Number: CND709290W

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Hewlett-Packard 
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:                     
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: F6 06 00 00 FF FB EB AF
	Version: Intel(R) Celeron(R) M CPU 520
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 1600 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: Not Provided
	L2 Cache Handle: 0x0005
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J1100
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J1101
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: 8              

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
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

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: SODIMM
	Set: 2
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 6

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0010, DMI type 127, 4 bytes
End Of Table


--=-9MtGn2JTLm+prTO9wXcd--

