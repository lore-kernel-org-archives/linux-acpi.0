From: Holger Klene <h.klene@tu-bs.de>
Subject: Errormessage from kernel 2.6.22-14-generic
Date: Thu, 8 Nov 2007 00:21:34 +0100
Message-ID: <200711080021.40915.h.klene@tu-bs.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart108594656.kVHeXcJogi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.hansenet.de ([213.191.73.26]:53707 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753473AbXKGXmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2007 18:42:05 -0500
Received: from samson.local (85.182.124.253) by webmail.hansenet.de (7.3.118.12) (authenticated as carolin.nienhagen@alice-dsl.de)
        id 4729E72800B14821 for linux-acpi@vger.kernel.org; Thu, 8 Nov 2007 00:21:41 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart108594656.kVHeXcJogi
Content-Type: multipart/mixed;
  boundary="Boundary-01=_+hkMHmP/xYQt3Nt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_+hkMHmP/xYQt3Nt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

After the update to kernel 2.6.22-14-generic I got this note=20
in /var/log/messages

Nov  7 18:17:11 samson kernel: [   15.576751] ACPI: Please test=20
with "acpi_osi=3D!Linux"
Nov  7 18:17:11 samson kernel: [   15.576752] Please send dmidecode to=20
linux-acpi@vger.kernel.org

That is why I eMail you. I hope this is OK ...

By the way ... the new kernel would only boot in recovery mode. I could sta=
rt=20
kdm manually, but there was no networkadapter detected. so for now I have t=
o=20
experiment on this some more using the old kernel 2.6.20-16-generic to go=20
online and search for errormessages.

=2D-=20
|_|/    MfG
| |\    Holger Klene

PGP Key ID: 0x22FFE57E

--Boundary-01=_+hkMHmP/xYQt3Nt
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmidecode.txt"

Nov  7 18:17:11 samson kernel: [   15.576751] ACPI: Please test with "acpi_=
osi=3D!Linux"
Nov  7 18:17:11 samson kernel: [   15.576752] Please send dmidecode to linu=
x-acpi@vger.kernel.org

=2D----

# dmidecode 2.9
SMBIOS 2.4 present.
29 structures occupying 1023 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: 05YE
	Release Date: 06/18/2007
	Address: 0xE54D0
	Runtime Size: 109360 bytes
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
	Version: 01YE
	Serial Number: 962V93AP400034
	UUID: 609A7519-D21D-B211-8000-C6AC1FDCDAE9
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Product Name: R40P/R41P
	Version:    =20
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
	Family: Celeron D
	Manufacturer: Intel
	ID: EC 06 00 00 FF FB E9 BF
	Signature: Type 0, Family 6, Model 14, Stepping 12
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
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: A0
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 2048 MHz
	Current Speed: 1729 MHz
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
	String 2: 2007/07

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
	Size: 1024 MB
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
	Size: 1024 MB
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
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
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


--Boundary-01=_+hkMHmP/xYQt3Nt--

--nextPart108594656.kVHeXcJogi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMkiEmej+ciL/5X4RAqYwAKCIiRW8JIi/dr/+iVnmdE1uwS6FmwCeKZRG
PTYkgPZyQLgylrHDVeVnVYk=
=k9UH
-----END PGP SIGNATURE-----

--nextPart108594656.kVHeXcJogi--
