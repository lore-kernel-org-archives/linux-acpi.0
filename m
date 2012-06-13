From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Wed, 13 Jun 2012 14:35:18 -0700
Message-ID: <20120613213518.GB5597@xanatos>
References: <20120613193038.GA6312@kroah.com>
 <Pine.LNX.4.44L0.1206131706450.3821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50637 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab2FMVfU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2012 17:35:20 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1206131706450.3821-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 13, 2012 at 05:10:43PM -0400, Alan Stern wrote:
> On Wed, 13 Jun 2012, Greg KH wrote:
> 
> > > --- a/drivers/usb/host/xhci-hub.c
> > > +++ b/drivers/usb/host/xhci-hub.c
> > > @@ -728,6 +728,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> > >  
> > >  			temp = xhci_readl(xhci, port_array[wIndex]);
> > >  			xhci_dbg(xhci, "set port power, actual port %d status  = 0x%x\n", wIndex, temp);
> > > +
> > > +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> > > +					wIndex + 1))
> > 
> > Why +1?  If you have to do this everywhere, then do it only in the
> > function, so you can be 0 based properly.
> 
> This is an awkward matter.  The USB spec numbers hub ports starting
> from 1, and so do several of the functions in usbcore, in order to
> match the spec.  But of course, all our internal arrays are indexed
> starting from 0.
> 
> The cleanest solution here might be to keep wIndex as an origin-0 value
> and create an origin-1 temporary variable (like hub.c does with
> "port1").

Oh, is that why it's named port1?  I could never understand why. :)

Sarah Sharp
