From: "=?UTF-8?B?0KHRgtCw0L3QuNGB0LvQsNCy?=" <ginermail@gmail.com>
Subject: laptop Benq s41 acpi sleep (now plain text)
Date: Thu, 13 Dec 2007 23:57:03 +0300
Message-ID: <47458ca10712131257o275fec22o54156eb51b97634e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:44573 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbXLMU5I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Dec 2007 15:57:08 -0500
Received: by py-out-1112.google.com with SMTP id u77so439242pyb.16
        for <linux-acpi@vger.kernel.org>; Thu, 13 Dec 2007 12:57:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Sleep mode (on close laptop) work with both acpi_apic_instance=2 and
acpi_osi=!Linux

1.
ACPI: BIOS bug: multiple APIC/MADT found, using 2
[    0.000000] ACPI: If "acpi_apic_instance=0" works better, notify
linux-acpi@vger.kernel.org


2.
[   23.806190] ACPI: Please test with "acpi_osi=!Linux"
[   23.806191] Please send dmidecode to linux-acpi@vger.kernel.org

dmidecode:

# dmidecode 2.9
SMBIOS 2.4 present.
42 structures occupying 1444 bytes.
Table at 0x3FEDF000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
     Vendor: Phoenix Technologies LTD
    Version: 01.09
    Release Date: 08/31/2007
    Address: 0xE7F40
    Runtime Size: 98496 bytes
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
        ACPI is supported
        USB legacy is supported
        AGP is supported
        BIOS boot specification is supported
        Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: BenQ
    Product Name: Joybook S41
    Version: 2.4
    Serial Number: 9H07701R3273807770DHS400
    UUID: 55F26796-0F00-0010-835C-E801E400F065
    Wake-up Type: Power Switch
    SKU Number: Not Specified
    Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
    Manufacturer: BenQ
    Product Name: Joybook S41
    Version: 2.4
    Serial Number: 9H07701R3273807770DHS400

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
    Manufacturer: f
    Type: Other
    Lock: Not Present
    Version: N/A
    Serial Number: None
    Asset Tag: No Asset Tag
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None
    OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
    Socket Designation: U2E1
    Type: Central Processor
    Family: Other
    Manufacturer: Intel
    ID: FD 06 00 00 FF FB EB BF
    Version: CPU Version
    Voltage: 3.3 V
    External Clock: Unknown
    Max Speed: 4096 MHz
    Current Speed: 2000 MHz
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
    Installed Size: 2048 KB
    Maximum Size: 4096 KB
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
     Internal Reference Designator: J19
    Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
    External Reference Designator: COM 1
    External Connector Type: DB-9 male
    Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: J1A1
    Internal Connector Type: None
    External Reference Designator: Keyboard
    External Connector Type: Circular DIN-8 male
    Port Type: Keyboard Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: J1A1
    Internal Connector Type: None
    External Reference Designator: PS/2 Mouse
    External Connector Type: Circular DIN-8 male
    Port Type: Mouse Port

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Slot J8B3
    Type: 32-bit PCI
    Current Usage: Available
    Length: Long
    ID: 3
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Slot S9B1
     Type: 32-bit PCI
    Current Usage: Unknown
    Length: Long
    ID: 0
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
    Designation: PEG Slot J6B2
    Type: 32-bit PCI Express
    Current Usage: In Use
    Length: Long
    ID: 6
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Express Slot J6B1
    Type: 32-bit PCI Express
    Current Usage: In Use
    Length: Long
    ID: 7
    Characteristics:
        5.0 V is provided
         3.3 V is provided

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Express Slot J6D1
    Type: 32-bit PCI Express
    Current Usage: Available
    Length: Long
    ID: 8
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x000F, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Express Slot J8B4
    Type: 32-bit PCI Express
    Current Usage: Available
    Length: Long
    ID: 8
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x0010, DMI type 9, 13 bytes
System Slot Information
     Designation: PCI Express Slot J8D1
    Type: 32-bit PCI Express
    Current Usage: Available
    Length: Long
    ID: 10
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x0011, DMI type 9, 13 bytes
System Slot Information
    Designation: PCI Express Slot J7B1
    Type: 32-bit PCI Express
    Current Usage: Available
    Length: Long
    ID: 10
    Characteristics:
        5.0 V is provided
        3.3 V is provided

Handle 0x0012, DMI type 10, 6 bytes
On Board Device Information
    Type: Sound
    Status: Disabled
    Description: HD-Audio

Handle 0x0013, DMI type 11, 5 bytes
OEM Strings
    String 1: This is the Intel Crestline
    String 2: Chipset CRB Platform

Handle 0x0014, DMI type 12, 5 bytes
System Configuration Options
    Option 1: Jumper settings can be described here.

Handle 0x0015, DMI type 15, 29 bytes
System Event Log
    Area Length: 16 bytes
    Header Start Offset: 0x0000
    Header Length: 16 bytes
    Data Start Offset: 0x0010
    Access Method: General-purpose non-volatile data functions
    Access Address: 0x0000
    Status: Valid, Not Full
    Change Token: 0x000000FB
    Header Format: Type 1
    Supported Log Type Descriptors: 3
    Descriptor 1: POST error
    Data Format 1: POST results bitmap
    Descriptor 2: Single-bit ECC memory error
    Data Format 2: Multiple-event
    Descriptor 3: Multi-bit ECC memory error
    Data Format 3: Multiple-event

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 1000 MB
    Error Information Handle: Not Provided
    Number Of Devices: 2

 Handle 0x0017, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0016
    Error Information Handle: No Error
    Total Width: Unknown
    Data Width: Unknown
    Size: No Module Installed
    Form Factor: SODIMM
    Set: 1
    Locator: M1
    Bank Locator: Bank 0
    Type: DDR2
    Type Detail: Synchronous
    Speed: 667 MHz (1.5 ns)
    Manufacturer: Mfg 0
    Serial Number: 1234-B0
    Asset Tag: Not Specified
    Part Number: SODIMM000

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0016
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
     Size: 1024 MB
    Form Factor: SODIMM
    Set: 1
    Locator: M2
    Bank Locator: Bank 1
    Type: DDR2
    Type Detail: Synchronous
    Speed: 667 MHz (1.5 ns)
    Manufacturer: Mfg 1
    Serial Number: 1234-B1
    Asset Tag: Not Specified
    Part Number: SODIMM001

Handle 0x0019, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 1 GB
    Physical Array Handle: 0x0016
    Partition Width: 0

Handle 0x001A, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x000000003FF
    Range Size: 1 kB
    Physical Device Handle: 0x0017
    Memory Array Mapped Address Handle: 0x0019
    Partition Row Position: Unknown
    Interleave Position: Unknown
    Interleaved Data Depth: Unknown

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 1 GB
    Physical Device Handle: 0x0018
    Memory Array Mapped Address Handle: 0x0019
     Partition Row Position: Unknown
    Interleave Position: Unknown
    Interleaved Data Depth: Unknown

Handle 0x001C, DMI type 22, 26 bytes
Portable Battery
    Location: Rear
    Manufacturer: Intel Corporation
    Name: Intel Corporation
    Chemistry: Lithium Ion
    Design Capacity: 1000 mWh
    Design Voltage: 19 mV
    SBDS Version: BATT_1234
    Maximum Error: 100%
    SBDS Serial Number: 0001
    SBDS Manufacture Date: 1980-00-01
    OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 23, 13 bytes
System Reset
    Status: Enabled
    Watchdog Timer: Present
    Boot Option: Do Not Reboot
    Boot Option On Limit: Do Not Reboot
    Reset Count: Unknown
    Reset Limit: Unknown
    Timer Interval: Unknown
    Timeout: Unknown

Handle 0x001E, DMI type 24, 5 bytes
Hardware Security
    Power-On Password Status: Disabled
     Keyboard Password Status: Unknown
    Administrator Password Status: Disabled
    Front Panel Reset Status: Unknown

Handle 0x001F, DMI type 25, 9 bytes
    System Power Controls
    Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0020, DMI type 26, 20 bytes
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

Handle 0x0021, DMI type 27, 12 bytes
Cooling Device
    Temperature Probe Handle: 0x0022
    Type: Fan
    Status: OK
    OEM-specific Information: 0x00000000

Handle 0x0022, DMI type 28, 20 bytes
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

Handle 0x0023, DMI type 29, 20 bytes
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

Handle 0x0024, DMI type 30, 6 bytes
Out-of-band Remote Access
    Manufacturer Name: Intel
    Inbound Connection: Enabled
    Outbound Connection: Disabled

Handle 0x0025, DMI type 32, 20 bytes
System Boot Information
    Status: <OUT OF SPEC>

Handle 0x0026, DMI type 129, 16 bytes
OEM-specific Type
    Header and Data:
        81 10 26 00 01 01 02 01 00 00 00 01 00 00 08 01
    Strings:
        Intel_ASF_001
        Intel_ASF_001

Handle 0x0027, DMI type 136, 6 bytes
OEM-specific Type
    Header and Data:
        88 06 27 00 FF FF

Handle 0x0028, DMI type 150, 14 bytes
OEM-specific Type
    Header and Data:
        96 0E 28 00 01 01 00 00 00 00 00 00 00 00
    Strings:
        ABSOLUTE(PHOENIX) CLM

Handle 0x0029, DMI type 127, 4 bytes
End Of Table

 3.
[   47.365395] Linux Plug and Play Support v0.97 (c) Adam Belay
[   47.365404] pnp: PnP ACPI init
[   47.365412] ACPI: bus type pnp registered
[   47.366846] pnp: PnP ACPI: found 10 devices
 [   47.366848] ACPI: ACPI bus type pnp unregistered
[   47.366852] PnPBIOS: Disabled by ACPI PNP
[   47.366891] PCI: Using ACPI for IRQ routing
[   47.366893] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   47.366897] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
[   47.367023] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
[   47.367138] PCI: Cannot allocate resource region 9 of bridge 0000:00: 1c.0
[   47.367253] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
[   47.367368] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
[   47.367483] PCI: Cannot allocate resource region 9 of bridge 0000:00: 1c.1
[   47.367598] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.3
[   47.367714] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.3
[   47.367829] PCI: Cannot allocate resource region 9 of bridge 0000:00: 1c.3
[   47.367944] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.5
[   47.368059] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.5
[   47.368174] PCI: Cannot allocate resource region 9 of bridge 0000:00: 1c.5
[   47.368327] PCI: Cannot allocate resource region 0 of device 0000:02:00.0
[   47.368464] PCI: Cannot allocate resource region 0 of device 0000:05:00.0
[   47.368579] PCI: Cannot allocate resource region 2 of device 0000:05: 00.0
[   47.445684] NET: Registered protocol family 8
[   47.445686] NET: Registered protocol family 20
[   47.445736] pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not
be reserved
[   47.445739] pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not
be reserved
[   47.445741] pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not
be reserved
[   47.445744] pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not
be reserved
[   47.445750] pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not
be reserved
[   47.448930] Time: tsc clocksource has been installed.

trying pci=routeirq

[   23.828398] Linux Plug and Play Support v0.97 (c) Adam Belay
[   23.828406] pnp: PnP ACPI init
[   23.828415] ACPI: bus type pnp registered
[   23.829852] pnp: PnP ACPI: found 10 devices
[   23.829854] ACPI: ACPI bus type pnp unregistered
[   23.829857] PnPBIOS: Disabled by ACPI PNP
[   23.829894] PCI: Using ACPI for IRQ routing
[   23.829896] PCI: Routing PCI interrupts for all devices because
"pci=routeirq" specified
[   23.829901] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   23.829904] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   23.829908] ACPI: PCI Interrupt 0000:00: 1a.1[B] -> GSI 21 (level,
low) -> IRQ 17
[   23.829911] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level,
low) -> IRQ 18
[   23.829915] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level,
low) -> IRQ 19
[   23.829918] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level,
low) -> IRQ 20
[   23.829921] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level,
low) -> IRQ 16
[   23.829925] ACPI: PCI Interrupt 0000:00: 1c.3[D] -> GSI 19 (level,
low) -> IRQ 21
[   23.829927] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level,
low) -> IRQ 16
[   23.829931] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level,
low) -> IRQ 22
[   23.829933] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level,
low) -> IRQ 21
[   23.829936] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level,
low) -> IRQ 18
[   23.829938] ACPI: PCI Interrupt 0000:00: 1d.7[A] -> GSI 23 (level,
low) -> IRQ 22
[   23.829941] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
low) -> IRQ 21
[   23.829944] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level,
low) -> IRQ 21
[   23.829947] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   23.829949] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   23.829952] ACPI: PCI Interrupt 0000:05: 00.0[A] -> GSI 17 (level,
low) -> IRQ 20
[   23.829956] ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 20 (level,
low) -> IRQ 23
[   23.829958] ACPI: PCI Interrupt 0000:06:09.1[B] -> GSI 17 (level,
low) -> IRQ 20
[   23.829961] ACPI: PCI Interrupt 0000:06:09.2[B] -> GSI 17 (level,
low) -> IRQ 20
[   23.829964] ACPI: PCI Interrupt 0000:06:09.3[B] -> GSI 17 (level,
low) -> IRQ 20
[   23.829968] PCI: Cannot allocate resource region 7 of bridge 0000:00: 1c.0
[   23.830089] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
[   23.830205] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
[   23.830319] PCI: Cannot allocate resource region 7 of bridge 0000:00: 1c.1
[   23.830434] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
[   23.830549] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
[   23.830663] PCI: Cannot allocate resource region 7 of bridge 0000:00: 1c.3
[   23.830778] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.3
[   23.830893] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.3
[   23.831008] PCI: Cannot allocate resource region 7 of bridge 0000:00: 1c.5
[   23.831123] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.5
[   23.831237] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.5
[   23.831390] PCI: Cannot allocate resource region 0 of device 0000:02: 00.0
[   23.831526] PCI: Cannot allocate resource region 0 of device 0000:05:00.0
[   23.831641] PCI: Cannot allocate resource region 2 of device 0000:05:00.0
[   23.908703] NET: Registered protocol family 8
[   23.908704] NET: Registered protocol family 20
[   23.908755] pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not
be reserved
[   23.908758] pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not
be reserved
 [   23.908760] pnp: 00:01: iomem range 0xfed18000-0xfed18fff could
not be reserved
[   23.908763] pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not
be reserved
[   23.908769] pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not
be reserved
