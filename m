From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Re: Why do I have to set pci=noacpi for network card to work?
Date: Tue, 26 Apr 2005 14:32:41 -0500
Message-ID: <200504261432.41890.gkanis@cems.umn.edu>
References: <971FCB6690CD0E4898387DBF7552B90E014B561F@orsmsx403.amr.corp.intel.com> <200504261426.03529.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZdpbCorbb0Aye4w"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504261426.03529.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
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

--Boundary-00=_ZdpbCorbb0Aye4w
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here they are...

Vasilis

PS. Bob, my email to you what returned back, because the server thought that I 
am sending you a spam. So, I am sending it to the list


> On Tuesday 26 April 2005 02:16 pm, Moore, Robert wrote:
> > Please send the dsdt and dmesg, we would like to examine them.
> > Bob
> >
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Vasileios Gkanis
> > > Sent: Tuesday, April 26, 2005 12:03 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Cc: Bjorn Helgaas; Li, Shaohua
> > > Subject: Re: [ACPI] Why do I have to set pci=noacpi for network card
> >
> > to
> >
> > > work?
> > >
> > > > Looks to me like your _PRT references LNKA, which should
> > > > appear in the namespace.  But apparently it doesn't.
> > > >
> > > > That's a bug in your firmware.  Are any BIOS upgrades available?
> > >
> > > Unfortunately, not :(
> > >
> > > > You could disassemble your DSDT to explore this further.
> > > > In short, "cp /proc/acpi/dsdt dsdt; iasl -d dsdt;
> > > > cat dsdt.dsl".
> > > >
> > > > You can get iasl here:
> > > >     http://www.intel.com/technology/IAPC/acpi/downloads.htm
> > >
> > > I followed the instructions found at this link
> > > http://forums.gentoo.org/viewtopic-t-122145-highlight-dsdt.html
> > >
> > > and when I compiled the dsdt.dsl file I got the following
> >
> > errros/warning
> >
> > > Intel ACPI Component Architecture
> > > ASL Optimizing Compiler / AML Disassembler version 20050309 [Apr 26
> >
> > 2005]
> >
> > > Copyright (C) 2000 - 2005 Intel Corporation
> > > Supports ACPI Specification Revision 3.0
> > >
> > > dsdt.dsl   205:     Method (_WAK, 1, NotSerialized)
> > > Warning  2026 -                ^ Reserved method must return a value
> > > (_WAK)
> > >
> > > dsdt.dsl  1664:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1672:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1680:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1688:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1696:                             \_SB.PCI0.LPCB.LNKB,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKB)
> > >
> > > dsdt.dsl  1704:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1712:                             \_SB.PCI0.LPCB.LNKC,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKC)
> > >
> > > dsdt.dsl  1720:                             \_SB.PCI0.LPCB.LNKD,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKD)
> > >
> > > dsdt.dsl  1728:                             \_SB.PCI0.LPCB.LNKH,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKH)
> > >
> > > dsdt.dsl  1736:                             \_SB.PCI0.LPCB.LNKH,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKH)
> > >
> > > dsdt.dsl  1744:                             \_SB.PCI0.LPCB.LNKG,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKG)
> > >
> > > dsdt.dsl  1752:                             \_SB.PCI0.LPCB.LNKG,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKG)
> > >
> > > dsdt.dsl  1760:                             \_SB.PCI0.LPCB.LNKF,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKF)
> > >
> > > dsdt.dsl  1768:                             \_SB.PCI0.LPCB.LNKE,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKE)
> > >
> > > dsdt.dsl  1776:                             \_SB.PCI0.LPCB.LNKC,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKC)
> > >
> > > dsdt.dsl  1784:                             \_SB.PCI0.LPCB.LNKD,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKD)
> > >
> > > dsdt.dsl  1792:                             \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                         Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1864:                                 \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  1872:                                 \_SB.PCI0.LPCB.LNKB,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKB)
> > >
> > > dsdt.dsl  1880:                                 \_SB.PCI0.LPCB.LNKC,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKC)
> > >
> > > dsdt.dsl  1888:                                 \_SB.PCI0.LPCB.LNKD,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKD)
> > >
> > > dsdt.dsl  2756:                                 \_SB.PCI0.LPCB.LNKD,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKD)
> > >
> > > dsdt.dsl  2764:                                 \_SB.PCI0.LPCB.LNKB,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKB)
> > >
> > > dsdt.dsl  2772:                                 \_SB.PCI0.LPCB.LNKC,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKC)
> > >
> > > dsdt.dsl  2780:                                 \_SB.PCI0.LPCB.LNKA,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKA)
> > >
> > > dsdt.dsl  2788:                                 \_SB.PCI0.LPCB.LNKB,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKB)
> > >
> > > dsdt.dsl  2796:                                 \_SB.PCI0.LPCB.LNKC,
> > > Error    1022 -                             Object does not exist ^
> > > (\_SB.PCI0.LPCB.LNKC)
> > >
> > > ASL Input:  dsdt.dsl - 7057 lines, 253513 bytes, 3592 keywords
> > > Compilation complete. 27 Errors, 1 Warnings, 0 Remarks, 957
> >
> > Optimizations
> >
> > > I know how to fix the warning, but what I am suppose to do with the
> > > errors?
> > >
> > > Here are the lines 1660-1670 of the dsdi.dsl file
> > >
> > >          Return (Package (0x11)
> > >                     {
> > >                         Package (0x04)
> > >                         {
> > >                             0x0001FFFF,
> > >                             0x00,
> > >                             \_SB.PCI0.LPCB.LNKA,
> > >                             0x00
> > >                         },
> > >
> > >                         Package (0x04)
> > >                         {
> > >                             0x0002FFFF,
> > >                             0x00,
> > >                             \_SB.PCI0.LPCB.LNKA,
> > >                             0x00
> > >                         },
> > >
> > > How serious this problem is? Could this be the reason for the need to
> >
> > use
> >
> > > the
> > > command acpi=noirq?
> > >
> > > Thank you,
> > > Vasilis
> > >
> > >
> > > -------------------------------------------------------
> > > SF.Net email is sponsored by: Tell us your software development plans!
> > > Take this survey and enter to win a one-year sub to SourceForge.net
> > > Plus IDC's 2005 look-ahead and a copy of this survey
> > > Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel

--Boundary-00=_ZdpbCorbb0Aye4w
Content-Type: text/x-diff;
  charset="utf-8";
  name="dmesg.dat"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.dat"

 BIOS-e820: 000000001feea000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130784
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126688 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 GATEWA                                ) @ 0x000f6a90
ACPI: RSDT (v001 GATEWA M460     0x20040113  LTP 0x00000000) @ 0x1fee1cd7
ACPI: MADT (v001 GATEWA M460     0x20040113 LOHR 0x0000005f) @ 0x1fee9e88
ACPI: FADT (v001 GATEWA M460     0x20040113 LOHR 0x0000005f) @ 0x1fee9ef0
ACPI: BOOT (v001 GATEWA M460     0x20040113  LTP 0x00000001) @ 0x1fee9fd8
ACPI: MCFG (v001 GATEWA M460     0x20040113 LOHR 0x0000005f) @ 0x1fee9f9c
ACPI: SSDT (v001 GATEWA M460     0x20050113 INTL 0x20030224) @ 0x1fee20dd
ACPI: SSDT (v001 GATEWA M460     0x20050113 INTL 0x20030224) @ 0x1fee1f05
ACPI: SSDT (v001 GATEWA M460     0x20050113 INTL 0x20030224) @ 0x1fee1d17
ACPI: DSDT (v001 GATEWA M460     0x20040113 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 20000000 (gap: 20000000:c0000000)
Built 1 zonelists
Kernel command line: root/dev/hda5 vga=792 acpi=noirq
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1996.083 MHz processor.
Using pmtmr for high-res timesource
dyn-tick: Found suitable timer: pmtmr
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513912k/523136k available (2875k kernel code, 8720k reserved, 960k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0e00 (from 0c00)
NET: Registered protocol family 16
dyn-tick: Registering dynamic tick timer v050301-1
PCI: PCI BIOS revision 2.10 entry at 0xfd954, last bus=7
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPCB.LNKA] in namespace, AE_NOT_FOUND
search_node dfec1ca0 start_node dfec1ca0 return_node 00000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node dfec1ca0), AE_NOT_FOUND
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPCB.LNKA] in namespace, AE_NOT_FOUND
search_node dfec1d80 start_node dfec1d80 return_node 00000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.PEGP._PRT] (Node dfec1d80), AE_NOT_FOUND
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPCB.LNKD] in namespace, AE_NOT_FOUND
search_node dfec3cc0 start_node dfec3cc0 return_node 00000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.PCIB._PRT] (Node dfec3cc0), AE_NOT_FOUND
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Device [P_D1] status [00000008]: functional but not present; setting present
SCSI subsystem initialized
usbcore: registered new driver hub
PCI: Probing PCI hardware
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
audit: initializing netlink socket (disabled)
audit(1114514545.377:0): initialized
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Please try using pci=biosirq.
PCI: Setting latency timer of device 0000:00:01.0 to 64
pcie_portdrv_probe->Dev[2591:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xd0000000, mapped to 0xe0880000, using 4608k, total 131072k
vesafb: mode is 1024x768x24, linelength=3072, pages=55
vesafb: protected mode interface info at c000:56bb
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Thermal Zone [THRM] (65 C)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18c0-0x18c7, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: HTS548080M9AT00, ATA DISK drive
hdb: QSI DVD+/-RW SDW-082, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ata_piix version 1.03
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x2080 ctl 0x18FA bmdma 0x18E0 irq 11
ata2: SATA max UDMA/133 cmd 0x18F0 ctl 0x18D6 bmdma 0x18E8 irq 11
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: SATA port has no device.
spurious 8259A interrupt: IRQ7.
scsi1 : ata_piix
ohci1394: $Rev: 1250 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[c8218000-c82187ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugs is not available
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xc8000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 10, io base 0x00001820
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x00001840
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00001860
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-2: new full speed USB device using uhci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x043D pid 0x009F
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [A4Tech USB Optical Mouse] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
dyn-tick: Maximum ticks to skip limited to 54
dyn-tick: Timer using dynamic tick
ACPI wakeup devices: 
 LID AZAL USB1 USB2 USB3 USB4 USB7 LANC CRDB MODM 
ACPI: (supports S0 S3 S4 S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0b804600002fc]
Synaptics Touchpad, model: 1
 Firmware: 6.2
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Adding 1959888k swap on /dev/hda6.  Priority:-1 extents:1
tg3.c:v3.25 (March 24, 2005)
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:b8:7c:1c:5f
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 430 MBytes.
[fglrx] module loaded - fglrx 8.12.10 [Apr  4 2005] on minor 0
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.3
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
input: PS/2 Generic Mouse on synaptics-pt/serio0
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using r5 hash to sort names
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
ReiserFS: hda10: found reiserfs format "3.6" with standard journal
ReiserFS: hda10: using ordered data mode
ReiserFS: hda10: journal params: device hda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda10: checking transaction log (hda10)
ReiserFS: hda10: Using r5 hash to sort names
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 49889 usecs
intel8x0: clocking to 48000
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
mtrr: base(0xd0000000) is not aligned on a size(0x7ff0000) boundary
[fglrx:firegl_addmap] *ERROR* mtrr allocation failed (-22)
[fglrx] free  PCIe = 54804480
[fglrx] max   PCIe = 54804480
[fglrx] free  LFB = 119762944
[fglrx] max   LFB = 119762944
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total PCIe = 16384
eth1: no IPv6 routers present
eth0: no IPv6 routers present
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--Boundary-00=_ZdpbCorbb0Aye4w
Content-Type: application/x-gzip;
  name="dsdt.dsl.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dsdt.dsl.gz"

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
X9XhJjblEJPi//35F9KL/x8/DE0vSd4DAA==

--Boundary-00=_ZdpbCorbb0Aye4w--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
