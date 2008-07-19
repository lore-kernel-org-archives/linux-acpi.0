From: Dieter Probst <diprob@yahoo.com>
Subject: dmidecode output asked for by dmesg
Date: Sat, 19 Jul 2008 10:25:40 -0700 (PDT)
Message-ID: <766407.41448.qm@web31801.mail.mud.yahoo.com>
Reply-To: diprob@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:48646 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754707AbYGSRcV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jul 2008 13:32:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

dmesg output:

ACPI: Please test with "acpi_osi=!Linux"

After adding this setting to kernel parameter demsg shows the following lines during next boot (dmesg|grep acpi) 


noname:~ # dmesg |grep acpi
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Kernel command line: acpi_osi=!Linux root=/dev/disk/by-id/scsi-SATA_WDC_WD2500BEVS-_WD-WXC308218316-part7 vga=0x314 resume=/dev/sda5 splash=silent
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org


So here is the dmidecode output:

# dmidecode 2.9
SMBIOS 2.4 present.
19 structures occupying 726 bytes.
Table at 0x000DF010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Hewlett-Packard
        Version: F.2F
        Release Date: 04/23/2008
        Address: 0xE69E0
        Runtime Size: 103968 bytes
        ROM Size: 1024 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                Smart battery is supported
                Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Hewlett-Packard
        Product Name: HP Pavilion dv6700 Notebook PC
        Version: Rev 1
        Serial Number: CNF8183F12
        UUID: 434E4638-3138-3346-3132-001E68667BDD
        Wake-up Type: Power Switch
        SKU Number: FF746EA#ABD
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Quanta
        Product Name: 30D0
        Version: 85.26
        Serial Number: None2

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: Quanta
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag:
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000104

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: Socket S1
        Type: Central Processor
        Family: Opteron
        Manufacturer: AMD
        ID: 82 0F 06 00 FF FB 8B 17
        Signature: Family 15, Model 104, Stepping 2
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
        Version: AMD Turion(tm) 64 X2 Mobile TL60
        Voltage: 1.6 V
        External Clock: 200 MHz
        Max Speed: 2000 MHz
        Current Speed: 2000 MHz
        Status: Populated, Enabled
        Upgrade: None
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
        Socket Designation: L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 1024 KB
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
        Designation: PCI Express Slot 1
        Type: 64-bit PCI Express
        Current Usage: Available
        Length: Short
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot 2
        Type: 64-bit PCI Express
        Current Usage: Available
        Length: Short
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported
                Hot-plug devices are supported

Handle 0x0009, DMI type 10, 6 bytes
On Board Device Information
        Type: Video
        Status: Enabled
        Description:

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
        String 1: $HP$
        String 2: LOC#ABD
        String 3: ABS 70/71 6A 6B 6C 6D

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
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 2048 MB
        Form Factor: DIMM
        Set: 1
        Locator: DIMM 1
        Bank Locator: Bank 0,1
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
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: DIMM 2
        Bank Locator: Bank 2,3
        Type: DDR2
        Type Detail: Unknown
        Speed: 667 MHz (1.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000BFFFFFFF
        Range Size: 3 GB
        Physical Array Handle: 0x000B
        Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
        Physical Device Handle: 0x000C
        Memory Array Mapped Address Handle: 0x000E
        Partition Row Position: 2
        Interleave Position: 2
        Interleaved Data Depth: 2

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00080000000
        Ending Address: 0x000BFFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000D
        Memory Array Mapped Address Handle: 0x000E
        Partition Row Position: 2
        Interleave Position: 2
        Interleaved Data Depth: 2

Handle 0x0011, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0012, DMI type 127, 4 bytes
End Of Table

Please let me know in case additional information helps.

Best regards,
- Dieter Probst


      
