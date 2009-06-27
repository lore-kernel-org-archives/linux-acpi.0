From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of
 I/O devices (rev. 6)
Date: Fri, 26 Jun 2009 21:25:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906262106490.2995-100000@netrider.rowland.org>
References: <200906270032.45290.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47122 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754580AbZF0BZq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 21:25:46 -0400
In-Reply-To: <200906270032.45290.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

On Sat, 27 Jun 2009, Rafael J. Wysocki wrote:

> > Speaking of races, have you noticed that the way power.work_done gets 
> > used is racy?
> 
> Not really. :-)
> 
> > You can't wait for the completion before releasing the 
> > lock, but then anything could happen.
> > 
> > A safer approach would be to use a wait_queue.
> 
> I'm not sure what you mean exactly.  What's the race?

Somebody calls pm_runtime_suspend when a suspend is already in 
progress.  The routine sees that the status is RPM_SUSPENDING, so it 
prepares to wait until the suspend is finished.  It drops the lock and 
calls wait_for_completion.

But in between those last two steps, the suspend could finish and 
a resume could start up.  Then the wait_for_completion wouldn't return 
until the device was fully resumed!

Now I admit this isn't as bad as it sounds.  The same sort of thing
could happen even if there weren't two suspends going on at the same
time; a resume could occur between when the routine drops the lock and
when it returns.  So okay, forget I mentioned it.

Alan Stern

