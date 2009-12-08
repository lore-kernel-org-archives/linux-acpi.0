From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 15:16:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081508220.3046-100000@iolanthe.rowland.org>
References: <200912082044.52098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57990 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965929AbZLHUQi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 15:16:38 -0500
In-Reply-To: <200912082044.52098.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> Suppose we use rwsem and during suspend each child uses a down_read() on a
> parent and then the parent uses down_write() on itself.  What if, whatever the
> reason, the parent is a bit early and does the down_write() before one of the
> children has a chance to do the down_read()?  Aren't we toast?
> 
> Do we need any direct protection against that or does it just work itself out
> in a way I just don't see right now?

That's not the way it should be done.  Linus had children taking their
parents' locks during suspend, which is simple but leads to
difficulties.

Instead, the PM core should do a down_write() on each device before
starting the device's async suspend routine, and an up_write() when the
routine finishes.  Parents should, at the start of their async routine,
do down_read() on each of their children plus whatever other devices
they need to wait for.  The core can do the waiting for children part 
and the driver's suspend routine can handle any other waiting.

This is a little more awkward because it requires the parent to iterate 
through its children.  But it does solve the off-tree dependency 
problem for suspends.

Alan Stern

