From: Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
Subject: Various Lockups with IBM T30
Date: 04 Oct 2002 11:51:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033750314.1578.4.camel@scraz.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GPAzx2LCXPNCMsMKgwWN"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-GPAzx2LCXPNCMsMKgwWN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm still trying to get my IBM T30 to even boot with ACPI enabled. I've
managed to output my console over serial so I can capture the output and
here's what happens.

2.4.20-pre8 (with 20021002 patch):
  - hangs trying to initialize NET4
2.4.20-pre8-ac3 (no acpi patch applied)
  - Oopses at some point during init but spews out a bunch of ACPI
errors before
2.5.40 (with 20021002 patch):
  - Oopses right after ACPI Power Resource

I'm attaching the ouputs of each of these logs. I've also managed to
dump my DSDT so if that's needed (because I really don't know what to do
with it) I'll send it as well.

-- 
Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>

--=-GPAzx2LCXPNCMsMKgwWN
Content-Disposition: attachment; filename=TP30-2.4.20-pre8
Content-Type: text/plain; name=TP30-2.4.20-pre8; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

.................Linux version 2.4.20-pre8 (root-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org) (gcc versio2BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
 BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
zone(0): 4096 pages.
zone(1): 126816 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7020
ACPI: XSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3b4
ACPI: FADT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3f8
ACPI: SSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f4ac
ACPI: ECDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79f87
ACPI: BOOT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79fd8
ACPI: DSDT (v001 IBM    TP-1I    00000.04114) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi console=ttyS0
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1794.192 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 515676k/523648k available (1158k kernel code, 7584k reserved, 475k data)Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021002
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:................................................................Table [DSDT] - 1247 Objects with 63 Devices 373 Methods 18 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c02bea5c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
ACPI: Found ECDT
Executing all Device _STA and_INI methods:......................................58 Devices found containing: 58 _STA, 7 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................Initialized 9/18 Regions 107/124 Fields 65/67 Buffers 34/34 Packages (1248 node)ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: Power Resource [PUBS] (on)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=of'Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 2 performance states, 8 throttling st)ACPI: Thermal Zone [THM0] (62 C)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI edttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.8 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23DA-40B, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c02d85c4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=5168/240/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.


--=-GPAzx2LCXPNCMsMKgwWN
Content-Disposition: attachment; filename=TP30-2.4.20-pre8-ac3
Content-Type: text/plain; name=TP30-2.4.20-pre8-ac3; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.4.20-pre8-ac3 (root-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org) (gcc version 2.96 2000072BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
 BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
zone(0): 4096 pages.
zone(1): 126816 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi console=ttyS0
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1794.221 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 512416k/523648k available (1169k kernel code, 8668k reserved, 485k data)Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [8086/1a30] 000600 00
Found 00:08 [8086/1a31] 000604 01
Found 00:e8 [8086/2482] 000c03 00
Found 00:e9 [8086/2484] 000c03 00
Found 00:ea [8086/2487] 000c03 00
Found 00:f0 [8086/2448] 000604 01
Found 00:f8 [8086/248c] 000601 00
Found 00:f9 [8086/248a] 000101 00
Found 00:fb [8086/2483] 000c05 00
Found 00:fd [8086/2485] 000401 00
Found 00:fe [8086/2486] 000703 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [1002/4c57] 000300 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:1e.0, config 080200, pass 0
Scanning bus 02
Found 02:00 [104c/ac55] 000607 02
Found 02:01 [104c/ac55] 000607 02
Found 02:40 [8086/1031] 000200 00
Fixups for bus 02
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
Scanning behind PCI bridge 02:00.0, config 050302, pass 0
Scanning behind PCI bridge 02:00.1, config 080602, pass 0
Scanning behind PCI bridge 02:00.0, config 050302, pass 1
Scanning behind PCI bridge 02:00.1, config 080602, pass 1
Bus scan for 02 returning with max=08
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Scanning behind PCI bridge 00:1e.0, config 080200, pass 1
Bus scan for 00 returning with max=08
PCI: Bus 01 already known
PCI: Bus 02 already known
Scanning bus 09
Fixups for bus 09
Bus scan for 09 returning with max=09
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:................................................................373 Control Methods found and parsed (1247 nodes total)
Parsing Methods:
0 Control Methods found and parsed (1248 nodes total)
ACPI Namespace successfully loaded at root c02ccde0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-30] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.............................evregion-0218 [-11] ] exfldio-0219 [-12] Ex_read_field_datum   : Region Embedded_control(3) has no hrevregion-0218 [-11] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0592 [-12] Ex_write_field_datum  : **** Region type Embedded_control(3rPs_execute: method failed - \_SB_.PCI0.LPC_.EC__._INI (c24fbf28)
  nsinit-0351 [-28] Ns_init_one_device    : \   /_SB_PCI0LPC_EC__._INI failed: T.evregion-0218 [-11] Ev_address_space_dispa: no handler for region(c24d2a28) [E] exfldio-0219 [-12] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-20] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT0._STA (c24f9428)
  uteval-0337 [-27] Ut_execute_STA        : _STA on BAT0 failed AE_NOT_EXIST
.evregion-0218 [-11] Ev_address_space_dispa: no handler for region(c24d2a28) [E] exfldio-0219 [-12] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-20] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT1._STA (c24f9a28)
  uteval-0337 [-27] Ut_execute_STA        : _STA on BAT1 failed AE_NOT_EXIST
...........evregion-0302 [-12] Ev_address_space_dispa: Region handler: AE_ERROR] dswexec-0392 [-21] Ds_exec_end_op        : [And]: Could not resolve operands, RPs_execute: method failed - \_SB_.PCI0.PCI1.CBS1._INI (c24f4ca8)
  nsinit-0351 [-28] Ns_init_one_device    : \   /_SB_PCI0PCI1CBS1._INI failed: R...............
57 Devices found: 55 _STA, 4 _INI
Completing Region and Field initialization:.....................................9/18 Regions, 111/124 Fields initialized (1248 nodes total)
ACPI: Subsystem enabled
evregion-0218 [-10] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0219 [-11] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-19] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.PUBS._STA (c24fb928)
evregion-0218 [-12] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0219 [-13] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-21] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT0._STA (c24f9428)
  uteval-0337 [-28] Ut_execute_STA        : _STA on BAT0 failed AE_NOT_EXIST
evregion-0218 [-10] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0219 [-11] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-19] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT0._STA (c24f9428)
evregion-0218 [-12] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0219 [-13] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-21] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT1._STA (c24f9a28)
  uteval-0337 [-28] Ut_execute_STA        : _STA on BAT1 failed AE_NOT_EXIST
evregion-0218 [-10] Ev_address_space_dispa: no handler for region(c24d2a28) [Em] exfldio-0219 [-11] Ex_read_field_datum   : Region Embedded_control(3) has no hr dswexec-0392 [-19] Ds_exec_end_op        : [Store]: Could not resolve operandsTPs_execute: method failed - \_SB_.PCI0.LPC_.EC__.BAT1._STA (c24f9a28)
EC: found, GPE 28
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2 C3, 8 throttling states
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
ACPI: Thermal Zone found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI edttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:00.1
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.8 loaded
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23DA-40B, ATA DISK drive
blk: queue c02e6260, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=5168/240/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 88k freed
INIT: version 2.84 booting
                Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Fri Oct  4 10:46:58 CDT 2002 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname scraz.mcs.anl.gov:  [  OK  ]
Checking root filesystem
/: clean, 19051/98304 files, 33908/196560 blocks
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda3 
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
/boot: clean, 45/13272 files, 10813/52888 blocks
/home: clean, 14227/131616 files, 98354/262702 blocks
/sandbox: clean, 27829/2747136 files, 3142602/5494222 blocks
/tmp: clean, 777/130560 files, 33186/521608 blocks
/usr: clean, 148346/656000 files, 778472/1311652 blocks
/var: clean, 28981/130560 files, 220318/521608 blocks
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /boot] fsck.ext2 -a /dev/hda2 
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/hda6 
[/sbin/fsck.ext3 (1) -- /sandbox] fsck.ext3 -a /dev/hda10 
[/sbin/fsck.ext3 (1) -- /tmp] fsck.ext3 -a /dev/hda8 
[/sbin/fsck.ext3 (1) -- /usr] fsck.ext3 -a /dev/hda5 
[/sbin/fsck.ext3 (1) -- /var] fsck.ext3 -a /dev/hda7 
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
Setting hard drive parameters for hda:  [  OK  ]
/sbin/mkkerneldoth: line 9:   173 Segmentation fault      rpm -qUnable to handl0*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0115d30>]    Not tainted
EFLAGS: 00010046
eax: c22be148   ebx: dfcec000   ecx: 0000a490   edx: dfcec02c
esi: dfb13f24   edi: c02bdd98   ebp: dfb13f34   esp: dfb13f20
ds: 0018   es: 0018   ss: 0018
Process uname (pid: 182, stackpage=dfb13000)
Stack: 00000000 00000082 dfcedf44 00000001 c2482c80 dfb13f58 c0116468 dfcec000 
       00000000 00000282 00000001 00000010 c2482c80 df7deb80 00000000 c01403b7 
       fffffff2 00000010 00000010 00000000 c17df180 ffffffea 00000010 c01383f6 
Call Trace:    [<c0116468>] [<c01403b7>] [<c01383f6>] [<c0108833>]

Code: 89 11 8b 43 24 0f ab 47 04 ff 07 89 7b 34 8b 15 10 d9 2b c0 
  kernel$KERNEL_TYPE-$KERNEL_RELEASE >/dev/null 2>&1



--=-GPAzx2LCXPNCMsMKgwWN
Content-Disposition: attachment; filename=TP30-2.5.40
Content-Type: text/plain; name=TP30-2.5.40; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

.................Linux version 2.5.40 (root-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org) (gcc version 2.92Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
 BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages
  Normal zone: 126816 pages
  HighMem zone: 0 pages
ACPI: RSDP (v002 IBM                        ) @ 0x000f7020
ACPI: XSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3b4
ACPI: FADT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3f8
ACPI: SSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f4ac
ACPI: ECDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79f87
ACPI: BOOT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79fd8
ACPI: DSDT (v001 IBM    TP-1I    00000.04114) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi console=ttyS0
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1794.200 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3547.13 BogoMIPS
Memory: 515372k/523648k available (1274k kernel code, 7888k reserved, 497k data)Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
ACPI: Subsystem revision 20021002
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:................................................................Table [DSDT] - 1247 Objects with 63 Devices 373 Methods 18 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c030421c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
ACPI: Found ECDT
Executing all Device _STA and_INI methods:......................................58 Devices found containing: 58 _STA, 7 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................Initialized 9/18 Regions 107/124 Fields 65/67 Buffers 34/34 Packages (1248 node)ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: Power Resource [PUBS] (on)
Unable to handle kernel paging request at virtual address e0ef6050
 printing eip:
c012c721
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c012c721>]    Not tainted
EFLAGS: 00010003
EIP is at kmalloc+0xf1/0x220
eax: 0040000e   ebx: c15072e0   ecx: dfef6000   edx: dfef6100
esi: 0040000e   edi: 00000068   ebp: 000001d0   esp: dff41c9c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=dff40000 task=c153c080)
Stack: dff41cc8 00000058 dff41ce4 00000246 00200000 0000018b dff41ce4 c0268acd 
       c02687ae dff41ce4 00000058 00000001 c01851bf 00000058 000001d0 c01a976b 
       00000058 c0185d91 00000001 c02687eb c02687ae 00000400 c02687ae 0000009b 
Call Trace:
 [<c01851bf>]acpi_os_allocate+0xf/0x20
 [<c01a976b>]acpi_ut_callocate+0x7b/0xf0
 [<c0185d91>]acpi_os_signal_semaphore+0xa1/0xb0
 [<c01a9870>]acpi_ut_callocate_and_track+0x20/0x90
 [<c01a94bd>]acpi_ut_acquire_from_cache+0xfd/0x120
 [<c01ad7d1>]acpi_ut_allocate_object_desc_dbg+0x31/0xb0
 [<c01ad64c>]acpi_ut_create_internal_object_dbg+0x4c/0xe0
 [<c01b3de0>]acpi_pci_data_handler+0x0/0x40
 [<c01b3de0>]acpi_pci_data_handler+0x0/0x40
 [<c019dca9>]acpi_ns_attach_data+0x49/0x80
 [<c019f709>]acpi_attach_data+0x49/0x60
 [<c01b3de0>]acpi_pci_data_handler+0x0/0x40
 [<c01b41ff>]acpi_pci_bind+0x29f/0x370
 [<c01b3de0>]acpi_pci_data_handler+0x0/0x40
 [<c01bb9a6>]acpi_bus_add+0x196/0x1e0
 [<c01bbb7d>]acpi_bus_scan+0x18d/0x200
 [<c0105030>]init+0x0/0x160
 [<c010504c>]init+0x1c/0x160
 [<c0105030>]init+0x0/0x160
 [<c0106ff5>]kernel_thread_helper+0x5/0x10

Code: 8b 44 81 18 0f af f7 89 41 14 01 d6 40 75 23 8b 41 04 8b 11 
 <0>Kernel panic: Attempted to kill init!
 

--=-GPAzx2LCXPNCMsMKgwWN--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
