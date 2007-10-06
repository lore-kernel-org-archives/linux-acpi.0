From: Jochen Kemnade <kemnade@gmail.com>
Subject: dmidecode for Compal HEL80 Notebook
Date: Sat, 06 Oct 2007 10:27:23 +0200
Message-ID: <470746EB.2000707@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig4A9B6A1FEF595B66932CFFD4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:22007 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbXJFI1d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2007 04:27:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so595269ugc
        for <linux-acpi@vger.kernel.org>; Sat, 06 Oct 2007 01:27:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A9B6A1FEF595B66932CFFD4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello,

I just noticed a kernel output message that suggested that I post the
output of dmidecode to this list. So here it is. I hope this information
is of any use for you. If I can take any further steps to assist you,
please let me know.

Regards,
Jochen Kemnade


# dmidecode 2.9
SMBIOS 2.4 present.
22 structures occupying 970 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: COMPAL
        Version: 122B
        Release Date: 07/09/2007
        Address: 0xE63F0
        Runtime Size: 105488 bytes
        ROM Size: 1024 kB
        Characteristics:
                PCI is supported
                PC Card (PCMCIA) is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                Smart battery is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 1.21
        Firmware Revision: 1.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: COMPAL
        Product Name: HEL80C
        Version: -
        Serial Number: 2056773503276
        UUID: 980A3401-5238-11DB-9E1A-0016D45584F7
        Wake-up Type: Power Switch
        SKU Number:

        Family: Intel

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: COMPAL
        Product Name: HEL8X
        Version: Null
        Serial Number: 0123456789AB

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: COMPAL
        Type: Notebook
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag: -
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
        ID: F5 06 00 00 FF FB EB BF
        Version: Intel(R) Core(TM)2 CPU         T7
        Voltage: 3.3 V
        External Clock: Unknown
        Max Speed: 2330 MHz
        Current Speed: 2130 MHz
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
        Installed Size: 4096 KB
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
        Internal Reference Designator: J11
        Internal Connector Type: None
        External Reference Designator: Keyboard
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J12
        Internal Connector Type: None
        External Reference Designator: PS/2 Mouse
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x0009, DMI type 9, 13 bytes
System Slot Information
        Designation: ENE CB-714
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
        String 1: -

Handle 0x000C, DMI type 12, 5 bytes
System Configuration Options
        Option 1: Jumper settings can be described here.

Handle 0x000D, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 3 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000D
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 1024 MB
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

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x000D
        Error Information Handle: No Error
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 1024 MB
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

Handle 0x0010, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 2 GB
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
        Starting Address: 0x00040000000
        Ending Address: 0x0007FFFFFFF
        Range Size: 1 GB
        Physical Device Handle: 0x000F
        Memory Array Mapped Address Handle: 0x0010
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0013, DMI type 22, 26 bytes
Portable Battery
        Location: 1st Battery
        Manufacturer: COMPAL
        Manufacture Date: 12/01/2005
        Serial Number: 3658Q
        Name: PA3395U
        Chemistry: Lithium Ion
        Design Capacity: 31500 mWh
        Design Voltage: 14800 mV
        SBDS Version: Not Specified
        Maximum Error: Unknown
        OEM-specific Information: 0x00000000

Handle 0x0014, DMI type 32, 20 bytes
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0015, DMI type 127, 4 bytes
End Of Table

--=20
Jochen Kemnade
kemnade@gmail.com
PGP: 0xb5cb0a3f


--------------enig4A9B6A1FEF595B66932CFFD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHB0bv8gsDeLXLCj8RA23PAKCSmGO7JHPWL0UFKP9QKCNQTOvqYwCgtQaH
/iD2rs/WKIsNMmGRoMH73T4=
=PUy7
-----END PGP SIGNATURE-----

--------------enig4A9B6A1FEF595B66932CFFD4--
