From: Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
Subject: Re: Problems with P4
Date: 21 Sep 2002 12:09:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032628143.1563.2.camel@scraz.mcs.anl.gov>
References: <1030032660.1537.17.camel@scraz-57.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1030032660.1537.17.camel-yKkbRDLg+u3kO4pph2lK859G+ZOsUmrO@public.gmane.org>
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

I tried again with the newest patch again 2.5.36 and it oopses after
init starts.

Does *anyone* out there have any suggestions?

On Thu, 2002-08-22 at 11:10, Ti Leggett wrote:
> I've been trying to get ACPI working on IBM ThinkPad T30 (2366-91U).
> It's an Intel P4-M 1.8GHz. So far I've not had much success getting full
> ACPI working. Here's what I tried:
> 
> 2.4.18 with acpi-20020726-2.4.18:
> * Turning on all ACPI options causes a kernel oops at boot time. I can
> see the ACPI messages scroll by and everything looks good but soon after
> it oopses
> * Turning off processor options cause a hang when it gets to the NET4
> loading
> * Turning only CPU Enumeration works fine
> 
> 2.5.31 with acpi-20020815-2.5.31:
> * Same as 2.4.18
> 
> 2.4.19 with acpi-20020821-2.4.19:
> * Turning on all ACPI options causes a hang at NET4 loading
> * Turning off processor options causes a hang at NET4 loading
> * Turning only on CPU Enumeration works fine
> 
> With the scenarios where oopses happened, compiling the kernel for
> something other than a P4 (say a PIII or PII) causes the kernel to hang.
> 
> I've tried ACPI on a Dual P4 Xeon 2.2GHz box with SuperMicro P4DC6+
> motherboard (i860 chipset), turning off hyper-threading, with similar
> results.
> 
> Is there something not kosher with ACPI on P4s? Here's the dmesg output
> from my laptop with 2.4.19 with acpi-20020821-2.4.19 and CPU Enumeration
> Only and APM (so that I can still do PM). Please let me know if there's
> anything else I can do to help debug.
> 
> Linux version 2.4.19 (root-Qsbryy5/dojkO4pph2lK859G+ZOsUmrO@public.gmane.org) (gcc version 2.96
> 20000731 (Red Hat Linux 7.3 2.96-112)) #1 Thu Aug 22 09:27:17 CDT 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
>  BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
>  BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
>  BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
>  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> Advanced speculative caching feature not present
> On node 0 totalpages: 130912
> zone(0): 4096 pages.
> zone(1): 126816 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v002 IBM                        ) @ 0x000f7020
> ACPI: XSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3b4
> ACPI: FADT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f3f8
> ACPI: SSDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff6f4ac
> ACPI: ECDT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79f87
> ACPI: BOOT (v001 IBM    TP-1I    00000.04114) @ 0x1ff79fd8
> IBM machine detected. Enabling interrupts during APM calls.
> Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
> ide_setup: hdc=ide-scsi
> Initializing CPU#0
> Detected 1794.221 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3578.26 BogoMIPS
> Memory: 515924k/523648k available (991k kernel code, 7336k reserved,
> 403k data, 76k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 12K, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
> CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Discovered primary peer bus 09 [IRQ]
> PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
> PCI: Found IRQ 11 for device 00:1f.1
> PCI: Sharing IRQ 11 with 00:1d.2
> PCI: Cannot allocate resource region 0 of device 02:00.0
> PCI: Cannot allocate resource region 0 of device 02:00.1
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> Starting kswapd
> Journalled Block Device driver loaded
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> PCI: Found IRQ 11 for device 00:1f.6
> PCI: Sharing IRQ 11 with 00:1f.3
> PCI: Sharing IRQ 11 with 00:1f.5
> PCI: Sharing IRQ 11 with 02:00.1
> Real Time Clock Driver v1.10e
> i810_rng hardware driver 0.9.8 loaded
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ICH3M: IDE controller on PCI bus 00 dev f9
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
> PCI: Found IRQ 11 for device 00:1f.1
> PCI: Sharing IRQ 11 with 00:1d.2
> ICH3M: chipset revision 2
> ICH3M: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
> hda: HITACHI_DK23DA-40B, ATA DISK drive
> hdc: DW-28E, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=5168/240/63,
> UDMA(100)
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a National Semiconductor PC87306
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Detected Intel i845 chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> [drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
> [drm] Initialized radeon 1.1.1 20010405 on minor 0
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 76k freed
> Adding Swap: 521600k swap-space (priority -1)
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,10), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: TEAC      Model: DW-28E            Rev: 2.1A
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> hdc: DMA disabled
> parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
> PCI: Found IRQ 11 for device 02:08.0
> eth0: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller,
> 00:09:6B:10:7D:FF, IRQ 11.
>   Board assembly 000000-000, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
> Linux PCMCIA Card Services 3.2.0
>   kernel build: 2.4.19 #1 Thu Aug 22 09:27:17 CDT 2002
>   options:  [pci] [cardbus] [apm]
> Intel ISA/PCI/CardBus PCIC probe:
> PCI: Found IRQ 11 for device 02:00.0
> PCI: Sharing IRQ 11 with 00:1d.0
> PCI: Sharing IRQ 11 with 01:00.0
> PCI: Found IRQ 11 for device 02:00.1
> PCI: Sharing IRQ 11 with 00:1f.3
> PCI: Sharing IRQ 11 with 00:1f.5
> PCI: Sharing IRQ 11 with 00:1f.6
>   Unknown [104c ac55] rev 01 PCI-to-CardBus at slot 02:00, mem
> 0xd0201000
>     host opts [0]: [pci irq 11] [lat 64/176] [bus 3/5]
>     host opts [1]: [pci irq 11] [lat 64/176] [bus 6/8]
>     PCI irq 11 test failed
>     ISA irqs (default) = 3,4,5,7,9,10,12 polling interval = 1000 ms
> cs: memory probe 0xa0000000-0xa0ffffff: clean.
> hermes.c: 5 Apr 2002 David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
> orinoco.c 0.11b (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
> orinoco_cs.c 0.11b (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and
> others)
> cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
> cs: IO port probe 0x03e0-0x04cf: clean.
> cs: IO port probe 0x04d8-0x04ff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: IO port probe 0x0c00-0x0cff: clean.
> eth1: Station identity 001f:0001:0008:000a
> eth1: Looks like a Lucent/Agere firmware version 8.10
> eth1: Ad-hoc demo mode supported
> eth1: IEEE standard IBSS ad-hoc mode supported
> eth1: WEP supported, 104-bit key
> eth1: MAC address 00:02:2D:0A:19:9A
> eth1: Station name "HERMES I"
> eth1: ready
> eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
> Cisco Systems VPN Client Version 3.5.1 (Rel) kernel module loaded
> Intel 810 + AC97 Audio, version 0.21, 09:30:41 Aug 22 2002
> PCI: Found IRQ 11 for device 00:1f.5
> PCI: Sharing IRQ 11 with 00:1f.3
> PCI: Sharing IRQ 11 with 00:1f.6
> PCI: Sharing IRQ 11 with 02:00.1
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, IRQ 11
> i810_audio: Audio Controller supports 6 channels.
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not
> present), total channels = 2
> ac97_codec: AC97 Modem codec, id: 0x5349:0x4c27 (Unknown)
> i810_audio: timed out waiting for codec 1 analog ready.
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.12
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
