From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>
Subject: AVM B1 PCI on DH77KC (H77 chipset) problem, requires pci=noirq
Date: Tue, 12 Jun 2012 22:39:43 +0200
Message-ID: <4FD7A90F.7070900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:50479 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751445Ab2FLUjr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 16:39:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
I am trying to get an old and trusty active ISDN-card to work on a shiny
new Intel DH77KC mainboard in conjunction with an i7 Ivy Bridge
processor. (it's supposed to bridge VoIP to ISDN, amongst other stuff).

The PCI bus seems to be behind a PCIe-PCI bridge.

When booting "normally", the card is recognized by the kernel. But then
the firmware upload fails. I can get this to work when using irqfixup or
irqpoll.

The strange thing is that it doesn't seem to receive any interrupts. See
interrupt 18:

> # cat /proc/interrupts                                                                                                                                                                                       :(
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       
>   0:         39          0          0          0          0          0          0          0   IO-APIC-edge      timer
>   1:          5          0          0          0          2          1          0          1   IO-APIC-edge      i8042
>   8:          1          0          0          0          0          0          0          0   IO-APIC-edge      rtc0
>   9:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   acpi
>  12:          3          0          0          0          0          1          0          0   IO-APIC-edge      i8042
>  16:         16          1          0          0          5          0          6          0   IO-APIC-fasteoi   ehci_hcd:usb3
>  18:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   b1pci-e040
>  23:        951          1          1          1       3508        113          7          3   IO-APIC-fasteoi   ehci_hcd:usb4
>  40:          0          0          0          0          0          0          0          0   PCI-MSI-edge      PCIe PME
>  41:          0          0          0          0          0          0          0          0   PCI-MSI-edge      PCIe PME
>  42:      22174        151         37         31       4929       3408        505         78   PCI-MSI-edge      ahci
>  43:          0          0          0          0          0          0          0          0   PCI-MSI-edge      xhci_hcd
>  44:      83408         13          7          1      16731      45447       3778        434   PCI-MSI-edge      eth0
> NMI:          0          0          0          0          0          0          0          0   Non-maskable interrupts
> LOC:     100444      42739      43037      43502      20252      27063      11456       8737   Local timer interrupts
> SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
> PMI:          0          0          0          0          0          0          0          0   Performance monitoring interrupts
> IWI:          0          0          0          0          0          0          0          0   IRQ work interrupts
> RTR:          7          0          0          0          0          0          0          0   APIC ICR read retries
> RES:       7601       5517       1005        519       2245        607        539        136   Rescheduling interrupts
> CAL:        396       1190       1168       1197       1057       1062       1175       1182   Function call interrupts
> TLB:        910        964        879        824       1998       1683       1682       1942   TLB shootdowns
> TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
> THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
> MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
> MCP:          3          3          3          3          3          3          3          3   Machine check polls
> ERR:          0
> MIS:          0


When I boot using pci=noacpi it becomes better. The driver receives
interrupts (on the one remaining CPU core in that mode). The card
doesn't work properly in that mode, though.


Could that be an ACPI problem of the kernel or should I pester Intel for
a BIOS problem?


I am not on list, so please CC me ...

Regards
Malte
