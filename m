From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Introduce core framework for run-time PM of I/O
 devices (rev. 3)
Date: Tue, 23 Jun 2009 13:10:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906231303390.3209-100000@iolanthe.rowland.org>
References: <200906230121.18932.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35608 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751647AbZFWRKS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 13:10:18 -0400
In-Reply-To: <200906230121.18932.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Oliver Neukum <oliver@neukum.org>, Magnus Damm <magnus.damm@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>

On Tue, 23 Jun 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> Below is a new revision of the patch introducing the run-time PM framework.
> 
> The most visible changes from the last version:
> 
> * I realized that if child_count is atomic, we can drop the parent locking from
>   all of the functions, so I did that.
> 
> * Introduced pm_runtime_put() that decrements the resume counter and queues
>   up an idle notification if the counter went down to 0 (and wasn't 0 previously).
>   Using asynchronous notification makes it possible to call pm_runtime_put()
>   from interrupt context, if necessary.
> 
> * Changed the meaning of the RPM_WAKE bit slightly (it is now also used for
>   disabling run-time PM for a device along with the resume counter).
> 
> Please let me know if I've overlooked anything. :-)

This first thing to strike me was that you moved the idle notifications 
into the workqueue.

Is that really needed?  Would we be better off just make the idle
callbacks directly from pm_runtime_put?  They would run in whatever
context the driver happened to be in at the time.

It's not clear exactly how much work the idle callbacks will need to 
do, but it seems likely that they won't have to do too much more than 
call pm_request_suspend.  And of course, that can be done in_interrupt.

Alan Stern

