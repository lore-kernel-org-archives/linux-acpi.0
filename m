From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 12:48:19 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071239270.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071449470.15701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55470 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935185AbZLGUsw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 15:48:52 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912071449470.15701-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Mon, 7 Dec 2009, Alan Stern wrote:
> 
> Yes, I like this approach better and better.
> 
> There is still a problem.  In your code outlines, you have presented a
> classic depth-first (suspend) or depth-last (resume) tree algorithm. 

Yes, I did that because that clarifies the locking rules (ie "we traverse 
parents nodes last/first"), not because it was actually relevant to 
anything else.

And the whole pre-order vs post-order is important, and really only shows 
up when you show the pseudo-code as a tree walk. 

> But that's not how the PM core works.  Instead it maintains dpm_list, a
> list of all devices in order of registration.

Right. I did mention that in a couple of the asides, I'm well aware that 
we don't actually traverse the tree as a tree.

But the "traverse list forward" is logically the same thing as doing 
a pre-order DFS, while going backwards is equivalent to doing a post-order 
DFS, since all we really care about is the whole "parent first" or 
"children first" part of the ordering.

So I wanted to show the logic in pseudo-code using the tree walk (because 
that explains the logic _conceptually_ much better), but the actual code 
would just do the list traversal.

> The consequence is that there's no way to hand off an entire subtree to 
> an async thread.  And as a result, your single-pass algorithm runs into 
> the kind of "stall" problem I described before.

No, look again. There's no stall in the thing, because all it really 
depends on is (for the suspend path) is that it sees all children before 
the parent (because the child will do a "down_read()" on the parent node 
and that should not stall), and for the resume path it depends on seeing 
the parent node before any children (because the parent node does that 
"down_write()" on its own node).

Everything else is _entirely_ asynchronous, including all the other locks 
it takes. So there are no stalls (except, of course, if we then hit limits 
on numbers of outstanding async work and refuse to create too many 
outstanding async things, but that's a separate issue, and intentional, of 
course).

You're right that my first one (two-phase suspend) had a stall situation.

		Linus
