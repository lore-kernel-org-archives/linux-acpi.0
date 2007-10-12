From: "Marco Calviani" <marco.calviani@gmail.com>
Subject: Re: Acer Aspire 5720 thermal issues (CORRECTED MODEL name)
Date: Fri, 12 Oct 2007 21:43:41 +0200
Message-ID: <da5cd1900710121243r3522b706s6143f16ef255477a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:13967 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbXJLTnn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Oct 2007 15:43:43 -0400
Received: by wr-out-0506.google.com with SMTP id 36so597954wra
        for <linux-acpi@vger.kernel.org>; Fri, 12 Oct 2007 12:43:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: acpi@linux.intel.com

I'm attaching also the dmidecode logfile, maybe it could be of help

# dmidecode 2.9
SMBIOS 2.4 present.
37 structures occupying 1489 bytes.
Table at 0x000E2AE0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Acer
	Version: V1.18
	Release Date: 09/27/2007
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer
	Product Name: Aspire 5720
	Version: V1.18
	Serial Number: LXAHE0X2267371AF671601
	UUID: 79AAF9EB-ABBD-B710-1E62-001B384F8D62
	Wake-up Type: Power Switch
	SKU Number: None
	Family: None

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Acer
	Product Name: Nettiling
	Version: V1.18
	Serial Number: Base Board Serial Number
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Acer
	Type: Other
	Lock: Not Present
	Version: V1.18
	Serial Number: Chassis Serial Number
	Asset Tag:
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 9, 13 bytes
System Slot Information
	Designation: J6C1
	Type: x16 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0005, DMI type 9, 13 bytes
System Slot Information
	Designation: J8C1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
	Designation: J7C1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 1
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: J8D1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 2
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: J8B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		SMBus signal is supported

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
	Designation: J9B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		SMBus signal is supported

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2
	Internal Connector Type: None
	External Reference Designator: Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LAN
	Internal Connector Type: None
	External Reference Designator: Network
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2H2
	Internal Connector Type: On Board IDE
	External Reference Designator: OnBoard Primary IDE
	External Connector Type: None
	Port Type: Other

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2H1
	Internal Connector Type: On Board IDE
	External Reference Designator: OnBoard Secondary IDE
	External Connector Type: None
	Port Type: Other

Handle 0x0012, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Intel Video Graphics Controller

Handle 0x0013, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Broadcom Lan Controller

Handle 0x0014, DMI type 11, 6 bytes
OEM Strings
	String 1: EFI Software for Nettiling and Poyang

Handle 0x0015, DMI type 12, 5 bytes
System Configuration Options
	Option 1: J1D4:1-2,5-6,9-10Default;2-3CMOS clr,6-7Pswd clr,10-11Recovery

Handle 0x0016, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 4

Handle 0x0017, DMI type 22, 26 bytes
Portable Battery
	Location: Internal Battery
	Manufacturer: Sony
	Serial Number: Not Supported
	Name: Li-ion(6cell)
	Chemistry: Lithium Ion
	Design Capacity: 51840 mWh
	Design Voltage: 10800 mV
	SBDS Version: Not Specified
	Maximum Error: Unknown
	SBDS Manufacture Date: 1980-00-00
	OEM-specific Information: 0xFFFFFFFF

Handle 0x0018, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0019, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0018
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x02008097
	Asset Tag: Unknown
	Part Number: 0x48594D503131325336344350362D59352020

Handle 0x001A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 0
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0019
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x001C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0018
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK 2
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x00005098
	Asset Tag: Unknown
	Part Number: 0x48594D503131325336344350362D59352020

Handle 0x001D, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: 0 0
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x001E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x001C
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x001F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0018
	Partition Width: 0

Handle 0x0020, DMI type 4, 35 bytes
Processor Information
	Socket Designation: uPGA-478
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R) Corporation
	ID: FA 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 10
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM)2 Duo CPU     T7300  @ 2.00GHz
	Voltage: 1.6 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: Socket 478
	L1 Cache Handle: 0x0023
	L2 Cache Handle: 0x0021
	L3 Cache Handle: Not Provided
	Serial Number: NotSupport
	Asset Tag: FFFF
	Part Number: FFFF

Handle 0x0021, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 4096 KB
	Maximum Size: 4096 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: Unknown

Handle 0x0022, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0023, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0024, DMI type 127, 4 bytes
End Of Table



On 10/11/07, Marco Calviani <marco.calviani@gmail.com> wrote:
> Hi list,
>     i have thermal problems with my Acer Aspire 5720 (Santa Rosa,
> T7300 Intel Core 2 Duo).
> In particular:
>
> # cat /proc/acpi/thermal_zone/TZ01/trip_points
> critical (S5):           100 C
>
> so that there is no rules for activating the fans (and cat
> /proc/acpi/fan/ in empty, but as suggested by the acpi_acer driver,
> this is normal for Acer laptops). The only way to control the laptop
> CPU temperature is with the coretemp module (but it does not swith on
> the fans when the temperature increases anyway).
>
> Additionally
> proc/acpi/thermal_zone/TZ01/temperature does not get updated neither
> if i change the polling_freqency, so that even if the core temperature
> reaches 70-80C the fans never starts.
>
> I've also tried to install acer_acpi in order to
> see f this can change the situation, but in fact the module fail when
> it comes to load :
>
> acer_acpi: Acer Laptop ACPI Extras version 0.9.1
> acer_acpi: No or unsupported WMI interface, unable to load.
>
> My original DSDT table is here (thanks to Carlos):
> http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5720.dsl
> It does not compile again (so is a buggy dsdt): i've manage to wipe
> out the errors but still warning remais. However when it comes to
> include it into the kernel, during startup the system hang up at CPU
> recognition.
>
> I'm using Gentoo Linux with kernel version 2.6.22. i've tried also
> with 2.6.23-rc8-mm2, but it is the same.
>
> Thanks in advance,
> Marco
>
