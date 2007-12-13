From: jason hu <huzhijiang@gmail.com>
Subject: acpi_osi Linux report and questions
Date: Thu, 13 Dec 2007 10:36:36 +0530
Message-ID: <4760BDDC.60602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:46180 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXLMFQz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Dec 2007 00:16:55 -0500
Received: by mu-out-0910.google.com with SMTP id i10so770839mue.5
        for <linux-acpi@vger.kernel.org>; Wed, 12 Dec 2007 21:16:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

With acpi_osi=Linux, which dmesg suggested, I got something changed in 
the dmesg output(I just listed out the most important things):


diff !Linux Linux
79c80
< Detected 1733.505 MHz processor.
---
 > Detected 1733.456 MHz processor.
95c96
< Calibrating delay using timer specific routine.. 3470.37 BogoMIPS 
(lpj=1735185)
---
 > Calibrating delay using timer specific routine.. 3470.36 BogoMIPS 
(lpj=1735181)
121c122
< Calibrating delay using timer specific routine.. 3466.35 BogoMIPS 
(lpj=1733178)
---
 > Calibrating delay using timer specific routine.. 3466.36 BogoMIPS 
(lpj=1733183)
186,187d186
< PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
< PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
207c206
<   MEM window: disabled.
---
 >   MEM window: c0100000-c01fffff


It seems with acpi_osi=Linux, it mainly made the two processors equals 
in BogoMIPS and made a PCI device window available.

I am not so familiar with ACPI, so can you tell me what is 
acpi_osi=Linux used for, and why it made such changes above? Thank you!


Here goes the dmi infomation FYI:

# dmidecode 2.7
SMBIOS 2.4 present.
28 structures occupying 1132 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes.
BIOS Information
	Vendor: TOSHIBA
	Version: V1.40
	Release Date: 08/23/2007
	Address: 0xE4D20
	Runtime Size: 111328 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		IEEE 1394 boot is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.64
	Firmware Revision: 1.64

Handle 0x0001, DMI type 1, 27 bytes.
System Information
	Manufacturer: TOSHIBA
	Product Name: Satellite A135
	Version: PSAD6U-01D00D
	Serial Number: 37184795K
	UUID: 65C30D95-C773-11DB-BDF0-0016D49509AB
	Wake-up Type: Power Switch
	SKU Number: 012345678912345678912345678
	Family: ABCDEFGHIJKLMNOPQRSTUVWXYZ

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: IAYAA
	Version: 1.00
	Serial Number: 0123456789AB

Handle 0x0003, DMI type 3, 17 bytes.
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

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Other
	Manufacturer: INTEL
	ID: EC 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU           T2
	Voltage: 1.6 V
	External Clock: Unknown
	Max Speed: 200 MHz
	Current Speed: 1730 MHz
	Status: Populated, Enabled
	Upgrade: Other
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
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP1
	Internal Connector Type: None
	External Reference Designator: SVGA-Out
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0008, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP7
	Internal Connector Type: None
	External Reference Designator: S-Video
	External Connector Type: Mini DIN
	Port Type: Video Port

Handle 0x0009, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP14
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP18
	Internal Connector Type: None
	External Reference Designator: MIC_IN
	External Connector Type: RJ-11
	Port Type: MIDI Port

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP17
	Internal Connector Type: None
	External Reference Designator: HEADPHONE
	External Connector Type: RJ-11
	Port Type: MIDI Port

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP2
	Internal Connector Type: None
	External Reference Designator: Telephone Line
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: JP2
	Internal Connector Type: None
	External Reference Designator: Network
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x000E, DMI type 9, 13 bytes.
System Slot Information
	Designation: TI PCI1410
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Unknown
	Length: Other
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Hot-plug devices are supported

Handle 0x000F, DMI type 10, 8 bytes.
On Board Device 1 Information
	Type: Sound
	Status: Disabled
	Description: Realtek ACL861
On Board Device 2 Information
	Type: Ethernet
	Status: Disabled
	Description: Realtek RTL8100L

Handle 0x0010, DMI type 11, 5 bytes.
OEM Strings
	String 1: PSAD6U-01D00D,SQ004244V07,11A

Handle 0x0011, DMI type 12, 5 bytes.
System Configuration Options

Handle 0x0012, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0013, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0012
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: J401
	Bank Locator: Channel B0
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0014, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0012
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 2
	Locator: J400
	Bank Locator: Channel B1
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0015, DMI type 18, 23 bytes.
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0016, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0005FFFFFFF
	Range Size: 1536 MB
	Physical Array Handle: 0x0012
	Partition Width: 0

Handle 0x0017, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0013
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 6

Handle 0x0018, DMI type 22, 26 bytes.
Portable Battery
	Location: 1st Battery
	Manufacturer: TOSHIBA
	Name: TOSHIBA
	Chemistry: Lithium Ion
	Design Capacity: 31500 mWh
	Design Voltage: 14800 mV
	SBDS Version: Not Specified
	Maximum Error: Unknown
	SBDS Serial Number: 0000
	SBDS Manufacture Date: 1980-00-00
	OEM-specific Information: 0x00000000

Handle 0x0019, DMI type 32, 20 bytes.
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001A, DMI type 126, 4 bytes.
Inactive

Handle 0x001B, DMI type 127, 4 bytes.
End Of Table

