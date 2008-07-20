From: "Edwin Helbert Aponte Angarita" <helbert2a@gmail.com>
Subject: Fwd: Please send dmidecode to linux-acpi@vger.kernel.org
Date: Sun, 20 Jul 2008 18:24:19 -0500
Message-ID: <3c8ae0f40807201624t1dfd0180h9d3a3a9a79223dd6@mail.gmail.com>
References: <3c8ae0f40807200749n3a31b7fcm7403da8ff4a03644@mail.gmail.com>
	 <3c8ae0f40807200754v31358623gafc9d33eb2897c2@mail.gmail.com>
	 <3c8ae0f40807201616l5da8d16bu29a08a1870f62c7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:3203 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbYGTXYU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jul 2008 19:24:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1124368rvb.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Jul 2008 16:24:19 -0700 (PDT)
In-Reply-To: <3c8ae0f40807201616l5da8d16bu29a08a1870f62c7c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, I send this e-mail because my openSUSE10.3, kernel
2.6.22.18-0.2-default detect only one core of two that my intel T2400
processor has.

This is the output of dmidecode:

_____________________________________

# dmidecode 2.9
SMBIOS 2.31 present.
19 structures occupying 912 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: R0083N0
        Release Date: 07/10/2006
        Address: 0xE4580
        Runtime Size: 113280 bytes
        ROM Size: 1024 kB
        Characteristics:
                PCI is supported
                PC Card (PCMCIA) is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                8042 keyboard services are supported (int 9h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                Smart battery is supported
                BIOS boot specification is supported
                Function key-initiated network boot is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
        Manufacturer: Sony Corporation
        Product Name: VGN-SZ240F
        Version: J001LQMY
        Serial Number: 28244243-3001532
        UUID: CD3B3360-5B3C-11D9-80ED-0013A92B8453
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 10 bytes
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
        Serial Number: J001LQMY
        Asset Tag:
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000009

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: N/A
        Type: Central Processor
        Family: Other
        Manufacturer: GenuineIntel
        ID: E8 06 00 00 FF FB E9 BF
        Version: Genuine Intel(R) CPU           T2400  @ 1.83GHz
        Voltage: 1.4 V
        External Clock: 166 MHz
        Max Speed: 1833 MHz
        Current Speed: 1833 MHz
        Status: Populated, Enabled
        Upgrade: None
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: 0x0007
        Serial Number: N/A
        Asset Tag: N/A
        Part Number: N/A

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
        Error Correction Type: None
        System Type: Other
        Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 2048 KB
        Maximum Size: 2048 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: None
        System Type: Data
        Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L3 Cache
        Configuration: Disabled, Not Socketed, Level 3
        Operational Mode: Unknown
        Location: Unknown
        Installed Size: 0 KB
        Maximum Size: 0 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: None
        System Type: Data
        Associativity: 4-way Set-associative

Handle 0x0008, DMI type 9, 13 bytes
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

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
        String 1: UCG414XSPM
        String 2: FNC-CCIA0okeHDPW
        String 3: 6LQP00000000900910174c398bff
        String 4: Reserved
        String 5: Reserved

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: Unknown
        Maximum Capacity: 2048 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000B, DMI type 17, 21 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: Not Provided
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: None
        Locator: SODIMM1
        Bank Locator: Bank 0
        Type: DDR
        Type Detail: Unknown

Handle 0x000C, DMI type 17, 21 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: Not Provided
        Total Width: 32 bits
        Data Width: 32 bits
        Size: 512 MB
        Form Factor: SODIMM
        Set: None
        Locator: SODIMM2
        Bank Locator: Bank 1
        Type: DDR
        Type Detail: Unknown

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x000A
        Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x000B
        Memory Array Mapped Address Handle: 0x000D
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00020000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x000C
        Memory Array Mapped Address Handle: 0x000D
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
        Status: No errors detected

Handle 0x0011, DMI type 136, 6 bytes
OEM-specific Type
        Header and Data:
                88 06 11 00 5A 5A

Handle 0x0012, DMI type 127, 4 bytes
End Of Table

_______________________________________________


This information can be useful, I think. Part of dmesg (normal boot):

______________________________________________

Linux version 2.6.22.18-0.2-default (geeko@buildhost) (gcc version
4.2.1 (SUSE Linux)) #1 SMP 2008-06-09 13:53:20 +0200
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe70000 (usable)
 BIOS-e820: 000000003fe70000 - 000000003fe7e000 (ACPI data)
 BIOS-e820: 000000003fe7e000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6480
Entering add_active_range(0, 0, 261744) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261744
early_node_map[1] active PFN ranges
    0:        0 ->   261744
On node 0 totalpages: 261744
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 252 pages used for memmap
  HighMem zone: 32116 pages, LIFO batch:7
DMI present.
Using APIC driver default
ACPI: RSDP 000F63B0, 0014 (r0 PTLTD )
ACPI: RSDT 3FE765D7, 0050 (r1   Sony       N0 20060710 PTL         0)
ACPI: FACP 3FE7DDDE, 0084 (r2   Sony       N0 20060710 PTL        5A)
ACPI: DSDT 3FE77E33, 5FAB (r1   Sony       N0 20060710 PTL   100000E)
ACPI: FACS 3FE7EFC0, 0040
ACPI: APIC 3FE7DE62, 0068 (r1   Sony       N0 20060710 PTL        5A)
ACPI: BOOT 3FE7DFD8, 0028 (r1   Sony       N0 20060710 PTL         1)
ACPI: MCFG 3FE7DF02, 003C (r1   Sony       N0 20060710 PTL        5A)
ACPI: TCPA 3FE7DF3E, 0032 (r1   Sony       N0 20060710 PTL      5A52)
ACPI: APIC 3FE7DF70, 0068 (r1   Sony       N0 20060710 PTL         0)
ACPI: SSDT 3FE776B1, 077E (r1   Sony       N0 20060710 PTL  20050624)
ACPI: SSDT 3FE76EE6, 07CB (r1   Sony       N0 20060710 PTL  20050624)
ACPI: SSDT 3FE76D3E, 01A8 (r1   Sony       N0 20060710 PTL  20050624)
ACPI: SSDT 3FE76B09, 0235 (r1   Sony       N0 20060710 PTL  20050624)
ACPI: SSDT 3FE76627, 04E2 (r1   Sony       N0 20060710 PTL  20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists.  Total pages: 259700
Kernel command line:
root=/dev/disk/by-id/scsi-SATA_ST9100824AS_3PL0J99S-part7 vga=0x317
resume=/dev/sda6 splash=silent
bootsplash: silent mode.
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1833.493 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1029780k/1046976k available (1829k kernel code, 16448k
reserved, 764k data, 228k init, 129472k highmem)
virtual kernel memory layout:
    fixmap  : 0xffdf4000 - 0xfffff000   (2092 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0390000 - 0xc03c9000   ( 228 kB)
      .data : 0xc02c969b - 0xc0388964   ( 764 kB)
      .text : 0xc0100000 - 0xc02c969b   (1829 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3671.29 BogoMIPS (lpj=7342586)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000
0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940
0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
Unpacking initramfs... done
Freeing initrd memory: 4045k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 923 Objects with 104 Devices 193 Methods 29 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 13 Objects with 3 Devices 4 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 14 Objects with 3 Devices 5 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 5 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 1 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0006) - 13 Objects with 0 Devices 4 Methods 0 Regions
 tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Total of 1 processors activated (3671.29 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 5
Runtime GPEs in this block
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package
initialization:...................................
Initialized 28/29 Regions 4/4 Fields 28/29 Buffers 13/40 Packages (978 nodes)
Initializing Device/Processor/Thermal objects by executing _INI
methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
...

______________________________________________

I check with different boots.

Normal boot.

      Wireless disabled

            Only one core is detected

            Sound OK

            Battery AC/DC state information OK

      Wireless enabled

            Only one core is detected

            Sound OK

            Internet wireless OK.

            Battery AC/DC state information OK

acpi_osi=!Linux boot.

      Wireless disabled

            Only one core is detected

            Sound OK

            Battery AC/DC state information Fail

      Wireless enabled

            Only one core is detected

            Sound OK

            Internet wireless OK.

            Battery AC/DC state information Fail

acpi_apic_instance=2 acpi_osi=!Linux boot.

      Wireless enabled

            Two core is detected, but one is disabled. See
http://i34.tinypic.com/do58gz.jpg

            Sound OK

            Internet wireless OK.
