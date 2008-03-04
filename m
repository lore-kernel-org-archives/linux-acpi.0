From: Dieter Bloms <dieter@bloms.de>
Subject: dmidecode from acer extensa 5220
Date: Tue, 4 Mar 2008 09:51:08 +0100
Message-ID: <20080304085108.GA4990@bloms.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mordac.selfhost.de ([82.98.82.6]:59269 "EHLO mordac.selfhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbYCDI5z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2008 03:57:55 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

my kernel say I should send the output of dmidecode to this address.
It is from a notebook acer extensa 5220 (there are different variants
=66rom this model).
I've one with a 1.86 MHz cpu.

If you need more information, let me know.

btw.: I installed an openSUSE10.3 system


--=20
Gru=DF

  Dieter

--
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
=46rom field.

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmidecode
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.9
SMBIOS 2.4 present.
28 structures occupying 1179 bytes.
Table at 0x1F6E0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: V1.31         =20
	Release Date: 01/17/2008
	Address: 0xE58D0
	Runtime Size: 108336 bytes
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
	Manufacturer: Acer          =20
	Product Name: Extensa 5220                  =20
	Version: 0100          =20
	Serial Number: LXE870C002746144B12000       =20
	UUID: 22F262A0-954C-11DC-B80C-F4C5983FC95A
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer          =20
	Product Name: Columbia                      =20
	Version: Rev           =20
	Serial Number: LXE870C002746144B12000       =20

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Acer          =20
	Type: Notebook
	Lock: Not Present
	Version: N/A           =20
	Serial Number: None          =20
	Asset Tag: None                           =20
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
	ID: 61 06 01 00 FF FB EB AF
	Version: CPU Version
	Voltage: 3.3 V
	External Clock: 133 MHz
	Max Speed: 1860 MHz
	Current Speed: 1860 MHz
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
	Current Usage: Available
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
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 533 MHz (1.9 ns)
	Manufacturer: Mfg 0
	Serial Number: 1234-B0
	Asset Tag: Not Specified
	Part Number: SODIMM000

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 533 MHz (1.9 ns)
	Manufacturer: Mfg 1
	Serial Number: 1234-B1
	Asset Tag: Not Specified
	Part Number: SODIMM001

Handle 0x0013, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Array Handle: 0x0010
	Partition Width: 0

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0001FFFFC00
	Ending Address: 0x0001FFFFFFF
	Range Size: 1 kB
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
		            =20
		0001

Handle 0x001B, DMI type 127, 4 bytes
End Of Table


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.msg"
Content-Transfer-Encoding: quoted-printable

Inspecting /boot/System.map-2.6.22.17-0.1-default
Loaded 26666 symbols from /boot/System.map-2.6.22.17-0.1-default.
Symbols match kernel version 2.6.22.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source =3D ksyslog started.
<5>Linux version 2.6.22.17-0.1-default (geeko@buildhost) (gcc version 4.2.1=
 (SUSE Linux)) #1 SMP 2008/02/10 20:01:04 UTC
<6>Command line: root=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07=
001091-part3 vga=3D0 resume=3D/dev/sda5 splash=3Dsilent
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001f6d0000 (usable)
<4> BIOS-e820: 000000001f6d0000 - 000000001f6e0000 (ACPI NVS)
<4> BIOS-e820: 000000001f6e0000 - 0000000020000000 (reserved)
<4> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
<4> BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
<4> BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
<7>Entering add_active_range(0, 0, 159) 0 entries of 3200 used
<7>Entering add_active_range(0, 256, 128720) 1 entries of 3200 used
<4>end_pfn_map =3D 1048576
<6>DMI present.
<4>ACPI: RSDP 000F7BF0, 0024 (r2 PTLTD )
<4>ACPI: XSDT 1F6D2929, 0094 (r1 ACRSYS ACRPRDCT  6040000 INNA        0)
<4>ACPI: FACP 1F6DCBE5, 00F4 (r3 INTEL  CRESTLNE  6040000 ALAN        1)
<4>ACPI: DSDT 1F6D3BC9, 8FA8 (r2 INTEL  CRESTLNE  6040000 MSFT  3000000)
<4>ACPI: FACS 1F6DFFC0, 0040
<4>ACPI: HPET 1F6DCCD9, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
<4>ACPI: MCFG 1F6DCD11, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
<4>ACPI: TCPA 1F6DCD4D, 0032 (r1 Intel   CRESTLN  6040000          5A52)
<4>ACPI: TMOR 1F6DCD7F, 0026 (r1 PTLTD            6040000 PTL         3)
<4>ACPI: SLIC 1F6DCDA5, 0176 (r1 ACRSYS ACRPRDCT  6040000 ANNI        1)
<4>ACPI: ASF! 1F6DCF1B, 0063 (r32 OEMID  OEMTBL    6040000 PTL         1)
<4>ACPI: APIC 1F6DCF7E, 005A (r1 PTLTD  	 APIC    6040000  LTP        0)
<4>ACPI: BOOT 1F6DCFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
<4>ACPI: SSDT 1F6D38EC, 02DD (r1 SataRe SataAhci     1000 INTL 20050624)
<4>ACPI: SSDT 1F6D3721, 01CB (r1 BrtRef  DD01BRT     1000 INTL 20050624)
<4>ACPI: SSDT 1F6D3102, 061F (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
<4>ACPI: SSDT 1F6D2EA3, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
<4>ACPI: SSDT 1F6D29BD, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
<6>No NUMA configuration found
<6>Faking a node at 0000000000000000-000000001f6d0000
<7>Entering add_active_range(0, 0, 159) 0 entries of 3200 used
<7>Entering add_active_range(0, 256, 128720) 1 entries of 3200 used
<6>Bootmem setup node 0 0000000000000000-000000001f6d0000
<4>Zone PFN ranges:
<4>  DMA             0 ->     4096
<4>  DMA32        4096 ->  1048576
<4>  Normal    1048576 ->  1048576
<4>early_node_map[2] active PFN ranges
<4>    0:        0 ->      159
<4>    0:      256 ->   128720
<7>On node 0 totalpages: 128623
<7>  DMA zone: 56 pages used for memmap
<7>  DMA zone: 1270 pages reserved
<7>  DMA zone: 2673 pages, LIFO batch:0
<7>  DMA32 zone: 1703 pages used for memmap
<7>  DMA32 zone: 122921 pages, LIFO batch:31
<7>  Normal zone: 0 pages used for memmap
<6>ACPI: PM-Timer IO Port: 0x1008
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<6>Processor #0 (Bootup-CPU)
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<6>Setting APIC routing to flat
<6>ACPI: HPET id: 0x8086a201 base: 0xfed00000
<6>Using ACPI (MADT) for SMP configuration information
<4>swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a=
0000
<4>swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e=
0000
<4>swsusp: Registered nosave memory region: 00000000000e0000 - 000000000010=
0000
<6>Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
<6>SMP: Allowing 1 CPUs, 0 hotplug CPUs
<6>PERCPU: Allocating 50296 bytes of per cpu data
<4>Built 1 zonelists.  Total pages: 125594
<5>Kernel command line: root=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD=
-WXEY07001091-part3 vga=3D0 resume=3D/dev/sda5 splash=3Dsilent
<6>bootsplash: silent mode.
<4>Initializing CPU#0
<4>PID hash table entries: 2048 (order: 11, 16384 bytes)
<6>Extended CMOS year: 2000
<4>Marking TSC unstable due to TSCs unsynchronized
<6>time.c: Detected 1862.208 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Checking aperture...
<7>Calgary: detecting Calgary via BIOS EBDA area
<7>Calgary: Unable to locate Rio Grande table in EBDA - bailing!
<4>Memory: 497796k/514880k available (2053k kernel code, 16696k reserved, 1=
017k data, 316k init)
<4>Calibrating delay using timer specific routine.. 3728.55 BogoMIPS (lpj=
=3D7457109)
<6>Security Framework v1.0.0 initialized
<4>Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 256
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 1024K
<6>CPU 0/0 -> Node 0
<4>using mwait in idle threads.
<7>CPU0: Thermal monitoring handled by SMI
<6>SMP alternatives: switching to UP code
<6>Freeing SMP alternatives: 24k freed
<6>Unpacking initramfs... done
<6>Freeing initrd memory: 4391k freed
<6>ACPI: Core revision 20070126
<4>Parsing all Control Methods:
<4>Table [DSDT](id 0001) - 1131 Objects with 83 Devices 261 Methods 36 Regi=
ons
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0002) - 15 Objects with 3 Devices 9 Methods 0 Regions
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0003) - 3 Objects with 0 Devices 3 Methods 0 Regions
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0004) - 2 Objects with 0 Devices 1 Methods 0 Regions
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0005) - 7 Objects with 0 Devices 3 Methods 0 Regions
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0006) - 13 Objects with 0 Devices 4 Methods 0 Regions
<4> tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acqu=
ired
<4>evxfevnt-0091 [00] enable                : Transition to ACPI mode succe=
ssful
<6>Using local APIC timer interrupts.
<4>result 8313415
<6>Detected 8.313 MHz APIC timer.
<6>Brought up 1 CPUs
<6>NET: Registered protocol family 16
<6>ACPI: bus type pci registered
<6>PCI: Using MMCONFIG at e0000000 - efffffff
<4>evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on=
 int 0x9
<4>evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 6 Wake, Enabled 6 Runti=
me GPEs in this block
<7>ACPI: EC: Look up EC in DSDT
<4>Completing Region/Field/Buffer/Package initialization:..................=
=2E.......................................................................
<4>Initialized 33/36 Regions 11/11 Fields 33/34 Buffers 13/21 Packages (118=
0 nodes)
<4>Initializing Device/Processor/Thermal objects by executing _INI methods:=
<4>ACPI: System BIOS is requesting _OSI(Linux)
<4>ACPI: Please test with "acpi_osi=3D!Linux"
<4>Please send dmidecode to linux-acpi@vger.kernel.org
<4>.
<4>Executed 1 _INI methods requiring 0 _STA executions (examined 92 objects)
<6>ACPI: Interpreter enabled
<6>ACPI: (supports S0 S3 S4 S5)
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>PCI: Probing PCI hardware (bus 00)
<4>PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
<4>PCI quirk: region 1180-11bf claimed by ICH6 GPIO
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>pnp: PnP ACPI init
<6>ACPI: bus type pnp registered
<6>pnp: PnP ACPI: found 10 devices
<6>ACPI: ACPI bus type pnp unregistered
<6>PCI: Using ACPI for IRQ routing
<6>PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post =
a report
<6>PCI-GART: No AMD northbridge found.
<6>hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
<6>hpet0: 3 64-bit timers, 14318180 Hz
<4>ACPI: RTC can wake from S4
<6>pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
<6>pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
<6>pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
<6>pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
<6>pnp: 00:06: iomem range 0xfed00000-0xfed003ff could not be reserved
<6>pnp: 00:08: iomem range 0xff800000-0xff800fff could not be reserved
<6>PCI: Bridge: 0000:00:1c.0
<6>  IO window: 2000-2fff
<6>  MEM window: f6000000-f7ffffff
<6>Time: hpet clocksource has been installed.
<6>  PREFETCH window: f0000000-f1ffffff
<6>PCI: Bridge: 0000:00:1c.1
<6>  IO window: 3000-3fff
<6>  MEM window: f8000000-f9ffffff
<6>  PREFETCH window: f2000000-f3ffffff
<6>PCI: Bridge: 0000:00:1c.2
<6>  IO window: 4000-4fff
<6>  MEM window: fa000000-fbffffff
<6>  PREFETCH window: f4000000-f5ffffff
<4>PCI: Bus 16, cardbus bridge: 0000:0f:06.0
<4>  IO window: 00001400-000014ff
<4>  IO window: 00005000-000050ff
<4>  PREFETCH window: 34000000-37ffffff
<4>  MEM window: 38000000-3bffffff
<6>PCI: Bridge: 0000:00:1e.0
<6>  IO window: disabled.
<6>  MEM window: fc200000-fc2fffff
<6>  PREFETCH window: disabled.
<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
<7>PCI: Setting latency timer of device 0000:00:1c.2 to 64
<7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>ACPI: PCI Interrupt 0000:0f:06.0[A] -> GSI 22 (level, low) -> IRQ 22
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>TCP established hash table entries: 16384 (order: 6, 393216 bytes)
<4>TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
<6>TCP: Hash tables configured (established 16384 bind 16384)
<6>TCP reno registered
<6>Simple Boot Flag at 0x36 set to 0x1
<6>audit: initializing netlink socket (disabled)
<5>audit(1204614595.920:1): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<7>Boot video device is 0000:00:02.0
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.0:pcie00]
<7>Allocate Port Service[0000:00:1c.0:pcie02]
<7>Allocate Port Service[0000:00:1c.0:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.1:pcie00]
<7>Allocate Port Service[0000:00:1c.1:pcie02]
<7>Allocate Port Service[0000:00:1c.1:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.2 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.2:pcie00]
<7>Allocate Port Service[0000:00:1c.2:pcie02]
<7>Allocate Port Service[0000:00:1c.2:pcie03]
<6>Real Time Clock Driver v1.12ac
<7>hpet_resources: 0xfed00000 is busy
<6>Non-volatile memory driver v1.2
<6>Linux agpgart interface v0.102 (c) Dave Jones
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
<6>PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker as /class/input/input0
<6>NET: Registered protocol family 1
<6>Freeing unused kernel memory: 316k freed
<7>Monitor-Mwait will be used to enter C-1 state
<7>Monitor-Mwait will be used to enter C-2 state
<6>ACPI: CPU0 (power states: C1[C1] C2[C2])
<4>ACPI Exception (processor_core-0789): AE_NOT_FOUND, Processor Device is =
not present [20070126]
<6>ACPI: Thermal Zone [TZS0] (58 C)
<6>ACPI: Thermal Zone [TZS1] (59 C)
<5>SCSI subsystem initialized
<7>libata version 3.00 loaded.
<7>ahci 0000:00:1f.2: version 3.0
<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
<6>Synaptics Touchpad, model: 1, fw: 6.3, id: 0x12a0b1, caps: 0xa04713/0x20=
4000
<6>input: SynPS/2 Synaptics TouchPad as /class/input/input1
<6>input: AT Translated Set 2 keyboard as /class/input/input2
<6>ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA =
mode
<6>ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part=20
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>scsi0 : ahci
<6>scsi1 : ahci
<6>scsi2 : ahci
<6>ata1: SATA max UDMA/133 cmd 0xffffc200101a6100 ctl 0x0000000000000000 bm=
dma 0x0000000000000000 irq 4348
<6>ata2: SATA max UDMA/133 cmd 0xffffc200101a6180 ctl 0x0000000000000000 bm=
dma 0x0000000000000000 irq 4348
<6>ata3: SATA max UDMA/133 cmd 0xffffc200101a6200 ctl 0x0000000000000000 bm=
dma 0x0000000000000000 irq 4348
<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<6>ata1.00: ATA-7: WDC WD800BEVS-22RST0, 04.01G04, max UDMA/133
<6>ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
<6>ata1.00: configured for UDMA/133
<6>ata2: SATA link down (SStatus 0 SControl 300)
<6>ata3: SATA link down (SStatus 0 SControl 300)
<5>scsi 0:0:0:0: Direct-Access     ATA      WDC WD800BEVS-22 04.0 PQ: 0 ANS=
I: 5
<7>ata_piix 0000:00:1f.1: version 2.11
<6>ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:00:1f.1 to 64
<6>scsi3 : ata_piix
<6>scsi4 : ata_piix
<6>ata4: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bm=
dma 0x0000000000011810 irq 14
<6>ata5: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bm=
dma 0x0000000000011818 irq 15
<6>ata4.00: ATAPI: TSSTcorp CDDVDW TS-L632H, AC01, max UDMA/33
<6>ata4.00: configured for UDMA/33
<5>scsi 3:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L632H  AC01 PQ: 0 ANS=
I: 5
<6>BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<6>USB Universal Host Controller Interface driver v3.0
<6>ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
<7>PCI: Setting latency timer of device 0000:00:1a.0 to 64
<6>uhci_hcd 0000:00:1a.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
<6>uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001820
<6>usb usb1: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb1: Product: UHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.22.17-0.1-default uhci_hcd
<6>usb usb1: SerialNumber: 0000:00:1a.0
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
<7>PCI: Setting latency timer of device 0000:00:1a.1 to 64
<6>uhci_hcd 0000:00:1a.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
<6>uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001840
<6>usb usb2: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb2: Product: UHCI Host Controller
<6>usb usb2: Manufacturer: Linux 2.6.22.17-0.1-default uhci_hcd
<6>usb usb2: SerialNumber: 0000:00:1a.1
<6>usb usb2: configuration #1 chosen from 1 choice
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<5>sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't sup=
port DPO or FUA
<5>sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't sup=
port DPO or FUA
<6> sda: sda1 sda2 sda3 sda4 <<6>ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI=
 23 (level, low) -> IRQ 23
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
<6>uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001860
<6>usb usb3: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb3: Product: UHCI Host Controller
<6>usb usb3: Manufacturer: Linux 2.6.22.17-0.1-default uhci_hcd
<6>usb usb3: SerialNumber: 0000:00:1d.0
<6>usb usb3: configuration #1 chosen from 1 choice
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<4> sda5 sda6 >
<5>sd 0:0:0:0: [sda] Attached SCSI disk
<6>ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
<6>uhci_hcd 0000:00:1d.1: irq 17, io base 0x00001880
<6>usb usb4: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb4: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb4: Product: UHCI Host Controller
<6>usb usb4: Manufacturer: Linux 2.6.22.17-0.1-default uhci_hcd
<6>usb usb4: SerialNumber: 0000:00:1d.1
<6>usb usb4: configuration #1 chosen from 1 choice
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
<6>uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018a0
<6>usb usb5: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb5: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb5: Product: UHCI Host Controller
<6>usb usb5: Manufacturer: Linux 2.6.22.17-0.1-default uhci_hcd
<6>usb usb5: SerialNumber: 0000:00:1d.2
<6>usb usb5: configuration #1 chosen from 1 choice
<6>hub 5-0:1.0: USB hub found
<6>hub 5-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 20 (level, low) -> IRQ 20
<7>PCI: Setting latency timer of device 0000:00:1a.7 to 64
<6>ehci_hcd 0000:00:1a.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
<6>ehci_hcd 0000:00:1a.7: debug port 1
<7>PCI: cache line size of 32 is not supported by device 0000:00:1a.7
<6>ehci_hcd 0000:00:1a.7: irq 20, io mem 0xfc504800
<6>ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb6: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb6: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb6: Product: EHCI Host Controller
<6>usb usb6: Manufacturer: Linux 2.6.22.17-0.1-default ehci_hcd
<6>usb usb6: SerialNumber: 0000:00:1a.7
<6>usb usb6: configuration #1 chosen from 1 choice
<6>hub 6-0:1.0: USB hub found
<6>hub 6-0:1.0: 4 ports detected
<6>ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
<6>ehci_hcd 0000:00:1d.7: debug port 1
<7>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
<6>ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc504c00
<6>ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb7: new device found, idVendor=3D0000, idProduct=3D0000
<6>usb usb7: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
<6>usb usb7: Product: EHCI Host Controller
<6>usb usb7: Manufacturer: Linux 2.6.22.17-0.1-default ehci_hcd
<6>usb usb7: SerialNumber: 0000:00:1d.7
<6>usb usb7: configuration #1 chosen from 1 choice
<6>hub 7-0:1.0: USB hub found
<6>hub 7-0:1.0: 6 ports detected
<4>swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
<4>swsusp: Basic memory bitmaps created
<4>swsusp: Basic memory bitmaps freed
<4>Attempting manual resume
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda3, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<5>scsi 3:0:0:0: Attached scsi generic sg1 type 5
<6>agpgart: Detected an Intel 965GM Chipset.
<6>agpgart: Detected 7676K stolen memory.
<6>agpgart: AGP aperture is 256M @ 0xd0000000
<7>ieee80211_crypt: registered algorithm 'NULL'
<6>ieee80211: 802.11 data/management/control stack, git-1.1.13
<6>ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.int=
el.com>
<6>input: Power Button (FF) as /class/input/input3
<6>ACPI: Power Button (FF) [PWRF]
<6>tg3.c:v3.77 (May 31, 2007)
<6>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:02:00.0 to 64
<6>input: Lid Switch as /class/input/input4
<6>eth0: Tigon3 [partno(BCM95787m) rev b002 PHY(5787)] (PCI Express) 10/100=
/1000Base-T Ethernet 00:1d:72:0c:fc:c7
<6>eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
<6>eth0: dma_rwctrl[76180000] dma_mask[64-bit]
<6>rtc_cmos 00:09: rtc core: registered rtc_cmos as rtc0
<4>rtc_cmos: probe of 00:09 failed with error -16
<6>ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level, low) -> IRQ 19
<6>ACPI: Lid Switch [LID0]
<6>input: Sleep Button (CM) as /class/input/input5
<6>ACPI: Sleep Button (CM) [SLPB]
<4>sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.20
<7>sr 3:0:0:0: Attached scsi CD-ROM sr0
<6>bcm43xx driver
<6>ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:04:00.0 to 64
<6>bcm43xx: Chip ID 0x4311, rev 0x1
<6>bcm43xx: Number of cores: 4
<6>bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
<6>bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
<6>bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
<6>bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
<6>bcm43xx: PHY connected
<6>bcm43xx: Detected PHY: Analog: 4, Type 2, Revision 8
<6>bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
<6>bcm43xx: Radio turned off
<6>bcm43xx: Radio turned off
<6>ACPI: PCI Interrupt 0000:0f:06.2[A] -> GSI 22 (level, low) -> IRQ 22
<6>ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
<7>PCI: Setting latency timer of device 0000:00:1b.0 to 64
<6>hda_codec: Unknown model for ALC268, trying auto-probe from BIOS...
<7>ALSA sound/pci/hda/hda_codec.c:2333: autoconfig: line_outs=3D1 (0x15/0x0=
/0x0/0x0/0x0)
<7>ALSA sound/pci/hda/hda_codec.c:2337:    speaker_outs=3D0 (0x0/0x0/0x0/0x=
0/0x0)
<7>ALSA sound/pci/hda/hda_codec.c:2341:    hp_outs=3D1 (0x14/0x0/0x0/0x0/0x=
0)
<7>ALSA sound/pci/hda/hda_codec.c:2349:    inputs: mic=3D0x19, fmic=3D0x18,=
 line=3D0x0, fline=3D0x1a, cd=3D0x0, aux=3D0x0
<6>sdhci: Secure Digital Host Controller Interface driver
<6>sdhci: Copyright(c) Pierre Ossman
<6>sdhci: SDHCI controller found at 0000:0f:06.3 [104c:803c] (rev 0)
<6>ACPI: PCI Interrupt 0000:0f:06.3[A] -> GSI 22 (level, low) -> IRQ 22
<6>mmc0: SDHCI at 0xfc206800 irq 22 PIO
<6>Yenta: CardBus bridge found at 0000:0f:06.0 [1025:011f]
<6>Yenta: Using CSCINT to route CSC interrupts to PCI
<6>Yenta: Routing CardBus interrupts to PCI
<6>Yenta TI: socket 0000:0f:06.0, mfunc 0x01aa1b22, devctl 0x64
<6>ACPI: AC Adapter [ADP1] (on-line)
<6>Yenta: ISA IRQ mask 0x0cf8, PCI irq 22
<6>Socket status: 30000006
<6>Yenta: Raising subordinate bus# of parent bus (#0f) from #10 to #13
<6>pcmcia: parent PCI bridge Memory window: 0xfc200000 - 0xfc2fffff
<6>ACPI: PCI Interrupt 0000:0f:06.1[A] -> GSI 22 (level, low) -> IRQ 22
<6>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[22]  MMIO=3D[fc206000-fc=
2067ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>Adding 1052216k swap on /dev/sda5.  Priority:-1 extents:1 across:1052216k
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001d72ffff0cfcc7]
<6>device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@re=
dhat.com
<6>loop: module loaded
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda6, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>AppArmor: AppArmor initialized
<5>audit(1204614606.684:2):  type=3D1505 info=3D"AppArmor initialized" pid=
=3D1961
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Tue Mar  4 07:09:55 2008

Creating device nodes with udev
Trying manual resume from /dev/sda5
Invoking userspace resume from /dev/sda5
boot/82-resume.userspace.sh: line 48: /proc/splash: No such file or directo=
ry
resume: Could not stat configuration file
resume: libgcrypt version: 1.2.4
Trying manual resume from /dev/sda5
Invoking in-kernel resume from /dev/sda5
Waiting for device /dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY0700109=
1-part3 to appear:  ok
fsck 1.40.2 (12-Jul-2007)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/disk/by-id/scsi-SATA_WDC_W=
D800BEVS-2_WD-WXEY07001091-part3=20
/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-part3: clean, 194=
853/1311552 files, 2120355/2622611 blocks
fsck succeeded. Mounting root device read-write.
Mounting root /dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-par=
t3

Boot logging started on /dev/tty1(/dev/console (deleted)) at Tue Mar  4 08:=
10:02 2008

<notice>boot.blktrace start
done
<notice>'boot.blktrace start' exits with status 0
<notice>boot.udev start
Starting udevd udevd-event[1786]: node_symlink: device node '/dev/rtc0' alr=
eady exists, link '/dev/rtc' will not overwrite it

done
<notice>'boot.udev start' exits with status 0
<notice>boot.rootfsck start
Activating swap-devices in /etc/fstab...
donemount: according to mtab, /dev/sda3 is already mounted on /

<notice>'boot.rootfsck start' exits with status 0
<notice>boot.loadmodules start
Loading required kernel modules
done<notice>'boot.loadmodules start' exits with status 0
<notice>boot.device-mapper start
Activating device mapper...
done
<notice>'boot.device-mapper start' exits with status 0
<notice>boot.localfs start
Checking file systems...
fsck 1.40.2 (12-Jul-2007)
/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-part6: clean, 127=
97/5968480 files, 2338470/11930262 blocks
donedone
Mounting local file systems...
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)
/dev/sda6 on /data type ext3 (rw,acl,user_xattr)
done<notice>'boot.localfs start' exits with status 0
<notice>boot.apparmor start
Mounting securityfs on /sys/kernel/security done
Loading AppArmor module done
Loading AppArmor profiles done
<notice>'boot.apparmor start' exits with status 0
<notice>boot.cleanup start
<notice>'boot.cleanup start' exits with status 0
<notice>boot.clock start
Setting up the hardware clockdone
<notice>'boot.clock start' exits with status 0
<notice>boot.cycle start
<notice>'boot.cycle start' exits with status 6
<notice>boot.klog start
Creating /var/log/boot.msg
done<notice>killproc: kill(1152,29)
<notice>'boot.klog start' exits with status 0
<notice>boot.proc start
<notice>'boot.proc start' exits with status 0
<notice>boot.scpm start
<notice>'boot.scpm start' exits with status 0
<notice>boot.swap start
Activating remaining swap-devices in /etc/fstab...
done<notice>'boot.swap start' exits with status 0
<notice>boot.udev_retry start
<notice>'boot.udev_retry start' exits with status 0
<notice>boot.videobios start
<notice>'boot.videobios start' exits with status 0
<notice>setserial start
Configuring serial ports...
Configured serial ports
done<notice>'setserial start' exits with status 0
<notice>boot.ldconfig start
<notice>'boot.ldconfig start' exits with status 0
<notice>boot.localnet start
Setting up hostname 'notebook'done
Setting up loopback interface     lo       =20
    lo        IP address: 127.0.0.1/8  =20
Checking for network time protocol daemon (NTPD): unused
Can't determine current runlevel
done
<notice>'boot.localnet start' exits with status 0
<notice>boot.sysctl start
Setting current sysctl status from /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts =3D 1
net.ipv4.conf.all.rp_filter =3D 1
fs.inotify.max_user_watches =3D 65536
done
<notice>'boot.sysctl start' exits with status 0
<notice>boot.ipconfig start
Enabling syn flood protectiondone
Disabling IP forwardingdone
done
<notice>'boot.ipconfig start' exits with status 0
System Boot Control: The system has been set up
Skipped features: boot.cycle
System Boot Control: Running /etc/init.d/boot.local
done<notice>killproc: kill(1152,3)

INIT: Entering runlevel: 5


<notice>
Boot logging started on /dev/tty1(/dev/console) at Tue Mar  4 08:10:12 2008

Master Resource Control: previous runlevel: N, switching to runlevel: 5
acpid start
Starting acpid <notice>startproc: execve (/sbin/acpid) [ /sbin/acpid ], [ C=
ONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TERM=3Dlinux ROO=
TFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDIRECT=3D/dev/tt=
y1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 RUNLEVEL=3D5 P=
WD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2 splash=3Dsi=
lent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_=
WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/sbin/acpid ]
acpid: starting up


done
<notice>'acpid start' exits with status 0
<notice>dbus start
Starting D-Bus daemonacpid: 2 rules loaded


Unknown username "gdm" in message bus configuration file
done
<notice>'dbus start' exits with status 0
<notice>earlysyslog start
Starting syslog services<notice>startproc: execve (/sbin/syslog-ng) [ /sbin=
/syslog-ng ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 TERM=3Dlinux SH=
ELL=3D/bin/sh ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 R=
EDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=
=3D0 RUNLEVEL=3D5 SPLASHCFG=3D PWD=3D/ PREVLEVEL=3DN LINES=3D25 SHLVL=3D2 H=
OME=3D/ SPLASH=3Dno splash=3Dsilent ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SA=
TA_WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/sbin=
/syslog-ng ]
=2E<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -x -x ], [ CO=
NSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 TERM=3Dlinux SHELL=3D/bin/sh ROOT=
FS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDIRECT=3D/dev/tty=
1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 RUNLEVEL=3D5 SP=
LASHCFG=3D PWD=3D/ PREVLEVEL=3DN LINES=3D25 SHLVL=3D2 HOME=3D/ SPLASH=3Dno =
splash=3Dsilent ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_W=
D-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/sbin/klogd ]
done
<notice>'earlysyslog start' exits with status 0
<notice>fbset start
<notice>'fbset start' exits with status 0
<notice>microcode.ctl start
Checking/updating CPU microcode done
<notice>'microcode.ctl start' exits with status 0
<notice>random start
Initializing random number generatordone
<notice>'random start' exits with status 0
<notice>resmgr start
Starting resource manager<notice>startproc: execve (/sbin/resmgrd) [ /sbin/=
resmgrd ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TE=
RM=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDI=
RECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 =
RUNLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=
=3D2 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_=
WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/sbin/re=
smgrd ]
done
<notice>'resmgr start' exits with status 0
<notice>consolekit start
Starting ConsoleKit<notice>startproc: execve (/usr/sbin/console-kit-daemon)=
 [ /usr/sbin/console-kit-daemon ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=
=3Dext3 SHELL=3D/bin/sh TERM=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VE=
RSION=3Dsysvinit-2.86 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/=
usr/bin:/usr/sbin vga=3D0 RUNLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN L=
INES=3D25 HOME=3D/ SHLVL=3D2 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/d=
ev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/sta=
rtproc DAEMON=3D/usr/sbin/console-kit-daemon ]
done
<notice>'consolekit start' exits with status 0
<notice>haldaemon start
Starting HAL daemon<notice>startproc: execve (/usr/sbin/hald) [ /usr/sbin/h=
ald --daemon=3Dyes ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=
=3D/bin/sh TERM=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvi=
nit-2.86 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/=
sbin vga=3D0 RUNLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOM=
E=3D/ SHLVL=3D2 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id=
/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=
=3D/usr/sbin/hald ]
done
Loading CPUFreq modules (CPUFreq not supported)
<notice>'haldaemon start' exits with status 0
<notice>earlyxdm start
Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kd=
e3/bin/kdm ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 TERM=3Dlinux SH=
ELL=3D/bin/sh ROOTFS_FSCK=3D0 INIT_VERSION=3Dsysvinit-2.86 KDEROOTHOME=3D/r=
oot/.kdm REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/=
sbin vga=3D0 RUNLEVEL=3D5 SPLASHCFG=3D PWD=3D/ LANG=3Dde_DE.UTF-8 PREVLEVEL=
=3DN LINES=3D25 QT_SYSTEM_DIR=3D/usr/share/desktop-data SHLVL=3D2 HOME=3D/ =
XCURSOR_THEME=3Dcrystalwhite WINDOWMANAGER=3D/usr/bin/kde SPLASH=3Dno splas=
h=3Dsilent ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXE=
Y07001091-part3 _=3D/sbin/startproc DAEMON=3D/opt/kde3/bin/kdm ]
done
<notice>'earlyxdm start' exits with status 0
<notice>network start
Setting up network interfaces:
    lo       =20
    lo        IP address: 127.0.0.1/8  =20
Checking for network time protocol daemon (NTPD): unused
done    eth0      device: Broadcom Corporation NetLink BCM5787M Gigabit Eth=
ernet PCI Express (rev 02)
    eth0      IP address: 192.168.253.10/24  =20
Checking for network time protocol daemon (NTPD): unused
done    eth1      device: Broadcom Corporation BCM94311MCG wlan mini-PCI (r=
ev 01)
    eth1      is controlled by ifplugd
doneSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .=
  .done
<notice>'network start' exits with status 0
<notice>syslog start
<notice>'syslog start' exits with status 0
<notice>auditd start
Starting auditd <notice>startproc: execve (/sbin/auditd) [ /sbin/auditd -s =
disable ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TE=
RM=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDI=
RECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 =
RUNLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=
=3D2 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_=
WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/sbin/au=
ditd ]
done
<notice>'auditd start' exits with status 0
<notice>splash_early start
<notice>'splash_early start' exits with status 0
<notice>wlan start
Starting wlan Setting up network interfaces:
    eth1      device: Broadcom Corporation BCM94311MCG wlan mini-PCI (rev 0=
1)
    eth1      is controlled by ifplugd
done    eth0      device: Broadcom Corporation NetLink BCM5787M Gigabit Eth=
ernet PCI Express (rev 02)
    eth0      IP address: 192.168.253.10/24
donedone
<notice>'wlan start' exits with status 0
<notice>alsasound start
<notice>'alsasound start' exits with status 0
<notice>cups start
Starting cupsd<notice>startproc: execve (/usr/sbin/cupsd) [ /usr/sbin/cupsd=
 ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TERM=3Dli=
nux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDIRECT=3D=
/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 RUNLEVE=
L=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2 spla=
sh=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_WD800=
BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/usr/sbin/cupsd ]
done
<notice>'cups start' exits with status 0
<notice>kbd start
Loading keymap i386/qwertz/de-latin1-nodeadkeys.map.gz
doneLoading compose table latin1.adddone
Start Unicode mode
doneLoading console font lat9w-16.psfu  -m trivial G0:loadable
done<notice>'kbd start' exits with status 0
<notice>powersaved start
<notice>checkproc: /opt/kde3/bin/kdm 2483
Starting powersaved: <notice>startproc: execve (/usr/sbin/powersaved) [ /us=
r/sbin/powersaved -d -f /var/run/acpid.socket -v 3 ], [ HOME=3D/ PATH=3D/bi=
n:/sbin:/usr/bin:/usr/sbin SHELL=3D/bin/sh RUNLEVEL=3D5 PREVLEVEL=3DN DAEMO=
N=3D/usr/sbin/powersaved ]
done
<notice>'powersaved start' exits with status 0
<notice>splash start
<notice>'splash start' exits with status 5
<notice>sshd start
Starting SSH daemon<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/s=
shd -o PidFile=3D/var/run/sshd.init.pid ], [ CONSOLE=3D/dev/console ROOTFS_=
FSTYPE=3Dext3 SHELL=3D/bin/sh TERM=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX I=
NIT_VERSION=3Dsysvinit-2.86 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/=
sbin:/usr/bin:/usr/sbin vga=3D0 RUNLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=
=3DN LINES=3D25 HOME=3D/ SHLVL=3D2 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDE=
V=3D/dev/disk/by-id/scsi-SATA_WDC_WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sb=
in/startproc DAEMON=3D/usr/sbin/sshd ]
done
<notice>'sshd start' exits with status 0
<notice>hotkey-setup start
Starting hotkey-setup done
<notice>'hotkey-setup start' exits with status 0
<notice>xdm start
<notice>checkproc: /opt/kde3/bin/kdm 2483
<notice>'xdm start' exits with status 0
<notice>cron start
Starting CRON daemon<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/=
cron ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TERM=
=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDIRE=
CT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 RU=
NLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2=
 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_=
WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/usr/sbin/cr=
on ]
done
<notice>'cron start' exits with status 0
<notice>smartd start
Starting smartd <notice>startproc: execve (/usr/sbin/smartd) [ /usr/sbin/sm=
artd ], [ CONSOLE=3D/dev/console ROOTFS_FSTYPE=3Dext3 SHELL=3D/bin/sh TERM=
=3Dlinux ROOTFS_FSCK=3D0 LC_ALL=3DPOSIX INIT_VERSION=3Dsysvinit-2.86 REDIRE=
CT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/bin:/sbin:/usr/bin:/usr/sbin vga=3D0 RU=
NLEVEL=3D5 PWD=3D/ SPLASHCFG=3D PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2=
 splash=3Dsilent SPLASH=3Dno ROOTFS_BLKDEV=3D/dev/disk/by-id/scsi-SATA_WDC_=
WD800BEVS-2_WD-WXEY07001091-part3 _=3D/sbin/startproc DAEMON=3D/usr/sbin/sm=
artd ]
done
<notice>'smartd start' exits with status 0
<notice>stopblktrace start
done
<notice>'stopblktrace start' exits with status 0
Master Resource Control: runlevel 5 has been reached
Skipped services in runlevel 5: splash
<notice>killproc: kill(2249,3)

--vtzGhvizbBRQ85DL--

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHzQ18+xZgAwaK6mMRAj1kAJ9DTVHIKnynDRAn12XsfSS77WhNgQCgwOlE
WrMyFEf3SYKcVc8tt0ggajw=
=YOyI
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
