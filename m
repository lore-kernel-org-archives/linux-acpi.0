From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: odd irq routing errors?
Date: Thu, 20 Feb 2003 12:44:45 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030220124445.GA3709@clara.net>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is for the IRQ allocation gurus.
More information on http://dude.noc.clara.net/~faye/

All refer to the IDE controller...

PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
 pci_irq-0297 [09] acpi_pci_irq_derive   : Unable to derive IRQ for
 device 00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
 pci_irq-0297 [12] acpi_pci_irq_derive   : Unable to derive IRQ for
 device 00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

But then:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

Looks like it has the correct IRQs.

root@marmite acpi # cat /proc/interrupts
           CPU0
  0:     200347          XT-PIC  timer
  1:        385          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       3253          XT-PIC  orinoco_cs
  8:          2          XT-PIC  rtc
  9:         11          XT-PIC  acpi, Intel ICH3, i82365
 11:          2          XT-PIC  sonypi
 14:       6969          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0

pcmcia-cs have allocated irq3 to the orinoco_cs but ACPI doesn't know
anything about that IRQ.  orinoco_cs seems to be working just fine
though.

ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
pci_link-0219 [14] acpi_pci_link_get_curr: Blank IRQ resource
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9

>From lspci:

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if
8a [Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 80fa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
		ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
		<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 255
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at e8000000 (32-bit, non-prefetchable)
		[size=1K]

I think the ports being ignored are these:

0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03f6-03f6 : ide0


-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Traffic signals in New York are just rough guidelines.
		-- David Letterman


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
