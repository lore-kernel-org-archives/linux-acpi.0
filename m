From: "=?BIG5?B?s6+k/a5p?=" <cwz0522@gmail.com>
Subject: acpi_osi=!Linux work better than acpi_osi=Linux
Date: Sat, 27 Oct 2007 09:13:19 +0800
Message-ID: <e859aabc0710261813t468447e7ue074bd5c7974cfee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:58183 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbXJ0BNU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 21:13:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so941322rvb
        for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 18:13:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear all,
after trying all the combinations from en.opensuse.org/S2ram, the
s2ram still hang or immediately shutdown the system.
But, I try to pass the acpi_osi=!Linux to the kernel, it work well!

the following settings is ok for me.
s2ram --force  --vbe_post

If you still need any further information, please contact to me.

PS. I don't known how to set the gnome-power-manager to use the
settings above, is there anyone can give me some advices?  I only can
use root to use the s2ram command to STR. Thanks
PS. s2disk is ok whether or not I pass the acpi_osi=Linux to the kernel.

Best Regards,
Peter Chen

# dmidecode 2.9
SMBIOS 2.4 present.
28 structures occupying 1179 bytes.
Table at 0x7FEDF000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: V1.06
        Release Date: 07/11/2007
        Address: 0xE5F80
        Runtime Size: 106624 bytes
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
        Manufacturer: Acer
        Product Name: Aspire 4920
        Version: 0100
        Serial Number: LXAHP0X2197320E23A2000
        UUID: CA6FCD60-47AE-11DC-93AB-D523380A14EA
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Acer
        Product Name: Tahoe
        Version: Rev
        Serial Number: LXAHP0X2197320E23A2000

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: Acer
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag: None
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
        External Clock: 166 MHz
        Max Speed: 1500 MHz
        Current Speed: 1500 MHz
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

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot J8B3
        Type: 32-bit PCI
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot S9B1
        Type: 32-bit PCI
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
        Designation: PEG Slot J6B2
        Type: 32-bit PCI Express
        Current Usage: In Use
        Length: Long
        ID: 6
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot J6B1
        Type: 32-bit PCI Express
        Current Usage: In Use
        Length: Long
        ID: 7
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot J6D1
        Type: 32-bit PCI Express
        Current Usage: In Use
        Length: Long
        ID: 8
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot J8B4
        Type: 32-bit PCI Express
        Current Usage: Available
        Length: Long
        ID: 9
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot J8D1
        Type: 32-bit PCI Express
        Current Usage: Available
        Length: Long
        ID: 9
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Express Slot J7B1
        Type: 32-bit PCI Express
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000F, DMI type 11, 5 bytes
OEM Strings
        String 1: This is the Intel Crestline
        String 2: Chipset CRB Platform

Handle 0x0010, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 4 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0010
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

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0010
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

Handle 0x0013, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
        Physical Array Handle: 0x0010
        Partition Width: 0

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x0011
        Memory Array Mapped Address Handle: 0x0013
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00040000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x0012
        Memory Array Mapped Address Handle: 0x0013
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0016, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0017, DMI type 129, 10 bytes
OEM-specific Type
        Header and Data:
                81 0A 17 00 01 01 02 01 01 02
        Strings:
                Intel_ASF
                Intel_ASF_001

Handle 0x0018, DMI type 136, 6 bytes
OEM-specific Type
        Header and Data:
                88 06 18 00 FF FF

Handle 0x0019, DMI type 150, 14 bytes
OEM-specific Type
        Header and Data:
                96 0E 19 00 01 01 00 00 00 00 00 00 00 00
        Strings:
                ABSOLUTE(PHOENIX) CLM

Handle 0x001A, DMI type 200, 7 bytes
OEM-specific Type
        Header and Data:
                C8 07 1A 00 01 02 03
        Strings:
                17C0

                0001

Handle 0x001B, DMI type 127, 4 bytes
End Of Table
