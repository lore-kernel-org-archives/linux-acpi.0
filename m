From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Wed, 11 Nov 2009 23:24:57 +0100
Message-ID: <200911112324.58076.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911111400370.6882-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0911111400370.6882-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 11 November 2009, Alan Stern wrote:
> On Wed, 11 Nov 2009, Oliver Neukum wrote:
> 
> > Am Mittwoch, 11. November 2009 18:08:17 schrieb Alan Stern:
> > > On Wed, 11 Nov 2009, Oliver Neukum wrote:
> > 
> > > > That seems to be a bit harsh. If you do not specify that a device be
> > > > able to wake the whole system, why would it be good for a request
> > > > coming from it to abort a system sleep transition?
> > > 
> > > The way you specify that a device be able to wake the whole system is
> > > by enabling its remote wakeup attribute.  If this attribute is not
> > > enabled then the device will not send remote wakeup requests, so the
> > > scenario described above will not occur -- no IRQ will be generated.
> > 
> > But what happens if a driver has requested remote wakeup requests
> > to do runtime power management?
> 
> The driver mustn't tell the device to send remote wakeup requests if
> the remote wakeup attribute isn't set.  If this means it can't do 
> effective runtime PM, then so be it.
> 
> Now, this does raise another point, which has been mentioned before.  
> To wit: devices really ought to have _two_ remote-wakeup attributes, 
> one for runtime PM and one for system sleep.

Yes, they do and there's another reason.  Namely, there apparently are
devices which can wake up the system from a sleep state and that are
unable to generate runtime wakeup events.

>   But that would introduce  yet more complexity and opportunities for
>   confusion.

Nevertheless.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
