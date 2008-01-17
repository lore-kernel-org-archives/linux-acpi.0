From: "Yurij Perepelytsia" <yurij.perepelytsia@gmail.com>
Subject: dmidecode
Date: Thu, 17 Jan 2008 14:43:18 +0200
Message-ID: <184fd4090801170443r512ec5a9w6a8984c4fe25fbbd@mail.gmail.com>
References: <184fd4090801170441r6d93157gfa1548b737a796c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:49248 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYAQMnT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 07:43:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1059523wah.23
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2008 04:43:19 -0800 (PST)
In-Reply-To: <184fd4090801170441r6d93157gfa1548b737a796c4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

in my log file I've found "Please send dmidecode to
linux-acpi@vger.kernel.org" my laptop is Samsung R40Plus R40XY0E.
Here is copy past of that.

yura:/home/yura# dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
29 structures occupying 1023 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
    Vendor: Phoenix Technologies LTD
    Version: 06YE
    Release Date: 07/18/2007
    Address: 0xE53C0
    Runtime Size: 109632 bytes
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
        LS-120 boot is supported
        ATAPI Zip drive boot is supported
        BIOS boot specification is supported
        Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
    Product Name: R40P/R41P
    Version: 06YE
    Serial Number: 967Y93FP800126
    UUID: 20B7E72E-D21D-B211-8000-9F20205EAF5B
    Wake-up Type: Power Switch
    SKU Number: Not Specified
    Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
    Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
    Product Name: R40P/R41P
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
    ID: EC 06 00 00 FF FB E9 AF
    Version: A0
    Voltage: 3.3 V
    External Clock: Unknown
    Max Speed: 2048 MHz
    Current Speed: 1862 MHz
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
    Maximum Size: 4096 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
    Installed SRAM Type: Burst
    Speed: Unknown
    Error Correction Type: Unknown
    System Type: Unknown
    Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
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

Handle 0x0008, DMI type 11, 5 bytes
OEM Strings
    String 1: AABBAAAAAAAA
    String 2: 2007/12

Handle 0x0009, DMI type 12, 5 bytes
System Configuration Options
    Option 1: Jumper settings can be described here.

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 1 GB
    Error Information Handle: Not Provided
    Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x000A
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: 1
    Locator: J400
    Bank Locator: Channel A0
    Type: DRAM
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
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: 3
    Locator: J501
    Bank Locator: Channel B0
    Type: DRAM
    Type Detail: Synchronous
    Speed: Unknown
    Manufacturer: Not Specified
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x000D, DMI type 18, 23 bytes
32-bit Memory Error Information
    Type: OK
    Granularity: Unknown
    Operation: Unknown
    Vendor Syndrome: Unknown
    Memory Array Address: Unknown
    Device Address: Unknown
    Resolution: Unknown

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0003FFFFFFF
    Range Size: 1 GB
    Physical Array Handle: 0x000A
    Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Device Handle: 0x000B
    Memory Array Mapped Address Handle: 0x000E
    Partition Row Position: 2
    Interleave Position: 1
    Interleaved Data Depth: 6

Handle 0x0010, DMI type 21, 7 bytes
Built-in Pointing Device
    Type: Touch Pad
    Interface: PS/2
    Buttons: 4

Handle 0x0011, DMI type 22, 26 bytes
Portable Battery
    Location: Rear
    Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
    Name: SAMSUNG ELECTRONICS CO., LTD.
    Chemistry: Lithium Ion
    Design Capacity: 1000 mWh
    Design Voltage: 19 mV
    SBDS Version: BATT_1234
    Maximum Error: Unknown
    SBDS Serial Number: 0000
    SBDS Manufacture Date: 1980-00-00
    OEM-specific Information: 0x00000000

Handle 0x0012, DMI type 23, 13 bytes
System Reset
    Status: Enabled
    Watchdog Timer: Present
    Boot Option: Do Not Reboot
    Boot Option On Limit: Do Not Reboot
    Reset Count: Unknown
    Reset Limit: Unknown
    Timer Interval: Unknown
    Timeout: Unknown

Handle 0x0013, DMI type 24, 5 bytes
Hardware Security
     Power-On Password Status: Disabled
    Keyboard Password Status: Unknown
    Administrator Password Status: Disabled
    Front Panel Reset Status: Unknown

Handle 0x0014, DMI type 25, 9 bytes
    System Power Controls
    Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0015, DMI type 26, 22 bytes
Voltage Probe
    Description: Voltage Probe 1
    Location: Processor
    Status: OK
    Maximum Value: Unknown
     Minimum Value: Unknown
    Resolution: Unknown
    Tolerance: Unknown
    Accuracy: Unknown
    OEM-specific Information: 0x00000000
    Nominal Value: 8.192 V

Handle 0x0016, DMI type 27, 14 bytes
Cooling Device
    Temperature Probe Handle: 0x0018
    Type: Fan
    Status: OK
    Cooling Unit Group: 255
    OEM-specific Information: 0x00000000
    Nominal Speed: Unknown Or Non-rotating

 Handle 0x0017, DMI type 27, 12 bytes
Cooling Device
    Temperature Probe Handle: 0x0018
    Type: Fan
    Status: OK
    Cooling Unit Group: 255
    OEM-specific Information: 0x00000000

Handle 0x0018, DMI type 28, 22 bytes
Temperature Probe
    Description: Temperature Probe 1
    Location: Processor
    Status: OK
    Maximum Value: Unknown
    Minimum Value Unknown
    Resolution: Unknown
    Tolerance: Unknown
     Accuracy: Unknown
    OEM-specific Information: 0x00000000
    Nominal Value: Unknown

Handle 0x0019, DMI type 29, 22 bytes
Electrical Current Probe
    Description: Electrical Current Probe 1
    Location: Processor
    Status: OK
    Maximum Value: Unknown
    Minimum Value: Unknown
    Resolution: Unknown
    Tolerance: Unknown
    Accuracy: Unknown
    OEM-specific Information: 0x00000000
    Nominal Value: Unknown

Handle 0x001A, DMI type 30, 6 bytes
Out-of-band Remote Access
    Manufacturer Name: Intel
    Inbound Connection: Enabled
    Outbound Connection: Disabled

Handle 0x001B, DMI type 32, 20 bytes
 System Boot Information
    Status: <OUT OF SPEC>

Handle 0x001C, DMI type 127, 4 bytes
End Of Table

yura:/home/yura#



-- 
Sincerely,
Yurij Perepelytsia
