From: Mick <utodeb@gmail.com>
Subject: Dmesg : ACPI: Please test with "acpi_osi=!Linux"
Date: Fri, 21 Dec 2007 19:32:02 +0100
Message-ID: <476C06A2.7010800@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040105020701010108090903"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:5277 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXLUScI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Dec 2007 13:32:08 -0500
Received: by fk-out-0910.google.com with SMTP id z23so554054fkz.5
        for <linux-acpi@vger.kernel.org>; Fri, 21 Dec 2007 10:32:06 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040105020701010108090903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

    In my Dmesg I see "Please send dmidecode to 
linux-acpi@vger.kernel.org" so I do... I hope this can help you :-) . I 
try with "acpi_osi=!Linux" but I have the same Dmesg after reboot. If 
you want more informations you can contact me vithout hesitation.

++



--------------040105020701010108090903
Content-Type: text/plain;
 name="dmidecode_out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode_out.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
28 structures occupying 1094 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: V1.18     
	Release Date: 12/25/2006
	Address: 0xE5970
	Runtime Size: 108176 bytes
	ROM Size: 1024 kB
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

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer
	Product Name: Aspire 9410
	Version: 0100           
	Serial Number: LXAGM0X1667210B03F2000
	UUID: 6DB0D5E0-0B42-11DC-BA83-96FD5E25CBEA
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer
	Product Name: Myall2                         
	Version: Rev            
	Serial Number: LXAGM0X1667210B03F2000

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Acer                                
	Type: Notebook
	Lock: Not Present
	Version: N/A            
	Serial Number: None           
	Asset Tag: None                            
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
	External Clock: 133 MHz
	Max Speed: 1730 MHz
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
	Current Usage: In Use
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
	ID: 10
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

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
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
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0003FFFFC00
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 kB
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

Handle 0x0018, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 18 00 FF FF

Handle 0x0019, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 19 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x001A, DMI type 200, 7 bytes
OEM-specific Type
	Header and Data:
		C8 07 1A 00 01 02 03
	Strings:
		17C0
		             
		0001

Handle 0x001B, DMI type 127, 4 bytes
End Of Table


--------------040105020701010108090903--
