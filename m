From: Hamie <hamish-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Subject: acpi fan/thermal/processor information on Asus A8V-Deluxe
Date: Fri, 25 Feb 2005 12:15:54 +0000
Message-ID: <421F16FA.1050809@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi.

I have a new Asus A8V-Delux with bios 1.0.8 running debian with a debian 
2.6.9 kernel and an Athlon64 (put it in last night & haven't had a 
chance to update to a 64bit version of Linux yet).

But I can't get the fan or temps from acpi... There should be temps for 
the processor, and fans for chassis, power-supply and CPU... (At least 
Asus utils under windoze seem to be able to get that info, I'm assuming 
it's available somewhere via acpi as well).

The modules are loaded for fan, thermal, and it finds processor info 
(Via the processor module), but /proc/acpi looks like

damned:/proc/acpi# ls -lR
.:
total 0
dr-xr-xr-x  2 root root 0 Feb 25 12:13 ac_adapter
-rw-r--r--  1 root root 0 Feb 25 12:13 alarm
dr-xr-xr-x  2 root root 0 Feb 25 12:13 battery
dr-xr-xr-x  4 root root 0 Feb 25 12:13 button
-r--------  1 root root 0 Feb 25 12:13 dsdt
dr-xr-xr-x  2 root root 0 Feb 25 12:13 embedded_controller
-r--------  1 root root 0 Feb 25 11:59 event
-r--------  1 root root 0 Feb 25 12:13 fadt
dr-xr-xr-x  2 root root 0 Feb 25 12:13 fan
-r--r--r--  1 root root 0 Feb 25 12:13 info
dr-xr-xr-x  2 root root 0 Feb 25 12:13 power_resource
dr-xr-xr-x  3 root root 0 Feb 25 12:13 processor
-rw-r--r--  1 root root 0 Feb 25 12:13 sleep
dr-xr-xr-x  2 root root 0 Feb 25 12:13 thermal_zone
-rw-r--r--  1 root root 0 Feb 25 12:13 wakeup

./ac_adapter:
total 0

./battery:
total 0

./button:
total 0
dr-xr-xr-x  3 root root 0 Feb 25 12:13 power
dr-xr-xr-x  3 root root 0 Feb 25 12:13 sleep

./button/power:
total 0
dr-xr-xr-x  2 root root 0 Feb 25 12:13 PWRF

./button/power/PWRF:
total 0
-r--r--r--  1 root root 0 Feb 25 12:13 info

./button/sleep:
total 0
dr-xr-xr-x  2 root root 0 Feb 25 12:13 SLPB

./button/sleep/SLPB:
total 0
-r--r--r--  1 root root 0 Feb 25 12:13 info

./embedded_controller:
total 0

./fan:
total 0

./power_resource:
total 0

./processor:
total 0
dr-xr-xr-x  2 root root 0 Feb 25 12:13 CPU1

./processor/CPU1:
total 0
-r--r--r--  1 root root 0 Feb 25 12:13 info
-rw-r--r--  1 root root 0 Feb 25 12:13 limit
-r--r--r--  1 root root 0 Feb 25 12:13 power
-rw-r--r--  1 root root 0 Feb 25 12:13 throttling

./thermal_zone:
total 0
damned:/proc/acpi#

When it boots I get

Linux version 2.6.9-2-686-smp (dilinger-Fqwm7F1mg36yD7FgjP0RdOTW4wlIGRCZ@public.gmane.org) (gcc 
version 3.3.5 (Debian 1:3.3.5-5)) #1 SMP Sat Jan 8 13:48:57 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32688 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa810
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000427 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x10000427 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000427 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000427 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information


Don't see a lot of info relating to fans or temps there...  Grepping 
dmesg for ACPI reveals


damned:/proc/acpi# dmesg | grep ACPI
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa810
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000427 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x10000427 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000427 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000427 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices:
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 193
ACPI: Processor [CPU1] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]


and dmidecode gives the following (With what looks like fan entries in 
it to me).

# dmidecode 2.4
SMBIOS 2.3 present.
68 structures occupying 2208 bytes.
Table at 0x000F0530.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: American Megatrends Inc.
                Version: 1008.003
                Release Date: 10/27/2004
                Address: 0xF0000
                Runtime Size: 64 kB
                ROM Size: 512 kB
                Characteristics:
                        ISA is supported
                        PCI is supported
                        PNP is supported
                        APM is supported
                        BIOS is upgradeable
                        BIOS shadowing is allowed
                        ESCD support is available
                        Boot from CD is supported
                        Selectable boot is supported
                        BIOS ROM is socketed
                        EDD is supported
                        5.25"/1.2 MB floppy services are supported (int 13h)
                        3.5"/720 KB floppy services are supported (int 13h)
                        3.5"/2.88 MB floppy services are supported (int 13h)
                        Print screen service is supported (int 5h)
                        8042 keyboard services are supported (int 9h)
                        Serial services are supported (int 14h)
                        Printer services are supported (int 17h)
                        CGA/mono video services are supported (int 10h)
                        ACPI is supported
                        USB legacy is supported
                        AGP is supported
                        LS-120 boot is supported
                        ATAPI Zip drive boot is supported
                        BIOS boot specification is supported
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: To Be Filled By O.E.M.
                Product Name: To Be Filled By O.E.M.
                Version: To Be Filled By O.E.M.
                Serial Number: To Be Filled By O.E.M.
                UUID: A87E6DAA-E56E-D911-8BDC-1F82760BBD69
                Wake-up Type: PCI PME#
Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: ASUSTeK Computer Inc.
                Product Name: A8V Deluxe
                Version: Rev 1.xx
                Serial Number: MB-1234567890
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information
                Manufacturer: Chassis Manufacture
                Type: Desktop
                Lock: Present
                Version: Chassis Version
                Serial Number: Chassis Serial Number
                Asset Tag: Asset-1234567890
                Boot-up State: Safe
                Power Supply State: Safe
                Thermal State: Safe
                Security Status: None
                OEM Information: 0x00000001
Handle 0x0004
        DMI type 4, 35 bytes.
        Processor Information
                Socket Designation: Socket 939
                Type: Central Processor
                Family: Athlon 64
                Manufacturer: AMD             
                ID: F0 0F 01 00 FF FB 8B 07
                Signature: Extended Family 0, Extended Model 1, Stepping 0
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
                Version: AMD Athlon(tm) 64 Processor 
3200+                  
                Voltage: 1.5 V
                External Clock: 200 MHz
                Max Speed: 2400 MHz
                Current Speed: 2000 MHz
                Status: Populated, Enabled
                Upgrade: <OUT OF SPEC>
                L1 Cache Handle: 0x0005
                L2 Cache Handle: 0x0006
                L3 Cache Handle: Not Provided
                Serial Number: To Be Filled By O.E.M.
                Asset Tag: To Be Filled By O.E.M.
                Part Number: To Be Filled By O.E.M.
Handle 0x0005
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L1-Cache
                Configuration: Enabled, Not Socketed, Level 1
                Operational Mode: Varies With Memory Address
                Location: Internal
                Installed Size: 64 KB
                Maximum Size: 64 KB
                Supported SRAM Types:
                        Pipeline Burst
                Installed SRAM Type: Pipeline Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Data
                Associativity: 4-way Set-associative
Handle 0x0006
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L2-Cache
                Configuration: Enabled, Not Socketed, Level 2
                Operational Mode: Varies With Memory Address
                Location: Internal
                Installed Size: 512 KB
                Maximum Size: 512 KB
                Supported SRAM Types:
                        Pipeline Burst
                Installed SRAM Type: Pipeline Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Unified
                Associativity: 4-way Set-associative
Handle 0x0007
        DMI type 5, 20 bytes.
        Memory Controller Information
                Error Detecting Method: 64-bit ECC
                Error Correcting Capabilities:
                        None
                        Single-bit Error Correcting
                        Double-bit Error Correcting
                        Error Scrubbing
                Supported Interleave: One-way Interleave
                Current Interleave: One-way Interleave
                Maximum Memory Module Size: 1024 MB
                Maximum Total Memory Size: 2048 MB
                Supported Speeds:
                        70 ns
                        60 ns
                        50 ns
                Supported Memory Types:
                        ECC
                        SIMM
                        DIMM
                        SDRAM
                Memory Module Voltage: 2.9 V
                Associated Memory Slots: 2
                        0x0008
                        0x0009
                Enabled Error Correcting Capabilities:
                        None
                        Single-bit Error Correcting
                        Double-bit Error Correcting
                        Error Scrubbing
Handle 0x0008
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: DIMM0
                Bank Connections: 0 2
                Current Speed: Unknown
                Type: ECC DIMM
                Installed Size: 512 MB (Double-bank Connection)
                Enabled Size: 512 MB (Double-bank Connection)
                Error Status: OK
Handle 0x0009
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: DIMM1
                Bank Connections: 0 2
                Current Speed: Unknown
                Type: ECC DIMM
                Installed Size: 512 MB (Double-bank Connection)
                Enabled Size: 512 MB (Double-bank Connection)
                Error Status: OK
Handle 0x000A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PS/2 Mouse
                Internal Connector Type: None
                External Reference Designator: PS/2 Mouse
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x000B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PS/2 Keyboard
                Internal Connector Type: None
                External Reference Designator: PS/2 Keyboard
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x000C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB1
                Internal Connector Type: None
                External Reference Designator: USB1
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB2
                Internal Connector Type: None
                External Reference Designator: USB2
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB3
                Internal Connector Type: None
                External Reference Designator: USB3
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x000F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB4
                Internal Connector Type: None
                External Reference Designator: USB4
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0010
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB5
                Internal Connector Type: None
                External Reference Designator: USB5
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0011
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB6
                Internal Connector Type: None
                External Reference Designator: USB6
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0012
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB7
                Internal Connector Type: None
                External Reference Designator: USB7
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0013
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: USB8
                Internal Connector Type: None
                External Reference Designator: USB8
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: LPT1
                Internal Connector Type: None
                External Reference Designator: LPT 1
                External Connector Type: DB-25 male
                Port Type: Parallel Port ECP/EPP
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Mic In
                Internal Connector Type: None
                External Reference Designator: Audio Mic In
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0016
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Line In
                Internal Connector Type: None
                External Reference Designator: Audio Line In
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0017
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Line Out
                Internal Connector Type: None
                External Reference Designator: Audio Line Out
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0018
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Center
                Internal Connector Type: None
                External Reference Designator: Audio Center
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x0019
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Side Surround
                Internal Connector Type: None
                External Reference Designator: Audio Side surround
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x001A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Audio Back Surround
                Internal Connector Type: None
                External Reference Designator: Audio Back surround
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x001B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: LAN
                Internal Connector Type: None
                External Reference Designator: LAN
                External Connector Type: RJ-45
                Port Type: Network Port
Handle 0x001C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: COM 1
                Internal Connector Type: None
                External Reference Designator: COM 1
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x001D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: MIDI
                Internal Connector Type: None
                External Reference Designator: MIDI
                External Connector Type: DB-15 female
                Port Type: MIDI Port
Handle 0x001E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Joy Stick
                Internal Connector Type: None
                External Reference Designator: Joy Stick
                External Connector Type: DB-15 female
                Port Type: Joystick Port
Handle 0x001F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: COM 2
                Internal Connector Type: None
                External Reference Designator: COM 2
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x0020
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: FireWire 1
                Internal Connector Type: None
                External Reference Designator: FireWire 1
                External Connector Type: IEEE 1394
                Port Type: Firewire (IEEE P1394)
Handle 0x0021
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: FireWire 2
                Internal Connector Type: None
                External Reference Designator: FireWire 2
                External Connector Type: IEEE 1394
                Port Type: Firewire (IEEE P1394)
Handle 0x0022
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: AUX
                Internal Connector Type: On Board Sound Input From CD-ROM
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Audio Port
Handle 0x0023
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CD
                Internal Connector Type: On Board Sound Input From CD-ROM
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Audio Port
Handle 0x0024
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PRI_IDE
                Internal Connector Type: On Board IDE
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0025
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SEC_IDE
                Internal Connector Type: On Board IDE
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0026
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: FLOPPY
                Internal Connector Type: On Board Floppy
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0027
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CHA_FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0028
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CPU_FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0029
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: MAIN POWER
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CHASSIS
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: ATXPWR
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: FP_AUDIO
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA1
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA2
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x002F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PWR_FAN
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0030
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PRI_SATA
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0031
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SEC_SATA
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0032
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PRI_RAID
                Internal Connector Type: Other
                External Reference Designator: Not Specified
                External Connector Type: None
                Port Type: Other
Handle 0x0033
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: AGP
                Type: 32-bit AGP 8x
                Current Usage: In Use
                Length: Short
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0034
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI1
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 1
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0035
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI2
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 2
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0036
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI3
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 3
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0037
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI4
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 4
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0038
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI5
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 5
                Characteristics:
                        3.3 V is provided
                        Opening is shared
                        PME signal is supported
Handle 0x0039
        DMI type 10, 6 bytes.
        On Board Device Information
                Type: Video
                Status: Enabled
                Description:   To Be Filled By O.E.M.
Handle 0x003A
        DMI type 11, 5 bytes.
        OEM Strings
                String 1: To Be Filled By O.E.M.
                String 2: To Be Filled By O.E.M.
                String 3: To Be Filled By O.E.M.
                String 4: To Be Filled By O.E.M.
Handle 0x003B
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 3
                        en|US|iso8859-1
                        de|DE|iso8859-1
                        fr|FR|iso8859-1
                Currently Installed Language: en|US|iso8859-1
Handle 0x003C
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System Board Or Motherboard
                Use: System Memory
                Error Correction Type: None
                Maximum Capacity: 8 GB
                Error Information Handle: Not Provided
                Number Of Devices: 2
Handle 0x003D
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0003FFFFFFF
                Range Size: 1 GB
                Physical Array Handle: 0x003C
                Partition Width: 0
Handle 0x003E
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x003C
                Error Information Handle: Not Provided
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 MB
                Form Factor: DIMM
                Set: None
                Locator: DIMM0
                Bank Locator: BANK0
                Type: DDR
                Type Detail: Synchronous
                Speed: 400 MHz (2.5 ns)
                Manufacturer: Manufacturer0
                Serial Number: SerNum0
                Asset Tag: AssetTagNum0
                Part Number: PartNum0
Handle 0x003F
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0001FFFFFFF
                Range Size: 512 MB
                Physical Device Handle: 0x003E
                Memory Array Mapped Address Handle: 0x003D
                Partition Row Position: 1
Handle 0x0040
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x003C
                Error Information Handle: Not Provided
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 MB
                Form Factor: DIMM
                Set: None
                Locator: DIMM1
                Bank Locator: BANK1
                Type: DDR
                Type Detail: Synchronous
                Speed: 400 MHz (2.5 ns)
                Manufacturer: Manufacturer1
                Serial Number: SerNum1
                Asset Tag: AssetTagNum1
                Part Number: PartNum1
Handle 0x0041
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00020000000
                Ending Address: 0x0003FFFFFFF
                Range Size: 512 MB
                Physical Device Handle: 0x0040
                Memory Array Mapped Address Handle: 0x003D
                Partition Row Position: 1
Handle 0x0042
        DMI type 32, 20 bytes.
        System Boot Information
                Status: No errors detected
Handle 0x0043
        DMI type 127, 4 bytes.
        End Of Table


Anyone got any ideas? I've googled but the chaff is too dense to find 
anythign sensible... the acpi website doesn't mention the A8V at all... 
Is this an acpi problem or a motherboard/firmware problem?


TIA

Hamish.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
