From: Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
Subject: Re: Various Lockups with IBM T30
Date: 23 Oct 2002 17:36:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1035412579.2804.6.camel@scraz.mcs.anl.gov>
References: <1033750314.1578.4.camel@scraz.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HbQdT5uz7BUfC7SIxrNC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033750314.1578.4.camel-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-HbQdT5uz7BUfC7SIxrNC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Good news! As of the latest patch against 2.4.20-pre11 I can boot with
all ACPI options compiled in. The only downside is that it kinda fails
and disables ACPI. I'm attaching my dmesg.

I haven't gotten anymore warnings since long time ago so I'm not even
sure where to start to futz with the DSDT.

On Fri, 2002-10-04 at 11:51, Ti Leggett wrote:
> I'm still trying to get my IBM T30 to even boot with ACPI enabled. I've
> managed to output my console over serial so I can capture the output and
> here's what happens.
> 
> 2.4.20-pre8 (with 20021002 patch):
>   - hangs trying to initialize NET4
> 2.4.20-pre8-ac3 (no acpi patch applied)
>   - Oopses at some point during init but spews out a bunch of ACPI
> errors before
> 2.5.40 (with 20021002 patch):
>   - Oopses right after ACPI Power Resource
> 
> I'm attaching the ouputs of each of these logs. I've also managed to
> dump my DSDT so if that's needed (because I really don't know what to do
> with it) I'll send it as well.
-- 
Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>

--=-HbQdT5uz7BUfC7SIxrNC
Content-Disposition: attachment; filename=acpi-successful
Content-Type: text/plain; name=acpi-successful; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.4.20-pre11 (root-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #2 Wed Oct 23 17:12:51 CDT 2002
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
ACPI: have wakeup address 0xc0001000
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
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1794.203 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 515468k/523648k available (1247k kernel code, 7792k reserved, 522k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021022
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:.....................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT] - 1247 Objects with 63 Devices 373 Methods 18 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c02f1a3c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0118 [06] Acpi_disable          : Transition to LEGACY mode successful
 utalloc-0971 [05] Ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:00.1
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.8 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23DA-40B, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c0309d24, I/O limit 4095Mb (mask 0xffffffff)
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=5168/240/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
  utmisc-0698 [01] Ut_acquire_mutex      : Thread 1 could not acquire Mutex [ACPI_MTX_Namespace] AE_BAD_PARAMETER
acpiphp_glue: acpiphp_glue_init: acpi_walk_namespace() failed
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 521600k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller, 00:09:6B:10:7D:FF, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0

--=-HbQdT5uz7BUfC7SIxrNC--



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
