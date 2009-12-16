From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 18:04:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912161753540.2643-100000@iolanthe.rowland.org>
References: <200912162257.00771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53418 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935314AbZLPXEL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 18:04:11 -0500
In-Reply-To: <200912162257.00771.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:

> I've just put the first set of data, for the HP nx6325 at:
> http://www.sisk.pl/kernel/data/nx6325/
>  
> The *-dmesg.log files contain full dmesg outputs starting from a cold boot and
> including one suspend-resume cycle in each case, with debug_initcall enabled.
> 
> The *-suspend.log files are excerpts from the *-dmesg.log files containing
> the suspend messages only, and analogously for *-resume.log.

I've just started looking at the sync-suspend.log file.  What are all 
the '+' characters and " @ 3368" strings after the device names?

You didn't print out the parent name for each device, so the tree 
structure has been lost.

Why do those "sd 0:0:0:0 [sda]" messages appear in between two 
callbacks?  The cache-synchronization and the spin-down commands are
not executed asynchronously.

Alan Stern

