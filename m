From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 17:53:01 +0200
Message-ID: <200906221753.01970.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906221135360.14561-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58889 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbZFVPwV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2009 11:52:21 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906221135360.14561-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Magnus Damm <magnus.damm@gmail.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Monday 22 June 2009, Alan Stern wrote:
> On Mon, 22 Jun 2009, Rafael J. Wysocki wrote:
> 
> > On Monday 22 June 2009, Alan Stern wrote:
> > > On Sun, 21 Jun 2009, Rafael J. Wysocki wrote:
> > > 
> > > > > Seriously, there _are_ places where drivers get bound to device before
> > > > > those devices are registered.  This happens for example in USB when a
> > > > > bunch of related interfaces are present in the same physical device.  
> > > > > When the first interface is registered, its driver binds itself to all
> > > > > the others even though they haven't been registered yet.
> > > > 
> > > > Well, the suspend functions could be protected against that under the
> > > > assumption that no suspend is possible for resume_counter = 0 (then, the "good
> > > > to go" value would be -1).
> > > > 
> > > > Still, the resume functions start from acquring a spinlock, which is not going
> > > > to work if that spinlock is uninitialized.
> > > 
> > > The initialization needs to be improved.  Most of the code in
> > > pm_runtime_init() should be called from device_pm_init(), and the rest
> > > should be moved into a separate pm_runtime_add() routine to be called
> > > from device_pm_add().
> > 
> > OK
> > 
> > In that case, I think, the initialization of the spinlock and resume_counter
> > can be put into the thing called by device_pm_init().
> 
> Right.
> 
> > > One of the things pm_runtime_add() could do is change the status from 
> > > RPM_UNREGISTERED to RPM_ACTIVE.
> > 
> > If the status is initially (ie. at the device_pm_init() point) RPM_ACTIVE and
> > resume_couter is initially 1, what are we going to need RPM_UNREGISTERED for?
> 
> Okay, we don't need it then.  I forgot to mention in the previous
> message that there also has to be a pm_runtime_del() routine, which
> should cancel pending workqueue items and set the counter to some high
> value so that no new items are added.

Should that be called by device_pm_remove()?  I think so.

Rafael
