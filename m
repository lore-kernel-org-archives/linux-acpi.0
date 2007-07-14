From: Markus Rathgeb <maggu2810@web.de>
Subject: Re: dmidecode acpi_osi=!Linux
Date: Sat, 14 Jul 2007 16:28:00 +0200
Message-ID: <200707141628.07178.maggu2810@web.de>
References: <49699.212.238.156.107.1184415372.squirrel@mail.de-vos.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1538657.PyrugAhYbo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:57948 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbXGNO3a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2007 10:29:30 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id EC99F8CDDF10
	for <linux-acpi@vger.kernel.org>; Sat, 14 Jul 2007 16:29:28 +0200 (CEST)
Received: from [87.181.85.83] (helo=[192.168.0.100])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #197)
	id 1I9ici-0001B8-00
	for linux-acpi@vger.kernel.org; Sat, 14 Jul 2007 16:29:28 +0200
In-Reply-To: <49699.212.238.156.107.1184415372.squirrel@mail.de-vos.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1538657.PyrugAhYbo
Content-Type: multipart/mixed;
  boundary="Boundary-01=_w1NmGN/aLK/FB6o"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_w1NmGN/aLK/FB6o
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!
I saw a lot of the dmidecode messages and attached my dmidecode output (wit=
h=20
kernel.parameter acpi_osi=3D!Linux).
But there is no different if I use this parameter or not.
Regards,
Markus

=2D-=20

Markus Rathgeb
Jabber: maggu2810@jabber.org
Public Key Server: http://wwwkeys.us.pgp.net/ bzw. hkp://wwwkeys.us.pgp.net/

"Erst nachdem wir alles verloren haben, haben wir die Freiheit, alles zu tu=
n."
"It's only after we've lost everything, that we're free to do anything!"


--Boundary-01=_w1NmGN/aLK/FB6o
Content-Type: text/x-log;
  charset="utf-8";
  name="dmidecode.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmidecode.log"

# dmidecode 2.9
SMBIOS 2.3 present.
17 structures occupying 592 bytes.
Table at 0x000DB010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Phoenix
	Version: 0F09.P00
	Release Date: 01/07/2005
	Address: 0xE78E0
	Runtime Size: 100128 bytes
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
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: ACTEBIS
	Product Name: SAM#451B
	Version: VT8385/VT8235
	Serial Number: 000009
	UUID: 80427E3E-4364-0010-937C-000930CFCFFC
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: ACTEBIS
	Product Name: SAM#451B
	Version: KBC Revision: 3308
	Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: ACTEBIS
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

Handle 0x0004, DMI type 4, 32 bytes
Processor Information
	Socket Designation: Socket 754
	Type: Central Processor
	Family: Opteron
	Manufacturer: AuthenticAMD
	ID: 4A 0F 00 00 FF FB 8B 07
	Signature: Family 15, Model 4, Stepping 10
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
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
	Version: AMD Athlon(tm) 64
	Voltage: 1.5 V
	External Clock: Unknown
	Max Speed: 2500 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0007
	L2 Cache Handle: 0x0008
	L3 Cache Handle: Not Provided

Handle 0x0005, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM 1
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 256 MB (Double-bank Connection)
	Enabled Size: 256 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM 2
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 2-way Set-associative

Handle 0x0008, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: Fully Associative

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: ACTEBIS:SAM#451B
	String 2: www.arima.com.tw
	String 3:                =20

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 23 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown

Handle 0x000C, DMI type 17, 23 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0005FFFFFFF
	Range Size: 1536 MB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 1

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0010, DMI type 127, 4 bytes
End Of Table


--Boundary-01=_w1NmGN/aLK/FB6o--

--nextPart1538657.PyrugAhYbo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBGmN13BH8MHVzJ39ERAs4EAKC7uD9B02e/7DCZp7Xb6aAtrvdliACgjpd5
bMMDwkSMSP5qVoFHkZlAL+U=
=6eRJ
-----END PGP SIGNATURE-----

--nextPart1538657.PyrugAhYbo--
