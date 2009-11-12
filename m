From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Thu, 12 Nov 2009 11:47:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911121145570.3000-100000@iolanthe.rowland.org>
References: <200911121544.19313.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200911121544.19313.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Nov 2009, Oliver Neukum wrote:

> Am Donnerstag, 12. November 2009 00:09:24 schrieb Alan Stern:
> > > Yes, they do and there's another reason.  Namely, there apparently are
> > > devices which can wake up the system from a sleep state and that are
> > > unable to generate runtime wakeup events.
> > 
> > That's okay.  There's no harm in trying to enable remote wakeup on a 
> > device which doesn't support it.
> 
> That's a bold statement. If Windows doesn't do it, it is most likely a
> false statement.

Let's rephrase it: There's no harm in trying to enable remote wakeup on 
a device which can wake up the system from a sleep state but can't 
generate runtime wakeup events.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
