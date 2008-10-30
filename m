From: "=?ISO-8859-2?Q?Piotr_=A3obacz?=" <kocur666@gmail.com>
Subject: dmi info for Lenovo 3000 n200 [TY2K2PB]
Date: Thu, 30 Oct 2008 15:38:52 +0100
Message-ID: <14a58f0b0810300738k66d1e1b3l8a7140ca1e204d62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:20673 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbYJ3OjE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2008 10:39:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so131938gvc.37
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2008 07:38:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey,

hope it helps, dmidecode attached,
more on request ;-)

dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
25 structures occupying 1056 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: 68ET32WW
        Release Date: 01/03/2008
        Address: 0xE5750
        Runtime Size: 108720 bytes
        ROM Size: 1024 kB
        Characteristics:
                PCI is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                5.25"/360 KB floppy services are supported (int 13h)
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
                LS-120 boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 0.50
        Firmware Revision: 0.50

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: LENOVO
        Product Name: 0769K2G
        Version: 3000 N200
        Serial Number: L3EX444
        UUID: 7026D9D9-B93D-11DC-A9A4-001B380E2A26
        Wake-up Type: Power Switch
        SKU Number: Lenovo
        Family: Lenovo

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: LENOVO
        Product Name: IEL10
        Version: REFERENCE
        Serial Number: 43N7648Z1ZEBM815453

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: No Enclosure
        Type: Notebook
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
        Family: Unknown
        Manufacturer: Intel
        ID: 76 06 01 00 FF FB EB BF
        Version: CPU Version
        Voltage: 3.3 V
        External Clock: Unknown
        Max Speed: 4096 MHz
        Current Speed: 2100 MHz
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
        Installed Size: 0 KB
        Maximum Size: 4096 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Unknown
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J1A1
        Internal Connector Type: None
        External Reference Designator: Keyboard
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J1A1
        Internal Connector Type: None
        External Reference Designator: PS/2 Mouse
        External Connector Type: Circular DIN-8 male
        Port Type: Mouse Port

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot J8B1
        Type: 32-bit PCI
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000A, DMI type 10, 6 bytes
On Board Device Information
        Type: Sound
        Status: Disabled
        Description: HD-Audio

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
        String 1: 84IRT0PmAhjFE
        String 2: ECHeAx4sIurr+
        String 3: -aZHx7IJuEy4j

Handle 0x000C, DMI type 12, 5 bytes
System Configuration Options
        Option 1: SMI:00B2C1
        Option 2: DSN:     W -DXW1C80719591
        Option 3: DSN: 64T128021EDL3SB2  020E3011
        Option 4: DSN: SANYOLNV-42T521605B9383C
        Option 5: TIM:

Handle 0x000D, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 1000 MB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000D
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 1024 MB
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

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000D
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
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

Handle 0x0010, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000D
        Partition Width: 0

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000E
        Memory Array Mapped Address Handle: 0x0010
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0012, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x0003FFFFC00
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 kB
        Physical Device Handle: 0x000F
        Memory Array Mapped Address Handle: 0x0010
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0013, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0014, DMI type 131, 22 bytes
OEM-specific Type
        Header and Data:
                83 16 14 00 01 00 00 00 00 00 00 00 00 00 00 00
                00 00 00 00 00 01
        Strings:
                TVT-Enablement

Handle 0x0015, DMI type 131, 22 bytes
OEM-specific Type
        Header and Data:
                83 16 15 00 01 00 00 00 00 00 00 00 00 00 00 00
                00 00 00 00 00 01
        Strings:
                TVT-Enablement

Handle 0x0016, DMI type 133, 5 bytes
OEM-specific Type
        Header and Data:
                85 05 16 00 01
        Strings:
                KHOIHGIUCCHHII

Handle 0x0017, DMI type 135, 10 bytes
OEM-specific Type
        Header and Data:
                87 0A 17 00 50 54 07 03 01 05

Handle 0x0018, DMI type 127, 4 bytes
End Of Table

dmesg | grep ACPI
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
ACPI: Added _OSI(Linux)
ACPI: Core revision 20080609
ACPI: bus type pci registered
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query honored via cmdline
ACPI: DMI System Vendor: LENOVO
ACPI: DMI Product Name: 0769K2G
ACPI: DMI Product Version: 3000 N200
ACPI: DMI Board Name: IEL10
ACPI: DMI BIOS Vendor: LENOVO
ACPI: DMI BIOS Date: 01/03/2008
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE storm detected, disabling EC GPE
ACPI: EC: GPE = 0x1c, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: SSDT 3FED955C, 027A (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 3FED8EED, 05EA (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI0007:00: registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 3FED97D6, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 3FED94D7, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI0007:01: registered as cooling_device1
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
region SMBI [0x1c00-0x1c0f]
ACPI: Device needs an ACPI driver
nvidia 0000:01:00.0: power state changed by ACPI to D0
