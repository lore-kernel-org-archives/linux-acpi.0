From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: please test latest acpi patch
Date: Mon, 21 Mar 2005 18:47:49 +0100
Message-ID: <423F08C5.3060405@gmx.net>
References: <1111214045.5932.41.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111214045.5932.41.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown schrieb:
> There are some very important -- and in some cases,
> potentially disruptive -- changes in the latest ACPI patch.
> 
> EC Burst Mode -- battery status AE_TIME etc.
> Binding ACPI power states to PCI devices -- power loss in S3
> Generic Hot Key Driver -- needs configuration from user space
> S3 Resume PCI Interrupt Link fix, requiring drivers to behave better
> Poweroff fix -- compatible with kexec patch
> Improved "Implicit Return" AML workaround -- toshiba, compaq etc.
> Relaxed AE_AML_BUFFER_LIMIT code -- reflects proposed ACPI spec update
> 
> Please try it out on a system near you!

Tested on my Samsung P35 notebook:

--- dmesg.2.6.11-latest-s3test19        2005-03-21 18:11:50.000000000 +0100
+++ dmesg.2.6.12-rc1-latest-s3test21-acpi       2005-03-21 18:15:27.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.11-latest (compiler@p35) (gcc version 3.3.4) #1 Thu Mar 17 23:57:36 CET 2005
+Linux version 2.6.12-rc1-latest-acpi (compiler@p35) (gcc version 3.3.4) #4 Mon Mar 21 17:53:09 CET 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
@@ -59,14 +59,18 @@
 PCI: PCI BIOS revision 2.10 entry at 0xfd9d3, last bus=4
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050211
+ACPI: Subsystem revision 20050309
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
-ACPI: PCI Root Bridge [PCI0] (00:00)
+ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
+ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
 PCI: Enabled i801 SMBus device
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 PCI: Transparent bridge - 0000:00:1e.0
+ACPI: Can't get handler for 0000:00:00.0
+ACPI: Can't get handler for 0000:02:01.0
+ACPI: Can't get handler for 0000:02:01.2
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
@@ -82,6 +86,16 @@
 ACPI: Power Resource [CFN1] (off)
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: PnP ACPI init
+ACPI: No ACPI bus support for 00:00
+ACPI: No ACPI bus support for 00:01
+ACPI: No ACPI bus support for 00:02
+ACPI: No ACPI bus support for 00:03
+ACPI: No ACPI bus support for 00:04
+ACPI: No ACPI bus support for 00:05
+ACPI: No ACPI bus support for 00:06
+ACPI: No ACPI bus support for 00:07
+ACPI: No ACPI bus support for 00:08
+ACPI: No ACPI bus support for 00:09
 pnp: PnP ACPI: found 10 devices
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
@@ -94,10 +108,12 @@
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Initializing Cryptographic API
+ACPI: No ACPI bus support for vesafb.0
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found
 Real Time Clock Driver v1.12
 PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
+ACPI: No ACPI bus support for i8042
 i8042.c: Detected active multiplexing controller, rev 1.1.
 serio: i8042 AUX0 port at 0x60,0x64 irq 12
 serio: i8042 AUX1 port at 0x60,0x64 irq 12
@@ -105,11 +121,17 @@
 serio: i8042 AUX3 port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
+ACPI: No ACPI bus support for serio0
+ACPI: No ACPI bus support for serio1
+ACPI: No ACPI bus support for serio2
+ACPI: No ACPI bus support for serio3
+ACPI: No ACPI bus support for serio4
+ACPI: No ACPI bus support for serial8250
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
 PCI: setting IRQ 5 as level-triggered
-ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
@@ -140,7 +162,7 @@
 ICH4: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
-ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
 ICH4: chipset revision 3
 ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
@@ -158,9 +180,11 @@
  -> palm detection
 input: SynPS/2 Synaptics TouchPad on isa0060/serio4
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
+ACPI: No ACPI bus support for 0.0
 Probing IDE interface ide1...
 hdc: DV-W24ES, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
+ACPI: No ACPI bus support for 1.0
 hda: max request size: 1024KiB
 hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: cache flushes supported
@@ -184,67 +208,78 @@
 Trying to free ramdisk memory ... failed
 Freeing unused kernel memory: 192k freed
 8139too Fast Ethernet driver 0.9.27
-ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
-eth0: RealTek RTL8139 at 0xe0860800, 00:00:de:ad:be:ef, IRQ 5
+ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
+eth0: RealTek RTL8139 at 0xe083a800, 00:00:de:ad:be:ef, IRQ 5
 eth0:  Identified 8139 chip type 'RTL-8101'
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
 USB Universal Host Controller Interface driver v2.2
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
-ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
+Linux agpgart interface v0.101 (c) Dave Jones
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1d.0: irq 5, io base 0x00001800
+ACPI: No ACPI bus support for usb1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
+ACPI: No ACPI bus support for 1-0:1.0
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 PCI: setting IRQ 11 as level-triggered
-ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
+ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.1 to 64
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
+ACPI: No ACPI bus support for usb2
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 5 (level, low) -> IRQ 5
+ACPI: No ACPI bus support for 2-0:1.0
+ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
-Linux agpgart interface v0.101 (c) Dave Jones
+hw_random: RNG not detected
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
 uhci_hcd 0000:00:1d.2: irq 5, io base 0x00001840
+ACPI: No ACPI bus support for usb3
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
+ACPI: No ACPI bus support for 3-0:1.0
 ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
-ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
+ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.7 to 64
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
 ehci_hcd 0000:00:1d.7: irq 11, io mem 0xd0000000
 PCI: cache line size of 32 is not supported by device 0000:00:1d.7
 ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
+Linux Kernel Card Services
+  options:  [pci] [cardbus] [pm]
+ACPI: No ACPI bus support for usb4
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 6 ports detected
+ACPI: No ACPI bus support for 4-0:1.0
 agpgart: Detected an Intel 855PM Chipset.
 agpgart: AGP aperture is 256M @ 0xe0000000
-Linux Kernel Card Services
-  options:  [pci] [cardbus] [pm]
-ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 Yenta: CardBus bridge found at 0000:02:01.0 [144d:c00c]
 Yenta: ISA IRQ mask 0x0498, PCI irq 5
 Socket status: 30000006
-hw_random: RNG not detected
 PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
-ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
 Yenta: CardBus bridge found at 0000:02:01.1 [144d:c00c]
 Yenta: ISA IRQ mask 0x0498, PCI irq 5
 Socket status: 30000006
 ieee1394: Initialized config rom entry `ip1394'
 ohci1394: $Rev: 1250 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
-ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:02:01.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
+ACPI: No ACPI bus support for fw-host0
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[d0201000-d02017ff]  Max Packet=[2048]
+ACPI: No ACPI bus support for 0000f0414012c7ff
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f0414012c7ff]
+ACPI: No ACPI bus support for 0000f0414012c7ff-0
 SCSI subsystem initialized
 ReiserFS: hda7: found reiserfs format "3.6" with standard journal
 ReiserFS: hda7: using ordered data mode
@@ -280,8 +315,8 @@
 ip6_tables: (C) 2000-2002 Netfilter core team
 ip_tables: (C) 2000-2002 Netfilter core team
 ip_conntrack version 2.1 (4091 buckets, 32728 max) - 248 bytes per conntrack
 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
-ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
+ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 intel8x0_measure_ac97_clock: measured 49457 usecs
 intel8x0: clocking to 48000
@@ -293,8 +328,7 @@
 ACPI: Fan [FAN1] (off)
 ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
 ACPI: Thermal Zone [THRM] (53 C)
-Asus Laptop ACPI Extras version 0.29
-  Samsung P30 detected, supported
+Using generic hotkey driver
 BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
 eth0: no IPv6 routers present
 parport: PnPBIOS parport detected.


Seems to work so far. I only tested S3 suspend/resume; my battery is
unplugged right now.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
