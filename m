From: Franck Gille' <franck.gille@ac-rouen.fr>
Subject: dmidecode on my vaio
Date: Mon, 31 Mar 2008 14:33:23 +0200
Message-ID: <47F0DA13.70409@ac-rouen.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080801020901020409000600"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.ac-rouen.fr ([194.167.196.131]:39007 "EHLO
	dallas.ac-rouen.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751986AbYCaMwQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Mar 2008 08:52:16 -0400
Received: from dallas.ac-rouen.fr (localhost.localdomain [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 59110700D6
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2008 14:33:24 +0200 (CEST)
Received: from [172.30.207.3] (unknown [172.30.207.3])
	by dallas.ac-rouen.fr (Postfix) with ESMTP id 38DA8700C5
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2008 14:33:24 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080801020901020409000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi
I'm running on Linux gillef-laptop 2.6.22-14-generic #1 SMP Tue Feb 12 
07:42:25 UTC 2008 i686 GNU/Linux
Hardware is sony vaio vgn-AR51M,
i can't adjust brightness, can't use webcam, dans function key don't 
work, i try with kernel 2.6.24 and it don't work better.
Can you help me or do i work with vista :-( ?

Best Regards
Franck

-- 
Franck Gillé
Equipe Réseaux-Sécurité
Division Informatique
Rectorat de ROUEN
Tél: 02.32.08.94.17
Fax: 02.32.08.94.12


--------------080801020901020409000600
Content-Type: text/plain;
 name="dmidecode.VGNAR-51M"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.VGNAR-51M"

# dmidecode 2.9
SMBIOS 2.4 present.
18 structures occupying 731 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: R1050J8
	Release Date: 07/18/2007
	Address: 0xE7000
	Runtime Size: 100 kB
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
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 5.0
	Firmware Revision: 5.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-AR51M
	Version: C3LQ2JWQ
	Serial Number: 28270261-5000552
	UUID: B6F64800-7219-11DC-80E7-001A801B7569
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
	Serial Number: N/A
	Asset Tag: N/A
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: N/A
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: FD 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz
	Voltage: 1.2 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
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
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
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
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
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
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

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
		Hot-plug devices are supported

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: 0000017631
	String 2: FNC-CCIA0gdbEXTB
	String 3: 058D000000008D8C073792BAC034
	String 4: Reserved
	String 5: Reserved

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2048 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Unknown

Handle 0x000C, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Unknown

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
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
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0010, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0011, DMI type 127, 4 bytes
End Of Table


--------------080801020901020409000600--
