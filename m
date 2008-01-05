From: Reindl Harald <support@rhsoft.net>
Subject: ACPI-Messages on HP Pavilion dv8335ea Notebook
Date: Sat, 05 Jan 2008 04:30:25 +0100
Message-ID: <477EF9D1.2040106@rhsoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhea.thelounge.net ([195.34.141.22]:57659 "EHLO
	mail.thelounge.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365AbYAEEae (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2008 23:30:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello, a happy new year and greetings from austria

I found the following message in "dmesg"
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001

Both of the following boot-options makes no difference
acpi_osi=Linux acpi_apic_instance=0
acpi_osi=Linux acpi_apic_instance=2

I do not have really problems but i hope this can help you in anyway
Attached the output of "dmidecode" with the first line
The machine is running on "Linux 2.6.23.12-101.fc8 #1 SMP Fri Jan 4 16:49:51 EST 2008"
_________

ACPI: System BIOS is requesting _OSI(Linux)
ACPI: If "acpi_osi=Linux" works better,
Please send dmidecode to linux-acpi@vger.kernel.org

ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org

ACPI: BIOS bug: multiple APIC/MADT found, using 2
ACPI: If "acpi_apic_instance=0" works better, notify linux-acpi@vger.kernel.org
________


[harry@nb-rhsoft:~]$ sudo dmidecode
# dmidecode 2.7
SMBIOS 2.4 present.
17 structures occupying 641 bytes.
Table at 0x000E3810.

Handle 0x0000, DMI type 0, 24 bytes.
BIOS Information
~        Vendor: Hewlett-Packard
~        Version: F.24
~        Release Date: 09/07/2007
~        Address: 0xE7390
~        Runtime Size: 101488 bytes
~        ROM Size: 1024 kB
~        Characteristics:
~                PCI is supported
~                PC Card (PCMCIA) is supported
~                PNP is supported
~                BIOS is upgradeable
~                BIOS shadowing is allowed
~                ESCD support is available
~                Boot from CD is supported
~                Selectable boot is supported
~                Print screen service is supported (int 5h)
~                8042 keyboard services are supported (int 9h)
~                Printer services are supported (int 17h)
~                CGA/mono video services are supported (int 10h)
~                ACPI is supported
~                USB legacy is supported
~                AGP is supported
~                Smart battery is supported
~                BIOS boot specification is supported
~                Targeted content distribution is supported
~        BIOS Revision: 1.6
~        Firmware Revision: 1.1

Handle 0x0001, DMI type 1, 27 bytes.
System Information
~        Manufacturer: Hewlett-Packard
~        Product Name: HP Pavilion dv8000 (RE329EA#ABD)
~        Version: F.24
~        Serial Number: CND6331RLR
~        UUID: 93BF9DE1-23FF-11DB-B88E-0016D43C5257
~        Wake-up Type: Power Switch
~        SKU Number: RE329EA#ABD
~        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
~        Manufacturer: Hewlett-Packard
~        Product Name: 30A6
~        Version: 56.48
~        Serial Number: CND6331RLR

Handle 0x0003, DMI type 3, 17 bytes.
Chassis Information
~        Manufacturer: Hewlett-Packard
~        Type: Notebook
~        Lock: Not Present
~        Version: N/A
~        Serial Number: None
~        Asset Tag:
~        Boot-up State: Safe
~        Power Supply State: Safe
~        Thermal State: Safe
~        Security Status: None
~        OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
~        Socket Designation: U1
~        Type: Central Processor
~        Family: Other
~        Manufacturer: Intel
~        ID: E8 06 00 00 FF FB E9 BF
~        Version: Genuine Intel(R) CPU T2300
~        Voltage: 3.3 V
~        External Clock: Unknown
~        Max Speed: 1660 MHz
~        Current Speed: 1660 MHz
~        Status: Populated, Enabled
~        Upgrade: ZIF Socket
~        L1 Cache Handle: Not Provided
~        L2 Cache Handle: 0x0005
~        L3 Cache Handle: Not Provided
~        Serial Number: Not Specified
~        Asset Tag: Not Specified
~        Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes.
Cache Information
~        Socket Designation: L2 Cache
~        Configuration: Enabled, Socketed, Level 2
~        Operational Mode: Write Back
~        Location: Internal
~        Installed Size: 2048 KB
~        Maximum Size: 2048 KB
~        Supported SRAM Types:
~                Burst
~                Pipeline Burst
~        Installed SRAM Type: Burst
~        Speed: Unknown
~        Error Correction Type: Unknown
~        System Type: Unknown
~        Associativity: Unknown

Handle 0x0006, DMI type 9, 13 bytes.
System Slot Information
~        Designation: PCI Slot J1100
~        Type: 32-bit PCI
~        Current Usage: In Use
~        Length: Long
~        ID: 0
~        Characteristics:
~                5.0 V is provided
~                3.3 V is provided
~                PME signal is supported

Handle 0x0007, DMI type 9, 13 bytes.
System Slot Information
~        Designation: PCI Slot J1101
~        Type: 32-bit PCI
~        Current Usage: In Use
~        Length: Long
~        ID: 0
~        Characteristics:
~                5.0 V is provided
~                3.3 V is provided
~                PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes.
On Board Device Information
~        Type: Video
~        Status: Enabled
~        Description: Intel Calistoga

Handle 0x0009, DMI type 11, 5 bytes.
OEM Strings
~        String 1: $HP$

Handle 0x000A, DMI type 16, 15 bytes.
Physical Memory Array
~        Location: System Board Or Motherboard
~        Use: System Memory
~        Error Correction Type: None
~        Maximum Capacity: 2 GB
~        Error Information Handle: Not Provided
~        Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes.
Memory Device
~        Array Handle: 0x000A
~        Error Information Handle: No Error
~        Total Width: 32 bits
~        Data Width: 32 bits
~        Size: 512 MB
~        Form Factor: SODIMM
~        Set: 1
~        Locator: M1
~        Bank Locator: Bank 0
~        Type: DDR2
~        Type Detail: Synchronous
~        Speed: Unknown
~        Manufacturer: Not Specified
~        Serial Number: Not Specified
~        Asset Tag: Not Specified
~        Part Number: Not Specified

Handle 0x000C, DMI type 17, 27 bytes.
Memory Device
~        Array Handle: 0x000A
~        Error Information Handle: No Error
~        Total Width: 32 bits
~        Data Width: 32 bits
~        Size: 512 MB
~        Form Factor: SODIMM
~        Set: 2
~        Locator: M2
~        Bank Locator: Bank 1
~        Type: DDR2
~        Type Detail: Synchronous
~        Speed: Unknown
~        Manufacturer: Not Specified
~        Serial Number: Not Specified
~        Asset Tag: Not Specified
~        Part Number: Not Specified

Handle 0x000D, DMI type 19, 15 bytes.
Memory Array Mapped Address
~        Starting Address: 0x00000000000
~        Ending Address: 0x0003FFFFFFF
~        Range Size: 1 GB
~        Physical Array Handle: 0x000A
~        Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes.
Memory Device Mapped Address
~        Starting Address: 0x00000000000
~        Ending Address: 0x0003FFFFFFF
~        Range Size: 1 GB
~        Physical Device Handle: 0x000B
~        Memory Array Mapped Address Handle: 0x000D
~        Partition Row Position: 2
~        Interleave Position: 1
~        Interleaved Data Depth: 6

Handle 0x000F, DMI type 32, 20 bytes.
System Boot Information
~        Status: <OUT OF SPEC>

Handle 0x0010, DMI type 127, 4 bytes.
End Of Table

[harry@nb-rhsoft:~]$

- --


Reindl Harald
A-1210 Vienna
Siegfriedgasse 22-24/2/4
software-development / cms-solutions

cellular: +43 (676) 40 221 40
icq:      154546673

http://www.rhsoft.net
mailto:support@rhsoft.net

Dienstleistungen in der automatischen
Datenverarbeitung und Informationstechnik

PGP-KEY: http://tinyurl.com/2agfpe
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHfvnRRJ5vipTtasgRAn2bAJ0ZMycg7WJTjiOxQeZAzd42k7C8pgCgj39a
1uoeJTaYVpVOl22/Q2mAN18=
=o4p+
-----END PGP SIGNATURE-----
