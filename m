From: Christian Schneider <ch_schneider_hi-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
Subject: Error messages with kernel 2.4.26 and acpi20040326
Date: Mon, 31 May 2004 17:43:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405311743.52699.ch_schneider_hi@freenet.de>
Reply-To: ch_schneider_hi-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

I have just compiled the 2.4.26 kernel patched with acpi20040326 from
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release
/2.4.26/

My board is an ASUS P4PE. I get these error messages:

<4> psparse-1133: *** Error: Method execution failed \
[\_SB_.PCI0.USB0._PRW] (Node c163dd28), AE_NOT_EXIST
<4>  uteval-0154: *** Error: Method execution failed \
[\_SB_.PCI0.USB0._PRW] (Node c163dd28), AE_NOT_EXIST

(The whole ACPI messages at the bottom of this mail. ACPI is compiled
with debug statements.)

These messages seem to be similar to the errors in bug 2403 which is
reported to be fixed, but the release patch did not fix it and I was
unable to find any other patch.

Could you give me a hint what to do know, please?

Thanks in advance.

Regards,
Christian Schneider

P.S.: This is the interesting part from /var/log/boot.msg (sorry for the 
long
lines, but perhaps the messages can be read easilier this way):

Inspecting /boot/System.map-2.4.26-acpi
Loaded 19892 symbols from /boot/System.map-2.4.26-acpi.
Symbols match kernel version 2.4.26.
Loaded 150 symbols from 6 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.26-acpi (chsch-nFQdcaFh7/Y@public.gmane.org) (gcc-Version 3.3.1 (SuSE 
Linux)) #4 Mo Mai 31 15:38:19 CEST 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
<4> BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
<4> BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
<4> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>511MB LOWMEM available.
<4>On node 0 totalpages: 131052
<4>zone(0): 4096 pages.
<4>zone(1): 126956 pages.
<4>zone(2): 0 pages.
<6>ACPI: RSDP (v000 ASUS                                      ) @ 
0x000f5340
<6>ACPI: RSDT (v001 ASUS   P4PE     0x42302e31 MSFT 0x31313031) @ 
0x1ffec000
<6>ACPI: FADT (v001 ASUS   P4PE     0x42302e31 MSFT 0x31313031) @ 
0x1ffec0c0
<6>ACPI: BOOT (v001 ASUS   P4PE     0x42302e31 MSFT 0x31313031) @ 
0x1ffec030
<6>ACPI: MADT (v001 ASUS   P4PE     0x42302e31 MSFT 0x31313031) @ 
0x1ffec058
<6>ACPI: DSDT (v001   ASUS P4PE     0x00001000 MSFT 0x0100000b) @ 
0x00000000
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC[0]: Assigned apic_id 2
<4>IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
<6>Using ACPI (MADT) for SMP configuration information
<4>Kernel command line: root=/dev/hda6 vga=0x317 hdd=ide-scsi hddlun=0
<6>ide_setup: hdd=ide-scsi
<6>ide_setup: hddlun=0
<6>Initializing CPU#0
<4>Detected 2405.516 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 4797.23 BogoMIPS
<6>Memory: 514888k/524208k available (1710k kernel code, 8932k reserved, 
597k data, 140k init, 0k highmem)
<6>Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23 not connected.
<6>..TIMER: vector=0x31 pin1=0 pin2=-1
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
<6>...trying to set up timer as Virtual Wire IRQ... works.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2405.5518 MHz.
<4>..... host bus clock speed is 133.6417 MHz.
<4>cpu: 0, clocks: 1336417, slice: 668208
<4>CPU0<T0:1336416,T1:668208,D:0,S:668208,C:1336417>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
<4>mtrr: detected mtrr type: Intel
<6>ACPI: Subsystem revision 20040326
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1e50, last bus=2
<6>PCI: Using configuration type 1
<4> tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
<4>Parsing all Control 
Methods:...............................................................................................................................
<4>Table [DSDT](id F004) - 327 Objects with 47 Devices 127 Methods 8 
Regions
<4>ACPI Namespace successfully loaded at root c03824fc
<4>evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
<4>evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs 
at 000000000000E428 on int 9
<4>evregion-0251 [24] ev_address_space_dispa: No handler for Region 
[FSEG] (c161dc28) [SystemMemory]
<4> exfldio-0283 [23] ex_access_region      : Region SystemMemory(0) has 
no handler
<4> dswexec-0435 [16] ds_exec_end_op        : [Store]: Could not resolve 
operands, AE_NOT_EXIST
<4> psparse-1133: *** Error: Method execution failed 
[\_SB_.PCI0.USB0._PRW] (Node c163dd28), AE_NOT_EXIST
<4>  uteval-0154: *** Error: Method execution failed 
[\_SB_.PCI0.USB0._PRW] (Node c163dd28), AE_NOT_EXIST
<4>evgpeblk-0925 [06] ev_create_gpe_block   : Found 2 Wake, Enabled 4 
Runtime GPEs in this block
<4>Completing Region/Field/Buffer/Package 
initialization:..........................................
<4>Initialized 7/8 Regions 0/0 Fields 22/22 Buffers 13/13 Packages (336 
nodes)
<4>Executing all Device _STA and_INI 
methods:..................................................
<4>50 Devices found containing: 50 _STA, 1 _INI methods
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S1 S4 S5)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Enabled i801 SMBus device
<6>PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
<4>Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
<6>PCI: Probing PCI hardware
<7>00:00:1d[A] -> 2-16 -> IRQ 16 level low
<7>00:00:1d[B] -> 2-19 -> IRQ 19 level low
<7>00:00:1d[C] -> 2-18 -> IRQ 18 level low
<7>00:00:1d[D] -> 2-23 -> IRQ 23 level low
<7>00:00:1f[B] -> 2-17 -> IRQ 17 level low
<7>00:02:09[A] -> 2-21 -> IRQ 21 level low
<7>00:02:09[D] -> 2-20 -> IRQ 20 level low
<7>number of MP IRQ sources: 17.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 001 01  1    0    0   0   0    1    1    41
<7> 03 001 01  0    0    0   0   0    1    1    49
<7> 04 001 01  0    0    0   0   0    1    1    51
<7> 05 001 01  0    0    0   0   0    1    1    59
<7> 06 001 01  0    0    0   0   0    1    1    61
<7> 07 001 01  0    0    0   0   0    1    1    69
<7> 08 001 01  0    0    0   0   0    1    1    71
<7> 09 001 01  0    0    0   0   0    1    1    79
<7> 0a 001 01  0    0    0   0   0    1    1    81
<7> 0b 001 01  0    0    0   0   0    1    1    89
<7> 0c 001 01  0    0    0   0   0    1    1    91
<7> 0d 001 01  0    0    0   0   0    1    1    99
<7> 0e 001 01  0    0    0   0   0    1    1    A1
<7> 0f 001 01  0    0    0   0   0    1    1    A9
<7> 10 001 01  1    1    0   1   0    1    1    B1
<7> 11 001 01  1    1    0   1   0    1    1    D1
<7> 12 001 01  1    1    0   1   0    1    1    C1
<7> 13 001 01  1    1    0   1   0    1    1    B9
<7> 14 001 01  1    1    0   1   0    1    1    E1
<7> 15 001 01  1    1    0   1   0    1    1    D9
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 001 01  1    1    0   1   0    1    1    C9
<7>IRQ to pin mappings:
<7>IRQ1 -> 0:1
<7>IRQ2 -> 0:2
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:21
<7>IRQ23 -> 0:23
<6>.................................... done.
<6>PCI: Using ACPI for IRQ routing
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
<5>apm: overridden by ACPI.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
