From: James Joseph <jannix97-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI hangs X-Windows with nForce chipset
Date: Fri, 3 Jan 2003 00:44:38 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030103084438.1697.qmail@web13402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1507814741-1041583478=:1585"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-1507814741-1041583478=:1585
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there,
I have a clean (from kernel.org) 2.4.20 kernel patched
with the latest ACPI patch from sourceforge.net
(acpi-20021212-2.4.20.diff).  I am using AMD Athlon XP
2000+ on Asus A7N266-VM (nForce 220-D chipset with
latest bios update rev. 1005) and i have Local APIC
and IO APIC enabled. 
I am using a Mandrake 8.1 base system. Enabling ACPI
on the default mandrake kernel,(which is 2.4.8) make
the system unbootable, it just prints a line of hex,
and "Attempted to kill init" message comes.

Using the 2.4.20 kernel, system boots properly, and
the text-only mode seems stable runlevel 3).
/proc/interrupts show IO-APIC used for all devices
except "cascade". But when i start X, the server and
KDE boots up, and then whole system hangs. 
Ctrl-Alt-Backspace and Ctrl-Alt-Del don't work, but i
can Sync-Unmount-Reboot using the Magic SysRequest
keys (kernel debugging enabled).

Basically the problems are:- (output of dmesg)

pci_bind-0191 [05] acpi_pci_bind         : Device
00:00:04.00 not present in PCI namespace

and a series of AE_AML_BUFFER_LIMIT conditions.

I don't know anything about ACPI, but is it possible
to increase the AML buffer size from 48 to 56? Is
there any other way to fix this problem, please help!

The suspicious lines of boot message are as follows:-
( I have ACPI Debug messages compiled in to kernel)
---------------------------Output of
dmesg------------------------------------
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCI2._PRT]

pci_bind-0191 [05] acpi_pci_bind         : Device
00:00:04.00 not present in PCI namespace

PCI: Probing PCI hardware
dsopcode-0495 [14] Ds_init_buffer_field  : Field size
56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed
[\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed
[\_SB_.LNKB._SRS] (Node cdf6eee8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error
evaluating _SRS
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size
56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed
[\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed
[\_SB_.LNKC._SRS] (Node cdf6d668), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error
evaluating _SRS
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size
56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed
[\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed
[\_SB_.LNKD._SRS] (Node cdf6dce8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error
evaluating _SRS
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size
56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed
[\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed
[\_SB_.LNKI._SRS] (Node cdf6b8e8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error
evaluating _SRS
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size
56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed
[\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed
[\_SB_.LNKM._SRS] (Node cdf6ad68), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error
evaluating _SRS
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option
'pci=noacpi' or even 'acpi=off'
-------------------------------------------------------
I tried pci=noacpi, no effect, it KDE still hangs.
acpi=off solves the problem(but i
don't get ACPI!)  Also, compiling in "CPU Enumeration
only" option also gives a
stable kernel.

There are 2 other symptoms worth mentioning:-
1)
-----------------Something about a MP-BIOS
bug---------
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19,
2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
--------Guess, this isn't a serious
problem------------

2) I also get the following message on the console
once in a while:-
Spurious 8259A interrupt : IRQ7

>From Motherboard manual, Standard assignment of IRQ7
to Printer port LPT1.
I have no printer connected. Should i disable parallel
port kernel support?
There are no problems after the above message, and i
can continue work. I just
thought it might be significant.

I am attaching the full boot messages (with ACPI debug
enabled) as a file,
acpidebug.msg. Also attaching /proc/pci (as
procpci.msg) and /proc/interrupts
(as procint.msg).

Please help!  I apologize for such a long letter, but
i thought, if i was going
to ask for help, i should atleast include some detail
about my problem for u to be
able to help me.  I am really sorry for killing so
much of your time.

Please help if possible.

James Joseph.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
--0-1507814741-1041583478=:1585
Content-Type: text/plain; name="acpidebug.msg"
Content-Description: acpidebug.msg
Content-Disposition: inline; filename="acpidebug.msg"

Linux version 2.4.20 (root-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version 2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #2 Fri Jan 3 09:03:59 IST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000080000 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dfec000 (usable)
 BIOS-e820: 000000000dfec000 - 000000000dfef000 (ACPI data)
 BIOS-e820: 000000000dfef000 - 000000000dfff000 (reserved)
 BIOS-e820: 000000000dfff000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
223MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 57324
zone(0): 4096 pages.
zone(1): 53228 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f8070
ACPI: RSDT (v001 ASUS   A7N266VM 16944.11825) @ 0x0dfec000
ACPI: FADT (v001 ASUS   A7N266VM 16944.11825) @ 0x0dfec100
ACPI: BOOT (v001 ASUS   A7N266VM 16944.11825) @ 0x0dfec040
ACPI: MADT (v001 ASUS   A7N266VM 16944.11825) @ 0x0dfec080
ACPI: DSDT (v001   ASUS A7N266VM 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=linux ro root=303
Initializing CPU#0
Detected 1670.481 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3335.78 BogoMIPS
Memory: 224412k/229296k available (1101k kernel code, 4372k reserved, 469k data, 92k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1670.4808 MHz.
..... host bus clock speed is 267.2768 MHz.
cpu: 0, clocks: 2672768, slice: 1336384
CPU0<T0:2672768,T1:1336384,D:0,S:1336384,C:2672768>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xf1b20, last bus=2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................................................................................................
Table [DSDT] - 410 Objects with 53 Devices 154 Methods 12 Regions
ACPI Namespace successfully loaded at root c02b679c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
   evgpe-0259: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0259: *** Info: GPE Block1 defined as GPE16 to GPE47
Executing all Device _STA and_INI methods:.....................................................
53 Devices found containing: 53 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:..................................
Initialized 8/12 Regions 0/0 Fields 15/15 Buffers 11/11 Packages (410 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 18, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 18, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 18, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 18, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 19, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 20 21 22, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKU] (IRQs 20 21 22, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LNKI] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 20 21 22, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKK] (IRQs 20 21 22, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKM] (IRQs 20 21 22, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
pci_bind-0191 [05] acpi_pci_bind         : Device 00:00:04.00 not present in PCI namespace
PCI: Probing PCI hardware
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed [\_SB_.LNKB._SRS] (Node cdf6eee8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed [\_SB_.LNKC._SRS] (Node cdf6d668), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed [\_SB_.LNKD._SRS] (Node cdf6dce8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed [\_SB_.LNKI._SRS] (Node cdf6b8e8), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 56 exceeds Buffer size 48 (bits)
 psparse-1102: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf6e1e8), AE_AML_BUFFER_LIMIT
 psparse-1102: *** Error: Method execution failed [\_SB_.LNKM._SRS] (Node cdf6ad68), AE_AML_BUFFER_LIMIT
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 48, VID=10de, DID=01bc
PCI_IDE: chipset revision 195
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SV4002H, ATA DISK drive
hdc: ASUS DVD-ROM E612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=4870/255/63
hdc: ATAPI 40X DVD-ROM drive, 640kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 92k freed
Real Time Clock Driver v1.10e
Adding Swap: 136512k swap-space (priority -1)
Intel 810 + AC97 Audio, version 0.21, 17:21:26 Jan  2 2003
PCI: Enabling device 00:06.0 (0005 -> 0007)
PCI: Setting latency timer of device 00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xe000 and 0xe100, IRQ 11
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: ALG32(ALC650)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 6
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
blk: queue c02ce6e4, I/O limit 4095Mb (mask 0xffffffff)
i2c-core.o: i2c core module version 2.6.5 (20020915)
i2c-amd756.o version 2.6.5 (20020915)
i2c-amd756.o: Found nVidia nForce SMBus controller.
i2c-amd756.o: nVidia nForce bus detected and initialized
i2c-proc.o version 2.6.5 (20020915)
w83781d.o version 2.6.5 (20020915)

--0-1507814741-1041583478=:1585
Content-Type: text/plain; name="procint.msg"
Content-Description: procint.msg
Content-Disposition: inline; filename="procint.msg"

           CPU0       
  0:     567513          XT-PIC  timer
  1:      28403          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:     195935          XT-PIC  NVIDIA nForce Audio, nvidia
 12:      70199          XT-PIC  PS/2 Mouse
 14:       6994          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0 
LOC:     567486 
ERR:        107
MIS:          0

--0-1507814741-1041583478=:1585
Content-Type: text/plain; name="procpci.msg"
Content-Description: procpci.msg
Content-Disposition: inline; filename="procpci.msg"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: nVidia Corporation nForce CPU bridge (rev 178).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   0, function  1:
    RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev 178).
  Bus  0, device   0, function  2:
    RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev 178).
  Bus  0, device   0, function  3:
    RAM memory: PCI device 10de:01aa (nVidia Corporation) (rev 178).
  Bus  0, device   1, function  0:
    ISA bridge: nVidia Corporation nForce ISA Bridge (rev 195).
  Bus  0, device   1, function  1:
    SMBus: nVidia Corporation nForce PCI System Management (rev 193).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0x5000 [0x500f].
      I/O at 0x5500 [0x550f].
      I/O at 0x5100 [0x511f].
  Bus  0, device   2, function  0:
    USB Controller: PCI device 10de:01c2 (nVidia Corporation) (rev 195).
      IRQ 10.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xef000000 [0xef000fff].
  Bus  0, device   3, function  0:
    USB Controller: PCI device 10de:01c2 (nVidia Corporation) (rev 195).
      IRQ 10.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xee800000 [0xee800fff].
  Bus  0, device   5, function  0:
    Multimedia audio controller: PCI device 10de:01b0 (nVidia Corporation) (rev 194).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=1.Max Lat=12.
      Non-prefetchable 32 bit memory at 0xed800000 [0xed87ffff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: nVidia Corporation nForce Audio (rev 194).
      IRQ 11.
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=5.
      I/O at 0xe100 [0xe1ff].
      I/O at 0xe000 [0xe07f].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed000fff].
  Bus  0, device   8, function  0:
    PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev 194).
  Bus  0, device   9, function  0:
    IDE interface: nVidia Corporation nForce IDE (rev 195).
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0xb800 [0xb80f].
  Bus  0, device  30, function  0:
    PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev 178).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  2, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV15 [GeForce2 - nForce GPU] (rev 177).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xec000000 [0xecffffff].
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].

--0-1507814741-1041583478=:1585--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
