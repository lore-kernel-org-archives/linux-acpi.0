From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Wed, 13 Jun 2012 17:10:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206131706450.3821-100000@iolanthe.rowland.org>
References: <20120613193038.GA6312@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120613193038.GA6312-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Jun 2012, Greg KH wrote:

> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -728,6 +728,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >  
> >  			temp = xhci_readl(xhci, port_array[wIndex]);
> >  			xhci_dbg(xhci, "set port power, actual port %d status  = 0x%x\n", wIndex, temp);
> > +
> > +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> > +					wIndex + 1))
> 
> Why +1?  If you have to do this everywhere, then do it only in the
> function, so you can be 0 based properly.

This is an awkward matter.  The USB spec numbers hub ports starting
from 1, and so do several of the functions in usbcore, in order to
match the spec.  But of course, all our internal arrays are indexed
starting from 0.

The cleanest solution here might be to keep wIndex as an origin-0 value
and create an origin-1 temporary variable (like hub.c does with
"port1").

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
