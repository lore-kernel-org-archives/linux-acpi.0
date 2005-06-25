From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: S3 works but nastyness in logs
Date: Sat, 25 Jun 2005 14:56:10 +0200
Message-ID: <20050625125610.GA32445@platane.lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nef2.ens.fr id j5PCuBY2088288

S3 seems to be working very well on my ASUS S5200N laptop; yesterday, I
suspended and resumed 5 times in a row without any apparent problem.

However, in the logs, I have, at each time the system resumes,

-------------------------------------------------------------------------=
--
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
-------------------------------------------------------------------------=
---

And, on the five cycles, I had twice the following:

-------------------------------------------------------------------------=
---
BUG: soft lockup detected on CPU#0!

Pid: 3122, comm:                 echo
EIP: 0060:[<c014a820>] CPU: 0
EIP is at suspend_enter+0x29/0x46
 EFLAGS: 00000286    Tainted: GF      (2.6.11-1.1369_FC4)
EAX: 00000000 EBX: 00000000 ECX: c03e5798 EDX: c03da0dc
ESI: 00000286 EDI: 00000003 EBP: 00000006 DS: 0068 ES: 007b
CR0: 8005003b CR2: b7f0b000 CR3: 024fa000 CR4: 000006d0
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
 [<c01505e1>] softlockup_tick+0x95/0x1b8
 [<c012cd3d>] update_wall_time+0x14/0x40
 [<c012d331>] do_timer+0x4d/0xfb
 [<c0108c2e>] timer_interrupt+0x60/0x1b5
 [<c02d2f40>] usb_hcd_irq+0x22/0x52
 [<c015085d>] handle_IRQ_event+0x2e/0x5a
 [<c015093c>] __do_IRQ+0xb3/0x367
 [<c0105b1d>] do_IRQ+0x4a/0x82
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103c0e>] common_interrupt+0x1a/0x20
 [<c014a820>] suspend_enter+0x29/0x46
 n<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
------------------------------------------------------------------------

It doesn't seem to be important as the system keeps working, but it is
not nice.

The computer is running a fedora core n with the stock kernel
(kernel-2.6.11-1.1369_FC4), plus the ipw2100 drivers from atrpms.net
(ipw2100-kmdl-2.6.11-1.1369_FC4-1.1.0-31.rhfc4.at). The processor is an
intel pentium M, and I have attached the full dmesg with the five
suspends/resumes and the output of lspci -vv.

Please tell me if you need more info.

Thanks,

	=C9ric Brunet

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.11-1.1369_FC4 (bhcompile-VuzbdAJ76DUiarxAAYPCSB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org) (gcc version 4.0.0 20050525 (Red Hat 4.0.0-9)) #1 Thu Jun 2 22:55:56 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f740000 (usable)
 BIOS-e820: 000000000f740000 - 000000000f750000 (ACPI data)
 BIOS-e820: 000000000f750000 - 000000000f800000 (ACPI NVS)
0MB HIGHMEM available.
247MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 63296
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59200 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4ff0
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000427 MSFT 0x00000097) @ 0x0f740000
ACPI: FADT (v002 A M I  OEMFACP  0x02000427 MSFT 0x00000097) @ 0x0f740200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000427 MSFT 0x00000097) @ 0x0f740300
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000427 MSFT 0x00000097) @ 0x0f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x02000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 0f800000 (gap: 0f800000:f0800000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ acpi_sleep=s3_bios
Initializing CPU#0
CPU 0 irqstacks, hard=c0457000 soft=c0456000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 600.029 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 245548k/253184k available (2518k kernel code, 7056k reserved, 690k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpj=593920)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f3bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 00b8)
    ACPI-0077: *** Warning: Invalid FADT value PM_TM_LEN=3 at offset 5B FADT=cf73a740
checking if image is initramfs... it is
softlockup thread 0 started up.
Freeing initrd memory: 1082k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1119603417.898:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 42BD35A990375F72
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FN00] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (31 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
P0P1 LAN0 CBS0 CBS1 P394 MPCI MODM USB1 USB2 USB3 EHCI SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 180k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 17
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
ieee80211_crypt: no version for "struct_module" found: kernel tainted.
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.1.0
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: RealTek RTL8139 at 0xc800, 00:0e:a6:b4:4a:cc, IRQ 5
eth1:  Identified 8139 chip type 'RTL-8101'
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
intel8x0_measure_ac97_clock: measured 49244 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
hw_random: RNG not detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x0000d480
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 4, io base 0x0000d800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 7, io base 0x0000d880
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt 0000:01:03.0[A] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:01:03.0 [1043:1824]
Yenta: ISA IRQ mask 0x0000, PCI irq 7
Socket status: 30000006
ACPI: PCI Interrupt 0000:01:03.1[B] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:01:03.1 [1043:1824]
Yenta: ISA IRQ mask 0x0000, PCI irq 7
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[fe8ff000-fe8ff7ff]  Max Packet=[2048]
ACPI: AC Adapter [AC0] (off-line)
Asus Laptop ACPI Extras version 0.29
  S5N model detected, supported
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000318ef2b]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
EXT3 FS on hda6, internal journal
Adding 755012k swap on /dev/hda5.  Priority:-1 extents:1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1978 buckets, 15824 max) - 272 bytes per conntrack
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_write 1: semaphore is not ready for register 0x54
lp: driver loaded but no devices found
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03e6820(lo)
IPv6 over IPv4 tunneling driver
eth1: link down
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
[drm] Initialized i915 1.1.0 20040405 on minor 0: 
[drm] Initialized i915 1.1.0 20040405 on minor 1: 
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
ieee80211_crypt: registered algorithm 'WEP'
eth0: no IPv6 routers present
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x72
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: ==============================================================================|
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_write 1: semaphore is not ready for register 0x26
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0x2]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: link down
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: ================================================================================|
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0x2]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: link down
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: ================================================================================|
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#0!

Pid: 3122, comm:                 echo
EIP: 0060:[<c014a820>] CPU: 0
EIP is at suspend_enter+0x29/0x46
 EFLAGS: 00000286    Tainted: GF      (2.6.11-1.1369_FC4)
EAX: 00000000 EBX: 00000000 ECX: c03e5798 EDX: c03da0dc
ESI: 00000286 EDI: 00000003 EBP: 00000006 DS: 0068 ES: 007b
CR0: 8005003b CR2: b7f0b000 CR3: 024fa000 CR4: 000006d0
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
 [<c01505e1>] softlockup_tick+0x95/0x1b8
 [<c012cd3d>] update_wall_time+0x14/0x40
 [<c012d331>] do_timer+0x4d/0xfb
 [<c0108c2e>] timer_interrupt+0x60/0x1b5
 [<c02d2f40>] usb_hcd_irq+0x22/0x52
 [<c015085d>] handle_IRQ_event+0x2e/0x5a
 [<c015093c>] __do_IRQ+0xb3/0x367
 [<c0105b1d>] do_IRQ+0x4a/0x82
 =======================
 [<c0103c0e>] common_interrupt+0x1a/0x20
 [<c014a820>] suspend_enter+0x29/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0x2]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: link down
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: ================================================================================|
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0x2]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: link down
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Stopping tasks: ================================================================================|
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2126
in_atomic():0, irqs_disabled():1
 [<c015c27e>] kmem_cache_alloc+0x3c/0x49
 [<c02481d6>] acpi_pci_link_set+0x3f/0x17f
 [<c0248620>] irqrouter_resume+0x14/0x28
 [<c02878ee>] sysdev_resume+0x3d/0xb5
 [<c028b9e7>] device_power_up+0x5/0xa
 [<c014a83b>] suspend_enter+0x44/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#0!

Pid: 3290, comm:                 echo
EIP: 0060:[<c014a820>] CPU: 0
EIP is at suspend_enter+0x29/0x46
 EFLAGS: 00000286    Tainted: GF      (2.6.11-1.1369_FC4)
EAX: 00000000 EBX: 00000000 ECX: c03e5798 EDX: c03da0dc
ESI: 00000286 EDI: 00000003 EBP: 00000006 DS: 0068 ES: 007b
CR0: 8005003b CR2: b7f0b000 CR3: 0a389000 CR4: 000006d0
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
 [<c01505e1>] softlockup_tick+0x95/0x1b8
 [<c012ce5f>] count_active_tasks+0xd/0x16
 [<c012d350>] do_timer+0x6c/0xfb
 [<c0108c2e>] timer_interrupt+0x60/0x1b5
 [<c02d2f40>] usb_hcd_irq+0x22/0x52
 [<c015085d>] handle_IRQ_event+0x2e/0x5a
 [<c015093c>] __do_IRQ+0xb3/0x367
 [<c0105b1d>] do_IRQ+0x4a/0x82
 =======================
 [<c0103c0e>] common_interrupt+0x1a/0x20
 [<c014a820>] suspend_enter+0x29/0x46
 [<c014a7c9>] suspend_prepare+0x57/0x85
 [<c014a8ae>] enter_state+0x49/0x54
 [<c024569a>] acpi_system_write_sleep+0x5a/0x6c
 [<c0245640>] acpi_system_write_sleep+0x0/0x6c
 [<c017b8c4>] vfs_write+0x9e/0x110
 [<c017b9e1>] sys_write+0x41/0x6a
 [<c0103a51>] syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0x2]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:03.2[C] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
eth1: link down
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKC] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xfebff800
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-vv

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1821
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] Vendor Specific Information

00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 182a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 182b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1712
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at feb00000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at dc00 [size=8]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1712
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at fea80000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d480 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 4
	Region 4: I/O ports at d800 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1828
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 7
	Region 4: I/O ports at d880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1829
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 3
	Region 0: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe700000-fe8fffff
	Prefetchable memory behind bridge: de500000-de6fffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1828
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 0f800000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev ff) (prog-if ff)
	!!! Unknown header type 7f

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1803
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at 0f800400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at 0f800600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1826
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 0: I/O ports at e200 [size=256]
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1824
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at 0f801000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 0fc00000-0ffff000 (prefetchable)
	Memory window 1: 10000000-103ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1824
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at 0f802000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1827
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1045
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at fe8ff800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 Network controller: Intel Corporation PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corporation MIM2000/Centrino
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size 10
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at fe8fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
