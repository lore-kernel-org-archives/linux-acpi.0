From: "W. Conrad GP" <conrad@praxisarzt.de>
Subject: IT SAID " Please send dmidecode to linux-acpi@vger.kernel.org" ...
Date: Sat, 17 Nov 2007 19:06:14 +0100
Message-ID: <473F2D96.8040305@praxisarzt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:51257 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbXKQSIK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Nov 2007 13:08:10 -0500
Received: from mo-p07-ob.rzone.de (klopstock-mo-p07-ob.mail [192.168.63.178])
	by gibbsson-fb-08.store (RZmta 14.0) with ESMTP id V02884jAHFG7Q8
	for <linux-acpi@vger.kernel.org>; Sat, 17 Nov 2007 19:08:08 +0100 (MET)
	(envelope-from: <conrad@praxisarzt.de>)
Received: from [192.168.1.4] (e178086047.adsl.alicedsl.de [85.178.86.47])
	by post.webmailer.de (klopstock mo56) (RZmta 14.0)
	with ESMTP id 5047c4jAHH8AIe for <linux-acpi@vger.kernel.org>;
	Sat, 17 Nov 2007 19:06:15 +0100 (MET)
	(envelope-from: <conrad@praxisarzt.de>)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

in /var/log/messages.


The output is appended below.


==

root@conport:/home/coney# dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 803 bytes.
Table at 0x37EE3000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: 1.00
        Release Date: 08/27/2007
        Address: 0xE3D70
        Runtime Size: 115344 bytes
        ROM Size: 1024 kB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/360 KB floppy services are supported (int 13h)
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 KB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: TOSHIBA
        Product Name: Satellite A210
        Version: PSAFGE-02600RGR
        Serial Number: X7059827Q
        UUID: 1E45BA00-71CE-11DC-A70E-00A0D185ABE3
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: ATI
        Product Name: SB600
        Version: Rev 1
        Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: AMD
        Type: Other
        Lock: Not Present
        Version: None
        Serial Number: None
        Asset Tag: No Asset Tag
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: Socket M2/S1G1
        Type: Central Processor
        Family: Opteron
        Manufacturer: AMD
        ID: 81 0F 06 00 FF FB 8B 17
        Signature: Family 15, Model 104, Stepping 1
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
        Version: Engineering Samplenology
        Voltage: 1.4 V
        External Clock: 200 MHz
        Max Speed: 4000 MHz
        Current Speed: 1800 MHz
        Status: Populated, Enabled
        Upgrade: Other
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: Not Provided
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Not Socketed, Level 1
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
        Socket Designation: H0 L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 512 KB
        Maximum Size: 1024 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unified
        Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI1
        Type: 32-bit PCI
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI2
        Type: 32-bit PCI
        Current Usage: Available
        Length: Long
        ID: 2
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
        String 1: SSAFGE02600RGR
        String 2:
        String 3:
        String 4:
        String 5:

Handle 0x000A, DMI type 12, 5 bytes
System Configuration Options
        Option 1: NVR:00707002
        Option 2: DSN:5LZ5M77Z
        Option 3: DSN:TMS1GS264C082665AP00000000
        Option 4: DSN:7BC50786

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 2 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000B
        Error Information Handle: No Error
        Total Width: 128 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: S1
        Bank Locator: DIMM1
        Type: DDR2
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
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: 2
        Locator: S2
        Bank Locator: DIMM2
        Type: DDR2
        Type Detail: Unknown
        Speed: Unknown
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000E, DMI type 18, 23 bytes
32-bit Memory Error Information
        Type: OK
        Granularity: Unknown
        Operation: Unknown
        Vendor Syndrome: Unknown
        Memory Array Address: Unknown
        Device Address: Unknown
        Resolution: Unknown

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000B
        Partition Width: 0

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000C
        Memory Array Mapped Address Handle: 0x000F
        Partition Row Position: 2
        Interleave Position: 1
        Interleaved Data Depth: 6

Handle 0x0011, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0012, DMI type 150, 14 bytes
OEM-specific Type
        Header and Data:
                96 0E 12 00 01 01 00 00 00 00 00 00 00 00
        Strings:
                ABSOLUTE(PHOENIX) CLM

Handle 0x0013, DMI type 127, 4 bytes
End Of Table

root@conport:/home/coney#


