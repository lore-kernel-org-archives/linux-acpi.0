From: Zbyszek Szmek <zbyszek@in.waw.pl>
Subject: dmidecode of Acer Travelmate 5520 with Turion 64 x2
Date: Fri, 20 Jul 2007 13:44:48 +0200
Message-ID: <20070720114448.GA25463@szyszka.in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cwm83.internetdsl.tpnet.pl ([83.19.120.83]:2107 "EHLO
	szyszka.in.waw.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761895AbXGTMD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jul 2007 08:03:28 -0400
Received: from zbyszek by szyszka.in.waw.pl with local (Exim 4.67)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1IBque-0006fo-Oh
	for linux-acpi@vger.kernel.org; Fri, 20 Jul 2007 13:44:48 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi. 
Upon booting 2.6.22.* the kernel says:  
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

Here it is:
------------------------------------------------------------
# dmidecode 2.9
SMBIOS 2.4 present.
37 structures occupying 1255 bytes.
Table at 0x37EE3000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: V1.04
	Release Date: 05/15/2007
	Address: 0xE3E80
	Runtime Size: 115072 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer
	Product Name: TravelMate 5520
	Version: 0100           
	Serial Number: LXTKT0X03472505E342000
	UUID: 92832300-1FE7-11DC-AD33-93244F26716C
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer
	Product Name: TravelMate 5520
	Version: Rev            
	Serial Number: LXTKT0X03472505E342000

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Acer                                
	Type: Other
	Lock: Not Present
	Version: None           
	Serial Number: None           
	Asset Tag: None                            
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket M2/S1G1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 81 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 104, Stepping 1
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
		HTT (Hyper-threading technology)
	Version: Engineering Samplenology
	Voltage: 1.4 V
	External Clock: 200 MHz
	Max Speed: 4000 MHz
	Current Speed: 1700 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
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
	Socket Designation: H0 L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J28
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J28
	Internal Connector Type: None
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J28
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J33
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J33
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J31
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J32
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J32
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J31
	Internal Connector Type: None
	External Reference Designator: USB 4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Microphone In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Speaker Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0013, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0014, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0015, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI3
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0016, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Disabled
	Description: ATI RS690M

Handle 0x0017, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: ESS 1869

Handle 0x0018, DMI type 11, 5 bytes
OEM Strings
	String 1: AMD New Processor Technology
	String 2: www.amd.com
	String 3: Have a nice day :)

Handle 0x0019, DMI type 12, 5 bytes
System Configuration Options
	Option 1: J13 1-2 Normal Operation, 2-3 Clear CMOS

Handle 0x001A, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x001B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x001C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: No Error
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 1
	Locator: S1
	Bank Locator: DIMM1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: No Error
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 2
	Locator: S2
	Bank Locator: DIMM2
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001E, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x001F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x001B
	Partition Width: 0

Handle 0x0020, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001C
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 6

Handle 0x0021, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0022, DMI type 129, 32 bytes
OEM-specific Type
	Header and Data:
		81 20 22 00 01 01 02 01 00 00 10 01 05 01 00 01
		00 00 18 01 00 00 20 01 06 02 00 01 00 00 28 01
	Strings:
		AMD_ASF_020
		Herring_690

Handle 0x0023, DMI type 200, 7 bytes
OEM-specific Type
	Header and Data:
		C8 07 23 00 01 02 03
	Strings:
		17C0
		             
		0001

Handle 0x0024, DMI type 127, 4 bytes
End Of Table
------------------------------------------------------------
Information given by dmidecode is mostly correct. I only noticed the
following discrepancies: 
1. Handle 0x0007, COM A -> not present
2. Handle 0x0008, parport -> not present
3. Handle 0x000A, circular DIN-8 male keyboard connector -> not present
4. Handle 0x000B, circular DIN-8 male mouse connector -> not present
5? Processor is a Turion, while dmidecode shows 'Family: Opteron'

In particular memory type, amount, cache size, CPU speed are correct.

As far as I can tell, it behaves exactly the same with acpi_osi=!Linux
and without.  

Unfortunately, loading any acpi modules causes the system to hang.
When I do: modprobe thermal (or video or button or ...), modprobe
never exits. If I don't load those modules, everything works well,
aparat from some minor glitches: for example, it sometimes hangs on reboot.

If acpi is not modular, but built-in, the system hangs on boot.

dmesg after modprobing battery:
------------------------------------------------------------
Linux version 2.6.22-git10-2 (zbyszek@nowyacer) (gcc version 4.2.1 20070712 (prerelease) (Debian 4.2-20070712-1)) #2 SMP PREEMPT Fri Jul 20 00:29:54 CEST 2007
Command line: root=/dev/mapper/System-root64_crypt ro resume=/dev/mapper/System-swap vga=ext 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037e80000 (usable)
 BIOS-e820: 0000000037e80000 - 0000000037e94000 (ACPI data)
 BIOS-e820: 0000000037e94000 - 0000000037e95000 (ACPI NVS)
 BIOS-e820: 0000000037e95000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 157) 0 entries of 256 used
Entering add_active_range(0, 256, 228992) 1 entries of 256 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP 000F8480, 0024 (r2 PTLTD )
ACPI: XSDT 37E8A377, 005C (r1 ACRSYS ACRPRDCT  6040000 INNA        0)
ACPI: FACP 37E93A33, 00F4 (r3 ATI    Herring   6040000 ATI     F4240)
ACPI: DSDT 37E8A3D3, 9660 (r1    ATI    SB600  6040000 MSFT  100000E)
ACPI: FACS 37E94FC0, 0040
ACPI: SLIC 37E93B9B, 0176 (r1 ACRSYS ACRPRDCT  6040000 ANNI        1)
ACPI: SSDT 37E93D11, 01C4 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ACPI: ASF! 37E93ED5, 0063 (r32    DMA AMDTBL    6040000 PTL         1)
ACPI: APIC 37E93F38, 0054 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: MCFG 37E93F8C, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ACPI: HPET 37E93FC8, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
Entering add_active_range(0, 0, 157) 0 entries of 256 used
Entering add_active_range(0, 256, 228992) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      157
    0:      256 ->   228992
On node 0 totalpages: 228893
  DMA zone: 56 pages used for memmap
  DMA zone: 903 pages reserved
  DMA zone: 3038 pages, LIFO batch:0
  DMA32 zone: 3074 pages used for memmap
  DMA32 zone: 221822 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x43538301 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 30216 bytes of per cpu data
Built 1 zonelists in Zone order.  Total pages: 224860
Kernel command line: root=/dev/mapper/System-root64_crypt ro resume=/dev/mapper/System-swap vga=ext 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1695.755 MHz processor.
Console: colour VGA+ 80x50
console [tty0] enabled
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|  ok  |failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |  ok  |             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
142 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 891224k/915968k available (2033k kernel code, 24152k reserved, 778k data, 184k init)
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 3466.88 BogoMIPS (lpj=6933775)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 1087 Objects with 70 Devices 293 Methods 40 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 8 Objects with 0 Devices 0 Methods 0 Regions
 tbxface-0587 [02] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [02] enable                : Transition to ACPI mode successful
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 12468782
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3391.57 BogoMIPS (lpj=6783151)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual-Core Processor TK-53 stepping 01
Brought up 2 CPUs
khelper used greatest stack depth: 6600 bytes left
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - e0dfffff
PCI: No mmconfig possible on device 00:18
khelper used greatest stack depth: 6240 bytes left
evgpeblk-0952 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 5 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...........................................................................................................
Initialized 40/40 Regions 10/10 Fields 37/37 Buffers 20/35 Packages (1104 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
..
Executed 2 _INI methods requiring 0 _STA executions (examined 76 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI Error (psargs-0355): [^OSTB] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0.EC0_._REG] (Node ffff810001dee4a0), AE_NOT_FOUND
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB4_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB5_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
ACPI Error (evgpe-0705): No handler or method for GPE[ 3], disabling event [20070126]
ACPI Error (evgpe-0705): No handler or method for GPE[ 3], disabling event [20070126]
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 32-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:06: ioport range 0x1080-0x1080 has been reserved
pnp: 00:06: ioport range 0x220-0x22f has been reserved
pnp: 00:06: ioport range 0x40b-0x40b has been reserved
pnp: 00:06: iomem range 0xff800000-0xffefffff has been reserved
pnp: 00:07: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:07: iomem range 0xfff00000-0xffffffff could not be reserved
pnp: 00:07: iomem range 0x0-0x0 could not be reserved
Time: hpet clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: f8000000-f81fffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:04.0
  IO window: a000-afff
  MEM window: f8200000-f82fffff
  PREFETCH window: 54000000-540fffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: f8300000-f83fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 12, cardbus bridge: 0000:0b:06.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 50000000-53ffffff
  MEM window: 58000000-5bffffff
PCI: Bridge: 0000:00:14.4
  IO window: 2000-2fff
  MEM window: f8400000-f84fffff
  PREFETCH window: 50000000-53ffffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI Interrupt 0000:0b:06.0[A] -> GSI 20 (level, low) -> IRQ 20
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 6304k freed
Initializing RT-Tester: OK
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler cfq registered (default)
Boot video device is 0000:01:05.0
PCI: Setting latency timer of device 0000:00:04.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie03]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie02]
Allocate Port Service[0000:00:06.0:pcie03]
hpet_resources: 0xfed00000 is busy
ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFF0 [20070126]
PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
TCP cubic registered
Freeing unused kernel memory: 184k freed
Write protecting the kernel read-only data: 588k
busybox used greatest stack depth: 6208 bytes left
exe used greatest stack depth: 6144 bytes left
exe used greatest stack depth: 6064 bytes left
framebuffer used greatest stack depth: 5936 bytes left
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
SCSI subsystem initialized
libata version 2.21 loaded.
ahci 0000:00:12.0: version 2.3
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq ilck pm led clo pmp pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc2000001c100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata2: SATA max UDMA/133 cmd 0xffffc2000001c180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata3: SATA max UDMA/133 cmd 0xffffc2000001c200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata4: SATA max UDMA/133 cmd 0xffffc2000001c280 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Hitachi HTS541612J9SA00, SBDOC70P, max UDMA/100
ata1.00: 234441648 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SBDO PQ: 0 ANSI: 5
modprobe used greatest stack depth: 4928 bytes left
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
modprobe used greatest stack depth: 4528 bytes left
NET: Registered protocol family 1
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
modprobe used greatest stack depth: 4224 bytes left
sed used greatest stack depth: 4048 bytes left
udevd used greatest stack depth: 3648 bytes left
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Yenta: CardBus bridge found at 0000:0b:06.0 [1025:0124]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0cb8, PCI irq 20
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
pcmcia: parent PCI bridge Memory window: 0xf8400000 - 0xf84fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
Real Time Clock Driver v1.12ac
ieee80211_crypt: registered algorithm 'NULL'
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 0000:02:00.0: v1.16 addr 0xf8200000 irq 16 Yukon-Extreme (0xb5) rev 2
sky2 eth0: addr 00:16:d3:59:3a:be
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xf8704000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: PC Speaker as /devices/platform/pcspkr/input/input1
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xf8705000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.2: irq 18, io mem 0xf8706000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.3: irq 17, io mem 0xf8707000
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Synaptics Touchpad, model: 1, fw: 6.3, id: 0x12a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input2
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.4: irq 18, io mem 0xf8708000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xf8709400
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 10 ports detected
pnp: Device 00:0a activated.
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: Supports SIR Mode only
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
ACPI: PCI Interrupt 0000:0b:06.4[A] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[f8402000-f84027ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:0b:06.2 [1217:7120] (rev 2)
ACPI: PCI Interrupt 0000:0b:06.2[A] -> GSI 20 (level, low) -> IRQ 20
sdhci:slot0: Unknown controller version (2). You may experience problems.
mmc0: SDHCI at 0xf8403800 irq 20 DMA
mmc0: Unexpected interrupt 0x00008000.
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x0000c002
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x000001aa | Trn mode: 0x00000000
sdhci: Present:  0x01ff0000 | Host ctl: 0x00000001
sdhci: Power:    0x0000000f | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x03c132b2 | Max curr: 0x00ffffff
sdhci: ===========================================
mmc0: Unexpected interrupt 0x00008000.
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x0000c002
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x000001aa | Trn mode: 0x00000000
sdhci: Present:  0x01ff0000 | Host ctl: 0x00000001
sdhci: Power:    0x0000000d | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x03c132b2 | Max curr: 0x00ffffff
sdhci: ===========================================
usb 6-7: new high speed USB device using ehci_hcd and address 2
mice: PS/2 mouse device common for all mice
usb 6-7: configuration #1 chosen from 1 choice
mmcblk0: mmc0:8757 SD032 29888KiB 
 mmcblk0: p1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40721601d4a]
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:14.1 to 64
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_intel.c:698: codec_mask = 0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_intel.c:1689: hda-intel: no codecs found!
ACPI: PCI interrupt for device 0000:00:14.1 disabled
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
Linux video capture interface: v2.00
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_intel.c:698: codec_mask = 0x3
bcm43xx driver
uvcvideo: Found UVC 1.00 device Acer CrystalEye webcam (064e:a101)
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:610: AUD_IN = 7
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:232: UNMUTE IN: NID=0x7 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:232: UNMUTE IN: NID=0x18 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:250: CONNECT: NID=0x24 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:232: UNMUTE IN: NID=0x24 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:216: UNMUTE OUT: NID=0x24
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:647: [Capture Source] NID=0x7, #SRC=1
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:650:   [Front Mic] IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:288: AUD_OUT found 3
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:250: CONNECT: NID=0x10 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:232: UNMUTE IN: NID=0x10 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:216: UNMUTE OUT: NID=0x10
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:232: UNMUTE IN: NID=0x15 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:216: UNMUTE OUT: NID=0x15
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:216: UNMUTE OUT: NID=0x15
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:288: AUD_OUT found 2
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:250: CONNECT: NID=0x7 IDX=0x0
ALSA /home/zbyszek/linuxx/26git/sound/pci/hda/hda_generic.c:732: [Master Playback Volume] NID=0x3, DIR=OUT
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:05:00.0 to 64
bcm43xx: Chip ID 0x4311, rev 0x1
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
bcm43xx: PHY connected
bcm43xx: Detected PHY: Analog: 4, Type 2, Revision 8
bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
EXT3 FS on dm-2, internal journal
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
NTFS driver 2.1.28 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs warning (device sda2): load_system_files(): Unsupported volume flags 0x4000 encountered.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
rc used greatest stack depth: 3376 bytes left
sky2 eth0: enabling interface
sky2 eth0: ram buffer 0K
NET: Registered protocol family 17
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control rx
NET: Registered protocol family 10
eth0: no IPv6 routers present
WARNING: at /home/zbyszek/linuxx/26git/kernel/mutex.c:132 __mutex_lock_common()

Call Trace:
 [<ffffffff803f8153>] __mutex_lock_slowpath+0x263/0x2d0
 [<ffffffff803f99dc>] _spin_unlock_irqrestore+0x3c/0x50
 [<ffffffff803f81c9>] mutex_lock+0x9/0x10
 [<ffffffff8034b899>] acpi_ec_transaction+0x70/0x1f5
 [<ffffffff8034bb8c>] acpi_ec_read+0x34/0x40
 [<ffffffff8034bc29>] acpi_ec_space_handler+0x91/0x11e
 [<ffffffff80343d3b>] acpi_ut_exit+0x31/0x39
 [<ffffffff8034bb98>] acpi_ec_space_handler+0x0/0x11e
 [<ffffffff80327d78>] acpi_ev_address_space_dispatch+0x23d/0x2a2
 [<ffffffff8034bb98>] acpi_ec_space_handler+0x0/0x11e
 [<ffffffff8032f3a1>] acpi_ex_access_region+0x372/0x428
 [<ffffffff8032f5c3>] acpi_ex_field_datum_io+0x16c/0x33e
 [<ffffffff80343ecc>] acpi_ut_trace+0x4f/0x5b
 [<ffffffff8032f867>] acpi_ex_extract_from_field+0xd2/0x244
 [<ffffffff8032d4da>] acpi_ex_read_data_from_field+0x298/0x2ea
 [<ffffffff8033617c>] acpi_ex_resolve_node_to_value+0x2e8/0x400
 [<ffffffff80343e6e>] acpi_ut_trace_ptr+0x5a/0x69
 [<ffffffff8032e4d1>] acpi_ex_resolve_to_value+0x391/0x414
 [<ffffffff80343d9c>] acpi_ut_trace_u32+0x59/0x68
 [<ffffffff8033149b>] acpi_ex_resolve_operands+0x3d9/0x8e2
 [<ffffffff80347d7b>] acpi_ut_delete_generic_state+0x57/0x5c
 [<ffffffff80322d30>] acpi_ds_exec_end_op+0x121/0x615
 [<ffffffff8033f05a>] acpi_ps_parse_loop+0xa4d/0xcf7
 [<ffffffff8033dbab>] acpi_ps_parse_aml+0x12b/0x3aa
 [<ffffffff8033fc94>] acpi_ps_execute_method+0x1df/0x2ff
 [<ffffffff8033a1eb>] acpi_ns_evaluate+0x1d7/0x2c8
 [<ffffffff8033991c>] acpi_evaluate_object+0x1e9/0x309
 [<ffffffff8028b05e>] kmem_cache_alloc+0x8e/0xb0
 [<ffffffff8031fce0>] acpi_evaluate_integer+0x9f/0x21a
 [<ffffffff802fa65a>] ida_get_new_above+0xaa/0x1d0
 [<ffffffff80349234>] acpi_bus_get_status+0x3d/0xcd
 [<ffffffff883d923c>] :battery:acpi_battery_check+0x3a/0x14e
 [<ffffffff883d952f>] :battery:acpi_battery_add+0x7a/0x1e1
 [<ffffffff8034a1fe>] acpi_device_probe+0x4e/0x10a
 [<ffffffff80370f91>] driver_probe_device+0xa1/0x1c0
 [<ffffffff80371190>] __driver_attach+0x0/0xb0
 [<ffffffff80371234>] __driver_attach+0xa4/0xb0
 [<ffffffff803701f3>] bus_for_each_dev+0x53/0x80
 [<ffffffff80370dcc>] driver_attach+0x1c/0x20
 [<ffffffff80370605>] bus_add_driver+0xa5/0x1e0
 [<ffffffff8037142d>] driver_register+0x4d/0x80
 [<ffffffff8034b570>] acpi_bus_register_driver+0x3e/0x42
 [<ffffffff8813702a>] :battery:acpi_battery_init+0x2a/0x45
 [<ffffffff8025c7e3>] sys_init_module+0x153/0x1970
 [<ffffffff8020c3de>] system_call+0x7e/0x83


thanks,
Zbyszek
