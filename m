From: "Craig Whitmore" <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>
Subject: Re: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 12:57:00 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <014401c28aa7$30dce670$6df058db@PC2>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com> <20021112233844.GA4746@schiggy.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm still getting some errors on my MB  (Intel SHG2)

CPI: Subsystem revision 20021111
PCI: PCI BIOS revision 2.10 entry at 0xfdace, last bus=3
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing
Methods:....................................................................
................................................
............................................................................
..........................................
Table [DSDT] - 565 Objects with 53 Devices 234 Methods 19 Regions
ACPI Namespace successfully loaded at root c039f55c
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE31
 evevent-0508: *** Info: GPE Block1 defined as GPE32 to GPE63
Executing all Device _STA and_INI
methods:.....................................................
53 Devices found containing: 53 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package
initialization:.......................................................
Initialized 13/19 Regions 0/0 Fields 22/22 Buffers 20/20 Packages (565
nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
pci_link-0207 [08] acpi_pci_link_get_curr: Error evaluating _CRS
ACPI: PCI Interrupt Link [LN1] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LN10] (IRQs *16)
ACPI: PCI Interrupt Link [LN11] (IRQs *17)
ACPI: PCI Interrupt Link [LN12] (IRQs *18)
ACPI: PCI Interrupt Link [LN13] (IRQs *19)
ACPI: PCI Interrupt Link [LN14] (IRQs *20)
ACPI: PCI Interrupt Link [LN15] (IRQs *21)
ACPI: PCI Interrupt Link [LN16] (IRQs *22)
ACPI: PCI Interrupt Link [LN17] (IRQs *23)
ACPI: PCI Interrupt Link [LN18] (IRQs *24)
ACPI: PCI Interrupt Link [LN19] (IRQs *25)
ACPI: PCI Interrupt Link [LN1A] (IRQs *26)
ACPI: PCI Interrupt Link [LN1B] (IRQs *27)
ACPI: PCI Interrupt Link [LN1C] (IRQs *28)
ACPI: PCI Interrupt Link [LN1D] (IRQs *29)
ACPI: PCI Interrupt Link [LN1E] (IRQs *30)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 53)
schedule_task(): keventd has not started
pci_bind-0194 [10] acpi_pci_bind         : Device 00:00:04.00 not present in
PCI namespace
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
PCI: Probing PCI hardware
pci_link-0207 [09] acpi_pci_link_get_curr: Error evaluating _CRS
ACPI: PCI Interrupt Link [LN1] enabled at IRQ 0
IOAPIC[1]: Set PCI routing entry (3-4 -> 0xa9 -> IRQ 20)
00:00:02[A] -> 3-4 -> IRQ 20
IOAPIC[1]: Set PCI routing entry (3-6 -> 0xb1 -> IRQ 22)
00:00:08[A] -> 3-6 -> IRQ 22
IOAPIC[1]: Set PCI routing entry (3-12 -> 0xb9 -> IRQ 28)
00:00:08[B] -> 3-12 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (3-13 -> 0xc1 -> IRQ 29)
00:00:08[C] -> 3-13 -> IRQ 29
IOAPIC[1]: Set PCI routing entry (3-14 -> 0xc9 -> IRQ 30)
00:00:08[D] -> 3-14 -> IRQ 30
IOAPIC[1]: Set PCI routing entry (3-7 -> 0xd1 -> IRQ 23)
00:00:09[A] -> 3-7 -> IRQ 23
Pin 3-14 already programmed
Pin 3-12 already programmed
Pin 3-13 already programmed
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xd9 -> IRQ 18)
00:00:03[A] -> 3-2 -> IRQ 18
IOAPIC[1]: Set PCI routing entry (3-9 -> 0xe1 -> IRQ 25)
00:00:04[A] -> 3-9 -> IRQ 25
Pin 3-12 already programmed
Pin 3-13 already programmed
Pin 3-14 already programmed
IOAPIC[1]: Set PCI routing entry (3-11 -> 0xe9 -> IRQ 27)
00:01:09[A] -> 3-11 -> IRQ 27
Pin 3-13 already programmed
Pin 3-14 already programmed
Pin 3-12 already programmed
IOAPIC[1]: Set PCI routing entry (3-3 -> 0x32 -> IRQ 19)
00:01:04[A] -> 3-3 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-10 -> 0x3a -> IRQ 26)
00:01:08[A] -> 3-10 -> IRQ 26
Pin 3-14 already programmed
Pin 3-12 already programmed
Pin 3-13 already programmed
IOAPIC[1]: Set PCI routing entry (3-0 -> 0x42 -> IRQ 16)
00:02:09[A] -> 3-0 -> IRQ 16
IOAPIC[1]: Set PCI routing entry (3-1 -> 0x4a -> IRQ 17)
00:02:09[B] -> 3-1 -> IRQ 17
IOAPIC[1]: Set PCI routing entry (3-8 -> 0x52 -> IRQ 24)
00:02:08[A] -> 3-8 -> IRQ 24
Pin 3-13 already programmed
pci_link-0480 [09] acpi_pci_link_get_irq : Link disabled
 pci_irq-0258 [08] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0297 [08] acpi_pci_irq_derive   : Unable to derive IRQ for device
00:0f.2
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
pci_link-0480 [-14] acpi_pci_link_get_irq : Link disabled
 pci_irq-0258 [-15] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0297 [-15] acpi_pci_irq_derive   : Unable to derive IRQ for device
00:0f.2
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
acpi_processor-2108 [-43] acpi_processor_get_inf: Invalid PBLK length [0]
ACPI: Processor [CPU0] (supports C1)
acpi_processor-2108 [-43] acpi_processor_get_inf: Invalid PBLK length [0]
ACPI: Processor [CPU1] (supports C1)
acpi_processor-2108 [-43] acpi_processor_get_inf: Invalid PBLK length [0]
ACPI: Processor [CPU2] (supports C1)
acpi_processor-2108 [-43] acpi_processor_get_inf: Invalid PBLK length [0]
ACPI: Processor [CPU3] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]


----- Original Message -----
From: "Arndt Schoenewald" <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
Sent: Wednesday, November 13, 2002 12:38 PM
Subject: Re: [ACPI] ACPI patches updated (20021111)


> On Tue, Nov 12, 2002 at 12:48:45PM -0800, Grover, Andrew wrote:
> > Hi all,
> >
> > New patches are up on sf.net/projects/acpi. [...]
>
> Linux 2.4.20-rc1 w/ acpi-20021111 works beautifully on my Gericom M6-T
> laptop, just as expected. There are no ACPI related problems left that I
> am aware of (I have never messed around with trip points and throttling
> though).
>
> Great work, Andy and friends!
>
> Best regards,
> Arndt
>
> --
> Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
> Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:
> To learn the basics of securing your web site with SSL,
> click here to get a FREE TRIAL of a Thawte Server Certificate:
> http://www.gothawte.com/rd522.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>



-------------------------------------------------------
This sf.net email is sponsored by: 
To learn the basics of securing your web site with SSL, 
click here to get a FREE TRIAL of a Thawte Server Certificate: 
http://www.gothawte.com/rd522.html
