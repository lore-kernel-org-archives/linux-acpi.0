From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 21:11:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912082105100.26994-100000@netrider.rowland.org>
References: <alpine.LFD.2.00.0912081416470.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:37786 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754400AbZLICLY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 21:11:24 -0500
In-Reply-To: <alpine.LFD.2.00.0912081416470.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Linus Torvalds wrote:

> On Tue, 8 Dec 2009, Alan Stern wrote:
> >
> > And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> > these routines were not intended to be called with interrupts disabled, 
> > but that requirement doesn't seem to be documented.  And it isn't a 
> > natural requirement anyway.
> 
> 'complete()' is supposed to be callable from interrupts, but the waiting 
> ones aren't. But 'complete()' is all you should need to call from 
> interrupts, so that's fine.

And try_wait_for_completion()?  The fact that it doesn't block makes it
interrupt-safe.  What's the point of having an interrupt-safe routine
that you can't call from within interrupt handlers?

Even if nobody uses it that way now, there's no guarantee somebody
won't attempt it in the future.


> So I think completions should work, if done right. That whole "make the 
> parent wait for all the children to complete" is fine in that sense. And 
> I'll happily take such an approach if my rwlock thing doesn't work.

In principle the two approaches could be combined: Add an rwsem for use 
by children and a completion for off-tree[*] use.  But that would 
certainly be overkill.  Looping over children doesn't take a 
tremendous amount of time compared to a full system suspend.

Alan Stern

[*] "Off-tree" isn't really an appropriate term; these devices aren't 
"off" the tree.  "Non-tree" would be better.

