From: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Subject: Re: High interrupt rate and no eth with 2.6.0-test1
Date: Mon, 21 Jul 2003 12:25:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <bfgigg$2bc$1@main.gmane.org>
References: <20030720200551.0f90c5ef.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030720200551.0f90c5ef.gigerstyle-OI3hZJvNYWs@public.gmane.org>
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

Marc Giger wrote:
> Hi Andrew, Hi All,
> 
> I've tested today 2.6.0-test1 with acpi. When acpi is enabled eth is not
> working. Also I noticed a very high interrupt rate on acpi irq.
> 
> eth0 is normally on irq 22 which was disabled by kernel (see dmesg)
> 
> greets
> 
> Marc
> 
> 
> cat /proc/interrupts (after 5 min uptime):
> 
>            CPU0
>   0:     302824    IO-APIC-edge  timer
>   1:       2301    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          2    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  eth0
>  12:        118    IO-APIC-edge  i8042
>  14:        214    IO-APIC-edge  ide0
>  15:         18    IO-APIC-edge  ide1
>  20:       3363   IO-APIC-level  aic7xxx
>  22:   74291106   IO-APIC-level  acpi
>  23:          0   IO-APIC-level  EMU10K1
> NMI:          0
> LOC:     302784
> ERR:          0
> MIS:          0
> 
> dmesg:
> 
> gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2
> Sun Jul 20 19:12:33 CEST 2003 Video mode to be used for restore is f00
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
>  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
>  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
>  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec80000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 511MB LOWMEM available.
> found SMP MP-table at 000f0410
> hm, page 000f0000 reserved twice.
> hm, page 000f1000 reserved twice.
> hm, page 000f0000 reserved twice.
> On node 0 totalpages: 131052
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 126956 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> ACPI: RSDP (v000 ASUS                       ) @ 0x000f5930
> ACPI: RSDT (v001 ASUS   P4T533-C 16944.11825) @ 0x1ffec000
> ACPI: FADT (v001 ASUS   P4T533-C 16944.11825) @ 0x1ffec0c0
> ACPI: BOOT (v001 ASUS   P4T533-C 16944.11825) @ 0x1ffec030
> ACPI: MADT (v001 ASUS   P4T533-C 16944.11825) @ 0x1ffec058
> ACPI: DSDT (v001   ASUS P4T533-C 00000.04096) @ 0x00000000
> ACPI: BIOS passes blacklist
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
> ACPI: IOAPIC (id[0x04] address[0xfec00000] global_irq_base[0x0])
> IOAPIC[0]: Assigned apic_id 4
> IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, IRQ 0-23
> ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
> trigger[0x1]) ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x16]
> polarity[0x3] trigger[0x3]) Enabling APIC mode:  Flat.  Using 1 I/O
> APICs Using ACPI (MADT) for SMP configuration information
> Building zonelist for node : 0
> Kernel command line: BOOT_IMAGE=linux2560t rw root=802 enableapic
> vga=0x0311 Initializing CPU#0
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 2406.129 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 4751.36 BogoMIPS
> Memory: 514888k/524208k available (2181k kernel code, 8524k reserved,
> 703k data, 200k init, 0k highmem) Dentry cache hash table entries: 65536
> (order: 6, 262144 bytes) Inode-cache hash table entries: 32768 (order:
> 5, 131072 bytes) Mount-cache hash table entries: 512 (order: 0, 4096
> bytes)-> /dev
> -> /dev/console
> -> /root
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU#0: Thermal monitoring enabled
> CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 4-0, 4-9, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-23
> not connected...TIMER: vector=0x31 pin1=2 pin2=-1
> number of MP IRQ sources: 15.
> number of IO-APIC #4 registers: 24.
> testing the IO APIC.......................
> IO APIC #4......
> .... register #00: 04000000
> .......    : physical APIC id: 04
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178020
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0020
> .... register #02: 00000000
> .......     : arbitration: 00
> .... register #03: 00000001
> .......     : Boot DT    : 1
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 000 00  1    0    0   0   0    0    0    00
>  01 001 01  0    0    0   0   0    1    1    39
>  02 001 01  0    0    0   0   0    1    1    31
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 001 01  0    0    0   0   0    1    1    71
>  0b 001 01  0    0    0   0   0    1    1    79
>  0c 001 01  0    0    0   0   0    1    1    81
>  0d 001 01  0    0    0   0   0    1    1    89
>  0e 001 01  0    0    0   0   0    1    1    91
>  0f 001 01  0    0    0   0   0    1    1    99
>  10 000 00  1    0    0   0   0    0    0    00
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 000 00  1    0    0   0   0    0    0    00
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 001 01  1    1    0   1   0    1    1    A1
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:22
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2404.0996 MHz.
> ..... host bus clock speed is 133.0610 MHz.
> Initializing RT netlink socket
> PCI: PCI BIOS revision 2.10 entry at 0xf1670, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> ACPI: Subsystem revision 20030619
> IOAPIC[0]: Set PCI routing entry (4-22 -> 0xa9 -> IRQ 22)
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15,
> disabled) ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14
> 15) ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15,
> disabled) ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14
> 15) ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Enabled i801 SMBus device
> Transparent bridge - PCI device 8086:244e
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
> SCSI subsystem initialized
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
> IOAPIC[0]: Set PCI routing entry (4-17 -> 0xb1 -> IRQ 17)
> 00:00:1f[B] -> 4-17 -> IRQ 17
> IOAPIC[0]: Set PCI routing entry (4-23 -> 0xb9 -> IRQ 23)
> 00:00:1f[C] -> 4-23 -> IRQ 23
> IOAPIC[0]: Set PCI routing entry (4-19 -> 0xc1 -> IRQ 19)
> 00:00:1f[D] -> 4-19 -> IRQ 19
> IOAPIC[0]: Set PCI routing entry (4-16 -> 0xc9 -> IRQ 16)
> 00:01:00[A] -> 4-16 -> IRQ 16
> Pin 4-17 already programmed
> IOAPIC[0]: Set PCI routing entry (4-21 -> 0xd1 -> IRQ 21)
> 00:02:09[A] -> 4-21 -> IRQ 21
> Pin 4-23 already programmed
> IOAPIC[0]: Set PCI routing entry (4-20 -> 0xd9 -> IRQ 20)
> 00:02:09[D] -> 4-20 -> IRQ 20
> Pin 4-23 already programmed
> Pin 4-20 already programmed
> Pin 4-21 already programmed
> Pin 4-23 already programmed
> Pin 4-20 already programmed
> Pin 4-21 already programmed
> Pin 4-20 already programmed
> Pin 4-21 already programmed
> Pin 4-23 already programmed
> IOAPIC[0]: Set PCI routing entry (4-18 -> 0xe1 -> IRQ 18)
> 00:02:0d[A] -> 4-18 -> IRQ 18
> Pin 4-19 already programmed
> Pin 4-16 already programmed
> Pin 4-17 already programmed
> Pin 4-21 already programmed
> Pin 4-23 already programmed
> Pin 4-20 already programmed
> ACPI: No IRQ known for interrupt pin A of device 0000:02:0a.0
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even
> 'acpi=off' vga16fb: initializing
> vga16fb: mapped to 0xc00a0000
> fb0: VGA16 VGA frame buffer device
> pty: 256 Unix98 ptys configured
> SBF: Simple Boot Flag extension found and enabled.
> SBF: Setting boot flags 0x1
> Machine check exception polling timer started.
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> Enabling SEP on CPU 0
> Total HugeTLB memory allocated, 0
> Journalled Block Device driver loaded
> devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> devfs: boot_options: 0x1
> Initializing Cryptographic API
> Real Time Clock Driver v1.11
> hw_random: RNG not detected
> anticipatory scheduling elevator
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> loop: loaded (max 8 devices)
> ACPI: No IRQ known for interrupt pin A of device 0000:02:0a.0
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:02:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800. Vers LK1.1.19
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx ICH2: IDE controller at PCI slot 0000:00:1f.1
> ICH2: chipset revision 4
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L080AVVA07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: Pioneer CD-ROM ATAPI Model DR-944 0107, ATAPI CD/DVD-ROM drive
> hdd: Pioneer CD-ROM ATAPI Model DR-A12X 0202, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: host protected area => 1
> hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63,
> UDMA(100) /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
> hdc: ATAPI 40X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.12
> hdd: ATAPI 12X CD-ROM drive, 128kB Cache
> ide-floppy driver 0.99.newide
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
>         <Adaptec 29160 Ultra160 SCSI adapter>
>         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
> (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 16)
> (scsi0:A:5): 19.230MB/s transfers (19.230MHz, offset 16)
> (scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
>   Vendor: IBM       Model: DDYS-T18350N      Rev: SA2A
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: SONY      Model: CD-RW  CRX140S    Rev: 1.0e
>   Type:   CD-ROM                             ANSI SCSI revision: 04
> SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
> SCSI device sda: drive cache: write through
>  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 59x/61x caddy
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
> sr1: scsi3-mmc drive: 59x/61x caddy
> Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
> mice: PS/2 mouse device common for all mice
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> ACPI: (supports S0 S1 S4 S5)
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device sda2, size 8192, journal first block 18,
> max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (sda2) for (sda2) Using r5 hash to
> sort names VFS: Mounted root (reiserfs filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 200k freed
> Adding 289160k swap on /dev/sda4.  Priority:-1 extents:1
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device sda3, size 8192, journal first block 18,
> max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (sda3) for (sda3) Using r5 hash to
> sort names found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda8, size 8192, journal first block 18,
> max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda8) for (hda8) Using r5 hash to
> sort names parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
> parport0: irq 7 detected
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> lp0: using parport0 (polling).
> irq 22: nobody cared!
> Call Trace:
>  [<c010d2a5>] __report_bad_irq+0x2b/0x8c
>  [<c0205ad1>] acpi_irq+0xf/0x1a
>  [<c010d38e>] note_interrupt+0x69/0x99
>  [<c010d624>] do_IRQ+0x13e/0x14d
>  [<c0109029>] default_idle+0x0/0x2c
>  [<c0109029>] default_idle+0x0/0x2c
>  [<c010bb20>] common_interrupt+0x18/0x20
>  [<c0109029>] default_idle+0x0/0x2c
>  [<c0109029>] default_idle+0x0/0x2c
>  [<c0109050>] default_idle+0x27/0x2c
>  [<c01090c1>] cpu_idle+0x31/0x3a
>  [<c0105000>] _stext+0x0/0x61
>  [<c03d46e3>] start_kernel+0x176/0x19b
>  [<c03d443f>] unknown_bootoption+0x0/0xfa
> 
> handlers:
> [<c0205ac2>] (acpi_irq+0x0/0x1a)
> Disabling IRQ #22
> Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
> Module nfsd cannot be unloaded due to unsafe usage in
> include/linux/module.h:482 NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e601.
>   diagnostics: net 0cda media 8880 dma 0000003a fifo 0000
> eth0: Interrupt posted but not delivered -- IRQ blocked by another
> device?  Flags; bus-master 1, dirty 16(0) current 16(0)
>   Transmit list 00000000 vs. dfda3200.
>   0: @dfda3200  length 8000006e status 0c01006e
>   1: @dfda32a0  length 8000006e status 0c01006e
>   2: @dfda3340  length 8000006e status 0c01006e
>   3: @dfda33e0  length 8000006e status 0c01006e
>   4: @dfda3480  length 8000006e status 0c01006e
>   5: @dfda3520  length 80000108 status 0c010108
>   6: @dfda35c0  length 8000006e status 0c01006e
>   7: @dfda3660  length 8000006e status 0c01006e
>   8: @dfda3700  length 8000006e status 0c01006e
>   9: @dfda37a0  length 8000006e status 0c01006e
>   10: @dfda3840  length 8000006e status 0c01006e
>   11: @dfda38e0  length 8000006e status 0c01006e
>   12: @dfda3980  length 8000006e status 0c01006e
>   13: @dfda3a20  length 8000006e status 0c01006e
>   14: @dfda3ac0  length 8000006e status 8c01006e
>   15: @dfda3b60  length 8000006e status 8c01006e
> eth0: Resetting the Tx ring pointer.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0

Try applying Andrew de Qincey's patch.
(See e-mail to this group: "[PATCH] IRQ params patch#4").
The issues you have are similar enough to mine to suggest that
this patch may help. Infact read all his recent mails, some good
ideas for things to research there.

Bye
	-Rob.

p.s. e-mails to my e-mail address may bounce at the moment.
It looks as if my ISP has a spam block against Sneakemail :-(




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
