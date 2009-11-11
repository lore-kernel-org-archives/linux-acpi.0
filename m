From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Wed, 11 Nov 2009 12:08:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911111203490.6882-100000@netrider.rowland.org>
References: <200911111234.43867.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200911111234.43867.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Nov 2009, Oliver Neukum wrote:

> Am Dienstag, 10. November 2009 16:04:12 schrieb Alan Stern:
> > D's driver will field the interrupt request and will call something
> > like pm_request_resume(), to schedule a workqueue item for a runtime
> > resume of D.  However, the runtime-PM workqueues are either frozen or
> > in some other way prevented from doing anything while the system sleep
> > transition is in progress.
> > 
> > Therefore the wakeup request will get lost.  The information is still
> > present, in the form of a work_struct, but it won't get acted on until
> > the system wakes up.  In particular, it won't prevent the sleep
> > transition from completing and it won't cause the system to wake up
> > immediately after going to sleep.
> > 
> > This suggests that pm_request_resume() should abort a sleep transition
> > if one is already in progress.  Rafael, what do you think?
> 
> That seems to be a bit harsh. If you do not specify that a device be
> able to wake the whole system, why would it be good for a request
> coming from it to abort a system sleep transition?

The way you specify that a device be able to wake the whole system is
by enabling its remote wakeup attribute.  If this attribute is not
enabled then the device will not send remote wakeup requests, so the
scenario described above will not occur -- no IRQ will be generated.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
