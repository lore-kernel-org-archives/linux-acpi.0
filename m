From: Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
Subject: DSDT with many errors on an Acer Extensa 4101 WLMi
Date: Mon, 14 Mar 2005 20:24:43 +0100
Message-ID: <4235E4FB.8080404@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060809010003000308020002"
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

This is a multi-part message in MIME format.
--------------060809010003000308020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello!

I recently got my new Acer Extensa 4101 WLMi notebook and tried to
install CRUX Linux - everything worked quite good, however I had to
disable I/O APIC, else my kernel wouldn't boot. I have also applied the
current ACPI patch to the kernel (2.6.11.3), however there are still
many errors regarding ACPI when I boot the system. After I decompiled
and tried to recompile the DSDT I already could see why.. ;-) I've read
all those HOWTOs on the Internet (including the good one from Gentoo
:)), but I just don't know how to fix these weird errors. :-/ Maybe
someone who knows the process of fixing a DSDT better can help me? I
also can't read the battery state from /proc/acpi/battery/BAT1/state.
This is what I get:

# cat /proc/acpi/battery/BAT1/state
present:		yes
ERROR: Unable to read battery status

I've tried applying the patches from the sbs-project, but they don't
apply cleanly to my DSDT:

# patch --dry-run < /root/sbs-cm-20050213/acer-tm4xxx-sbs-cm.diff
patching file dsdt.dsl
Hunk #1 succeeded at 3811 (offset 170 lines)
Hunk #2 FAILED at 3839.
Hunk #3 FAILED at 5342.

I've attached the decompiled DSDT, the error messages iasl produced,
when I tried recompiling it and the output of dmesg. I used the newest
version of the iasl. Note that ACPI says "ACPI: Battery Slot [BAT1]
(battery absent)", which is simply wrong, as the battery is correctly
installed and works.

Thank you very much!
Philipp Wollermann

- --
/              Philipp Wollermann
|      eMail : phil_wo-hi6Y0CQ0nG0@public.gmane.org
|        WWW : http://www.philwo.de/
|
| GPG-Key-ID : 0x23498808
|    GPG-Key : http://www.philwo.de/gpgkey.txt
\ Fingerprint: D8A1 BDF1 3C63 1F00 CB8D  4BC4 281E B1FA 2349 8808
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCNeT7KB6x+iNJiAgRAi4IAKDsj/WJ5x/XwWseu0IfqLrnMMIJ6gCeNMyM
4F4+OutWEKvK8ipwKsEt4JA=
=CRPO
-----END PGP SIGNATURE-----

--------------060809010003000308020002
Content-Type: application/octet-stream;
 name="dsdt.dsl.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dsdt.dsl.bz2"

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
wA==
--------------060809010003000308020002
Content-Type: text/plain;
 name="iasl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iasl.txt"


Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050211 [Mar 14 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   450:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -      Object does not exist ^  (CFGD)

dsdt.dsl   450:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -                  Object does not exist ^  (CFGD)

dsdt.dsl   470:                     And (CFGD, 0x3F, CFGD)
Error    1022 -       Object does not exist ^  (CFGD)

dsdt.dsl   470:                     And (CFGD, 0x3F, CFGD)
Error    1022 -                   Object does not exist ^  (CFGD)

dsdt.dsl   584:             If (LEqual (And (PDC0, 0x0A), 0x0A))
Error    1022 -           Object does not exist ^  (PDC0)

dsdt.dsl   589:             If (LEqual (And (PDC1, 0x0A), 0x0A))
Error    1021 -                                 ^ Object not accessible from this scope (PDC1)

dsdt.dsl  1901:                     Method (DRUL, 1, NotSerialized)
Warning  2019 -                                ^ Not all control paths return a value (DRUL)

dsdt.dsl  2548:                         Method (_DCK, 1, NotSerialized)
Warning  2019 -                                    ^ Not all control paths return a value (_DCK)

dsdt.dsl  2548:                         Method (_DCK, 1, NotSerialized)
Warning  2026 -                                    ^ Reserved method must return a value (_DCK)

dsdt.dsl  2603:                             And (CFGD, 0x3F, CFGD)
Error    1022 -               Object does not exist ^  (CFGD)

dsdt.dsl  2603:                             And (CFGD, 0x3F, CFGD)
Error    1022 -                           Object does not exist ^  (CFGD)

dsdt.dsl  2612:                             Or (CFGD, 0xC0, CFGD)
Error    1022 -              Object does not exist ^  (CFGD)

dsdt.dsl  2612:                             Or (CFGD, 0xC0, CFGD)
Error    1022 -                          Object does not exist ^  (CFGD)

dsdt.dsl  6345:                 Z00C, 
Error    1022 -                    ^ Object does not exist (Z00C)

dsdt.dsl  6346:                 Z00C, 
Error    1022 -                    ^ Object does not exist (Z00C)

dsdt.dsl  6602:                 Z00C, 
Error    1022 -                    ^ Object does not exist (Z00C)

dsdt.dsl  6603:                 Z00C, 
Error    1022 -                    ^ Object does not exist (Z00C)

ASL Input:  dsdt.dsl - 6922 lines, 243331 bytes, 3200 keywords
Compilation complete. 14 Errors, 3 Warnings, 0 Remarks, 1114 Optimizations

--------------060809010003000308020002
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

 0x8086a201 base: 0x0
Allocating PCI resources starting at 20000000 (gap: 20000000:c0000000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=CRUX ro root=306 video=vesafb:redraw,800x600@60
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c05a0000 soft=c059f000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1596.730 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512784k/522752k available (3242k kernel code, 9464k reserved, 1296k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3137.53 BogoMIPS (lpj=1568768)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.........................................................................................................................................................................................................................
Table [DSDT](id F007) - 859 Objects with 69 Devices 217 Methods 27 Regions
Parsing all Control Methods:...
Table [SSDT](id F003) - 5 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:.
Table [SSDT](id F004) - 1 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:..
Table [SSDT](id F005) - 10 Objects with 0 Devices 2 Methods 0 Regions
ACPI Namespace successfully loaded at root c05bef20
ACPI: setting ELCR to 0200 (from 0c00)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7be, last bus=7
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 3 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:......................................................  psargs-0352: *** Error: Looking up [Z00C] in namespace, AE_NOT_FOUND
search_node dfe185a8 start_node dfe185a8 return_node 00000000

  nsinit-0300 [15] ns_init_one_object    : Could not execute arguments for [PBST] (Package), AE_NOT_FOUND
...  psargs-0352: *** Error: Looking up [Z00C] in namespace, AE_NOT_FOUND
search_node dfe19fa8 start_node dfe19fa8 return_node 00000000

  nsinit-0300 [15] ns_init_one_object    : Could not execute arguments for [PBST] (Package), AE_NOT_FOUND
...............
Initialized 27/27 Regions 0/0 Fields 28/28 Buffers 17/27 Packages (884 nodes)
Executing all Device _STA and_INI methods:.....................................................................
69 Devices found containing: 69 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
acpi_bus-0077 [18] acpi_bus_get_device   : No context for object [dfe09a28]
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
     osl-0958 [42] os_wait_semaphore     : Failed to acquire semaphore[c147e5a0|1|0], AE_TIME
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
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
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:03' and the driver 'system'
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:01.0[A] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1c.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI interrupt 0000:00:1c.1[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1c.2[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: (C) 1988-2003, ATI Technologies Inc. , M26-P, 01.00 (OEM: ATI ATOMBIOS)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:ad70
vesafb: pmi: set display start = c00cadfe, set palette = c00cae3e
vesafb: hardware supports DCC2 transfers
vesafb: monitor limits: vf = 59 Hz, hf = 49 kHz, clk = 68 MHz
vesafb: trying maximum allowed refresh rate
vesafb: using default BIOS refresh rate
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
vesafb: framebuffer at 0xd0000000, mapped to 0xe0880000, using 937k, total 16384k
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
acpi_processor-0484 [26] acpi_processor_get_inf: Error getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (45 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0x0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe-l3A5Bk7waGM@public.gmane.org) and petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
tg3.c:v3.23 (February 15, 2005)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:06:08.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet xx:xx:xx:xx:xx:xx
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18c0-0x18c7, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: IC25N080ATMR04-0, ATA DISK drive
hdb: MATSHITAUJ-831D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI interrupt 0000:06:01.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:06:01.0 [1025:0066]
Yenta: ISA IRQ mask 0x00f8, PCI irq 10
Socket status: 30000006
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc8000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.3: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 10, io base 0x1860
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
i2c /dev entries driver
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1e.2[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 49780 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH with unknown codec at 0xc8000800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
ACPI wakeup devices: 
RP01 RP02 RP04 USB1 USB2 USB3 USB4 USB7 LANC MODM 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

--------------060809010003000308020002--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
