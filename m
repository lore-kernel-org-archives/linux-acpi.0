From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 20:07:16 +0100
Message-ID: <20090730190716.GB22016@srcf.ucam.org>
References: <20090730020623.GB26389@srcf.ucam.org> <Pine.LNX.4.44L0.0907301447080.6087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0907301447080.6087-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 30, 2009 at 02:57:48PM -0400, Alan Stern wrote:
> > event, even though port0en and port1n are set in USB_RES. Is there any 
> > way to get UHCI to do this? I'm guessing that the power is being cut to 
> > the port when it suspends with no device connected.
> 
> No, that doesn't sound right.  On the other hand, there's only one way 
> to find out for certain.  Voltmeters do come in handy at times...

Thinking about it, I get plug events from EHCI, so it can't be that the 
port is powered down. Maybe it's something to do with the port switching 
logic.

> UHCI isn't very flexible or configurable.  It doesn't sound like 
> there's anything more you can do about this.

Which possibly rules out the ability to do this.

> > I've thought of a way that this could be made to work, but it's kind of 
> > hacky. A generic GPE handler could be registered and then scan all PCIe 
> > devices for a raised PME bit.
> 
> Something like that is probably needed anyway -- for all PCI devices, 
> not just PCIe.  You have to do this on systems that support PCI-PM but 
> don't have ACPI.

Yes, they'll need to have their own platform hook into this.

> > Anyone have any ideas? I've attached the current version of my code, 
> > which is hacked up in various ways as I try to understand what's going 
> > on but should give some idea what I'm trying.
> 
> Ugh...  Hacked is right.  I can't comment on the ACPI stuff, but the
> USB parts are a mess.  You put stuff in the USB core that really
> belongs in the PCI core and you put stuff in the kernel that belongs in
> userspace.  Of course, there's nothing wrong with doing this as part of
> a "proof-of-principle" thing.

Yes, I guess the correct model is for this to be in PCI and have the USB 
code do nothing other than indicate that the PCI device is now idle.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
