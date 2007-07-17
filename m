From: gothicx@sapo.pt
Subject: System BIOS is requesting...
Date: Tue, 17 Jul 2007 20:21:57 +0100
Message-ID: <20070717202157.w4omck7ntllw8g08@w11.mail.sapo.pt>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_525yv8edsmps"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:44162 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753224AbXGQT2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2007 15:28:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This message is in MIME format.

--=_525yv8edsmps
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Distribution: Ubuntu Gutsy with kernel v2.6.22

ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org


Sem mais de momento,
Marco Rodrigues
--
Portal Tondela Online
www.Tondela.org

--=_525yv8edsmps
Content-Type: text/x-log;
	charset=UTF-8;
	name="dmidecode.log"
Content-Disposition: attachment;
	filename="dmidecode.log"
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.9
SMBIOS 2.33 present.
25 structures occupying 808 bytes.
Table at 0x000E3810.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
=09Vendor: Acer
=09Version: V3.10
=09Release Date: 11/15/2006
=09Address: 0xE69B0
=09Runtime Size: 104016 bytes
=09ROM Size: 1024 kB
=09Characteristics:
=09=09PCI is supported
=09=09PC Card (PCMCIA) is supported
=09=09PNP is supported
=09=09BIOS is upgradeable
=09=09BIOS shadowing is allowed
=09=09ESCD support is available
=09=09Boot from CD is supported
=09=09Selectable boot is supported
=09=09Print screen service is supported (int 5h)
=09=098042 keyboard services are supported (int 9h)
=09=09Printer services are supported (int 17h)
=09=09CGA/mono video services are supported (int 10h)
=09=09ACPI is supported
=09=09USB legacy is supported
=09=09AGP is supported
=09=09Smart battery is supported
=09=09BIOS boot specification is supported
=09=09Targeted content distribution is supported
=09BIOS Revision: 0.0
=09Firmware Revision: 0.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
=09Manufacturer: Acer           =20
=09Product Name: Aspire 5630    =20
=09Version: V3.10
=09Serial Number: LXAG40J0666450D6031601
=09UUID: 5835016D-AB01-9504-F4EC-0016D457B22B
=09Wake-up Type: Power Switch
=09SKU Number: Not Specified
=09Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
=09Manufacturer: Acer
=09Product Name: Grapevine
=09Version: N/A
=09Serial Number: LXAG40J0666450D6031601

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
=09Manufacturer: Acer
=09Type: Notebook
=09Lock: Not Present
=09Version: N/A
=09Serial Number: None
=09Asset Tag:                                =20
=09Boot-up State: Safe
=09Power Supply State: Safe
=09Thermal State: Safe
=09Security Status: None
=09OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
=09Socket Designation: U1
=09Type: Central Processor
=09Family: Other
=09Manufacturer: Intel
=09ID: F6 06 00 00 FF FB EB BF
=09Version: Intel(R) Core(TM)2 CPU         T5
=09Voltage: 3.3 V
=09External Clock: 166 MHz
=09Max Speed: 1660 MHz
=09Current Speed: 1660 MHz
=09Status: Populated, Enabled
=09Upgrade: ZIF Socket
=09L1 Cache Handle: Not Provided
=09L2 Cache Handle: 0x0005
=09L3 Cache Handle: Not Provided
=09Serial Number: Not Specified
=09Asset Tag: Not Specified
=09Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
=09Socket Designation: L2 Cache
=09Configuration: Enabled, Socketed, Level 2
=09Operational Mode: Write Back
=09Location: Internal
=09Installed Size: 2048 KB
=09Maximum Size: 2048 KB
=09Supported SRAM Types:
=09=09Burst
=09=09Pipeline Burst
=09Installed SRAM Type: Burst
=09Speed: Unknown
=09Error Correction Type: Unknown
=09System Type: Unknown
=09Associativity: Unknown

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
=09Designation: PCI Slot J1100
=09Type: 32-bit PCI
=09Current Usage: In Use
=09Length: Long
=09ID: 0
=09Characteristics:
=09=095.0 V is provided
=09=093.3 V is provided
=09=09PME signal is supported

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
=09Designation: PCI Slot J1101
=09Type: 32-bit PCI
=09Current Usage: In Use
=09Length: Long
=09ID: 0
=09Characteristics:
=09=095.0 V is provided
=09=093.3 V is provided
=09=09PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
=09Type: Sound
=09Status: Disabled
=09Description: HD-Audio

Handle 0x0009, DMI type 14, 11 bytes
Group Associations
=09Name: Cpu Module
=09Items: 2
=09=090x0015 (Processor)
=09=090x0016 (Cache)

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
=09Location: System Board Or Motherboard
=09Use: System Memory
=09Error Correction Type: None
=09Maximum Capacity: 2 GB
=09Error Information Handle: Not Provided
=09Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
=09Array Handle: 0x000A
=09Error Information Handle: No Error
=09Total Width: 32 bits
=09Data Width: 32 bits
=09Size: 512 MB
=09Form Factor: SODIMM
=09Set: 1
=09Locator: M1
=09Bank Locator: Bank 0
=09Type: DDR2
=09Type Detail: Synchronous
=09Speed: Unknown
=09Manufacturer: Not Specified
=09Serial Number: Not Specified
=09Asset Tag: Not Specified
=09Part Number: Not Specified

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
=09Array Handle: 0x000A
=09Error Information Handle: No Error
=09Total Width: 32 bits
=09Data Width: 32 bits
=09Size: 512 MB
=09Form Factor: SODIMM
=09Set: 2
=09Locator: M2
=09Bank Locator: Bank 1
=09Type: DDR2
=09Type Detail: Synchronous
=09Speed: Unknown
=09Manufacturer: Not Specified
=09Serial Number: Not Specified
=09Asset Tag: Not Specified
=09Part Number: Not Specified

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
=09Starting Address: 0x00000000000
=09Ending Address: 0x0003FFFFFFF
=09Range Size: 1 GB
=09Physical Array Handle: 0x000A
=09Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
=09Starting Address: 0x00000000000
=09Ending Address: 0x0003FFFFFFF
=09Range Size: 1 GB
=09Physical Device Handle: 0x000B
=09Memory Array Mapped Address Handle: 0x000D
=09Partition Row Position: 2
=09Interleave Position: 1
=09Interleaved Data Depth: 6

Handle 0x000F, DMI type 23, 13 bytes
System Reset
=09Status: Enabled
=09Watchdog Timer: Present
=09Boot Option: Do Not Reboot
=09Boot Option On Limit: Do Not Reboot
=09Reset Count: Unknown
=09Reset Limit: Unknown
=09Timer Interval: Unknown
=09Timeout: Unknown

Handle 0x0010, DMI type 24, 5 bytes
Hardware Security
=09Power-On Password Status: Disabled
=09Keyboard Password Status: Unknown
=09Administrator Password Status: Disabled
=09Front Panel Reset Status: Unknown

Handle 0x0011, DMI type 25, 9 bytes
=09System Power Controls
=09Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0012, DMI type 26, 20 bytes
Voltage Probe
=09Description: Voltage Probe
=09Location: Processor
=09Status: OK
=09Maximum Value: Unknown
=09Minimum Value: Unknown
=09Resolution: Unknown
=09Tolerance: Unknown
=09Accuracy: Unknown
=09OEM-specific Information: 0x00000000

Handle 0x0013, DMI type 27, 12 bytes
Cooling Device
=09Temperature Probe Handle: 0x0014
=09Type: Fan
=09Status: OK
=09OEM-specific Information: 0x00000000

Handle 0x0014, DMI type 28, 20 bytes
Temperature Probe
=09Description: Temperature Probe
=09Location: Processor
=09Status: OK
=09Maximum Value: Unknown
=09Minimum Value Unknown
=09Resolution: Unknown
=09Tolerance: Unknown
=09Accuracy: Unknown
=09OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 29, 20 bytes
Electrical Current Probe
=09Description: Electrical Current Probe
=09Location: Processor
=09Status: OK
=09Maximum Value: Unknown
=09Minimum Value: Unknown
=09Resolution: Unknown
=09Tolerance: Unknown
=09Accuracy: Unknown
=09OEM-specific Information: 0x00000000

Handle 0x0016, DMI type 30, 6 bytes
Out-of-band Remote Access
=09Manufacturer Name: Intel
=09Inbound Connection: Enabled
=09Outbound Connection: Disabled

Handle 0x0017, DMI type 32, 20 bytes
System Boot Information
=09Status: <OUT OF SPEC>

Handle 0x0018, DMI type 127, 4 bytes
End Of Table

--=_525yv8edsmps--
