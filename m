From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: spinlock in completion_done() (was: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33))
Date: Tue, 8 Dec 2009 22:48:14 +0100
Message-ID: <200912082248.14138.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49436 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966245AbZLHVra (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2009 16:47:30 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tuesday 08 December 2009, Alan Stern wrote:
> On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> > BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> > and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> > here?
> 
> And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> these routines were not intended to be called with interrupts disabled, 
> but that requirement doesn't seem to be documented.  And it isn't a 
> natural requirement anyway.

OK, let's ask Ingo about that.

Ingo, is there any particular reason why completion_done() and
try_wait_for_completion() don't use spin_lock_irqsave() and
spin_unlock_irqrestore()?

Rafael
