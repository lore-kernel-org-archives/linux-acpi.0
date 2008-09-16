From: "Aryn M" <roadrun777@gmail.com>
Subject: DMI info and decode for Gateway ML6729 Laptop
Date: Tue, 16 Sep 2008 18:03:41 -0400
Message-ID: <7dc640fd0809161503h40e0c562sf4bb58d43bdd8b91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:25856 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIPWDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2008 18:03:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2871126rvb.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2008 15:03:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Sep 15 07:06:17 laptop kernel: [    0.627513] ACPI: EC: Look up EC in DSDT
Sep 15 07:06:17 laptop kernel: [    0.639347] ACPI: BIOS _OSI(Linux)
query ignored
Sep 15 07:06:17 laptop kernel: [    0.639354] ACPI: DMI System Vendor: Gateway
Sep 15 07:06:17 laptop kernel: [    0.639361] ACPI: DMI Product Name: ML6720
Sep 15 07:06:17 laptop kernel: [    0.639367] ACPI: DMI Product
Version: 3408933R
Sep 15 07:06:17 laptop kernel: [    0.639374] ACPI: DMI Board Name:
Sep 15 07:06:17 laptop kernel: [    0.639379] ACPI: DMI BIOS Vendor:
Phoenix Technologies LTD
Sep 15 07:06:17 laptop kernel: [    0.639384] ACPI: DMI BIOS Date: 07/12/2007
Sep 15 07:06:17 laptop kernel: [    0.639389] ACPI: Please send DMI
info above to linux-acpi@vger.kernel.org
Sep 15 07:06:17 laptop kernel: [    0.639396] ACPI: If
"acpi_osi=Linux"works better, please notify linux-acpi@vger.kernel.org

# dmidecode 2.9
SMBIOS 2.4 present.
25 structures occupying 1387 bytes.
Table at 0x000DF010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
    Vendor: Phoenix Technologies LTD
    Version: 93.03
    Release Date: 07/12/2007
    Address: 0xE5070
    Runtime Size: 110480 bytes
    ROM Size: 1024 kB
    Characteristics:
        ISA is supported
        PCI is supported
        PC Card (PCMCIA) is supported
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
        Smart battery is supported
        BIOS boot specification is supported
        Function key-initiated network boot is supported
        Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: Gateway
    Product Name: ML6720
    Version: 3408933R
    Serial Number:
    UUID:
    Wake-up Type: Power Switch
    SKU Number: Not Specified
    Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
    Manufacturer: Gateway
    Product Name:
    Version: 93.03
    Serial Number:

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
    Manufacturer: Gateway
    Type: Portable
    Lock: Not Present
    Version: Rev.1
    Serial Number:
    Asset Tag: No Asset Tag
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None
    OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
    Socket Designation: uFCPGA2
    Type: Central Processor
    Family: Other
    Manufacturer: Intel
    ID: FD 06 00 00 FF FB EB BF
    Version: Intel(R) Pentium(R) Dual  CPU  T2310  @ 1.46GHz
    Voltage: 3.3 V
    External Clock: 533 MHz
    Max Speed: 1460 MHz
    Current Speed: 1460 MHz
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
    Installed Size: 1024 KB
    Maximum Size: 1024 KB
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
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: CRT
    External Connector Type: DB-15 female
    Port Type: Video Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: J19
    Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
    External Reference Designator: COM 1
    External Connector Type: DB-9 male
    Port Type: Serial Port 16550A Compatible

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
    Designation: Mini-Card Slot
    Type: x1 PCI Express
    Current Usage: Available
    Length: Short
    ID: 0
    Characteristics:
        3.3 V is provided
        PME signal is supported

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
    Designation: PCMCIA socket 0
    Type: 32-bit PC Card (PCMCIA)
    Current Usage: Unknown
    Length: Long
    ID: Adapter 0, Socket 0
    Characteristics:
        5.0 V is provided
        3.3 V is provided
        PC Card-16 is supported
        Cardbus is supported
        Modem ring resume is supported
        PME signal is supported
        Hot-plug devices are supported

Handle 0x000B, DMI type 10, 12 bytes
On Board Device 1 Information
    Type: Video
    Status: Disabled
    Description: Mobile Intel(R) 965GM Express Chipset Family
On Board Device 2 Information
    Type: Ethernet
    Status: Disabled
    Description: Realtek RTL8101 PCIE 10/100 Network Connection
On Board Device 3 Information
    Type: Sound
    Status: Disabled
    Description: Sigmatel STAC-9200 Audio Codec
On Board Device 4 Information
    Type: Other
    Status: Disabled
    Description: Realtek 5158 Card Reader

Handle 0x000C, DMI type 11, 5 bytes
OEM Strings
    String 1:
    String 2:
    String 3:
    String 4: TrustCode Notebook MA8

Handle 0x000D, DMI type 12, 5 bytes
System Configuration Options
    Option 1: HDD:        K4xxxxxxxxxx

Handle 0x000E, DMI type 15, 29 bytes
System Event Log
    Area Length: 16 bytes
    Header Start Offset: 0x0000
    Header Length: 16 bytes
    Data Start Offset: 0x0010
    Access Method: General-purpose non-volatile data functions
    Access Address: 0x0000
    Status: Valid, Not Full
    Change Token: 0x0000001F
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
    Maximum Capacity: 4 GB
    Error Information Handle: Not Provided
    Number Of Devices: 2

Handle 0x0010, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x000F
    Error Information Handle: 0xFF71
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 1024 MB
    Form Factor: DIMM
    Set: 1
    Locator: DIMM 1
    Bank Locator: Bank 0, 1
    Type: DDR2
    Type Detail: Synchronous
    Speed: 533 MHz (1.9 ns)
    Manufacturer: Not Specified
    Serial Number: 00000000
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x000F
    Error Information Handle: 0xFFC6
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 2048 MB
    Form Factor: DIMM
    Set: 1
    Locator: DIMM 2
    Bank Locator: Bank 2, 3
    Type: DDR2
    Type Detail: Synchronous
    Speed: 533 MHz (1.9 ns)
    Manufacturer: Not Specified
    Serial Number: 00000000
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0012, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x000BFFFFFFF
    Range Size: 3 GB
    Physical Array Handle: 0x000F
    Partition Width: 0

Handle 0x0013, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 1 GB
    Physical Device Handle: 0x0010
    Memory Array Mapped Address Handle: 0x0012
    Partition Row Position: 1
    Interleave Position: 1

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00040000000
    Ending Address: 0x000BFFFFFFF
    Range Size: 2 GB
    Physical Device Handle: 0x0011
    Memory Array Mapped Address Handle: 0x0012
    Partition Row Position: 1
    Interleave Position: 1

Handle 0x0015, DMI type 22, 26 bytes
Portable Battery
    Location: In the Back side
    Manufacturer: SMP-PAN24
    Manufacture Date: 2006/11/29
    Serial Number:  1588
    Name: MAL32b
    Chemistry: Lithium Ion
    Design Capacity: 4800 mWh
    Design Voltage: 10800 mV
    SBDS Version: BAT 2.1
    Maximum Error: 100%
    OEM-specific Information: 0x00000000

Handle 0x0016, DMI type 32, 20 bytes
System Boot Information
    Status: <OUT OF SPEC>

Handle 0x0017, DMI type 200, 7 bytes
OEM-specific Type
    Header and Data:
        C8 07 17 00 01 02 03
    Strings:

Handle 0x0018, DMI type 127, 4 bytes
End Of Table
