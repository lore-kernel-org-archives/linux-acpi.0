From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] add "pnpacpi=off", print info during discovery
Date: Fri, 14 Jan 2005 11:28:26 -0700
Message-ID: <1105727306.7034.18.camel@eeyore>
References: <1105489541.31942.81.camel@eeyore>
	 <1105491763.29370.5.camel@sli10-desk.sh.intel.com>
	 <1105632437.3818.5.camel@eeyore>  <20050113181333.GS6069@neo.rr.com>
	 <1105666525.22995.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-43Ndiy4K5YNBK+xgUni4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105666525.22995.9.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-43Ndiy4K5YNBK+xgUni4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-01-14 at 09:35 +0800, Li Shaohua wrote:
> On Fri, 2005-01-14 at 02:13, Adam Belay wrote: 
> > Could you send me a copy of your patch.  I'm curious.
> We have a case (PNPACPI breaks ES7000 system). We want blacklist PNPACPI
> in the arch. My patch doesn't do blacklist now, so I didn't send it out.

Yeah, I have gotten several reports of problems that go away
when turning off PNPACPI.  They came to me because they also
go away when using "pci=routeirq".

For example, I have a report of the keyboard on an IBM T41
that doesn't work unless you either use "pci=routeirq" or
set CONFIG_PNPACPI=n.

In the attached dmesg logs, I can't see anything different
related to keyboard.  But it is interesting that PNPACPI
makes parport interrupt-driven (IRQ 7) rather than polling,
and somehow "pci=routeirq" makes a difference.


--=-43Ndiy4K5YNBK+xgUni4
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linux version 2.6.10 (js@ares) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Sat Dec 25 14:40:03 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux(2.6.10) ro root=303
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1694.794 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514516k/523648k available (2414k kernel code, 8648k reserved, 997k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 1317 Objects with 63 Devices 392 Methods 20 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c048e560
ACPI: setting ELCR to 0200 (from 0800)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:.......................................................................................................................................................................................................................................................
Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 38/46 Packages (1327 nodes)
Executing all Device _STA and_INI methods:..............................................................
62 Devices found containing: 62 _STA, 9 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff4ea68]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff54768]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff59ce8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5c628]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5cfe8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5dda8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5dc28]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5d868]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e07e8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e2f28]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e2428]
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x35 set to 0x1
NTFS driver 2.1.22 [Flags: R/W].
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3)
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (55 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.8
ibm_acpi: http://ibm-acpi.sf.net/
acpi_bus-0081 [05] acpi_bus_get_device   : Error getting context for object [dff59ce8]
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
pnp: Device 00:09 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R9012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
^Icurrent capacity is 110648690 sectors (56652 MB)
^Inative  capacity is 117210240 sectors (60011 MB)
hda: Host Protected Area disabled.
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49452 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
 LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
kjournald starting.  Commit interval 5 seconds
Adding 498952k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
c013ae51
PREEMPT
Modules linked in: parport_pc lp parport video
CPU:    0
EIP:    0060:[<c013ae51>]    Not tainted VLI
EFLAGS: 00010012   (2.6.10)
EIP is at free_block+0x41/0xd0
eax: ffffffff   ebx: df7a57a0   ecx: df0cc000   edx: c14df994
esi: c14df980   edi: 00000000   ebp: dff39f04   esp: dff39eec
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=dff38000 task=dff0b020)
Stack: c14df99c 00000005 c14dc110 c14dc110 c14dc100 00000005 dff39f1c c013b484
       c14df980 c14dfb9c c14df980 dff38000 dff39f44 c013b526 c14dfb9c dff38000
       00000002 c14df9f0 00000292 c048b300 dff38000 c048b304 dff39fc8 c0125ddf
Call Trace:
 [<c010347a>] show_stack+0x7a/0x90
 [<c01035f9>] show_registers+0x149/0x1b0
 [<c01037ed>] die+0xdd/0x170
 [<c0112135>] do_page_fault+0x275/0x657
 [<c0103107>] error_code+0x2b/0x30
 [<c013b484>] drain_array_locked+0x64/0x90
 [<c013b526>] cache_reap+0x76/0x1b0
 [<c0125ddf>] worker_thread+0x19f/0x260
 [<c0129c79>] kthread+0x99/0xa0
 [<c01012c5>] kernel_thread_helper+0x5/0x10
Code: 39 cf 7d 7e 8d 40 1c 89 45 e8 8b 45 f0 8b 15 10 b4 48 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c 8b 53 04 8b 03 <89> 50 04 89 02 8b 43 0c 31 d2 c7 03 00 01 10 00 c7 43 04 00 02
 <6>note: events/0[3] exited with preempt_count 1
xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable)
xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)
xfs: ignoring font path element /var/lib/defoma/x-ttcidfont-conf.d/dirs/CID (unreadable)
shutdown[1599]: shutting down for system halt
Xprt_64: Xprint server pid=1495 done, exitcode=0.

--=-43Ndiy4K5YNBK+xgUni4
Content-Disposition: attachment; filename=dmesg.routeirq
Content-Type: text/plain; name=dmesg.routeirq; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linux version 2.6.10 (js@ares) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Sat Dec 25 14:40:03 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux(2.6.10) ro root=303 pci=routeirq
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1694.825 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514516k/523648k available (2414k kernel code, 8648k reserved, 997k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 1317 Objects with 63 Devices 392 Methods 20 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c048e560
ACPI: setting ELCR to 0200 (from 0800)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:.......................................................................................................................................................................................................................................................
Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 38/46 Packages (1327 nodes)
Executing all Device _STA and_INI methods:..............................................................
62 Devices found containing: 62 _STA, 9 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff4ea68]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff54768]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff59ce8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5c628]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5cfe8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5dda8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5dc28]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [dff5d868]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e07e8]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e2f28]
acpi_bus-0081 [06] acpi_bus_get_device   : Error getting context for object [c14e2428]
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x35 set to 0x1
NTFS driver 2.1.22 [Flags: R/W].
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3)
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (61 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.8
ibm_acpi: http://ibm-acpi.sf.net/
acpi_bus-0081 [05] acpi_bus_get_device   : Error getting context for object [dff59ce8]
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
pnp: Device 00:09 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R9012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
^Icurrent capacity is 110648690 sectors (56652 MB)
^Inative  capacity is 117210240 sectors (60011 MB)
hda: Host Protected Area disabled.
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49459 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
 LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
kjournald starting.  Commit interval 5 seconds
Adding 498952k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable)
xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)
xfs: ignoring font path element /var/lib/defoma/x-ttcidfont-conf.d/dirs/CID (unreadable)

--=-43Ndiy4K5YNBK+xgUni4
Content-Disposition: attachment; filename=dmesg.nopnpacpi
Content-Type: text/plain; name=dmesg.nopnpacpi; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linux version 2.6.10 (js@ares) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #2 Sat Jan 8 14:29:13 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux(2.6.10) ro root=303
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1694.739 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514524k/523648k available (2410k kernel code, 8640k reserved, 996k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 1317 Objects with 63 Devices 392 Methods 20 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c048c560
ACPI: setting ELCR to 0200 (from 0800)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:.......................................................................................................................................................................................................................................................
Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 38/46 Packages (1327 nodes)
Executing all Device _STA and_INI methods:..............................................................
62 Devices found containing: 62 _STA, 9 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x35 set to 0x1
NTFS driver 2.1.22 [Flags: R/W].
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3)
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (56 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.8
ibm_acpi: http://ibm-acpi.sf.net/
acpi_bus-0081 [05] acpi_bus_get_device   : Error getting context for object [dff59ce8]
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R9012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
^Icurrent capacity is 110648690 sectors (56652 MB)
^Inative  capacity is 117210240 sectors (60011 MB)
hda: Host Protected Area disabled.
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49360 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
 LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: hda3: orphan cleanup on readonly fs
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda3: 40 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 498952k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable)
xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)
xfs: ignoring font path element /var/lib/defoma/x-ttcidfont-conf.d/dirs/CID (unreadable)

--=-43Ndiy4K5YNBK+xgUni4--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
