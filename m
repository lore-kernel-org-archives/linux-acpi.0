From: Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: Re: S3 causes hang on Dell I2650 in 2.5.60
Date: Wed, 19 Feb 2003 16:19:37 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E53AE99.2080705@ihug.com.au>
References: <Pine.LNX.4.33.0302180043080.21776-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

Thanks for your reply. The 2.5.60 kernel I've compiled is already as 
minimal as I can get it - no sound, networking, SCSI, or  mulitimedia 
support. And it still crashes like that. You suggest trying to put some 
debug print statements in the suspend code to find out exactly what is 
making it crash - can you tell me exactly where to put these statements, 
and what to print? I'm guessing they should go in kernel/suspend.c, 
since that's where the "Stopping tasks" line appears, but according to 
the comments for this file, it's for software suspend, and I was trying 
to use the S3 ACPI suspend state, so is this the right place for these 
debugging statements? And what exactly should I have it output?

Also, I looked more closely at my boot messages, and noticed some weird 
lines about "ACPI: Wakeup code way too big, will crash on attempt to 
suspend" - this sounds like it could be relevant? I've included the 
output of dmesg for the 2.5.60 kernel boot, in case you want to look at 
what it says about ACPI.

Thanks,
Luke


==============================

Linux version 2.5.60 (root@textchimp) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-110)) #2 SMP Wed Feb 19 09:05:32 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000017f80000 (usable)
 BIOS-e820: 0000000017f80000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: Wakeup code way too big, will crash on attempt to suspend
ACPI: have wakeup address 0xc0002000
On node 0 totalpages: 98176
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94080 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000f6740
ACPI: RSDT (v001 DELL     RSDT   01540.00000) @ 0x17efadcf
ACPI: FADT (v001 INTEL  845M     01540.00000) @ 0x17efef8c
ACPI: DSDT (v001 DELL   845M     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.60 ro root=303 
BOOT_FILE=/boot/vmlinuz-2.5.60
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1695.018 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3342.33 BogoMIPS
Memory: 384888k/392704k available (1579k kernel code, 6992k reserved, 
689k data, 296k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
per-CPU timeslice cutoff: 1462.61 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd9c5, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:..................................................................................................................................................
Table [DSDT] - 530 Objects with 51 Devices 146 Methods 16 Regions
ACPI Namespace successfully loaded at root c03b03fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode 
successful
   evgpe-0258: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0258: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI 
methods:...................................................
51 Devices found containing: 51 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package 
initialization:................................................
Initialized 13/16 Regions 0/0 Fields 20/20 Buffers 15/15 Packages (530 
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
pci_bind-0188 [11] acpi_pci_bind         : Device 00:00:1d.02 not 
present in PCI namespace
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
pci_link-0331 [12] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Starting balanced_irq
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
udf: registering filesystem
 exfldio-0117 [33] ex_setup_region       : Field [ACPW] 
Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
 psparse-1101: *** Error: Method execution failed 
[\_SB_.PCI0.LPCB.ACAD._PSR] (Node d7f01e28), AE_AML_REGION_LIMIT
 acpi_ac-0097 [17] acpi_ac_get_state     : Error reading AC Adapter state
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
pty: 256 Unix98 ptys configured
i810_rng: cannot disable RNG, aborting
i810_rng hardware driver 0.9.8 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i845 chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Software Suspend has a malfunctioning SMP support. Disabled :(
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
Adding 514040k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
hdc: CHECK for good STATUS
blk: queue c03bc2bc, I/O limit 4095Mb (mask 0xffffffff)
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?



==============================


Bjorn Wesen wrote:

>On Tue, 18 Feb 2003, Luke Hammer wrote:
>  
>
>>done on the 2.5.x kernel, I compiled the 2.5.60 kernel on
>>my Dell Inspiron 2650 laptop and tried to enter the S3
>>suspend state (with 'echo 3 >/proc/acpi/sleep'). All that
>>happened was that I got the words 'Stopping tasks:' on
>>the console and the laptop hung. There doesn't seem to
>>be anything in the logs about it. Does anyone know what's
>>happening here?
>>    
>>
>
>Try compiling a minimal kernel without any drivers, scsi emulation etc in 
>it (well except for the necessary, perhaps like IDE and keyboard and stuff 
>:) and try again. Some kernel threads and drivers will hang the freezing of 
>the processes upon sleep. You can add debug printouts in the refridgerator 
>code (don't have the filename right now..) so you see which tasks are 
>stopping when it hangs. Adding other debug printouts are useful as well 
>(there should really be some more permanent printouts in that code..)
>
>The drivers I needed but are buggy are 8139too.c and the scsi emulation 
>(trivial fixes to make them work though).
>
>/Bjorn
>
>
>
>  
>





-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
