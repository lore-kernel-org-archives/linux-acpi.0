From: Volker Schlecht <vschlecht-hi6Y0CQ0nG0@public.gmane.org>
Subject: PROBLEM: ACPI hangs while booting Linux 2.6.0-test4
Date: Sun, 24 Aug 2003 14:12:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030824121223.GB1167@loki.dragonslair>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I can't boot Linux 2.6.0-test4 with ACPI enabled on my Hewlett Packard
ze4360ea notebook. This worked flawlessly with *-test1 through
*-test3.

The boot process hangs at the point where it says 

"ACPI Subsystem revision 20030813" (quoted from memory ... no dmesg
output available naturally)

I'm attaching succesful boot messages from *-test3, in case it
helps. If you need further information, please contact me with details
on how to acquire it.

Thanks,

Volker

Aug 23 13:15:05 loki kernel: Inspecting /boot/System.map-2.6.0-test3
Aug 23 13:15:05 loki kernel: Loaded 24899 symbols from /boot/System.map-2.6.0-test3.
Aug 23 13:15:05 loki kernel: Symbols match kernel version 2.6.0.
Aug 23 13:15:05 loki kernel: No module symbols loaded - kernel modules not enabled. 
Aug 23 13:15:05 loki kernel: Linux version 2.6.0-test3 (root@loki) (gcc version 3.3.1 (Debian)) #1 Sun Aug 10 17:48:14 CEST 2003
Aug 23 13:15:05 loki kernel: Video mode to be used for restore is 307
Aug 23 13:15:05 loki kernel: BIOS-provided physical RAM map:
Aug 23 13:15:05 loki kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 000000001bef0000 - 000000001beff000 (ACPI data)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 000000001beff000 - 000000001bf00000 (ACPI NVS)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 000000001bf00000 - 000000001c000000 (reserved)
Aug 23 13:15:05 loki kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Aug 23 13:15:05 loki kernel: 446MB LOWMEM available.
Aug 23 13:15:05 loki kernel: On node 0 totalpages: 114416
Aug 23 13:15:05 loki kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 23 13:15:05 loki kernel:   Normal zone: 110320 pages, LIFO batch:16
Aug 23 13:15:05 loki kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 23 13:15:05 loki kernel: ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7450
Aug 23 13:15:05 loki kernel: ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x1bef8bbb
Aug 23 13:15:05 loki kernel: ACPI: FADT (v001 ATI    Raptor   01540.00000) @ 0x1befee2b
Aug 23 13:15:05 loki kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x1befee9f
Aug 23 13:15:05 loki kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x1befeec7
Aug 23 13:15:05 loki kernel: ACPI: DSDT (v001    ATI U1_M1535 01540.00000) @ 0x00000000
Aug 23 13:15:05 loki kernel: ACPI: BIOS passes blacklist
Aug 23 13:15:05 loki kernel: Building zonelist for node : 0
Aug 23 13:15:05 loki kernel: Kernel command line: root=/dev/hda2 ro nomce idebus=66 pci=biosirq vga=775
Aug 23 13:15:05 loki kernel: ide_setup: idebus=66
Aug 23 13:15:05 loki kernel: Initializing CPU#0
Aug 23 13:15:05 loki kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Aug 23 13:15:05 loki kernel: Detected 1789.087 MHz processor.
Aug 23 13:15:05 loki kernel: Console: colour dummy device 80x25
Aug 23 13:15:05 loki kernel: Calibrating delay loop... 3538.94 BogoMIPS
Aug 23 13:15:05 loki kernel: Memory: 449076k/457664k available (2121k kernel code, 7824k reserved, 814k data, 136k init, 0k highmem)
Aug 23 13:15:05 loki kernel: Security Scaffold v1.0.0 initialized
Aug 23 13:15:05 loki kernel: Capability LSM initialized
Aug 23 13:15:05 loki kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 23 13:15:05 loki kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 23 13:15:05 loki kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 23 13:15:05 loki kernel: -> /dev
Aug 23 13:15:05 loki kernel: -> /dev/console
Aug 23 13:15:05 loki kernel: -> /root
Aug 23 13:15:05 loki kernel: CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Aug 23 13:15:05 loki kernel: CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
Aug 23 13:15:05 loki kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 23 13:15:05 loki kernel: CPU: L2 Cache: 512K (64 bytes/line)
Aug 23 13:15:05 loki kernel: CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Aug 23 13:15:05 loki kernel: CPU: AMD mobile AMD Athlon(tm) XP2400+ stepping 00
Aug 23 13:15:05 loki kernel: Enabling fast FPU save and restore... done.
Aug 23 13:15:05 loki kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 23 13:15:05 loki kernel: Checking 'hlt' instruction... OK.
Aug 23 13:15:05 loki kernel: POSIX conformance testing by UNIFIX
Aug 23 13:15:05 loki kernel: Initializing RT netlink socket
Aug 23 13:15:05 loki kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
Aug 23 13:15:05 loki kernel: PCI: Using configuration type 1
Aug 23 13:15:05 loki kernel: mtrr: v2.0 (20020519)
Aug 23 13:15:05 loki kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 23 13:15:05 loki kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Aug 23 13:15:05 loki kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Aug 23 13:15:05 loki kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Aug 23 13:15:05 loki kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Aug 23 13:15:05 loki kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Aug 23 13:15:05 loki kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Aug 23 13:15:05 loki kernel: ACPI: Subsystem revision 20030714
Aug 23 13:15:05 loki kernel: ACPI: Interpreter enabled
Aug 23 13:15:05 loki kernel: ACPI: Using PIC for interrupt routing
Aug 23 13:15:05 loki kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 23 13:15:05 loki kernel: PCI: Probing PCI hardware (bus 00)
Aug 23 13:15:05 loki kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 23 13:15:05 loki kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB.cale: frequency and voltage.
Aug 23 13:15:05 loki kernel: powernow: Found PSB header at c00f17f0
Aug 23 13:15:05 loki kernel: powernow: Table version: 0x12
Aug 23 13:15:05 loki kernel: powernow: Flags: 0x0 (Mobile voltage regulator)
Aug 23 13:15:05 loki kernel: powernow: Settling Time: 100 microseconds.
Aug 23 13:15:05 loki kernel: powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
Aug 23 13:15:05 loki kernel: Journalled Block Device driver loaded
Aug 23 13:15:05 loki kernel: Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Aug 23 13:15:05 loki kernel: udf: registering filesystem
Aug 23 13:15:05 loki kernel: Initializing Cryptographic API
Aug 23 13:15:05 loki kernel: ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Aug 23 13:15:05 loki kernel: request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
Aug 23 13:15:05 loki kernel: lp: driver loaded but no devices found
Aug 23 13:15:05 loki kernel: Real Time Clock Driver v1.11
Aug 23 13:15:05 loki kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 23 13:15:05 loki kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Aug 23 13:15:05 loki kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Aug 23 13:15:05 loki kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 23 13:15:05 loki kernel: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
Aug 23 13:15:05 loki kernel: ttyS2 at I/O 0x8840 (irq = 3)
Aug 23 13:15:05 loki kernel: mice: PS/2 mouse device common for all mice
Aug 23 13:15:05 loki kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 23 13:15:05 loki kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 23 13:15:05 loki kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 23 13:15:05 loki kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 23 13:15:05 loki kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Aug 23 13:15:05 loki kernel: TCP: Hash tables configured (established 32768 bind 65536)
Aug 23 13:15:05 loki kernel: Initializing IPsec netlink socket
Aug 23 13:15:05 loki kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 23 13:15:05 loki kernel: kjournald starting.  Commit interval 5 seconds
Aug 23 13:15:05 loki kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 23 13:15:05 loki kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 23 13:15:05 loki kernel: Freeing unused kernel memory: 136k freed
Aug 23 13:15:05 loki kernel: Adding 506008k swap on /dev/hda5.  Priority:-1 extents:1
Aug 23 13:15:05 loki kernel: EXT3 FS on hda2, internal journal
Aug 23 13:15:05 loki kernel: ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Aug 23 13:15:05 loki kernel: ohci-hcd: block sizes: ed 64 td 64
Aug 23 13:15:05 loki kernel: ohci-hcd 0000:00:02.0: OHCI Host Controller
Aug 23 13:15:05 loki kernel: ohci-hcd 0000:00:02.0: irq 9, pci mem dd85d000
Aug 23 13:15:05 loki kernel: ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Aug 23 13:15:05 loki kernel: hub 1-0:0: USB hub found
Aug 23 13:15:05 loki kernel: hub 1-0:0: 4 ports detected
Aug 23 13:15:05 loki kernel: drivers/usb/core/usb.c: registered new driver usbkbd
Aug 23 13:15:05 loki kernel: drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug 23 13:15:05 loki kernel: natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
Aug 23 13:15:05 loki kernel:   originally by Donald Becker <becker-H7y4myexbJEAvxtiuMwx3w@public.gmane.org>
Aug 23 13:15:05 loki kernel:   http://www.scyld.com/network/natsemi.html
Aug 23 13:15:05 loki kernel:   2.4.x kernel port by Jeff Garzik, Tjee
Aug 23 13:15:05 loki kernel: eth0: NatSemi DP8381[56] at 0xdd861000, 00:0b:cd:87:9d:89, IRQ 11.
Aug 23 13:15:05 loki kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Aug 23 13:15:05 loki kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Aug 23 13:15:05 loki kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Aug 23 13:15:05 loki kernel: ACPI: Battery Slot [BAT1] (battery present)
Aug 23 13:15:05 loki kernel: drivers/usb/core/usb.c: registered new driver hiddev
Aug 23 13:15:05 loki kernel: ACPI: Power Button (FF) [PWRF]
Aug 23 13:15:05 loki kernel: ACPI: Lid Switch [LID]
Aug 23 13:15:05 loki kernel: input: USB HID v1.10 Mouse [Adomax USB/PS2 Scroll Mouse] on usb-0000:00:02.0-1
Aug 23 13:15:05 loki kernel: drivers/usb/core/usb.c: registered new driver hid
Aug 23 13:15:05 loki kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Aug 23 13:15:05 loki kernel: drivers/usb/core/usb.c: registered new driver usbmouse
Aug 23 13:15:05 loki kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Aug 23 13:15:05 loki kernel: ACPI: Processor [CPU0] (supports C1 C2)
Aug 23 13:15:05 loki kernel: ACPI: Thermal Zone [THRM] (48 C)
Aug 23 13:15:05 loki kernel: ACPI: AC Adapter [ACAD] (on-line)

-- 
I am a traffic light, and Alan Ginzberg kidnapped my laundry in 1927!


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
