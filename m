From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11, why not in 9
 ?
Date: Sun, 24 Sep 2006 20:42:52 -0700
Message-ID: <20060924204252.26cc3839.rdunlap@xenotime.net>
References: <1158262993.4200.14.camel@localhost.localdomain>
	<1158885131.8360.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:56732 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751471AbWIYDll (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Sep 2006 23:41:41 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 24 Sep 2006 20:41:38 -0700
In-Reply-To: <1158885131.8360.17.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stian Jordet <liste@jordet.net>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, acpi devel <linux-acpi@vger.kernel.org>

On Fri, 22 Sep 2006 02:32:11 +0200 Stian Jordet wrote:

> tor, 14,.09.2006 kl. 20.43 +0100, skrev Sergio Monteiro Basto:
> > drivers/acpi/pci_link.c, line #583
> > acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
> >         printk(PREFIX "%s [%s] enabled at IRQ %d\n",
> >                acpi_device_name(link->device),
> >                acpi_device_bid(link->device), link->irq.active);
> > 
> > any clue about this problem ? 
> 
> I think you might be on to something here, but doesn't seem like anyone
> with the right skills has anything to add :( But it seems obvious that
> it's somewhat related to the fact that LNKD is enabled on irq11, even
> though it seems like it should have been irq9. Weird, but I don't
> understand nada :(

You should probably file a bug in the kernel bugzilla at
http://kernel.bugzilla.org and provides lots of info.


> Thanks for looking into it, though.
> 
> -Stian
> 
> 
> > -------- Forwarded Message --------
> > From: Sergio Monteiro Basto 
> > Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
> > Date: Wed, 13 Sep 2006 01:48:28 +0100
> > 
> > On Tue, 2006-09-12 at 23:38 +0200, Stian Jordet wrote:
> > > On tir, 2006-09-12 at 13:37 +0100, Sergio Monteiro Basto wrote:
> > > > Ok, as a quick answer, you have a very primitive VIA SMP board, which
> > > > make me remember my old laptop. 
> > > > I maintain what a had write in previous emails about this system. 
> > > > Seeing the configuration of irqs on windows, USB are in 9, so could be a
> > > > clue.
> > > > If I had your board, I'll try not quirk USB (cause quirk put USB in 11)
> > > > and make USB interrupts work as IO-APIC-edge.
> > > > 9:       nnnn       nnnn   IO-APIC-edge  uhci_hcd:usb1, uhci_hcd:usb2,
> > > > uhci_hcd:usb3
> > > 
> > > The point is, that even when I do not quirk (just insert return at the
> > > top of the quirk-function), usb still uses irq 11 (as I wrote here:
> > > http://lkml.org/lkml/2006/9/6/49 ), but won't work. And acpi (on
> > > interrupt 9) gets an interrupt storm, and gets disabled.
> > > 
> > 
> > Good point , you got on your dmesg of kernel 2.6.18-rc6
> > (http://lkml.org/lkml/2006/9/10/120)
> > 
> > USB Universal Host Controller Interface driver v3.0
> > ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> > ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> > PCI: VIA IRQ fixup for 0000:00:11.2, from 9 to 11
> > uhci_hcd 0000:00:11.2: UHCI Host Controller
> > uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
> > uhci_hcd 0000:00:11.2: irq 11, io base 0x00009800
> > usb usb1: configuration #1 chosen from 1 choice
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 2 ports detected
> > 
> > but before 
> > 
> > ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> > 
> > LNKD was on 9, so may be the bug is on ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> > you have to investigate :) 
> > 
> > Further more, your interrupts have 4 steps  
> > ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> > and mine just got 3 
> > ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
> > 
> > > But if I somehow got usb using irq 9, all my problems might vanish...
> > > 
> > > -Stian

---
~Randy
