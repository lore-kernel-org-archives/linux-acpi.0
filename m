From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: how I know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Date: Thu, 22 Jun 2006 14:29:02 -0700
Message-ID: <20060622142902.5c8f8e67.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
	<20060621210817.74b6b2bc.rdunlap@xenotime.net>
	<1150977386.2859.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:16038 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932642AbWFVV0R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 17:26:17 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 14:26:15 -0700
In-Reply-To: <1150977386.2859.34.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, cw@f00f.org, vsu@altlinux.ru

On Thu, 22 Jun 2006 12:56:25 +0100 Sergio Monteiro Basto wrote:

> On Wed, 2006-06-21 at 21:08 -0700, Randy.Dunlap wrote:
> > 
> > If you have a specific issue/problem, it would probably be
> > better just to focus on that. 
> 
> on linux-2.6.17/drivers/pci/quirks.c	
> 
>   * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
>   * interrupts delivered properly.
>   */
> 
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
> 
> I want here put something like:  if ( dev->irq != XT-PIC) return and don't quirk this dev.
>  	else 

I don't think the interrupt device mode is known by this code (AFAICT
with a quick look).  The function is only called for certain VIA chipsets.

Do you want the quirk for any particular hardware device?
You might be able to look at the function's <dev> parameter
to decide on using the quirk or not.


> 	new_irq = dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);


---
~Randy
