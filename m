From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework for run-time PM of I/O devices
Date: Sun, 21 Jun 2009 13:32:45 +0200
Message-ID: <200906211332.46249.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906202223080.20502-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51500 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbZFULcU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 07:32:20 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906202223080.20502-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Magnus Damm <magnus.damm@gmail.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Sunday 21 June 2009, Alan Stern wrote:
> On Sun, 21 Jun 2009, Rafael J. Wysocki wrote:
> 
> > On Saturday 20 June 2009, Alan Stern wrote:
> > > Some more thoughts...
> > > 
> > > Magnus, you might have some insights here.  It occurred to me that some 
> > > devices can switch power levels very quickly, and the drivers might 
> > > therefore want the runtime suspend and resume methods to be called as 
> > > soon as possible, even in interrupt context.
> > 
> > Then, we'll need special suspend and resume calls for them.
> 
> Good idea.  pm_runtime_resume_atomic() and pm_runtime_suspend_atomic().  
> No need for _request variants since the status should never be 
> RPM_SUSPENDING or RPM_RESUMING while the lock is released.

Yes, exactly.  I also thought of the same names. :-)

> > > Similarly, we should insure that runtime PM calls made before the
> > > device is registered don't do anything.  So when the device structure
> > > is first created and the contents are all 0, this should also be
> > > interpreted as an exceptional state.  We could call it RPM_UNREGISTERED
> > > and use it for both purposes.
> > 
> > Hmm.  How do you think is possible that the pm_runtime_* functions will be
> > called in such a situation?
> 
> By mistake.  :-)
> 
> Seriously, there _are_ places where drivers get bound to device before
> those devices are registered.  This happens for example in USB when a
> bunch of related interfaces are present in the same physical device.  
> When the first interface is registered, its driver binds itself to all
> the others even though they haven't been registered yet.

Well, the suspend functions could be protected against that under the
assumption that no suspend is possible for resume_counter = 0 (then, the "good
to go" value would be -1).

Still, the resume functions start from acquring a spinlock, which is not going
to work if that spinlock is uninitialized.

Best,
Rafael
