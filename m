From: Hans-Hermann Leinen <h2@leinensoft.de>
Subject: dmidecode (Sony Vaio VGN-TX5MN)
Date: Thu, 21 Feb 2008 13:23:02 +0100
Message-ID: <47BD6D26.2070904@leinensoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080308030606030601090803"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mo-p00-fb.rzone.de ([81.169.146.163]:43738 "EHLO
	mo-p00-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbYBULyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 06:54:53 -0500
Received: from mo-p00-ob.rzone.de (fruni-mo-p00-ob.mail [192.168.63.71])
	by gibbsson-fb-03.store (RZmta 16.5) with ESMTP id i0324bk1L8w9qz
	for <linux-acpi@vger.kernel.org>; Thu, 21 Feb 2008 12:24:43 +0100 (MET)
	(envelope-from: <h2@leinensoft.de>)
Received: from [192.168.1.2] (pD9E87F14.dip.t-dialin.net [217.232.127.20])
	by post.webmailer.de (fruni mo12) (RZmta 16.5)
	with ESMTP id N03481k1L9bxeD for <linux-acpi@vger.kernel.org>;
	Thu, 21 Feb 2008 12:23:43 +0100 (MET)
	(envelope-from: <h2@leinensoft.de>)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308030606030601090803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

hope I interpreted the boot message right.
Find dmidecode output attached.

Kind regards
HHL

--------------080308030606030601090803
Content-Type: text/plain;
 name="sony_vaio_vgn_tx5mn"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sony_vaio_vgn_tx5mn"

# dmidecode 2.9
SMBIOS 2.4 present.
19 structures occupying 994 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: R0051N3
	Release Date: 11/30/2006
	Address: 0xE41F0
	Runtime Size: 114192 bytes
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
	BIOS Revision: 5.1
	Firmware Revision: 5.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-TX5MN_W
	Version: J002E1W1
	Serial Number: 28201552-5001397
	UUID: D3E82F60-5B3C-11D9-839E-0013A9FA863C
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
	Serial Number: J002E1W1
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
	ID: EC 06 00 00 FF FB E9 AF
	Version: Intel(R) Core(TM) Solo CPU     U1400  @ 1.20GHz
	Voltage: 1.1 V
	External Clock: 133 MHz
	Max Speed: 1200 MHz
	Current Speed: 1200 MHz
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

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: PCCARD1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Other
	ID: Adapter 0, Socket 1
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: JPBL-002973
	String 2: FNC-CCIA0ice
	String 3: 4K1M000000003549e7d7d4350a64
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
	Size: 512 MB
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
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM2
	Bank Locator: Bank 1
	Type: DDR
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
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
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


--------------080308030606030601090803--
