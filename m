From: Peter Stuge <peter-Y+HMSxxDrH8@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
	for device fixed on the motherboard
Date: Fri, 11 May 2012 16:30:27 +0200
Message-ID: <20120511143027.8313.qmail@stuge.se>
References: <20120511041309.22096.qmail@stuge.se> <Pine.LNX.4.44L0.1205111019000.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205111019000.1865-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alan Stern wrote:
> > > Maybe we need an "off" setting that forces the port off?
> > 
> > FWIW this would be very welcome in libusb, to do a hard reset of
> > bus-powered devices.
> > 
> > It can be attempted via SET_FEATURE(PORT_POWER) to the hub, but a
> > "real" API would be nice.
> 
> But remember that such an API would be very unreliable.  Many hubs and
> root hubs cannot shut off port power at all, and some of the remaining
> ones use ganged power switches (you have to turn off all the ports in a
> gang before power is removed from any of them).

Yes, I know. It would be extra special nice if the kernel exposes
these various capabilities, in case they are already known.


//Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
