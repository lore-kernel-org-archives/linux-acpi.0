From: Greg Sanders <greg@gallensanders.org>
Subject: dmidecode output HP DV2320US laptop
Date: Sat, 29 Dec 2007 08:37:25 -0700
Message-ID: <200712290837.25509.greg@gallensanders.org>
Reply-To: greg@gallensanders.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1mmdHmxGVIrQ5SW"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpauth12.prod.mesa1.secureserver.net ([64.202.165.35]:35896
	"HELO smtpauth12.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753190AbXL2PoG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Dec 2007 10:44:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_1mmdHmxGVIrQ5SW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yo,

I saw a message in syslog to send dmidecode output to this email address.  
Here goes:
-----------------------------------------------------------------------------------------------

# dmidecode 2.9
SMBIOS 2.4 present.
27 structures occupying 867 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Hewlett-Packard
        Version: F.34
        Release Date: 06/02/2007
        Address: 0xE7F70
        Runtime Size: 98448 bytes
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
        BIOS Revision: 15.52
        Firmware Revision: 62.87

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Hewlett-Packard
        Product Name: HP Pavilion dv2000 (RV323UA#ABA)
        Version: F.34
        Serial Number: 2CE7171BDY
        UUID: 1501AA80-F433-11DB-9D1A-9EE3B10D875F
        Wake-up Type: Power Switch
        SKU Number: RV323UA#ABA
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Wistron
        Product Name: 30B5
        Version: 62.57
        Serial Number:

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: Wistron
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number:
        Asset Tag:
        Boot-up State: Unknown
        Power Supply State: Unknown
        Thermal State: Unknown
        Security Status: Unknown
        OEM Information: 0x00001200

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: U1
        Type: Central Processor
        Family: Opteron
        Manufacturer: AMD
        ID: 82 0F 04 00 FF FB 8B 17
        Signature: Family 15, Model 72, Stepping 2
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
                MMX (MMX technology supported)
                FXSR (Fast floating-point save and restore)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                HTT (Hyper-threading technology)
        Version: AMD Turion(tm) 64 X2
        Voltage: 3.3 V
        External Clock: 200 MHz
        Max Speed: 2000 MHz
        Current Speed: 2000 MHz
        Status: Populated, Enabled
        Upgrade: Slot 1
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
        Maximum Size: 2048 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCMCIA Slot CBUS1
        Type: 32-bit PC Card (PCMCIA)
        Current Usage: Available
        Length: Long
        ID: Adapter 0, Socket 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PC Card-16 is supported
                Cardbus is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
        Type: Video
        Status: Enabled
        Description: 64

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
        String 1: $HP$
        String 2: LOC#yyy

Handle 0x000A, DMI type 15, 29 bytes
System Event Log
        Area Length: 0 bytes
        Header Start Offset: 0x0000
        Data Start Offset: 0x0000
        Access Method: General-purpose non-volatile data functions
        Access Address: 0x0000
        Status: Invalid, Not Full
        Change Token: 0x00000000
        Header Format: No Header
        Supported Log Type Descriptors: 3
        Descriptor 1: POST error
        Data Format 1: POST results bitmap
        Descriptor 2: Single-bit ECC memory error
        Data Format 2: Multiple-event
        Descriptor 3: Multi-bit ECC memory error
        Data Format 3: Multiple-event

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 4 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000B
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 1024 MB
        Form Factor: SODIMM
        Set: 1
        Locator: M1
        Bank Locator: Bank 0
        Type: DDR
        Type Detail: Synchronous
        Speed: 667 MHz (1.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000B
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 1024 MB
        Form Factor: SODIMM
        Set: 1
        Locator: M2
        Bank Locator: Bank 1
        Type: DDR
        Type Detail: Synchronous
        Speed: 667 MHz (1.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
        Physical Array Handle: 0x000B
        Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
        Physical Device Handle: 0x000C
        Memory Array Mapped Address Handle: 0x000E
        Partition Row Position: 1

Handle 0x0010, DMI type 23, 13 bytes
System Reset
        Status: Enabled
        Watchdog Timer: Present
        Boot Option: Do Not Reboot
        Boot Option On Limit: Do Not Reboot
        Reset Count: Unknown
        Reset Limit: Unknown
        Timer Interval: Unknown
        Timeout: Unknown

Handle 0x0011, DMI type 24, 5 bytes
Hardware Security
        Power-On Password Status: Disabled
        Keyboard Password Status: Unknown
        Administrator Password Status: Enabled
        Front Panel Reset Status: Unknown

Handle 0x0012, DMI type 25, 9 bytes
        System Power Controls
        Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0013, DMI type 26, 20 bytes
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

Handle 0x0014, DMI type 27, 12 bytes
Cooling Device
        Temperature Probe Handle: 0x0015
        Type: Fan
        Status: OK
        OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 28, 20 bytes
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

Handle 0x0016, DMI type 29, 20 bytes
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

Handle 0x0017, DMI type 30, 6 bytes
Out-of-band Remote Access
        Manufacturer Name: Intel
        Inbound Connection: Enabled
        Outbound Connection: Disabled

Handle 0x0018, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0019, DMI type 150, 14 bytes
OEM-specific Type
        Header and Data:
                96 0E 19 00 01 01 00 00 00 00 00 00 00 00
        Strings:
                ABSOLUTE(PHOENIX) CLM

Handle 0x001A, DMI type 127, 4 bytes
End Of Table
---------------------------------------------------------------------------------------

I also attached it as a file if that helps.

greg

--Boundary-00=_1mmdHmxGVIrQ5SW
Content-Type: text/plain;
  charset="utf-8";
  name="dmidecode_122907_HP-DV2320US.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode_122907_HP-DV2320US.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
27 structures occupying 867 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.34
	Release Date: 06/02/2007
	Address: 0xE7F70
	Runtime Size: 98448 bytes
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
	BIOS Revision: 15.52
	Firmware Revision: 62.87

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv2000 (RV323UA#ABA)
	Version: F.34
	Serial Number: 2CE7171BDY
	UUID: 1501AA80-F433-11DB-9D1A-9EE3B10D875F
	Wake-up Type: Power Switch
	SKU Number: RV323UA#ABA
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Wistron
	Product Name: 30B5
	Version: 62.57
	Serial Number:           

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Wistron
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number:           
	Asset Tag:                     
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00001200

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 72, Stepping 2
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
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Turion(tm) 64 X2 
	Voltage: 3.3 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: Slot 1
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
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCMCIA Slot CBUS1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Long
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: 64 

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#yyy

Handle 0x000A, DMI type 15, 29 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Data Start Offset: 0x0000
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Invalid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000B
	Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: 1

Handle 0x0010, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0011, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x0012, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0013, DMI type 26, 20 bytes
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

Handle 0x0014, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x0015
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 28, 20 bytes
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

Handle 0x0016, DMI type 29, 20 bytes
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

Handle 0x0017, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0018, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0019, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 19 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x001A, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_1mmdHmxGVIrQ5SW--
