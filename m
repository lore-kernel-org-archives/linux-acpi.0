From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: ACPI prevents detection of SCSI HA
Date: Fri, 15 Nov 2002 07:44:41 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DD4EC39.7080703@optonline.net>
References: <20021115062833.GA4637@doma.ballum.wikaba.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="Boundary_(ID_zmB4oaksM675mtYG9dtN5A)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Guenther Thomsen <tho-NfGIfjByo2U0TNoGDjcNAsJftPPqhGjr@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_zmB4oaksM675mtYG9dtN5A)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

This looks exactly like the problem I have with my AMIBIOS on an Intel 
SRMK2 dual PIII server.
Andy suggested patching a bug in the DSDT by swapping the contents of 
the If and Else in the snippet below:

    Method(GETI, 1) {
        If(And(Arg0, 0xf, )) {
            Return(Zero)
        }
        Else {
            Return(\MLIB.CNV2(And(Arg0, 0xf, )))
        }
    }


Then the interrupt assignment looks more reasonable, but there is still 
a problem with the IRQ distribution such that the SCSI disk cannot be 
accessed. So as of right now, my box won't boot either unless I set 
acpi=off.

Is your system a dual-PIII (max 1GHz) with a ServerWorks chipset?

Bernd


Guenther Thomsen wrote:

>Hi,
>
>my Gateway 2000 PC server 6400 with ASUS CUR-DLS MB doesn't boot 
>linux-2.5.47 (the first 2.5 I tried on that box) from SCSI unless 
>I disable ACPI. Apparently the SCSI HA wont recognized/initialized.
>
>Please let me know, if I can provide more information to help fix 
>this issue.
>
>cheers
>	Guenther
>
>PS: please send e-mail to gthomsen-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org, as I do not frequent
>this list.
>  
>
>------------------------------------------------------------------------
>
>LILO 22.2 boot: new acpi=nopci
>Loading new
>s Linux version 2.5.47 (tho@paris) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 SMP Wed Nov 13 14:57:25 PST 2002
>Video mode to be used for restore is ffff
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)
> BIOS-e820: 0000000027ff0000 - 0000000027fff000 (ACPI data)
> BIOS-e820: 0000000027fff000 - 0000000028000000 (ACPI NVS)
> BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
>639MB LOWMEM available.
>found SMP MP-table at 000ff780
>hm, page 000ff000 reserved twice.
>hm, page 00100000 reserved twice.
>hm, page 000f1000 reserved twice.
>hm, page 000f2000 reserved twice.
>On node 0 totalpages: 163824
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 159728 pages, LIFO batch:16
>  HighMem zone: 0 pages, LIFO batch:1
>ACPI: RSDP (v000 AMI                        ) @ 0x000ff8f0
>ACPI: RSDT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff0000
>ACPI: FADT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff0030
>ACPI: MADT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff00b0
>ACPI: DSDT (v001    RCC  CNB30LE 00000.00256) @ 0x00000000
>ACPI: BIOS passes blacklist
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 6:8 APIC version 16
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] disabled)
>ACPI: IOAPIC (id[0x04] address[0xfec00000] global_irq_base[0x0])
>IOAPIC[0]: Assigned apic_id 4
>IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, IRQ 0-15
>ACPI: IOAPIC (id[0x05] address[0xfec01000] global_irq_base[0x10])
>IOAPIC[1]: Assigned apic_id 5
>IOAPIC[1]: apic_id 5, version 17, address 0xfec01000, IRQ 16-31
>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
>Using ACPI (MADT) for SMP configuration information
>Building zonelist for node : 0
>Kernel command line: auto BOOT_IMAGE=new ro root=805 panic=30 console=ttyS0 console=tty0 hda=none hdb=none hdc=none hdd=none acpi=nopci
>ide_setup: hda=none
>ide_setup: hdb=none
>ide_setup: hdc=none
>ide_setup: hdd=none
>Initializing CPU#0
>Detected 933.596 MHz processor.
>Console: colour VGA+ 80x25
>Calibrating delay loop... 1843.20 BogoMIPS
>Memory: 644260k/655296k available (2042k kernel code, 10280k reserved, 992k data, 124k init, 0k highmem)
>Security Scaffold v1.0.0 initialized
>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>-> /dev
>-> /dev/console
>-> /root
>CPU: L1 I cache: 16K, L1 D cache: 16K
>CPU: L2 cache: 256K
>CPU serial number disabled.
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>POSIX conformance testing by UNIFIX
>CPU0: Intel Pentium III (Coppermine) stepping 06
>per-CPU timeslice cutoff: 731.32 usecs.
>task migration cache decay timeout: 1 msecs.
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000004
>ESR value after enabling vector: 00000000
>Error: only one processor found.
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=0
>..MP-BIOS bug: 8254 timer not connected to IO-APIC
>...trying to set up timer (IRQ0) through the 8259A ... 
>..... (found pin 0) ...works.
>testing the IO APIC.......................
>
>
>.................................... done.
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 933.0179 MHz.
>..... host bus clock speed is 133.0311 MHz.
>Starting migration thread for cpu 0
>CPUS done 32
>Linux NET4.0 for Linux 2.4
>Based upon Swansea University Computer Society NET3.039
>Initializing RT netlink socket
>mtrr: v2.0 (20020519)
>PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=1
>PCI: Using configuration type 1
>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
>ACPI: Subsystem revision 20021101
> tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
> dswload-0503: *** Warning: Type override - [DEB_] had invalid type (Integer) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [MLIB] had invalid type (Integer) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [IO__] had invalid type (Integer) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [DATA] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [SB__] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [ICNT] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [ACPI] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [OSB4] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [BIOS] had invalid type (Integer) for Scope operator, changed to (Scope)
> dswload-0503: *** Warning: Type override - [CMOS] had invalid type (Integer) for Scope operator, changed to (Scope)
>Parsing Methods:................................................................................................................................................................................................
>Table [DSDT] - 662 Objects with 45 Devices 192 Methods 14 Regions
>ACPI Namespace successfully loaded at root c046527c
>evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
> evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE31
> evevent-0508: *** Info: GPE Block1 defined as GPE32 to GPE63
>Executing all Device _STA and_INI methods:.............................................
>45 Devices found containing: 45 _STA, 2 _INI methods
>Completing Region/Field/Buffer/Package initialization:.................................................................
>Initialized 10/14 Regions 2/2 Fields 42/42 Buffers 11/11 Packages (662 nodes)
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [NRTH] (00:00)
>PCI: Probing PCI hardware (bus 00)
>ACPI: PCI Root Bridge [PCI1] (00:00)
>ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
>ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
>ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
>block request queues:
> 128 requests per read queue
> 128 requests per write queue
> 8 requests per batch
> enter congestion at 31
> exit congestion at 33
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
>pci_link-0331 [03] acpi_pci_link_set     : Link disabled
>ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
>dsopcode-0497 [14] Ds_init_buffer_field  : Field size 72 exceeds Buffer size 48 (bits)
>pci_link-0320 [03] acpi_pci_link_set     : Error evaluating _SRS
>ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
>pci_link-0484 [04] acpi_pci_link_get_irq : Link disabled
> pci_irq-0256 [03] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
> pci_irq-0295 [03] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.2
>ACPI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
>PCI: Using ACPI for IRQ routing
>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
>slab: reap timer started for cpu 0
>Starting kswapd
>aio_setup: sizeof(struct page) = 40
>[e7fb1020] eventpoll: driver installed.
>VFS: Disk quotas vdquot_6.5.1
>Journalled Block Device driver loaded
>devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
>devfs: boot_options: 0x1
>Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
>Capability LSM initialized
>Initializing Cryptographic API
>ACPI: Power Button (FF) [PWRF]
>ACPI: Sleep Button (FF) [SLPF]
>acpi_processor-1365 [07] acpi_processor_get_thr: duty_cycle spans bit 4
>ACPI: Processor [CPU0] (supports C1)
>acpi_processor-1365 [07] acpi_processor_get_thr: duty_cycle spans bit 4
>ACPI: Processor [CPU1] (supports C1)
>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
>tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
>tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
>parport0: irq 7 detected
>i2c-core.o: i2c core module version 2.6.4 (20020719)
>pty: 256 Unix98 ptys configured
>lp0: using parport0 (polling).
>Floppy drive(s): fd0 is 1.44M
>FDC 0 is a National Semiconductor PC87306
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>Intel(R) PRO/100 Network Driver - version 2.1.24-k2
>Copyright (c) 2002 Intel Corporation
>
>e100: eth0: Intel(R) 82559 Fast Ethernet LAN on Motherboard
>  Mem:0xfeafb000  IRQ:20  Speed:0 Mbps  Dx:N/A
>  Hardware receive checksums enabled
>  cpu cycle saver enabled
>
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>PDC20267: IDE controller at PCI slot 00:03.0
>PDC20267: chipset revision 2
>PDC20267: not 100% native mode: will probe irqs later
>PDC20267: ROM enabled at 0xfea90000
>PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>    ide2: BM-DMA at 0xcf00-0xcf07, BIOS settings: hde:DMA, hdf:pio
>    ide3: BM-DMA at 0xcf08-0xcf0f, BIOS settings: hdg:DMA, hdh:pio
>hde: Maxtor 2R015H1, ATA DISK drive
>ide2 at 0xcff0-0xcff7,0xcfe6 on irq 16
>hdg: IC35L040AVER07-0, ATA DISK drive
>hdg: bad special flag: 0x03
>hdg: tagged command queueing enabled, command queue depth 8
>ide3 at 0xcfa8-0xcfaf,0xcfe2 on irq 16
>SvrWks OSB4: IDE controller at PCI slot 00:0f.1
>SvrWks OSB4: chipset revision 0
>SvrWks OSB4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
>hde: host protected area => 1
>hde: 29297520 sectors (15000 MB) w/2048KiB Cache, CHS=29065/16/63, UDMA(100)
> /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
>hdg: host protected area => 1
>hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
> /dev/ide/host2/bus1/target0/lun0:ide_tcq_intr_timeout: timeout waiting for completion interrupt
>hdg: invalidating tag queue (1 commands)
>hdg: status error: status=0x48 { DriveReady DataRequest }
>
>hdg: drive not ready for command
>hdg: status error: status=0x48 { DriveReady DataRequest }
>
>hdg: drive not ready for command
> p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 >
>SCSI subsystem driver Revision: 1.00
>request_module[scsi_hostadapter]: not ready
>mice: PS/2 mouse device common for all mice
>input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
>serio: i8042 AUX port at 0x60,0x64 irq 12
>input: AT Set 2 keyboard on isa0060/serio0
>serio: i8042 KBD port at 0x60,0x64 irq 1
>i2c-core.o: i2c core module version 2.6.4 (20020719)
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP: routing cache hash table of 8192 buckets, 64Kbytes
>TCP: Hash tables configured (established 262144 bind 65536)
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>VFS: Cannot open root device "805" or 08:05
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on 08:05
> <0>Rebooting in 30 seconds..
>  
>


--Boundary_(ID_zmB4oaksM675mtYG9dtN5A)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
This looks exactly like the problem I have with my AMIBIOS on an Intel SRMK2
dual PIII server.<br>
Andy suggested patching a bug in the DSDT by swapping the contents of the
If and Else in the snippet below:
<pre wrap="">    Method(GETI, 1) {
        If(And(Arg0, 0xf, )) {
            Return(Zero)
        }
        Else {
            Return(\MLIB.CNV2(And(Arg0, 0xf, )))
        }
    }

</pre>
Then the interrupt assignment looks more reasonable, but there is still a
problem with the IRQ distribution such that the SCSI disk cannot be accessed.
So as of right now, my box won't boot either unless I set acpi=off.<br>
<br>
Is your system a dual-PIII (max 1GHz) with a ServerWorks chipset?<br>
<br>
Bernd<br>
<br>
<br>
Guenther Thomsen wrote:<br>
<blockquote type="cite"
 cite="mid20021115062833.GA4637-NfGIfjByo2U0TNoGDjcNAsJftPPqhGjr@public.gmane.org">
  <pre wrap="">Hi,

my Gateway 2000 PC server 6400 with ASUS CUR-DLS MB doesn't boot 
linux-2.5.47 (the first 2.5 I tried on that box) from SCSI unless 
I disable ACPI. Apparently the SCSI HA wont recognized/initialized.

Please let me know, if I can provide more information to help fix 
this issue.

cheers
	Guenther

PS: please send e-mail to <a class="moz-txt-link-abbreviated" href="mailto:gthomsen-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org">gthomsen@sbcglobal.net</a>, as I do not frequent
this list.
  </pre>
  <pre wrap="">
<hr width="90%" size="4">
LILO 22.2 boot: new acpi=nopci
Loading new
s Linux version 2.5.47 (tho@paris) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 SMP Wed Nov 13 14:57:25 PST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)
 BIOS-e820: 0000000027ff0000 - 0000000027fff000 (ACPI data)
 BIOS-e820: 0000000027fff000 - 0000000028000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
639MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 163824
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159728 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000ff8f0
ACPI: RSDT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff0000
ACPI: FADT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff0030
ACPI: MADT (v001 RCC    RCCNILE  00000.00001) @ 0x27ff00b0
ACPI: DSDT (v001    RCC  CNB30LE 00000.00256) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] disabled)
ACPI: IOAPIC (id[0x04] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 4
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x05] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 5
IOAPIC[1]: apic_id 5, version 17, address 0xfec01000, IRQ 16-31
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=new ro root=805 panic=30 console=ttyS0 console=tty0 hda=none hdb=none hdc=none hdd=none acpi=nopci
ide_setup: hda=none
ide_setup: hdb=none
ide_setup: hdc=none
ide_setup: hdd=none
Initializing CPU#0
Detected 933.596 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1843.20 BogoMIPS
Memory: 644260k/655296k available (2042k kernel code, 10280k reserved, 992k data, 124k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-&gt; /dev
-&gt; /dev/console
-&gt; /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.32 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 933.0179 MHz.
..... host bus clock speed is 133.0311 MHz.
Starting migration thread for cpu 0
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20021101
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
 dswload-0503: *** Warning: Type override - [DEB_] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [MLIB] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [IO__] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [DATA] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [SB__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [ICNT] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [ACPI] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [OSB4] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [BIOS] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0503: *** Warning: Type override - [CMOS] had invalid type (Integer) for Scope operator, changed to (Scope)
Parsing Methods:................................................................................................................................................................................................
Table [DSDT] - 662 Objects with 45 Devices 192 Methods 14 Regions
ACPI Namespace successfully loaded at root c046527c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE31
 evevent-0508: *** Info: GPE Block1 defined as GPE32 to GPE63
Executing all Device _STA and_INI methods:.............................................
45 Devices found containing: 45 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.................................................................
Initialized 10/14 Regions 2/2 Fields 42/42 Buffers 11/11 Packages (662 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
pci_link-0331 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
dsopcode-0497 [14] Ds_init_buffer_field  : Field size 72 exceeds Buffer size 48 (bits)
pci_link-0320 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
pci_link-0484 [04] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [03] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [03] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.2
ACPI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
slab: reap timer started for cpu 0
Starting kswapd
aio_setup: sizeof(struct page) = 40
[e7fb1020] eventpoll: driver installed.
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (<a class="moz-txt-link-abbreviated" href="mailto:rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org">rgooch@atnf.csiro.au</a>)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 <a class="moz-txt-link-abbreviated" href="mailto:okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org">okir@monad.swb.de</a>).
Capability LSM initialized
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
acpi_processor-1365 [07] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU0] (supports C1)
acpi_processor-1365 [07] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU1] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module version 2.6.4 (20020719)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/100 Network Driver - version 2.1.24-k2
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) 82559 Fast Ethernet LAN on Motherboard
  Mem:0xfeafb000  IRQ:20  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 00:03.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfea90000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xcf00-0xcf07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xcf08-0xcf0f, BIOS settings: hdg:DMA, hdh:pio
hde: Maxtor 2R015H1, ATA DISK drive
ide2 at 0xcff0-0xcff7,0xcfe6 on irq 16
hdg: IC35L040AVER07-0, ATA DISK drive
hdg: bad special flag: 0x03
hdg: tagged command queueing enabled, command queue depth 8
ide3 at 0xcfa8-0xcfaf,0xcfe2 on irq 16
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hde: host protected area =&gt; 1
hde: 29297520 sectors (15000 MB) w/2048KiB Cache, CHS=29065/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 &lt; p5 p6 p7 p8 &gt;
hdg: host protected area =&gt; 1
hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0:ide_tcq_intr_timeout: timeout waiting for completion interrupt
hdg: invalidating tag queue (1 commands)
hdg: status error: status=0x48 { DriveReady DataRequest }

hdg: drive not ready for command
hdg: status error: status=0x48 { DriveReady DataRequest }

hdg: drive not ready for command
 p1 p2 &lt; p5 p6 p7 p8 p9 p10 p11 p12 &gt;
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: not ready
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-core.o: i2c core module version 2.6.4 (20020719)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "805" or 08:05
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:05
 &lt;0&gt;Rebooting in 30 seconds..
  </pre>
</blockquote>
<br>
</body>
</html>

--Boundary_(ID_zmB4oaksM675mtYG9dtN5A)--


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
