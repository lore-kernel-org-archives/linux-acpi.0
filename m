From: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>
Subject: Re: thinkpad workaround v2.
Date: Mon, 20 Jan 2003 15:30:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301201530.00303.dom@wahuu.at>
References: <200301171947.54174.dom@wahuu.at> <200301201442.27358.x545@gmx.net> <20030120140926.GA11487@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ofAL+9tzdVJMhTC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030120140926.GA11487-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_ofAL+9tzdVJMhTC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Bruno,

i have tried the new patch and now it compiles without any problems. Juhu! 
Unfortunately when booting the patched kernel, ACPI does not get initialized 
properly. Attached to this email you may find the dmesg output of the patched 
kernel ...

Greetings,
Dom

On Monday 20 January 2003 15:09, you wrote:
> On Mon, Jan 20, 2003 at 02:42:27PM +0100, x545 wrote:
> > I get many Errors, all the same in osl.c, line
> > 234,241,243,244,248,250,251,266,290: dereferencing pointer to incomplete
> > type
> > Can you please give short instructions what's wrong or send a complete
> > working diff?
>
> in short, 'struct acpi_table_ecdt' is now in include/linux/acpi.h
>
> Then replace
> #include "acpi.h"
>
> by
> #include <linux/acpi.h>
> (which include drivers/acpi/include/acpi.h btw)
>
> in the file drivers/acpi/osl.c
>
> Here goes the complete patch to be make things cleaner.
>
> my big apologies for this mistake by me..
>
> A final note though: I don't have a thinkpad to play with
> so that I can not test myself this workaround.

--Boundary-00=_ofAL+9tzdVJMhTC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.21-pre3 (root@jonas) (gcc version 3.2.1 20021207 (Gentoo Linux 3.2.1-20021207)) #8 Mon Jan 20 14:57:21 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
 BIOS-e820: 000000002ff60000 - 000000002ff7a000 (ACPI data)
 BIOS-e820: 000000002ff7a000 - 000000002ff7c000 (ACPI NVS)
 BIOS-e820: 000000002ff7c000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
767MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 196448
zone(0): 4096 pages.
zone(1): 192352 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7060
ACPI: XSDT (v001 IBM    TP-1G    00000.04176) @ 0x2ff6ee44
ACPI: FADT (v001 IBM    TP-1G    00000.04176) @ 0x2ff6ee88
ACPI: SSDT (v001 IBM    TP-1G    00000.04176) @ 0x2ff6ef3c
ACPI: ECDT (v001 IBM    TP-1G    00000.04176) @ 0x2ff79f87
ACPI: BOOT (v001 IBM    TP-1G    00000.04176) @ 0x2ff79fd8
ACPI: DSDT (v001 IBM    TP-1G    00000.04176) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda3 
Initializing CPU#0
Detected 1199.021 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 774260k/785792k available (1785k kernel code, 11144k reserved, 583k data, 76k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
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
ACPI: Subsystem revision 20030109
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.........................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT] - 1276 Objects with 64 Devices 393 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c037761c
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0118 [06] acpi_disable          : ACPI mode disabled
 utalloc-0967 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 02:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:00.1
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller, 00:D0:59:CF:10:21, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized i810 1.2.0 20010920 on minor 2
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 02:02.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
blk: queue c038db80, I/O limit 4095Mb (mask 0xffffffff)
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=5168/240/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 76k freed
Adding Swap: 1028152k swap-space (priority -1)

--Boundary-00=_ofAL+9tzdVJMhTC--



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
