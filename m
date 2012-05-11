From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 16:36:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org>
References: <20120511202113.GH18754@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120511202113.GH18754@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 11 May 2012, Sarah Sharp wrote:

> On Fri, May 11, 2012 at 03:14:37PM -0400, Alan Stern wrote:
> > On Fri, 11 May 2012, Sarah Sharp wrote:
> > 
> > > > That reminds me...  I think this should not be so closely linked with
> > > > ACPI.  There's a perfectly good USB Clear-Feature request for turning
> > > > off port power; that's what we should use.  If hooks are required for
> > > > interfacing with platform-specific code (such as ACPI), they can be
> > > > added at the appropriate places.
> > > 
> > > So would you rather userspace issue a clear port power feature request
> > > to the roothub through libusb than have a sysfs file per port in
> > > /sys/bus/usb/devices/../power/ ?  Or are you just saying that the sysfs
> > > interface should issue the request to the hub (which may be the
> > > roothub), and the xHCI driver can just implement the ACPI calls in its
> > > roothub control method?
> > 
> > The latter.  Except that the ACPI calls may need to occur in more
> > places than just xhci-hcd (ehci-hcd, for example).
> 
> Only the xHCI host controller will have the port power off mechanism.

You're only talking about the upcoming Intel implementation, right?

> > And what about ports on the USB-2 "rate-matching" hubs that Intel now
> > builds into its chipsets?
> 
> For the Intel platform that has the port power off mechanism, there are
> EHCI host controllers, but the port switch over changes *all* the USB
> ports under xHCI.

Leaving aside the matter of people who don't use the port switch-over, 
what about other platforms?

> > For that matter, is it really necessary to involve ACPI in port power
> > changes at all?  Why can't xhci-hcd simply set the PP bit in the PORTSC
> > register, and rely on the PPC bit in the HCCPARAMS register to indicate
> > whether or not port power control is supported?  In other words, what 
> > advantage does ACPI have over USB native power control?
> 
> The port power off mechanism is controlled by some other chunk of
> hardware outside the xHCI host controller.  I asked the architects why
> they didn't just use the port power control bits in the port status
> registers, but they had already made their design choices by then.  So
> we're stuck with the ACPI method of powering off the ports.

Then yes, xhci_hub_control() would need an ACPI hook.  The hook belongs 
there, not in usbcore.

Can you convince the architects to do it the right way next time?  :-)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
