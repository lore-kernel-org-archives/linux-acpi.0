From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 16:40:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
References: <200912082152.21910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44425 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965843AbZLHVkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 16:40:04 -0500
In-Reply-To: <200912082152.21910.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> here?

And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
these routines were not intended to be called with interrupts disabled, 
but that requirement doesn't seem to be documented.  And it isn't a 
natural requirement anyway.

Alan Stern

