From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 10:55:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081049010.3046-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912080728590.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57720 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932336AbZLHPzE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 10:55:04 -0500
In-Reply-To: <alpine.LFD.2.00.0912080728590.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Linus Torvalds wrote:

> Please just use the lock. Don't make up your own locking crap. Really. 
> 
> Your patch is horrible. Exactly because your locking is horribly 
> mis-designed. You can't say things are complete from an interrupt, for 
> example, since you made it some random bitfield, which has unknown 
> characteristics (ie non-atomic read-modify-write etc).
> 
> The fact is, any time anybody makes up a new locking mechanism, THEY 
> ALWAYS GET IT WRONG. Don't do it.
> 
> I suggested using the rwsem locking for a good reason. It made sense. It 
> was simpler. Just do it that way, stop making up crap.

The semantics needed for this kind of lock aren't really the same as
for an rwsem (although obviously an rwsem will do the job).  Basically
it needs to have the capability for multiple users to lock it (no
blocking when acquiring a lock) and the capability for a user to wait
until it is totally unlocked.  It could be implemented trivially using
an atomic_t counter and a waitqueue head.

Is this a standard sort of lock?  It's a lot simpler than most others.  
I don't recall seeing anything quite like it anywhere; the closest 
thing might be some kind of barrier.

Alan Stern

