From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ACPI on Asus M2N
Date: Mon, 27 Oct 2003 10:06:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F9CE029.6030905@pca.it>
References: <1067120458.3313.8.camel@RTop>
Reply-To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000003080403020005010106"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1067120458.3313.8.camel-RU1JJA7J9tM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003080403020005010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

on 10/27/03 09:28, rmuehlhoff wrote:
> what's the current state concerning ACPI on Asus M2N?
as Mads wrote, the problem is quite completely solved, here the quote
from a mail I sent to another user asked me about:
> This bug is related to kernel <= 2.4.22, as in kernels >= 2.6.0-test8 the 'asus-centrino' patch is integrated and you don't need other external patches. My advice is to use kernel 2.6.0-test8, it's faster, more performant and newer

I don't know if the patch was integrated in kernel >= 2.4.23, but my 
advice is to choose kernel 2.6.x, as I'm testing it and it's a lot 
better than 2.4.x.

I wrote taht the problem is /quite/ solved, becasue I continue having 
the error already known, as in the mail I attached. It seems that this 
error is related only to ASUS M3N users (as Lindsey reported the same 
problem) and ATM it isn't solved. But as other M3N users out of Lindsey 
and me haven't reported it yet, I don't know the exact cause.

Thx, bye,
Gismo / Luca

--------------000003080403020005010106
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Delivered-To: 3-luca-wlebWZzHoyE@public.gmane.org
Received: (qmail 2385 invoked by uid 2520); 23 Oct 2003 23:25:13 -0000
Received: from lists.sourceforge.net (HELO sc8-sf-list2.sourceforge.net) (66.35.250.206)
  by 151.39.103.103 with SMTP; 23 Oct 2003 23:25:12 -0000
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.13] helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACoQm-00047P-00; Thu, 23 Oct 2003 15:59:48 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACoPa-0005SA-00
	for <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>; Thu, 23 Oct 2003 15:58:34 -0700
Received: from [151.39.103.104] (helo=host01.pcaserver.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACoMy-0000SJ-O5
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Thu, 23 Oct 2003 15:55:52 -0700
Received: (qmail 2022 invoked by uid 2520); 23 Oct 2003 22:33:39 -0000
Received: from 222.61.203.62.dial.bluewin.ch (HELO pca.it) (62.203.61.222)
  by 151.39.103.103 with SMTP; 23 Oct 2003 22:33:36 -0000
Message-ID: <3F9856B8.3080103-wlebWZzHoyE@public.gmane.org>
From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Reply-To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020 Debian/1.5-1
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Type: multipart/mixed;
 boundary="------------070009080605000107050405"
X-Spam-Score: -0.1 (/)
X-Spam-Report: -0.1/5.0
	Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to https://sf.net/tracker/?func=add&group_id=1&atid=200001
	USER_AGENT_MOZILLA_UA (0.0 points)  User-Agent header indicates a non-spam MUA (Mozilla)
	X_ACCEPT_LANG      (-0.1 points) Has a X-Accept-Language  header
Subject: [ACPI] ASUS M3N (Centrino) & kernel 2.6.0-test8
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-BeenThere: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Id: ACPI Development Discussion List <acpi-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
X-Original-Date: Fri, 24 Oct 2003 00:31:20 +0200
Date: Fri, 24 Oct 2003 00:31:20 +0200
X-Virus-Scanned: by AMaViS perl-11

This is a multi-part message in MIME format.
--------------070009080605000107050405
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I downloaded the last kernel 2.6.0-test8 and the last ACPI patched for 
it. I successfully installed it and it works perfectly, just I get the 
same "osl / AE_TIME" error I get on kernel 2.4.21, where it was called 
"osl-8888" and not "osl-8892" (I attached the dmesg to see the exact 
error message). More, there's another error: "utmisc-0745" that IIRC 
I've never had on kernel 2.4.21.

The first error causes some big problems on kernel 2.4.21: first of all, 
if you works on battery mode it doesn't occurs, while it starts suddenly 
after you plug the AC-adapter in (or you boot with the AC-adapter 
plugged-in). Once it occurs, the keyboard doesn't answer at all for 5min 
and as the error occurs quite every 5/10min, it's a real problem, as I 
need to work with my notebook all the day. On kernel 2.6.0-test8 I've 
always the same problem, but now the keyboard  doesn't answer for 15/30 
seconds, so it's better.

The problem is surely related to "osl.c", but as I not a programmer, I 
can't correct it. Anyway, Í'm here if you need tester.

Thx, bye,
Gismo / Luca

--------------070009080605000107050405
Content-Type: text/plain;
 name="dmesg_2.6.0-test8_20031024"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_2.6.0-test8_20031024"

Linux version 2.6.0-test8 (root@gismo) (gcc version 3.3.2 (Debian)) #1 Fri Oct 24 00:01:06 CEST 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f740000 (usable)
 BIOS-e820: 000000001f740000 - 000000001f750000 (ACPI data)
 BIOS-e820: 000000001f750000 - 000000001f800000 (ACPI NVS)
503MB LOWMEM available.
On node 0 totalpages: 128832
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124736 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f4b70
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000314 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x05000314 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000314 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=260 ro root=304
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1300.226 MHz processor.
Console: colour dummy device 80x25
Memory: 505844k/515328k available (2248k kernel code, 8712k reserved, 969k data, 136k init, 0k highmem)
Calibrating delay loop... 2572.28 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1064 Objects with 55 Devices 332 Methods 29 Regions
ACPI Namespace successfully loaded at root c04656dc
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 000000000000E428 on int 9
Completing Region/Field/Buffer/Package initialization:....................................................................................................................................
Initialized 29/29 Regions 30/30 Fields 42/42 Buffers 31/31 Packages (1072 nodes)
Executing all Device _STA and_INI methods:........................................................
56 Devices found containing: 56 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *4 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7)
ACPI: PCI Interrupt Link [LNKH] (IRQs *4 6 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f2e00
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x39da, dseg 0xf0000
PnPBIOS: Unknown tag '0x0', length '1'.
PnPBIOS: Unknown tag '0x8', length '7'.
PnPBIOS: Unknown tag '0x8', length '7'.
PnPBIOS: Resource structure does not contain an end tag.
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1300MHz": max frequency: 1300000kHz
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: 0000:01:08.0, 00:0C:6E:21:D1:F9, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 > p4
hdc: ATAPI 12X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
scsi0 : scsi_debug, Version: 1.70 (20030507), num_tgts=1, dev_size_mb=8, opts=0x0
  Vendor: Linux     Model: scsi_debug        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 5
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding 265032k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (58 C)
Asus Laptop ACPI Extras version 0.26
  M3N model detected, supported
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
     osl-0892 [5305] os_wait_semaphore     : Failed to acquire semaphore[df73ee00|1|0], AE_TIME
  utmisc-0745 [5304] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Execute] AE_TIME
 exutils-0094: *** Error: Could not acquire interpreter mutex
     osl-0892 [5297] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [5301] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [5310] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [5319] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [24009] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [24016] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [24025] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [24034] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [24043] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32362] os_wait_semaphore     : Failed to acquire semaphore[df73ee00|1|0], AE_TIME
  utmisc-0745 [32361] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Execute] AE_TIME
 exutils-0094: *** Error: Could not acquire interpreter mutex
     osl-0892 [32358] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32362] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32371] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32380] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32389] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32398] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [32516] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [38528] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [43632] os_wait_semaphore     : Failed to acquire semaphore[df73ee00|1|0], AE_TIME
  utmisc-0745 [43631] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Execute] AE_TIME
 exutils-0094: *** Error: Could not acquire interpreter mutex
     osl-0892 [43627] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [43631] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [43640] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [43649] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME

--------------070009080605000107050405--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


--------------000003080403020005010106--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
