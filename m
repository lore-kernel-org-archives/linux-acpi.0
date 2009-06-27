From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of
 I/O devices (rev. 6)
Date: Sat, 27 Jun 2009 10:51:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906271042450.12287-100000@netrider.rowland.org>
References: <200906270032.45290.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51844 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751810AbZF0Ovb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Jun 2009 10:51:31 -0400
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

Come to think of it, there really is a problem here.  Because the
wait_for_completion call occurs outside the spinlock, it can race with
the init_completion call.  It's not good for both of them to run at the
same time; the completion's internal spinlock and list pointers could 
get corrupted.

Therefore I stand by my original assertion: The struct completion 
should be replaced with a wait_queue.  Set the runtime_error field to 
-EINPROGRESS initially, and make other threads wait until the value 
changes.

Alan Stern

