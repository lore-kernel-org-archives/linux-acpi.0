From: Moritz Muehlenhoff <jmm-jNDFPZUTrfTJi8DqpkIagb0g9mU11dCt@public.gmane.org>
Subject: ACPI whitelist for working DMIs
Date: Mon, 20 Oct 2003 13:51:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031020115132.GA802@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
when I upgraded from a older 2.6.0-test kernel to test8 ACPI stopped
working because it claims that my 97 bios is too old. As everything
worked fine in the past and still works with acpi=force I decoded my
DMI to give you an impression of my setup. Is it possible to whitelist
working ACPI setups such as mine?

Cheers,
         Moritz

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmi-baycom-worldbook.txt"

# dmidecode 2.3
SMBIOS 2.2 present.
47 structures occupying 1526 bytes.
Table at 0x000ED6F6.
Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information
		Vendor: SystemSoft
		Version: Version 1.00
		Release Date: 10/22/97
		Address: 0xEC000
		Runtime Size: 80 kB
		ROM Size: 256 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			BIOS ROM is socketed
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			Smart battery is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer:                 
		Product Name: SiS 630S
		Version: None
		Serial Number: 12345678
		UUID: Not Present
		Wake-up Type: Unknown
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: KAPOK           
		Product Name: SiS 630S
		Version: None
		Serial Number: 12345678
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information
		Manufacturer: KAPOK           
		Type: Portable
		Lock: Not Present
		Version: 5a
		Serial Number: 12345678
		Asset Tag: 12345678
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: uPGA2
		Type: Central Processor
		Family: Pentium
		Manufacturer: GenuineIntel
		ID: FF F9 83 03 00 00 00 00
		Signature: Type 3, Family 389, Model 3F, Stepping F
		Flags: None
		Version: Pentium III
		Voltage: 2.9 V
		External Clock: 66 MHz
		Max Speed: 996 MHz
		Current Speed: 996 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: 0x0000
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 128 KB
		Maximum Size: 128 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Serial Port
		Internal Connector Type: None
		External Reference Designator: J16
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0008
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Parallel Port
		Internal Connector Type: None
		External Reference Designator: J20
		External Connector Type: DB-25 male
		Port Type: Parallel Port ECP/EPP
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Kbd Connector
		Internal Connector Type: None
		External Reference Designator: J8
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Mouse Conn.
		Internal Connector Type: None
		External Reference Designator: J9
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: USB Conn.
		Internal Connector Type: None
		External Reference Designator: J12
		External Connector Type: Other
		Port Type: USB
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Dock Conn.
		Internal Connector Type: None
		External Reference Designator: J6
		External Connector Type: Other
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: VGA Conn.
		Internal Connector Type: None
		External Reference Designator: J7
		External Connector Type: Other
		Port Type: Other
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: DC Input
		Internal Connector Type: None
		External Reference Designator: J35
		External Connector Type: Other
		Port Type: Other
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: IrDA Port
		Internal Connector Type: None
		External Reference Designator: U1
		External Connector Type: Infrared
		Port Type: Other
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CardBus Conn.
		Internal Connector Type: None
		External Reference Designator: J26
		External Connector Type: Other
		Port Type: Cardbus
Handle 0x0011
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: ISA Slot
		Type: 16-bit ISA
		Current Usage: Available
		Length: Long
		Characteristics: Unknown
Handle 0x0012
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics: Unknown
Handle 0x0013
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP Slot
		Type: 32-bit AGP
		Current Usage: In Use
		Length: Long
		ID: 4
		Characteristics: Unknown
Handle 0x0014
	DMI type 10, 16 bytes.
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: ECP Port
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: 16550 UART
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: IrDA Port
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: CardBus Bridge
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: IDE Controller
	On Board Device Information
		Type: Video
		Status: Enabled
		Description: VGA
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x050B
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x0015
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: SystemSoft SM-BIOS For SiS
Handle 0x0016
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: SystemSoft SM-BIOS For SiS
Handle 0x0017
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US|iso8859-1
		Currently Installed Language: en|US|iso8859-1
Handle 0x0022
	DMI type 18, 25 bytes.
	32-bit Memory Error Information
		Type: Unknown
		Granularity: Memory Partition Level
		Operation: Unknown
		Vendor Syndrome: Unknown
		Memory Array Address: Unknown
		Device Address: Unknown
		Resolution: Unknown
Handle 0x0022
	DMI type 4, 0 bytes.
	Processor Information
Handle 0x190F
	DMI type 0, 16 bytes.
	BIOS Information
Handle 0x001A
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Flash Memory
		Error Correction Type: None
		Maximum Capacity: 2 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x001B
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Cache Memory
		Error Correction Type: None
		Maximum Capacity: 256 kB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x001C
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0018
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1020 MB
		Form Factor: DIMM
		Set: Unknown
		Locator: DRAM Slot 0
		Bank Locator: Banks 0/1
		Type: DRAM
		Type Detail: EDO
Handle 0x001D
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0018
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: No Module Installed
		Form Factor: DIMM
		Set: Unknown
		Locator: DRAM Slot 1
		Bank Locator: Banks 2/3
		Type: DRAM
		Type Detail: EDO
Handle 0x001E
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0018
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: No Module Installed
		Form Factor: DIMM
		Set: Unknown
		Locator: DRAM Slot 2
		Bank Locator: Banks 4/5
		Type: DRAM
		Type Detail: EDO
Handle 0x001F
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0019
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 2 MB
		Form Factor: TSOP
		Set: Unknown
		Locator: Video Memory
		Bank Locator: U39/U40
		Type: VRAM
		Type Detail: Unknown
Handle 0x0020
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: No Module Installed
		Form Factor: TSOP
		Set: Unknown
		Locator: Cache SRAM
		Bank Locator: U5/U6
		Type: SRAM
		Type Detail: Unknown
Handle 0x0021
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001A
		Error Information Handle: Not Provided
		Total Width: 16 bits
		Data Width: 16 bits
		Size: 2 MB
		Form Factor: TSOP
		Set: Unknown
		Locator: Flash BIOS U43
		Bank Locator: U43
		Type: EEPROM
		Type Detail: Unknown
Handle 0x0023
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x00003BFFFFF
		Range Size: 60 MB
		Physical Array Handle: 0x0018
		Partition Width: 0
Handle 0x0024
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Mouse
		Interface: PS/2
		Buttons: 2
Handle 0x0025
	DMI type 22, 16 bytes.
	Portable Battery
		Location: <BAD INDEX>
		Manufacturer: <BAD INDEX>
		Manufacture Date: <BAD INDEX>
		Serial Number: <BAD INDEX>
		Name: <BAD INDEX>
		Chemistry: Unknown
		Design Capacity: Unknown
		Design Voltage: 12 mV
		SBDS Version: <BAD INDEX>
		Maximum Error: 6%
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x6D53
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x7261
	DMI type 83, 109 bytes.
	Unknown Type
		Header and Data:
			53 6D 61 72 74 20 42 61 74 74 65 72 79 20 43 6F
			6E 6E 20 4A 33 37 00 44 75 72 61 63 65 6C 6C 00
			30 31 2F 30 36 2F 39 37 00 30 30 34 32 00 44 52
			33 36 00 56 31 2E 30 00 00 17 0D 26 00 00 FF FF
			FF FF FF FF FF FF 00 18 05 27 00 22 00 19 09 28
			00 00 00 00 00 00 00 1A 14 29 00 01 42 00 80 00
			80 00 80 00 80 00 80 00 00 00 00 56 6F
		Strings:
			ltage Probe Description
			..*
			+
			B
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information
Handle 0x141C
	DMI type 0, 0 bytes.
	BIOS Information
Wrong DMI structures length: 1526 bytes announced, structures occupy 1398 bytes.

--tThc/1wpZn/ma/RB--


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
