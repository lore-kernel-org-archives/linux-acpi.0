From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 3] PM: Introduce core framework for run-time PM
 of I/O devices
Date: Mon, 22 Jun 2009 12:28:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906221222490.15425-100000@iolanthe.rowland.org>
References: <200906221749.50784.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37064 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751607AbZFVQ2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 12:28:13 -0400
In-Reply-To: <200906221749.50784.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Mon, 22 Jun 2009, Rafael J. Wysocki wrote:

> > Again, this boils down to how drivers decide to use the async 
> > interface.  I can see justifications for both pm_request_resume_get 
> > (which would always increment the counter) and pm_request_resume (which 
> > would increment the counter only if a work item had to be queued).
> 
> OK, so this means we should provide both at the core level and let the drivers
> decide which one to use.
> 
> I think in both cases the caller would be responsible for decrementing the
> counter?

Sure.  They could call pm_runtime_put just once at the end of their
runtime_resume method (assuming they used pm_request_resume), or they
could call it at every place where some deferred work was finished 
(assuming they used pm_request_resume_get).

> > Okay, we don't need it then.  I forgot to mention in the previous
> > message that there also has to be a pm_runtime_del() routine, which
> > should cancel pending workqueue items and set the counter to some high
> > value so that no new items are added.
> 
> Should that be called by device_pm_remove()?  I think so.

Yes.  I suppose it could be named pm_runtime_remove.  Either would be 
okay.

Alan Stern

