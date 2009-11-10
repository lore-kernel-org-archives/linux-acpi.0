From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Tue, 10 Nov 2009 10:04:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911100949500.2888-100000@iolanthe.rowland.org>
References: <20091110141259.GA19792@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091110141259.GA19792-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 10 Nov 2009, Matthew Garrett wrote:

> On Tue, Nov 10, 2009 at 02:08:01PM +0100, Oliver Neukum wrote:
> 
> > I was wondering because a tester has reported a race in ehci that
> > can lead to a loss of wakeup events. Alan posted a patch to fix it.
> > Does it cooperate with your patch?
> 
> Hm. I'll look into that.

There should not be any interaction.  That particular race occurs when
the root hub is suspended, not when the controller is suspended.


But this does raise an interesting point.  We do still have a race 
between remote wakeup and system sleep.

Suppose we're in the middle of a system sleep transition, and device D
(such as a USB root hub) has been suspended as part of the normal
preparation.  But then D generates a remote wakeup IRQ.

D's driver will field the interrupt request and will call something
like pm_request_resume(), to schedule a workqueue item for a runtime
resume of D.  However, the runtime-PM workqueues are either frozen or
in some other way prevented from doing anything while the system sleep
transition is in progress.

Therefore the wakeup request will get lost.  The information is still
present, in the form of a work_struct, but it won't get acted on until
the system wakes up.  In particular, it won't prevent the sleep
transition from completing and it won't cause the system to wake up
immediately after going to sleep.

This suggests that pm_request_resume() should abort a sleep transition
if one is already in progress.  Rafael, what do you think?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
