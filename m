From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 10:52:08 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081043280.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081234030.3046-100000@iolanthe.rowland.org> <alpine.LFD.2.00.0912081024530.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60948 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756141AbZLHSwY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 13:52:24 -0500
In-Reply-To: <alpine.LFD.2.00.0912081024530.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Tue, 8 Dec 2009, Linus Torvalds wrote:
> 
> [ Hint: you need a smp_mb() *before* the atomic_dec() in wait-unlock, so 
>   that anybody else who sees the new value will be guaranteed to have seen 
>   anything else the unlocker did.
> 
>   You also need a smp_mb() in the wait_for_lock(), not a smp_rmb(). Can't 
>   allow writes to migrate up either.  'atomic_read()' does not imply any
>   barriers.
> 
>   But most architectures can optimize these things for their particular 
>   memory ordering model, and do so in their rwsem implementation. ]

Side note: if this was a real lock, you'd also needed an smp_wmb() in the 
'wait_lock()' path after the atomic_inc(), to make sure that others see 
the atomic lock was seen by other people before the suspend started. 

In your usage scenario, I don't think it would ever be noticeable, since 
the other users are always going to start running from the same thread 
that did the wait_lock(), so even if they run on other CPU's, we'll have 
scheduled _to_ those other CPU's and done enough memory ordering to 
guarantee that they will see the thing.

So it would be ok in this situation, simply because it acts as an 
initializer and never sees any real SMP issues.

But it's an example of how you now don't just depend on the locking 
primitives themselves doing the right thing, you end up depending very 
subtly on exactly how the lock is used.  The standard locks do have the 
same kind of issue for initializers, but we avoid it elsewhere because 
it's so risky.

				Linus
