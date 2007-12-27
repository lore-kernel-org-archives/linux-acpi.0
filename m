From: Parminder Singh Dhillon <theboywho@ruddyperl.com>
Subject: RE: dmidecode output for a Sony Vaio TZ21MN
Date: Thu, 27 Dec 2007 00:18:24 +0000
Message-ID: <200712270018.25131.theboywho@ruddyperl.com>
Reply-To: theboywho@ruddyperl.com
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R9ucHmscH0GmSa3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mars.ruddyperl.com ([80.68.91.241]:1986 "EHLO
	mars.ruddyperl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbXL0Amp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 19:42:45 -0500
Received: from x303.local (82-37-107-201.cable.ubr02.sand.blueyonder.co.uk [82.37.107.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mars.ruddyperl.com (Postfix) with ESMTP id 4DA2D67B3F6
	for <linux-acpi@vger.kernel.org>; Thu, 27 Dec 2007 00:18:34 +0000 (GMT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_R9ucHmscH0GmSa3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

While looking through my dmesg output I saw this message:

Please send dmidecode to linux-acpi@vger.kernel.org

So please find attached the output of dmidecode for me Sony Vaio TZ21MN/N.

If there is any other information you require, please contact me.

--Boundary-00=_R9ucHmscH0GmSa3
Content-Type: text/plain;
  charset="utf-8";
  name="dmi-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmi-output"

# dmidecode 2.9
SMBIOS 2.4 present.
18 structures occupying 973 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: R0052N7
	Release Date: 07/11/2007
	Address: 0xE42D0
	Runtime Size: 113968 bytes
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
		EDD is supported
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		IEEE 1394 boot is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 5.2
	Firmware Revision: 5.2

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-TZ21MN_N
	Version: J002RMWG
	Serial Number: 28206960-5000722
	UUID: F942DE40-5B3C-11D9-8C31-001A8055B489
	Wake-up Type: Power Switch
	SKU Number: N/A                             
	Family: N/A                             

Handle 0x0002, DMI type 2, 10 bytes
Base Board Information
	Manufacturer: Sony Corporation
	Product Name: VAIO                            
	Version: N/A                             
	Serial Number: N/A                             

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Sony Corporation
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: J002RMWG
	Asset Tag:                                                   
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x000000FF

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: N/A
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: F2 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU         U7500  @ 1.06GHz
	Voltage: 0.9 V
	External Clock: 133 MHz
	Max Speed: 1066 MHz
	Current Speed: 1066 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: N/A
	Asset Tag: N/A
	Part Number: N/A

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
	Error Correction Type: None
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Unknown
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: JPBL-003673
	String 2: FNC-CCIA0eee
	String 3: 4L2M00000000ac5a404caaaada25
	String 4: Reserved              
	String 5: Reserved              

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Unknown
	Maximum Capacity: 2048 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM2
	Bank Locator: Bank 1
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0003FFFFC00
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 kB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0011, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 11 00 5A 5A

Handle 0x0012, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_R9ucHmscH0GmSa3--
