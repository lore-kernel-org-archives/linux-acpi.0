From: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Thu, 25 Aug 2005 19:22:28 +0200
Message-ID: <20050825172227.GA4055@inferi.kami.home>
References: <6694B22B6436BC43B429958787E454983CBD0C@mssmsx402nb> <2fc0cdd205082503364f255347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2fc0cdd205082503364f255347-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2005 at 12:36:52PM +0200, Mattia Dongili wrote:
> On 8/25/05, Starikovskiy, Alexey Y <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >  Could you try this patch?
> 
> That fixes it! (I attached again the diff to apply cleanly to .13-rc6-mm2)
> I'll test the thing some more to verify that the random "Invalid
> owner_id" don't appear anymore.

Bad news, see the end of the following dmesg, it is probably triggered
while polling one of the /proc/acpi/{battery,ac_adapter}/*/state dirs. I
have cpufreqd and gkrellm doing that .

I'll restore the WARN_ON(*owner_id!=0) in acpi_ut_allocate_owner_id and
see if I can get more out of it.

Linux version 2.6.13-rc6-mm2-2 (mattia@inferi) (gcc version 4.0.1 (Debian 4.0.1-2)) #2 PREEMPT Thu Aug 25 12:26:22 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0, present: 65408, spanned: 65408
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61312 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6cd0
ACPI: RSDT (v001 SONY   C0       0x20010809 PTL  0x00000000) @ 0x0fefa88f
ACPI: FADT (v001   SONY       C0 0x20010809 PTL  0x01000000) @ 0x0fefef64
ACPI: BOOT (v001   SONY       C0 0x20010809 PTL  0x00000001) @ 0x0fefefd8
ACPI: DSDT (v001   SONY       C0 0x20010809 PTL  0x0100000d) @ 0x00000000
Allocating PCI resources starting at 10000000 (gap: 10000000:ef800000)
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01200000)
Initializing CPU#0
Kernel command line: root=/dev/hda1 ro vga=extended
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 994.407 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255576k/261632k available (1999k kernel code, 5420k reserved, 541k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1991.13 BogoMIPS (lpj=3982278)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................................................................................
Table [DSDT](id 0005) - 555 Objects with 54 Devices 191 Methods 21 Regions
ACPI Namespace successfully loaded at root c03d1618
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050729
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................................
Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564 nodes)
Executing all Device _STA and_INI methods:..........................................................
58 Devices found containing: 58 _STA, 3 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 3, cardbus bridge: 0000:02:05.0
  IO window: 00005000-00005fff
  IO window: 00006000-00006fff
  PREFETCH window: 10000000-11ffffff
  MEM window: 14000000-15ffffff
PCI: Bus 7, cardbus bridge: 0000:02:05.1
  IO window: 00007000-00007fff
  IO window: 00008000-00008fff
  PREFETCH window: 12000000-13ffffff
  MEM window: 16000000-17ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: d0200000-d02fffff
  PREFETCH window: 10000000-13ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:02:05.0 to 64
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:02:05.1 to 64
Simple Boot Flag at 0x36 set to 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [ATF0] (53 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 pci_irq-0385 [10] pci_irq_derive        : Unable to derive IRQ for device 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard on isa0060/serio0
hda: FUJITSU MHV2080AH, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
perfctr: driver 2.7.17, cpu type Intel P6 at 994407 kHz
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB USB1 USB2 USB3 CRD0 CRD1  LAN  EC0 COMA MODE 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1 across:248996k
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 9, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 9, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
input: PC Speaker
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.26.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
Real Time Clock Driver v1.12
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2548b1, caps: 0x804753/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
hw_random hardware driver 1.0.0 loaded
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55483 usecs
intel8x0: clocking to 48000
  Vendor: Sony      Model: MSC-U02           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
sda: Write Protect is off
sda: Mode Sense: 00 6a 10 00
sda: assuming drive cache: write through
SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
sda: Write Protect is off
sda: Mode Sense: 00 6a 10 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.0 [104d:80e7]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.1 [104d:80e7]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
e100: Intel(R) PRO/100 Network Driver, 3.4.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
acpi_bus-0200 [12] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xd0204000, irq 9, MAC addr 08:00:46:26:50:59
ip_tables: (C) 2000-2002 Netfilter core team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.3 (2044 buckets, 16352 max) - 252 bytes per conntrack
e100: eth0: e100_watchdog: link up, 100Mbps, half-duplex
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
e100: eth0: e100_watchdog: link down
e100: eth0: e100_watchdog: link up, 100Mbps, half-duplex
Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:70
 [<c02170c1>] acpi_ut_allocate_owner_id+0x3d/0xdb
 [<c01f64ae>] acpi_ds_call_control_method+0xed/0x303
 [<c020e471>] acpi_ps_parse_aml+0xf1/0x2d0
 [<c020e485>] acpi_ps_parse_aml+0x105/0x2d0
 [<c020f9f2>] acpi_ps_execute_pass+0xa9/0xd7
 [<c020f876>] acpi_ps_execute_method+0x10a/0x1a7
 [<c020b14d>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020b009>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c020ad52>] acpi_ns_evaluate_relative+0x162/0x1ca
 [<c020a184>] acpi_evaluate_object+0x150/0x27f
 [<c01f2d82>] acpi_evaluate_integer+0xda/0x23e
 [<c015d61e>] get_unused_fd+0x5e/0xe0
 [<c016d594>] permission+0xb4/0xd0
 [<c014f844>] __vma_link+0x44/0x80
 [<c02161fd>] acpi_ut_trace+0x30/0x34
 [<c0228673>] acpi_thermal_get_temperature+0x63/0xdb
 [<c02298cb>] acpi_thermal_temp_seq_show+0x30/0x8d
 [<c01830c8>] seq_read+0x68/0x2f0
 [<c015e2b5>] vfs_read+0xb5/0x190
 [<c015e69b>] sys_read+0x4b/0x80
 [<c0103281>] syscall_call+0x7/0xb
  utmisc-0133: *** Error: Invalid owner_id: 00
Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:70
 [<c02170c1>] acpi_ut_allocate_owner_id+0x3d/0xdb
 [<c01f64ae>] acpi_ds_call_control_method+0xed/0x303
 [<c020e471>] acpi_ps_parse_aml+0xf1/0x2d0
 [<c020e485>] acpi_ps_parse_aml+0x105/0x2d0
 [<c020f9f2>] acpi_ps_execute_pass+0xa9/0xd7
 [<c020f876>] acpi_ps_execute_method+0x10a/0x1a7
 [<c020b14d>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020b009>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c020ad52>] acpi_ns_evaluate_relative+0x162/0x1ca
 [<c020a184>] acpi_evaluate_object+0x150/0x27f
 [<c01f2d82>] acpi_evaluate_integer+0xda/0x23e
 [<c015d61e>] get_unused_fd+0x5e/0xe0
 [<c016d594>] permission+0xb4/0xd0
 [<c014f844>] __vma_link+0x44/0x80
 [<c02161fd>] acpi_ut_trace+0x30/0x34
 [<c0228673>] acpi_thermal_get_temperature+0x63/0xdb
 [<c02298cb>] acpi_thermal_temp_seq_show+0x30/0x8d
 [<c01830c8>] seq_read+0x68/0x2f0
 [<c015e2b5>] vfs_read+0xb5/0x190
 [<c015e69b>] sys_read+0x4b/0x80
 [<c0103281>] syscall_call+0x7/0xb
  utmisc-0133: *** Error: Invalid owner_id: 00

-- 
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
