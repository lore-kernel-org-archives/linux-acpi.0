From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Tue, 5 Jun 2012 08:58:40 -0700
Message-ID: <20120605155840.GB7534@xanatos>
References: <4FCDC3BB.50809@intel.com>
 <Pine.LNX.4.44L0.1206051017040.1542-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1206051017040.1542-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 05, 2012 at 10:18:50AM -0400, Alan Stern wrote:
> On Tue, 5 Jun 2012, Lan Tianyu wrote:
> 
> > > The patch does not implement anything at all for "auto".  It should do
> > > _something_.
> > >
> > Yeah, if we don't power off port without device when echo "auto" > portX/control,
> > this patch does nothing about "auto". Original plan is to deal with port without
> > devices firstly. Do you mean I should add the process of port with device in this
> > patch?
> 
> At least make a start.  For example, have "auto" turn off the power if
> no device is attached to the port.

Auto should only turn off power if no device is attached to the port
*and* we know it's an internal port through ACPI.  Don't forget that
we'll lose port connect events when the power is off.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
