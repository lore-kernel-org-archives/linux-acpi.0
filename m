From: Ville =?iso-8859-1?Q?P=E4tsi?= <drc-gbHDUNYU5Z6UJGkj1VpxcA@public.gmane.org>
Subject: Critical temperature even when idle with 2.6.7+patch, works fine in 2.4.26
Date: Fri, 2 Jul 2004 12:48:47 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040702094846.GB2141@torni>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have an Acer TravelMate 233xc laptop. The system cooling isn't handled
by ACPI. The system works fine in 2.4.26 and with moderate fan speed
(judged by the sound) the system stays at around 60 degrees celcius.

When I boot into 2.6.7 (with the 2004-06-21 patch) the system starts to
heat up, atlest judging from /proc/acpi/thermal_zone/THM0/temperature .
The fan also gets faster. The system load is basically none (No X
running). Then the system reports it has reached the critical
temperature of 80 degrees and shuts down. 
If I try to start the machine too soon after it does an emergency
shutdown (instant power off) while the kernel is loading, so I guess
it's not a temperature measurement error.  I don't have cpufreq running
and /proc/cpuinfo reports 2.0GHz (which is the normal).

Full kernel log of that run:

Jun 30 16:17:46 corsair kernel: Linux version 2.6.7 (root-M1jtaS7+WsY@public.gmane.org) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Wed Jun 30 16:09:32 EEST 2004
Jun 30 16:17:46 corsair kernel: BIOS-provided physical RAM map:
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 0000000000100000 - 000000000f760000 (usable)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 000000000f760000 - 000000000f76e000 (ACPI data)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 000000000f76e000 - 000000000f780000 (ACPI NVS)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 000000000f780000 - 0000000010000000 (reserved)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jun 30 16:17:46 corsair kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jun 30 16:17:47 corsair portmap: portmap startup succeeded
Jun 30 16:17:47 corsair kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Jun 30 16:17:47 corsair kernel:  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
Jun 30 16:17:47 corsair random: Initializing random number generator:  succeeded
Jun 30 16:17:47 corsair kernel: 247MB LOWMEM available.
Jun 30 16:17:47 corsair kernel: On node 0 totalpages: 63328
Jun 30 16:17:47 corsair pcmcia: Starting PCMCIA services: 
Jun 30 16:17:47 corsair cardmgr[1163]: watching 1 socket
Jun 30 16:17:47 corsair kernel:   DMA zone: 4096 pages, LIFO batch:1
Jun 30 16:17:47 corsair pcmcia: cardmgr[1163]: watching 1 socket
Jun 30 16:17:47 corsair kernel:   Normal zone: 59232 pages, LIFO batch:14
Jun 30 16:17:47 corsair pcmcia: done.
Jun 30 16:17:47 corsair kernel:   HighMem zone: 0 pages, LIFO batch:1
Jun 30 16:17:47 corsair rc: Starting pcmcia:  succeeded
Jun 30 16:17:47 corsair kernel: DMI present.
Jun 30 16:17:47 corsair kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f5c60
Jun 30 16:17:47 corsair kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0f7698d1
Jun 30 16:17:47 corsair kernel: ACPI: FADT (v001 INTEL  NBGV     0x06040000 PTL  0x00000003) @ 0x0f76df14
Jun 30 16:17:47 corsair kernel: ACPI: MADT (v001 PTLTD  ^I APIC   0x06040000  LTP 0x00000000) @ 0x0f76df88
Jun 30 16:17:47 corsair netfs: Mounting other filesystems:  succeeded
Jun 30 16:17:47 corsair kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0f76dfd8
Jun 30 16:17:47 corsair kernel: ACPI: DSDT (v001   WIST  PELICAN 0x06040000 MSFT 0x0100000d) @ 0x00000000
Jun 30 16:17:47 corsair acpid: acpid startup succeeded
Jun 30 16:17:48 corsair kernel: Built 1 zonelists
Jun 30 16:17:48 corsair kernel: Kernel command line: ro root=/dev/hda6 vga=0x318
Jun 30 16:17:45 corsair rc: Starting sysstat:  succeeded 
Jun 30 16:17:48 corsair kernel: Initializing CPU#0
Jun 30 16:17:49 corsair sshd:  succeeded
Jun 30 16:17:45 corsair iptables:  succeeded 
Jun 30 16:17:49 corsair kernel: CPU 0 irqstacks, hard=c0479000 soft=c0478000
Jun 30 16:17:45 corsair iptables:  succeeded 
Jun 30 16:17:49 corsair kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jun 30 16:17:49 corsair xinetd: xinetd startup succeeded
Jun 30 16:17:45 corsair iptables:  succeeded 
Jun 30 16:17:49 corsair kernel: Detected 2000.818 MHz processor.
Jun 30 16:17:45 corsair iptables:  succeeded 
Jun 30 16:17:50 corsair kernel: Using tsc for high-res timesource
Jun 30 16:17:45 corsair sysctl: net.ipv4.ip_forward = 0 
Jun 30 16:17:51 corsair kernel: Console: colour dummy device 80x25
Jun 30 16:17:45 corsair sysctl: net.ipv4.conf.default.rp_filter = 1 
Jun 30 16:17:51 corsair kernel: Memory: 246824k/253312k available (2433k kernel code, 5764k reserved, 952k data, 152k init, 0k highmem)
Jun 30 16:17:45 corsair sysctl: kernel.core_uses_pid = 1 
Jun 30 16:17:53 corsair kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jun 30 16:17:45 corsair network: Setting network parameters:  succeeded 
Jun 30 16:17:53 corsair kernel: Calibrating delay loop... 3948.54 BogoMIPS
Jun 30 16:17:53 corsair kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun 30 16:17:53 corsair kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jun 30 16:17:53 corsair kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jun 30 16:17:53 corsair postfix:  succeeded
Jun 30 16:17:54 corsair crond: crond startup succeeded
Jun 30 16:17:54 corsair kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun 30 16:17:54 corsair kernel: CPU: L2 cache: 256K
Jun 30 16:17:55 corsair kernel: Intel machine check architecture supported.
Jun 30 16:17:56 corsair kernel: Intel machine check reporting enabled on CPU#0.
Jun 30 16:17:56 corsair kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Jun 30 16:17:56 corsair kernel: CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.00GHz stepping 07
Jun 30 16:17:56 corsair kernel: Enabling fast FPU save and restore... done.
Jun 30 16:17:57 corsair kernel: Enabling unmasked SIMD FPU exception support... done.
Jun 30 16:17:57 corsair kernel: Checking 'hlt' instruction... OK.
Jun 30 16:17:57 corsair kernel: NET: Registered protocol family 16
Jun 30 16:17:57 corsair kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd824, last bus=2
Jun 30 16:17:57 corsair kernel: PCI: Using configuration type 1
Jun 30 16:17:57 corsair kernel: mtrr: v2.0 (20020519)
Jun 30 16:17:57 corsair kernel: ACPI: Subsystem revision 20040326
Jun 30 16:17:57 corsair kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jun 30 16:17:57 corsair kernel: ACPI: Interpreter enabled
Jun 30 16:17:57 corsair kernel: ACPI: Using PIC for interrupt routing
Jun 30 16:17:57 corsair kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 30 16:17:58 corsair kernel: PCI: Probing PCI hardware (bus 00)
Jun 30 16:17:58 corsair kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jun 30 16:17:59 corsair xinetd[1219]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Jun 30 16:17:59 corsair kernel: PCI: Transparent bridge - 0000:00:1e.0
Jun 30 16:17:59 corsair xinetd[1219]: Started working: 1 available service
Jun 30 16:18:00 corsair cups: cupsd startup succeeded
Jun 30 16:18:00 corsair kernel: ACPI: Embedded Controller [EC] (gpe 28)
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 10) *11
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
Jun 30 16:18:00 corsair anacron: anacron startup succeeded
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
Jun 30 16:18:00 corsair atd: atd startup succeeded
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
Jun 30 16:18:00 corsair kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 11) *0, disabled.
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
Jun 30 16:18:01 corsair messagebus: messagebus startup succeeded
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *11)
Jun 30 16:18:01 corsair kernel: SCSI subsystem initialized
Jun 30 16:18:01 corsair kernel: Linux Kernel Card Services
Jun 30 16:18:01 corsair kernel:   options:  [pci] [cardbus] [pm]
Jun 30 16:18:01 corsair kernel: usbcore: registered new driver usbfs
Jun 30 16:18:01 corsair kernel: usbcore: registered new driver hub
Jun 30 16:18:01 corsair kernel: PCI: Using ACPI for IRQ routing
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: agpgart: Detected an Intel 845G Chipset.
Jun 30 16:18:01 corsair kernel: agpgart: Maximum main memory to use for agp memory: 196M
Jun 30 16:18:01 corsair kernel: agpgart: Detected 8060K stolen memory.
Jun 30 16:18:01 corsair kernel: agpgart: AGP aperture is 128M @ 0xd8000000
Jun 30 16:18:01 corsair kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xd0090000, size 6144k
Jun 30 16:18:01 corsair kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Jun 30 16:18:01 corsair kernel: vesafb: protected mode interface info at 00ff:44f0
Jun 30 16:18:01 corsair kernel: vesafb: scrolling: redraw
Jun 30 16:18:01 corsair kernel: vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Jun 30 16:18:01 corsair kernel: fb0: VESA VGA frame buffer device
Jun 30 16:18:01 corsair kernel: Simple Boot Flag at 0x36 set to 0x1
Jun 30 16:18:01 corsair kernel: Machine check exception polling timer started.
Jun 30 16:18:01 corsair kernel: audit: initializing netlink socket (disabled)
Jun 30 16:18:01 corsair kernel: audit(1088612249.633:0): initialized
Jun 30 16:18:01 corsair kernel: udf: registering filesystem
Jun 30 16:18:01 corsair kernel: ACPI: AC Adapter [AC] (on-line)
Jun 30 16:18:01 corsair kernel: ACPI: Battery Slot [BAT0] (battery present)
Jun 30 16:18:01 corsair kernel: ACPI: Power Button (FF) [PWRF]
Jun 30 16:18:01 corsair kernel: ACPI: Lid Switch [LID]
Jun 30 16:18:01 corsair kernel: ACPI: Sleep Button (CM) [SLPB]
Jun 30 16:18:01 corsair kernel: ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
Jun 30 16:18:01 corsair kernel: ACPI: Thermal Zone [THM0] (50 C)
Jun 30 16:18:01 corsair kernel: Console: switching to colour frame buffer device 128x48
Jun 30 16:18:01 corsair kernel: lp: driver loaded but no devices found
Jun 30 16:18:01 corsair kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jun 30 16:18:01 corsair kernel: mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x400000
Jun 30 16:18:01 corsair kernel: [drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device
Jun 30 16:18:01 corsair kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jun 30 16:18:01 corsair kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:01 corsair kernel: parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
Jun 30 16:18:01 corsair kernel: parport0: irq 7 detected
Jun 30 16:18:01 corsair kernel: lp0: using parport0 (polling).
Jun 30 16:18:01 corsair kernel: Using anticipatory io scheduler
Jun 30 16:18:01 corsair kernel: Floppy drive(s): fd0 is 1.44M
Jun 30 16:18:02 corsair kernel: FDC 0 is a National Semiconductor PC87306
Jun 30 16:18:02 corsair kernel: 8139too Fast Ethernet driver 0.9.27
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:02 corsair kernel: eth0: RealTek RTL8139 at 0x3000, 00:00:e2:9d:7f:ee, IRQ 11
Jun 30 16:18:02 corsair kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 30 16:18:02 corsair kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 30 16:18:02 corsair kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Jun 30 16:18:02 corsair kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:02 corsair kernel: ICH4: chipset revision 2
Jun 30 16:18:02 corsair kernel: ICH4: not 100%% native mode: will probe irqs later
Jun 30 16:18:02 corsair kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Jun 30 16:18:02 corsair kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Jun 30 16:18:02 corsair kernel: hda: IC25N030ATCS04-0, ATA DISK drive
Jun 30 16:18:02 corsair kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 30 16:18:02 corsair kernel: hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
Jun 30 16:18:02 corsair kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 30 16:18:02 corsair kernel: hda: max request size: 128KiB
Jun 30 16:18:02 corsair kernel: hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
Jun 30 16:18:02 corsair kernel:  hda: hda1 hda2 < hda5 hda6 hda7 > hda3
Jun 30 16:18:02 corsair kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jun 30 16:18:02 corsair kernel: Uniform CD-ROM driver Revision: 3.20
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:02 corsair kernel: Yenta: CardBus bridge found at 0000:02:09.0 [17c0:3102]
Jun 30 16:18:02 corsair kernel: Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Jun 30 16:18:02 corsair kernel: Socket status: 30000821
Jun 30 16:18:02 corsair kernel: Databook TCIC-2 PCMCIA probe: not found.
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:02 corsair kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
Jun 30 16:18:02 corsair kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem d0693000
Jun 30 16:18:02 corsair kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jun 30 16:18:02 corsair kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Jun 30 16:18:02 corsair kernel: hub 1-0:1.0: USB hub found
Jun 30 16:18:02 corsair kernel: hub 1-0:1.0: 6 ports detected
Jun 30 16:18:02 corsair kernel: USB Universal Host Controller Interface driver v2.2
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jun 30 16:18:02 corsair kernel: hub 2-0:1.0: USB hub found
Jun 30 16:18:02 corsair kernel: hub 2-0:1.0: 2 ports detected
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jun 30 16:18:02 corsair kernel: hub 3-0:1.0: USB hub found
Jun 30 16:18:02 corsair kernel: hub 3-0:1.0: 2 ports detected
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
Jun 30 16:18:02 corsair kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jun 30 16:18:02 corsair kernel: hub 4-0:1.0: USB hub found
Jun 30 16:18:02 corsair kernel: hub 4-0:1.0: 2 ports detected
Jun 30 16:18:02 corsair kernel: usbcore: registered new driver usblp
Jun 30 16:18:02 corsair kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Jun 30 16:18:02 corsair kernel: Initializing USB Mass Storage driver...
Jun 30 16:18:02 corsair kernel: usbcore: registered new driver usb-storage
Jun 30 16:18:02 corsair kernel: USB Mass Storage support registered.
Jun 30 16:18:02 corsair kernel: usbcore: registered new driver usbhid
Jun 30 16:18:02 corsair kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jun 30 16:18:02 corsair kernel: mice: PS/2 mouse device common for all mice
Jun 30 16:18:02 corsair kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Jun 30 16:18:02 corsair kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Jun 30 16:18:02 corsair kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Jun 30 16:18:02 corsair kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Jun 30 16:18:02 corsair kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Jun 30 16:18:02 corsair kernel: Synaptics Touchpad, model: 1
Jun 30 16:18:02 corsair kernel:  Firmware: 4.6
Jun 30 16:18:02 corsair kernel:  180 degree mounted touchpad
Jun 30 16:18:02 corsair kernel:  Sensor: 18
Jun 30 16:18:02 corsair kernel:  new absolute packet format
Jun 30 16:18:02 corsair kernel:  Touchpad has extended capability bits
Jun 30 16:18:02 corsair kernel:  -> four buttons
Jun 30 16:18:02 corsair kernel:  -> multifinger detection
Jun 30 16:18:02 corsair kernel:  -> palm detection
Jun 30 16:18:02 corsair kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Jun 30 16:18:02 corsair kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 30 16:18:02 corsair kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 30 16:18:02 corsair kernel: Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:02 corsair kernel: intel8x0_measure_ac97_clock: measured 49338 usecs
Jun 30 16:18:02 corsair kernel: intel8x0: clocking to 48000
Jun 30 16:18:02 corsair kernel: ALSA device list:
Jun 30 16:18:02 corsair kernel:   #0: Intel 82801DB-ICH4 at 0xd0080c00, irq 10
Jun 30 16:18:02 corsair kernel: NET: Registered protocol family 2
Jun 30 16:18:02 corsair kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Jun 30 16:18:02 corsair kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jun 30 16:18:02 corsair kernel: ip_conntrack version 2.1 (1979 buckets, 15832 max) - 296 bytes per conntrack
Jun 30 16:18:02 corsair kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 30 16:18:02 corsair kernel: ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
Jun 30 16:18:02 corsair kernel: arp_tables: (C) 2002 David S. Miller
Jun 30 16:18:02 corsair kernel: NET: Registered protocol family 1
Jun 30 16:18:02 corsair kernel: NET: Registered protocol family 17
Jun 30 16:18:02 corsair kernel: ACPI: (supports S0 S3 S4 S5)
Jun 30 16:18:02 corsair kernel: kjournald starting.  Commit interval 5 seconds
Jun 30 16:18:02 corsair kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 30 16:18:02 corsair kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun 30 16:18:02 corsair kernel: Freeing unused kernel memory: 152k freed
Jun 30 16:18:02 corsair kernel: Real Time Clock Driver v1.12
Jun 30 16:18:02 corsair kernel: EXT3 FS on hda6, internal journal
Jun 30 16:18:02 corsair kernel: Adding 618460k swap on /dev/hda7.  Priority:-1 extents:1
Jun 30 16:18:02 corsair kernel: Loaded prism54 driver, version 1.1
Jun 30 16:18:02 corsair kernel: PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
Jun 30 16:18:02 corsair kernel: ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Jun 30 16:18:08 corsair login(pam_unix)[1520]: session opened for user root by LOGIN(uid=0)
Jun 30 16:18:08 corsair  -- root[1520]: ROOT LOGIN ON tty1
Jun 30 16:23:03 corsair kernel: Critical temperature reached (80 C), shutting down.
Jun 30 16:23:03 corsair shutdown: shutting down for system halt


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
