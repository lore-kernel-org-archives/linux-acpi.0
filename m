From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: 2.4.x ACPI updates
Date: Mon, 18 Aug 2003 23:03:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F413F38.1030104@free.fr>
References: <F760B14C9561B941B89469F59BA3A8470255EEDA@orsmsx401.jf.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060500000205010008040806"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EEDA-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060500000205010008040806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> From: Jeff Garzik (jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org)
> Date: Mon Aug 18 2003 - 14:11:16 EST
> 
>     * Next message: Linus Torvalds: "Re: Fix up riscom8 driver to use work queues instead of task queueing."
>     * Previous message: Andries . Brouwer: "headers"
>     * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 
> 
> For those without BK, I have extracted Intel's latest 2.4.x ACPI updates
> into patch form:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-rc2-acpi1.patch.bz2

I was patiently waiting for sourceforge ACPI page to be updated but as 
it does not happen (Andrew?) I tried your patch and found one problem 
with it and one with the patch itself :

1) The patch does not apply correctly for driver/acpi/Config.in. As It 
is a single block to replace, I copied the new block by hand but then 
xconfig started to fail. I just reverted to original version.

2) I own a A7V that has been blacklisted by last patch while I have been 
using ACPI (mainly for software power off via power button on this 
machine :-)). Using ht only, I lost silently this feature and halted my 
machine without any form of sync which is rather bad... Seeing the 
message concerning blacklisted machine, I tried with acpi=force at boot 
time and of course booted sucessfully. Here is the dmesg attached. May I 
have a few words about the reason why this machine has been blacklisted?

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org

--------------060500000205010008040806
Content-Type: text/plain;
 name="a7v-with-acpi=force"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a7v-with-acpi=force"

Linux version 2.4.22-rc2 (root@tri-yann) (gcc version 3.3.2 20030812 (Debian prerelease)) #36 Mon Aug 18 22:28:45 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
DMI 2.3 present.
Warning: acpi=force overrules DMI blacklist: acpi=ht
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=Linux root=2101 acpi=force
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1009.021 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2011.95 BogoMIPS
Memory: 514536k/524208k available (2432k kernel code, 9280k reserved, 807k data, 120k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1009.0145 MHz.
..... host bus clock speed is 201.8028 MHz.
cpu: 0, clocks: 2018028, slice: 1009014
CPU0<T0:2018016,T1:1008992,D:10,S:1009014,C:2018028>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Disabling Via external APIC routing
PCI: Via IRQ fixup for 00:04.2, from 9 to 5
PCI: Via IRQ fixup for 00:04.3, from 9 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.4a [Flags: R/O].
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xe6000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller at PCI slot 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:DMA
hda: Maxtor 91360U4, ATA DISK drive
blk: queue c0479880, I/O limit 4095Mb (mask 0xffffffff)
hde: ST380011A, ATA DISK drive
blk: queue c047a128, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x9000-0x9007,0x8802 on irq 10
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 26588016 sectors (13613 MB) w/2048KiB Cache, CHS=1655/255/63, UDMA(33)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi1:A:6): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:3): 5.000MB/s transfers (5.000MHz, offset 15)
  Vendor: HP        Model: C1533A            Rev: A907
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 7)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: QUANTUM   Model: ATLAS10K3_36_WLS  Rev: 020W
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:6:0: Tagged Queuing enabled.  Depth 253
st: Version 20030406, bufsize 32768, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
Attached scsi disk sda at scsi1, channel 0, id 6, lun 0
SCSI device sda: 71833096 512-byte hdwr sectors (36779 MB)
 /dev/scsi/host1/bus0/target6/lun0: p1 p2 < p5 p6 p7 p8 > p3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
PCI: Enabling device 00:0c.0 (0014 -> 0016)
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[d4800000-d48007ff]  Max Packet=[2048]
video1394: Installed video1394 module
raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1010 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Creative EMU10K1 PCI Audio Driver, version 0.20, 22:29:14 Aug 18 2003
PCI: Enabling device 00:0a.0 (0004 -> 0005)
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xa400-0xa41f, IRQ 11
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/uhci.c: USB UHCI at I/O 0xd000, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver audio
audio.c: v1.0.0:USB Audio Class driver
rtl8150.c: rtl8150 based usb-ethernet driver v0.4.3 (2002/12/31)
usb.c: registered new driver rtl8150
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
lec.c: Aug 18 2003 22:24:21 initialized
VFS: Mounted root (ext2 filesystem) readonly.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[003095231000ad1f]
Mounted devfs on /dev
Freeing unused kernel memory: 120k freed
hub.c: new USB device 00:04.2-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:04.2-2.4, assigned address 3
rtl8150.c: eth0: rtl8150 is detected
Adding Swap: 1228936k swap-space (priority -1)
hub.c: new USB device 00:04.3-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
unicorn_atm: v 0.0.0, 13:49:07 Aug  9 2003
unicorn_pci: v 0.0.0, 13:49:10 Aug  9 2003
unicorn_pci: MSW parameters: 
ActivationMode=1
ActTimeout=300000
AutoActivation=1
DebugLevel=0
DownstreamRate=8192
unicorn_pci: ExchangeDelay=20
FmPollingRate=1000
g_RefGain=38
g_Teqmode=7
InitTimeout=20000
Interoperability=0
unicorn_pci: LCD_Trig=15000
LOS_LOF_Trig=5000
LoopbackMode=0
MswDebugLevel=2
RetryTime=5000
TrainingDelay=120
unicorn_pci: useRFC019v=0
useRFC029v=8000
useRFC040v=0
useRFC041v=1
setINITIALDAC=64
unicorn_pci: useRFCFixedRate=1
useVCXO=0
_no_TS652=0
unicorn_pci: driver parameters: DebugLevel=0
PCI: Enabling device 00:09.0 (0014 -> 0016)
unicorn_msw: FmPollingRate=1000ms,InitTimeout=20000ms,ActTimeout=300000
unicorn_msw: AMU: ECI PATCH DISABLED
unicorn_pci: AdslStatus=1
unicorn_msw: Current Modem State (3): ACTIVATING
unicorn_pci: MSW state: ACTIVATING
spurious 8259A interrupt: IRQ7.
unicorn_msw: Event Reported (3): Initializing
unicorn_pci: MSW event: TO INITIALIZING
unicorn_msw: Current Modem State (6): INITIALIZING
unicorn_pci: MSW state: INITIALIZING
unicorn_pci: upRate=377cells/s,downRate=1509cells/s
unicorn_pci: AdslStatus=1
unicorn_msw: Event Reported (4): Showtime
unicorn_pci: MSW event: AMSW SHOWTIME
unicorn_msw: Current Modem State (9): SHOWTIME_L0
unicorn_pci: MSW state: SHOWTIME L0
unicorn_atm: ESI=00:81:77:12:ec:73

--------------060500000205010008040806--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
