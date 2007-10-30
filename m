From: vlad <bobrovva@gmail.com>
Subject: acpi list from Acer Aspire 5684
Date: Tue, 30 Oct 2007 21:59:24 +0300
Message-ID: <1193770764.6560.1.camel@vlad-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:4852 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbXJ3S7a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 14:59:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1716879nfb
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 11:59:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

# dmidecode 2.9
SMBIOS 2.31 present.
26 structures occupying 803 bytes.
Table at 0x000E3810.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
        Vendor: Acer
        Version: V2.80
        Release Date: 09/01/2006
        Address: 0xE7250
        Runtime Size: 101808 bytes
        ROM Size: 1024 kB
        Characteristics:
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
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                Smart battery is supported
                BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
        Manufacturer: Acer            
        Product Name: Aspire 5680     
        Version: V2.80
        Serial Number: LXAV60J0046360C1561601
        UUID: C2A7C6F0-F65F-6E45-D372-0016D41BAD86
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Acer
        Product Name: Grapevine
        Version: N/A
        Serial Number: LXAV60J0046360C1561601

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
        Manufacturer: Acer
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag: ....................            
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000
        Height: 52 U
        Number Of Power Cords: 18
        Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: U1
        Type: Central Processor
        Family: Unknown
        Manufacturer: Intel
        ID: F6 06 00 00 FF FB EB BF
        Version:   
        Voltage: 3.3 V
        External Clock: 166 MHz
        Max Speed: 1830 MHz
        Current Speed: 1830 MHz
        Status: Populated, Enabled
        Upgrade: ZIF Socket
        L1 Cache Handle: Not Provided
        L2 Cache Handle: 0x0005
        L3 Cache Handle: Not Provided
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 2048 KB
        Maximum Size: 2048 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot J1100
        Type: 32-bit PCI
        Current Usage: In Use
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot J1101
        Type: 32-bit PCI
        Current Usage: In Use
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
        Type: Sound
        Status: Disabled
        Description: HD-Audio

Handle 0x0009, DMI type 14, 11 bytes
Group Associations
        Name: Cpu Module
        Items: 2
                0x0015 (Processor)
                0x0016 (Cache)

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 2 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: 1
        Locator: M1
        Bank Locator: Bank 0
        Type: DDR2
        Type Detail: Synchronous
        Speed: Unknown
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: 2
        Locator: M2
        Bank Locator: Bank 1
        Type: DDR2
        Type Detail: Synchronous
        Speed: Unknown
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000A
        Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000B
        Memory Array Mapped Address Handle: 0x000D
        Partition Row Position: 2
        Interleave Position: 1
        Interleaved Data Depth: 6

Handle 0x000F, DMI type 22, 26 bytes
Portable Battery
        Location: Left Front
        Manufacturer: Not Specified
        Name: <BAD INDEX>
        Design Capacity: Unknown
        Design Voltage: Unknown
        SBDS Version: Not Specified
        Maximum Error: Unknown
        SBDS Serial Number: 0000
        SBDS Manufacture Date: 1980-00-00
        SBDS Chemistry: Not Specified
        OEM-specific Information: 0x00000000

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
        Administrator Password Status: Disabled
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

Handle 0x0019, DMI type 127, 4 bytes
End Of Table



Regards,
Vlad

