From: "Fred Albrecht" <fred@fredshome.org>
Subject: dmidecode for Samsung Q35 laptop
Date: Wed, 2 Apr 2008 18:10:08 +0200
Message-ID: <b367f9780804020910s4fe2a803o9c5a61fcea5a9f80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:54323 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbYDBQKJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2008 12:10:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1503068rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Apr 2008 09:10:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello, as per request in the dmesg :

root@bop:~# uname -a
Linux bop 2.6.22-14-generic #1 SMP Tue Feb 12 07:42:25 UTC 2008 i686 GNU/Linux

root@bop:~# lsb_release -d
Description:    Ubuntu 7.10

# dmidecode 2.9
SMBIOS 2.4 present.
33 structures occupying 1030 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: 25SD
        Release Date: 03/29/2007
        Address: 0xE7E40
        Runtime Size: 98752 bytes
        ROM Size: 1024 kB
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
                ACPI is supported
                USB legacy is supported
                IEEE 1394 boot is supported
                Smart battery is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 0.0
        Firmware Revision: 0.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
        Product Name: Q35/Q36
        Version: 25SD
        Serial Number: 811L93CP400066
        UUID: 60BBC5F4-DA1D-B211-8000-B18CD8B19F07
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
        Product Name: Q35/Q36
        Version:
        Serial Number: 123490EN400015

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
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
        ID: F2 06 00 00 FF FB EB BF
        Version: Intel(R) Core(TM)2 CPU         T5
        Voltage: 3.3 V
        External Clock: Unknown
        Max Speed: 2048 MHz
        Current Speed: 1660 MHz
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
        Installed Size: 32 KB
        Maximum Size: 32 KB
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
        Location: External
        Installed Size: 2048 KB
        Maximum Size: 2048 KB
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
        Internal Reference Designator: J23
        Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
        External Reference Designator: Parallel
        External Connector Type: DB-25 female
        Port Type: Parallel Port ECP/EPP

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J12
        Internal Connector Type: None
        External Reference Designator: PS/2 Mouse
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
        Designation: CARDBUS 0
        Type: 32-bit PC Card (PCMCIA)
        Current Usage: Unknown
        Length: Other
        ID: Adapter 0, Socket 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PC Card-16 is supported
                Cardbus is supported

Handle 0x000B, DMI type 10, 6 bytes
On Board Device Information
        Type: Sound
        Status: Disabled
        Description: HD-Audio

Handle 0x000C, DMI type 11, 5 bytes
OEM Strings
        String 1: BBBBAAAAAAAA
        String 2: 2007/08

Handle 0x000D, DMI type 12, 5 bytes
System Configuration Options
        Option 1: Jumper settings can be described here.

Handle 0x000E, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 3 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000E
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: 1
        Locator: M1
        Bank Locator: Bank 0
        Type: DDR
        Type Detail: Synchronous
        Speed: Unknown
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0010, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000E
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: 1
        Locator: M2
        Bank Locator: Bank 1
        Type: DDR
        Type Detail: Synchronous
        Speed: Unknown
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0011, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000E
        Partition Width: 0

Handle 0x0012, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x000F
        Memory Array Mapped Address Handle: 0x0011
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0013, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00020000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x0010
        Memory Array Mapped Address Handle: 0x0011
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0014, DMI type 21, 7 bytes
Built-in Pointing Device
        Type: Touch Pad
        Interface: PS/2
        Buttons: 4

Handle 0x0015, DMI type 23, 13 bytes
System Reset
        Status: Enabled
        Watchdog Timer: Present
        Boot Option: Do Not Reboot
        Boot Option On Limit: Do Not Reboot
        Reset Count: Unknown
        Reset Limit: Unknown
        Timer Interval: Unknown
        Timeout: Unknown

Handle 0x0016, DMI type 24, 5 bytes
Hardware Security
        Power-On Password Status: Enabled
        Keyboard Password Status: Unknown
        Administrator Password Status: Enabled
        Front Panel Reset Status: Unknown

Handle 0x0017, DMI type 25, 9 bytes
        System Power Controls
        Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0018, DMI type 26, 20 bytes
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

Handle 0x0019, DMI type 27, 12 bytes
Cooling Device
        Temperature Probe Handle: 0x001A
        Type: Fan
        Status: OK
        OEM-specific Information: 0x00000000

Handle 0x001A, DMI type 28, 20 bytes
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

Handle 0x001B, DMI type 29, 20 bytes
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

Handle 0x001C, DMI type 30, 6 bytes
Out-of-band Remote Access
        Manufacturer Name: Intel
        Inbound Connection: Enabled
        Outbound Connection: Disabled

Handle 0x001D, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x001E, DMI type 129, 16 bytes
OEM-specific Type
        Header and Data:
                81 10 1E 00 01 01 02 01 00 00 00 01 00 00 08 01
        Strings:
                Intel_ASF_001
                Intel_ASF_001

Handle 0x001F, DMI type 136, 6 bytes
OEM-specific Type
        Header and Data:
                88 06 1F 00 FF FF

Handle 0x0020, DMI type 127, 4 bytes
End Of Table

root@bop:~#

Hopefully this can be of some use to you (still having network trouble
on wakeup and ALSA problems with that machine, works ok otherwise).

Cheers.

-- 
Fred Albrecht
Linux Guru
fred@fredshome.org (now fixed)
jabber : fred.albrecht@jabber.fsfe.org
