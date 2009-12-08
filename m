From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 14:18:57 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081416470.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53538 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965718AbZLHWTX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 17:19:23 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Tue, 8 Dec 2009, Alan Stern wrote:
>
> And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> these routines were not intended to be called with interrupts disabled, 
> but that requirement doesn't seem to be documented.  And it isn't a 
> natural requirement anyway.

'complete()' is supposed to be callable from interrupts, but the waiting 
ones aren't. But 'complete()' is all you should need to call from 
interrupts, so that's fine.

So I think completions should work, if done right. That whole "make the 
parent wait for all the children to complete" is fine in that sense. And 
I'll happily take such an approach if my rwlock thing doesn't work.

		Linus
