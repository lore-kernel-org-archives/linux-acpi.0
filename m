From: Nguyen The Toan <ntt-0ZXR/GfGkoW3j4TM+ZUt8PZ8FUJU4vz8@public.gmane.org>
Subject: Thinkpad X20: How to wake up from sleep?
Date: Sat, 18 Oct 2003 16:09:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310181609.02372.ntt@control.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I have a Thinkpad X20 and I'm using 2.6.0-test8. After issuing 
	echo 3 > /proc/acpi/sleep
the laptop seems to go into sleep properly. However, I cannot wakeup using any 
key (Fn, power, Fn+F4, Fn+F3...). I notices that when I use apm, the kernel 
says:

IBM machine detected. Enabling interrupts during APM calls.

Does anybody know if there's a way to enable keyboard interrupts during sleep 
in ACPI? 

Thanks,
Toan

PS: below is the output of dmesg:

Linux version 2.6.0-test8 (root-VI0D5Bl9EBstwKmt+vA9ytAjP3GQurS+@public.gmane.org) (gcc version 3.3.2 
20031005 (Debian prerelease)) #2 Sat Oct 18 13:30:29 CEST 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dd000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ffec00 (ACPI data)
 BIOS-e820: 0000000013ffec00 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77808 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6ec0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x13ff5c64
ACPI: FADT (v001 IBM    TP-X21   0x06040000  0x00000000) @ 0x13ffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x13ffebd9
ACPI: DSDT (v001 IBM    TP-X21   0x06040000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro vga=791
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 442.720 MHz processor.
Console: colour dummy device 80x25
Memory: 320928k/327616k available (1634k kernel code, 5928k reserved, 685k 
data, 132k init, 0k highmem)
Calibrating delay loop... 1048.57 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node 
d3fddd20), AE_AML_NO_RETURN_VALUE
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSIO] (on)
ACPI: Power Resource [PSER] (off)
ACPI: Embedded Controller [EC] (gpe 9)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vesafb: framebuffer at 0xf5000000, mapped to 0xd480f000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:57aa
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
speedstep-smi: signature:0x47534943, command:0x008200b2, event:0x00c000b3, 
perf_level:0x07d00000.
speedstep-smi: could not detect low and high frequencies by SMI call.
cpufreq: change to 0 MHz succeded
cpufreq: change to 4 MHz succeded
speedstep-smi: workaround worked.
cpufreq: currently at high speed setting - 600 MHz
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (51 C)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/
eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:47:0F:8E:7A, IRQ 11.
  Board assembly 000695-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=41344/15/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00001820
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ACPI: (supports S0 S1 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 132k freed
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
hub 1-1:1.0: new USB device on port 2, assigned address 3
NET: Registered protocol family 1
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:07.2-1.2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
NET: Registered protocol family 17
loop: loaded (max 8 devices)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring 
Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 
3.5
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
SCSI subsystem initialized
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NTFS driver 2.1.4 [Flags: R/W MODULE].
NTFS volume version 3.1.
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
Real Time Clock Driver v1.12
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:08.0 [1014:0185]
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:08.1 [1014:0185]
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000006
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
nfs warning: mount version older than kernel
usb 1-1.2: USB disconnect, address 3
usb 1-1: USB disconnect, address 2
hub 1-0:1.0: new USB device on port 1, assigned address 4
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
hub 1-1:1.0: new USB device on port 2, assigned address 5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:07.2-1.2


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
