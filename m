From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Wed, 11 Nov 2009 18:05:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911111753500.12919-100000@netrider.rowland.org>
References: <200911112315.36073.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:45379 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759596AbZKKXFs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 18:05:48 -0500
In-Reply-To: <200911112315.36073.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Wed, 11 Nov 2009, Rafael J. Wysocki wrote:

> > But this does raise an interesting point.  We do still have a race 
> > between remote wakeup and system sleep.
> 
> We do to some extent.  There is the check in dpm_prepare() that will abort
> system sleep transitions if run-time wake-up has been requested earlier,
> but later requests will be discarded.

Exactly.  The race I was referring to doesn't involve runtime PM; it 
occurs when a device is suspended as part of a sleep transition but 
then generates a wakeup request before the transition has finished.

> > Suppose we're in the middle of a system sleep transition, and device D
> > (such as a USB root hub) has been suspended as part of the normal
> > preparation.  But then D generates a remote wakeup IRQ.
> > 
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
> That's not an easy question, becuase there always will be a point after which
> we can't handle a run-time resume request.  If we are deep enough into the
> suspend process, we won't receive wakeup interrupts any more, at least on
> some platforms.

I don't know how to fix this in general...  The ultimate answer has to 
be a synchronization point of some sort.  Wakeup requests received 
before this point should cause the sleep to be aborted.  Requests 
received later should remain pending in the hardware and cause the 
system to wake up as soon as it goes to sleep.  But where this point is 
will depend on the platform.

On regular PCs, a likely spot is the place where we disable the IRQ 
lines.  For other types of system, I don't know.

Alan Stern

