From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 17:21:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801061712480.19222-100000@netrider.rowland.org>
References: <200801062057.01677.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2384 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755528AbYAFWVv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 17:21:51 -0500
In-Reply-To: <200801062057.01677.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:

> > Still, shouldn't we fail the removal of the device apart from giving the
> > warning?
> 
> Actually, having thought about it a bit more, I don't see the point in
> preventing the removal of the device from the list in device_pm_remove() if
> we allow all of the operations in device_del() preceding it to be performed.

That's not the issue.  We _don't_ allow all of the operations in 
device_del() preceding the call to device_pm_remove().  In particular, 
the call to the device's driver's remove method will deadlock because 
device_release_driver() always has to acquire dev->sem.

> Shouldn't we just take pm_sleep_rwsem in device_del() upfront and block on that
> if locked?

No -- the whole idea here is to print an error message in the system
log if a driver's resume method tries to call device_del().  Deadlock 
is unavoidable in this case, but at least we'll know which driver is 
guilty.

Alan Stern

