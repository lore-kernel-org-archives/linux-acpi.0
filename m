From: Oscar Hernandez <oscar.hernandez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: bad acpi-bios???
Date: Tue, 4 Jan 2005 20:50:15 +0100
Message-ID: <59b10f2605010411506b1eec21@mail.gmail.com>
Reply-To: Oscar Hernandez <oscar.hernandez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

My name is Oscar Hernadez and I'm from Barcelona. Since two months I'm
triying to rebuild a linux kernel on a asus L5 notebook with HT.
So I've just read that I can paste my dmidecode for to explain my
interest on develope a wide support on a linux labtops, so the next
paste is mine:


asuslabtop:/proc# dmidecode
# dmidecode 2.5
SMBIOS 2.3 present.
47 structures occupying 1612 bytes.
Table at 0x000F9B60.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: American Megatrends Inc.
                Version: 0208
                Release Date: 05/10/2004
                Address: 0xF0000
                Runtime Size: 64 kB
                ROM Size: 512 kB
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
                        Selectable boot is supported
                        BIOS ROM is socketed
                        EDD is supported
                        5.25"/1.2 MB floppy services are supported (int 13h)
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
                        BIOS boot specification is supported
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: ASUSTeK Computer Inc.
                Product Name: L5Ga
                Version: 3.0
                Serial Number: SSN12345678901234567
                UUID: 00020003-0004-0005-0006-000700080009
                Wake-up Type: Power Switch
Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: ASUSTeK Computer Inc.
                Product Name: L5Ga
                Version: 2.2
                Serial Number: BSN12345678901234567
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information
                Manufacturer: ASUSTeK Computer Inc.
                Type: Desktop
                Lock: Not Present
                Version: 2.0
                Serial Number: A0N1V2E3N4C5H6U
                Asset Tag: L9I8N7D6A5
                Boot-up State: Safe
                Power Supply State: Safe
                Thermal State: Safe
                Security Status: None
                OEM Information: 0x00000000
Handle 0x0004
        DMI type 4, 35 bytes.
        Processor Information
                Socket Designation: CPU 1
                Type: Central Processor
                Family: Pentium 4
                Manufacturer: Intel
                ID: 29 0F 00 00 FF FB EB BF
                Signature: Type 0, Family 15, Model 2, Stepping 9
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
                        SBF (Signal break on FERR)
                Version: Intel(R) Pentium(R) 4 CPU 3.20GHz
                Voltage: 3.3 V 2.9 V
                External Clock: 800 MHz
                Max Speed: 3200 MHz
                Current Speed: 3200 MHz
                Status: Populated, Enabled
                Upgrade: Socket 478
                L1 Cache Handle: 0x0005
                L2 Cache Handle: 0x0006
                L3 Cache Handle: Not Provided
                Serial Number: To Be Filled By O.E.M.
                Asset Tag: To Be Filled By O.E.M.
                Part Number: To Be Filled By O.E.M.
Handle 0x0005
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L1-Cache
                Configuration: Enabled, Not Socketed, Level 1
                Operational Mode: Varies With Memory Address
                Location: Internal
                Installed Size: 8 KB
                Maximum Size: 8 KB
                Supported SRAM Types:
                        Pipeline Burst
                Installed SRAM Type: Pipeline Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Data
                Associativity: 4-way Set-associative
Handle 0x0006
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L2-Cache
                Configuration: Enabled, Not Socketed, Level 2
                Operational Mode: Varies With Memory Address
                Location: Internal
                Installed Size: 512 KB
                Maximum Size: 512 KB
                Supported SRAM Types:
                        Pipeline Burst
                Installed SRAM Type: Pipeline Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Unified
                Associativity: 4-way Set-associative
Handle 0x0007
        DMI type 5, 20 bytes.
        Memory Controller Information
                Error Detecting Method: None
                Error Correcting Capabilities:
                        None
                Supported Interleave: One-way Interleave
                Current Interleave: One-way Interleave
                Maximum Memory Module Size: 1024 MB
                Maximum Total Memory Size: 2048 MB
                Supported Speeds:
                        70 ns
                        60 ns
                        50 ns
                Supported Memory Types:
                        DIMM
                        SDRAM
                Memory Module Voltage: 3.3 V
                Associated Memory Slots: 2
                        0x0008
                        0x0009
                Enabled Error Correcting Capabilities:
                        None
Handle 0x0008
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: DIMM0
                Bank Connections: 1 0
                Current Speed: Unknown
                Type: DIMM SDRAM
                Installed Size: 512 MB (Double-bank Connection)
                Enabled Size: 512 MB (Double-bank Connection)
                Error Status: OK
Handle 0x0009
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: DIMM1
                Bank Connections: 3 2
                Current Speed: Unknown
                Type: Unknown
                Installed Size: Not Installed (Single-bank Connection)
                Enabled Size: Not Installed (Single-bank Connection)
                Error Status: OK
Handle 0x000A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J1A1
                Internal Connector Type: None
                External Reference Designator: PS2Mouse
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x000B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J1A1
                Internal Connector Type: None
                External Reference Designator: Keyboard
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x000C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J2A2
                Internal Connector Type: None
                External Reference Designator: USB1
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J2A2
                Internal Connector Type: None
                External Reference Designator: USB2
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J4A1
                Internal Connector Type: None
                External Reference Designator: LPT 1
                External Connector Type: DB-25 male
                Port Type: Parallel Port ECP/EPP
Handle 0x000F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J2A1
                Internal Connector Type: None
                External Reference Designator: COM A
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x0010
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6A1
                Internal Connector Type: None
                External Reference Designator: Audio Mic In
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0011
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6A1
                Internal Connector Type: None
                External Reference Designator: Audio Line In
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0012
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6B1 - AUX IN
                Internal Connector Type: On Board Sound Input From CD-ROM
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Audio Port
Handle 0x0013
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6B2 - CDIN
                Internal Connector Type: On Board Sound Input From CD-ROM
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Audio Port
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6J2 - PRI IDE
                Internal Connector Type: On Board IDE
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6J1 - SEC IDE
                Internal Connector Type: On Board IDE
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0016
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J4J1 - FLOPPY
                Internal Connector Type: On Board Floppy
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0017
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J9H1 - FRONT PNL
                Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0018
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J1B1 - CHASSIS REAR FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0019
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J2F1 - CPU FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J8B4 - FRONT FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J9G2 - FNT USB
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J6C3 - FP AUD
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J9G1 - CONFIG
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J8C1 - SCSI LED
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x001F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J9J2 - INTRUDER
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0020
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J9G4 - ITP
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0021
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: J2H1 - MAIN POWER
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0022
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: AGP
                Type: 32-bit AGP 4x
                Current Usage: In Use
                Length: Short
                ID: 0
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0023
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI1
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 1
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0024
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI2
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 2
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0025
        DMI type 10, 6 bytes.
        On Board Device Information
                Type: Video
                Status: Enabled
                Description:   To Be Filled By O.E.M.
Handle 0x0026
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 1
                        en|US|iso8859-1
                Currently Installed Language: en|US|iso8859-1
Handle 0x0027
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System Board Or Motherboard
                Use: System Memory
                Error Correction Type: None
                Maximum Capacity: 4 GB
                Error Information Handle: Not Provided
                Number Of Devices: 2
Handle 0x0028
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x100000003FF
                Range Size: 1073741825 kB
                Physical Array Handle: 0x0027
                Partition Width: 0
Handle 0x0029
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0027
                Error Information Handle: Not Provided
                Total Width: 64 bits
                Data Width: 64 bits
                Size: 512 MB
                Form Factor: SODIMM
                Set: None
                Locator: DIMM0
                Bank Locator: BANK0
                Type: DDR
                Type Detail: Synchronous
                Speed: Unknown
                Manufacturer: Manufacturer0
                Serial Number: SerNum0
                Asset Tag: AssetTagNum0
                Part Number: PartNum0
Handle 0x002A
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0001FFFFFFF
                Range Size: 512 MB
                Physical Device Handle: 0x0029
                Memory Array Mapped Address Handle: 0x0028
                Partition Row Position: 1
Handle 0x002B
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0027
                Error Information Handle: Not Provided
                Total Width: Unknown
                Data Width: Unknown
                Size: No Module Installed
                Form Factor: DIMM
                Set: None
                Locator: DIMM1
                Bank Locator: BANK1
                Type: Unknown
                Type Detail: Unknown
                Speed: Unknown
                Manufacturer: Manufacturer1
                Serial Number: SerNum1
                Asset Tag: AssetTagNum1
                Part Number: PartNum1
Handle 0x002C
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x000000003FF
                Range Size: 1 kB
                Physical Device Handle: 0x002B
                Memory Array Mapped Address Handle: 0x0028
                Partition Row Position: 1
Handle 0x002D
        DMI type 32, 20 bytes.
        System Boot Information
                Status: No errors detected
Handle 0x002E
        DMI type 127, 4 bytes.
        End Of Table


I hope help you.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
