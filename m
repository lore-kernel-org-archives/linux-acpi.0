From: "Max Demmelbauer" <max.demmelbauer-z3Qmyc3n39kAvxtiuMwx3w@public.gmane.org>
Subject: IRQ problem with LNKG
Date: Fri, 13 Sep 2002 12:07:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <8FD16F6B8AC4B6499BE151D339AEEFD60534FF@vie-dc1.vienna.ucpag.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hello...

i have a compaq evo N160 notebook. since the acpi-path 20020503 there is
a problem with some (i think usb) IRQ's.

this error is already decribed in
http://sourceforge.net/mailarchive/message.php?msg_id=3D1825937.
today i inserted some dbg-statements to find the exact point where the
system hangs.
 --> when acpi_set_current_resources(link->handle, &buffer) is called in
function acpi_pci_link_set(pci_link.c).. (it trys to set IRQ 9 to LNKG).
... so i made a dirty hack in acpi_set_current_resources to do nothing
on IRQ 9, and than the system hangs when it init the second usb
device... :-(

ok... then i patch/override my dsdt(errors and fix see below), but the
system hangs on the same point...
i enabled verbose debugging and the last debug-msg is:
pci_link-0283[0001][22] acpi_pci_link_set :----Entry
.... so i think this problem is specific to my hardware and interrupt 9
:-(

dont know what to do???

is there a way to set a specific interrupt in the dsdt.asl for
LNKG(which??), or should i hack the kernel???
and what is LNKG used for???

...my test-system has kernel 2.4.19 and acpi-20020821

thanks for your help.

max.

dsdt errors and fix:

dsdt.asl   601:             If(CondRefOf(_OSI, Local0)) {
Error   1022 -        Object does not exist ^  (_OSI)

dsdt.asl   602:                 If(\_OSI) {
Error   1022 -   Object does not exist ^  (\_OSI)

dsdt.asl   603:                     "Windows 2001"
Error   1037 -                       parse error ^=20

dsdt.asl  1973:                     Method(_GLK, 1) {
Warning 2024 -                                ^ Reserved method has too
many arguments ( _GLK requires 0)

dsdt.asl  3166: Method(_WAK, 1) {
Warning 2026 -            ^ Reserved method must return a value (_WAK)

-> fixed all errors, but the first error is strange: Object does not
exist ^  (_OSI)
   i made a \ before _OSI without success, so i remove the whole part
from dsdt.asl
            If(CondRefOf(_OSI, Local0)) {
                If(\_OSI) {
                    "Windows 2001"
                    Store(One, WXPF)
                    \_SB_.SSMI(0x8f, 0x8)
                }
            }
   do i need this part, what is \_OSI ?? find nothing in ACPI
documentation

********************************

LNKG part in dsdt.asl:

            Device(LNKG) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x7)
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0
})
                Method(_DIS) {
                    Or(PIRG, 0x80, PIRG)
                }
                Name(_PRS, Buffer(0x6) {0x23, 0xb8, 0xce, 0x18, 0x79,
0x0 })
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    Store(Zero, IRQ0)
                    If(LNot(And(PIRG, 0x80, ))) {
                        And(PIRF, 0xf, Local0)
                        ShiftLeft(0x1, Local0, IRQ0)
                    }
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Store(Local0, PIRF)
                }
                Method(_STA) {
                    If(And(PIRG, 0x80, )) {
                        Return(0x9)
                    }
                    Else {
                        Return(0xb)
                    }
                }
            }

/proc/interrupts with my running system (2.4.18 acpi-20020404)
          CPU0      =20
  0:     227058          XT-PIC  timer
  1:       7153          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        241          XT-PIC  Intel 82801CA-ICH3
  8:          3          XT-PIC  rtc
  9:      27230          XT-PIC  acpi, eth0
 10:          2          XT-PIC  usb-uhci, i82365
 11:      18788          XT-PIC  usb-uhci
 12:         66          XT-PIC  PS/2 Mouse
 14:      27814          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0=20
LOC:     227029=20
ERR:          0
MIS:          0

dmesg of my running system (2.4.18 acpi-20020404)


Linux version 2.4.18 (root@prozessor) (gcc version 2.95.4 20011002
(Debian prerelease)) #9 Sun Jul 21 22:06:42 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff60000 (usable)
 BIOS-e820: 000000000ff60000 - 000000000ff6fc00 (ACPI data)
 BIOS-e820: 000000000ff6fc00 - 000000000ff80000 (ACPI NVS)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65376
zone(0): 4096 pages.
zone(1): 61280 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6400
ACPI: RSDT (v001 PTLTD  	 RSDT   01540.00000) @ 0x0ff69e0d
ACPI: FADT (v001 COMPAQ CPQ2C01  01540.00000) @ 0x0ff6fb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0ff6fbd8
ACPI: MADT not present
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=3Dstable ro root=3D302
Initializing CPU#0
Detected 996.705 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1985.74 BogoMIPS
Memory: 255044k/261504k available (1174k kernel code, 6072k reserved,
342k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 996.7035 MHz.
..... host bus clock speed is 132.8937 MHz.
cpu: 0, clocks: 1328937, slice: 664468
CPU0<T0:1328928,T1:664448,D:12,S:664468,C:1328937>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Bus Driver revision 20020404
ACPI: Core Subsystem revision 20020403
PCI: PCI BIOS revision 2.10 entry at 0xfd99b, last bus=3D2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00:00.00)
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 7 9 10 11 14 15)
ACPI: Embedded Controller [H8] (gpe 29)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: Found IRQ 3 for device 00:1f.1
PCI: Found IRQ 5 for device 02:04.0
PCI: Found IRQ 9 for device 02:05.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states)
ACPI: Thermal Zone [TZ0] (64 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Assigned IRQ 3 for device 00:1f.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB), CHS=3D2432/255/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i830M chipset
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] AGP 0.99 on Unknown @ 0xe0000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 22:08:03 Jul 21 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Assigned IRQ 11 for device 00:1d.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Assigned IRQ 10 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1860, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: USB hub found
hub.c: 4 ports detected
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
hub.c: USB new device connect on bus1/2/4, assigned device number 3
usb.c: USB device 3 (vend/prod 0x46d/0xc001) is not claimed by any
active driver.
Adding Swap: 489972k swap-space (priority -1)
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
PCI: Enabling device 00:1f.5 (0000 -> 0001)
PCI: Assigned IRQ 5 for device 00:1f.5
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
Linux PCMCIA Card Services 3.1.33
  kernel build: 2.4.18 #9 Sun Jul 21 22:06:42 CEST 2002
  options:  [pci] [cardbus] [apm] [pnp]
PnP: PNP BIOS installation structure at 0xc00f6470
PnP: PNP BIOS version 1.0, entry at f0000:9194, dseg at 400
Intel ISA/PCI/CardBus PCIC probe:
PCI: Assigned IRQ 10 for device 02:06.0
  TI 1410 rev 01 PCI-to-CardBus at slot 02:06, mem 0xd0202000
    host opts [0]: [ring] [pci + serial irq] [pci irq 10] [lat 168/176]
[bus 3/6]
    ISA irqs (scanned) =3D none!<6>    PCI card interrupts, PCI status
changes
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
PCI: Assigned IRQ 9 for device 02:08.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:A5:9B:ED:69, IRQ 9.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth0: 0 multicast blocks dropped.
usb-uhci.c: interrupt, status 3, frame# 1972



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
