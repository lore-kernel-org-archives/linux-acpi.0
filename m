From: "Bob Z" <ziuchkov-e94Sedi4moU@public.gmane.org>
Subject: S3 and S4 broken on Toshiba Satellite 2400-s201
Date: Sat, 30 Jul 2005 15:45:29 -0500
Message-ID: <200507301545.29522.ziuchkov@uiuc.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pb+6CIz1NDkqq8q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, I am new to this mailing list, so please bear with me.  I've been 
having a heck of a time getting everything working with my laptop.  It's a 
Toshiba Satellite 2400-s201.  I finally got my alps touchpad and my wifi card 
to work after days of fussing around with different kernel and patch 
versions.  I ended up with version 2.6.11 of the linux kernel because neither 
2.6.8(.1) nor 2.6.12 would work with my touchpad.  Now everything works 
except for suspend to ram and suspend to disk.  All of the rest of the ACPI 
modules work fine for me.  I can poll my battery, scale my cpu frequency, use 
my extra function keys, etc.  It's just that whenever I try to suspend, I end 
up with a weird IRQ error and my computer locks up.  I've tried the built-in 
swsusp, the swsusp2 patches, the hibernate scripts, and just plain 'echo -n 
mem > /sys/power/state'.  Nothing works for me.  I've unloaded every module I 
can except for the acpi ones and I've killed every process except for 
syslogd, klogd, and my shell.  Still my computer freezes.  If I try to 
suspend to disk, it freezes with the IRQ error right after the memory image 
is written to ram but before the computer powers down.  If I try to suspend 
to memory, it suspends okay, but I get the IRQ error when I try to wake the 
computer.  It all seems to be a problem relating to IRQ 11, which is the IRQ 
used by everything that is built-in on this laptop.  I've tried the vanilla 
acpi from 2.6.11 and I've tried patching my kernel with 
acpi-20050408-2.6.11.diff.  Always I get the same problem.  I also tried 
disassembling my computer's DSDT and recompiling with intel's compiler 
according to instructions I found on the net.  Everything compiled without 
any errors or warnings.  I only got 3 'remarks'.  I also searched the dsdt 
for any reference to the windows OS.  It seems to check for windows versions 
and stores a value to an OSID variable.  I changed the code so that it stored 
the value as if it were a Windows XP machine and I recompiled my kernel so 
that it would use my compiled dsdt.  Still I got the same error.  I have 
attached every single piece of information I could think of that might help 
in diagnosing the problem.  The contents of the files are as follows:

dmesg: output of dmesg after my computer boots
dsdt.tar.bz2: the disassembled version of my computer's DSDT
errormsg: an example output I get when trying to use swsusp (v1).  I tried to 
copy it as close to verbatim as possible, but some of the spaces may be off, 
as I had to copy it by hand since at this stage my computer is locked up.
interrupts: contents of /proc/interrupts when everything is loaded on my 
computer
modules: the modules I have present when trying to suspend
processes: the processes I have present when trying to suspend

Please forgive me if I have been too verbose.  I just would really like to get 
suspending to work.  I am really quite new to fiddling with ACPI on linux.  
Everything I have learned is from trying the past few days to get this to 
work.  I appreciate any advice that could be offered.  Thank you.

Bob Z.

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.11.072905 (root@toshiba) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 Sat Jul 30 00:01:33 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000ffe0000 (ACPI data)
 BIOS-e820: 000000000ffe0000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65488
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61392 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0180
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ffd0000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ffd0058
ACPI: DBGP (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ffd00dc
ACPI: BOOT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ffd0030
ACPI: DSDT (v001 TOSHIB 2400     0x20020424 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 10000000 (gap: 10000000:eeda0000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro 
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1595.092 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256124k/261952k available (1636k kernel code, 5256k reserved, 770k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a00)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd496, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x7c set to 0x80
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> IRQ 11
savagefb: mapped io at d0880000
savagefb: probed videoram:  16384k
savagefb: Detected current MCLK value of 332182 kHz
savagefb: mapped framebuffer at d0980000, pbase == ec000000
savagefb v0.4.0_2.6: 16256kB VRAM, using 800x600, 37.878kHz, 60Hz
fb: S3 SuperSavage frame buffer device
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcfa0-0xcfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK3018GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
ACPI wakeup devices: 
MPC0 MPC1  LAN VIY0 VIY1 USB1 USB2 AMDM  LID 
ACPI: (supports S0 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
NET: Registered protocol family 1
Adding 642560k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Generic RTC Driver v1.07
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ALPS Touchpad (GlidePoint) detected
  Enabling hardware tapping
input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ts: Compaq touchscreen protocol output
Linux agpgart interface v0.100 (c) Dave Jones
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:0b.0 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:0b.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
PCI: Enabling device 0000:02:0b.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:0b.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:0b.1 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000011
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xff9ff000, irq 11, MAC addr 00:00:39:0A:D7:DB
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0xefe0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0xef80
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 128M @ 0xf0000000
hw_random: RNG not detected
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49387 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
input: PC Speaker
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Fan [FAN] (off)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Thermal Zone [THRM] (51 C)
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
lp0: using parport0 (interrupt-driven).
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xef
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
hostap_crypt: registered algorithm 'NULL'
hostap_cs: 0.4.1 - 2005-05-22 (Jouni Malinen <jkmaline-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>)
hostap_cs: setting Vcc=33 (constant)
hostap_cs: CS_EVENT_CARD_INSERTION
hostap_cs: setting Vcc=50 (from config)
Checking CFTABLE_ENTRY 0x01 (default 0x01)
IO window settings: cfg->io.nwin=1 dflt.io.nwin=1
io->flags = 0x0047, io.base=0x0000, len=128
hostap_cs: Registered netdevice wifi0
hostap_cs: index 0x01: Vcc 5.0, irq 11, io 0x0200-0x027f
hostap_cs: assuming no Primary image in flash - card initialization not completed
wifi0: test Genesis mode with HCR 0x1f
prism2_pccard_cor_sreset: original COR 41
prism2_pccard_genesis_sreset: original COR 41
Readback test failed, HCR 0x1f write 00 e1 a1 ff read 00 ce a1 ce
wifi0: test Genesis mode with HCR 0x0f
prism2_pccard_cor_sreset: original COR 41
prism2_pccard_genesis_sreset: original COR 41
Readback test succeeded, HCR 0x0f
prism2_pccard_genesis_sreset: original COR 41
wifi0: registered netdevice wlan0
wlan0: could not set interface UP - no PRI f/w
wifi0: cannot set RID fc2d (len=2) - no PRI f/w
prism2: wlan0: operating mode changed 3 -> 2
wlan0: cannot set RID fc00 (len=2) - no PRI f/w
wlan0: cannot set RID fc02 (len=34) - no PRI f/w
wifi0: cannot set RID fc2d (len=2) - no PRI f/w
prism2_download: dl_cmd=4 start_addr=0x003f0000 num_areas=3
wifi0: test Genesis mode with HCR 0x0f
prism2_pccard_cor_sreset: original COR 41
prism2_pccard_genesis_sreset: original COR 41
Readback test succeeded, HCR 0x0f
prism2_pccard_genesis_sreset: original COR 41
prism2_hw_init: initialized in 2 ms
wifi0: NIC: id=0x8000 v0.0.1
wifi0: PRI: id=0x15 v1.1.2
Could not get RID for component STA
wifi0: Failed to read STA f/w version - only Primary f/w present
prism2_download: dl_cmd=6 start_addr=0x003f0000 num_areas=3
wifi0: test Genesis mode with HCR 0x0f
prism2_pccard_cor_sreset: original COR 41
prism2_pccard_genesis_sreset: original COR 41
Readback test succeeded, HCR 0x0f
prism2_pccard_genesis_sreset: original COR 41
prism2_hw_init: initialized in 6 ms
wifi0: NIC: id=0x801d v1.0.0
wifi0: PRI: id=0x15 v1.1.2
Could not get RID for component STA
wifi0: Failed to read STA f/w version - only Primary f/w present
prism2_download: dl_cmd=5 start_addr=0x003f0c01 num_areas=3
prism2_hw_init: initialized in 27 ms
wifi0: NIC: id=0x801d v1.0.0
wifi0: PRI: id=0x15 v1.1.2
wifi0: STA: id=0x1f v1.7.4
wlan0: updating basic rate set automatically to match with the new supported rate set
hostap_crypt: registered algorithm 'WEP'
wifi0: LinkStatus=1 (Connected)
wifi0: LinkStatus: BSSID=00:0d:88:1e:d2:ea
NET: Registered protocol family 17

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: application/x-tbz;
  name="dsdt.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dsdt.tar.bz2"

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
12mNjZM4kP/xdyRThQkHROppUA==

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii";
  name="errormsg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="errormsg"

Stopping tasks: ====================|
Freeing memory ... done (21209 pages freed)
stats: 3
swsusp: Need to copy 6004 pages
swsusp: critical section/: done (6036 pages copied)
ACPI: PCI interrupt    0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
                                      upt    0000     :01:    00.0    [A]   -> 6
				           SI 1    1 (l      evel    , lo   w)     > IRACPIQ   11: PC   I  in  terr

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii";
  name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="interrupts"

           CPU0
  0:     683016          XT-PIC  timer
  1:       2027          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:         47          XT-PIC  acpi
 11:       5904          XT-PIC  yenta, yenta, uhci_hcd, uhci_hcd, Intel 82801CA-ICH3, Intel 82801CA-ICH3 Modem, eth0, 1.0
 12:      10649          XT-PIC  i8042
 14:       7627          XT-PIC  ide0
 15:         41          XT-PIC  ide1
NMI:          0
LOC:     321407
ERR:          0

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii";
  name="modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modules"

Module                  Size  Used by
container               4608  0
intel_agp              23324  1
usbcore               120440  1
agpgart                34984  1 intel_agp
unix                   27700  8

--Boundary-00=_pb+6CIz1NDkqq8q
Content-Type: text/plain;
  charset="us-ascii";
  name="processes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="processes"

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1   1584   512 ?        S    02:55   0:00 init [2]  
root         2  0.0  0.0      0     0 ?        SN   02:55   0:00 [ksoftirqd/0]
root         3  0.9  0.0      0     0 ?        S<   02:55   0:03 [events/0]
root         4  0.0  0.0      0     0 ?        S<   02:55   0:00 [khelper]
root         9  0.0  0.0      0     0 ?        S<   02:55   0:00 [kthread]
root        18  0.0  0.0      0     0 ?        S<   02:55   0:00 [kacpid]
root       120  0.0  0.0      0     0 ?        S<   02:55   0:00 [kblockd/0]
root       159  0.0  0.0      0     0 ?        S    02:55   0:00 [pdflush]
root       160  0.0  0.0      0     0 ?        S    02:55   0:00 [pdflush]
root       162  0.0  0.0      0     0 ?        S<   02:55   0:00 [aio/0]
root       161  0.0  0.0      0     0 ?        S    02:55   0:00 [kswapd0]
root       752  0.0  0.0      0     0 ?        S    02:55   0:00 [kseriod]
root       806  0.0  0.0      0     0 ?        S    02:55   0:00 [kjournald]
root      1884  0.0  0.0      0     0 ?        S    02:55   0:00 [khubd]
root      3330  0.0  0.2   1628   636 ?        Ss   02:55   0:00 /sbin/syslogd
root      3333  0.0  0.5   2468  1456 ?        Ss   02:55   0:00 /sbin/klogd
root      3771  0.0  0.3   2272  1016 tty1     Ss   02:55   0:00 /bin/login --       
bobbyz    3791  0.0  0.6   3188  1708 tty1     S    02:56   0:00 -bash
root      3794  0.0  0.3   2416   920 tty1     S    02:56   0:00 su
root      3798  0.0  0.6   3192  1752 tty1     S    02:56   0:00 bash
root      4790  0.0  0.3   2848   896 tty1     R+   03:00   0:00 ps aux

--Boundary-00=_pb+6CIz1NDkqq8q--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
