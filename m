From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Thu, 12 Nov 2009 11:22:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911121120550.3000-100000@iolanthe.rowland.org>
References: <20091112003312.GA27572@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091112003312.GA27572-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Nov 2009, Matthew Garrett wrote:

> On Wed, Nov 11, 2009 at 06:09:24PM -0500, Alan Stern wrote:
> 
> > That's okay.  There's no harm in trying to enable remote wakeup on a 
> > device which doesn't support it.
> 
> There's harm if we're using the ability to generate remote waleups as a 
> condition for whether we can perform runtime pm on the device...

You misunderstood me.  There's no harm in _trying_ to enable remote 
wakeup.  The harm comes when the attempt fails but the drivers thinks 
it succeeded.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
