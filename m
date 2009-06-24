From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 3] PM: Introduce core framework for run-time PM of I/O devices
Date: Wed, 24 Jun 2009 02:17:38 +0200
Message-ID: <200906240217.39608.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906231408370.3209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40067 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbZFXARG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2009 20:17:06 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906231408370.3209-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Tuesday 23 June 2009, Alan Stern wrote:
> On Tue, 23 Jun 2009, Rafael J. Wysocki wrote:
> 
> > In short, I think suspending (or queuing a suspend request) should fail if the
> > usage counter is nonzero, but the resuming (or queuing up a resume request)
> > should be possible regardless of its value.  The reason is that multiple
> > threads may in theory attempt to resume the device at the same time.
> 
> Agreed.  Suspends and resumes aren't symmetrical -- a single resume 
> request must outweigh numerous suspend requests.
> 
> > However, I'm not sure if the core should manipulate the usage counter by
> > itself, because it's sort of problematic (there's no good approach to decide
> > when to decrement the counter).
> 
> Yes.  The idea behind my previous message was that it's not really so
> easy for the core to decide when to _increment_ the counter either.
> 
> > So, I'd let the callers use pm_runtime_get() to increment the counter
> > and pm_runtime_put() to decrement it, possibly queuing up an idle notification
> > if the counter happens to reach 0.  Also, I'm not sure if unbalanced
> > pm_runtime_put() should be regarded as a bug.
> 
> It should be.  Once the counter is messed up, runtime PM wouldn't be
> able to work properly.  But maybe you should add a pm_set_counter call
> so that drivers can recover from imbalances.
> 
> One question still remains: If the counter is 0 at the end of a
> successful pm_runtime_resume, should the core then call pm_notify_idle?  
> Or should we make the driver responsible for that too?

Good question. :-)

I think the core may call pm_notify_idle() in that case, but not necessarily in
the synchronous case.

> > At the same time, I'd like the core to use runtime_status and the other
> > fields in dev_pm_info, except for the usage counter, to ensure that all
> > operations are only carried out when it makes sense.
> 
> Yes.  In fact, I'd say that when the counter is positive it doesn't
> make sense to allow a runtime suspend -- so you don't need that
> exception in your statement above.  :-)

Well, you're right.

Best,
Rafael
