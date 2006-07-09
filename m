From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1
Date: Sun, 9 Jul 2006 14:40:35 -0700
Message-ID: <20060709144035.5ec1c451.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
	<20060709103312.5f78ad38.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:60051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161170AbWGIVlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 17:41:03 -0400
In-Reply-To: <20060709103312.5f78ad38.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: reuben-lkml@reub.net, mingo@redhat.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, greg@kroah.com, Thomas Gleixner <tglx@linutronix.de>

On Sun, 9 Jul 2006 10:33:12 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > [root@tornado ~]# cat /proc/interrupts
> >             CPU0       CPU1
> >    0:     258266          0   IO-APIC-edge     timer
> >    4:        355          0   IO-APIC-edge     serial
> >    6:          5          0   IO-APIC-edge     floppy
> >    8:          1          0   IO-APIC-edge     rtc
> >    9:          0          0   IO-APIC-fasteoi  acpi
> >   14:         28          0   IO-APIC-edge     libata
> >   15:          0          0   IO-APIC-edge     libata
> >   16:          0          0   IO-APIC-fasteoi  uhci_hcd:usb5
> >   18:          0          0   IO-APIC-fasteoi  uhci_hcd:usb4
> >   19:        980          0   IO-APIC-fasteoi  uhci_hcd:usb3, serial
> >   23:        105          0   IO-APIC-fasteoi  ehci_hcd:usb1, uhci_hcd:usb2
> > 313:      82513          0   PCI-MSI-<NULL>  eth0
> > 314:      57370          0   PCI-MSI-<NULL>  libata
> 
> "We" need to fix that <NULL> there.

Seems that irq_desc[i].handle_irq is msi_irq_wo_maskbit_type or
msi_irq_w_maskbit_type and kernel/irq/chip.c:handle_irq_name() doesn't know
about that.

handle_irq_name() is a bit of a crock - this info should be in the irq_desc
struct or somewhere like that.

