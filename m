From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch update] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 5)
Date: Thu, 25 Jun 2009 12:49:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906251144280.4836-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0906241724020.22054-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33547 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758556AbZFYQtn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2009 12:49:43 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906241724020.22054-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

On Wed, 24 Jun 2009, Alan Stern wrote:
> More comments to follow when I get time to review more of the code...

Here we go.  This isn't so detailed, because I wasn't able to do a 
detailed review.  Frankly, the code is kind of a mess.

The whole business about the runtime_notify and RPM_NOTIFY flags is 
impenetrable.  My suggestion: Rename runtime_notify to notify_pending 
and eliminate RPM_NOTIFY.  Then make sure that notify_pending is set 
whenever a notify work item is queued.

The pm_notify_or_cancel_work routine should just be pm_notify_work.  
It's silly to submit a workqueue item just to cancel a delayed
workqueue item!  Do all the cancellations in the __pm_runtime_resume
and __pm_runtime_suspend routines, where you're already in process
context.  If this means a work item occasionally runs at the wrong time
then let it -- it will quickly find out that it has nothing to do.  
And while you're at it, get rid of the runtime_break flag.

The logic in __pm_runtime_resume and __pm_runtime_suspend is too
complicated to check.  This is probably because of the interactions
with RPM_NOTIFY and runtime_break.  Once they are gone, the logic
should be much more straightforward: test the flags, then do whatever 
is needed based on the status.

I think once these cleanups are made, the code will be a lot more 
transparent.

In __pm_runtime_resume, don't assume that incrementing the parent's
child_count will prevent the parent from suspending; also increment the
resume_count.  And don't forget to decrement the parent's child_count
again if the resume fails.

In __pm_runtime_suspend, you should decrement the parent's child_count
before releasing the child's lock.  The pm_runtime_idle call should 
stay where it is, of course.

One more thing: Don't use flush_work or its relatives -- it tends to
cause deadlocks.  Use cancel_work_sync instead.

Alan Stern

