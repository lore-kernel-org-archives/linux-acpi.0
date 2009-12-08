From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 15:44:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081542350.3046-100000@iolanthe.rowland.org>
References: <200912082130.14634.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34572 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937883AbZLHUnz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 15:43:55 -0500
In-Reply-To: <200912082130.14634.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> > This is a little more awkward because it requires the parent to iterate 
> > through its children.
> 
> I can live with that.
> 
> > But it does solve the off-tree dependency  problem for suspends.
> 
> That's a plus, but I still think we're trying to create a barrier-alike
> mechanism using lock.
> 
> There's one more possibility to consider, though.  What if we use a completion
> instead of the flag + wait queue?  It surely is a standard synchronization
> mechanism and it seems it might work here.

You're right.  I should have thought of that.  Linus's original
approach couldn't use a completion because during suspend it needed to
make one task (the parent) wait for a bunch of others (the children).
But if you iterate through the children by hand, that objection no
longer applies.

Alan Stern

