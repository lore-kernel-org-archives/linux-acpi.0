From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Fri, 18 Dec 2009 12:26:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912181205290.2987-100000@iolanthe.rowland.org>
References: <200912180251.22655.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39549 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754426AbZLRR0q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 12:26:46 -0500
In-Reply-To: <200912180251.22655.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Fri, 18 Dec 2009, Rafael J. Wysocki wrote:

> I didn't manage to do that, but I was able to mark sd and i8042 as async and
> see the impact of this.

Apparently this didn't do what you wanted.  In the nx6325
sd+i8042+async+extra log, the 0:0:0:0 device (which is a SCSI disk) was
suspended by the main thread instead of an async thread.

There's an important point I neglected to mention before.  Your logs 
don't show anything for devices with no suspend callbacks at all.  
Nevertheless, these devices sit on the device list and prevent other
devices from suspending or resuming as soon as they could.

For example, the fingerprint sensor (3-1) took the most time to resume.  
But other devices were delayed until after it finished because it had
children with no callbacks, and they delayed the devices following
them in the list.

What would happen if you completed these devices immediately, as part 
of the first pass?

Alan Stern

