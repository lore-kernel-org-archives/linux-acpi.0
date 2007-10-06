From: Samae <lord.myyl@gmail.com>
Subject: dmidecode
Date: Sat, 6 Oct 2007 18:05:06 +0200
Message-ID: <413515090710060905u2efdafa9m55e3dbce4586e50a@mail.gmail.com>
References: <413515090710060238x4af5f54fsd558841153480b42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:16365 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760240AbXJFQFJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2007 12:05:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so936916nfb
        for <linux-acpi@vger.kernel.org>; Sat, 06 Oct 2007 09:05:07 -0700 (PDT)
In-Reply-To: <413515090710060238x4af5f54fsd558841153480b42@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here is what dmidecode returns for a macbook core 2 duo.
Maybe it's usefull ...

# dmidecode 2.9
SMBIOS 2.4 present.
37 structures occupying 1429 bytes.
Table at 0x000E0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
    Vendor: Apple Inc.
    Version:     MB21.88Z.00A5.B07.0706270922
    Release Date: 06/27/07
    ROM Size: 2048 kB
    Characteristics:
        PCI is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        ACPI is supported
        IEEE 1394 boot is supported
        Smart battery is supported
         Function key-initiated network boot is supported
    BIOS Revision: 0.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: Apple Inc.
    Product Name: MacBook2,1
    Version:  1.0
    Serial Number: W87311YWZ5X
    UUID: 61F9E18A-38B2-B440-A87E-7457DF18863C
    Wake-up Type: Power Switch
    SKU Number: System SKUNumber
    Family: MacBook

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
    Manufacturer: Apple Inc.
    Product Name: Mac-F4208CAA
    Version: PVT
    Serial Number: 1
    Asset Tag: Base Board Asset Tag
    Features:
        Board is a hosting board
        Board is replaceable
    Location In Chassis: Part Component
    Chassis Handle: 0x0003
    Type: Unknown
    Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
    Manufacturer: Apple Inc.
    Type: Notebook
    Lock: Not Present
    Version: Mac-F4208CAA
    Serial Number: W87311YWZ5X
    Asset Tag: Asset Tag
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Other
    Security Status: Other
    OEM Information: 0x00000000
    Height: Unspecified
    Number Of Power Cords: Unspecified
    Contained Elements: 0

Handle 0x0004, DMI type 32, 20 bytes
System Boot Information
    Status: No errors detected

Handle 0x0005, DMI type 13, 22 bytes
BIOS Language Information
    Installable Languages: 1
        <BAD INDEX>
    Currently Installed Language: Not Specified

Handle 0x0106, DMI type 12, 5 bytes
System Configuration Options

Handle 0x0107, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: DVI
    External Connector Type: Other
    Port Type: Video Port

Handle 0x0108, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: USBA
    External Connector Type: Access Bus (USB)
    Port Type: USB

Handle 0x0109, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: USBC
    External Connector Type: Access Bus (USB)
    Port Type: USB

Handle 0x010A, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: 1394A
    External Connector Type: IEEE 1394
    Port Type: Firewire (IEEE P1394)

Handle 0x010B, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: Audio Out
    External Connector Type: Mini Jack (headphones)
    Port Type: Audio Port

Handle 0x010C, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: Microphone
    External Connector Type: Mini Jack (headphones)
    Port Type: Audio Port

Handle 0x010D, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: None
    Internal Connector Type: None
    External Reference Designator: RJ-45
    External Connector Type: RJ-45
    Port Type: Network Port

Handle 0x010E, DMI type 9, 13 bytes
System Slot Information
    Designation: AirPort
    Type: x1 PCI Express
    Current Usage: Available
    Length: Short
    ID: 2
    Characteristics:
        3.3 V is provided
        Hot-plug devices are supported
        SMBus signal is supported

Handle 0x010F, DMI type 10, 6 bytes
On Board Device Information
    Type: Video
    Status: Enabled
    Description: Integrated Graphics Controller

Handle 0x0110, DMI type 10, 6 bytes
On Board Device Information
    Type: Sound
     Status: Enabled
    Description: Azalia Audio Codec

Handle 0x0111, DMI type 10, 6 bytes
On Board Device Information
    Type: Ethernet
    Status: Enabled
    Description: Yukon Ethernet Controller

Handle 0x0112, DMI type 10, 6 bytes
On Board Device Information
    Type: Other
    Status: Enabled
    Description: SATA

Handle 0x0113, DMI type 10, 6 bytes
On Board Device Information
    Type: Other
    Status: Enabled
    Description: PATA

Handle 0x0114, DMI type 10, 6 bytes
On Board Device Information
    Type: Other
    Status: Enabled
    Description: Sudden Motion Sensor

Handle 0x0115, DMI type 136, 6 bytes
OEM-specific Type
    Header and Data:
        88 06 15 01 00 00

Handle 0x0116, DMI type 4, 35 bytes
Processor Information
    Socket Designation: U2E1
    Type: Central Processor
    Family: Unknown
    Manufacturer: Intel(R) Corporation
    ID: F6 06 00 00 FF FB EB BF
    Version: Intel(R) Core(TM)2 CPU
    Voltage: 1.6 V
    External Clock: 166 MHz
    Max Speed: 2160 MHz
    Current Speed: 2160 MHz
    Status: Populated, Enabled
    Upgrade: ZIF Socket
    L1 Cache Handle: 0x0119
    L2 Cache Handle: 0x0117
    L3 Cache Handle: Not Provided
    Serial Number: Not Specified
    Asset Tag: Unknown
    Part Number: Not Specified

Handle 0x0117, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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
    System Type: Unified
    Associativity: 16-way Set-associative

Handle 0x0118, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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

Handle 0x0119, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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

Handle 0x011A, DMI type 4, 35 bytes
Processor Information
    Socket Designation: U2E1
    Type: Central Processor
    Family: Unknown
    Manufacturer: Intel(R) Corporation
    ID: F6 06 00 00 FF FB EB BF
    Version: Intel(R) Core(TM)2 CPU
    Voltage: 1.6  V
    External Clock: 166 MHz
    Max Speed: 2160 MHz
    Current Speed: 2160 MHz
    Status: Populated, Enabled
    Upgrade: ZIF Socket
    L1 Cache Handle: 0x011D
    L2 Cache Handle: 0x011B
    L3 Cache Handle: Not Provided
    Serial Number: Not Specified
    Asset Tag: Unknown
    Part Number: Not Specified

Handle 0x011B, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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
    System Type: Unified
    Associativity: 16-way Set-associative

Handle 0x011C, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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

Handle 0x011D, DMI type 7, 19 bytes
Cache Information
    Socket Designation: Unknown
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

Handle 0x011E, DMI type 16, 15 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 4 GB
    Error Information Handle: Not Provided
    Number Of Devices: 2

Handle 0x011F, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x011E
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: None
    Locator: DIMM0
    Bank Locator: BANK 0
    Type: DDR2
    Type Detail: Synchronous
    Speed: 667 MHz (1.5 ns)
    Manufacturer: 0xAD00000000000000
    Serial Number: 0x00003162
    Asset Tag: Unknown
    Part Number: 0x48594D503536345336344350362D59352020

Handle 0x0120, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Device Handle: 0x011F
    Memory Array Mapped Address Handle: 0x0123
    Partition Row Position: 1
    Interleave Position: 1
    Interleaved Data Depth: 1

Handle 0x0121, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x011E
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: None
    Locator: DIMM1
    Bank Locator: BANK 1
    Type: DDR2
    Type Detail: Synchronous
    Speed: 667 MHz (1.5 ns)
    Manufacturer: 0xAD00000000000000
    Serial Number: 0x00002235
    Asset Tag: Unknown
    Part Number: 0x48594D503536345336344350362D59352020

Handle 0x0122, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00020000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 512 MB
    Physical Device Handle: 0x0121
    Memory Array Mapped Address Handle: 0x0123
    Partition Row Position: 2
    Interleave Position: 2
    Interleaved Data Depth: 1

Handle 0x0123, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 1 GB
    Physical Array Handle: 0x011E
    Partition Width: 0

Handle 0xFFFD, DMI type 127, 4 bytes
End Of Table

--
Linux eeva 2.6.22-ARCH #1 SMP PREEMPT Wed Sep 26 20:57:40 CEST 2007
i686 Intel(R) Core(TM)2 CPU         T7400  @  2.16GHz GenuineIntel
GNU/Linux
