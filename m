From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Wed, 11 Nov 2009 23:15:36 +0100
Message-ID: <200911112315.36073.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911100949500.2888-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37915 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759501AbZKKWOK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 17:14:10 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911100949500.2888-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

[Sorry for the delayed response, I was distracted by the btusb regression
causing resume to fail on my box.]

On Tuesday 10 November 2009, Alan Stern wrote:
> On Tue, 10 Nov 2009, Matthew Garrett wrote:
> 
> > On Tue, Nov 10, 2009 at 02:08:01PM +0100, Oliver Neukum wrote:
> > 
> > > I was wondering because a tester has reported a race in ehci that
> > > can lead to a loss of wakeup events. Alan posted a patch to fix it.
> > > Does it cooperate with your patch?
> > 
> > Hm. I'll look into that.
> 
> There should not be any interaction.  That particular race occurs when
> the root hub is suspended, not when the controller is suspended.
> 
> 
> But this does raise an interesting point.  We do still have a race 
> between remote wakeup and system sleep.

We do to some extent.  There is the check in dpm_prepare() that will abort
system sleep transitions if run-time wake-up has been requested earlier,
but later requests will be discarded.

> Suppose we're in the middle of a system sleep transition, and device D
> (such as a USB root hub) has been suspended as part of the normal
> preparation.  But then D generates a remote wakeup IRQ.
> 
> D's driver will field the interrupt request and will call something
> like pm_request_resume(), to schedule a workqueue item for a runtime
> resume of D.  However, the runtime-PM workqueues are either frozen or
> in some other way prevented from doing anything while the system sleep
> transition is in progress.
> 
> Therefore the wakeup request will get lost.  The information is still
> present, in the form of a work_struct, but it won't get acted on until
> the system wakes up.  In particular, it won't prevent the sleep
> transition from completing and it won't cause the system to wake up
> immediately after going to sleep.
> 
> This suggests that pm_request_resume() should abort a sleep transition
> if one is already in progress.  Rafael, what do you think?

That's not an easy question, becuase there always will be a point after which
we can't handle a run-time resume request.  If we are deep enough into the
suspend process, we won't receive wakeup interrupts any more, at least on
some platforms.

Thanks,
Rafael
