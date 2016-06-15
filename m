From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Wed, 15 Jun 2016 23:02:55 +0300
Message-ID: <20160615200255.GA2466@nest>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
 <20160611104922.GA2368@nest>
 <2544058.dYPSaC0ylY@vostro.rjw.lan>
 <744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
 <20160613100707.GA2365@nest>
 <CAJZ5v0jw=hvcYSOokPkHK+KgsLee9nc9Aj_33H37-3t7uNxX8w@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBE2163@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36550 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbcFOUDB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 16:03:01 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBE2163@SHSMSX103.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Jun, Zheng, Lv wrote:
> Hi, Rafael
>=20
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
> > Rafael J. Wysocki
> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> >=20
> > On Mon, Jun 13, 2016 at 12:07 PM, Andrey Skvortsov
> > <andrej.skvortzov@gmail.com> wrote:
> > > Hi Lv,
> > >
> > > On 13 Jun, Zheng, Lv wrote:
> > >> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > >> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > >> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > >> >
> > >> > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > >> > > On 10 Jun, Rafael J. Wysocki wrote:
> > >> > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > >> > > > > Hi,
> > >> > > > >
> > >> > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend
> > to RAM.
> > >> > > > > Laptop doesn't finish suspend to RAM process (disks are off,=
 but
> > >> > > > > WiFi and Power LEDs are still on). The only way to get it ou=
t of
> > >> > > > > this state, is to turn the power off.
> > >> > > > >
> > >> > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > >> > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> > support
> > >> > > > > for acpi_hw_write()].
> > >> > > > >
> > >> > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend t=
o RAM
> > >> > > > > is working again.
> > >> > > > >
> > >> > > > > The cause of this problem is that after this commit write to
> > PM1A
> > >> > > > > Control Block (16-bit register) is done using two 8-bit writ=
es.
> > >> > > > > If I force this write to be 16-bit, then all is working as b=
efore.
> > >> > > > >
> > >> > > > > To get it working 'access_width' for PM1A Control Block needs
> > to
> > >> > > > > be 2 (16-bit), but it's 1 (8-bit).
> > >> [Lv Zheng]
> > >> Could you send me the acpidump of the machine?
> > > Here it is
> > >
> > https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> > ump.bin
> > >
> > >> > > > >
> > >> > > > > The root of the problem seems to be not the commit
> > >> > 66b1ed5aa8dd25
> > >> > > > > itself, but the ACPI tables in BIOS where wrong access_width
> > >> > > > > comes from. I fixed problem in FACP  table, put it in initrd=
 to
> > >> > > > > override FACP table from BIOS. This fixed the issue, suspend=
 to
> > >> > > > > RAM is working now again.
> > >> > > > >
> > >> > > > > But I'm not sure whether is this proper fix for this problem.
> > >> > > > > Is there any place in the kernel, where such ACPI quirks are
> > placed?
> > >> [Lv Zheng]
> > >> My question would be:
> > >> Does Windows behave correctly for this table?
> > > Yes, suspend to RAM is working under Windows Vista.
> > > IIRC it worked under Windows XP too.
> > >
> > >> However there is a real case showing that there are real tables need=
 us
> > to correctly support BitWidth/BitOffset.
> > >> Here is the information for you to refer:
> > >> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> > >>
> > >> > > >
> > >> > > > Well, if the commit in question caused a problem to happen for
> > you,
> > >> > > > it also might cause similar problems to happen elsewhere.
> > >> > > >
> > >> > > > It looks like we'll need to revert that commit.
> > >> > > Hi,
> > >> > >
> > >> > > or maybe to reset access_width AnyAcc from FACP table only for
> > PM1A
> > >> > > control register or even for all registers? This will fix the is=
sue too.
> > >> >
> > >> > That's a good idea actually.
> > >> >
> > >> > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > >> > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > >> > > --- a/drivers/acpi/acpica/tbfadt.c
> > >> > > +++ b/drivers/acpi/acpica/tbfadt.c
> > >> > > @@ -714,7 +714,14 @@ static void
> > acpi_tb_setup_fadt_registers(void)
> > >> > >                         }
> > >> > >                 }
> > >> > >         }
> > >> > >
> > >> > > +       /*
> > >> > > +        * Reset access_width in the GAS for PM1A control regist=
er to
> > >> > > +        * undefined value. Because in some cases this field con=
tains
> > >> > > +        * wrong value.
> > >> > > +        */
> > >> > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> > >> >
> > >> > OK, let's see what Bob and Lv think about that.
> > >> [Lv Zheng]
> > >> There is a commit in 4.7-rc2:
> > >>
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D
> > 7f9bef9d
> > >> Have you tried if the problem still exists in 4.7-rc2?
> > > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the problem
> > > exists there too.
> >=20
> > I have decided to revert commit 66b1ed5aa8dd25 as in principle other
> > registers may be similarly affected on other systems.
> [Lv Zheng]=20
> Yes.
> I didn't prepare fallback mechanism for this support.
> It seems we have to do the reversion.
> Please revert it.
> Next time I'll prepare a quirk mechanism when this is upstreamed.
Lv, Could you CC me, when you'll upstream quirk mechanism?

> For Andrey:
> Could you provide me the DMIdecode output of the machine?
DMI binary dump is available here:
https://dl.dropboxusercontent.com/u/24023626/dell-vostro-1500.dmidecode.dump

And here is dmidecode output:

# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 2.4 present.
45 structures occupying 1977 bytes.
Table at 0x000F7180.

Handle 0xDA00, DMI type 218, 251 bytes
OEM-specific Type
	Header and Data:
		DA FB 00 DA B2 00 0D 5F 1F 37 40 7D 00 00 00 00
		00 7E 00 02 00 00 00 40 00 04 00 01 00 41 00 04
		00 00 00 65 00 05 00 00 00 66 00 05 00 01 00 5E
		00 06 00 01 00 5F 00 06 00 00 00 89 01 07 00 00
		00 8A 01 07 00 01 00 42 00 08 00 01 00 43 00 08
		00 00 00 55 00 09 00 00 00 6D 00 09 00 01 00 2D
		00 0A 00 02 00 6E 00 0A 00 01 00 2E 00 0A 00 00
		00 11 01 0B 00 00 00 10 01 0B 00 01 00 F0 00 0C
		00 01 00 ED 00 0C 00 00 00 41 01 0D 00 01 00 40
		01 0D 00 00 00 47 01 0E 00 01 00 46 01 0E 00 00
		00 4A 01 0F 00 00 00 4B 01 0F 00 01 00 52 01 10
		00 01 00 53 01 10 00 00 00 80 01 11 00 01 00 7F
		01 11 00 00 00 7C 01 12 00 01 00 7B 01 12 00 00
		00 7E 01 13 00 01 00 7D 01 13 00 00 00 92 01 14
		00 00 00 91 01 14 00 01 00 94 01 15 00 00 00 93
		01 15 00 01 00 FF FF 00 00 00 00

Handle 0xDA01, DMI type 218, 251 bytes
OEM-specific Type
	Header and Data:
		DA FB 01 DA B2 00 0D 5F 1F 37 40 86 01 16 00 01
		00 85 01 16 00 00 00 82 01 17 00 01 00 81 01 17
		00 00 00 84 01 18 00 01 00 83 01 18 00 00 00 9B
		01 19 00 00 00 9C 01 19 00 01 00 9D 01 19 00 02
		00 9E 01 19 00 03 00 8B 01 1A 00 00 00 8C 01 1A
		00 01 00 EA 00 1B 00 00 00 EB 00 1B 00 01 00 EC
		00 1B 00 02 00 28 00 1C 00 00 00 29 00 1C 00 01
		00 2A 00 1C 00 02 00 2B 00 1D 00 00 00 2C 00 1E
		00 00 00 E7 00 1F 00 01 00 E6 00 1F 00 00 00 0E
		01 20 00 01 00 0F 01 20 00 00 00 9B 00 21 00 01
		00 9C 00 21 00 00 00 4D 01 22 00 01 00 4C 01 22
		00 00 00 01 01 23 00 00 00 02 01 23 00 01 00 04
		01 23 00 02 00 37 01 24 00 00 00 38 01 24 00 01
		00 D9 01 25 00 01 00 D8 01 25 00 00 00 EA 01 26
		00 00 00 EB 01 26 00 01 00 EC 01 27 00 00 00 ED
		01 27 00 01 00 FF FF 00 00 00 00

Handle 0xDA02, DMI type 218, 53 bytes
OEM-specific Type
	Header and Data:
		DA 35 02 DA B2 00 0D 5F 1F 37 40 76 01 76 01 01
		00 75 01 75 01 01 00 01 F0 01 F0 00 00 02 F0 02
		F0 00 00 03 F0 03 F0 00 00 04 F0 04 F0 00 00 FF
		FF 00 00 00 00

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Dell Inc.
	Version: A06
	Release Date: 04/21/2008
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		3.5"/720 kB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 0.6
	Firmware Revision: 0.6

Handle 0x0100, DMI type 1, 27 bytes
System Information
	Manufacturer: Dell Inc.
	Product Name: Vostro 1500                    =20
	Version: Not Specified
	Serial Number: 2KPDQF1
	UUID: 44454C4C-4B00-1050-8044-B2C04F514631
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: =20

Handle 0x0200, DMI type 2, 9 bytes
Base Board Information
	Manufacturer: Dell Inc.
	Product Name: 0NX907
	Version:   =20
	Serial Number: .2KPDQF1.CN486438228200.
	Asset Tag:          =20

Handle 0x0300, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Dell Inc.
	Type: Portable
	Lock: Not Present
	Version: Not Specified
	Serial Number: 2KPDQF1
	Asset Tag: Not Specified
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None

Handle 0x0400, DMI type 4, 40 bytes
Processor Information
	Socket Designation: Microprocessor
	Type: Central Processor
	Family: Core 2 Duo
	Manufacturer: Intel
	ID: 76 06 01 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 23, Stepping 6
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
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Not Specified
	Voltage: 3.3 V
	External Clock: 200 MHz
	Max Speed: 2600 MHz
	Current Speed: 2600 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0700
	L2 Cache Handle: 0x0701
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 2
	Core Enabled: 2
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0700, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 kB
	Maximum Size: 32 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0701, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 6144 kB
	Maximum Size: 6144 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: 15 ns
	Error Correction Type: None
	System Type: Unified
	Associativity: Other

Handle 0x0804, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0806, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: MONITOR
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x080B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FireWire
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x080C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Modem
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x080D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Ethernet
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0A00, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Intel Crestline Graphics     =20

Handle 0x0A01, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: Sigmatel 9205

Handle 0x0B00, DMI type 11, 5 bytes
OEM Strings
	String 1: Dell System
	String 2: 5[0003]
	String 3: 13[PP22L]

Handle 0x0D00, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x1000, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x1100, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_A
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: 7F98000000000000
	Serial Number: 453E7A84
	Asset Tag: 000B05
	Part Number:                  =20

Handle 0x1101, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 256 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_B
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: 7F7F7F7F7F020000
	Serial Number: 00000000
	Asset Tag: 000000
	Part Number: PSD24G8002S      =20

Handle 0x1301, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0008FFFFFFF
	Range Size: 2304 MB
	Physical Array Handle: 0x1000
	Partition Width: 1

Handle 0x1401, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x1100
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 8

Handle 0x1411, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0008FFFFFFF
	Range Size: 1792 MB
	Physical Device Handle: 0x1100
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1

Handle 0x1402, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x1101
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1
	Interleave Position: 2
	Interleaved Data Depth: 8

Handle 0x1412, DMI type 126, 19 bytes
Inactive

Handle 0x1500, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: Bus Mouse
	Buttons: 2

Handle 0x1600, DMI type 22, 26 bytes
Portable Battery
	Location: Sys. Battery Bay
	Manufacturer: Sanyo          =20
	Name: DELL UW28082   =20
	Design Capacity: 78000 mWh
	Design Voltage: 11100 mV
	SBDS Version: 1.0
	Maximum Error: 1%
	SBDS Serial Number: 1019
	SBDS Manufacture Date: 2008-02-15
	SBDS Chemistry: LION           =20
	OEM-specific Information: 0x00000001

Handle 0x1B00, DMI type 27, 12 bytes
Cooling Device
	Type: Fan
	Status: OK
	OEM-specific Information: 0x0000DD00

Handle 0x1C00, DMI type 28, 20 bytes
Temperature Probe
	Description: CPU Internal Temperature
	Location: Processor
	Status: OK
	Maximum Value: 127.0 deg C
	Minimum Value: 0.0 deg C
	Resolution: 1.000 deg C
	Tolerance: 0.5 deg C
	Accuracy: Unknown
	OEM-specific Information: 0x0000DC00

Handle 0x2000, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0xB000, DMI type 176, 5 bytes
OEM-specific Type
	Header and Data:
		B0 05 00 B0 01

Handle 0xB100, DMI type 177, 12 bytes
OEM-specific Type
	Header and Data:
		B1 0C 00 B1 02 00 00 00 00 00 00 00

Handle 0xB200, DMI type 178, 6 bytes
OEM-specific Type
	Header and Data:
		B2 06 00 B2 99 99

Handle 0xD000, DMI type 208, 10 bytes
OEM-specific Type
	Header and Data:
		D0 0A 00 D0 01 04 FE 00 28 02

Handle 0xD800, DMI type 216, 9 bytes
OEM-specific Type
	Header and Data:
		D8 09 00 D8 01 03 01 F0 03
	Strings:
		Intel Corp.         =20
		=20
		1466                 =20
		 =20

Handle 0xD900, DMI type 217, 8 bytes
OEM-specific Type
	Header and Data:
		D9 08 00 D9 01 02 01 03
	Strings:
		US-101
		Proprietary

Handle 0xDB00, DMI type 219, 9 bytes
OEM-specific Type
	Header and Data:
		DB 09 00 DB 03 01 02 03 FF
	Strings:
		System Device Bay
		Floppy, Battery, CD-ROM, CD-RW, DVD, DVD+RW, DVD+/-RW, Hard Disk, BLU-RAY
		Hard-Disk=20

Handle 0xDC00, DMI type 220, 22 bytes
OEM-specific Type
	Header and Data:
		DC 16 00 DC 01 F0 00 00 02 F0 00 00 00 00 03 F0
		04 F0 00 00 00 00

Handle 0xDD00, DMI type 221, 19 bytes
OEM-specific Type
	Header and Data:
		DD 13 00 DD 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00

Handle 0xD400, DMI type 212, 37 bytes
OEM-specific Type
	Header and Data:
		D4 25 00 D4 74 00 75 00 00 10 2D 2E 5C 00 78 BF
		40 5D 00 78 BF 00 08 00 1D DF 00 03 00 1D DF 00
		FF FF 00 00 00

Handle 0xD401, DMI type 212, 17 bytes
OEM-specific Type
	Header and Data:
		D4 11 01 D4 74 00 75 00 03 40 49 4A FF FF 00 00
		00

Handle 0xDE00, DMI type 222, 16 bytes
OEM-specific Type
	Header and Data:
		DE 10 00 DE 01 02 FF FF 00 00 00 00 00 00 00 01

Handle 0x7F00, DMI type 127, 4 bytes
End Of Table



--=20
Best regards,
Andrey Skvortsov



--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXYbRvAAoJEAF8y6L1SLCtJcYQALdphgYwn9iKrNXC8ZBvp3LJ
y31I3Vswfs0lLiNf5VreypDrKOc+hB3Zp8Io4zarHwiIXuPBGVH3zxc6K9SB+OC0
muZjvRAuTEM21iwcqMJwq9uCt3bBTUp4887gre+zc7xd+VI1A+KqjOg+5wopNFST
CSDWmXv1OoMJn1GrqQHuLaaH0AfNU+I375Ww9BlHGmd5H+G8UEdh5BUPY/4iO4RF
HTps294gsK50L2V0o6hudc5E/GOZLybME+2P78s0Dhq7ealiFlMcACZLX4mCH2KZ
jPDOaa/eb3wkRPPH3NN4MGbEJzT3wsCit90nmLFiMu1SmqgkJ6C+WGeQu7A9kJDh
R0TWjlUtj/lWJrUowRsCVVXawXdH/B1lZDZwYrV1JTaaOjWL5xfF5IGukOmu3MPz
AKxcSYTpro2llZoxqWtYas7sVFnfJ1XtUEgPTgqlpjy4kM1+9IKoBku2DYKFZG2z
fSXkM/TUP7oYtAvoV1r1AZQtWI8ghLi31rVrzPlEeiU5Uwix+Z6PwEB5PVFjLMGX
lWL4UpYRbhAndXaI3IR/wEz87VzT4QxrA9k5EcCf0KIE4obysLQ2GwH+eXgH9muI
i272Iy15xeMhSPjhBry4CaiOyHs5z9WzNNHyylKhI8mxo184mvkKjDzFmrtyxbQR
eZLkxMIBs7C9ZVgWH9do
=l/6e
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
