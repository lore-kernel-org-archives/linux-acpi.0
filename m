From: David Carlos Manuelda <stormbyte@gmail.com>
Subject: A couple of things about ACPI
Date: Tue, 18 Sep 2007 16:10:52 +0200
Message-ID: <200709181610.52771.StormByte@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sx97GWS5V3L1qQH"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:10643 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbXIRONe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Sep 2007 10:13:34 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3194140mue
        for <linux-acpi@vger.kernel.org>; Tue, 18 Sep 2007 07:13:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_sx97GWS5V3L1qQH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've seen in dmesg some things I wanted to comment to you.

First of all, I've seen a message at boot:

ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

I've tested with that boot option, and I see exactly same message (maybe a 
bug?)

dmidecode is attached.
=========================
I've seen:
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org
Testing with that option, I see no difference, except the message change, now 
says:
ACPI: BIOS bug: multiple APIC/MADT found, using 2
ACPI: If "acpi_apic_instance=0" works better, notify 
linux-acpi@vger.kernel.org
=========================
I don't know what it is exactly, but I mail you with information requested.

Please let me know if it is useful, and if you need more info, just tell me.

This is a Samsung R70 laptop, intel core2 duo 1800, 2GB ram 'Santa Rosa'.

By the way, info of dmidecode is not 100% correct, I don't know why. This is 
what is not correct:

extract of dmidecode.txt:
====================
Handle 0x000B, DMI type 10, 6 bytes
On Board Device Information
        Type: Sound
        Status: Disabled (***!!! Sound is enabled and fully functional)
        Description: HD-Audio
=======
I wait for your answer, hope this is useful to improve kernel.

David.

--Boundary-00=_sx97GWS5V3L1qQH
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
35 structures occupying 1231 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: 04AB
	Release Date: 06/08/2007
	Address: 0xE6960
	Runtime Size: 104096 bytes
	ROM Size: 64 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
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
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Product Name: SR70S/SR71S
	Version: 03AB
	Serial Number: 828W93CP500506
	UUID: 80D3C740-D21D-B211-8000-EC6E97A66AD1
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Product Name: SR70S/SR71S
	Version:     
	Serial Number: 123490EN400015

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
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
	ID: FD 06 00 00 FF FB EB BF
	Version: CPU Version
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 4096 MHz
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
	Installed Size: 64 KB
	Maximum Size: 64 KB
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
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 4096 KB
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

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Mouse Port

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
	Designation: CARDBUS 0
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Unknown
	Length: Other
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x000B, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x000C, DMI type 11, 5 bytes
OEM Strings
	String 1: AABBAAAAAAAA
	String 2: 20YY/MM

Handle 0x000D, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x000E, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x000000E9
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000F, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1000 MB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0010, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000F
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 0
	Serial Number: 1234-B0
	Asset Tag: Not Specified
	Part Number: SODIMM000

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000F
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 1
	Serial Number: 1234-B1
	Asset Tag: Not Specified
	Part Number: SODIMM001

Handle 0x0012, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000F
	Partition Width: 0

Handle 0x0013, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0010
	Memory Array Mapped Address Handle: 0x0012
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0012
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 22, 26 bytes
Portable Battery
	Location: Rear
	Manufacturer: Intel Corporation
	Name: Intel Corporation
	Chemistry: Lithium Ion
	Design Capacity: 1000 mWh
	Design Voltage: 19 mV
	SBDS Version: BATT_1234
	Maximum Error: 100%
	SBDS Serial Number: 0001
	SBDS Manufacture Date: 1980-00-01
	OEM-specific Information: 0x00000000

Handle 0x0016, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0017, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x0018, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0019, DMI type 26, 20 bytes
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

Handle 0x001A, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x001B
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001B, DMI type 28, 20 bytes
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

Handle 0x001C, DMI type 29, 20 bytes
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

Handle 0x001D, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x001E, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001F, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 1F 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0020, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 20 00 FF FF

Handle 0x0021, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 21 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x0022, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_sx97GWS5V3L1qQH--
