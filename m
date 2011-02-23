From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: xHCI Express Card failure -- ACPI related?
Date: Wed, 23 Feb 2011 08:23:34 -0800
Message-ID: <20110223162333.GA5660@xanatos>
References: <20110223005513.GA2503@xanatos>
 <20110223015445.GA27481@srcf.ucam.org>
 <20110223145747.GA4627@xanatos>
 <20110223150922.GA9304@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6730 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab1BWQXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Feb 2011 11:23:37 -0500
Content-Disposition: inline
In-Reply-To: <20110223150922.GA9304@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Feb 23, 2011 at 03:09:22PM +0000, Matthew Garrett wrote:
> On Wed, Feb 23, 2011 at 06:57:47AM -0800, Sarah Sharp wrote:
> > On Wed, Feb 23, 2011 at 01:54:45AM +0000, Matthew Garrett wrote:
> > > On Tue, Feb 22, 2011 at 04:55:13PM -0800, Sarah Sharp wrote:
> > > > I'm having an issue with an xHCI (USB 3.0 host controller) Express Card.
> > > > This card works fine on 2.6.37, but on 2.6.38-rc5, when I plug in the
> > > > card, I get this output in dmesg:
> > > 
> > > Is the controller associated with irq 23?
> > 
> > I think it is, before the xHCI driver switches to MSI/MSIX.  I'd have to
> > disable MSI in 2.6.37 to confirm.
> 
> Mm. Sounds like it's the hardware generating a legacy IRQ after you've 
> changed to MSI? Any chance this could be related to the irq 
> synchronisation patches?

Could be related, but I'm not sure that's the issue.  I don't see any
messages at all from the xHCI driver or the USB core about the new host
before the "nobody cared" message appears (although it turned out I have
CONFIG_USB_XHCI_HCD_DEBUGGING turned off).  AFAICT, the driver never
gets loaded.  But if the xHCI driver failed in its init sequence...
I'll check.

Sarah Sharp
