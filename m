From: praveen <pkallakuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: acpi woes on 2.6.10-5
Date: Tue, 12 Jul 2005 06:36:29 -0500
Message-ID: <a756b9ed0507120436740aa4c0@mail.gmail.com>
References: <a756b9ed050709172542d74b39@mail.gmail.com>
Reply-To: praveen <pkallakuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10881_7458568.1121168189230"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <a756b9ed050709172542d74b39-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_Part_10881_7458568.1121168189230
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

My earlier message on this topic bounced because of the size of the
acpidump. I will send it to anyone who needs to look at it directly if
that is alright. Thank you.

---------- Forwarded message ----------
From: praveen <pkallakuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Jul 9, 2005 7:25 PM
Subject: acpi woes on 2.6.10-5
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org


I am on 2.6.10-5-386 on a compaq presario 1720US. (its an ubuntu hoary inst=
all)

I got tired of my battstat applet not working.. and when I digged in,
I found that /proc/acpi/info/battery/alarm, .../info, and .../state
were empty files. If I cat any of these files I loose my touchpad and
later, even my keyboard etc.. it looks like it results in a runaway
process taking up most mem.. if I go to the tty and fire an "init 0"
shutting down power management takes forever and finally I see out of
memory errors.

Anyway, I got a new DSDT generated from acpidmp and appended the
approp signature followed by the DSDT datafile to my initrd as
explained in Markus Gaugusch's page. I didn't have to recompile my
kernel since I did find the messages that are supposed to appear when
the new DSDT table is found in initrd during boot time... I figured my
kernel already has that patch..

So I get all this done and when I boot up, I still find the files
empty and yes, trying to cat them results in the same behavior..

Can anyone help? I am attaching all the relevant output..

--
                                     k.p.




--=20
                                     k.p.

------=_Part_10881_7458568.1121168189230
Content-Type: text/plain; name=lspci.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 009c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 009c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1860 [size=32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 41) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0200000-d02fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 009c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 1800 [size=16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 009c
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 005c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1880 [size=64]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device b11b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:02:04.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at d0210000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 1: I/O ports at 3040 [disabled] [size=8]
	Capabilities: <available only to root>

0000:02:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device b1b1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0201000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0204000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 41)
	Subsystem: Compaq Computer Corporation: Unknown device 0093
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3000 [size=64]
	Capabilities: <available only to root>


------=_Part_10881_7458568.1121168189230
Content-Type: text/plain; name=dmicode.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmicode.txt"

# dmidecode 2.5
SMBIOS 2.31 present.
21 structures occupying 761 bytes.
Table at 0x000DB010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies LTD
		Version: 4.06
		Release Date: 05/30/2002
		Address: 0xE62B0
		Runtime Size: 105808 bytes
		ROM Size: 64 kB
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
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			NEC PC-98
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: COMPAQ
		Product Name: PRESARIO 1720US 470020-430
		Version: 0F0E
		Serial Number: 5Y1AKDJKNA99
		UUID: 00DCF68D-8563-0010-8C2E-302E808B3BEB
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: COMPAQ
		Product Name: 0726h
		Version: TBD   
		Serial Number: None
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: COMPAQ
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
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: U1
		Type: Central Processor
		Family: Pentium III
		Manufacturer: GenuineIntel
		ID: B1 06 00 00 FF F9 83 03
		Signature: Type 0, Family 6, Model 11, Stepping 1
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
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
		Version: Intel(R) Pentium(
		Voltage: 3.3 V
		External Clock: 133 MHz
		Max Speed: 1000 MHz
		Current Speed: 733 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 1024 MB
		Maximum Total Memory Size: 2048 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types: None
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0000
			0x0001
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: J7
		Bank Connections: 0 1
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: J8
		Bank Connections: 2 3
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
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
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000A
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: Mini PCI Slot J12
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
			3.3 V is provided
Handle 0x000B
	DMI type 10, 14 bytes.
	On Board Device 1 Information
		Type: Video
		Status: Enabled
		Description: ATi Mobility-P6 Video
	On Board Device 2 Information
		Type: Sound
		Status: Enabled
		Description: AC97 Crystal Audio
	On Board Device 3 Information
		Type: Ethernet
		Status: Enabled
		Description: Internal Ethernet
	On Board Device 4 Information
		Type: Other
		Status: Enabled
		Description: Ti TSB43BA22 IEEE1394
	On Board Device 5 Information
		Type: Other
		Status: Enabled
		Description: Ti 1410 Cardbus
Handle 0x000C
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: MG
		String 2: ........................
Handle 0x000D
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 512 MB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x000E
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000D
		Error Information Handle: No Error
		Total Width: 32 bits
		Data Width: 32 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: J7
		Bank Locator: Bank 0
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000F
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000D
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: J8
		Bank Locator: Bank 1
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0010
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Array Handle: 0x000D
		Partition Width: 0
Handle 0x0011
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000E
		Memory Array Mapped Address Handle: 0x0010
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x0012
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x000100003FF
		Range Size: 1 kB
		Physical Device Handle: 0x000F
		Memory Array Mapped Address Handle: 0x0010
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x0013
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0014
	DMI type 127, 4 bytes.
	End Of Table

------=_Part_10881_7458568.1121168189230
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.10-5-386 (buildd@vernadsky) (gcc version 3.3.5 (Debian 1:=
3.3.5-8ubuntu2)) #1 Fri Jun 24 16:53:01 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff60000 (usable)
 BIOS-e820: 000000000ff60000 - 000000000ff6fc00 (ACPI data)
 BIOS-e820: 000000000ff6fc00 - 000000000ff80000 (ACPI NVS)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61280 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6420
ACPI: RSDT (v001 PTLTD  =09 RSDT   0x06040000  LTP 0x00000000) @ 0x0ff69f76
ACPI: FADT (v001 COMPAQ CPQ2C01  0x06040000 PTL  0x00000001) @ 0x0ff6fb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0ff6fbd8
ACPI: DSDT (v001 COMPAQ   U22C01 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=3D/dev/hda1 ro quiet splash
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01202000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 996.874 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 251420k/261504k available (1436k kernel code, 9424k reserved, 754k =
data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
.
Calibrating delay loop... 1978.36 BogoMIPS (lpj=3D989184)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 0000=
0000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000=
000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00=
000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
ACPI: Looking for DSDT in initrd... found (at offset 4403220)!
 found customized DSDT with 23470 bytes!
ACPI: Using customized DSDT
    ACPI-0294: *** Info: Table [DSDT] replaced by host OS
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs...it isn't (bad gzip magic numbers); looks l=
ike an initrd
Freeing initrd memory: 4322k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd99b, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 14 15) *0, disabled.
ACPI: Embedded Controller [H8] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: 00:03: ioport range 0x600-0x60f has been reserved
Simple Boot Flag at 0x38 set to 0x1
audit: initializing netlink socket (disabled)
audit(1120935077.142:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a NS16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a NS16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
Restarting tasks...<6> Strange, kswapd0 not stopped
 Strange, kseriod not stopped
 done
ACPI wakeup devices:=20
  AC  LID PWRB PCIB CRD0  LAN PS2K PS2M   H8 USB0 USB1 USB2=20
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4300KiB [1 disk] into ram disk... |=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [TZ0] (60 C)
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK2018GAP, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB), CHS=3D38760/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2002, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Adding 500936k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
SCSI subsystem initialized
Synaptics Touchpad, model: 1
 Firmware: 5.5
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
mice: PS/2 mouse device common for all mice
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ts: Compaq touchscreen protocol output
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1219 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,EP=
P,ECP,DMA]
lp0: using parport0 (interrupt-driven).
Capability LSM initialized
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
cdrom: open failed.
cdrom: open failed.
Real Time Clock Driver v1.12
inserting floppy driver for 2.6.10-5-386
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Evaluate _OSC Set fails. Status =3D 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 0x1860
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Evaluate _OSC Set fails. Status =3D 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
hw_random: RNG not detected
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49060 usecs
intel8x0: clocking to 48000
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[9]  MMIO=3D[d0201000-d02017=
ff]  Max Packet=3D[2048]
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.0 [0e11:b103]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x012c1202, devctl 0x64
Yenta: ISA IRQ mask 0x0058, PCI irq 10
Socket status: 30000010
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xd0200000, irq 9, MAC addr 00:02:A5:99:D3:BB
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508b702fab2929]
NET: Registered protocol family 17
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [CMB0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02f0500(lo)
IPv6 over IPv4 tunneling driver
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Pavel Roskin <p=
roski-mXXj517/zsQ@public.gmane.org>, et al)
orinoco_cs 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Pavel Roskin=
 <proski-mXXj517/zsQ@public.gmane.org>, et al)
eth1: Station identity 001f:0001:0007:001c
eth1: Looks like a Lucent/Agere firmware version 7.28
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:51:AA:02
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth1: New link status: Connected (0001)
acpi-cpufreq: CPU0 - ACPI performance management activated.
eth1: no IPv6 routers present

------=_Part_10881_7458568.1121168189230--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
