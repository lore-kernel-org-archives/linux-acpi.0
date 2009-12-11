From: Dave Chinner <david@fromorbit.com>
Subject: Re: spinlock in completion_done() (was: Re: Async resume patch
	(was: Re: [GIT PULL] PM updates for 2.6.33))
Date: Fri, 11 Dec 2009 15:10:41 +1100
Message-ID: <20091211041041.GJ30608@discord.disaster>
References: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org> <200912082248.14138.rjw@sisk.pl> <20091209092922.GC28428@elte.hu> <200912092337.52492.rjw@sisk.pl> <20091210075947.GD25549@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757287AbZLKEKy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091210075947.GD25549@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Lachlan McIlroy <lachlan@sgi.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 10, 2009 at 08:59:47AM +0100, Ingo Molnar wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday 09 December 2009, Ingo Molnar wrote:
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > On Tuesday 08 December 2009, Alan Stern wrote:
> > > > > On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> > > > > 
> > > > > > BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> > > > > > and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> > > > > > here?
> > > > > 
> > > > > And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> > > > > these routines were not intended to be called with interrupts disabled, 
> > > > > but that requirement doesn't seem to be documented.  And it isn't a 
> > > > > natural requirement anyway.

When I implemented them they were not called from anywhere that
disabled interrupts.  IIRC the main reason I used spin_lock_irq()
was because that is what wait_for_completion() used at the time....

> > > that's a bug that should be fixed - all the wakeup side (and atomic) 
> > > variants of completetion API should be irq safe.

I see no problems with that ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
