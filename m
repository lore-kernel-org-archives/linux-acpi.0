From: Andy Dustman <andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org>
Subject: IRQ routing problems
Date: 02 Apr 2003 02:00:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049266836.3648.18.camel@chef.neosouth.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8VdSlxevIkJCRwIuTXCk"
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


--=-8VdSlxevIkJCRwIuTXCk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've got an ASUS A7N8X motherboard (Athlon + Nvidia Nforce2 chipset) and
I have a terrible time with recent ACPI and 2.4 kernels (I can't even
get 2.5 kernels to boot, but that's another problem).

/proc/interrupts:
           CPU0       
  0:      19042    IO-APIC-edge  timer
  1:        695    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       1881    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
 21:          0            none  eth0
 22:          0            none  NVidia NForce2
NMI:          0 
LOC:      18994 
ERR:          0
MIS:          0

Note 21 and 22 don't seem to be attached properly. 21 is a 3c905C. 22 is
the sound chipset via ALSA 0.9.2. As you might guess neither eth0 nor
sound work at all. Basically ACPI reports that IRQs 20, 21, and 22 are
disabled, but assigns stuff to those IRQs anyway. (dmesg attached)

If I boot with pci=noacpi, then I at least get a usable system:

/proc/interrupts:
           CPU0
  0:      88382    IO-APIC-edge  timer
  1:       2421    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 11:       4588    IO-APIC-edge  NVidia NForce2, eth0
 12:      27990    IO-APIC-edge  PS/2 Mouse
 14:       8776    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
NMI:          0
LOC:      88333
ERR:          0
MIS:          0

However, eth0 and the sound don't really play nicely together. The sound
will lock up and take the ethernet with it. To make it work again, I
have to kill xmms, and after awhile the eth0 watchdog kicks in and
resets the ethernet controller:

Apr  2 00:01:36 chef kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr  2 00:01:36 chef kernel: eth0: transmit timed out, tx_status 00 status e601.Apr  2 00:01:36 chef kernel:   diagnostics: net 0cc0 media 8080 dma 0000003a.
Apr  2 00:01:36 chef kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Apr  2 00:01:36 chef kernel:   Flags; bus-master 1, dirty 395(11) current 395(11)
Apr  2 00:01:36 chef kernel:   Transmit list 00000000 vs. deb614c0.
Apr  2 00:01:36 chef kernel:   0: @deb61200  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   1: @deb61240  length 8000004a status 0001004a
Apr  2 00:01:36 chef kernel:   2: @deb61280  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   3: @deb612c0  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   4: @deb61300  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   5: @deb61340  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   6: @deb61380  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   7: @deb613c0  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   8: @deb61400  length 8000002a status 0001002a
Apr  2 00:01:36 chef kernel:   9: @deb61440  length 8000002a status 8001002a
Apr  2 00:01:36 chef kernel:   10: @deb61480  length 8000002a status 8001002a
Apr  2 00:01:36 chef kernel:   11: @deb614c0  length 8000005a status 0001005a
Apr  2 00:01:36 chef kernel:   12: @deb61500  length 80000055 status 00010055
Apr  2 00:01:36 chef kernel:   13: @deb61540  length 80000055 status 00010055
Apr  2 00:01:36 chef kernel:   14: @deb61580  length 80000055 status 00010055
Apr  2 00:01:36 chef kernel:   15: @deb615c0  length 8000004a status 0001004a
Apr  2 00:01:36 chef kernel: eth0: Resetting the Tx ring pointer.

This latter problem is probably not related to ACPI IRQ routing, but I'm
including it for completeness.

-- 
Andy Dustman         PGP: 0x930B8AB6
    @       .net     http://dustman.net/andy
Freedom isn't free. It's sold to the highest bidder.

--=-8VdSlxevIkJCRwIuTXCk
Content-Description: dmesg output with ACPI IRQ routing enabled
Content-Disposition: inline; filename=dmesg
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Linux version 2.4.21_pre6-gss (root@chef) (gcc version 3.2.2 20030322 (Gent=
oo Linux 1.4 3.2.2-r2)) #2 Wed Apr 2 01:17:34 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 Nvidia                     ) @ 0x000f6ed0
ACPI: RSDT (v001 Nvidia AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 16944.11825) @ 0x1fff7500
ACPI: DSDT (v001 NVIDIA AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: hdc=3Dide-scsi root=3D/dev/hda3 single
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1737.279 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515776k/524224k available (1539k kernel code, 8060k reserved, 522k =
data, 92k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...=20
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
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
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
..... CPU clock speed is 1737.2983 MHz.
..... host bus clock speed is 267.2766 MHz.
cpu: 0, clocks: 2672766, slice: 1336383
CPU0<T0:2672752,T1:1336368,D:1,S:1336383,C:2672766>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030328
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3D3
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
...........................................................................=
...........................................................................=
................................................................
Table [DSDT] - 709 Objects with 77 Devices 261 Methods 27 Regions
ACPI Namespace successfully loaded at root c033263c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 4 registers at=
 0000000000004020 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to=
 GPE 0x1F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L00 as GP=
E number 0x00
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L03 as GP=
E number 0x03
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0B as GP=
E number 0x0B
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0D as GP=
E number 0x0D
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0C as GP=
E number 0x0C
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L05 as GP=
E number 0x05
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0F as GP=
E number 0x0F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0A as GP=
E number 0x0A
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L07 as GP=
E number 0x07
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 8 registers at=
 00000000000044A0 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x20 to=
 GPE 0x5F
Executing all Device _STA and_INI methods:.................................=
............................................
77 Devices found containing: 77 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................=
........................................................
Initialized 23/27 Regions 1/1 Fields 29/29 Buffers 24/24 Packages (709 node=
s)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [APC1] (IRQs 16, disabled)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APCE] (IRQs 16, disabled)
pci_link-0252 [44] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
pci_link-0252 [46] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22, disabled)
pci_link-0252 [49] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22, disabled)
pci_link-0252 [51] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
pci_link-0252 [56] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22, disabled)
pci_link-0252 [59] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 10
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 10
ACPI: PCI Interrupt Link [LIDE] enabled at IRQ 5
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt Link [APCE] enabled at IRQ 16
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
ACPI: Power Button (FF) [PWRF]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 control=
ler on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-75CAA0, ATA DISK drive
hdb: Maxtor 94610H6, ATA DISK drive
blk: queue c034a600, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c034a73c, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area =3D> 1
hda: setmax LBA 156301488, native  156250000
hda: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=3D9726/255/63, UDMA(=
100)
hdb: host protected area =3D> 1
hdb: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=3D5605/255/63, UDMA(1=
00)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 92k freed
Adding Swap: 498004k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Real Time Clock Driver v1.10e
PCI: Setting latency timer of device 00:06.0 to 64
intel8x0: clocking to 47476
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:01.0: 3Com PCI 3c905C Tornado 2 at 0xc000. Vers LK1.1.16
 00:26:54:0a:07:f1, IRQ 21
  product code ffff rev 00.0 date 15-31-127
  Internal config register is 1600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 2, status 784d.
  Enabling bus-master transmits and whole-frame receives.
02:01.0: scatter/gather enabled. h/w checksums enabled

--=-8VdSlxevIkJCRwIuTXCk
Content-Description: /proc/pci with ACPI IRQ routing enabled
Content-Disposition: inline; filename=pci
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 10de:01e0 (nVidia Corporation) (rev 162).
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   0, function  1:
    RAM memory: PCI device 10de:01eb (nVidia Corporation) (rev 162).
  Bus  0, device   0, function  2:
    RAM memory: PCI device 10de:01ee (nVidia Corporation) (rev 162).
  Bus  0, device   0, function  3:
    RAM memory: PCI device 10de:01ed (nVidia Corporation) (rev 162).
  Bus  0, device   0, function  4:
    RAM memory: PCI device 10de:01ec (nVidia Corporation) (rev 162).
  Bus  0, device   0, function  5:
    RAM memory: PCI device 10de:01ef (nVidia Corporation) (rev 162).
  Bus  0, device   1, function  0:
    ISA bridge: PCI device 10de:0060 (nVidia Corporation) (rev 163).
  Bus  0, device   1, function  1:
    SMBus: PCI device 10de:0064 (nVidia Corporation) (rev 162).
      IRQ 23.
      Master Capable.  No bursts.  Min Gnt=3D3.Max Lat=3D1.
      I/O at 0xe000 [0xe01f].
  Bus  0, device   2, function  0:
    USB Controller: PCI device 10de:0067 (nVidia Corporation) (rev 163).
      IRQ 20.
      Master Capable.  No bursts.  Min Gnt=3D3.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xea082000 [0xea082fff].
  Bus  0, device   2, function  1:
    USB Controller: PCI device 10de:0067 (nVidia Corporation) (rev 163).
      IRQ 22.
      Master Capable.  No bursts.  Min Gnt=3D3.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xea080000 [0xea080fff].
  Bus  0, device   2, function  2:
    USB Controller: PCI device 10de:0068 (nVidia Corporation) (rev 163).
      IRQ 20.
      Master Capable.  No bursts.  Min Gnt=3D3.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xea081000 [0xea0810ff].
  Bus  0, device   5, function  0:
    Multimedia audio controller: PCI device 10de:006b (nVidia Corporation) =
(rev 162).
      IRQ 20.
      Master Capable.  No bursts.  Min Gnt=3D1.Max Lat=3D12.
      Non-prefetchable 32 bit memory at 0xea000000 [0xea07ffff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: PCI device 10de:006a (nVidia Corporation) =
(rev 161).
      IRQ 22.
      Master Capable.  No bursts.  Min Gnt=3D2.Max Lat=3D5.
      I/O at 0xe400 [0xe4ff].
      I/O at 0xe800 [0xe87f].
      Non-prefetchable 32 bit memory at 0xea083000 [0xea083fff].
  Bus  0, device   8, function  0:
    PCI bridge: PCI device 10de:006c (nVidia Corporation) (rev 163).
      Master Capable.  No bursts.  Min Gnt=3D2.Max Lat=3D2.
  Bus  0, device   9, function  0:
    IDE interface: PCI device 10de:0065 (nVidia Corporation) (rev 162).
      Master Capable.  No bursts.  Min Gnt=3D3.Max Lat=3D1.
      I/O at 0xf000 [0xf00f].
  Bus  0, device  12, function  0:
    PCI bridge: PCI device 10de:006d (nVidia Corporation) (rev 163).
      Master Capable.  No bursts.  Min Gnt=3D2.
  Bus  0, device  30, function  0:
    PCI bridge: PCI device 10de:01e8 (nVidia Corporation) (rev 162).
      Master Capable.  Latency=3D32.  Min Gnt=3D10.
  Bus  1, device   9, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 1).
      IRQ 17.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xe9000000 [0xe9000fff].
  Bus  1, device  11, function  0:
    RAID bus controller: PCI device 1095:3112 (CMD Technology Inc) (rev 2).
      IRQ 18.
      Master Capable.  Latency=3D32. =20
      I/O at 0xa400 [0xa407].
      I/O at 0xa800 [0xa803].
      I/O at 0xac00 [0xac07].
      I/O at 0xb000 [0xb003].
      I/O at 0xb400 [0xb40f].
      Non-prefetchable 32 bit memory at 0xe9001000 [0xe90011ff].
  Bus  2, device   1, function  0:
    Ethernet controller: PCI device 10b7:9201 (3Com Corporation) (rev 64).
      IRQ 21.
      Master Capable.  Latency=3D32.  Min Gnt=3D10.Max Lat=3D10.
      I/O at 0xc000 [0xc07f].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe500007f].
  Bus  3, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon =
8500 LE] (rev 0).
      IRQ 19.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 32 bit memory at 0xe7000000 [0xe700ffff].

--=-8VdSlxevIkJCRwIuTXCk--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
