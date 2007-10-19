From: "nothingness@citycable.ch" <nothingness@citycable.ch>
Subject: dmidecode for Sony Vaio SZ650N
Date: Fri, 19 Oct 2007 16:22:59 -0400
Message-ID: <47191223.1020405@citycable.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ecler.submusic.ch ([80.74.152.177]:48472 "EHLO
	mail.ecler.submusic.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762340AbXJSU4j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2007 16:56:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ecler.submusic.ch (Postfix) with ESMTP id 36AF518206CC
	for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2007 22:23:29 +0200 (CEST)
Received: from mail.ecler.submusic.ch ([127.0.0.1])
	by localhost (ecler.submusic.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DhceJInS6VDG for <linux-acpi@vger.kernel.org>;
	Fri, 19 Oct 2007 22:23:25 +0200 (CEST)
Received: from ghost.nineinchnetworks.ch (c-71-63-114-199.hsd1.va.comcast.net [71.63.114.199])
	(Authenticated sender: simon.biddle@nineinchnetworks.ch)
	by mail.ecler.submusic.ch (Postfix) with ESMTP id 3666E18206C5
	for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2007 22:23:25 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 1176 bytes.
Table at 0x7FECB000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: R0081S5
        Release Date: 07/12/2007
        Address: 0xE5240
        Runtime Size: 110016 bytes
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
                BIOS boot specification is supported
                Function key-initiated network boot is supported
                Targeted content distribution is supported
        BIOS Revision: 8.1
        Firmware Revision: 8.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Sony Corporation
        Product Name: VGN-SZ650N
        Version: J002QRYN
        Serial Number: 28205633-3023572
        UUID: A04662C0-0EBE-11DC-88DD-0013A9FFC26B
        Wake-up Type: Power Switch
        SKU Number: N/A                             
        Family: N/A                             

Handle 0x0002, DMI type 2, 9 bytes
Base Board Information
        Manufacturer: Sony Corporation
        Product Name: VAIO                            
        Version: N/A                             
        Serial Number: N/A                             

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: Sony Corporation
        Type: Notebook
        Lock: Not Present
        Version: N/A                  
        Serial Number:                                                   
        Asset Tag:                                                   
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: N/A
        Type: Central Processor
        Family: Other
        Manufacturer: GenuineIntel
        ID: FA 06 00 00 FF FB EB BF
        Version: Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz
        Voltage: 1.2 V
        External Clock: 200 MHz
        Max Speed: 2200 MHz
        Current Speed: 2200 MHz
        Status: Populated, Enabled
        Upgrade: None
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: Not Provided
        Serial Number: N/A
        Asset Tag: N/A
        Part Number: N/A

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
        Error Correction Type: Single-bit ECC
        System Type: Unknown
        Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 4096 KB
        Maximum Size: 4096 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Unified
        Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
        Designation: PCCARD1
        Type: 32-bit PC Card (PCMCIA)
        Current Usage: Available
        Length: Other
        ID: Adapter 0, Socket 1
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PC Card-16 is supported
                Cardbus is supported
                Modem ring resume is supported
                PME signal is supported
                Hot-plug devices are supported

Handle 0x0008, DMI type 11, 5 bytes
OEM Strings
        String 1: 0000010012
        String 2: FNC-HDPWCCIA0oke
        String 3: 02VE0000000073E2F3A52FB8552D
        String 4: Reserved              
        String 5: Reserved              

Handle 0x0009, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 1000 MB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000A, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0009
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

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0009
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

Handle 0x000C, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
        Physical Array Handle: 0x0009
        Partition Width: 0

Handle 0x000D, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000A
        Memory Array Mapped Address Handle: 0x000C
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00040000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000B
        Memory Array Mapped Address Handle: 0x000C
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0010, DMI type 129, 16 bytes
OEM-specific Type
        Header and Data:
                81 10 10 00 01 01 02 01 00 00 00 01 00 00 08 01
        Strings:
                Intel_ASF_001
                Intel_ASF_001

Handle 0x0011, DMI type 136, 11 bytes
OEM-specific Type
        Header and Data:
                88 0B 11 00 01 44 49 52 53 03 03
        Strings:
                Sony Corporation

Handle 0x0012, DMI type 150, 14 bytes
OEM-specific Type
        Header and Data:
                96 0E 12 00 01 01 00 00 00 00 00 00 00 00
        Strings:
                ABSOLUTE(PHOENIX) CLM

Handle 0x0013, DMI type 127, 4 bytes
End Of Table

