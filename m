From: =?iso-8859-1?q?Jo=E3o_Cardoso?= <jcard-A1Gx7Te15Zc@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Fri, 14 Jan 2005 19:09:33 +0000
Message-ID: <200501141909.34406.jcard@fe.up.pt>
References: <200501111652.28556.jcard@fe.up.pt> <20050112224425.GB2139@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ujB6B+rHiJI7aAu"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050112224425.GB2139-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_ujB6B+rHiJI7aAu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 12 January 2005 22:44, Pavel Machek wrote:
> Hi!
>
> > In my ASUS M3N laptop, Centrino based, standby (S1) works fine with
> > linux 2.4.x, x>~24, but fails for all 2.6.x series.
> >
> > In runlevel 1, even with all modules unloaded (but the filesystem
> > modules and usbcore, I can't remove it), the system enters standby
> > upon executing
> >    echo 1 > /proc/acpi/sleep
> > but after pressing the power button to resume the PC hangs.
> > Standby works fine under linux-2.4.x, even under runlevel 5.
...
> > What else can I do to help you helping me? :)
>
> Obviously try again without usb ever loaded. Recompile kernel without
> USB support if you have to.
> Does keyboard work? Try to find out where it hangs. Try noapic. Did
> you try with 2.6.11-rc1?
> 								Pavel

OK, I have compiled 2.6.11-rc1 without USB support.

dmesg output is appended. There are some acpi related errors/warnings. 

But now, the system don't enters S1.
Upon "echo 1 > /proc/acpi/sleep" in runlevel 1, the following message is 
printed: (the ... mean I'm ommiting some figures I don't think are 
important )

Stopping tasks: ===|
------[ cut here]----
Kernel bug at drivers/pci/pci.c:330!
Invalid operand: 0000 [#1]
PREEMPT
Modules linked in: e100 mii ext3 jbd reiserfs
CPU: 0
EIP: 0060[<c01e5e78.>] Not tainted VLI
...
EIP is at pci_choose_state+0x38/0x60
EFLAGS: 00010202 (2.6.11-rc1)
...
Call Trace:
... e100_suspend+0x8b/0xe0
... e100_suspend...
...pci_device_suspend...
...suspend_device...
...device_suspend...
...suspend_prepare...
...enter_state...
...acpi_suspend...
...acpi_system_write_sleep
...vfs_write...
...sys_write...
...syenter_past_esp
Code:...

At this point the keyboard is not dead (CAPS LOCK toogles the keyboard 
led) but CTRL-ALT-DEL does not  reboot machine.

After hardware-reboot, I removed the e100 and mii modules (now only the 
ext3, jdb and reiserfs modules are loaded) and repeated the enter 
standby.
The system went to standby (power LED flashing, blank screen), and upon 
pressing the power button again to resume from sleep, the LCD screen 
turned on, showing the following:

   Stopping tasks: ===|
     hwsleep-0306 [78] acpi_enter_sleep_state: Entering sleep state [S1]

So, there is obviously a problem with the e100 network driver. But the 
system is locked, the keyboard does not works.

S3 doesn't work either, but never worked, even in 2.4.xx

And now, after the S3 test, at power up, my laptop starts, the fan works 
for a couple of seconds, and the laptop shuts down itself -- without 
even showing the initial bios messages!

What is the next step? A new laptop? WinXP? (sorry, but I'm not exactly 
happy)

OK! Uffff! After resting for some 15 minutes the laptop rebooted again! 
Obviously(?) while I was copying the screen messages, the CPU 
overheated.

Thanks,
Joao


--Boundary-00=_ujB6B+rHiJI7aAu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.11-rc1.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.11-rc1.dmesg"

Linux version 2.6.11-rc1 (root@flash) (gcc version 3.3.3 (SuSE Linux)) #2 Fri Jan 14 17:47:27 WET 2005
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
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4b70
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000314 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x05000314 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000314 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: root=/dev/hda9 vga=0x317 splash=silent resume=/dev/hda7 2
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1600.534 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505704k/515328k available (2261k kernel code, 9084k reserved, 675k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3170.30 BogoMIPS (lpj=1585152)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1064 Objects with 55 Devices 332 Methods 29 Regions
ACPI Namespace successfully loaded at root c04467a0
ACPI: setting ELCR to 0200 (from 0830)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1175k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041210
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...................................................................................................................................
Initialized 28/29 Regions 30/30 Fields 42/42 Buffers 31/31 Packages (1073 nodes)
Executing all Device _STA and_INI methods:...........................................................
59 Devices found containing: 59 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs *4 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *4 6 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
exoparg2-0436 [73] ex_opcode_2A_1T_1R    : Index value (14) beyond end of buffer (14)
 psparse-1138: *** Error: Method execution failed [\MCTH] (Node df601ba8), AE_AML_BUFFER_LIMIT
 psparse-1138: *** Error: Method execution failed [\OSFL] (Node df601be8), AE_AML_BUFFER_LIMIT
 psparse-1138: *** Error: Method execution failed [\_SB_.RMEM._CRS] (Node c145d668), AE_AML_BUFFER_LIMIT
  uteval-0158: *** Error: Method execution failed [\_SB_.RMEM._CRS] (Node c145d668), AE_AML_BUFFER_LIMIT
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
exoparg2-0436 [74] ex_opcode_2A_1T_1R    : Index value (14) beyond end of buffer (14)
 psparse-1138: *** Error: Method execution failed [\MCTH] (Node df601ba8), AE_AML_BUFFER_LIMIT
 psparse-1138: *** Error: Method execution failed [\OSFL] (Node df601be8), AE_AML_BUFFER_LIMIT
 psparse-1138: *** Error: Method execution failed [\_SB_.RMEM._CRS] (Node c145d668), AE_AML_BUFFER_LIMIT
  uteval-0158: *** Error: Method execution failed [\_SB_.RMEM._CRS] (Node c145d668), AE_AML_BUFFER_LIMIT
pnp: 00:06: ioport range 0x480-0x48f has been reserved
pnp: 00:06: ioport range 0x4c0-0x4cf has been reserved
scx200: NatSemi SCx200 Driver
audit: initializing netlink socket (disabled)
audit(1105727114.258:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: framebuffer at 0xf0000000, mapped to 0xe0080000, using 3072k, total 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 4 (level, low) -> IRQ 4
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHS2060AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
P0P1 LAN0 CBS0 P394 MPCI MODM USB1 USB2 USB3 EHCI SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: replayed 8 transactions in 0 seconds
ReiserFS: hda9: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 192k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using r5 hash to sort names
Adding 819272k swap on /dev/hda7.  Priority:42 extents:1
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xff7ff000, irq 11, MAC addr 00:0C:6E:59:7D:D0
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 17
hw_random: RNG not detected
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (73 C)
     osl-0958 [367] os_wait_semaphore     : Failed to acquire semaphore[df73e580|1|0], AE_TIME
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found

--Boundary-00=_ujB6B+rHiJI7aAu--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
