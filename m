From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 12:52:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071217220.2644-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912070737150.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44745 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935541AbZLGRw3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 12:52:29 -0500
In-Reply-To: <alpine.LFD.2.00.0912070737150.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Mon, 7 Dec 2009, Linus Torvalds wrote:

> No, I haven't overlooked resume at all. I just assumed that it was 
> obvious. It's the exact same thing, except in reverse (the locking ends 
> up being slightly different, but the changes are actually fairly 
> straightforward).
> 
> And by reverse, I mean that you walk the tree in the reverse order too, 
> exactly like we already do - on suspend we walk it children-first, on 
> resume we walk it parents-first (small detail: we actually just walk a 
> simple linked list, but the list is topologically ordered, so walking it 
> forwards/backwards is topologically the same thing as doing that 
> depth-first search).

> Notice? It's _exactly_ the same thing as suspend - except all turned 
> around. We do the nodes before the children ("walk the list backwards"), 
> and we also do the locking the other way around (ie on suspend we'd lock 
> the _parent_ if we wanted to do async stuff - to keep it around - but on 
> resume we lock _ourselves_, so that the children can have something to 
> wait on. Also note how we take a _write_ lock rather than a read lock).

Okay, I think I've got it.  But you're wrong about one thing: Resume
isn't _exactly_ the reverse of suspend.  For both of them we have to
start the async thread in the first pass.  So instead of
resume/post_resume we would have pre_resume/resume, just like
pre_suspend/suspend.

During the pre- pass, the driver launches an async thread and takes the
appropriate locks.  The thread does its work as appropriate (with
locking to insure that it first waits for children or parents), and
then in the second pass the driver waits for the async thread to 
finish.

A non-async driver (i.e., most of them) would ignore the pre- pass
entirely and do all its work in the second pass.

An async-aware driver would look like this:

	pre_suspend(dev)
	{
		/* Prevent parent from suspending until we are ready */
		down_read(dev->parent->lock);
		dev->pm_cookie = async_schedule(async_suspend, dev);
	}

	async_suspend(dev)
	{
		/* Wait until all children are fully suspended */
		down_write(dev->lock);
		Suspend dev, taking as much time as needed
		up_write(dev->lock);

		/* Allow parent to suspend */
		up_read(dev->parent->lock);
	}

	suspend(dev)
	{
		/* Wait until the suspend is complete */
		async_synchronize_cookie(dev->pm_cookie);
	}


	pre_resume(dev)
	{
		/* Prevent children from resuming */
		down_write(dev->lock);
		dev->pm_cookie = async_schedule(async_resume, dev);
	}

	async_resume(dev)
	{
		/* Wait until parent is fully resumed */
		down_read(dev->parent->lock);
		Resume dev, taking as much time as needed
		up_read(dev->parent->lock);

		/* Allow children to resume */
		up_write(dev->lock);
	}

	resume(dev)
	{
		/* Wait until resume is complete */
		async_synchronize_cookie(dev->pm_cookie);
	}

So there's some time symmetry here, but it isn't perfect.  This is 
probably what you had in mind all along, but I needed to get it 
straight.

There's some question about what to do if a suspend or resume fails.  A
bunch of async threads will have been launched for other devices, but
now there won't be anything to wait for them.  It's not clear how this
should be handled.

Alan Stern

